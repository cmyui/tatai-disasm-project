#!/usr/bin/env python3
"""Build isolated sweep experiments without editing production assembly."""
from pathlib import Path
import argparse
import subprocess
import hashlib
import json
from fallback_variants import fallback
from direct_scan_variants import direct_scan, direct_scan_registers
from refill_variants import resume
from header_variants import fused_headers
from table_variants import tables, negative_table
from offset_variants import offsets
from architecture_variants import batch_sliders, slider_streams, scratch_prefix, scratch_limit, batch_four, slider_streams_simd
from local_variants import transform
from context_variants import context4, context7, callers
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

def timing_register_join(source):
    for version,frame,spill,slot in [('v14',72,144,64),('legacy',88,160,80)]:
        a=source.index(f'parse_timing_points_{version}:');b=source.index('\t.seh_endproc',a)
        t=source[a:b]
        t=t.replace(f'rsp, {frame}',f'rsp, {frame+16}').replace(f'.seh_stackalloc\t{frame}',f'.seh_stackalloc\t{frame+16}').replace(f'{spill}[rsp]',f'{spill+16}[rsp]')
        t=t.replace('\t.seh_endprologue',f'\tvmovaps XMMWORD PTR {slot}[rsp], xmm10\n\t.seh_savexmm xmm10, {slot}\n\t.seh_endprologue')
        t=t.replace(f'\tjmp\t.Lparse_timing_points_{version}_block_3',f'\tmov eax, 100000000\n\tvmovd xmm10, eax\n\tjmp\t.Lparse_timing_points_{version}_block_3',1)
        t=t.replace('XMMWORD PTR sweep_decimal_integer[rip]','xmm10')
        t=t.replace(f'\tadd\trsp, {frame+16}',f'\tvmovaps xmm10, XMMWORD PTR {slot}[rsp]\n\tadd\trsp, {frame+16}')
        source=source[:a]+t+source[b:]
    return source

def main():
    p=argparse.ArgumentParser();p.add_argument('variant',choices=['control','timing-dot','timing-upper','timing-memory','timing-dot-align','timing-simd','timing-scan','context4','context7','refill-constant','negative-input','negative-inline','header-simd','decimal-simd','decimal-address','prefetch-none','prefetch-256','prefetch-1024','prefetch-combined','branch-no-padding','batch-sliders','slider-streams','newline-offsets','scratch-prefix','scratch-limit','batch-four','timing-simd-reg','table-split','table-compact','align-refill','align-slider','align-header','align-object4','align-object7','align-timing','slider-prefetch4','slider-prefetch8','slider-prefetch-clamp','object4-constant','point-store8','defer-conditional','defer-pair-control','header-frame','refill-preserve','refill-resume','slider-streams-simd','negative-table','direct-scan','direct-scan-registers','fallback-integer','fallback-pairs','object-deferral-noqueue']);p.add_argument('--reference',default='1dacd0f');p.add_argument('--source-ref',default='1dacd0f');a=p.parse_args()
    out=ROOT/'build/variants'/a.variant;out.mkdir(parents=True,exist_ok=True)
    subprocess.run(['make','build/verify_harness.o','build/audit_call.o'],cwd=ROOT,check=True)
    subprocess.run(['python3','tools/build_reference.py',a.reference],cwd=ROOT,check=True)
    objects=[];sources={}
    for path in sorted((ROOT/'asm').glob('*.s')):
        if path.stem in ['benchmark','file_io','runtime','runtime_data']:continue
        source=subprocess.check_output(['git','show',f'{a.source_ref}:asm/{path.name}'],cwd=ROOT,text=True)
        if path.stem=='headers' and a.variant.startswith('timing-'):
            if a.variant in ['timing-simd','timing-simd-reg','table-split','table-compact']:
                source=timing_simd(source)
                if a.variant=='timing-simd-reg':source=timing_register_join(source)
            elif a.variant=='timing-scan':source=timing_scan(source)
            else:
                source=timing(source,a.variant.split('-')[1])
                if a.variant=='timing-dot-align':
                    for v in ['v14','legacy']:source=source.replace(f'.Lparse_timing_points_{v}_block_3:',f'\t.p2align 5\n.Lparse_timing_points_{v}_block_3:')
        if a.variant in ['context4','context7']:
            width=int(a.variant[-1])
            if path.stem=='object_loop':source=(context4 if width==4 else context7)(source)
            if path.stem=='beatmap':source=callers(source,width)
        if a.variant=='batch-sliders' and path.stem=='beatmap':source=batch_sliders(source)
        if a.variant=='slider-streams':source=slider_streams(source,path.stem)
        if a.variant=='newline-offsets':source=offsets(source,path.stem)
        if a.variant=='scratch-limit' and path.stem=='beatmap':source=scratch_limit(source)
        if a.variant=='scratch-prefix' and path.stem=='beatmap':source=scratch_prefix(source)
        if a.variant=='batch-four' and path.stem=='beatmap':source=batch_four(source)
        if a.variant in ['table-split','table-compact']:source=tables(source,path.stem,a.variant)
        if a.variant=='header-frame' and path.stem=='headers':source=fused_headers(source)
        if a.variant in ['refill-preserve','refill-resume']:source=resume(source,path.stem,a.variant)
        if a.variant=='slider-streams-simd':source=slider_streams_simd(source,path.stem)
        if a.variant=='negative-table':source=negative_table(source,path.stem)
        if a.variant in ['direct-scan','direct-scan-registers']:source=(direct_scan if a.variant=='direct-scan' else direct_scan_registers)(source,path.stem,subprocess.check_output(['git','show',f'{a.source_ref}:asm/object_loop.s'],cwd=ROOT,text=True))
        if a.variant in ['fallback-integer','fallback-pairs','object-deferral-noqueue']:source=fallback(source,path.stem,a.variant)
        if a.variant=='prefetch-combined':
            source=transform(source,path.stem,'prefetch-1024')
            source=transform(source,path.stem,'slider-prefetch4')
        source=transform(source,path.stem,a.variant)
        target=out/path.name;target.write_text(source);sources[path.name]=hashlib.sha256(source.encode()).hexdigest()
        obj=target.with_suffix('.o');subprocess.run(['x86_64-w64-mingw32-g++','-Wa,-mbranches-within-32B-boundaries','-c',str(target),'-o',str(obj)],check=True);objects.append(str(obj))
    subprocess.run(['x86_64-w64-mingw32-g++',str(ROOT/'build/verify_harness.o'),str(ROOT/'build/audit_call.o'),*objects,*map(str,sorted((ROOT/'build/reference').glob('*.o'))),'-static','-o',str(out/'verify.exe'),'-lonecore'],check=True)
    provenance=dict(assembly=sources,source_revision=subprocess.check_output(['git','rev-parse',a.source_ref],cwd=ROOT,text=True).strip(),reference_revision=(ROOT/'build/reference/revision.txt').read_text().strip(),variant=a.variant)
    provenance['recipes']={p.name:hashlib.sha256(p.read_bytes()).hexdigest() for p in (ROOT/'tools').glob('*variants.py')}
    provenance['harness_sha256']=hashlib.sha256((ROOT/'build/verify_harness.o').read_bytes()).hexdigest()
    (out/'sources.json').write_text(json.dumps(provenance,indent=2)+'\n')
if __name__=='__main__':main()
