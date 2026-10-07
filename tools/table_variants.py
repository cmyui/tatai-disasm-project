"""Compare split and compact direct lookup layouts with identical entries."""
import itertools

def entries():
    result={}
    for n in (2,4):
        for widths in itertools.product(range(1,4),repeat=n):
            cursor=mask=0;shuffle=[128]*16
            for group,width in enumerate(widths):
                start=group*4+4-width;shuffle[start:start+width]=range(cursor,cursor+width)
                cursor+=width;mask|=1<<cursor;cursor+=1
            result[mask]=(n//2 | (cursor<<24),shuffle)
    return result

def tables(source,module,kind):
    if module=='slider_tables':
        a=source.index('\t.section .rdata$slider_positive_table');b=source.index('\t.section\t.rdata$slider_single_table',a)
        s='\t.section .rdata$slider_positive_table,"dr"\n\t.linkonce same_size\n\t.align 4096\n.globl slider_positive_table\nslider_positive_table:\n'
        data=entries();cursor=0
        for mask,(metadata,shuffle) in sorted(data.items()):
            offset=mask*(4 if kind=='table-split' else 12)
            if offset>cursor:s+=f'\t.zero {offset-cursor}\n'
            s+=f'\t.long {mask}, {metadata}\n';cursor=offset+8
            if kind=='table-compact':s+='\t.byte '+','.join(map(str,shuffle))+'\n';cursor+=16
        size=0x40000 if kind=='table-split' else 0xc0000
        s+=f'\t.zero {size-cursor}\n'
        if kind=='table-split':
            cursor=0
            for mask,(_,shuffle) in sorted(data.items()):
                offset=mask*8
                if offset>cursor:s+=f'\t.zero {offset-cursor}\n'
                s+='\t.byte '+','.join(map(str,shuffle))+'\n';cursor=offset+16
            s+=f'\t.zero {0x80000-cursor}\n'
        return source[:a]+s+source[b:]
    if module=='beatmap':
        old='\tmov\teax, r8d\n\tshl\teax, 4\n\tadd\trax, r15\n\tmov\trcx, QWORD PTR [rax]'
        assert old in source
        if kind=='table-split':
            source=source.replace(old,'\tmov rcx, QWORD PTR [r15+r8*4]')
            source=source.replace('XMMWORD PTR 16[rax]','XMMWORD PTR 262144[r15+r8*8]',1)
        else:
            source=source.replace(old,'\tlea eax, [r8+r8*2]\n\tlea rax, [r15+rax*4]\n\tmov rcx, QWORD PTR [rax]')
            source=source.replace('XMMWORD PTR 16[rax]','XMMWORD PTR 8[rax]',1)
    return source

def negative_table(source,module):
    if module=='slider_tables':
        a=source.index('slider_negative_table:\n')+len('slider_negative_table:\n')
        b=source.index('\t.globl\tobject_7_coordinate_shuffles',a)
        raw=bytearray()
        for line in source[a:b].splitlines():
            fields=line.split();kind=fields[0]
            if kind=='.space':raw.extend(bytes(int(fields[1])))
            else:
                size={'.byte':1,'.long':4}[kind]
                raw.extend((int(fields[1])&((1<<(size*8))-1)).to_bytes(size,'little'))
        assert len(raw)==4608
        entries={int.from_bytes(raw[4096+i*4:4100+i*4],'little'):raw[i*32:(i+1)*32] for i in range(128)}
        entries.pop(0xffffffff,None)
        assert max(entries)<1024
        # One cache-line entry owns validation and the original 32-byte payload.
        s='';cursor=0
        for mask,data in sorted(entries.items()):
            offset=mask*64
            if offset>cursor:s+=f'\t.zero {offset-cursor}\n'
            s+=f'\t.long {mask}\n\t.zero 12\n\t.byte '+','.join(map(str,data))+'\n\t.zero 16\n'
            cursor=offset+64
        s+=f'\t.zero {65536-cursor}\n'
        return source[:a]+s+source[b:]
    if module=='sliders':
        a=source.index('\tmov\tedx, 445');b=source.index('\tmov\tr8d, -791621424',a)
        source=source[:a]+'''\tcmp r8d, 1023
\tja .Lparse_slider_negative_block_1
\tmov edx, r8d
\tshl edx, 6
\tadd r10, rdx
\tcmp DWORD PTR [r10], r8d
\tjne .Lparse_slider_negative_block_1
\tadd r10, 16
\txor edx, edx
'''+source[b:]
    return source
