#!/usr/bin/env python3
"""Build isolated sweep experiments without editing production assembly."""
from pathlib import Path
import argparse
import subprocess
import hashlib
import json
ROOT=Path(__file__).resolve().parent.parent

def timing(source,kind):
    for version,dot,digits,multiply in [('v14',8,7,5),('legacy',9,8,6)]:
        start=source.index(f'parse_timing_points_{version}:');end=source.index('\t.seh_endproc',start)
        s=source[start:end]
        for line in [f'\tmov\tebx, 774778414\n',f'\tvmovd\txmm{dot}, ebx\n',f'\tvpbroadcastd\txmm{dot}, xmm{dot}\n']:
            assert line in s;s=s.replace(line,'')
        setup=f'\tmov eax, 774778414\n\tvmovd xmm{dot}, eax\n\tvpbroadcastd xmm{dot}, xmm{dot}\n'
        if kind!='dot':
            for line in ['\tmov\teax, -791621424\n','\tvmovd\txmm0, eax\n','\tvpbroadcastd\txmm0, xmm0\n']:
                assert line in s;s=s.replace(line,'')
            if kind=='upper':
                setup+=f'\tmov eax, -791621424\n\tvmovd xmm0, eax\n\tvpbroadcastd xmm0, xmm0\n\tvinserti128 ymm{multiply}, ymm{multiply}, xmm0, 1\n'
                s=s.replace(f'\tvpaddb\txmm0, xmm{digits}, xmm0',f'\tvextracti128 xmm0, ymm{multiply}, 1\n\tvpaddb\txmm0, xmm{digits}, xmm0')
            else:
                s=s.replace(f'\tvpaddb\txmm0, xmm{digits}, xmm0',f'\tvpaddb xmm0, xmm{digits}, XMMWORD PTR sweep_digit_offset[rip]')
        anchor=f'\tjmp\t.Lparse_timing_points_{version}_block_3'
        s=s.replace(anchor,setup+anchor,1)
        source=source[:start]+s+source[end:]
    if kind=='memory':source+='\n.section .rdata$sweep_digit_offset,"dr"\n.p2align 4\nsweep_digit_offset:\n.fill 16,1,208\n'
    return source

def timing_scan(source):
    for version in ['v14','legacy']:
        start=source.index(f'parse_timing_points_{version}:');end=source.index('\t.seh_endproc',start)
        s=source[start:end]
        a=s.index('\tjmp\t.Lparse_timing_points_'+version+'_block_5')
        b=s.index('.Lparse_timing_points_'+version+'_block_6:',a)
        # Search only at/after the existing width cursor; do not change the
        # original parser's behavior on decreasing/malformed timestamps.
        s=s[:a]+f'''
	vmovq xmm0, rcx
	vpcmpeqb xmm0, xmm0, XMMWORD PTR constant_7[rip]
	vpmovmskb r10d, xmm0
	mov ebx, edx
	shr ebx, 3
	and r10d, 255
	or r10d, 256
	shrx r10d, r10d, ebx
	tzcnt r10d, r10d
	add r10d, ebx
	lea edx, [r10*8]
	inc r10d
'''+s[b:]
        source=source[:start]+s+source[end:]
    return source

def timing_simd(source):
    for version,temp in [('v14',7),('legacy',8)]:
        start=source.index(f'parse_timing_points_{version}:');end=source.index('\t.seh_endproc',start)
        s=source[start:end]
        old='\tvmovq\tr10, xmm0\n\tmov\tebx, r10d\n\tshr\tr10, 32\n\timul\trbx, rbx, 100000000\n\tadd\trbx, r10\n'
        assert old in s
        s=s.replace(old,f'\tvpmuludq xmm{temp}, xmm0, XMMWORD PTR sweep_decimal_integer[rip]\n\tvpsrlq xmm0, xmm0, 32\n\tvpaddq xmm0, xmm0, xmm{temp}\n\tvmovq rbx, xmm0\n')
        source=source[:start]+s+source[end:]
    return source+'\n.section .rdata$sweep_decimal_integer,"dr"\n.p2align 4\nsweep_decimal_integer:\n.long 100000000,0,100000000,0\n'

def main():
    p=argparse.ArgumentParser();p.add_argument('variant',choices=['control','timing-dot','timing-upper','timing-memory','timing-dot-align','timing-simd','timing-scan']);p.add_argument('--reference',default='1dacd0f');a=p.parse_args()
    out=ROOT/'build/variants'/a.variant;out.mkdir(parents=True,exist_ok=True)
    subprocess.run(['make','build/verify_harness.o','build/audit_call.o'],cwd=ROOT,check=True)
    subprocess.run(['python3','tools/build_reference.py',a.reference],cwd=ROOT,check=True)
    objects=[];sources={}
    for path in sorted((ROOT/'asm').glob('*.s')):
        if path.stem in ['benchmark','file_io','runtime','runtime_data']:continue
        source=path.read_text()
        if path.stem=='headers' and a.variant.startswith('timing-'):
            if a.variant=='timing-simd':source=timing_simd(source)
            elif a.variant=='timing-scan':source=timing_scan(source)
            else:
                source=timing(source,a.variant.split('-')[1])
                if a.variant=='timing-dot-align':
                    for v in ['v14','legacy']:source=source.replace(f'.Lparse_timing_points_{v}_block_3:',f'\t.p2align 5\n.Lparse_timing_points_{v}_block_3:')
        target=out/path.name;target.write_text(source);sources[path.name]=hashlib.sha256(source.encode()).hexdigest()
        obj=target.with_suffix('.o');subprocess.run(['x86_64-w64-mingw32-g++','-Wa,-mbranches-within-32B-boundaries','-c',str(target),'-o',str(obj)],check=True);objects.append(str(obj))
    subprocess.run(['x86_64-w64-mingw32-g++',str(ROOT/'build/verify_harness.o'),str(ROOT/'build/audit_call.o'),*objects,*map(str,sorted((ROOT/'build/reference').glob('*.o'))),'-static','-o',str(out/'verify.exe'),'-lonecore'],check=True)
    (out/'sources.json').write_text(json.dumps(sources,indent=2)+'\n')
if __name__=='__main__':main()
