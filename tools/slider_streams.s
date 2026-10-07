.intel_syntax noprefix
.section .text$sweep_slider_streams,"x"
.globl sweep_slider_streams
.def sweep_slider_streams; .scl 2; .type 32; .endef
.seh_proc sweep_slider_streams
# Private slider context: RSI deferrals, RBX end, RDX anchors, RCX input end.
# Retains RDI/RSI/RBX/R13/R15 and XMM6-XMM11. Other scalar registers scratch.
# Success advances RSI by two records and RDX to the reserved spans' end.
sweep_slider_streams:
 sub rsp, 72
 .seh_stackalloc 72
 .seh_endprologue
 mov QWORD PTR 0[rsp], rdx
 mov QWORD PTR 8[rsp], r13
 mov QWORD PTR 16[rsp], rcx
 lea rax, 32[rsi]
 cmp rax, rbx
 ja .Lsweep_stream_fail
 # Count both spans, including that cost in the prototype. Reject missing
 # delimiters before crossing the real input end. Padding permits SIMD loads.
 .macro reserve_stream record, input, output, slot
 mov \input, QWORD PTR \record[rsi]
 mov r10, QWORD PTR (\record+8)[rsi]
 mov eax, 2
 mov ecx, 3
 cmp BYTE PTR 1[\input], 44
 cmovne eax, ecx
 add \input, rax
 movzx eax, BYTE PTR [\input]
 mov DWORD PTR 28[r10], eax
 add \input, 2
 mov \output, rdx
 mov QWORD PTR [r10], rdx
 mov rcx, \input
 xor r8d, r8d
 .Lcount_\@:
 cmp rcx, QWORD PTR 16[rsp]
 jae .Lsweep_stream_fail
 movzx eax, BYTE PTR [rcx]
 cmp al, 44
 je .Lcount_done_\@
 cmp al, 124
 sete r9b
 movzx r9d, r9b
 add r8d, r9d
 inc rcx
 jmp .Lcount_\@
 .Lcount_done_\@:
 cmp BYTE PTR 2[rcx], 44
 jne .Lsweep_stream_fail
 movzx eax, BYTE PTR 1[rcx]
 and eax, 15
 mov DWORD PTR 24[r10], eax
 add rcx, 3
 mov QWORD PTR \slot[rsp], rcx
 lea rdx, 8[rdx+r8*8]
 mov QWORD PTR 8[r10], rdx
 .endm
 reserve_stream 0, rbp, r13, 24
 reserve_stream 16, r12, r14, 32
 mov QWORD PTR 40[rsp], rdx
 mov rdx, r13
 .p2align 4
.Lsweep_stream_loop:
 .macro decode_stream input, output
 test \input, \input
 je .Lstream_skip_\@
 vmovdqu xmm1, XMMWORD PTR [\input]
 vpshufb xmm0, xmm11, xmm1
 vpmovmskb r8d, xmm0
 vpaddb xmm0, xmm1, xmm10
 vpcmpeqb xmm1, xmm1, xmm6
 mov eax, 15
 pdep eax, eax, r8d
 lea ecx, 1[rax+rax]
 vpmovmskb r9d, xmm1
 test ecx, eax
 jne .Lsweep_stream_fail
 blsmsk r8d, r9d
 and r8d, eax
 mov eax, r8d
 shl eax, 4
 add rax, r15
 mov rcx, QWORD PTR [rax]
 cmp r8d, ecx
 jne .Lsweep_stream_fail
 vpshufb xmm0, xmm0, XMMWORD PTR 16[rax]
 shr rcx, 32
 test ecx, ecx
 je .Lsweep_stream_fail
 vpmaddubsw xmm0, xmm0, xmm9
 vpmaddwd xmm0, xmm0, xmm7
 cmp cl, 1
 je .Lstore_single_\@
 vmovdqu XMMWORD PTR [\output], xmm0
 jmp .Lstore_done_\@
 .Lstore_single_\@:
 vmovq QWORD PTR [\output], xmm0
 .Lstore_done_\@:
 movzx eax, cl
 lea \output, [\output+rax*8]
 shr ecx, 24
 add \input, rcx
 test r9d, r8d
 je .Lstream_skip_\@
 xor \input, \input
 .Lstream_skip_\@:
 .endm
 decode_stream rbp, rdx
 decode_stream r12, r14
 mov rax, rbp
 or rax, r12
 jne .Lsweep_stream_loop
 mov rax, QWORD PTR 24[rsp]
 mov QWORD PTR [rsi], rax
 mov rax, QWORD PTR 32[rsp]
 mov QWORD PTR 16[rsi], rax
 mov rdx, QWORD PTR 40[rsp]
 add rsi, 32
 mov eax, 1
 jmp .Lsweep_stream_return
.Lsweep_stream_fail:
 mov rdx, QWORD PTR 0[rsp]
 xor eax, eax
.Lsweep_stream_return:
 mov r13, QWORD PTR 8[rsp]
 add rsp, 72
 ret
.seh_endproc
