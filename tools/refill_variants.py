"""Resume hot object loops across refills without rebuilding their constants."""
def resume(source,module,kind):
    if module=='line_scan':
        source=source.replace('''\tvpcmpeqb\tymm1, ymm0, YMMWORD PTR [rdx]
\tvpcmpeqb\tymm2, ymm0, YMMWORD PTR 32[rdx]
\tvpmovmskb\teax, ymm1
\tvpmovmskb\tr10d, ymm2''','''\tvpcmpeqb ymm1, ymm0, YMMWORD PTR [rdx]
\tvpmovmskb eax, ymm1
\tvpcmpeqb ymm1, ymm0, YMMWORD PTR 32[rdx]
\tvpmovmskb r10d, ymm1''')
        source=source.replace('\tvzeroupper\n','')
    if kind=='refill-resume' and module=='object_loop':
        for width,loop,exit in [(5,1,5),(6,6,7)]:
            source+=f'''
.section .text$parse_objects_{width}digit_resume,"x"
.globl parse_objects_{width}digit_resume
.def parse_objects_{width}digit_resume; .scl 2; .type 32; .endef
.seh_proc parse_objects_{width}digit_resume
parse_objects_{width}digit_resume:
 sub rsp, 40
 .seh_stackalloc 40
 .seh_endprologue
 mov rbx, QWORD PTR [rbp]
 test rbx, rbx
 je .Lparse_objects_{width}digit_context_block_{exit}
 lea rsi, object_{width}_header_shuffles[rip]
 jmp .Lparse_objects_{width}digit_context_block_{loop}
.seh_endproc
'''
    if kind=='refill-resume' and module=='beatmap':
        extra=''
        for width,block in [(5,21),(6,22)]:
            # Only a completed call establishes the vector/table state. An
            # initial entry on an empty line batch must still use full setup.
            a=source.index(f'\tcall\tparse_objects_{width}digit_context')
            b=source.index(f'\tje .Lparse_beatmap_body_block_{block}',a)
            source=source[:b]+source[b:].replace(f'\tje .Lparse_beatmap_body_block_{block}',f'\tje .Lresume_refill_{width}',1)
            # Both entry paths join at the original post-call cursor update.
            call=f'\tcall\tparse_objects_{width}digit_context\n'
            source=source.replace(call,call+f'.Lresume_done_{width}:\n')
            extra+=f'''.Lresume_refill_{width}:
 mov rdx, QWORD PTR 184[rsp]
 mov r8, QWORD PTR 176[rsp]
 cmp rdx, r8
 je .Lparse_beatmap_body_block_24
 mov rcx, rdi
 call refill_object_lines
 mov QWORD PTR 184[rsp], rdx
 lea rbp, 536870912[rdi]
 vmovq xmm10, rax
 call parse_objects_{width}digit_resume
 jmp .Lresume_done_{width}
'''
        end=source.index('\t.seh_endproc',source.index('parse_beatmap_body:'))
        source=source[:end]+extra+source[end:]
    return source
