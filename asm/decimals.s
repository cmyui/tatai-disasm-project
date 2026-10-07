.intel_syntax noprefix

# parse_decimal
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_double::from_ascii::NO_INLINE_parse_decimal_16(char const*)
.section .text$parse_decimal,"x"
.p2align 4
.globl parse_decimal
.def parse_decimal; .scl 2; .type 32; .endef
	.seh_proc	parse_decimal
parse_decimal:
.Lparse_decimal_block_0:
	.seh_endprologue
	mov	eax, -791621424
	lea	r8, decimal_shuffles[rip]
	vmovd	xmm0, eax
	mov	eax, 774778414
	vmovd	xmm2, eax
	vpbroadcastd	xmm0, xmm0
	vpbroadcastd	xmm2, xmm2
	vmovdqu	xmm1, XMMWORD PTR [rcx]
	vpaddb	xmm0, xmm1, xmm0
	vpcmpeqb	xmm1, xmm1, xmm2
	vpmovmskb	edx, xmm0
	vpmovmskb	ecx, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_15[rip]
	andn	edx, ecx, edx
	or	edx, 65536
	tzcnt	edx, edx
	bts	ecx, edx
	mov	eax, edx
	tzcnt	ecx, ecx
	sal	eax, 4
	add	eax, ecx
	mov	eax, eax
	sal	rax, 4
	vpshufb	xmm0, xmm0, XMMWORD PTR [r8+rax]
	vpmaddubsw	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_16[rip]
	vpmaddwd	xmm0, xmm0, xmm1
	vmovdqa	xmm1, XMMWORD PTR constant_17[rip]
	vpackssdw	xmm0, xmm0, xmm0
	vpmaddwd	xmm0, xmm0, xmm1
	vmovq	rax, xmm0
	vxorps	xmm0, xmm0, xmm0
	mov	r8d, eax
	shr	rax, 32
	imul	r8, r8, 100000000
	add	rax, r8
	cmp	ecx, edx
	sbb	edx, ecx
	vcvtsi2sd	xmm0, xmm0, rax
	lea	rax, decimal_powers[rip]
	vmulsd	xmm0, xmm0, QWORD PTR [rax+rdx*8]
	ret
	.seh_endproc
