.intel_syntax noprefix

# parse_object_5digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_5_time::NO_INLINE_parse_object_5digit_single(char const*, _object_header*)
.section .text$parse_object_5digit,"x"
.p2align 4
.globl parse_object_5digit
.def parse_object_5digit; .scl 2; .type 32; .endef
	.seh_proc	parse_object_5digit
parse_object_5digit:
.Lparse_object_5digit_block_0:
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	mov	eax, 741092396
	vmovd	xmm1, eax
	vpbroadcastd	xmm1, xmm1
	vmovdqu	xmm0, XMMWORD PTR [rcx]
	mov	r10, rdx
	mov	r9, rcx
	vpcmpeqb	xmm1, xmm0, xmm1
	vpmovmskb	r8d, xmm1
	movzx	eax, r8b
	mov	edx, eax
	sal	edx, 6
	and	edx, r8d
	je	.Lparse_object_5digit_block_4
	lea	edx, 54[rax]
	lea	rcx, object_5_coordinate_shuffles[rip]
	mov	esi, -791621424
	movzx	r11d, WORD PTR [rcx+rdx]
	vmovd	xmm1, esi
	mov	esi, r8d
	vpbroadcastd	xmm1, xmm1
	shr	esi, 8
	mov	ebx, r11d
	vpaddb	xmm0, xmm0, xmm1
	movzx	edx, r11b
	movzx	ecx, bh
	lea	ebx, -1[rax]
	test	esi, ebx
	je	.Lparse_object_5digit_block_5
