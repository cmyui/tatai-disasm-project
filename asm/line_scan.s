.intel_syntax noprefix
.section .text$refill_object_lines,"x"
.p2align 4
.globl refill_object_lines
.def refill_object_lines; .scl 2; .type 32; .endef
.seh_proc refill_object_lines
# Internal ABI: RCX region, RDX scan cursor, R8 input end.
# Returns RAX line-array end and RDX next scan cursor. Clobbers RBP/RSI;
# the caller replaces both with the new line range immediately. Preserves
# RDI/R12/R14/R15 and XMM6-XMM10, so the object decoder context stays live.
# Reuses MEM_lines as scratch; raw input remains readable across chunks.
refill_object_lines:
	.seh_endprologue
	lea	rsi, 536870912[rcx]
	lea	r9, 1024[rdx]
	cmp	r9, r8
	cmova	r9, r8
	mov	eax, 10
	vmovd	xmm0, eax
	vpbroadcastb	ymm0, xmm0
	mov	rbp, r9
	sub	rbp, rdx
	and	rbp, -64
	add	rbp, rdx
	cmp	rbp, rdx
	je	.Lrefill_object_lines_tail
	.p2align 4
.Lrefill_object_lines_scan:
	prefetcht0	BYTE PTR 512[rdx]
	vpcmpeqb	ymm1, ymm0, YMMWORD PTR [rdx]
	vpcmpeqb	ymm2, ymm0, YMMWORD PTR 32[rdx]
	vpmovmskb	eax, ymm1
	vpmovmskb	r10d, ymm2
	shl	r10, 32
	or	rax, r10
	xor	r8d, r8d
	popcnt	r8, rax
	xor	r11d, r11d
	tzcnt	r11, rax
	blsr	rax, rax
	lea	r11, 1[rdx+r11]
	mov	QWORD PTR [rsi], r11
	xor	r11d, r11d
	tzcnt	r11, rax
	blsr	rax, rax
	lea	r11, 1[rdx+r11]
	mov	QWORD PTR 8[rsi], r11
	xor	r11d, r11d
	tzcnt	r11, rax
	lea	r11, 1[rdx+r11]
	mov	QWORD PTR 16[rsi], r11
	cmp	r8d, 3
	ja	.Lrefill_object_lines_extra
	lea	rsi, [rsi+r8*8]
.Lrefill_object_lines_next:
	add	rdx, 64
	cmp	rdx, rbp
	jne	.Lrefill_object_lines_scan
	jmp	.Lrefill_object_lines_tail
.Lrefill_object_lines_extra:
	add	rsi, 24
	blsr	rax, rax
.Lrefill_object_lines_extra_loop:
	xor	r11d, r11d
	tzcnt	r11, rax
	lea	r11, 1[rdx+r11]
	mov	QWORD PTR [rsi], r11
	add	rsi, 8
	blsr	rax, rax
	jne	.Lrefill_object_lines_extra_loop
	jmp	.Lrefill_object_lines_next
.Lrefill_object_lines_tail:
	mov	r8, r9
	sub	r8, rdx
	test	r8, r8
	je	.Lrefill_object_lines_done
	vpcmpeqb	ymm1, ymm0, YMMWORD PTR [rdx]
	vpcmpeqb	ymm2, ymm0, YMMWORD PTR 32[rdx]
	vpmovmskb	eax, ymm1
	vpmovmskb	r10d, ymm2
	shl	r10, 32
	or	rax, r10
	bzhi	rax, rax, r8
	test	rax, rax
	je	.Lrefill_object_lines_done
.Lrefill_object_lines_tail_loop:
	xor	r11d, r11d
	tzcnt	r11, rax
	lea	r11, 1[rdx+r11]
	mov	QWORD PTR [rsi], r11
	add	rsi, 8
	blsr	rax, rax
	jne	.Lrefill_object_lines_tail_loop
.Lrefill_object_lines_done:
	mov	rax, rsi
	lea	r11, 536870912[rcx]
	sub	rsi, r11
	shr	rsi, 3
	add	DWORD PTR 40[rcx], esi
	vpxor	xmm0, xmm0, xmm0
	vmovdqu	XMMWORD PTR [rax], xmm0
	mov	rdx, r9
	vzeroupper
	ret
.seh_endproc
