.intel_syntax noprefix

# find_hitobjects
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: find_hitobjects_line(char const*, char const*)
.section .text$find_hitobjects,"x"
.p2align 4
.globl find_hitobjects
.def find_hitobjects; .scl 2; .type 32; .endef
	.seh_proc	find_hitobjects
find_hitobjects:
.Lfind_hitobjects_block_0:
	.seh_endprologue
	mov	r9, rcx
	cmp	rcx, rdx
	jnb	.Lfind_hitobjects_block_6
	mov	eax, 1212696648
	movabs	r10, 7307761438757046363
	vmovd	xmm3, eax
	mov	eax, 1532713819
	vmovd	xmm2, eax
	vpbroadcastd	ymm3, xmm3
	vpbroadcastd	ymm2, xmm2
	.p2align 4,,10
	.p2align 3
.Lfind_hitobjects_block_1:
	vpcmpeqb	ymm0, ymm3, YMMWORD PTR 1[r9]
	vpcmpeqb	ymm1, ymm2, YMMWORD PTR [r9]
	vpand	ymm0, ymm0, ymm1
	vpmovmskb	r8d, ymm0
	test	r8d, r8d
	jne	.Lfind_hitobjects_block_3
	jmp	.Lfind_hitobjects_block_5
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lfind_hitobjects_block_2:
	blsr	r8d, r8d
	je	.Lfind_hitobjects_block_5
.Lfind_hitobjects_block_3:
	xor	eax, eax
	tzcnt	eax, r8d
	add	rax, r9
	cmp	QWORD PTR [rax], r10
	jne	.Lfind_hitobjects_block_2
	cmp	rcx, rax
	je	.Lfind_hitobjects_block_4
	cmp	BYTE PTR -1[rax], 10
	jne	.Lfind_hitobjects_block_2
	cmp	rax, rdx
	jnb	.Lfind_hitobjects_block_2
.Lfind_hitobjects_block_4:
	vzeroupper
	ret
	.p2align 4,,10
	.p2align 3
.Lfind_hitobjects_block_5:
	add	r9, 32
	cmp	r9, rdx
	jb	.Lfind_hitobjects_block_1
	vzeroupper
.Lfind_hitobjects_block_6:
	mov	rax, rdx
	ret
	.seh_endproc

# parse_beatmap_body
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_beatmap_from_memory(_memory_region_header*, char const*, char const*) [clone .part.0]
.section .text$parse_beatmap_body,"x"
.p2align 4
.globl parse_beatmap_body
.def parse_beatmap_body; .scl 2; .type 32; .endef
	.seh_proc	parse_beatmap_body
parse_beatmap_body:
.Lparse_beatmap_body_block_0:
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
	sub	rsp, 184
	.seh_stackalloc	184
	vmovaps	XMMWORD PTR 80[rsp], xmm6
	.seh_savexmm	xmm6, 80
	vmovaps	XMMWORD PTR 96[rsp], xmm7
	.seh_savexmm	xmm7, 96
	vmovaps	XMMWORD PTR 112[rsp], xmm8
	.seh_savexmm	xmm8, 112
	vmovaps	XMMWORD PTR 128[rsp], xmm9
	.seh_savexmm	xmm9, 128
	vmovaps	XMMWORD PTR 144[rsp], xmm10
	.seh_savexmm	xmm10, 144
	vmovaps	XMMWORD PTR 160[rsp], xmm11
	.seh_savexmm	xmm11, 160
	.seh_endprologue
	vpxor	xmm0, xmm0, xmm0
	mov	rsi, r8
	mov	r14, rdx
	mov	DWORD PTR 68[rcx], 0
	mov	rdi, rcx
	sub	rsi, rdx
	mov	edx, DWORD PTR 4[rcx]
	mov	BYTE PTR 152[rcx], 0
	mov	rbp, r8
	lea	rax, 32[0+rsi*8]
	vmovdqu	YMMWORD PTR 36[rcx], ymm0
	lea	r12, 536870912[rcx]
	cmp	rdx, rax
	jb	.Lparse_beatmap_body_block_56
.Lparse_beatmap_body_block_1:
	mov	r13, rsi
	mov	edx, DWORD PTR 24[rdi]
	mov	ebx, 3221225472
	sar	r13, 2
	add	rbx, rdi
	lea	rax, 0[0+r13*8]
	cmp	rdx, rax
	jb	.Lparse_beatmap_body_block_70
.Lparse_beatmap_body_block_2:
	lea	rax, 0[r13+r13*2]
	mov	edx, DWORD PTR 16[rdi]
	sal	rax, 3
	cmp	rdx, rax
	jb	.Lparse_beatmap_body_block_68
.Lparse_beatmap_body_block_3:
	sar	rsi, 3
	lea	rax, 1073741824[rdi]
	mov	edx, DWORD PTR 8[rdi]
	mov	r13d, esi
	mov	QWORD PTR 48[rsp], rax
	mov	rax, r13
	sal	rax, 4
	cmp	rdx, rax
	jb	.Lparse_beatmap_body_block_69
.Lparse_beatmap_body_block_4:
	mov	eax, DWORD PTR 12[rdi]
	sal	r13, 5
	cmp	rax, r13
	jb	.Lparse_beatmap_body_block_57
