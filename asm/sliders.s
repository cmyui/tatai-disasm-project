.intel_syntax noprefix

# slider_type_valid
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: is_valid_slider_type(unsigned int)
.section .text$slider_type_valid,"x"
.p2align 4
.globl slider_type_valid
.def slider_type_valid; .scl 2; .type 32; .endef
	.seh_proc	slider_type_valid
slider_type_valid:
.Lslider_type_valid_block_0:
	.seh_endprologue
	mov	eax, 69644
	bt	eax, ecx
	setc	al
	movzx	eax, al
	ret
	.seh_endproc

# parse_slider_negative
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: slider_body_neg::parse_slider_point_negative(char const*, _slider_point*, unsigned int, unsigned int)
.section .text$parse_slider_negative,"x"
.p2align 4
.globl parse_slider_negative
.def parse_slider_negative; .scl 2; .type 32; .endef
	.seh_proc	parse_slider_negative
parse_slider_negative:
.Lparse_slider_negative_block_0:
	.seh_endprologue
	lea	r10, slider_negative_table[rip]
	movzx	eax, r8w
	shr	r8d, 16
	mov	r11, rcx
	mov	rcx, rdx
	or	r8d, eax
	mov	edx, 445
	pext	edx, r8d, edx
	mov	edx, edx
	cmp	DWORD PTR 4096[r10+rdx*4], r8d
	jne	.Lparse_slider_negative_block_1
	mov	r8d, -791621424
	sal	rdx, 5
	vmovdqa	xmm1, XMMWORD PTR constant_12[rip]
	and	eax, r9d
	vmovd	xmm0, r8d
	sal	eax, 8
	vpbroadcastd	xmm0, xmm0
	or	eax, DWORD PTR 16[r10+rdx]
	vpaddb	xmm0, xmm0, XMMWORD PTR [r11]
	vpshufb	xmm0, xmm0, XMMWORD PTR [r10+rdx]
	vpmaddubsw	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_13[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vmovq	xmm1, QWORD PTR 24[r10+rdx]
	vpsignd	xmm0, xmm0, xmm1
	vmovq	QWORD PTR [rcx], xmm0
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_slider_negative_block_1:
	xor	eax, eax
	ret
	.seh_endproc

# parse_slider_general
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: general_parse_slider_points(char const*, _slider_point*, _slider_data*)
.section .text$parse_slider_general,"x"
.p2align 4
.globl parse_slider_general
.def parse_slider_general; .scl 2; .type 32; .endef
	.seh_proc	parse_slider_general
parse_slider_general:
.Lparse_slider_general_block_0:
	push	rbx
	.seh_pushreg	rbx
	.seh_endprologue
	movzx	r9d, BYTE PTR [rcx]
	mov	QWORD PTR [r8], rdx
	mov	r10, rdx
	cmp	r9b, 45
	je	.Lparse_slider_general_block_8
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_1:
	movsx	eax, r9b
	xor	r11d, r11d
	sub	eax, 48
	cmp	eax, 9
	ja	.Lparse_slider_general_block_9
.Lparse_slider_general_block_2:
	xor	edx, edx
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_3:
	lea	edx, [rdx+rdx*4]
	inc	rcx
	lea	edx, [rax+rdx*2]
	movsx	eax, BYTE PTR [rcx]
	mov	r9d, eax
	sub	eax, 48
	cmp	eax, 9
	jbe	.Lparse_slider_general_block_3
	mov	eax, edx
	neg	eax
	test	r11b, r11b
	cmovne	edx, eax
	cmp	r9b, 58
	jne	.Lparse_slider_general_block_10
.Lparse_slider_general_block_4:
	movzx	r11d, BYTE PTR 1[rcx]
	cmp	r11b, 45
	je	.Lparse_slider_general_block_11
	movsx	eax, r11b
	lea	r9, 1[rcx]
	sub	eax, 48
	cmp	eax, 9
	ja	.Lparse_slider_general_block_12
	xor	ebx, ebx
.Lparse_slider_general_block_5:
	xor	ecx, ecx
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_6:
	lea	ecx, [rcx+rcx*4]
	inc	r9
	lea	ecx, [rax+rcx*2]
	movsx	eax, BYTE PTR [r9]
	mov	r11d, eax
	sub	eax, 48
	cmp	eax, 9
	jbe	.Lparse_slider_general_block_6
	mov	eax, ecx
	neg	eax
	test	bl, bl
	cmovne	ecx, eax
.Lparse_slider_general_block_7:
	mov	DWORD PTR [r10], edx
	add	r10, 8
	mov	DWORD PTR -4[r10], ecx
	cmp	r11b, 124
	jne	.Lparse_slider_general_block_13
	lea	rcx, 1[r9]
	movzx	r9d, BYTE PTR [rcx]
	cmp	r9b, 45
	jne	.Lparse_slider_general_block_1
.Lparse_slider_general_block_8:
	movsx	eax, BYTE PTR 1[rcx]
	inc	rcx
	mov	r9d, eax
	sub	eax, 48
	cmp	eax, 9
	ja	.Lparse_slider_general_block_9
	mov	r11d, 1
	jmp	.Lparse_slider_general_block_2
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_9:
	xor	edx, edx
	cmp	r9b, 58
	je	.Lparse_slider_general_block_4
.Lparse_slider_general_block_10:
	xor	eax, eax
	pop	rbx
	ret
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_11:
	movsx	eax, BYTE PTR 2[rcx]
	lea	r9, 2[rcx]
	mov	ebx, 1
	mov	r11d, eax
	sub	eax, 48
	cmp	eax, 9
	jbe	.Lparse_slider_general_block_5
.Lparse_slider_general_block_12:
	xor	ecx, ecx
	jmp	.Lparse_slider_general_block_7
.Lparse_slider_general_block_13:
	mov	QWORD PTR 8[r8], r10
	cmp	r11b, 44
	jne	.Lparse_slider_general_block_10
	movzx	r10d, BYTE PTR 1[r9]
	cmp	r10b, 45
	je	.Lparse_slider_general_block_17
	movsx	eax, r10b
	lea	rcx, 1[r9]
	sub	eax, 48
	cmp	eax, 9
	ja	.Lparse_slider_general_block_18
	xor	r9d, r9d
.Lparse_slider_general_block_14:
	xor	edx, edx
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lparse_slider_general_block_15:
	lea	edx, [rdx+rdx*4]
	inc	rcx
	lea	edx, [rax+rdx*2]
	movsx	eax, BYTE PTR [rcx]
	mov	r10d, eax
	sub	eax, 48
	cmp	eax, 9
	jbe	.Lparse_slider_general_block_15
	mov	eax, edx
	neg	eax
	test	r9b, r9b
	cmove	eax, edx
.Lparse_slider_general_block_16:
	mov	DWORD PTR 24[r8], eax
	cmp	r10b, 44
	jne	.Lparse_slider_general_block_10
	mov	eax, -791621424
	vmovdqu	xmm1, XMMWORD PTR 1[rcx]
	xor	ecx, ecx
	lea	r9, decimal_shuffles[rip]
	vmovd	xmm0, eax
	mov	eax, 774778414
	vmovd	xmm2, eax
	vpbroadcastd	xmm0, xmm0
	vpbroadcastd	xmm2, xmm2
	vpaddb	xmm0, xmm1, xmm0
	vpcmpeqb	xmm1, xmm1, xmm2
	vpmovmskb	edx, xmm0
	vpmovmskb	eax, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_15[rip]
	andn	edx, eax, edx
	or	edx, 65536
	tzcnt	edx, edx
	bts	eax, edx
	tzcnt	ecx, eax
	mov	eax, edx
	sal	eax, 4
	add	eax, ecx
	mov	eax, eax
	sal	rax, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR [r9+rax]
	vpmaddubsw	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_16[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_17[rip]
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm1
	vmovq	rax, xmm0
	vxorps	xmm0, xmm0, xmm0
	mov	r9d, eax
	shr	rax, 32
	imul	r9, r9, 100000000
	add	rax, r9
	cmp	ecx, edx
	sbb	edx, ecx
	vcvtsi2sd	xmm0, xmm0, rax
	lea	rax, decimal_powers[rip]
	vmulsd	xmm0, xmm0, QWORD PTR [rax+rdx*8]
	mov	eax, 1
	vmovsd	QWORD PTR 16[r8], xmm0
	pop	rbx
	ret
.Lparse_slider_general_block_17:
	movsx	eax, BYTE PTR 2[r9]
	lea	rcx, 2[r9]
	mov	r9d, 1
	mov	r10d, eax
	sub	eax, 48
	cmp	eax, 9
	jbe	.Lparse_slider_general_block_14
.Lparse_slider_general_block_18:
	xor	eax, eax
	jmp	.Lparse_slider_general_block_16
	.seh_endproc
