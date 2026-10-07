.intel_syntax noprefix

# parse_timing_points_v14
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: char const** parse_timing_points<true>(_memory_region_header*, char const**, char const**)
.section .text$parse_timing_points_v14,"x"
.p2align 4
.globl parse_timing_points_v14
.def parse_timing_points_v14; .scl 2; .type 32; .endef
	.seh_proc	parse_timing_points_v14
parse_timing_points_v14:
.Lparse_timing_points_v14_block_0:
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
	vmovaps	XMMWORD PTR 16[rsp], xmm6
	.seh_savexmm	xmm6, 16
	vmovaps	XMMWORD PTR 32[rsp], xmm7
	.seh_savexmm	xmm7, 32
	vmovaps	XMMWORD PTR 48[rsp], xmm8
	.seh_savexmm	xmm8, 48
	.seh_endprologue
	mov	r9, rdx
	cmp	rdx, r8
	je	.Lparse_timing_points_v14_block_18
	mov	eax, 2147483648
	mov	QWORD PTR 144[rsp], rcx
	vmovsd	xmm1, QWORD PTR constant_24[rip]
	vxorps	xmm6, xmm6, xmm6
	lea	rsi, [rcx+rax]
	vmovdqa	xmm5, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm4, XMMWORD PTR constant_16[rip]
	xor	edi, edi
	mov	QWORD PTR 8[rsp], rsi
	vmovdqa	xmm3, XMMWORD PTR constant_17[rip]
	mov	r11, rsi
	mov	edx, 8
	vxorpd	xmm2, xmm2, xmm2
	lea	r13, decimal_shuffles[rip]
	lea	r12, decimal_powers[rip]
	movabs	rbp, 7307761438757046363
	movabs	r15, 1085102592571150095
	movabs	r14, 71777214294589695
	jmp	.Lparse_timing_points_v14_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_1:
	cmp	rcx, rbp
	je	.Lparse_timing_points_v14_block_17
	cmp	cl, 45
	je	.Lparse_timing_points_v14_block_13
.Lparse_timing_points_v14_block_2:
	add	r9, 8
	cmp	r8, r9
	je	.Lparse_timing_points_v14_block_10
.Lparse_timing_points_v14_block_3:
	mov	rax, QWORD PTR [r9]
	movzx	esi, BYTE PTR [rax]
	mov	rcx, QWORD PTR [rax]
	lea	r10d, -48[rsi]
	cmp	r10b, 9
	ja	.Lparse_timing_points_v14_block_1
	jmp	.Lparse_timing_points_v14_block_5
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_4:
	shrx	r10, rcx, rdx
	cmp	r10b, 44
	je	.Lparse_timing_points_v14_block_12
	add	edx, 8
.Lparse_timing_points_v14_block_5:
	cmp	edx, 64
	jne	.Lparse_timing_points_v14_block_4
	mov	r10d, 9
.Lparse_timing_points_v14_block_6:
	add	rax, r10
	mov	r10, QWORD PTR [rax]
	cmp	r10, rdi
	je	.Lparse_timing_points_v14_block_2
	mov	ebx, edx
	mov	rdi, r10
	neg	ebx
	shlx	rcx, rcx, rbx
	and	rcx, r15
	movabs	rbx, 281470681808895
	imul	rcx, rcx, 2561
	shr	rcx, 8
	and	rcx, r14
	imul	rcx, rcx, 6553601
	shr	rcx, 16
	and	rbx, rcx
	movabs	rcx, 42949672960001
	imul	rcx, rbx
	shr	rcx, 32
