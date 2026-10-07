.intel_syntax noprefix

# parse_objects_4digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: Parse objects using 4-digit timestamps (RCX: begin, RDX: end, R8: object bodies, R9: deferrals)
.section .text$parse_objects_4digit,"x"
.p2align 4
.globl parse_objects_4digit
.def parse_objects_4digit; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_4digit
parse_objects_4digit:
.Lparse_objects_4digit_block_0:
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	mov	r12, QWORD PTR [rcx]
	mov	r11, rcx
	mov	rbx, rdx
	test	r12, r12
	je	.Lparse_objects_4digit_block_10
	mov	esi, 741092396
	vmovdqa	xmm4, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_16[rip]
	mov	rax, r9
	vmovd	xmm2, esi
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	mov	r10, rcx
	lea	rdi, object_4_coordinate_shuffles[rip]
	vpbroadcastd	xmm2, xmm2
	lea	rsi, object_4_header_shuffles[rip]
.Lparse_objects_4digit_block_1:
	vmovdqu	xmm0, XMMWORD PTR [r12]
	vpcmpeqb	xmm1, xmm0, xmm2
	vpmovmskb	ebp, xmm1
	movzx	r13d, bpl
	mov	edx, r13d
	sal	edx, 5
	test	edx, ebp
	je	.Lparse_objects_4digit_block_4
	lea	edx, 54[r13]
	mov	r15d, ebp
	lea	r14d, -2[r13]
	movzx	ecx, WORD PTR [rdi+rdx]
	mov	edx, -791621424
	shr	r15d, 7
	vmovd	xmm1, edx
	vpbroadcastd	xmm1, xmm1
	movzx	edx, cl
	movzx	ecx, ch
	vpaddb	xmm0, xmm0, xmm1
	test	r15d, r14d
	je	.Lparse_objects_4digit_block_6
.Lparse_objects_4digit_block_2:
	mov	ecx, ecx
	vpmovmskb	r14d, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [rsi+rcx*8]
	andn	r14d, ebp, r14d
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpminud	xmm0, xmm0, xmm5
	vmovdqa	XMMWORD PTR [rbx], xmm0
	jne	.Lparse_objects_4digit_block_7
.Lparse_objects_4digit_block_3:
	cmp	edx, 2
	jbe	.Lparse_objects_4digit_block_9
	mov	ecx, DWORD PTR 12[rbx]
	add	rdx, r12
	mov	r12, QWORD PTR 8[r10]
	mov	QWORD PTR 8[rax], r8
	mov	QWORD PTR [rax], rdx
	add	r10, 8
	lea	edx, 0[0+rcx*8]
	and	edx, 16
	add	rax, rdx
	test	r12, r12
	je	.Lparse_objects_4digit_block_4
	add	rbx, 16
	add	r8, 32
	jmp	.Lparse_objects_4digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_4digit_block_4:
	sub	rax, r9
	sub	r10, r11
	sar	rax, 4
	sar	r10, 3
	sal	rax, 32
	or	rax, r10
.Lparse_objects_4digit_block_5:
	add	rsp, 56
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_4digit_block_6:
	blsr	r14d, r13d
	sal	r14d, 8
	test	r14d, ebp
	je	.Lparse_objects_4digit_block_11
	add	ecx, 2
	inc	edx
	jmp	.Lparse_objects_4digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_4digit_block_7:
	xor	ecx, ecx
	tzcnt	ecx, r13d
	cmp	BYTE PTR [r12], 45
	jne	.Lparse_objects_4digit_block_8
	mov	DWORD PTR [rbx], 0
