"""Share one unwindable frame across header and timing phases."""
import re

def fused_headers(source):
    clones=[]
    restore=''.join(f'\tvmovaps xmm{i}, XMMWORD PTR {16+(i-6)*16}[rsp]\n' for i in range(6,11))
    restore+='\tadd rsp, 104\n'+''.join(f'\tpop {r}\n' for r in ['rbx','rsi','rdi','rbp','r12','r13','r14','r15'])+'\tret\n'
    for version,spill in [('v14',144),('legacy',160)]:
        a=source.index(f'parse_timing_points_{version}:');b=source.index('\t.seh_endproc',a)
        t=source[a:b];t=t[t.index('\t.seh_endprologue')+len('\t.seh_endprologue'):]
        t=t.replace(f'{spill}[rsp]','176[rsp]')
        a=t.index('\tvmovaps\txmm6,');b=t.index('\tret',a)+len('\tret\n')
        t=t[:a]+restore+t[b:]
        t=t.replace(f'.Lparse_timing_points_{version}',f'.Lfused_timing_{version}')
        clones.append(f'.Lfused_timing_{version}_entry:\n'+t)
    a=source.index('parse_beatmap_header:');b=source.index('\t.seh_endproc',a)
    h=source[a:b]
    for version in ['v14','legacy']:
        # Locate the exact restore-to-tail-jump block in the original header.
        end=h.index(f'\tjmp\tparse_timing_points_{version}')+len(f'\tjmp\tparse_timing_points_{version}')
        begin=h.rindex('\tvmovaps\txmm6,',0,end)
        h=h[:begin]+f'\tjmp .Lfused_timing_{version}_entry'+h[end:]
    h=h.replace('\tpush\tr14','\tpush r15\n\t.seh_pushreg r15\n\tpush\tr14',1)
    h=h.replace('rsp, 80','rsp, 104').replace('.seh_stackalloc\t80','.seh_stackalloc\t104')
    h=re.sub(r'(\d*)\[rsp\]',lambda m:f'{int(m[1] or 0)+16}[rsp]',h)
    h=re.sub(r'(\.seh_savexmm\s+xmm\d+, )(\d+)',lambda m:m[1]+str(int(m[2])+16),h)
    h=h.replace('\tpop\tr14\n\tret','\tpop\tr14\n\tpop r15\n\tret')
    return source[:a]+h+'\n'+'\n'.join(clones)+source[b:]