.Lparse_timing_points_v14_block_7:
	movzx	esi, BYTE PTR [rax]
	mov	DWORD PTR 16[r11], ecx
	cmp	sil, 45
	sete	cl
	sete	r10b
	movzx	ecx, cl
	sal	ecx, 3
	shrx	rcx, rdi, rcx
	cmp	ecx, 741355569
	je	.Lparse_timing_points_v14_block_16
	movzx	r10d, r10b
	mov	ebx, 774778414
	vmovdqu	xmm7, XMMWORD PTR [rax+r10]
	mov	eax, -791621424
	vmovd	xmm8, ebx
	vmovd	xmm0, eax
	vpbroadcastd	xmm8, xmm8
	vpbroadcastd	xmm0, xmm0
	vpaddb	xmm0, xmm7, xmm0
	vpcmpeqb	xmm7, xmm7, xmm8
	vpmovmskb	eax, xmm0
	vpmovmskb	ecx, xmm7
	andn	eax, ecx, eax
	or	eax, 65536
	tzcnt	eax, eax
	bts	ecx, eax
	mov	r10d, eax
	tzcnt	ecx, ecx
	sal	r10d, 4
	add	r10d, ecx
	mov	r10d, r10d
	sal	r10, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR 0[r13+r10]
	vpmaddubsw	xmm0, xmm0, xmm5
	vpmaddwd	xmm0, xmm0, xmm4
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm3
	vmovq	r10, xmm0
	mov	ebx, r10d
	shr	r10, 32
	imul	rbx, rbx, 100000000
	add	rbx, r10
	cmp	ecx, eax
	sbb	eax, ecx
	vcvtsi2sd	xmm0, xmm6, rbx
	vmulsd	xmm0, xmm0, QWORD PTR [r12+rax*8]
.Lparse_timing_points_v14_block_8:
	vmovapd	xmm7, xmm0
	cmp	sil, 45
	jne	.Lparse_timing_points_v14_block_9
	vmulsd	xmm0, xmm0, QWORD PTR constant_27[rip]
	vmulsd	xmm7, xmm0, xmm2
	vmovapd	xmm0, xmm2
.Lparse_timing_points_v14_block_9:
	vucomisd	xmm7, xmm1
	vmovddup	xmm2, xmm7
	vmovapd	xmm1, xmm7
	mov	ecx, 1
	vmovupd	XMMWORD PTR [r11], xmm2
	vmovapd	xmm2, xmm0
	setp	al
	cmovne	eax, ecx
	add	r9, 8
	sal	rax, 63
	sar	rax, 63
	and	eax, 24
	add	r11, rax
	cmp	r8, r9
	jne	.Lparse_timing_points_v14_block_3
.Lparse_timing_points_v14_block_10:
	sub	r11, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 144[rsp]
	mov	rax, r8
	sar	r11, 3
	imul	edx, r11d, -1431655765
.Lparse_timing_points_v14_block_11:
	mov	DWORD PTR 52[rcx], edx
	vmovaps	xmm6, XMMWORD PTR 16[rsp]
	vmovaps	xmm7, XMMWORD PTR 32[rsp]
	vmovaps	xmm8, XMMWORD PTR 48[rsp]
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
.Lparse_timing_points_v14_block_12:
	mov	r10d, edx
	shr	r10d, 3
	inc	r10d
	jmp	.Lparse_timing_points_v14_block_6
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_13:
	add	rax, 2
	jmp	.Lparse_timing_points_v14_block_15
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_14:
	inc	rax
	test	rcx, rcx
	je	.Lparse_timing_points_v14_block_7
.Lparse_timing_points_v14_block_15:
	shr	rcx, 8
	cmp	cl, 44
	jne	.Lparse_timing_points_v14_block_14
	xor	ecx, ecx
	jmp	.Lparse_timing_points_v14_block_7
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_16:
	vmovsd	xmm0, QWORD PTR constant_26[rip]
	jmp	.Lparse_timing_points_v14_block_8
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_v14_block_17:
	sub	r11, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 144[rsp]
	mov	rax, r9
	sar	r11, 3
	imul	edx, r11d, -1431655765
	jmp	.Lparse_timing_points_v14_block_11
.Lparse_timing_points_v14_block_18:
	mov	rax, rdx
	xor	edx, edx
	jmp	.Lparse_timing_points_v14_block_11
	.seh_endproc

# parse_timing_points_legacy
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: char const** parse_timing_points<false>(_memory_region_header*, char const**, char const**)
.section .text$parse_timing_points_legacy,"x"
.p2align 4
.globl parse_timing_points_legacy
.def parse_timing_points_legacy; .scl 2; .type 32; .endef
	.seh_proc	parse_timing_points_legacy