.Lparse_objects_4digit_block_8:
	inc	ecx
	cmp	BYTE PTR [r12+rcx], 45
	jne	.Lparse_objects_4digit_block_3
	mov	DWORD PTR 4[rbx], 0
	jmp	.Lparse_objects_4digit_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_4digit_block_9:
	mov	rcx, r12
	mov	rdx, rbx
	mov	QWORD PTR 152[rsp], r9
	inc	r12
	mov	QWORD PTR 144[rsp], r8
	mov	QWORD PTR 128[rsp], r11
	mov	QWORD PTR 40[rsp], rax
	mov	QWORD PTR 32[rsp], r10
	call	defer_object_header
	mov	r10, QWORD PTR 32[rsp]
	mov	rax, QWORD PTR 40[rsp]
	mov	ecx, DWORD PTR 12[rbx]
	mov	r8, QWORD PTR 144[rsp]
	add	r10, 8
	mov	r11, QWORD PTR 128[rsp]
	mov	r9, QWORD PTR 152[rsp]
	mov	QWORD PTR [rax], r12
	lea	edx, 0[0+rcx*8]
	mov	r12, QWORD PTR [r10]
	mov	QWORD PTR 8[rax], r8
	and	edx, 16
	add	rax, rdx
	test	r12, r12
	je	.Lparse_objects_4digit_block_4
	vmovdqa	xmm2, XMMWORD PTR constant_7[rip]
	vmovdqa	xmm4, XMMWORD PTR constant_15[rip]
	add	rbx, 16
	add	r8, 32
	vmovdqa	xmm3, XMMWORD PTR constant_16[rip]
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	jmp	.Lparse_objects_4digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_4digit_block_10:
	xor	eax, eax
	jmp	.Lparse_objects_4digit_block_5
.Lparse_objects_4digit_block_11:
	add	ecx, 4
	add	edx, 2
	jmp	.Lparse_objects_4digit_block_2
	.seh_endproc

