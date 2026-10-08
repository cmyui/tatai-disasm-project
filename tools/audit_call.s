.intel_syntax noprefix
.text
.globl audit_parser_call
.def audit_parser_call; .scl 2; .type 32; .endef
.seh_proc audit_parser_call
audit_parser_call:
	push rbx
	.seh_pushreg rbx
	push rbp
	.seh_pushreg rbp
	push rdi
	.seh_pushreg rdi
	push rsi
	.seh_pushreg rsi
	push r12
	.seh_pushreg r12
	push r13
	.seh_pushreg r13
	push r14
	.seh_pushreg r14
	push r15
	.seh_pushreg r15
	sub rsp, 200
	.seh_stackalloc 200
	vmovdqa [rsp+32], xmm6
	.seh_savexmm xmm6, 32
	vmovdqa [rsp+48], xmm7
	.seh_savexmm xmm7, 48
	vmovdqa [rsp+64], xmm8
	.seh_savexmm xmm8, 64
	vmovdqa [rsp+80], xmm9
	.seh_savexmm xmm9, 80
	vmovdqa [rsp+96], xmm10
	.seh_savexmm xmm10, 96
	vmovdqa [rsp+112], xmm11
	.seh_savexmm xmm11, 112
	vmovdqa [rsp+128], xmm12
	.seh_savexmm xmm12, 128
	vmovdqa [rsp+144], xmm13
	.seh_savexmm xmm13, 144
	vmovdqa [rsp+160], xmm14
	.seh_savexmm xmm14, 160
	vmovdqa [rsp+176], xmm15
	.seh_savexmm xmm15, 176
	.seh_endprologue
	mov r10d, 0x13579bdf
	mov rbx, r10
	mov rbp, r10
	mov rdi, r10
	mov rsi, r10
	mov r12, r10
	mov r13, r10
	mov r14, r10
	mov r15, r10
	vpcmpeqd xmm0, xmm0, xmm0
	vmovdqa xmm6, xmm0
	vmovdqa xmm7, xmm0
	vmovdqa xmm8, xmm0
	vmovdqa xmm9, xmm0
	vmovdqa xmm10, xmm0
	vmovdqa xmm11, xmm0
	vmovdqa xmm12, xmm0
	vmovdqa xmm13, xmm0
	vmovdqa xmm14, xmm0
	vmovdqa xmm15, xmm0
	call r9
	xor eax, eax
	mov r10d, 0x13579bdf
	cmp rbx, r10
	je .Lok_g0
	or eax, 1
.Lok_g0:
	cmp rbp, r10
	je .Lok_g1
	or eax, 2
.Lok_g1:
	cmp rdi, r10
	je .Lok_g2
	or eax, 4
.Lok_g2:
	cmp rsi, r10
	je .Lok_g3
	or eax, 8
.Lok_g3:
	cmp r12, r10
	je .Lok_g4
	or eax, 16
.Lok_g4:
	cmp r13, r10
	je .Lok_g5
	or eax, 32
.Lok_g5:
	cmp r14, r10
	je .Lok_g6
	or eax, 64
.Lok_g6:
	cmp r15, r10
	je .Lok_g7
	or eax, 128
.Lok_g7:
	vpcmpeqd xmm1, xmm1, xmm1
	vpcmpeqb xmm0, xmm6, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v6
	or eax, 256
.Lok_v6:
	vpcmpeqb xmm0, xmm7, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v7
	or eax, 512
.Lok_v7:
	vpcmpeqb xmm0, xmm8, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v8
	or eax, 1024
.Lok_v8:
	vpcmpeqb xmm0, xmm9, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v9
	or eax, 2048
.Lok_v9:
	vpcmpeqb xmm0, xmm10, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v10
	or eax, 4096
.Lok_v10:
	vpcmpeqb xmm0, xmm11, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v11
	or eax, 8192
.Lok_v11:
	vpcmpeqb xmm0, xmm12, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v12
	or eax, 16384
.Lok_v12:
	vpcmpeqb xmm0, xmm13, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v13
	or eax, 32768
.Lok_v13:
	vpcmpeqb xmm0, xmm14, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v14
	or eax, 65536
.Lok_v14:
	vpcmpeqb xmm0, xmm15, xmm1
	vpmovmskb r11d, xmm0
	cmp r11d, 65535
	je .Lok_v15
	or eax, 131072
.Lok_v15:
	vmovdqa xmm6, [rsp+32]
	vmovdqa xmm7, [rsp+48]
	vmovdqa xmm8, [rsp+64]
	vmovdqa xmm9, [rsp+80]
	vmovdqa xmm10, [rsp+96]
	vmovdqa xmm11, [rsp+112]
	vmovdqa xmm12, [rsp+128]
	vmovdqa xmm13, [rsp+144]
	vmovdqa xmm14, [rsp+160]
	vmovdqa xmm15, [rsp+176]
	add rsp, 200
	pop r15
	pop r14
	pop r13
	pop r12
	pop rsi
	pop rdi
	pop rbp
	pop rbx
	ret
.seh_endproc