parse_timing_points_legacy:
.Lparse_timing_points_legacy_block_0:
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
	sub	rsp, 88
	.seh_stackalloc	88
	vmovaps	XMMWORD PTR 16[rsp], xmm6
	.seh_savexmm	xmm6, 16
	vmovaps	XMMWORD PTR 32[rsp], xmm7
	.seh_savexmm	xmm7, 32
	vmovaps	XMMWORD PTR 48[rsp], xmm8
	.seh_savexmm	xmm8, 48
	vmovaps	XMMWORD PTR 64[rsp], xmm9
	.seh_savexmm	xmm9, 64
	.seh_endprologue
	mov	r9, rdx
	cmp	rdx, r8
	je	.Lparse_timing_points_legacy_block_18
	vmovsd	xmm1, QWORD PTR constant_24[rip]
	mov	eax, 2147483648
	mov	QWORD PTR 160[rsp], rcx
	vxorps	xmm7, xmm7, xmm7
	lea	rsi, [rcx+rax]
	vmovdqa	xmm6, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm5, XMMWORD PTR constant_16[rip]
	xor	edi, edi
	mov	QWORD PTR 8[rsp], rsi
	vmovdqa	xmm4, XMMWORD PTR constant_17[rip]
	mov	r11, rsi
	vmovapd	xmm2, xmm1
	mov	edx, 8
	vxorpd	xmm3, xmm3, xmm3
	lea	r13, decimal_shuffles[rip]
	movabs	rbp, 7307761438757046363
	lea	r12, decimal_powers[rip]
	movabs	r15, 1085102592571150095
	movabs	r14, 71777214294589695
	jmp	.Lparse_timing_points_legacy_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_1:
	cmp	rcx, rbp
	je	.Lparse_timing_points_legacy_block_17
	cmp	cl, 45
	je	.Lparse_timing_points_legacy_block_13
.Lparse_timing_points_legacy_block_2:
	add	r9, 8
	cmp	r8, r9
	je	.Lparse_timing_points_legacy_block_10
.Lparse_timing_points_legacy_block_3:
	mov	rax, QWORD PTR [r9]
	movzx	esi, BYTE PTR [rax]
	mov	rcx, QWORD PTR [rax]
	lea	r10d, -48[rsi]
	cmp	r10b, 9
	ja	.Lparse_timing_points_legacy_block_1
	jmp	.Lparse_timing_points_legacy_block_5
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_4:
	shrx	r10, rcx, rdx
	cmp	r10b, 44
	je	.Lparse_timing_points_legacy_block_12
	add	edx, 8
.Lparse_timing_points_legacy_block_5:
	cmp	edx, 64
	jne	.Lparse_timing_points_legacy_block_4
	mov	r10d, 9
.Lparse_timing_points_legacy_block_6:
	add	rax, r10
	mov	r10, QWORD PTR [rax]
	cmp	r10, rdi
	je	.Lparse_timing_points_legacy_block_2
	mov	ebx, edx
	mov	rdi, r10
	neg	ebx
	shlx	rcx, rcx, rbx
	and	rcx, r15
	movabs	rbx, 281470681808895
	imul	rcx, rcx, 2561
	shr	rcx, 8
	and	rcx, r14
	imul	rcx, rcx, 6553601
	shr	rcx, 16
	and	rbx, rcx
	movabs	rcx, 42949672960001
	imul	rcx, rbx
	shr	rcx, 32
