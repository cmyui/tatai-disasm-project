"""Isolated whole-parser data-flow experiments, never production regeneration."""
import re

def batch_sliders(s):
    # Keep all existing record layouts. Flush completed slider work before each
    # line refill and retain fallback records until the original final pass.
    s=s.replace('sub\trsp, 216','sub\trsp, 472').replace('.seh_stackalloc\t216','.seh_stackalloc\t472').replace('add\trsp, 216','add\trsp, 472')
    marker='\tmov\tDWORD PTR 68[rcx], 0\n'
    s=s.replace(marker,marker+'''\tmov eax, 2684354560
\tadd rax, rcx
\tmov QWORD PTR 216[rsp], rax
\tmov eax, 3221225472
\tadd rax, rcx
\tmov QWORD PTR 224[rsp], rax
\tmov QWORD PTR 232[rsp], 0
''')
    # Flush at refill call sites after RCX/RDX/R8 arguments have been prepared.
    call='\tcall refill_object_lines\n'
    count=s.count(call)
    for i in range(count):
        s=s.replace(call,f'''\tlea rax, .Lsweep_refill_{i}[rip]
\tjmp .Lsweep_flush
.Lsweep_refill_{i}:
\tcall SWEEP_REFILL
''',1)
    s=s.replace('SWEEP_REFILL','refill_object_lines')
    s=s.replace('\tmov\tr13d, 2684354560\n\tadd\tr13, rdi\n\tcmp\tr13, r12','\tmov r13, QWORD PTR 216[rsp]\n\tcmp r13, r12')
    s=s.replace('\tmov\tedx, 3221225472\n\tadd\trdx, rdi\n','\tmov rdx, QWORD PTR 224[rsp]\n')
    # Odd/even selection must be relative to the current batch, not the whole
    # queue. r9 is the next unconverted record and rsi the last record.
    a=s.index('\tmovabs\trax, -2684354577');b=s.index('.Lparse_beatmap_body_block_32:',a)
    s=s[:a]+'''\txor ebp, ebp
\tcmp r9, rsi
\tje .Lparse_beatmap_body_block_55
'''+s[b:]
    s=s.replace('.Lparse_beatmap_body_block_32:\n','.Lparse_beatmap_body_block_32:\n\tcmp QWORD PTR 232[rsp], 0\n\tjne .Lsweep_flush_done\n')
    # The empty final batch must recover the last fast-path point cursor for
    # deferred general parsing.
    s=s.replace('.Lparse_beatmap_body_block_58:\n','.Lparse_beatmap_body_block_58:\n\tmov rbx, QWORD PTR 224[rsp]\n')
    # Save all values live at the refill boundary, including outer spill slots
    # reused by the slider phase. The original outer unwind frame owns them.
    regs=['rbp','r15','r14','r12','r13','rbx','rsi','rcx','rdx','r8']
    save='';restore=''
    for i,r in enumerate(regs):
        off=240+i*8;save+=f'\tmov QWORD PTR {off}[rsp], {r}\n';restore+=f'\tmov {r}, QWORD PTR {off}[rsp]\n'
    for i in range(6,11):
        off=320+(i-6)*16;save+=f'\tvmovdqu XMMWORD PTR {off}[rsp], xmm{i}\n';restore+=f'\tvmovdqu xmm{i}, XMMWORD PTR {off}[rsp]\n'
    for i,off in enumerate([40,56,64,72]):
        save+=f'\tmov r11, QWORD PTR {off}[rsp]\n\tmov QWORD PTR {400+i*8}[rsp], r11\n'
        restore+=f'\tmov r11, QWORD PTR {400+i*8}[rsp]\n\tmov QWORD PTR {off}[rsp], r11\n'
    code='''.Lsweep_flush:
\tcmp r12, QWORD PTR 216[rsp]
\tje .Lsweep_no_flush
\tmov QWORD PTR 232[rsp], rax
'''+save+'''\tjmp .Lparse_beatmap_body_block_24
.Lsweep_no_flush:
\tjmp rax
.Lsweep_flush_done:
\tmov QWORD PTR 224[rsp], rbx
'''+restore+'''\tmov QWORD PTR 216[rsp], r12
\tmov rax, QWORD PTR 232[rsp]
\tmov QWORD PTR 232[rsp], 0
\tjmp rax
'''
    a=s.index('\t.seh_endproc',s.index('parse_beatmap_body:'))
    return s[:a]+code+s[a:]

