"""Isolated transfers of setup, dependency, SIMD and memory lessons."""
import re

def transform(source,module,kind):
    if kind=='refill-constant':
        if module=='beatmap':
            source=source.replace('\tcall\tparse_beatmap_header\n','\tcall\tparse_beatmap_header\n\tmov edx, 10\n\tvmovd xmm7, edx\n\tvpbroadcastb xmm7, xmm7\n')
        if module=='line_scan':
            source=source.replace('\tmov\teax, 10\n\tvmovd\txmm0, eax\n\tvpbroadcastb\tymm0, xmm0','\tvpbroadcastb ymm0, xmm7')
    if kind=='negative-input' and module=='sliders':
        a=source.index('parse_slider_negative:');b=source.index('\t.seh_endproc',a)
        t=source[a:b]
        t=t.replace('\tmov\tr8d, -791621424\n','').replace('\tvmovd\txmm0, r8d\n','').replace('\tvpbroadcastd\txmm0, xmm0\n','').replace('\tvpaddb\txmm0, xmm0, XMMWORD PTR [r11]\n','')
        source=source[:a]+t+source[b:]
    if kind=='negative-inline' and module=='beatmap':
        a=source.index('.Lparse_beatmap_body_block_53:');b=source.index('.Lparse_beatmap_body_block_54:',a)
        source=source[:a]+'''.Lparse_beatmap_body_block_53:
\tlea rcx, slider_negative_table[rip]
\tor r8d, r11d
\tmov eax, 445
\tpext eax, r8d, eax
\tcmp DWORD PTR 4096[rcx+rax*4], r8d
\tjne .Lparse_beatmap_body_block_38
\tand r11d, r9d
\tshl r11d, 8
\tshl eax, 5
\tor r11d, DWORD PTR 16[rcx+rax]
\tvpshufb xmm0, xmm0, XMMWORD PTR [rcx+rax]
\tvpmaddubsw xmm0, xmm0, XMMWORD PTR constant_12[rip]
\tvpmaddwd xmm0, xmm0, XMMWORD PTR constant_13[rip]
\tvmovq xmm1, QWORD PTR 24[rcx+rax]
\tvpsignd xmm0, xmm0, xmm1
\tvmovq QWORD PTR [rdx], xmm0
\tmov eax, r11d
\tjmp .Lparse_beatmap_body_block_28
'''+source[b:]
    if kind in ['header-simd','decimal-simd']:
        applicable=module=='headers' if kind=='header-simd' else module in ['decimals','sliders']
        if applicable:
            # Only replace the exact integer-join idiom; signed conversion and
            # the final scalar multiplication remain bit-for-bit unchanged.
            pattern=r'\tvmovq\trax, xmm0\n(?P<zero>\tvxorps\txmm0, xmm0, xmm0\n)?\tmov\t(?P<lo>e(?:bp|ax)|r(?:8|9|14)d), eax\n\tshr\trax, 32\n\timul\t(?P<reg>rbp|rax|r8|r9|r14), (?P=reg), 100000000\n\tadd\trax, (?P=reg)\n'
            # Use a dead input-classification register; XMM1 is the zero merge
            # operand in header parsing, so XMM10 is used there instead.
            temp=10 if module=='headers' else 1
            def repl(m):
                return f'\tvpmuludq xmm{temp}, xmm0, XMMWORD PTR sweep_join_{module}[rip]\n\tvpsrlq xmm0, xmm0, 32\n\tvpaddq xmm0, xmm0, xmm{temp}\n\tvmovq rax, xmm0\n'+(m['zero'] or '')
            source,n=re.subn(pattern,repl,source)
            if n:source+=f'\n.section .rdata$sweep_join_{module},"dr"\n.p2align 4\nsweep_join_{module}:\n.long 100000000,0,100000000,0\n'
    if kind=='decimal-address':
        # Every site here has just written the same register with a 32-bit ADD
        # (or PEXT). Do not remove packed-return truncations in beatmap.s.
        source=re.sub(r'(\tadd\t(?P<r>eax|edx|r10d), [^\n]+\n)\tmov\t(?P=r), (?P=r)\n',r'\1',source)
        source=source.replace('\tpext\tedx, r8d, edx\n\tmov\tedx, edx\n','\tpext\tedx, r8d, edx\n')
    if kind in ['prefetch-none','prefetch-256','prefetch-1024'] and module in ['beatmap','line_scan']:
        if kind=='prefetch-none':source=re.sub(r'^\tprefetcht0[^\n]*\n','',source,flags=re.M)
        else:source=source.replace('512[rdx]',kind.split('-')[1]+'[rdx]')
    if kind=='branch-no-padding':source=source.replace('\t.p2align 4,,10\n\t.p2align 3\n','')
    if kind.startswith('align-'):
        labels={'align-refill':('line_scan','.Lrefill_object_lines_scan:'),
          'align-slider':('beatmap','.Lparse_beatmap_body_block_27:'),
          'align-header':('headers','.Lparse_beatmap_header_block_17:'),
          'align-object4':('object_loop','.Lparse_objects_4digit_block_1:'),
          'align-object7':('object_loop','.Lparse_objects_7digit_block_4:')}
        if kind=='align-timing' and module=='headers':
            for v in ['v14','legacy']:source=source.replace(f'.Lparse_timing_points_{v}_block_3:',f'\t.p2align 5\n.Lparse_timing_points_{v}_block_3:')
        elif kind in labels and module==labels[kind][0]:source=source.replace(labels[kind][1],'\t.p2align 5\n'+labels[kind][1])
    if kind in ['slider-prefetch4','slider-prefetch8','slider-prefetch-clamp'] and module=='beatmap':
        distance=128 if kind=='slider-prefetch8' else 64
        prefetch=f'\tlea rax, {distance}[rsi]\n\tcmp rax, rbx\n'
        if kind=='slider-prefetch-clamp':prefetch+='\tcmovae rax, rsi\n\tmov rax, QWORD PTR [rax]\n\tprefetcht0 [rax]\n'
        else:prefetch+='\tjae .Lsweep_prefetch_end\n\tmov rax, QWORD PTR [rax]\n\tprefetcht0 [rax]\n.Lsweep_prefetch_end:\n'
        source=source.replace('.Lparse_beatmap_body_block_26:\n','.Lparse_beatmap_body_block_26:\n'+prefetch)
    if kind=='object4-constant' and module=='object_loop':
        a=source.index('parse_objects_4digit:');b=source.index('\t.seh_endproc',a)
        t=source[a:b]
        for line in ['\tmov\tedx, -791621424\n','\tvmovd\txmm1, edx\n','\tvpbroadcastd\txmm1, xmm1\n']:t=t.replace(line,'')
        t=t.replace('\tvpaddb\txmm0, xmm0, xmm1','\tvpaddb\txmm0, xmm0, xmm8')
        source=source[:a]+t+source[b:]
    if kind=='point-store8' and module=='beatmap':
        source=source.replace('\tvmovdqu\tXMMWORD PTR [rdx], xmm0', '''	cmp cl, 1
	jne .Lsweep_full_point_store
	vmovq QWORD PTR [rdx], xmm0
	jmp .Lsweep_point_store_done
.Lsweep_full_point_store:
	vmovdqu XMMWORD PTR [rdx], xmm0
.Lsweep_point_store_done:''',1)
    if kind in ['defer-conditional','defer-pair-control'] and module=='object_loop':
        for width in [5,6]:
            a=source.index(f'parse_objects_{width}digit_context:');b=source.index('\t.seh_endproc',a)
            t=source[a:b]
            if kind=='defer-conditional':
                for index,r in enumerate(['rdx','r8']):
                    old=f'\tand\teax, 16\n\tmov\t[r12], {r}\n\tmov\t8[r12], r14\n\tadd\tr12, rax'
                    new=f'\tand\teax, 16\n\tje .Ldefer_skip_{width}_{index}\n\tmov [r12], {r}\n\tmov 8[r12], r14\n\tadd r12, 16\n.Ldefer_skip_{width}_{index}:'
                    assert old in t;t=t.replace(old,new)
            else:
                marker='\t# For a single decimal type digit, ASCII bit 1 is the parsed slider bit.'
                t=t.replace(marker,f'\tmov al, BYTE PTR -2[rdx]\n\tor al, BYTE PTR -2[r8]\n\ttest al, 2\n\tjne .Ldefer_pair_{width}\n\tadd r14, 64\n\tjmp .Ldefer_pair_done_{width}\n.Ldefer_pair_{width}:\n'+marker)
                t=t.replace('\tadd\tr15, 32',f'.Ldefer_pair_done_{width}:\n\tadd\tr15, 32',1)
            source=source[:a]+t+source[b:]
    return source