.Lparse_timing_points_legacy_block_7:
	movzx	esi, BYTE PTR [rax]
	mov	DWORD PTR 16[r11], ecx
	cmp	sil, 45
	sete	cl
	sete	r10b
	movzx	ecx, cl
	sal	ecx, 3
	shrx	rcx, rdi, rcx
	cmp	ecx, 741355569
	je	.Lparse_timing_points_legacy_block_16
	movzx	r10d, r10b
	mov	ebx, 774778414
	vmovdqu	xmm8, XMMWORD PTR [rax+r10]
	mov	eax, -791621424
	vmovd	xmm9, ebx
	vmovd	xmm0, eax
	vpbroadcastd	xmm9, xmm9
	vpbroadcastd	xmm0, xmm0
	vpaddb	xmm0, xmm8, xmm0
	vpcmpeqb	xmm8, xmm8, xmm9
	vpmovmskb	eax, xmm0
	vpmovmskb	ecx, xmm8
	andn	eax, ecx, eax
	or	eax, 65536
	tzcnt	eax, eax
	bts	ecx, eax
	mov	r10d, eax
	tzcnt	ecx, ecx
	sal	r10d, 4
	add	r10d, ecx
	mov	r10d, r10d
	sal	r10, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR 0[r13+r10]
	vpmaddubsw	xmm0, xmm0, xmm6
	vpmaddwd	xmm0, xmm0, xmm5
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm4
	vmovq	r10, xmm0
	mov	ebx, r10d
	shr	r10, 32
	imul	rbx, rbx, 100000000
	add	rbx, r10
	cmp	ecx, eax
	sbb	eax, ecx
	vcvtsi2sd	xmm0, xmm7, rbx
	vmulsd	xmm0, xmm0, QWORD PTR [r12+rax*8]
.Lparse_timing_points_legacy_block_8:
	vmovapd	xmm8, xmm0
	cmp	sil, 45
	jne	.Lparse_timing_points_legacy_block_9
	vmulsd	xmm0, xmm0, QWORD PTR constant_27[rip]
	vmulsd	xmm8, xmm0, xmm3
	vmovapd	xmm0, xmm3
.Lparse_timing_points_legacy_block_9:
	vucomisd	xmm8, xmm2
	mov	r10d, 1
	vmovsd	QWORD PTR [r11], xmm8
	vmovapd	xmm2, xmm8
	vmovsd	QWORD PTR 8[r11], xmm0
	vmovapd	xmm3, xmm0
	setp	al
	cmovne	eax, r10d
	vucomisd	xmm0, xmm1
	vmovapd	xmm1, xmm0
	setp	cl
	cmovne	ecx, r10d
	add	r9, 8
	or	eax, ecx
	movzx	eax, al
	neg	rax
	and	eax, 24
	add	r11, rax
	cmp	r8, r9
	jne	.Lparse_timing_points_legacy_block_3
.Lparse_timing_points_legacy_block_10:
	sub	r11, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 160[rsp]
	mov	rax, r8
	sar	r11, 3
	imul	edx, r11d, -1431655765
.Lparse_timing_points_legacy_block_11:
	mov	DWORD PTR 52[rcx], edx
	vmovaps	xmm6, XMMWORD PTR 16[rsp]
	vmovaps	xmm7, XMMWORD PTR 32[rsp]
	vmovaps	xmm8, XMMWORD PTR 48[rsp]
	vmovaps	xmm9, XMMWORD PTR 64[rsp]
	add	rsp, 88
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
.Lparse_timing_points_legacy_block_12:
	mov	r10d, edx
	shr	r10d, 3
	inc	r10d
	jmp	.Lparse_timing_points_legacy_block_6
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_13:
	add	rax, 2
	jmp	.Lparse_timing_points_legacy_block_15
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_14:
	inc	rax
	test	rcx, rcx
	je	.Lparse_timing_points_legacy_block_7
.Lparse_timing_points_legacy_block_15:
	shr	rcx, 8
	cmp	cl, 44
	jne	.Lparse_timing_points_legacy_block_14
	xor	ecx, ecx
	jmp	.Lparse_timing_points_legacy_block_7
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_16:
	vmovsd	xmm0, QWORD PTR constant_26[rip]
	jmp	.Lparse_timing_points_legacy_block_8
	.p2align 4,,10
	.p2align 3
.Lparse_timing_points_legacy_block_17:
	sub	r11, QWORD PTR 8[rsp]
	mov	rcx, QWORD PTR 160[rsp]
	mov	rax, r9
	sar	r11, 3
	imul	edx, r11d, -1431655765
	jmp	.Lparse_timing_points_legacy_block_11