.Lparse_beatmap_body_block_5:
	mov	eax, 2684354560
	mov	edx, DWORD PTR 20[rdi]
	lea	r13, [rdi+rax]
	lea	eax, 9[rsi]
	sal	rax, 4
	cmp	rdx, rax
	jb	.Lparse_beatmap_body_block_67
.Lparse_beatmap_body_block_6:
	mov	eax, 168430090
	lea	r9, 64[r14]
	mov	QWORD PTR 536870912[rdi], r14
	lea	rsi, 536870920[rdi]
	vmovd	xmm2, eax
	vpbroadcastd	ymm2, xmm2
	cmp	rbp, r9
	jb	.Lparse_beatmap_body_block_9
	# Align the scan base; ignore prefix bytes in the first newline mask.
	mov ecx, r14d
	and ecx, 31
	mov rbx, -1
	shl rbx, cl
	and r14, -32
	lea r9, 64[r14]
	mov r8, rbp
	lea	rdx, 1[r14]
	vmovdqa	ymm0, ymm2
	sub	r8, r14
	sub	r8, 64
	mov	rax, r8
	and	rax, -64
	lea	r10, 65[r14+rax]
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_7:
	# Hide upcoming cache misses without changing the demand-load bounds.
	prefetcht0 BYTE PTR 512[rdx]
	vpcmpeqb	ymm3, ymm0, YMMWORD PTR 31[rdx]
	vpcmpeqb	ymm1, ymm0, YMMWORD PTR -1[rdx]
	xor	r11d, r11d
	vpmovmskb	eax, ymm3
	vpmovmskb	ecx, ymm1
	sal	rax, 32
	or	rax, rcx
	and rax, rbx
	mov rbx, -1
	xor	ecx, ecx
	tzcnt	r11, rax
	popcnt	rcx, rax
	blsr	rax, rax
	add	r11, rdx
	mov	QWORD PTR [rsi], r11
	xor	r11d, r11d
	tzcnt	r11, rax
	blsr	rax, rax
	add	r11, rdx
	mov	QWORD PTR 8[rsi], r11
	xor	r11d, r11d
	tzcnt	r11, rax
	blsr	rax, rax
	add	r11, rdx
	mov	QWORD PTR 16[rsi], r11
	xor	r11d, r11d
	tzcnt	r11, rax
	add	r11, rdx
	mov	QWORD PTR 24[rsi], r11
	cmp	ecx, 4
	jg	.Lparse_beatmap_body_block_15
	lea	rsi, [rsi+rcx*8]
.Lparse_beatmap_body_block_8:
	add	rdx, 64
	cmp	r10, rdx
	jne	.Lparse_beatmap_body_block_7
	and	r8, -64
	lea	r14, [r9+r8]
.Lparse_beatmap_body_block_9:
	cmp	r14, rbp
	jb	.Lparse_beatmap_body_block_17
.Lparse_beatmap_body_block_10:
	mov ebx, 3221225472
	add rbx, rdi
	mov	eax, 741092396
	mov	r8, rsi
	mov	rdx, r12
	mov	rcx, rdi
	vmovd	xmm6, eax
	mov	rax, rsi
	vpbroadcastd	xmm6, xmm6
	vzeroupper
	sub	rax, r12
	vpxor	xmm0, xmm0, xmm0
	sar	rax, 3
	vmovdqu	XMMWORD PTR [rsi], xmm0
	mov	DWORD PTR 40[rdi], eax
	call	parse_beatmap_header
	mov	rbp, rax
	cmp	rax, rsi
	je	.Lparse_beatmap_body_block_19
	movabs	rdx, 7307761438757046363
	jmp	.Lparse_beatmap_body_block_12
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_11:
	cmp	rsi, rbp
	je	.Lparse_beatmap_body_block_19
.Lparse_beatmap_body_block_12:
	mov	rax, QWORD PTR 0[rbp]
	add	rbp, 8
	cmp	QWORD PTR [rax], rdx
	jne	.Lparse_beatmap_body_block_11
	mov	rax, QWORD PTR 48[rsp]
	lea	r14, 1610612736[rdi]
	mov	r12, r13
	mov	QWORD PTR 40[rsp], rax
	cmp	rsi, rbp
	je	.Lparse_beatmap_body_block_83
	mov	QWORD PTR 56[rsp], rbx
	vmovdqa	xmm1, xmm6
	lea	r15, .Lparse_beatmap_body_block_14[rip]
.Lparse_beatmap_body_block_13:
	mov	rdx, QWORD PTR 0[rbp]
	xor	r8d, r8d
	xor	ecx, ecx
	vpcmpeqb	xmm0, xmm1, XMMWORD PTR [rdx]
	vpmovmskb	r11d, xmm0
	blsr	r9d, r11d
	tzcnt	r8d, r9d
	blsr	r9d, r9d
	tzcnt	ecx, r9d
	mov	eax, ecx
	sub	eax, r8d
	cmp	eax, 8
	ja	.Lparse_beatmap_body_block_84
	mov	r10d, eax
	movsxd	r10, DWORD PTR [r15+r10*4]
	add	r10, r15
	jmp	r10
	.section .rdata,"dr"
	.align 4
.Lparse_beatmap_body_block_14:
	.long	.Lparse_beatmap_body_block_84-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_44-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_44-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_44-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_44-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_51-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_49-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_50-.Lparse_beatmap_body_block_14
	.long	.Lparse_beatmap_body_block_52-.Lparse_beatmap_body_block_14