def slider_streams(source, module):
    if module=='sliders':
        from pathlib import Path
        return source+'\n'+(Path(__file__).parent/'slider_streams.s').read_text()
    if module=='beatmap':
        marker='.Lparse_beatmap_body_block_26:\n'
        source=source.replace(marker,marker+'''	mov rcx, QWORD PTR 176[rsp]
	call sweep_slider_streams
	test eax, eax
	je .Lsweep_stream_original
	cmp rsi, rbx
	jne .Lparse_beatmap_body_block_26
	lea r11, [rsi]
	sub rsi, 16
	jmp .Lsweep_stream_lengths
.Lsweep_stream_original:
''')
        source=source.replace('\tmov\tebp, DWORD PTR 68[rdi]\n\tmov\teax, 774778414', '.Lsweep_stream_lengths:\n\tmov\tebp, DWORD PTR 68[rdi]\n\tmov\teax, 774778414')
    return source

def scratch_prefix(s):
    # Locate only a sizing bound. Keep the existing scanner and decoder intact.
    old='\tlea\trax, 32[0+rsi*8]\n';assert old in s;s=s.replace(old,'',1)
    marker='\tlea\tr12, 536870912[rcx]\n'
    s=s.replace(marker,marker+'''\tmov rcx, r14
\tmov rdx, rbp
\tcall find_hitobjects
\tsub rax, r14
\tadd rax, 1088
\tlea rax, 32[rax*8]
\tmov edx, DWORD PTR 4[rdi]
''',1)
    # The rare early-marker retry can scan the entire file and therefore needs
    # the original full-file pointer capacity. Do not silently reuse a small cap.
    marker='\tlea r12, 536870912[rdi]\n\tmov r13d, 2684354560'
    s=s.replace(marker,'''\tlea r12, 536870912[rdi]
\tmov rcx, rbp
\tsub rcx, r14
\tlea rcx, 32[rcx*8]
\tmov rdx, r12
\tlea r8, 4[rdi]
\tcall memory_resize
\ttest rax, rax
\tje .Lparse_beatmap_body_block_36
\tmov r13d, 2684354560''')
    return s

def batch_four(s):
    s=batch_sliders(s)
    s=s.replace('\tmov QWORD PTR 232[rsp], 0\n', '\tmov QWORD PTR 232[rsp], 0\n\tmov DWORD PTR 432[rsp], 0\n',1)
    s=s.replace('.Lsweep_flush:\n','.Lsweep_flush:\n\tinc DWORD PTR 432[rsp]\n\ttest BYTE PTR 432[rsp], 3\n\tjne .Lsweep_no_flush\n')
    return s

def slider_streams_simd(source,module):
    source=slider_streams(source,module)
    if module=='sliders':
        source=source.replace(' # Count both spans,',' mov eax, 124\n vmovd xmm5, eax\n vpbroadcastb xmm5, xmm5\n # Count both spans,')
        a=source.index(' movzx eax, BYTE PTR [rcx]\n',source.index('sweep_slider_streams:'))
        b=source.index(' cmp BYTE PTR 2[rcx], 44',a)
        source=source[:a]+r''' vmovdqu xmm1, XMMWORD PTR [rcx]
 vpcmpeqb xmm0, xmm1, xmm6
 vpmovmskb eax, xmm0
 vpcmpeqb xmm1, xmm1, xmm5
 vpmovmskb r9d, xmm1
 test eax, eax
 jne .Lcount_done_\@
 popcnt r9d, r9d
 add r8d, r9d
 add rcx, 16
 jmp .Lcount_\@
 .Lcount_done_\@:
 tzcnt eax, eax
 bzhi r9d, r9d, eax
 popcnt r9d, r9d
 add r8d, r9d
 add rcx, rax
 cmp rcx, QWORD PTR 16[rsp]
 jae .Lsweep_stream_fail
'''+source[b:]
    return source

def scratch_limit(s):
    # Start with one commit chunk. If header scanning fills it, grow once to
    # the original worst-case bound and restart the existing full scan.
    s=s.replace('\tlea\trax, 32[0+rsi*8]\n','\tlea rax, 32[rsi*8]\n\tmov r9d, 524288\n\tcmp rax, r9\n\tcmova rax, r9\n',1)
    check='''\tmov eax, DWORD PTR 4[rdi]
\tlea rax, -528[r12+rax]
\tcmp rsi, rax
\tja .Lretry_full_scan
'''
    for label in ['.Lparse_beatmap_body_block_7:','.Lscan_header_block:']:
        s=s.replace(label+'\n',label+'\n'+check,1)
    marker='\tlea r12, 536870912[rdi]\n\tmov r13d, 2684354560'
    s=s.replace(marker,'''\tlea r12, 536870912[rdi]
\tmov rcx, rbp
\tsub rcx, r14
\tlea rcx, 32[rcx*8]
\tmov rdx, r12
\tlea r8, 4[rdi]
\tcall memory_resize
\ttest rax, rax
\tje .Lparse_beatmap_body_block_36
\tmov r13d, 2684354560''')
    return s