.Lparse_timing_points_legacy_block_18:
	mov	rax, rdx
	xor	edx, edx
	jmp	.Lparse_timing_points_legacy_block_11
	.seh_endproc

# parse_beatmap_header
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_beatmap_header(_memory_region_header*, char const**, char const**)
.section .text$parse_beatmap_header,"x"
.p2align 4
.globl parse_beatmap_header
.def parse_beatmap_header; .scl 2; .type 32; .endef
	.seh_proc	parse_beatmap_header
parse_beatmap_header:
.Lparse_beatmap_header_block_0:
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
	sub	rsp, 80
	.seh_stackalloc	80
	vmovaps	XMMWORD PTR [rsp], xmm6
	.seh_savexmm	xmm6, 0
	vmovaps	XMMWORD PTR 16[rsp], xmm7
	.seh_savexmm	xmm7, 16
	vmovaps	XMMWORD PTR 32[rsp], xmm8
	.seh_savexmm	xmm8, 32
	vmovaps	XMMWORD PTR 48[rsp], xmm9
	.seh_savexmm	xmm9, 48
	vmovaps	XMMWORD PTR 64[rsp], xmm10
	.seh_savexmm	xmm10, 64
	.seh_endprologue
	mov	r11, rcx
	cmp	rdx, r8
	je	.Lparse_beatmap_header_block_25
	mov	rcx, QWORD PTR [rdx]
	mov	rax, QWORD PTR [rcx]
	test	rax, rax
	jne	.Lparse_beatmap_header_block_2
	jmp	.Lparse_beatmap_header_block_26
	.p2align 4
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_1:
	inc	rcx
	shr	rax, 8
	je	.Lparse_beatmap_header_block_3
.Lparse_beatmap_header_block_2:
	cmp	al, 111
	jne	.Lparse_beatmap_header_block_1
.Lparse_beatmap_header_block_3:
	movabs	rax, 7308332182667621231
	cmp	QWORD PTR [rcx], rax
	jne	.Lparse_beatmap_header_block_26
	mov	eax, DWORD PTR 17[rcx]
	movzx	ecx, ah
	movzx	edi, al
	sub	ecx, 48
	sub	edi, 48
	cmp	ecx, 9
	ja	.Lparse_beatmap_header_block_4
	shr	eax, 16
	movzx	eax, al
	sub	eax, 48
	cmp	eax, 9
	ja	.Lparse_beatmap_header_block_24
	imul	edi, edi, 100
	add	edi, eax
	lea	eax, [rcx+rcx*4]
	lea	edi, [rdi+rax*2]
.Lparse_beatmap_header_block_4:
	vmovapd	xmm0, XMMWORD PTR constant_28[rip]
	add	rdx, 32
	vmovsd	xmm3, QWORD PTR constant_24[rip]
	mov	DWORD PTR 72[r11], edi
	cmp	r8, rdx
	mov	rax, QWORD PTR constant_29[rip]
	mov	DWORD PTR 144[r11], 0
	vmovupd	XMMWORD PTR 80[r11], xmm0
	cmovbe	rdx, r8
	vmovapd	xmm0, XMMWORD PTR constant_30[rip]
	mov	QWORD PTR 112[r11], rax
	vmovsd	QWORD PTR 96[r11], xmm3
	vmovupd	XMMWORD PTR 128[r11], xmm0
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_9
	mov	eax, 774778414
	vmovdqa	xmm7, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm6, XMMWORD PTR constant_16[rip]
	vxorps	xmm1, xmm1, xmm1
	vmovd	xmm2, eax
	mov	eax, -791621424
	vmovdqa	xmm5, XMMWORD PTR constant_17[rip]
	movabs	r10, 7954848340932392019
	vmovd	xmm4, eax
	vpbroadcastd	xmm2, xmm2
	lea	rsi, decimal_shuffles[rip]
	vpbroadcastd	xmm4, xmm4
	vmovdqa	xmm8, xmm2
	lea	rbx, decimal_powers[rip]
	vmovdqa	xmm9, xmm4
	jmp	.Lparse_beatmap_header_block_7
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_5:
	cmp	rax, r10
	jne	.Lparse_beatmap_header_block_6
	movzx	eax, BYTE PTR 14[rcx]
	sub	eax, 48
	cmp	al, 9
	seta	al
	movzx	eax, al
	vmovdqu	xmm10, XMMWORD PTR 14[rcx+rax]
	vpaddb	xmm0, xmm10, xmm9
	vpcmpeqb	xmm10, xmm10, xmm8
	vpmovmskb	ecx, xmm0
	vpmovmskb	r9d, xmm10
	andn	ecx, r9d, ecx
	or	ecx, 65536
	tzcnt	ecx, ecx
	bts	r9d, ecx
	mov	eax, ecx
	tzcnt	r9d, r9d
	sal	eax, 4
	add	eax, r9d
	mov	eax, eax
	sal	rax, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR [rsi+rax]
	vpmaddubsw	xmm0, xmm0, xmm7
	vpmaddwd	xmm0, xmm0, xmm6
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm5
	vmovq	rax, xmm0
	mov	ebp, eax
	shr	rax, 32
	imul	rbp, rbp, 100000000
	add	rax, rbp
	cmp	r9d, ecx
	sbb	ecx, r9d
	vcvtsi2sd	xmm0, xmm1, rax
	vmulsd	xmm0, xmm0, QWORD PTR [rbx+rcx*8]
	vmovsd	QWORD PTR 88[r11], xmm0
