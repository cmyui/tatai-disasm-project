"""Transfer decimal batching into maps that contain deferred slider bodies."""
def fallback(source,module,kind):
    if kind=='object-deferral-noqueue' and module=='deferrals':
        a=source.index('defer_object_header:');b=source.index('\t.seh_endproc',a)
        source=source[:a]+'''defer_object_header:
 .seh_endprologue
 mov DWORD PTR 12[rdx], 0
 ret
'''+source[b:]
    if module!='beatmap':return source
    if kind=='fallback-integer':
        a=source.index('.Lparse_beatmap_body_block_71:');b=source.index('.Lparse_beatmap_body_block_74:',a)
        t=source[a:b]
        old='\tvmovq\trdx, xmm0\n\tmov\tebp, edx\n\tshr\trdx, 32\n\timul\trbp, rbp, 100000000\n\tadd\trdx, rbp'
        assert old in t;t=t.replace(old,'''\tvpmuludq xmm1, xmm0, XMMWORD PTR sweep_fallback_join[rip]
\tvpsrlq xmm0, xmm0, 32
\tvpaddq xmm0, xmm0, xmm1
\tvmovq rdx, xmm0''')
        return source[:a]+t+source[b:]+'\n.section .rdata$sweep_fallback_join,"dr"\n.p2align 4\nsweep_fallback_join:\n.long 100000000,0,100000000,0\n'
    if kind=='fallback-pairs':
        start=source.index('\t# Two decimal conversions share')
        end=source.index('\tmovabs\trax, -2684354577',start)
        body=source[start:end]
        body=body.replace('.Lparse_beatmap_body_block_31','.Lsweep_fallback_pair')
        marker='.Lsweep_fallback_pair:\n'
        body=body.replace(marker,marker+'''\tmov rax, QWORD PTR [r9]
\ttest rax, rax
\tje .Lsweep_fallback_skip
\tlea rcx, 16[r9]
\tcmp rcx, r11
\tjae .Lsweep_fallback_single
\tcmp QWORD PTR 16[r9], 0
\tje .Lsweep_fallback_single
''')
        body=body.replace('\tcmp\tr9, rsi\n','\tcmp r9, r11\n')
        body+='''\tjmp .Lsweep_fallback_end
.Lsweep_fallback_single:
\tmov rcx, rax
\tcall parse_decimal
\tmov rdx, QWORD PTR 8[r9]
\tvmovsd QWORD PTR 16[rdx], xmm0
\tvbroadcasti128 ymm2, XMMWORD PTR constant_17[rip]
.Lsweep_fallback_skip:
\tadd r9, 16
\tcmp r9, r11
\tjb .Lsweep_fallback_pair
.Lsweep_fallback_end:
\tmov ebp, DWORD PTR 68[rdi]
\tjmp .Lparse_beatmap_body_block_32
'''
        a=source.index('.Lparse_beatmap_body_block_71:');b=source.index('.Lparse_beatmap_body_block_74:',a)
        source=source[:a]+'.Lparse_beatmap_body_block_71:\n'+body+source[b:]
    return source