.Lparse_object_5digit_block_1:
	vmovdqa	xmm1, XMMWORD PTR constant_2[rip]
	mov	ecx, ecx
	lea	rbx, object_5_header_shuffles[rip]
	vpmovmskb	r11d, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [rbx+rcx*8]
	andn	r11d, r8d, r11d
	vpmaddubsw	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_3[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_5[rip]
	vpshufb	xmm0, xmm0, XMMWORD PTR constant_4[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vpminud	xmm0, xmm0, XMMWORD PTR constant_6[rip]
	vmovdqa	XMMWORD PTR [r10], xmm0
	jne	.Lparse_object_5digit_block_6
.Lparse_object_5digit_block_2:
	cmp	edx, 17
	ja	.Lparse_object_5digit_block_8
.Lparse_object_5digit_block_3:
	cmp	edx, 2
	jbe	.Lparse_object_5digit_block_9
.Lparse_object_5digit_block_4:
	mov	eax, edx
	add	rsp, 40
	pop	rbx
	pop	rsi
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_object_5digit_block_5:
	movzx	r11d, r11b
	cmp	BYTE PTR [r9+r11], 44
	jne	.Lparse_object_5digit_block_10
	add	ecx, 2
	inc	edx
	jmp	.Lparse_object_5digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_object_5digit_block_6:
	tzcnt	eax, eax
	cmp	BYTE PTR [r9], 45
	jne	.Lparse_object_5digit_block_7
	mov	DWORD PTR [r10], 0
.Lparse_object_5digit_block_7:
	inc	eax
	cmp	BYTE PTR [r9+rax], 45
	jne	.Lparse_object_5digit_block_2
	mov	DWORD PTR 4[r10], 0
	jmp	.Lparse_object_5digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_object_5digit_block_8:
	and	edx, 127
	lea	eax, -2[rdx]
	movzx	ecx, BYTE PTR [r9+rax]
	vpextrd	eax, xmm0, 3
	lea	eax, [rax+rax*4]
	and	ecx, 15
	lea	eax, [rcx+rax*2]
	mov	DWORD PTR 12[r10], eax
	jmp	.Lparse_object_5digit_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_object_5digit_block_9:
	mov	rdx, r10
	mov	rcx, r9
	call	defer_object_header
	mov	edx, 1
	jmp	.Lparse_object_5digit_block_4
.Lparse_object_5digit_block_10:
	add	ecx, 4
	add	edx, 130
	jmp	.Lparse_object_5digit_block_1
	.seh_endproc

# parse_object_6digit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_6_time::NO_INLINE_parse_object_6digit_single(char const*, _object_header*)
.section .text$parse_object_6digit,"x"
.p2align 4
.globl parse_object_6digit
.def parse_object_6digit; .scl 2; .type 32; .endef
	.seh_proc	parse_object_6digit
parse_object_6digit:
.Lparse_object_6digit_block_0:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	eax, 741092396
	vmovd	xmm1, eax
	vpbroadcastd	xmm1, xmm1
	vmovdqu	xmm0, XMMWORD PTR [rcx]
	mov	r9, rdx
	mov	r8, rcx
	vpcmpeqb	xmm1, xmm0, xmm1
	vpmovmskb	r10d, xmm1
	movzx	r11d, r10b
	mov	edx, r11d
	sal	edx, 7
	and	edx, r10d
	je	.Lparse_object_6digit_block_4
	mov	eax, -791621424
	lea	rdx, object_6_coordinate_shuffles[rip]
	vmovd	xmm1, eax
	lea	eax, 54[r11]
	movzx	eax, WORD PTR [rdx+rax]
	vpbroadcastd	xmm1, xmm1
	vpaddb	xmm0, xmm0, xmm1
	movzx	edx, al
	movzx	ecx, ah
	movzx	eax, al
	cmp	BYTE PTR -1[r8+rax], 44
	jne	.Lparse_object_6digit_block_5
.Lparse_object_6digit_block_1:
	vmovdqa	xmm1, XMMWORD PTR constant_9[rip]
	mov	ecx, ecx
	lea	rbx, object_6_header_shuffles[rip]
	vpmovmskb	eax, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [rbx+rcx*8]
	andn	eax, r10d, eax
	vpmaddubsw	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_10[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_11[rip]
	vpshufb	xmm0, xmm0, XMMWORD PTR constant_4[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vpminud	xmm0, xmm0, XMMWORD PTR constant_6[rip]
	vmovdqa	XMMWORD PTR [r9], xmm0
	jne	.Lparse_object_6digit_block_6
.Lparse_object_6digit_block_2:
	cmp	edx, 17
	ja	.Lparse_object_6digit_block_8
.Lparse_object_6digit_block_3:
	cmp	edx, 2
	jbe	.Lparse_object_6digit_block_9
.Lparse_object_6digit_block_4:
	mov	eax, edx
	add	rsp, 32
	pop	rbx
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_object_6digit_block_5:
	cmp	BYTE PTR [r8+rax], 44
	jne	.Lparse_object_6digit_block_10
	add	ecx, 2
	inc	edx
	jmp	.Lparse_object_6digit_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_object_6digit_block_6:
	xor	eax, eax
	tzcnt	eax, r11d
	cmp	BYTE PTR [r8], 45
	jne	.Lparse_object_6digit_block_7
	mov	DWORD PTR [r9], 0
.Lparse_object_6digit_block_7:
	inc	eax
	cmp	BYTE PTR [r8+rax], 45
	jne	.Lparse_object_6digit_block_2
	mov	DWORD PTR 4[r9], 0
	jmp	.Lparse_object_6digit_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_object_6digit_block_8:
	vpextrd	eax, xmm0, 3
	cmp	edx, 18
	jne	.Lparse_object_6digit_block_11
	movzx	ecx, BYTE PTR 16[r8]
	lea	eax, [rax+rax*4]
	and	ecx, 15
	lea	eax, [rcx+rax*2]
	mov	DWORD PTR 12[r9], eax
	jmp	.Lparse_object_6digit_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_object_6digit_block_9:
	mov	rdx, r9
	mov	rcx, r8
	call	defer_object_header
	mov	edx, 1
	jmp	.Lparse_object_6digit_block_4
.Lparse_object_6digit_block_10:
	add	ecx, 4
	add	edx, 130
	jmp	.Lparse_object_6digit_block_1
.Lparse_object_6digit_block_11:
	and	edx, 127
	imul	eax, eax, 100
	mov	ecx, edx
	movzx	ecx, WORD PTR -3[r8+rcx]
	mov	r10d, ecx
	shr	cx, 8
	and	r10d, 15
	and	ecx, 15
	lea	r10d, [r10+r10*4]
	lea	ecx, [rcx+r10*2]
	add	eax, ecx
	mov	DWORD PTR 12[r9], eax
	jmp	.Lparse_object_6digit_block_3
	.seh_endproc
