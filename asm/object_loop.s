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

# parse_objects_5digit_context
# Internal context: RBP lines, R15 headers, R14 bodies, R12 deferrals, advanced
# in place. Preserves RDI, XMM6 (comma), XMM8 (digit offset), XMM9
# (result shuffle), XMM10 (line end); clobbers RAX/RCX/RDX/R8-R11/RBX/R13/RSI
# and YMM0-YMM5 plus upper YMM6/YMM8/YMM9 halves.
# Only the 40-byte outgoing Windows call frame is allocated.
# Source: Parse objects using 5-digit timestamps; see internal context above.
.section .text$parse_objects_5digit_context,"x"
.p2align 4
.globl parse_objects_5digit_context
.def parse_objects_5digit_context; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_5digit_context
parse_objects_5digit_context:
.Lparse_objects_5digit_context_block_0:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	mov	rbx, QWORD PTR [rbp]
	test	rbx, rbx
	je	.Lparse_objects_5digit_context_block_14
	vbroadcasti128	ymm4, XMMWORD PTR constant_2[rip]
	lea	r13, object_5_coordinate_shuffles[rip]
	lea	rsi, object_5_header_shuffles[rip]
	vbroadcasti128	ymm3, XMMWORD PTR constant_3[rip]
	vbroadcasti128	ymm2, XMMWORD PTR constant_5[rip]
	vbroadcasti128	ymm5, XMMWORD PTR constant_6[rip]
	# Upper YMM halves are volatile; retain the caller's low XMM halves.
	vinserti128	ymm6, ymm6, xmm6, 1
	vinserti128	ymm8, ymm8, xmm8, 1
	vinserti128	ymm9, ymm9, xmm9, 1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_1:
	# Two padded input lines, one per 128-bit lane. Do not cross a sentinel.
	# Reject either lane before changing any output or context cursor.
	mov	r11, QWORD PTR 8[rbp]
	test	r11, r11
	je	.Lparse_objects_5digit_context_single
	vmovdqu	xmm0, [rbx]
	vinserti128	ymm0, ymm0, [r11], 1
	vpcmpeqb	ymm1, ymm0, ymm6
	vpmovmskb	r10d, ymm1
	lea r9, sweep_header_5[rip]
	movzx eax, r10w
	movzx edx, WORD PTR [r9+rax*2]
	test edx, edx
	je .Lparse_objects_5digit_context_single
	mov eax, r10d
	shr eax, 16
	movzx r8d, WORD PTR [r9+rax*2]
	test r8d, r8d
	je .Lparse_objects_5digit_context_single
	# Signed coordinates and other negative byte offsets use the single path.
	vpaddb	ymm0, ymm0, ymm8
	vpmovmskb	r9d, ymm0
	andn	r9d, r10d, r9d
	jne	.Lparse_objects_5digit_context_single
	mov	r9d, edx
	shr	r9d, 8
	mov	r10d, r8d
	shr	r10d, 8
	vmovdqu	xmm1, [rsi+r9*8]
	vinserti128	ymm1, ymm1, [rsi+r10*8], 1
	# Same conversion/clamping as the single path, in two independent lanes.
	vpshufb	ymm0, ymm0, ymm1
	vpmaddubsw	ymm0, ymm0, ymm4
	vpmaddwd	ymm0, ymm0, ymm3
	vpshufb	ymm0, ymm0, ymm9
	vpmaddwd	ymm0, ymm0, ymm2
	vpminud	ymm0, ymm0, ymm5
	vmovdqu	[r15], ymm0
	movzx	edx, dl
	movzx	r8d, r8b
	add	rdx, rbx
	add	r8, r11
	# For a single decimal type digit, ASCII bit 1 is the parsed slider bit.
	# Queue decisions need not wait for SIMD conversion or reload its store.
	# Preserve the original speculative deferral writes and their ordering.
	movzx	eax, BYTE PTR -2[rdx]
	shl	eax, 3
	and	eax, 16
	mov	[r12], rdx
	mov	8[r12], r14
	add	r12, rax
	add	r14, 32
	movzx	eax, BYTE PTR -2[r8]
	shl	eax, 3
	and	eax, 16
	mov	[r12], r8
	mov	8[r12], r14
	add	r12, rax
	add	r14, 32
	add	r15, 32
	add	rbp, 16
	mov	rbx, [rbp]
	test	rbx, rbx
	jne	.Lparse_objects_5digit_context_block_1
	jmp	.Lparse_objects_5digit_context_block_5