# parse_objects_5digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: Parse objects using 5-digit timestamps (RCX: begin, RDX: end, R8: object bodies, R9: deferrals)
.section .text$parse_objects_5digit,"x"
.p2align 4
.globl parse_objects_5digit
.def parse_objects_5digit; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_5digit
parse_objects_5digit:
.Lparse_objects_5digit_block_0:
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 72
	.seh_stackalloc	72
	vmovaps	XMMWORD PTR 48[rsp], xmm6
	.seh_savexmm	xmm6, 48
	.seh_endprologue
	mov	r15, QWORD PTR [rcx]
	mov	rsi, rcx
	mov	rbp, rdx
	mov	r13, r8
	mov	r12, r9
	test	r15, r15
	je	.Lparse_objects_5digit_block_14
	mov	QWORD PTR 40[rsp], r9
	vmovdqa	xmm4, XMMWORD PTR constant_2[rip]
	mov	rdi, rcx
	lea	r14, object_5_coordinate_shuffles[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_3[rip]
	vmovdqa	xmm6, XMMWORD PTR constant_4[rip]
	vmovdqa	xmm2, XMMWORD PTR constant_5[rip]
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_1:
	mov	eax, 741092396
	vmovdqu	xmm0, XMMWORD PTR [r15]
	vmovd	xmm1, eax
	vpbroadcastd	xmm1, xmm1
	vpcmpeqb	xmm1, xmm0, xmm1
	vpmovmskb	eax, xmm1
	movzx	ecx, al
	mov	edx, ecx
	sal	edx, 6
	test	edx, eax
	je	.Lparse_objects_5digit_block_5
	lea	edx, 54[rcx]
	mov	ebx, -791621424
	lea	r10d, -1[rcx]
	mov	r11d, eax
	movzx	r9d, WORD PTR [r14+rdx]
	vmovd	xmm1, ebx
	shr	r11d, 8
	vpbroadcastd	xmm1, xmm1
	mov	ebx, r9d
	vpaddb	xmm0, xmm0, xmm1
	movzx	edx, r9b
	movzx	ebx, bh
	mov	r8d, ebx
	test	r11d, r10d
	je	.Lparse_objects_5digit_block_11
.Lparse_objects_5digit_block_2:
	lea	r10, object_5_header_shuffles[rip]
	vpmovmskb	r9d, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [r10+r8*8]
	andn	r9d, eax, r9d
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpshufb	xmm0, xmm0, xmm6
	vpmaddwd	xmm0, xmm0, xmm2
	vpminud	xmm0, xmm0, xmm5
	vmovdqa	XMMWORD PTR 0[rbp], xmm0
	jne	.Lparse_objects_5digit_block_9
.Lparse_objects_5digit_block_3:
	cmp	edx, 17
	ja	.Lparse_objects_5digit_block_8
.Lparse_objects_5digit_block_4:
	cmp	edx, 2
	jbe	.Lparse_objects_5digit_block_7
	mov	eax, DWORD PTR 12[rbp]
	mov	rcx, QWORD PTR 40[rsp]
	add	rdi, 8
	add	rdx, r15
	mov	r15, QWORD PTR [rdi]
	sal	eax, 3
	mov	QWORD PTR [rcx], rdx
	and	eax, 16
	mov	QWORD PTR 8[rcx], r13
	add	rcx, rax
	mov	QWORD PTR 40[rsp], rcx
	test	r15, r15
	je	.Lparse_objects_5digit_block_5
	add	rbp, 16
	add	r13, 32
	jmp	.Lparse_objects_5digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_5:
	mov	rax, QWORD PTR 40[rsp]
	sub	rdi, rsi
	sar	rdi, 3
	sub	rax, r12
	sar	rax, 4
	sal	rax, 32
	or	rax, rdi
.Lparse_objects_5digit_block_6:
	vmovaps	xmm6, XMMWORD PTR 48[rsp]
	add	rsp, 72
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_7:
	mov	rcx, r15
	mov	rdx, rbp
	inc	r15
	add	rdi, 8
	call	defer_object_header
	mov	eax, DWORD PTR 12[rbp]
	mov	rbx, QWORD PTR 40[rsp]
	sal	eax, 3
	mov	QWORD PTR [rbx], r15
	mov	r15, QWORD PTR [rdi]
	and	eax, 16
	mov	QWORD PTR 8[rbx], r13
	add	rbx, rax
	mov	QWORD PTR 40[rsp], rbx
	test	r15, r15
	je	.Lparse_objects_5digit_block_5
	vmovdqa	xmm4, XMMWORD PTR constant_2[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_3[rip]
	add	rbp, 16
	add	r13, 32
	vmovdqa	xmm2, XMMWORD PTR constant_5[rip]
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	jmp	.Lparse_objects_5digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_8:
	and	edx, 127
	lea	eax, -2[rdx]
	movzx	ecx, BYTE PTR [r15+rax]
	vpextrd	eax, xmm0, 3
	lea	eax, [rax+rax*4]
	and	ecx, 15
	lea	eax, [rcx+rax*2]
	mov	DWORD PTR 12[rbp], eax
	jmp	.Lparse_objects_5digit_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_9:
	tzcnt	ecx, ecx
	cmp	BYTE PTR [r15], 45
	je	.Lparse_objects_5digit_block_12
	lea	eax, 1[rcx]
	cmp	BYTE PTR [r15+rax], 45
	jne	.Lparse_objects_5digit_block_3
.Lparse_objects_5digit_block_10:
	mov	DWORD PTR 4[rbp], 0
	jmp	.Lparse_objects_5digit_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_11:
	movzx	r9d, r9b
	cmp	BYTE PTR [r15+r9], 44
	jne	.Lparse_objects_5digit_block_13
	add	r8d, 2
	inc	edx
	jmp	.Lparse_objects_5digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_block_12:
	lea	eax, 1[rcx]
	mov	DWORD PTR 0[rbp], 0
	cmp	BYTE PTR [r15+rax], 45
	jne	.Lparse_objects_5digit_block_3
	jmp	.Lparse_objects_5digit_block_10
.Lparse_objects_5digit_block_13:
	add	r8d, 4
	add	edx, 130
	jmp	.Lparse_objects_5digit_block_2
.Lparse_objects_5digit_block_14:
	xor	eax, eax
	jmp	.Lparse_objects_5digit_block_6
	.seh_endproc

# parse_objects_6digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: Parse objects using 6-digit timestamps (RCX: begin, RDX: end, R8: object bodies, R9: deferrals)
.section .text$parse_objects_6digit,"x"
.p2align 4
.globl parse_objects_6digit
.def parse_objects_6digit; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_6digit
parse_objects_6digit:
.Lparse_objects_6digit_block_0:
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 56
	.seh_stackalloc	56
	vmovaps	XMMWORD PTR 32[rsp], xmm6
	.seh_savexmm	xmm6, 32
	.seh_endprologue
	mov	r13, QWORD PTR [rcx]
	mov	r15, rcx
	mov	rsi, rdx
	test	r13, r13
	je	.Lparse_objects_6digit_block_17
	vmovdqa	xmm4, XMMWORD PTR constant_9[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_10[rip]
	mov	rbx, r9
	mov	rdi, rcx
	vmovdqa	xmm6, XMMWORD PTR constant_4[rip]
	vmovdqa	xmm2, XMMWORD PTR constant_11[rip]
	lea	r12, object_6_coordinate_shuffles[rip]
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	jmp	.Lparse_objects_6digit_block_6
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_1:
	mov	eax, -791621424
	vmovd	xmm1, eax
	lea	eax, 54[r11]
	movzx	eax, WORD PTR [r12+rax]
	vpbroadcastd	xmm1, xmm1
	vpaddb	xmm0, xmm0, xmm1
	movzx	ebp, ah
	movzx	edx, al
	movzx	eax, al
	cmp	BYTE PTR -1[r13+rax], 44
	mov	r10d, ebp
	jne	.Lparse_objects_6digit_block_12
.Lparse_objects_6digit_block_2:
	lea	r14, object_6_header_shuffles[rip]
	vpmovmskb	eax, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [r14+r10*8]
	andn	eax, ecx, eax
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpshufb	xmm0, xmm0, xmm6
	vpmaddwd	xmm0, xmm0, xmm2
	vpminud	xmm0, xmm0, xmm5
	vmovdqa	XMMWORD PTR [rsi], xmm0
	jne	.Lparse_objects_6digit_block_10
.Lparse_objects_6digit_block_3:
	cmp	edx, 17
	ja	.Lparse_objects_6digit_block_9
.Lparse_objects_6digit_block_4:
	cmp	edx, 2
	jbe	.Lparse_objects_6digit_block_13
	mov	eax, DWORD PTR 12[rsi]
.Lparse_objects_6digit_block_5:
	add	rdi, 8
	add	rdx, r13
	sal	eax, 3
	mov	QWORD PTR 8[rbx], r8
	mov	r13, QWORD PTR [rdi]
	and	eax, 16
	mov	QWORD PTR [rbx], rdx
	add	rsi, 16
	add	rbx, rax
	add	r8, 32
	test	r13, r13
	je	.Lparse_objects_6digit_block_7
.Lparse_objects_6digit_block_6:
	mov	eax, 741092396
	vmovdqu	xmm0, XMMWORD PTR 0[r13]
	vmovd	xmm1, eax
	vpbroadcastd	xmm1, xmm1
	vpcmpeqb	xmm1, xmm0, xmm1
	vpmovmskb	ecx, xmm1
	movzx	r11d, cl
	mov	eax, r11d
	sal	eax, 7
	test	eax, ecx
	jne	.Lparse_objects_6digit_block_1
.Lparse_objects_6digit_block_7:
	mov	rax, rbx
	sub	rdi, r15
	sub	rax, r9
	sar	rdi, 3
	sar	rax, 4
	sal	rax, 32
	or	rax, rdi
.Lparse_objects_6digit_block_8:
	vmovaps	xmm6, XMMWORD PTR 32[rsp]
	add	rsp, 56
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_9:
	vpextrd	eax, xmm0, 3
	cmp	edx, 18
	jne	.Lparse_objects_6digit_block_15
	movzx	edx, BYTE PTR 16[r13]
	lea	eax, [rax+rax*4]
	and	edx, 15
	lea	eax, [rdx+rax*2]
	mov	edx, 18
	mov	DWORD PTR 12[rsi], eax
	jmp	.Lparse_objects_6digit_block_5
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_10:
	tzcnt	r11d, r11d
	cmp	BYTE PTR 0[r13], 45
	je	.Lparse_objects_6digit_block_14
	lea	eax, 1[r11]
	cmp	BYTE PTR 0[r13+rax], 45
	jne	.Lparse_objects_6digit_block_3
.Lparse_objects_6digit_block_11:
	mov	DWORD PTR 4[rsi], 0
	jmp	.Lparse_objects_6digit_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_12:
	cmp	BYTE PTR 0[r13+rax], 44
	jne	.Lparse_objects_6digit_block_16
	add	r10d, 2
	inc	edx
	jmp	.Lparse_objects_6digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_13:
	mov	rdx, rsi
	mov	rcx, r13
	mov	QWORD PTR 152[rsp], r9
	mov	QWORD PTR 144[rsp], r8
	call	defer_object_header
	mov	eax, DWORD PTR 12[rsi]
	vmovdqa	xmm5, XMMWORD PTR constant_6[rip]
	mov	edx, 1
	vmovdqa	xmm2, XMMWORD PTR constant_11[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_10[rip]
	vmovdqa	xmm4, XMMWORD PTR constant_9[rip]
	mov	r9, QWORD PTR 152[rsp]
	mov	r8, QWORD PTR 144[rsp]
	jmp	.Lparse_objects_6digit_block_5
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_block_14:
	lea	eax, 1[r11]
	mov	DWORD PTR [rsi], 0
	cmp	BYTE PTR 0[r13+rax], 45
	jne	.Lparse_objects_6digit_block_3
	jmp	.Lparse_objects_6digit_block_11
.Lparse_objects_6digit_block_15:
	and	edx, 127
	imul	eax, eax, 100
	mov	ecx, edx
	movzx	ecx, WORD PTR -3[r13+rcx]
	mov	r10d, ecx
	shr	cx, 8
	and	r10d, 15
	and	ecx, 15
	lea	r10d, [r10+r10*4]
	lea	ecx, [rcx+r10*2]
	add	eax, ecx
	mov	DWORD PTR 12[rsi], eax
	jmp	.Lparse_objects_6digit_block_4
.Lparse_objects_6digit_block_16:
	add	r10d, 4
	add	edx, 130
	jmp	.Lparse_objects_6digit_block_2
.Lparse_objects_6digit_block_17:
	xor	eax, eax
	jmp	.Lparse_objects_6digit_block_8
	.seh_endproc

# parse_objects_7digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: Parse objects using 7-digit timestamps (RCX: begin, RDX: end, R8: object bodies, R9: deferrals)
.section .text$parse_objects_7digit,"x"
.p2align 4
.globl parse_objects_7digit
.def parse_objects_7digit; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_7digit
parse_objects_7digit:
.Lparse_objects_7digit_block_0:
	push	r15
	.seh_pushreg	r15
	push	r14
	.seh_pushreg	r14
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 24
	.seh_stackalloc	24
	vmovaps	XMMWORD PTR [rsp], xmm6
	.seh_savexmm	xmm6, 0
	.seh_endprologue
	mov	rax, QWORD PTR [rcx]
	mov	rbp, rcx
	mov	r10, rdx
	mov	rdi, r8
	test	rax, rax
	je	.Lparse_objects_7digit_block_11
	mov	esi, 741092396
	mov	QWORD PTR 96[rsp], rbp
	vmovdqa	xmm3, XMMWORD PTR constant_31[rip]
	mov	rcx, r9
	vmovd	xmm4, esi
	mov	esi, -791621424
	vmovdqa	xmm2, XMMWORD PTR constant_32[rip]
	vmovdqa	xmm6, XMMWORD PTR constant_6[rip]
	vmovd	xmm5, esi
	mov	r8, rbp
	vpbroadcastd	xmm4, xmm4
	mov	r15, r9
	lea	r13, object_7_coordinate_shuffles[rip]
	vpbroadcastd	xmm5, xmm5
	lea	r14, object_7_header_shuffles[rip]
	jmp	.Lparse_objects_7digit_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_objects_7digit_block_1:
	lea	edx, 54[rsi]
	movzx	ebx, WORD PTR 0[r13+rdx]
	mov	r11d, ebx
	and	r11w, 255
	je	.Lparse_objects_7digit_block_7
	vpaddb	xmm0, xmm0, xmm5
	movzx	ebx, bh
	movzx	edx, r11w
	vpmovmskb	r12d, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [r14+rbx*8]
	vpmaddubsw	xmm0, xmm0, xmm3
	vpmaddwd	xmm0, xmm0, xmm2
	vpminud	xmm0, xmm0, xmm6
	vpextrq	rbp, xmm0, 1
	vmovq	QWORD PTR [r10], xmm0
	mov	rbx, rbp
	shr	rbx, 30
	add	ebx, ebp
	andn	r9d, r9d, r12d
	mov	DWORD PTR 8[r10], ebx
	jne	.Lparse_objects_7digit_block_8
.Lparse_objects_7digit_block_2:
	movzx	r11d, r11w
	mov	ebx, DWORD PTR [rax+r11]
	mov	r9d, ebx
	and	r9d, 15
	cmp	bh, 44
	jne	.Lparse_objects_7digit_block_10
	mov	DWORD PTR 12[r10], r9d
	add	edx, 2
.Lparse_objects_7digit_block_3:
	add	r8, 8
	add	rdx, rax
	sal	r9d, 3
	mov	QWORD PTR 8[rcx], rdi
	mov	rax, QWORD PTR [r8]
	and	r9d, 16
	mov	QWORD PTR [rcx], rdx
	add	r10, 16
	add	rcx, r9
	add	rdi, 32
	test	rax, rax
	je	.Lparse_objects_7digit_block_5
.Lparse_objects_7digit_block_4:
	vmovdqu	xmm0, XMMWORD PTR [rax]
	vpcmpeqb	xmm1, xmm0, xmm4
	vpmovmskb	r9d, xmm1
	movzx	esi, r9b
	mov	edx, esi
	sal	edx, 8
	test	edx, r9d
	jne	.Lparse_objects_7digit_block_1
.Lparse_objects_7digit_block_5:
	mov	rbp, QWORD PTR 96[rsp]
	mov	rax, rcx
	sub	rax, r15
	sar	rax, 4
	sub	r8, rbp
	sal	rax, 32
	sar	r8, 3
	or	rax, r8
.Lparse_objects_7digit_block_6:
	vmovaps	xmm6, XMMWORD PTR [rsp]
	add	rsp, 24
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_7digit_block_7:
	mov	r9d, DWORD PTR 12[r10]
	mov	edx, 1
	jmp	.Lparse_objects_7digit_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_7digit_block_8:
	tzcnt	esi, esi
	cmp	BYTE PTR [rax], 45
	jne	.Lparse_objects_7digit_block_9
	mov	DWORD PTR [r10], 0
.Lparse_objects_7digit_block_9:
	lea	r9d, 1[rsi]
	cmp	BYTE PTR [rax+r9], 45
	jne	.Lparse_objects_7digit_block_2
	mov	DWORD PTR 4[r10], 0
	jmp	.Lparse_objects_7digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_7digit_block_10:
	and	ebx, 986895
	mov	r11d, ebx
	mov	esi, ebx
	shr	r11d, 8
	shr	esi, 16
	movzx	r11d, r11b
	cmp	ebx, 655359
	jbe	.Lparse_objects_7digit_block_12
	lea	r9d, [r9+r9*4]
	add	edx, 3
	lea	r9d, [r11+r9*2]
	mov	DWORD PTR 12[r10], r9d
	jmp	.Lparse_objects_7digit_block_3
.Lparse_objects_7digit_block_11:
	xor	eax, eax
	jmp	.Lparse_objects_7digit_block_6
.Lparse_objects_7digit_block_12:
	imul	r9d, r9d, 100
	lea	r11d, [r11+r11*4]
	add	edx, 4
	add	r9d, esi
	lea	r9d, [r9+r11*2]
	mov	DWORD PTR 12[r10], r9d
	jmp	.Lparse_objects_7digit_block_3
	.seh_endproc