.section .text$parse_beatmap_body,"x"
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_15:
	add	rsi, 32
	blsr	rax, rax
	je	.Lparse_beatmap_body_block_8
	mov	r14, rsi
	mov	rcx, rax
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_16:
	xor	r11d, r11d
	add	r14, 8
	tzcnt	r11, rcx
	add	r11, rdx
	blsr	rcx, rcx
	mov	QWORD PTR -8[r14], r11
	jne	.Lparse_beatmap_body_block_16
	popcnt	rax, rax
	dec	eax
	lea	rsi, 8[rsi+rax*8]
	jmp	.Lparse_beatmap_body_block_8
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_17:
	vpcmpeqb	ymm0, ymm2, YMMWORD PTR [r14]
	vpcmpeqb	ymm2, ymm2, YMMWORD PTR 32[r14]
	sub	rbp, r14
	vpmovmskb	r8d, ymm2
	vpmovmskb	eax, ymm0
	sal	r8, 32
	or	r8, rax
	bzhi	r8, r8, rbp
	test	r8, r8
	je	.Lparse_beatmap_body_block_10
	mov	rdx, rsi
	mov	rax, r8
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_18:
	xor	ecx, ecx
	add	rdx, 8
	tzcnt	rcx, rax
	blsr	rax, rax
	lea	rcx, 1[r14+rcx]
	mov	QWORD PTR -8[rdx], rcx
	jne	.Lparse_beatmap_body_block_18
	popcnt	r8, r8
	lea	eax, -1[r8]
	lea	rsi, 8[rsi+rax*8]
	jmp	.Lparse_beatmap_body_block_10
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_19:
	mov	rax, QWORD PTR 48[rsp]
	lea	r14, 1610612736[rdi]
	mov	r12, r13
	mov	QWORD PTR 40[rsp], rax
	mov	r15, rax
.Lparse_beatmap_body_block_20:
	mov	rdx, r15
	mov	r9, r12
	mov	r8, r14
	mov	rcx, rbp
	call	parse_objects_4digit
	mov	rdx, rax
	mov	eax, eax
	shr	rdx, 32
	lea	rbp, 0[rbp+rax*8]
	sal	rdx, 4
	add	r12, rdx
	mov	rdx, rax
	sal	rax, 5
	sal	rdx, 4
	add	r14, rax
	add	r15, rdx
	mov	QWORD PTR 40[rsp], r15
.Lparse_beatmap_body_block_21:
	mov	r15, QWORD PTR 40[rsp]
	mov	r9, r12
	mov	r8, r14
	mov	rcx, rbp
	mov	rdx, r15
	call	parse_objects_5digit
	mov	rdx, rax
	mov	eax, eax
	shr	rdx, 32
	lea	rbp, 0[rbp+rax*8]
	sal	rdx, 4
	add	r12, rdx
	mov	rdx, rax
	sal	rax, 5
	sal	rdx, 4
	add	r14, rax
	add	r15, rdx
	mov	QWORD PTR 40[rsp], r15
.Lparse_beatmap_body_block_22:
	cmp	rsi, rbp
	je	.Lparse_beatmap_body_block_24
	mov	r15, QWORD PTR 40[rsp]
	mov	r9, r12
	mov	r8, r14
	mov	rcx, rbp
	mov	rdx, r15
	call	parse_objects_6digit
	mov	rdx, rax
	mov	eax, eax
	shr	rdx, 32
	lea	rbp, 0[rbp+rax*8]
	sal	rdx, 4
	add	r12, rdx
	mov	rdx, rax
	sal	rax, 5
	sal	rdx, 4
	add	r14, rax
	add	r15, rdx
	mov	QWORD PTR 40[rsp], r15
.Lparse_beatmap_body_block_23:
	cmp	rsi, rbp
	je	.Lparse_beatmap_body_block_24
	mov	rsi, QWORD PTR 40[rsp]
	mov	r9, r12
	mov	r8, r14
	mov	rcx, rbp
	mov	rdx, rsi
	call	parse_objects_7digit
	mov	rdx, rax
	mov	eax, eax
	sal	rax, 4
	shr	rdx, 32
	add	rsi, rax
	sal	rdx, 4
	mov	QWORD PTR 40[rsp], rsi
	add	r12, rdx
.Lparse_beatmap_body_block_24:
	cmp	r13, r12
	je	.Lparse_beatmap_body_block_58
	mov	eax, -791621424
	mov	rdx, rbx
	vmovdqa	xmm11, XMMWORD PTR constant_34[rip]
	vmovdqa	xmm9, XMMWORD PTR constant_35[rip]
	vmovd	xmm5, eax
	vmovdqa	xmm7, XMMWORD PTR constant_36[rip]
	mov	rsi, r13
	vpbroadcastd	xmm8, xmm5
	lea	r15, slider_positive_table[rip]
	mov	rbx, r12
	vmovdqa	xmm10, xmm8
	jmp	.Lparse_beatmap_body_block_26
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_25:
	mov	rsi, r11