.Lparse_objects_5digit_context_single:
	# Original decoder handles odd tails, width transitions and slow shapes.
	vmovdqu	xmm0, XMMWORD PTR [rbx]
	vpcmpeqb	xmm1, xmm0, xmm6
	vpmovmskb	eax, xmm1
	movzx	ecx, al
	mov	edx, ecx
	sal	edx, 6
	test	edx, eax
	je	.Lparse_objects_5digit_context_block_5
	lea	edx, 54[rcx]
	lea	r10d, -1[rcx]
	mov	r11d, eax
	movzx	r9d, WORD PTR [r13+rdx]
	shr	r11d, 8
	mov	r8d, r9d
	vpaddb	xmm0, xmm0, xmm8
	movzx	edx, r9b
	shr	r8d, 8
	test	r11d, r10d
	je	.Lparse_objects_5digit_context_block_11
.Lparse_objects_5digit_context_block_2:
	vpmovmskb	r9d, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [rsi+r8*8]
	andn	r9d, eax, r9d
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpshufb	xmm0, xmm0, xmm9
	vpmaddwd	xmm0, xmm0, xmm2
	vpminud	xmm0, xmm0, xmm5
	vmovdqa	XMMWORD PTR 0[r15], xmm0
	jne	.Lparse_objects_5digit_context_block_9
.Lparse_objects_5digit_context_block_3:
	cmp	edx, 17
	ja	.Lparse_objects_5digit_context_block_8
.Lparse_objects_5digit_context_block_4:
	cmp	edx, 2
	jbe	.Lparse_objects_5digit_context_block_7
	mov	eax, DWORD PTR 12[r15]
	add	rbp, 8
	add	rdx, rbx
	mov	rbx, QWORD PTR [rbp]
	sal	eax, 3
	mov	QWORD PTR [r12], rdx
	and	eax, 16
	mov	QWORD PTR 8[r12], r14
	add	r12, rax
	add	r15, 16
	add	r14, 32
	test	rbx, rbx
	jne	.Lparse_objects_5digit_context_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_5:
.Lparse_objects_5digit_context_block_6:
	add	rsp, 40
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_7:
	mov	rcx, rbx
	mov	rdx, r15
	inc	rbx
	add	rbp, 8
	call	defer_object_header
	# Upper YMM halves are volatile; retain the caller's low XMM halves.
	vinserti128	ymm6, ymm6, xmm6, 1
	vinserti128	ymm8, ymm8, xmm8, 1
	vinserti128	ymm9, ymm9, xmm9, 1
	mov	eax, DWORD PTR 12[r15]
	sal	eax, 3
	mov	QWORD PTR [r12], rbx
	mov	rbx, QWORD PTR [rbp]
	and	eax, 16
	mov	QWORD PTR 8[r12], r14
	add	r12, rax
	add	r15, 16
	add	r14, 32
	test	rbx, rbx
	je	.Lparse_objects_5digit_context_block_5
	vbroadcasti128	ymm4, XMMWORD PTR constant_2[rip]
	vbroadcasti128	ymm3, XMMWORD PTR constant_3[rip]
	vbroadcasti128	ymm2, XMMWORD PTR constant_5[rip]
	vbroadcasti128	ymm5, XMMWORD PTR constant_6[rip]
	jmp	.Lparse_objects_5digit_context_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_8:
	and	edx, 127
	lea	eax, -2[rdx]
	movzx	ecx, BYTE PTR [rbx+rax]
	vpextrd	eax, xmm0, 3
	lea	eax, [rax+rax*4]
	and	ecx, 15
	lea	eax, [rcx+rax*2]
	mov	DWORD PTR 12[r15], eax
	jmp	.Lparse_objects_5digit_context_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_9:
	tzcnt	ecx, ecx
	cmp	BYTE PTR [rbx], 45
	je	.Lparse_objects_5digit_context_block_12
	lea	eax, 1[rcx]
	cmp	BYTE PTR [rbx+rax], 45
	jne	.Lparse_objects_5digit_context_block_3