.Lparse_beatmap_header_block_6:
	add	rdx, 8
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_9
.Lparse_beatmap_header_block_7:
	mov	rcx, QWORD PTR [rdx]
	mov	rax, QWORD PTR [rcx]
	cmp	al, 91
	je	.Lparse_beatmap_header_block_12
	mov	r9, rax
	shr	r9, 8
	cmp	r9d, 979723375
	jne	.Lparse_beatmap_header_block_5
	movzx	eax, BYTE PTR 5[rcx]
	sub	eax, 48
	cmp	al, 9
	jbe	.Lparse_beatmap_header_block_8
	movzx	eax, BYTE PTR 6[rcx]
	sub	eax, 48
.Lparse_beatmap_header_block_8:
	movzx	eax, al
	add	rdx, 8
	mov	DWORD PTR 144[r11], eax
	cmp	r8, rdx
	jne	.Lparse_beatmap_header_block_7
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_9:
	vmovsd	xmm0, QWORD PTR 136[r11]
	vmovsd	QWORD PTR 96[r11], xmm0
.Lparse_beatmap_header_block_10:
	mov	rcx, r11
	cmp	edi, 7
	ja	.Lparse_beatmap_header_block_22
.Lparse_beatmap_header_block_11:
	vmovaps	xmm6, XMMWORD PTR [rsp]
	vmovaps	xmm7, XMMWORD PTR 16[rsp]
	vmovaps	xmm8, XMMWORD PTR 32[rsp]
	vmovaps	xmm9, XMMWORD PTR 48[rsp]
	vmovaps	xmm10, XMMWORD PTR 64[rsp]
	add	rsp, 80
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	jmp	parse_timing_points_v14
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_12:
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_9
	mov	rax, QWORD PTR [rdx]
	movabs	rcx, 8458720413657678939
	add	rdx, 8
	cmp	QWORD PTR [rax], rcx
	je	.Lparse_beatmap_header_block_14
.Lparse_beatmap_header_block_13:
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_9
	mov	rax, QWORD PTR [rdx]
	add	rdx, 8
	cmp	QWORD PTR [rax], rcx
	jne	.Lparse_beatmap_header_block_13