.Lparse_beatmap_body_block_26:
	mov rbp, QWORD PTR [rsi]
	mov r10, QWORD PTR 8[rsi]
	mov r12d, 15
	vmovdqa xmm2, xmm6
	mov QWORD PTR [r10], rdx
	# Only the 2- or 3-byte hitsound field length is consumed here.
	mov eax, 2
	mov ecx, 3
	cmp BYTE PTR 1[rbp], 44
	cmovne eax, ecx
	add rbp, rax
	movzx	eax, BYTE PTR 0[rbp]
	add	rbp, 2
	mov	QWORD PTR 8[r10], rbp
	mov	DWORD PTR 28[r10], eax
.Lparse_beatmap_body_block_27:
	vmovdqu	xmm1, XMMWORD PTR 0[rbp]
	vpshufb	xmm0, xmm11, xmm1
	vpmovmskb	r8d, xmm0
	vpaddb	xmm0, xmm1, xmm10
	vpcmpeqb	xmm1, xmm1, xmm2
	pdep	eax, r12d, r8d
	lea	ecx, 1[rax+rax]
	vpmovmskb	r9d, xmm1
	and	ecx, eax
	jne	.Lparse_beatmap_body_block_40
	blsmsk	r8d, r9d
	and	r8d, eax
	imul	eax, r8d, 480925
	shr	eax, 10
	and	eax, 8160
	add	rax, r15
	mov	rcx, QWORD PTR [rax]
	cmp	r8d, ecx
	jne	.Lparse_beatmap_body_block_38
	vpshufb	xmm0, xmm0, XMMWORD PTR 16[rax]
	mov	eax, r9d
	shr	rcx, 32
	vpmaddubsw	xmm0, xmm0, xmm9
	and	eax, r8d
	vpmaddwd	xmm0, xmm0, xmm7
	sal	eax, 8
	vmovdqu	XMMWORD PTR [rdx], xmm0
	or	eax, ecx
.Lparse_beatmap_body_block_28:
	test	eax, eax
	je	.Lparse_beatmap_body_block_38
.Lparse_beatmap_body_block_29:
	movzx	ecx, al
	lea	rdx, [rdx+rcx*8]
	mov	ecx, eax
	shr	ecx, 24
	add	rbp, rcx
	test	eax, 16776960
	je	.Lparse_beatmap_body_block_27
	movzx	eax, BYTE PTR 0[rbp]
	movzx	ecx, BYTE PTR 1[rbp]
	mov	QWORD PTR 8[r10], rdx
	lea	rdx, 2[rbp]
	and	eax, 15
	cmp	cl, 44
	jne	.Lparse_beatmap_body_block_41
	mov	DWORD PTR 24[r10], eax