.Lparse_objects_5digit_context_block_10:
	mov	DWORD PTR 4[r15], 0
	jmp	.Lparse_objects_5digit_context_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_11:
	movzx	r9d, r9b
	cmp	BYTE PTR [rbx+r9], 44
	jne	.Lparse_objects_5digit_context_block_13
	add	r8d, 2
	inc	edx
	jmp	.Lparse_objects_5digit_context_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_5digit_context_block_12:
	lea	eax, 1[rcx]
	mov	DWORD PTR 0[r15], 0
	cmp	BYTE PTR [rbx+rax], 45
	jne	.Lparse_objects_5digit_context_block_3
	jmp	.Lparse_objects_5digit_context_block_10
.Lparse_objects_5digit_context_block_13:
	add	r8d, 4
	add	edx, 130
	jmp	.Lparse_objects_5digit_context_block_2
.Lparse_objects_5digit_context_block_14:
	xor	eax, eax
	jmp	.Lparse_objects_5digit_context_block_6
	.seh_endproc

# parse_objects_6digit_context
# Internal context: RBP lines, R15 headers, R14 bodies, R12 deferrals, advanced
# in place. Preserves RDI, XMM6 (comma), XMM8 (digit offset), XMM9
# (result shuffle), XMM10 (line end); clobbers RAX/RCX/RDX/R8-R11/RBX/R13/RSI
# and YMM0-YMM5 plus upper YMM6/YMM8/YMM9 halves.
# Only the 40-byte outgoing Windows call frame is allocated.
# Source: Parse objects using 6-digit timestamps; see internal context above.
.section .text$parse_objects_6digit_context,"x"
.p2align 4
.globl parse_objects_6digit_context
.def parse_objects_6digit_context; .scl 2; .type 32; .endef
	.seh_proc	parse_objects_6digit_context
parse_objects_6digit_context:
.Lparse_objects_6digit_context_block_0:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	mov	rbx, QWORD PTR [rbp]
	test	rbx, rbx
	je	.Lparse_objects_6digit_context_block_17
	vbroadcasti128	ymm4, XMMWORD PTR constant_9[rip]
	vbroadcasti128	ymm3, XMMWORD PTR constant_10[rip]
	vbroadcasti128	ymm2, XMMWORD PTR constant_11[rip]
	lea	rsi, object_6_header_shuffles[rip]
	lea	r13, object_6_coordinate_shuffles[rip]
	vbroadcasti128	ymm5, XMMWORD PTR constant_6[rip]
	# Upper YMM halves are volatile; retain the caller's low XMM halves.
	vinserti128	ymm6, ymm6, xmm6, 1
	vinserti128	ymm8, ymm8, xmm8, 1
	vinserti128	ymm9, ymm9, xmm9, 1
	jmp	.Lparse_objects_6digit_context_block_6
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_1:
	lea	eax, 54[r11]
	movzx	eax, WORD PTR [r13+rax]
	vpaddb	xmm0, xmm0, xmm8
	mov	r10d, eax
	shr	r10d, 8
	movzx	edx, al
	movzx	eax, al
	cmp	BYTE PTR -1[rbx+rax], 44
	jne	.Lparse_objects_6digit_context_block_12