.Lparse_beatmap_header_block_14:
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_9
	vmovdqa	xmm7, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm6, XMMWORD PTR constant_16[rip]
	movabs	rbx, 6733853885346497883
	movabs	rsi, 5793720844721673307
	vmovdqa	xmm5, XMMWORD PTR constant_17[rip]
	lea	rbp, header_key_validation[rip]
	lea	r13, decimal_shuffles[rip]
	lea	r12, decimal_powers[rip]
	jmp	.Lparse_beatmap_header_block_17
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_15:
	cmp	rax, rsi
	je	.Lparse_beatmap_header_block_23
	imul	r10, rax, 157206
	shr	r10, 61
	mov	r9, r10
	cmp	rax, QWORD PTR 0[rbp+r10*8]
	jne	.Lparse_beatmap_header_block_16
	lea	rcx, 11[rcx+r10]
	movzx	eax, BYTE PTR [rcx]
	sub	eax, 48
	cmp	al, 9
	seta	al
	movzx	eax, al
	vmovdqu	xmm8, XMMWORD PTR [rcx+rax]
	vpaddb	xmm0, xmm8, xmm4
	vpcmpeqb	xmm8, xmm8, xmm2
	vpmovmskb	ecx, xmm0
	vpmovmskb	r10d, xmm8
	andn	ecx, r10d, ecx
	or	ecx, 65536
	tzcnt	ecx, ecx
	bts	r10d, ecx
	mov	eax, ecx
	tzcnt	r10d, r10d
	sal	eax, 4
	add	eax, r10d
	mov	eax, eax
	sal	rax, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR 0[r13+rax]
	vpmaddubsw	xmm0, xmm0, xmm7
	vpmaddwd	xmm0, xmm0, xmm6
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm5
	vmovq	rax, xmm0
	mov	r14d, eax
	shr	rax, 32
	imul	r14, r14, 100000000
	add	rax, r14
	cmp	r10d, ecx
	sbb	ecx, r10d
	vcvtsi2sd	xmm0, xmm1, rax
	vmulsd	xmm0, xmm0, QWORD PTR [r12+rcx*8]
	vmovsd	QWORD PTR 80[r11+r9*8], xmm0
.Lparse_beatmap_header_block_16:
	add	rdx, 8
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_18
.Lparse_beatmap_header_block_17:
	mov	rcx, QWORD PTR [rdx]
	mov	rax, QWORD PTR [rcx]
	cmp	rax, rbx
	jne	.Lparse_beatmap_header_block_15
	add	rdx, 8
.Lparse_beatmap_header_block_18:
	cmp	r8, rdx
	je	.Lparse_beatmap_header_block_20
	movabs	rcx, 5793720844721673307
.Lparse_beatmap_header_block_19:
	mov	rax, QWORD PTR [rdx]
	add	rdx, 8
	cmp	QWORD PTR [rax], rcx
	je	.Lparse_beatmap_header_block_20
	cmp	r8, rdx
	jne	.Lparse_beatmap_header_block_19
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_20:
	vmovsd	xmm0, QWORD PTR 96[r11]
.Lparse_beatmap_header_block_21:
	vucomisd	xmm0, xmm3
	jp	.Lparse_beatmap_header_block_10
	je	.Lparse_beatmap_header_block_9
	mov	rcx, r11
	cmp	edi, 7
	jbe	.Lparse_beatmap_header_block_11
.Lparse_beatmap_header_block_22:
	vmovaps	xmm6, XMMWORD PTR [rsp]
	vmovaps	xmm7, XMMWORD PTR 16[rsp]
	vmovaps	xmm8, XMMWORD PTR 32[rsp]
	vmovaps	xmm9, XMMWORD PTR 48[rsp]
	vmovaps	xmm10, XMMWORD PTR 64[rsp]
	add	rsp, 80
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	jmp	parse_timing_points_legacy
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_23:
	vmovsd	xmm0, QWORD PTR 96[r11]
	add	rdx, 8
	jmp	.Lparse_beatmap_header_block_21
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_24:
	lea	eax, [rdi+rdi*4]
	lea	edi, [rcx+rax*2]
	jmp	.Lparse_beatmap_header_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_25:
	vmovaps	xmm6, XMMWORD PTR [rsp]
	vmovaps	xmm7, XMMWORD PTR 16[rsp]
	mov	rax, rdx
	vmovaps	xmm8, XMMWORD PTR 32[rsp]
	vmovaps	xmm9, XMMWORD PTR 48[rsp]
	vmovaps	xmm10, XMMWORD PTR 64[rsp]
	add	rsp, 80
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_header_block_26:
	mov	edi, 14
	jmp	.Lparse_beatmap_header_block_4
	.seh_endproc