.Lparse_beatmap_body_block_30:
	mov	rax, QWORD PTR 8[rsi]
	lea	r11, 16[rsi]
	mov	QWORD PTR [rsi], rdx
	mov	rdx, QWORD PTR 8[rax]
	cmp	rbx, r11
	jne	.Lparse_beatmap_body_block_25
	mov	ebp, DWORD PTR 68[rdi]
	mov	eax, 774778414
	mov	rbx, rdx
	vxorps	xmm7, xmm7, xmm7
	vmovd	xmm6, eax
	vpbroadcastd	xmm6, xmm6
	mov	r8d, ebp
	test	ebp, ebp
	jne	.Lparse_beatmap_body_block_71
	cmp	r13, rsi
	jnb	.Lparse_beatmap_body_block_54
	mov	QWORD PTR 56[rsp], r13
	vmovdqa	xmm4, XMMWORD PTR constant_15[rip]
	mov	r9, r13
	lea	r12, decimal_shuffles[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_16[rip]
	vmovdqa	xmm2, XMMWORD PTR constant_17[rip]
	lea	rbp, decimal_powers[rip]
	vmovdqa	xmm5, xmm8
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_31:
	mov	rax, QWORD PTR 128[r9]
	mov	r15, QWORD PTR 24[r9]
	prefetcht0	[rax]
	mov	rax, QWORD PTR 144[r9]
	prefetcht0	[rax]
	mov	rax, QWORD PTR [r9]
	vmovdqu	xmm9, XMMWORD PTR [rax]
	mov	rax, QWORD PTR 16[r9]
	vpaddb	xmm1, xmm9, xmm5
	vpcmpeqb	xmm9, xmm9, xmm6
	vmovdqu	xmm8, XMMWORD PTR [rax]
	vpmovmskb	edx, xmm1
	vpaddb	xmm0, xmm8, xmm5
	vpcmpeqb	xmm8, xmm8, xmm6
	vpmovmskb	r8d, xmm9
	vpmovmskb	eax, xmm0
	andn	edx, r8d, edx
	or	edx, 65536
	tzcnt	edx, edx
	vpmovmskb	ecx, xmm8
	bts	r8d, edx
	mov	r10d, edx
	andn	eax, ecx, eax
	or	eax, 65536
	tzcnt	r8d, r8d
	sal	r10d, 4
	tzcnt	eax, eax
	add	r10d, r8d
	bts	ecx, eax
	mov	r10d, r10d
	tzcnt	ecx, ecx
	sal	r10, 4
	vpshufb	xmm1, xmm1, XMMWORD PTR [r12+r10]
	mov	r10d, eax
	vpmaddubsw	xmm1, xmm1, xmm4
	sal	r10d, 4
	vpmaddwd	xmm1, xmm1, xmm3
	add	r10d, ecx
	vpackssdw	xmm1, xmm1, xmm1
	mov	r10d, r10d
	vpmaddwd	xmm1, xmm1, xmm2
	sal	r10, 4
	vmovq	r13, xmm1
	vpshufb	xmm0, xmm0, XMMWORD PTR [r12+r10]
	mov	r14d, r13d
	vpmaddubsw	xmm0, xmm0, xmm4
	shr	r13, 32
	imul	r14, r14, 100000000
	vpmaddwd	xmm0, xmm0, xmm3
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm2
	add	r14, r13
	cmp	r8d, edx
	vmovq	r10, xmm0
	sbb	edx, r8d
	vcvtsi2sd	xmm0, xmm7, r14
	vmulsd	xmm0, xmm0, QWORD PTR 0[rbp+rdx*8]
	mov	rdx, QWORD PTR 8[r9]
	vmovsd	QWORD PTR 16[rdx], xmm0
	mov	edx, r10d
	shr	r10, 32
	imul	rdx, rdx, 100000000
	add	r10, rdx
	cmp	ecx, eax
	sbb	eax, ecx
	vcvtsi2sd	xmm0, xmm7, r10
	add	r9, 32
	vmulsd	xmm0, xmm0, QWORD PTR 0[rbp+rax*8]
	vmovsd	QWORD PTR 16[r15], xmm0
	cmp	r9, rsi
	jb	.Lparse_beatmap_body_block_31
	movabs	rax, -2684354577
	mov	r13, QWORD PTR 56[rsp]
	xor	ebp, ebp
	sub	rax, rdi
	add	rax, r11
	and	rax, -32
	lea	rax, 32[r13+rax]
	cmp	rsi, rax
	je	.Lparse_beatmap_body_block_55
.Lparse_beatmap_body_block_32:
	movabs	rsi, 4294967296
	sal	rbp, 4
	add	rsi, rdi
	add	rbp, rsi
	cmp	rsi, rbp
	je	.Lparse_beatmap_body_block_35
	mov	rdx, rbx
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_33:
	mov	r8, QWORD PTR 8[rsi]
	mov	rcx, QWORD PTR [rsi]
	call	parse_slider_general
	test	eax, eax
	je	.Lparse_beatmap_body_block_39
	mov	rdx, QWORD PTR 8[r8]
.Lparse_beatmap_body_block_34:
	add	rsi, 16
	cmp	rbp, rsi
	jne	.Lparse_beatmap_body_block_33
.Lparse_beatmap_body_block_35:
	mov	rax, QWORD PTR 40[rsp]
	mov	rbx, QWORD PTR 48[rsp]
	sub	rax, rbx
	sar	rax, 4
	cmp	BYTE PTR 152[rdi], 0
	mov	DWORD PTR 44[rdi], eax
	mov	ebp, eax
	jne	.Lparse_beatmap_body_block_59
.Lparse_beatmap_body_block_36:
	vmovaps	xmm6, XMMWORD PTR 80[rsp]
	vmovaps	xmm7, XMMWORD PTR 96[rsp]
	vmovaps	xmm8, XMMWORD PTR 112[rsp]
	vmovaps	xmm9, XMMWORD PTR 128[rsp]
	vmovaps	xmm10, XMMWORD PTR 144[rsp]
	vmovaps	xmm11, XMMWORD PTR 160[rsp]
	add	rsp, 184
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
.Lparse_beatmap_body_block_37:
	mov	DWORD PTR 24[r10], ecx
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_38:
	mov	rcx, r10
	call	defer_slider_body
	xor	edx, edx
	jmp	.Lparse_beatmap_body_block_30
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_39:
	vpxor	xmm0, xmm0, xmm0
	mov	BYTE PTR 152[rdi], 1
	xor	edx, edx
	vmovdqu	XMMWORD PTR [r8], xmm0
	jmp	.Lparse_beatmap_body_block_34
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_40:
	mov	r11d, 3
	andn	r8d, ecx, r8d
	pdep	r11d, r11d, r8d
	blsr	eax, r11d
	blsi	eax, eax
	lea	r8d, -1[rax]
	and	r8d, ecx
	jne	.Lparse_beatmap_body_block_53
	lea	ecx, [r11+r11*2]
	lea	r8, slider_single_table[rip+448]
	and	ecx, 108
	cmp	r11d, DWORD PTR [r8+rcx*4]
	jne	.Lparse_beatmap_body_block_38
	vmovdqa	xmm1, XMMWORD PTR constant_35[rip]
	vpshufb	xmm0, xmm0, XMMWORD PTR -448[r8+rcx*4]
/APP
 # 1886 "/opt/homebrew/Cellar/mingw-w64/14.0.0_3/toolchain-x86_64/x86_64-w64-mingw32/include/psdk_inc/intrin-impl.h" 1
	bsr r11d,r11d
 # 0 "" 2
/NO_APP
	vpmaddubsw	xmm0, xmm0, xmm1
	and	eax, r9d
	vmovdqa	xmm1, XMMWORD PTR constant_36[rip]
	sal	r11d, 24
	sal	eax, 8
	vpmaddwd	xmm0, xmm0, xmm1
	or	eax, 16777217
	vmovdqu	XMMWORD PTR [rdx], xmm0
	add	eax, r11d
	jmp	.Lparse_beatmap_body_block_29
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_41:
	lea	eax, [rax+rax*4]
	and	ecx, 15
	lea	ecx, [rcx+rax*2]
	mov	eax, DWORD PTR 2[rbp]
	test	eax, eax
	jne	.Lparse_beatmap_body_block_43
	jmp	.Lparse_beatmap_body_block_37
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_42:
	lea	r8d, [rcx+rcx*4]
	mov	ecx, eax
	inc	rdx
	and	ecx, 15
	shr	eax, 8
	lea	ecx, [rcx+r8*2]
	je	.Lparse_beatmap_body_block_37
.Lparse_beatmap_body_block_43:
	cmp	al, 44
	jne	.Lparse_beatmap_body_block_42
	mov	DWORD PTR 24[r10], ecx
	inc	rdx
	jmp	.Lparse_beatmap_body_block_30
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_44:
	blsr	r9d, r9d
	tzcnt	r11d, r11d
	tzcnt	r9d, r9d
	mov	DWORD PTR 64[rsp], r9d
	cmp	r11d, 3
	ja	.Lparse_beatmap_body_block_79
	mov	r9d, DWORD PTR [rdx]
	cmp	r9b, 45
	je	.Lparse_beatmap_body_block_82
	mov	r10d, r9d
	and	r9d, 15
	and	r10d, 252645135
	mov	DWORD PTR 76[rsp], r10d
	shr	r10d, 8
	movzx	ebx, r10b
	cmp	r11d, 3
	je	.Lparse_beatmap_body_block_75
	lea	r10d, [r9+r9*4]
	cmp	r11d, 2
	lea	r10d, [rbx+r10*2]
	cmove	r9d, r10d
.Lparse_beatmap_body_block_45:
	mov	r10, QWORD PTR 40[rsp]
	mov	DWORD PTR [r10], r9d
	lea	r9d, -1[r8]
	sub	r9d, r11d
	mov	DWORD PTR 76[rsp], r9d
	mov	ebx, r9d
	cmp	r9d, 3
	ja	.Lparse_beatmap_body_block_80
	mov	r9d, r11d
	mov	r9d, DWORD PTR 1[rdx+r9]
	cmp	r9b, 45
	je	.Lparse_beatmap_body_block_81
	mov	r11d, r9d
	and	r9d, 15
	and	r11d, 252645135
	mov	r10d, r11d
	shr	r10d, 8
	movzx	r10d, r10b
	cmp	ebx, 3
	je	.Lparse_beatmap_body_block_74
	lea	r11d, [r9+r9*4]
	cmp	DWORD PTR 76[rsp], 2
	lea	r10d, [r10+r11*2]
	cmove	r9d, r10d
.Lparse_beatmap_body_block_46:
	mov	r11, QWORD PTR 40[rsp]
	mov	r8d, r8d
	lea	r10d, -1[rax]
	mov	DWORD PTR 4[r11], r9d
	mov	r8d, DWORD PTR 1[rdx+r8]
	mov	r11d, r8d
	and	r8d, 15
	and	r11d, 252645135
	mov	r9d, r11d
	shr	r9d, 8
	movzx	r9d, r9b
	cmp	eax, 4
	je	.Lparse_beatmap_body_block_77
	lea	eax, [r8+r8*4]
	cmp	r10d, 2
	lea	eax, [r9+rax*2]
	cmove	r8d, eax
.Lparse_beatmap_body_block_47:
	mov	rax, QWORD PTR 40[rsp]
	mov	DWORD PTR 8[rax], r8d
	mov	r8d, DWORD PTR 64[rsp]
	sub	r8d, ecx
	mov	ecx, ecx
	mov	ecx, DWORD PTR 1[rdx+rcx]
	lea	r9d, -1[r8]
	mov	eax, ecx
	and	eax, 15
	cmp	r8d, 2
	je	.Lparse_beatmap_body_block_48
	mov	r8d, ecx
	shr	r8d, 8
	and	r8d, 15
	cmp	r9d, 2
	je	.Lparse_beatmap_body_block_78
	imul	eax, eax, 100
	shr	ecx, 16
	and	ecx, 15
	add	eax, ecx
	lea	ecx, [r8+r8*4]
	lea	eax, [rax+rcx*2]
.Lparse_beatmap_body_block_48:
	mov	r9, QWORD PTR 40[rsp]
	mov	ecx, DWORD PTR 64[rsp]
	add	rbp, 8
	mov	DWORD PTR 12[r9], eax
	sal	eax, 3
	lea	rdx, 1[rdx+rcx]
	add	r9, 16
	and	eax, 16
	mov	QWORD PTR 8[r12], r14
	add	r14, 32
	mov	QWORD PTR [r12], rdx
	add	r12, rax
	mov	QWORD PTR 40[rsp], r9
	cmp	rbp, rsi
	jne	.Lparse_beatmap_body_block_13
	mov	rbx, QWORD PTR 56[rsp]
	mov	r15, r9
	jmp	.Lparse_beatmap_body_block_20
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_49:
	mov	rbx, QWORD PTR 56[rsp]
	jmp	.Lparse_beatmap_body_block_21
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_50:
	mov	rbx, QWORD PTR 56[rsp]
	jmp	.Lparse_beatmap_body_block_22
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_51:
	mov	rbx, QWORD PTR 56[rsp]
	mov	r15, QWORD PTR 40[rsp]
	jmp	.Lparse_beatmap_body_block_20
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_52:
	mov	rbx, QWORD PTR 56[rsp]
	jmp	.Lparse_beatmap_body_block_23
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_53:
	sal	r8d, 16
	mov	rcx, rbp
	mov	QWORD PTR 64[rsp], r10
	or	r8d, r11d
	mov	QWORD PTR 56[rsp], rdx
	call	parse_slider_negative
	mov	rdx, QWORD PTR 56[rsp]
	mov	r10, QWORD PTR 64[rsp]
	jmp	.Lparse_beatmap_body_block_28
.Lparse_beatmap_body_block_54:
	jne	.Lparse_beatmap_body_block_35
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_55:
	mov	rcx, QWORD PTR -16[r11]
	mov	r9, QWORD PTR -8[r11]
	call	parse_decimal
	vmovsd	QWORD PTR 16[r9], xmm0
	jmp	.Lparse_beatmap_body_block_32
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_56:
	lea	rbx, 524287[rax]
	and	rbx, -524288
	cmp	rbx, 536870912
	ja	.Lparse_beatmap_body_block_76
	mov	rax, rbx
	lea	rcx, [r12+rdx]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rax, rdx
	mov	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_36
	mov	DWORD PTR 4[rdi], ebx
	jmp	.Lparse_beatmap_body_block_1
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_57:
	add	r13, 524287
	and	r13, -524288
	cmp	r13, 536870912
	ja	.Lparse_beatmap_body_block_5
	mov	rdx, r13
	lea	rcx, 1610612736[rdi+rax]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_5
	mov	DWORD PTR 12[rdi], r13d
	jmp	.Lparse_beatmap_body_block_5
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_58:
	mov	ebp, DWORD PTR 68[rdi]
	jmp	.Lparse_beatmap_body_block_32
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_59:
	and	eax, 4294967295
	je	.Lparse_beatmap_body_block_64
	xor	esi, esi
	mov	r14, rbx
	jmp	.Lparse_beatmap_body_block_62
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_60:
	mov	rsi, r12
.Lparse_beatmap_body_block_61:
	mov	eax, ebp
	cmp	rsi, rax
	jnb	.Lparse_beatmap_body_block_65
.Lparse_beatmap_body_block_62:
	mov	rdx, rsi
	lea	r12, 1[rsi]
	sal	rdx, 4
	lea	rcx, [r14+rdx]
	cmp	DWORD PTR 8[rcx], -1
	je	.Lparse_beatmap_body_block_66
	test	BYTE PTR 12[rcx], 2
	je	.Lparse_beatmap_body_block_60
	mov	r8, rsi
	sal	r8, 5
	lea	r13, 1610612736[rdi+r8]
	cmp	QWORD PTR 0[r13], 0
	jne	.Lparse_beatmap_body_block_60
.Lparse_beatmap_body_block_63:
	sub	rax, rsi
	lea	rdx, 16[r14+rdx]
	sal	r12, 5
	dec	ebp
	lea	rbx, -1[rax]
	mov	r8, rbx
	sal	rbx, 5
	sal	r8, 4
	call	"memmove"
	lea	rdx, 1610612736[rdi+r12]
	mov	r8, rbx
	mov	rcx, r13
	call	"memmove"
	jmp	.Lparse_beatmap_body_block_61
.Lparse_beatmap_body_block_64:
	xor	ebp, ebp
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_65:
	mov	DWORD PTR 44[rdi], ebp
	jmp	.Lparse_beatmap_body_block_36
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_66:
	mov	r8, rsi
	sal	r8, 5
	lea	r13, 1610612736[rdi+r8]
	jmp	.Lparse_beatmap_body_block_63
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_67:
	lea	rsi, 524287[rax]
	and	rsi, -524288
	cmp	rsi, 536870912
	ja	.Lparse_beatmap_body_block_6
	mov	rax, rsi
	lea	rcx, 0[r13+rdx]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rax, rdx
	mov	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_6
	mov	DWORD PTR 20[rdi], esi
	jmp	.Lparse_beatmap_body_block_6
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_68:
	lea	r13, 524287[rax]
	and	r13, -524288
	cmp	r13, 536870912
	ja	.Lparse_beatmap_body_block_3
	mov	ecx, 2147483648
	mov	rax, r13
	mov	r9d, 4
	mov	r8d, 4096
	sub	rax, rdx
	add	rdx, rcx
	lea	rcx, [rdi+rdx]
	mov	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_3
	mov	DWORD PTR 16[rdi], r13d
	jmp	.Lparse_beatmap_body_block_3
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_69:
	lea	r15, 524287[rax]
	and	r15, -524288
	cmp	r15, 536870912
	ja	.Lparse_beatmap_body_block_4
	mov	rcx, QWORD PTR 48[rsp]
	mov	rax, r15
	mov	r9d, 4
	mov	r8d, 4096
	sub	rax, rdx
	add	rcx, rdx
	mov	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_4
	mov	DWORD PTR 8[rdi], r15d
	jmp	.Lparse_beatmap_body_block_4
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_70:
	lea	r15, 524287[rax]
	and	r15, -524288
	cmp	r15, 536870912
	ja	.Lparse_beatmap_body_block_2
	mov	rax, r15
	lea	rcx, [rbx+rdx]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rax, rdx
	mov	rdx, rax
	vzeroupper
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lparse_beatmap_body_block_2
	mov	DWORD PTR 24[rdi], r15d
	jmp	.Lparse_beatmap_body_block_2
.Lparse_beatmap_body_block_71:
	vmovdqa	xmm4, XMMWORD PTR constant_15[rip]
	vmovdqa	xmm3, XMMWORD PTR constant_16[rip]
	vmovdqa	xmm5, xmm8
	lea	r10, decimal_shuffles[rip]
	vmovdqa	xmm2, XMMWORD PTR constant_17[rip]
	lea	r9, decimal_powers[rip]
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_body_block_72:
	mov	rax, QWORD PTR 64[r13]
	prefetcht0	[rax]
	mov	rax, QWORD PTR 0[r13]
	test	rax, rax
	je	.Lparse_beatmap_body_block_73
	vmovdqu	xmm1, XMMWORD PTR [rax]
	mov	rsi, QWORD PTR 8[r13]
	vpaddb	xmm0, xmm1, xmm5
	vpcmpeqb	xmm1, xmm1, xmm6
	vpmovmskb	eax, xmm0
	vpmovmskb	ecx, xmm1
	andn	eax, ecx, eax
	or	eax, 65536
	tzcnt	eax, eax
	bts	ecx, eax
	mov	edx, eax
	tzcnt	ecx, ecx
	sal	edx, 4
	add	edx, ecx
	mov	edx, edx
	sal	rdx, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR [r10+rdx]
	vpmaddubsw	xmm0, xmm0, xmm4
	vpmaddwd	xmm0, xmm0, xmm3
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm2
	vmovq	rdx, xmm0
	mov	ebp, edx
	shr	rdx, 32
	imul	rbp, rbp, 100000000
	add	rdx, rbp
	cmp	ecx, eax
	sbb	eax, ecx
	vcvtsi2sd	xmm0, xmm7, rdx
	vmulsd	xmm0, xmm0, QWORD PTR [r9+rax*8]
	vmovsd	QWORD PTR 16[rsi], xmm0
.Lparse_beatmap_body_block_73:
	add	r13, 16
	cmp	r11, r13
	jne	.Lparse_beatmap_body_block_72
	mov	ebp, r8d
	jmp	.Lparse_beatmap_body_block_32
.Lparse_beatmap_body_block_74:
	imul	r9d, r9d, 100
	shr	r11d, 16
	lea	r10d, [r10+r10*4]
	movzx	r11d, r11b
	add	r9d, r11d
	lea	r9d, [r9+r10*2]
	mov	r10d, 512
	cmp	r9d, r10d
	cmova	r9d, r10d
	jmp	.Lparse_beatmap_body_block_46
.Lparse_beatmap_body_block_75:
	mov	r10d, DWORD PTR 76[rsp]
	imul	r9d, r9d, 100
	shr	r10d, 16
	movzx	r10d, r10b
	add	r9d, r10d
	lea	r10d, [rbx+rbx*4]
	lea	r9d, [r9+r10*2]
	mov	r10d, 512
	cmp	r9d, r10d
	cmova	r9d, r10d
	jmp	.Lparse_beatmap_body_block_45
.Lparse_beatmap_body_block_76:
	vzeroupper
	jmp	.Lparse_beatmap_body_block_36
.Lparse_beatmap_body_block_77:
	imul	r8d, r8d, 100
	shr	r11d, 16
	movzx	eax, r11b
	add	eax, r8d
	lea	r8d, [r9+r9*4]
	lea	r8d, [rax+r8*2]
	jmp	.Lparse_beatmap_body_block_47
.Lparse_beatmap_body_block_78:
	lea	eax, [rax+rax*4]
	lea	eax, [r8+rax*2]
	jmp	.Lparse_beatmap_body_block_48
.Lparse_beatmap_body_block_79:
	mov	r9d, 512
	jmp	.Lparse_beatmap_body_block_45
.Lparse_beatmap_body_block_80:
	mov	r9d, 512
	jmp	.Lparse_beatmap_body_block_46
.Lparse_beatmap_body_block_81:
	xor	r9d, r9d
	jmp	.Lparse_beatmap_body_block_46
.Lparse_beatmap_body_block_82:
	xor	r9d, r9d
	jmp	.Lparse_beatmap_body_block_45
.Lparse_beatmap_body_block_83:
	mov	r15, rax
	jmp	.Lparse_beatmap_body_block_20
.Lparse_beatmap_body_block_84:
	mov	rbx, QWORD PTR 56[rsp]
	jmp	.Lparse_beatmap_body_block_24
	.seh_endproc

# parse_beatmap
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_beatmap_from_memory(_memory_region_header*, char const*, char const*)
.section .text$parse_beatmap,"x"
.p2align 4
.globl parse_beatmap
.def parse_beatmap; .scl 2; .type 32; .endef
	.seh_proc	parse_beatmap
parse_beatmap:
.Lparse_beatmap_block_0:
	.seh_endprologue
	test	rcx, rcx
	je	.Lparse_beatmap_block_1
	jmp	parse_beatmap_body
	.p2align 4,,10
	.p2align 3
.Lparse_beatmap_block_1:
	ret
	.seh_endproc