.Lparse_objects_6digit_context_block_2:
	vpmovmskb	eax, xmm0
	vpshufb	xmm0, xmm0, XMMWORD PTR [rsi+r10*8]
	andn	eax, ecx, eax
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpshufb	xmm0, xmm0, xmm9
	vpmaddwd	xmm0, xmm0, xmm2
	vpminud	xmm0, xmm0, xmm5
	vmovdqa	XMMWORD PTR [r15], xmm0
	jne	.Lparse_objects_6digit_context_block_10
.Lparse_objects_6digit_context_block_3:
	cmp	edx, 17
	ja	.Lparse_objects_6digit_context_block_9
.Lparse_objects_6digit_context_block_4:
	cmp	edx, 2
	jbe	.Lparse_objects_6digit_context_block_13
	mov	eax, DWORD PTR 12[r15]
.Lparse_objects_6digit_context_block_5:
	add	rbp, 8
	add	rdx, rbx
	sal	eax, 3
	mov	QWORD PTR 8[r12], r14
	mov	rbx, QWORD PTR [rbp]
	and	eax, 16
	mov	QWORD PTR [r12], rdx
	add	r15, 16
	add	r12, rax
	add	r14, 32
	test	rbx, rbx
	je	.Lparse_objects_6digit_context_block_7
.Lparse_objects_6digit_context_block_6:
	# Two padded input lines, one per 128-bit lane. Do not cross a sentinel.
	# Reject either lane before changing any output or context cursor.
	mov	r11, QWORD PTR 8[rbp]
	test	r11, r11
	je	.Lparse_objects_6digit_context_single
	vmovdqu	xmm0, [rbx]
	vinserti128	ymm0, ymm0, [r11], 1
	vpcmpeqb	ymm1, ymm0, ymm6
	vpmovmskb	r10d, ymm1
	lea r9, sweep_header_6[rip]
	movzx eax, r10w
	movzx edx, WORD PTR [r9+rax*2]
	test edx, edx
	je .Lparse_objects_6digit_context_single
	mov eax, r10d
	shr eax, 16
	movzx r8d, WORD PTR [r9+rax*2]
	test r8d, r8d
	je .Lparse_objects_6digit_context_single
	movzx eax, dl
	cmp BYTE PTR -1[rbx+rax], 44
	jne .Lparse_objects_6digit_context_single
	movzx eax, r8b
	cmp BYTE PTR -1[r11+rax], 44
	jne .Lparse_objects_6digit_context_single
	# Signed coordinates and other negative byte offsets use the single path.
	vpaddb	ymm0, ymm0, ymm8
	vpmovmskb	r9d, ymm0
	andn	r9d, r10d, r9d
	jne	.Lparse_objects_6digit_context_single
	mov	r9d, edx
	shr	r9d, 8
	mov	r10d, r8d
	shr	r10d, 8
	vmovdqu	xmm1, [rsi+r9*8]
	vinserti128	ymm1, ymm1, [rsi+r10*8], 1
	# Same conversion/clamping as the single path, in two independent lanes.
	vpshufb	ymm0, ymm0, ymm1
	vpmaddubsw	ymm0, ymm0, ymm4
	vpmaddwd	ymm0, ymm0, ymm3
	vpshufb	ymm0, ymm0, ymm9
	vpmaddwd	ymm0, ymm0, ymm2
	vpminud	ymm0, ymm0, ymm5
	vmovdqu	[r15], ymm0
	movzx	edx, dl
	movzx	r8d, r8b
	add	rdx, rbx
	add	r8, r11
	# For a single decimal type digit, ASCII bit 1 is the parsed slider bit.
	# Queue decisions need not wait for SIMD conversion or reload its store.
	# Preserve the original speculative deferral writes and their ordering.
	movzx	eax, BYTE PTR -2[rdx]
	shl	eax, 3
	and	eax, 16
	mov	[r12], rdx
	mov	8[r12], r14
	add	r12, rax
	add	r14, 32
	movzx	eax, BYTE PTR -2[r8]
	shl	eax, 3
	and	eax, 16
	mov	[r12], r8
	mov	8[r12], r14
	add	r12, rax
	add	r14, 32
	add	r15, 32
	add	rbp, 16
	mov	rbx, [rbp]
	test	rbx, rbx
	jne	.Lparse_objects_6digit_context_block_6
	jmp	.Lparse_objects_6digit_context_block_7
