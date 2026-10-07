"""Consume newline offsets in ordinary object runs; bound pointer fallback."""
import re

def offsets(source,module):
    if module=='line_scan':
        s=source.replace('refill_object_lines','refill_object_offsets')
        s=s.replace('\t.seh_endprologue','\t.seh_endprologue\n\tvmovq xmm11, rdx')
        s=s.replace('536870912','536875008')
        # Form positions relative to this input batch rather than full pointers.
        s=s.replace('\tor\trax, r10\n','\tor\trax, r10\n\tvmovq r10, xmm11\n\tneg r10\n\tadd r10, rdx\n')
        s=s.replace('1[rdx+r11]','1[r10+r11]')
        s=s.replace('QWORD PTR [rsi], r11','DWORD PTR [rsi], r11d').replace('QWORD PTR 8[rsi], r11','DWORD PTR 4[rsi], r11d').replace('QWORD PTR 16[rsi], r11','DWORD PTR 8[rsi], r11d')
        s=s.replace('[rsi+r8*8]','[rsi+r8*4]').replace('add\trsi, 24','add\trsi, 12').replace('add\trsi, 8','add\trsi, 4').replace('shr\trsi, 3','shr\trsi, 2')
        return source+'\n'+s
    if module=='object_loop':
        extra=''
        for width,loop in [(5,1),(6,6)]:
            name=f'parse_objects_{width}digit_context'
            a=source.index('# '+name+'\n');b=source.index('\t.seh_endproc',a)+len('\t.seh_endproc')
            s=source[a:b].replace(name,name+'_offsets')
            s=re.sub(r'\tmov\trbx, (?:QWORD PTR )?\[rbp\]', '\tmov ebx, DWORD PTR [rbp]',s)
            s=s.replace('\tadd\trbp, 16','\tadd\trbp, 8').replace('\tadd\trbp, 8\n\tadd\trdx','\tadd\trbp, 4\n\tadd\trdx')
            # Handle single increments not followed by ADD RDX, independently.
            s=s.replace('\tadd\trbp, 8\n\tcall','\tadd\trbp, 4\n\tcall')
            s=s.replace('\tmov\tr11, QWORD PTR 8[rbp]','\tmov r11d, DWORD PTR 4[rbp]')
            marker=f'.L{name}_offsets_block_{loop}:\n'
            s=s.replace(marker,marker+'\tvmovq rcx, xmm11\n\tadd rbx, rcx\n')
            marker=f'\tje\t.L{name}_offsets_single\n'
            s=s.replace(marker,marker+'\tvmovq rcx, xmm11\n\tadd r11, rcx\n',1)
            extra+='\n'+s+'\n'
        return source+extra
    if module=='beatmap':
        source=source.replace('\tcall\tparse_beatmap_header\n','\tcall\tparse_beatmap_header\n\tvpxor xmm11, xmm11, xmm11\n')
        for width,nextwidth in [(5,6),(6,7)]:
            a=source.index(f'.Lparse_beatmap_body_block_{21 if width==5 else 22}:');b=source.index(f'.Lparse_beatmap_body_block_{22 if width==5 else 23}:',a)
            s=source[a:b].replace('call refill_object_lines','call refill_object_offsets').replace('lea rbp, 536870912[rdi]','lea rbp, 536875008[rdi]')
            call=f'\tcall\tparse_objects_{width}digit_context\n'
            s=s.replace(call,f'''\tvmovq rcx, xmm11
\ttest rcx, rcx
\tje .Loffset_normal_{width}
\tcall parse_objects_{width}digit_context_offsets
\tjmp .Loffset_done_{width}
.Loffset_normal_{width}:
{call}.Loffset_done_{width}:
''')
            source=source[:a]+s+source[b:]
        marker='.Lhave_7digit_lines:\n'
        source=source.replace(marker,marker+'''\tvmovq rcx, xmm11
\ttest rcx, rcx
\tje .Loffset_expanded
\tlea rdx, 536870912[rdi]
\tmov r9, rdx
\tvmovq r8, xmm10
.Loffset_expand:
\tmov eax, DWORD PTR [rbp]
\tadd rax, rcx
\tmov QWORD PTR [rdx], rax
\tadd rbp, 4
\tadd rdx, 8
\tcmp rbp, r8
\tjb .Loffset_expand
\tmov QWORD PTR [rdx], 0
\tmov rbp, r9
\tvmovq xmm10, rdx
\tvpxor xmm11, xmm11, xmm11
.Loffset_expanded:
''')
        source=source.replace('\tcall refill_object_lines\n','\tcall refill_object_lines\n\tvpxor xmm11, xmm11, xmm11\n')
        return source
    return source