.Lparse_objects_6digit_context_single:
	# Original decoder handles odd tails, width transitions and slow shapes.
	vmovdqu	xmm0, XMMWORD PTR 0[rbx]
	vpcmpeqb	xmm1, xmm0, xmm6
	vpmovmskb	ecx, xmm1
	movzx	r11d, cl
	mov	eax, r11d
	sal	eax, 7
	test	eax, ecx
	jne	.Lparse_objects_6digit_context_block_1
.Lparse_objects_6digit_context_block_7:
.Lparse_objects_6digit_context_block_8:
	add	rsp, 40
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_9:
	vpextrd	eax, xmm0, 3
	cmp	edx, 18
	jne	.Lparse_objects_6digit_context_block_15
	movzx	edx, BYTE PTR 16[rbx]
	lea	eax, [rax+rax*4]
	and	edx, 15
	lea	eax, [rdx+rax*2]
	mov	edx, 18
	mov	DWORD PTR 12[r15], eax
	jmp	.Lparse_objects_6digit_context_block_5
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_10:
	tzcnt	r11d, r11d
	cmp	BYTE PTR 0[rbx], 45
	je	.Lparse_objects_6digit_context_block_14
	lea	eax, 1[r11]
	cmp	BYTE PTR 0[rbx+rax], 45
	jne	.Lparse_objects_6digit_context_block_3
.Lparse_objects_6digit_context_block_11:
	mov	DWORD PTR 4[r15], 0
	jmp	.Lparse_objects_6digit_context_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_12:
	cmp	BYTE PTR 0[rbx+rax], 44
	jne	.Lparse_objects_6digit_context_block_16
	add	r10d, 2
	inc	edx
	jmp	.Lparse_objects_6digit_context_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_13:
	mov	rdx, r15
	mov	rcx, rbx
	call	defer_object_header
	# Upper YMM halves are volatile; retain the caller's low XMM halves.
	vinserti128	ymm6, ymm6, xmm6, 1
	vinserti128	ymm8, ymm8, xmm8, 1
	vinserti128	ymm9, ymm9, xmm9, 1
	mov	eax, DWORD PTR 12[r15]
	vbroadcasti128	ymm5, XMMWORD PTR constant_6[rip]
	mov	edx, 1
	vbroadcasti128	ymm2, XMMWORD PTR constant_11[rip]
	vbroadcasti128	ymm3, XMMWORD PTR constant_10[rip]
	vbroadcasti128	ymm4, XMMWORD PTR constant_9[rip]
	jmp	.Lparse_objects_6digit_context_block_5
	.p2align 4,,10
	.p2align 3
.Lparse_objects_6digit_context_block_14:
	lea	eax, 1[r11]
	mov	DWORD PTR [r15], 0
	cmp	BYTE PTR 0[rbx+rax], 45
	jne	.Lparse_objects_6digit_context_block_3
	jmp	.Lparse_objects_6digit_context_block_11
.Lparse_objects_6digit_context_block_15:
	and	edx, 127
	imul	eax, eax, 100
	mov	ecx, edx
	movzx	ecx, WORD PTR -3[rbx+rcx]
	mov	r10d, ecx
	shr	cx, 8
	and	r10d, 15
	and	ecx, 15
	lea	r10d, [r10+r10*4]
	lea	ecx, [rcx+r10*2]
	add	eax, ecx
	mov	DWORD PTR 12[r15], eax
	jmp	.Lparse_objects_6digit_context_block_4
.Lparse_objects_6digit_context_block_16:
	add	r10d, 4
	add	edx, 130
	jmp	.Lparse_objects_6digit_context_block_2
.Lparse_objects_6digit_context_block_17:
	xor	eax, eax
	jmp	.Lparse_objects_6digit_context_block_8
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
