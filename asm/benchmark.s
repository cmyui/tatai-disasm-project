.intel_syntax noprefix

# sort_timings
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: void std::__introsort_loop<__gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, long long, std::less<void> >(__gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, __gnu_cxx::__normal_iterator<double*, std::vector<double, std::allocator<double> > >, long long, std::less<void>) [clone .isra.0]
.section .text$sort_timings,"x"
.p2align 4
.globl sort_timings
.def sort_timings; .scl 2; .type 32; .endef
	.seh_proc	sort_timings
sort_timings:
.Lsort_timings_block_0:
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
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rsi, rcx
	mov	rax, rdx
	mov	rdi, r8
	mov	rcx, rdx
	sub	rax, rsi
	cmp	rax, 128
	jle	.Lsort_timings_block_27
	mov	rbx, rax
	sar	rax, 4
	sar	rbx, 3
	test	rdi, rdi
	je	.Lsort_timings_block_12
.Lsort_timings_block_1:
	vmovupd	xmm0, XMMWORD PTR [rsi]
	lea	rax, [rsi+rax*8]
	dec	rdi
	vmovsd	xmm3, QWORD PTR -8[rcx]
	vmovsd	xmm2, QWORD PTR [rax]
	lea	rbx, 8[rsi]
	vunpckhpd	xmm1, xmm0, xmm0
	vpermilpd	xmm4, xmm0, 1
	vcomisd	xmm2, xmm1
	jbe	.Lsort_timings_block_8
	vcomisd	xmm3, xmm2
	ja	.Lsort_timings_block_25
	vcomisd	xmm3, xmm1
	ja	.Lsort_timings_block_9
.Lsort_timings_block_2:
	vmovupd	XMMWORD PTR [rsi], xmm4
.Lsort_timings_block_3:
	mov	rdx, rcx
	jmp	.Lsort_timings_block_5
	.p2align 4
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_4:
	vmovsd	xmm0, QWORD PTR 8[rbx]
	add	rbx, 8
.Lsort_timings_block_5:
	vcomisd	xmm1, xmm0
	ja	.Lsort_timings_block_4
	vmovsd	xmm2, QWORD PTR -8[rdx]
	lea	rax, -16[rdx]
	vcomisd	xmm2, xmm1
	jbe	.Lsort_timings_block_10
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_6:
	mov	rdx, rax
	sub	rax, 8
	vmovsd	xmm2, QWORD PTR 8[rax]
	vcomisd	xmm2, xmm1
	ja	.Lsort_timings_block_6
	cmp	rbx, rdx
	jnb	.Lsort_timings_block_11
.Lsort_timings_block_7:
	vmovsd	QWORD PTR [rbx], xmm2
	add	rbx, 8
	vmovsd	QWORD PTR [rdx], xmm0
	vmovsd	xmm0, QWORD PTR [rbx]
	vmovsd	xmm1, QWORD PTR [rsi]
	jmp	.Lsort_timings_block_5
.Lsort_timings_block_8:
	vcomisd	xmm3, xmm1
	ja	.Lsort_timings_block_2
	vcomisd	xmm3, xmm2
	jbe	.Lsort_timings_block_25
.Lsort_timings_block_9:
	vmovsd	QWORD PTR [rsi], xmm3
	vmovsd	QWORD PTR -8[rcx], xmm0
	vmovsd	xmm0, QWORD PTR 8[rsi]
	vmovsd	xmm1, QWORD PTR [rsi]
	jmp	.Lsort_timings_block_3
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_10:
	sub	rdx, 8
	cmp	rbx, rdx
	jb	.Lsort_timings_block_7
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_11:
	mov	rdx, rcx
	mov	r8, rdi
	mov	rcx, rbx
	call	sort_timings
	mov	rax, rbx
	sub	rax, rsi
	cmp	rax, 128
	jle	.Lsort_timings_block_27
	mov	rcx, rbx
	mov	rbx, rax
	sar	rax, 4
	sar	rbx, 3
	test	rdi, rdi
	jne	.Lsort_timings_block_1
.Lsort_timings_block_12:
	lea	r10, -1[rbx]
	lea	r11, -8[rsi+rax*8]
	lea	r9, -1[rax]
	sar	r10
	vmovsd	xmm2, QWORD PTR [r11]
	mov	r12, r11
	mov	rdi, r9
	cmp	r9, r10
	jge	.Lsort_timings_block_23
.Lsort_timings_block_13:
	mov	rbp, r9
	jmp	.Lsort_timings_block_15
	.p2align 6
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_14:
	mov	rbp, rax
.Lsort_timings_block_15:
	lea	r8, 1[rbp]
	lea	rax, -1[r8+r8]
	mov	rdx, r8
	sal	rdx, 4
	lea	r12, [rsi+rax*8]
	vmovsd	xmm1, QWORD PTR [rdx+rsi]
	vmovsd	xmm0, QWORD PTR [r12]
	vcomisd	xmm0, xmm1
	ja	.Lsort_timings_block_16
	vmovapd	xmm0, xmm1
	lea	r12, [rdx+rsi]
	lea	rax, [r8+r8]
.Lsort_timings_block_16:
	vmovsd	QWORD PTR [rsi+rbp*8], xmm0
	cmp	r10, rax
	jg	.Lsort_timings_block_14
	test	bl, 1
	jne	.Lsort_timings_block_17
	cmp	rdi, rax
	je	.Lsort_timings_block_43
.Lsort_timings_block_17:
	lea	rdx, -1[rax]
.Lsort_timings_block_18:
	sar	rdx
	cmp	r9, rax
	jl	.Lsort_timings_block_20
	jmp	.Lsort_timings_block_24
	.p2align 6
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_19:
	vmovsd	QWORD PTR [rax], xmm0
	lea	rax, -1[rdx]
	shr	rax, 63
	lea	r8, -1[rax+rdx]
	mov	rax, rdx
	cmp	r9, rdx
	jge	.Lsort_timings_block_39
	mov	rdx, r8
	sar	rdx
.Lsort_timings_block_20:
	lea	rbp, [rsi+rdx*8]
	lea	rax, [rsi+rax*8]
	vmovsd	xmm0, QWORD PTR 0[rbp]
	vcomisd	xmm2, xmm0
	ja	.Lsort_timings_block_19
.Lsort_timings_block_21:
	vmovsd	QWORD PTR [rax], xmm2
	test	r9, r9
	je	.Lsort_timings_block_28
.Lsort_timings_block_22:
	sub	r11, 8
	dec	r9
	vmovsd	xmm2, QWORD PTR [r11]
	mov	r12, r11
	cmp	r9, r10
	jl	.Lsort_timings_block_13
.Lsort_timings_block_23:
	test	bl, 1
	jne	.Lsort_timings_block_24
	cmp	r9, rdi
	je	.Lsort_timings_block_42
.Lsort_timings_block_24:
	vmovsd	QWORD PTR [r12], xmm2
	jmp	.Lsort_timings_block_22
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_25:
	vmovsd	QWORD PTR [rsi], xmm2
	vmovsd	QWORD PTR [rax], xmm0
	vmovsd	xmm0, QWORD PTR 8[rsi]
	vmovsd	xmm1, QWORD PTR [rsi]
	jmp	.Lsort_timings_block_3
.Lsort_timings_block_26:
	vmovsd	QWORD PTR [rsi], xmm2
.Lsort_timings_block_27:
	add	rsp, 32
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	ret
.Lsort_timings_block_28:
	mov	rax, rcx
	sub	rax, rsi
	cmp	rax, 8
	jle	.Lsort_timings_block_27
	lea	r9, -8[rcx]
	lea	r8, -8[rax]
.Lsort_timings_block_29:
	vmovsd	xmm0, QWORD PTR [rsi]
	mov	rdi, r8
	vmovsd	xmm2, QWORD PTR [r9]
	sar	rdi, 3
	vmovsd	QWORD PTR [r9], xmm0
	cmp	r8, 16
	jle	.Lsort_timings_block_40
	lea	rbx, -1[rdi]
	xor	r10d, r10d
	sar	rbx
	jmp	.Lsort_timings_block_31
	.p2align 6
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_30:
	mov	r10, rax
.Lsort_timings_block_31:
	lea	rcx, 1[r10]
	lea	rax, -1[rcx+rcx]
	mov	rdx, rcx
	sal	rdx, 4
	lea	r11, [rsi+rax*8]
	vmovsd	xmm1, QWORD PTR [rdx+rsi]
	vmovsd	xmm0, QWORD PTR [r11]
	vcomisd	xmm0, xmm1
	ja	.Lsort_timings_block_32
	vmovapd	xmm0, xmm1
	lea	r11, [rdx+rsi]
	lea	rax, [rcx+rcx]
.Lsort_timings_block_32:
	vmovsd	QWORD PTR [rsi+r10*8], xmm0
	cmp	rbx, rax
	jg	.Lsort_timings_block_30
	and	edi, 1
	jne	.Lsort_timings_block_33
	mov	rdx, r8
	sar	rdx, 4
	dec	rdx
	cmp	rdx, rax
	je	.Lsort_timings_block_41
.Lsort_timings_block_33:
	lea	rdx, -1[rax]
	shr	rdx, 63
	lea	rdx, -1[rax+rdx]
	sar	rdx
	test	rax, rax
	jne	.Lsort_timings_block_35
	jmp	.Lsort_timings_block_44
	.p2align 6
	.p2align 4,,10
	.p2align 3
.Lsort_timings_block_34:
	vmovsd	QWORD PTR [rax], xmm0
	lea	rax, -1[rdx]
	shr	rax, 63
	lea	rcx, -1[rax+rdx]
	mov	rax, rdx
	test	rdx, rdx
	je	.Lsort_timings_block_38
	sar	rcx
	mov	rdx, rcx
.Lsort_timings_block_35:
	lea	r10, [rsi+rdx*8]
	lea	rax, [rsi+rax*8]
	vmovsd	xmm0, QWORD PTR [r10]
	vcomisd	xmm2, xmm0
	ja	.Lsort_timings_block_34
.Lsort_timings_block_36:
	vmovsd	QWORD PTR [rax], xmm2
	cmp	r8, 8
	jle	.Lsort_timings_block_27
.Lsort_timings_block_37:
	sub	r9, 8
	sub	r8, 8
	jmp	.Lsort_timings_block_29
.Lsort_timings_block_38:
	mov	rax, r10
	jmp	.Lsort_timings_block_36
.Lsort_timings_block_39:
	mov	rax, rbp
	jmp	.Lsort_timings_block_21
.Lsort_timings_block_40:
	and	edi, 1
	jne	.Lsort_timings_block_26
	mov	rax, rsi
	cmp	r8, 16
	jne	.Lsort_timings_block_36
	mov	r11, rsi
	xor	eax, eax
.Lsort_timings_block_41:
	lea	rcx, 1[rax+rax]
	mov	rdx, rax
	vmovsd	xmm0, QWORD PTR [rsi+rcx*8]
	mov	rax, rcx
	vmovsd	QWORD PTR [r11], xmm0
	jmp	.Lsort_timings_block_35
.Lsort_timings_block_42:
	mov	rax, r9
.Lsort_timings_block_43:
	lea	rdx, [rax+rax]
	lea	rax, 1[rdx]
	lea	r8, [rsi+rax*8]
	vmovsd	xmm0, QWORD PTR [r8]
	vmovsd	QWORD PTR [r12], xmm0
	mov	r12, r8
	jmp	.Lsort_timings_block_18
.Lsort_timings_block_44:
	vmovsd	QWORD PTR [r11], xmm2
	jmp	.Lsort_timings_block_37
	.seh_endproc

# benchmark_folder
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: run_test_folder()
.section .text$benchmark_folder,"x"
.p2align 4
.globl benchmark_folder
.def benchmark_folder; .scl 2; .type 32; .endef
	.seh_proc	benchmark_folder
benchmark_folder:
.Lbenchmark_folder_block_0:
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
	sub	rsp, 280
	.seh_stackalloc	280
	vmovaps	XMMWORD PTR 256[rsp], xmm6
	.seh_savexmm	xmm6, 256
	.seh_endprologue
	xor	ecx, ecx
.Lbenchmark_folder_block_1:
	call	memory_region_create
.Lbenchmark_folder_block_2:
	lea	rdx, constant_44[rip]
	lea	rcx, 208[rsp]
	lea	r8, 45[rdx]
	mov	QWORD PTR 56[rsp], rax
.Lbenchmark_folder_block_3:
	call	path_convert_utf8
.Lbenchmark_folder_block_4:
	lea	rcx, 240[rsp]
.Lbenchmark_folder_block_5:
	call	"_ZNSt10filesystem7__cxx114path5_ListC1Ev"
.Lbenchmark_folder_block_6:
	lea	rcx, 208[rsp]
.Lbenchmark_folder_block_7:
	call	"_ZNSt10filesystem7__cxx114path14_M_split_cmptsEv"
.Lbenchmark_folder_block_8:
	lea	rcx, 112[rsp]
	xor	r9d, r9d
	lea	rdx, 208[rsp]
	xor	r8d, r8d
.Lbenchmark_folder_block_9:
	call	"_ZNSt10filesystem7__cxx1118directory_iteratorC1ERKNS0_4pathENS_17directory_optionsEPSt10error_code"
.Lbenchmark_folder_block_10:
	mov	rdx, QWORD PTR 240[rsp]
	test	rdx, rdx
	je	.Lbenchmark_folder_block_11
	lea	rcx, 240[rsp]
	call	"_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE"
.Lbenchmark_folder_block_11:
	mov	rcx, QWORD PTR 208[rsp]
	lea	rbp, 224[rsp]
	cmp	rcx, rbp
	je	.Lbenchmark_folder_block_12
	mov	rax, QWORD PTR 224[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
.Lbenchmark_folder_block_12:
	vmovdqa	xmm0, XMMWORD PTR 112[rsp]
	vpextrq	rax, xmm0, 1
	test	rax, rax
	je	.Lbenchmark_folder_block_28
	mov	edx, 1
	lock xadd	DWORD PTR 8[rax], edx
	cmp	edx, 2147483647
	je	.Lbenchmark_folder_block_115
	mov	rcx, QWORD PTR 120[rsp]
	vmovdqa	XMMWORD PTR 128[rsp], xmm0
	test	rcx, rcx
	je	.Lbenchmark_folder_block_14
	lea	rax, 8[rcx]
	mov	edx, 1
	lock xadd	DWORD PTR [rax], edx
	cmp	edx, 2147483647
	je	.Lbenchmark_folder_block_115
	mov	r8, QWORD PTR 8[rcx]
	movabs	rdx, 4294967297
	cmp	r8, rdx
	je	.Lbenchmark_folder_block_58
	lock dec	DWORD PTR [rax]
	je	.Lbenchmark_folder_block_86
.Lbenchmark_folder_block_13:
	mov	rax, QWORD PTR 136[rsp]
.Lbenchmark_folder_block_14:
	mov	QWORD PTR 64[rsp], 0
	vpcmpeqd	ymm0, ymm0, ymm0
	xor	esi, esi
	xor	ebx, ebx
	mov	DWORD PTR 40[rsp], 0
	xor	r15d, r15d
	vpsrlw	xmm6, xmm0, 8
	mov	DWORD PTR 52[rsp], 0
	vmovdqu	YMMWORD PTR 80[rsp], ymm0
	vzeroupper
.Lbenchmark_folder_block_15:
	test	rax, rax
	je	.Lbenchmark_folder_block_29
	lea	rcx, 128[rsp]
	lea	rdi, 192[rsp]
	call	"_ZNKSt10filesystem7__cxx1118directory_iteratordeEv"
	mov	QWORD PTR 176[rsp], rdi
	mov	r12, QWORD PTR 8[rax]
	mov	r13, QWORD PTR [rax]
	lea	r8, 1[r12]
	cmp	r12, 7
	ja	.Lbenchmark_folder_block_53
	test	r12, r12
	je	.Lbenchmark_folder_block_37
	add	r8, r8
	lea	rdx, 192[rsp]
	mov	rax, r13
	cmp	r8d, 8
	jnb	.Lbenchmark_folder_block_62
.Lbenchmark_folder_block_16:
	xor	ecx, ecx
	test	r8b, 4
	jne	.Lbenchmark_folder_block_65
	and	r8d, 2
	jne	.Lbenchmark_folder_block_64
.Lbenchmark_folder_block_17:
	mov	rdi, QWORD PTR 176[rsp]
	lea	rax, [r12+r12]
	mov	QWORD PTR 184[rsp], r12
	mov	QWORD PTR 72[rsp], rax
	lea	r14, [rdi+rax]
	sar	rax
	mov	QWORD PTR 208[rsp], rbp
	lea	rbp, 224[rsp]
	mov	r12, rax
.Lbenchmark_folder_block_18:
	mov	rax, rbp
.Lbenchmark_folder_block_19:
	lea	rdx, -2[r14]
	sub	rdx, rdi
	mov	r8, rdx
	shr	r8
	lea	r10, 1[r8]
	lea	rcx, [rax+r10]
	cmp	rdi, rcx
	jnb	.Lbenchmark_folder_block_20
	cmp	rax, r14
	jb	.Lbenchmark_folder_block_66
.Lbenchmark_folder_block_20:
	cmp	rdx, 60
	jbe	.Lbenchmark_folder_block_78
	vmovdqu	ymm5, YMMWORD PTR 80[rsp]
	mov	rdx, r10
	mov	rcx, r10
	xor	r9d, r9d
	shr	rdx, 5
	and	rcx, -32
	vpsrlw	ymm1, ymm5, 8
	.p2align 6
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_21:
	vpand	ymm0, ymm1, YMMWORD PTR [rdi+r9*2]
	vpand	ymm2, ymm1, YMMWORD PTR 32[rdi+r9*2]
	vpackuswb	ymm0, ymm0, ymm2
	vpermq	ymm0, ymm0, 216
	vmovdqu	YMMWORD PTR [rax+r9], ymm0
	add	r9, 32
	cmp	r9, rcx
	jne	.Lbenchmark_folder_block_21
	cmp	rcx, r10
	je	.Lbenchmark_folder_block_87
	sal	rdx, 6
	lea	r9, [rax+rcx]
	add	rdx, rdi
	vzeroupper
.Lbenchmark_folder_block_22:
	sub	r8, rcx
	cmp	r8, 14
	jbe	.Lbenchmark_folder_block_79
	lea	r10, [rdi+rcx*2]
	lea	r11, 1[r8]
	vpand	xmm0, xmm6, XMMWORD PTR [r10]
	vpand	xmm1, xmm6, XMMWORD PTR 16[r10]
	mov	r13, r11
	mov	r10, r11
	shr	r13, 4
	and	r10, -16
	and	r11d, 15
	vpackuswb	xmm0, xmm0, xmm1
	vmovdqu	XMMWORD PTR [rax+rcx], xmm0
	je	.Lbenchmark_folder_block_25
	sal	r13, 5
	add	r9, r10
	add	rdx, r13
.Lbenchmark_folder_block_23:
	sub	r8, r10
	cmp	r8, 6
	jbe	.Lbenchmark_folder_block_24
	add	r10, rcx
	vmovq	xmm1, QWORD PTR constant_47[rip]
	inc	r8
	lea	rcx, [rdi+r10*2]
	mov	r11, r8
	vmovq	xmm0, QWORD PTR [rcx]
	vmovq	xmm2, QWORD PTR 8[rcx]
	shr	r11, 3
	vpand	xmm0, xmm1, xmm0
	vpand	xmm1, xmm1, xmm2
	vpackuswb	xmm0, xmm0, xmm1
	vpshufd	xmm0, xmm0, 8
	vmovq	QWORD PTR [rax+r10], xmm0
	mov	rax, r8
	and	rax, -8
	and	r8d, 7
	je	.Lbenchmark_folder_block_25
	sal	r11, 4
	add	r9, rax
	add	rdx, r11
.Lbenchmark_folder_block_24:
	movzx	eax, WORD PTR [rdx]
	mov	BYTE PTR [r9], al
	lea	rax, 2[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 2[rdx]
	mov	BYTE PTR 1[r9], al
	lea	rax, 4[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 4[rdx]
	mov	BYTE PTR 2[r9], al
	lea	rax, 6[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 6[rdx]
	mov	BYTE PTR 3[r9], al
	lea	rax, 8[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 8[rdx]
	mov	BYTE PTR 4[r9], al
	lea	rax, 10[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 10[rdx]
	mov	BYTE PTR 5[r9], al
	lea	rax, 12[rdx]
	cmp	r14, rax
	je	.Lbenchmark_folder_block_25
	movzx	eax, WORD PTR 12[rdx]
	mov	BYTE PTR 6[r9], al
.Lbenchmark_folder_block_25:
	mov	rax, QWORD PTR 208[rsp]
	cmp	QWORD PTR 72[rsp], 6
	mov	BYTE PTR [rax+r12], 0
	mov	QWORD PTR 216[rsp], r12
	mov	r13, QWORD PTR 208[rsp]
	jbe	.Lbenchmark_folder_block_27
	lea	rdi, 0[r13+r12]
	mov	rcx, r13
	mov	r8, r12
.Lbenchmark_folder_block_26:
	sub	r8, 3
	mov	edx, 46
	call	"memchr"
	test	rax, rax
	je	.Lbenchmark_folder_block_27
	cmp	DWORD PTR [rax], 1970499374
	je	.Lbenchmark_folder_block_42
	lea	rcx, 1[rax]
	mov	r8, rdi
	sub	r8, rcx
	cmp	r8, 3
	ja	.Lbenchmark_folder_block_26
.Lbenchmark_folder_block_27:
	cmp	r13, rbp
	je	.Lbenchmark_folder_block_38
	mov	rax, QWORD PTR 224[rsp]
	mov	rcx, r13
	lea	rdx, 1[rax]
	call	"_ZdlPvy"
	jmp	.Lbenchmark_folder_block_38
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_28:
	mov	DWORD PTR 40[rsp], 0
	xor	ebx, ebx
	xor	esi, esi
	xor	r15d, r15d
	mov	DWORD PTR 52[rsp], 0
.Lbenchmark_folder_block_29:
	mov	rcx, QWORD PTR 120[rsp]
	test	rcx, rcx
	je	.Lbenchmark_folder_block_30
	mov	rdx, QWORD PTR 8[rcx]
	movabs	rax, 4294967297
	cmp	rdx, rax
	je	.Lbenchmark_folder_block_60
	lock dec	DWORD PTR 8[rcx]
	je	.Lbenchmark_folder_block_80
.Lbenchmark_folder_block_30:
	vxorps	xmm0, xmm0, xmm0
	test	r15, r15
	js	.Lbenchmark_folder_block_52
	vcvtsi2sd	xmm1, xmm0, r15
.Lbenchmark_folder_block_31:
	mov	eax, DWORD PTR 40[rsp]
	vdivsd	xmm1, xmm1, QWORD PTR constant_50[rip]
	lea	rcx, constant_51[rip]
	vmovq	rdx, xmm1
	vcvtsi2sd	xmm0, xmm0, rax
	vdivsd	xmm3, xmm1, xmm0
	vmovq	r8, xmm3
	vmovapd	xmm2, xmm3
.Lbenchmark_folder_block_32:
	call	__mingw_printf
.Lbenchmark_folder_block_33:
	test	rbx, rbx
	je	.Lbenchmark_folder_block_34
	sub	rsi, rbx
	mov	rcx, rbx
	mov	rdx, rsi
	call	"_ZdlPvy"
.Lbenchmark_folder_block_34:
	mov	edx, DWORD PTR 52[rsp]
	vmovaps	xmm6, XMMWORD PTR 256[rsp]
	lea	rcx, constant_49[rip]
	add	rsp, 280
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
.Lbenchmark_folder_block_35:
	jmp	__mingw_printf
.Lbenchmark_folder_block_36:
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_37:
	movzx	eax, WORD PTR 0[r13]
	mov	QWORD PTR 208[rsp], rbp
	mov	BYTE PTR 224[rsp], 0
	mov	WORD PTR 192[rsp], ax
.Lbenchmark_folder_block_38:
	mov	rcx, QWORD PTR 176[rsp]
	lea	rax, 192[rsp]
	cmp	rcx, rax
	je	.Lbenchmark_folder_block_39
	mov	rax, QWORD PTR 192[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_39:
	lea	rcx, 128[rsp]
.Lbenchmark_folder_block_40:
	call	"_ZNSt10filesystem7__cxx1118directory_iteratorppEv"
.Lbenchmark_folder_block_41:
	mov	rax, QWORD PTR 136[rsp]
	jmp	.Lbenchmark_folder_block_15
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_42:
	sub	rax, r13
	cmp	rax, -1
	je	.Lbenchmark_folder_block_27
	mov	rax, QWORD PTR 64[rsp]
	lea	rdx, 144[rsp]
	mov	rcx, r13
	mov	QWORD PTR 144[rsp], rbx
	mov	QWORD PTR 160[rsp], rsi
	mov	QWORD PTR 152[rsp], rax
.Lbenchmark_folder_block_43:
	call	read_file_into
.Lbenchmark_folder_block_44:
	mov	rax, QWORD PTR 152[rsp]
	mov	rsi, QWORD PTR 160[rsp]
	mov	rbx, QWORD PTR 144[rsp]
	cmp	rax, rsi
	je	.Lbenchmark_folder_block_68
	lea	rdi, 1[rax]
	mov	BYTE PTR [rax], 10
	mov	rax, rsi
	sub	rax, rdi
	cmp	rax, 127
	jbe	.Lbenchmark_folder_block_73
.Lbenchmark_folder_block_45:
	lea	rax, 128[rdi]
	mov	BYTE PTR [rdi], 0
	vpxor	xmm0, xmm0, xmm0
	mov	QWORD PTR 64[rsp], rax
	vmovdqu	YMMWORD PTR 65[rdi], ymm0
	vmovdqu	YMMWORD PTR 1[rdi], ymm0
	vmovdqu	YMMWORD PTR 33[rdi], ymm0
	vmovdqu	YMMWORD PTR 96[rdi], ymm0
	vzeroupper
.Lbenchmark_folder_block_46:
	inc	DWORD PTR 40[rsp]
	mov	eax, DWORD PTR 40[rsp]
	test	eax, 1023
	jne	.Lbenchmark_folder_block_48
	mov	edx, eax
	lea	rcx, constant_49[rip]
.Lbenchmark_folder_block_47:
	call	__mingw_printf
.Lbenchmark_folder_block_48:
	call	"_ZNSt6chrono3_V212steady_clock3nowEv"
	mov	rcx, QWORD PTR 56[rsp]
	mov	rdx, rbx
	mov	QWORD PTR 72[rsp], rax
	mov	rax, QWORD PTR 64[rsp]
	lea	r8, -128[rax]
	call	parse_beatmap_body
.Lbenchmark_folder_block_49:
	call	"_ZNSt6chrono3_V212steady_clock3nowEv"
	mov	rcx, QWORD PTR 208[rsp]
	mov	r12, rax
	mov	rax, QWORD PTR 56[rsp]
	mov	r14, QWORD PTR 1610631712[rax]
	mov	edi, DWORD PTR 1073819944[rax]
	mov	r13d, DWORD PTR 44[rax]
	cmp	rcx, rbp
	je	.Lbenchmark_folder_block_50
	mov	rax, QWORD PTR 224[rsp]
	lea	rdx, 1[rax]
	call	"_ZdlPvy"
.Lbenchmark_folder_block_50:
	mov	rcx, QWORD PTR 176[rsp]
	lea	rax, 192[rsp]
	cmp	rcx, rax
	je	.Lbenchmark_folder_block_51
	mov	rax, QWORD PTR 192[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
.Lbenchmark_folder_block_51:
	xor	edi, r14d
	sub	r12, QWORD PTR 72[rsp]
	xor	edi, DWORD PTR 52[rsp]
	add	r15, r12
	lea	eax, 0[r13+rdi]
	mov	DWORD PTR 52[rsp], eax
	jmp	.Lbenchmark_folder_block_39
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_52:
	mov	rdx, r15
	mov	rax, r15
	shr	rdx
	and	eax, 1
	or	rdx, rax
	vcvtsi2sd	xmm1, xmm0, rdx
	vaddsd	xmm1, xmm1, xmm1
	jmp	.Lbenchmark_folder_block_31
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_53:
	lea	rdi, [r8+r8]
	mov	rcx, rdi
.Lbenchmark_folder_block_54:
	call	"_Znwy"
.Lbenchmark_folder_block_55:
	mov	r8, rdi
	mov	rdx, r13
	mov	rcx, rax
	mov	QWORD PTR 192[rsp], r12
	mov	QWORD PTR 176[rsp], rax
	call	"memcpy"
	lea	rax, [r12+r12]
	mov	rdi, QWORD PTR 176[rsp]
	mov	QWORD PTR 184[rsp], r12
	mov	r13, rax
	mov	QWORD PTR 72[rsp], rax
	sar	r13
	mov	QWORD PTR 208[rsp], rbp
	lea	r14, [rdi+rax]
	mov	QWORD PTR 216[rsp], 0
	mov	r12, r13
	cmp	rax, 30
	jbe	.Lbenchmark_folder_block_18
	lea	rcx, 1[r13]
.Lbenchmark_folder_block_56:
	call	"_Znwy"
.Lbenchmark_folder_block_57:
	mov	QWORD PTR 208[rsp], rax
	mov	QWORD PTR 224[rsp], r13
	jmp	.Lbenchmark_folder_block_19
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_58:
	mov	rax, QWORD PTR [rcx]
	lea	r8, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rcx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, r8
	jne	.Lbenchmark_folder_block_83
.Lbenchmark_folder_block_59:
	mov	rdx, QWORD PTR 24[rax]
	lea	r8, shared_ptr_destroy[rip]
	cmp	rdx, r8
	jne	.Lbenchmark_folder_block_82
	call	[QWORD PTR 8[rax]]
	jmp	.Lbenchmark_folder_block_13
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_60:
	mov	rax, QWORD PTR [rcx]
	lea	r8, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rcx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, r8
	jne	.Lbenchmark_folder_block_84
.Lbenchmark_folder_block_61:
	mov	rdx, QWORD PTR 24[rax]
	lea	r8, shared_ptr_destroy[rip]
	cmp	rdx, r8
	jne	.Lbenchmark_folder_block_85
	call	[QWORD PTR 8[rax]]
	jmp	.Lbenchmark_folder_block_30
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_62:
	mov	ecx, r8d
	xor	eax, eax
	and	ecx, -8
.Lbenchmark_folder_block_63:
	mov	edx, eax
	add	eax, 8
	mov	r9, QWORD PTR 0[r13+rdx]
	mov	QWORD PTR 192[rsp+rdx], r9
	cmp	eax, ecx
	jb	.Lbenchmark_folder_block_63
	lea	rdx, 192[rsp+rax]
	add	rax, r13
	jmp	.Lbenchmark_folder_block_16
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_64:
	movzx	eax, WORD PTR [rax+rcx]
	mov	WORD PTR [rdx+rcx], ax
	jmp	.Lbenchmark_folder_block_17
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_65:
	mov	ecx, DWORD PTR [rax]
	and	r8d, 2
	mov	DWORD PTR [rdx], ecx
	mov	ecx, 4
	je	.Lbenchmark_folder_block_17
	jmp	.Lbenchmark_folder_block_64
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_66:
	xor	edx, edx
	.p2align 4
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_67:
	movzx	ecx, WORD PTR [rdi+rdx*2]
	mov	BYTE PTR [rax+rdx], cl
	inc	rdx
	cmp	r10, rdx
	jne	.Lbenchmark_folder_block_67
	jmp	.Lbenchmark_folder_block_25
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_68:
	mov	rdi, rsi
	movabs	rax, 9223372036854775807
	sub	rdi, rbx
	cmp	rdi, rax
	je	.Lbenchmark_folder_block_105
	test	rdi, rdi
	mov	r12d, 1
	movabs	rax, 9223372036854775807
	cmovne	r12, rdi
	add	r12, rdi
	cmp	r12, rax
	cmova	r12, rax
	mov	rcx, r12
.Lbenchmark_folder_block_69:
	call	"_Znwy"
.Lbenchmark_folder_block_70:
	mov	BYTE PTR [rax+rdi], 10
	mov	r13, rax
	test	rdi, rdi
	je	.Lbenchmark_folder_block_71
	mov	r8, rdi
	mov	rdx, rbx
	mov	rcx, rax
	call	"memcpy"
.Lbenchmark_folder_block_71:
	lea	rdi, 1[r13+rdi]
	test	rbx, rbx
	je	.Lbenchmark_folder_block_72
	sub	rsi, rbx
	mov	rcx, rbx
	mov	rdx, rsi
	call	"_ZdlPvy"
.Lbenchmark_folder_block_72:
	lea	rsi, 0[r13+r12]
	mov	rbx, r13
	mov	rax, rsi
	sub	rax, rdi
	cmp	rax, 127
	ja	.Lbenchmark_folder_block_45
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_73:
	sub	rdi, rbx
	movabs	rax, -9223372036854775680
	add	rax, rdi
	cmp	rax, 127
	jbe	.Lbenchmark_folder_block_101
	mov	r12d, 128
	movabs	rax, 9223372036854775807
	cmp	rdi, r12
	cmovnb	r12, rdi
	add	r12, rdi
	cmp	r12, rax
	cmova	r12, rax
	mov	rcx, r12
.Lbenchmark_folder_block_74:
	call	"_Znwy"
.Lbenchmark_folder_block_75:
	vpxor	xmm0, xmm0, xmm0
	mov	BYTE PTR [rax+rdi], 0
	mov	r13, rax
	vmovdqu	YMMWORD PTR 65[rax+rdi], ymm0
	vmovdqu	YMMWORD PTR 1[rax+rdi], ymm0
	vmovdqu	YMMWORD PTR 33[rax+rdi], ymm0
	vmovdqu	YMMWORD PTR 96[rax+rdi], ymm0
	test	rdi, rdi
	jne	.Lbenchmark_folder_block_81
	vzeroupper
.Lbenchmark_folder_block_76:
	test	rbx, rbx
	je	.Lbenchmark_folder_block_77
	sub	rsi, rbx
	mov	rcx, rbx
	mov	rdx, rsi
	call	"_ZdlPvy"
.Lbenchmark_folder_block_77:
	lea	rax, 128[r13+rdi]
	lea	rsi, 0[r13+r12]
	mov	rbx, r13
	mov	QWORD PTR 64[rsp], rax
	jmp	.Lbenchmark_folder_block_46
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_78:
	mov	r9, rax
	mov	rdx, rdi
	xor	ecx, ecx
	jmp	.Lbenchmark_folder_block_22
	.p2align 4,,10
	.p2align 3
.Lbenchmark_folder_block_79:
	xor	r10d, r10d
	jmp	.Lbenchmark_folder_block_23
.Lbenchmark_folder_block_80:
	call	shared_ptr_release_cold
	jmp	.Lbenchmark_folder_block_30
.Lbenchmark_folder_block_81:
	mov	r8, rdi
	mov	rdx, rbx
	mov	rcx, rax
	vzeroupper
	call	"memcpy"
	jmp	.Lbenchmark_folder_block_76
.Lbenchmark_folder_block_82:
	call	rdx
	mov	rax, QWORD PTR 136[rsp]
	jmp	.Lbenchmark_folder_block_14
.Lbenchmark_folder_block_83:
	mov	QWORD PTR 40[rsp], rcx
	call	rdx
	mov	rcx, QWORD PTR 40[rsp]
	mov	rax, QWORD PTR [rcx]
	jmp	.Lbenchmark_folder_block_59
.Lbenchmark_folder_block_84:
	mov	QWORD PTR 56[rsp], rcx
	call	rdx
	mov	rcx, QWORD PTR 56[rsp]
	mov	rax, QWORD PTR [rcx]
	jmp	.Lbenchmark_folder_block_61
.Lbenchmark_folder_block_85:
	call	rdx
	jmp	.Lbenchmark_folder_block_30
.Lbenchmark_folder_block_86:
	call	shared_ptr_release_cold
	mov	rax, QWORD PTR 136[rsp]
	jmp	.Lbenchmark_folder_block_14
.Lbenchmark_folder_block_87:
	vzeroupper
	jmp	.Lbenchmark_folder_block_25
.Lbenchmark_folder_block_88:
	mov	rdi, rax
	vzeroupper
.Lbenchmark_folder_block_89:
	lea	rcx, 208[rsp]
	call	"_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv"
.Lbenchmark_folder_block_90:
	mov	rcx, rdi
.Lbenchmark_folder_block_91:
	call	"_Unwind_Resume"
.Lbenchmark_folder_block_92:
.Lbenchmark_folder_block_93:
	mov	rdi, rax
	vzeroupper
	jmp	.Lbenchmark_folder_block_90
.Lbenchmark_folder_block_94:
.Lbenchmark_folder_block_95:
	mov	rdi, rax
.Lbenchmark_folder_block_96:
	lea	rcx, 208[rsp]
	vzeroupper
	call	"_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv"
.Lbenchmark_folder_block_97:
	lea	rcx, 176[rsp]
	call	"_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv"
.Lbenchmark_folder_block_98:
	mov	rcx, QWORD PTR 136[rsp]
	test	rcx, rcx
	je	.Lbenchmark_folder_block_99
	call	shared_ptr_release
.Lbenchmark_folder_block_99:
	mov	rcx, QWORD PTR 120[rsp]
	test	rcx, rcx
	je	.Lbenchmark_folder_block_100
	call	shared_ptr_release
.Lbenchmark_folder_block_100:
	test	rbx, rbx
	je	.Lbenchmark_folder_block_90
	sub	rsi, rbx
	mov	rcx, rbx
	mov	rdx, rsi
	call	"_ZdlPvy"
	jmp	.Lbenchmark_folder_block_90
.Lbenchmark_folder_block_101:
	lea	rcx, constant_43[rip]
.Lbenchmark_folder_block_102:
	call	"_ZSt20__throw_length_errorPKc"
.Lbenchmark_folder_block_103:
.Lbenchmark_folder_block_104:
	jmp	.Lbenchmark_folder_block_95
.Lbenchmark_folder_block_105:
	lea	rcx, constant_48[rip]
.Lbenchmark_folder_block_106:
	call	"_ZSt20__throw_length_errorPKc"
.Lbenchmark_folder_block_107:
.Lbenchmark_folder_block_108:
	lea	rcx, 208[rsp]
	mov	rdi, rax
	vzeroupper
	call	path_destroy
	jmp	.Lbenchmark_folder_block_90
.Lbenchmark_folder_block_109:
	mov	rdx, QWORD PTR 240[rsp]
	mov	rdi, rax
	test	rdx, rdx
	je	.Lbenchmark_folder_block_116
	lea	rcx, 240[rsp]
	vzeroupper
	call	"_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE"
	jmp	.Lbenchmark_folder_block_89
.Lbenchmark_folder_block_110:
	mov	rdi, rax
	vzeroupper
	jmp	.Lbenchmark_folder_block_97
.Lbenchmark_folder_block_111:
	mov	rdi, rax
	vzeroupper
	jmp	.Lbenchmark_folder_block_98
.Lbenchmark_folder_block_112:
	mov	rbx, QWORD PTR 144[rsp]
	mov	rsi, QWORD PTR 160[rsp]
	mov	rdi, rax
	jmp	.Lbenchmark_folder_block_96
.Lbenchmark_folder_block_113:
	jmp	.Lbenchmark_folder_block_95
.Lbenchmark_folder_block_114:
	mov	rdi, rax
	vzeroupper
	jmp	.Lbenchmark_folder_block_100
.Lbenchmark_folder_block_115:
	ud2
.Lbenchmark_folder_block_116:
	vzeroupper
	jmp	.Lbenchmark_folder_block_89
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
.Lbenchmark_folder_block_117:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .Lbenchmark_folder_block_119-.Lbenchmark_folder_block_118
.Lbenchmark_folder_block_118:
	.uleb128 .Lbenchmark_folder_block_1-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_2-.Lbenchmark_folder_block_1
	.uleb128 0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_3-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_4-.Lbenchmark_folder_block_3
	.uleb128 .Lbenchmark_folder_block_93-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_5-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_6-.Lbenchmark_folder_block_5
	.uleb128 .Lbenchmark_folder_block_88-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_7-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_8-.Lbenchmark_folder_block_7
	.uleb128 .Lbenchmark_folder_block_109-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_9-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_10-.Lbenchmark_folder_block_9
	.uleb128 .Lbenchmark_folder_block_108-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_32-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_33-.Lbenchmark_folder_block_32
	.uleb128 .Lbenchmark_folder_block_114-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_35-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_36-.Lbenchmark_folder_block_35
	.uleb128 0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_40-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_41-.Lbenchmark_folder_block_40
	.uleb128 .Lbenchmark_folder_block_111-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_43-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_44-.Lbenchmark_folder_block_43
	.uleb128 .Lbenchmark_folder_block_112-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_47-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_49-.Lbenchmark_folder_block_47
	.uleb128 .Lbenchmark_folder_block_113-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_54-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_55-.Lbenchmark_folder_block_54
	.uleb128 .Lbenchmark_folder_block_111-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_56-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_57-.Lbenchmark_folder_block_56
	.uleb128 .Lbenchmark_folder_block_110-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_69-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_70-.Lbenchmark_folder_block_69
	.uleb128 .Lbenchmark_folder_block_104-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_74-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_75-.Lbenchmark_folder_block_74
	.uleb128 .Lbenchmark_folder_block_94-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_91-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_92-.Lbenchmark_folder_block_91
	.uleb128 0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_102-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_103-.Lbenchmark_folder_block_102
	.uleb128 .Lbenchmark_folder_block_94-.Lbenchmark_folder_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_folder_block_106-.Lbenchmark_folder_block_0
	.uleb128 .Lbenchmark_folder_block_107-.Lbenchmark_folder_block_106
	.uleb128 .Lbenchmark_folder_block_104-.Lbenchmark_folder_block_0
	.uleb128 0
.Lbenchmark_folder_block_119:
.section .text$benchmark_folder,"x"
	.seh_endproc

# benchmark_preloaded
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: run_test_prebatch()
.section .text$benchmark_preloaded,"x"
.p2align 4
.globl benchmark_preloaded
.def benchmark_preloaded; .scl 2; .type 32; .endef
	.seh_proc	benchmark_preloaded
benchmark_preloaded:
.Lbenchmark_preloaded_block_0:
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
	sub	rsp, 328
	.seh_stackalloc	328
	vmovaps	XMMWORD PTR 272[rsp], xmm6
	.seh_savexmm	xmm6, 272
	vmovaps	XMMWORD PTR 288[rsp], xmm7
	.seh_savexmm	xmm7, 288
	vmovaps	XMMWORD PTR 304[rsp], xmm8
	.seh_savexmm	xmm8, 304
	.seh_endprologue
	xor	ecx, ecx
.Lbenchmark_preloaded_block_1:
	call	memory_region_create
.Lbenchmark_preloaded_block_2:
	mov	ecx, 2376000
	mov	r15, rax
.Lbenchmark_preloaded_block_3:
	call	"_Znwy"
.Lbenchmark_preloaded_block_4:
	mov	QWORD PTR 96[rsp], rax
	lea	rcx, constant_53[rip]
	add	rax, 2376000
	mov	QWORD PTR 104[rsp], rax
.Lbenchmark_preloaded_block_5:
	call	__mingw_printf
	lea	rdx, constant_44[rip]
	lea	rcx, 224[rsp]
	lea	r8, 45[rdx]
	call	path_convert_utf8
.Lbenchmark_preloaded_block_6:
	lea	rcx, 256[rsp]
.Lbenchmark_preloaded_block_7:
	call	"_ZNSt10filesystem7__cxx114path5_ListC1Ev"
.Lbenchmark_preloaded_block_8:
	lea	rcx, 224[rsp]
.Lbenchmark_preloaded_block_9:
	call	"_ZNSt10filesystem7__cxx114path14_M_split_cmptsEv"
.Lbenchmark_preloaded_block_10:
	lea	rcx, 128[rsp]
	xor	r9d, r9d
	lea	rdx, 224[rsp]
	xor	r8d, r8d
.Lbenchmark_preloaded_block_11:
	call	"_ZNSt10filesystem7__cxx1118directory_iteratorC1ERKNS0_4pathENS_17directory_optionsEPSt10error_code"
.Lbenchmark_preloaded_block_12:
	mov	rdx, QWORD PTR 256[rsp]
	test	rdx, rdx
	je	.Lbenchmark_preloaded_block_13
	lea	rcx, 256[rsp]
	call	"_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE"
.Lbenchmark_preloaded_block_13:
	mov	rcx, QWORD PTR 224[rsp]
	lea	rdi, 240[rsp]
	cmp	rcx, rdi
	je	.Lbenchmark_preloaded_block_14
	mov	rax, QWORD PTR 240[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_14:
	vmovdqa	xmm0, XMMWORD PTR 128[rsp]
	vpextrq	rax, xmm0, 1
	test	rax, rax
	je	.Lbenchmark_preloaded_block_100
	mov	edx, 1
	lock xadd	DWORD PTR 8[rax], edx
	cmp	edx, 2147483647
	je	.Lbenchmark_preloaded_block_181
	mov	rbx, QWORD PTR 136[rsp]
	vmovdqa	XMMWORD PTR 144[rsp], xmm0
	test	rbx, rbx
	je	.Lbenchmark_preloaded_block_16
	lea	rax, 8[rbx]
	mov	edx, 1
	lock xadd	DWORD PTR [rax], edx
	cmp	edx, 2147483647
	je	.Lbenchmark_preloaded_block_181
	mov	rcx, QWORD PTR 8[rbx]
	movabs	rdx, 4294967297
	cmp	rcx, rdx
	je	.Lbenchmark_preloaded_block_111
	lock dec	DWORD PTR [rax]
	je	.Lbenchmark_preloaded_block_155
.Lbenchmark_preloaded_block_15:
	mov	rax, QWORD PTR 152[rsp]
.Lbenchmark_preloaded_block_16:
	mov	rsi, QWORD PTR 96[rsp]
	mov	QWORD PTR 80[rsp], rsi
.Lbenchmark_preloaded_block_17:
	test	rax, rax
	je	.Lbenchmark_preloaded_block_32
	lea	rcx, 144[rsp]
	lea	r12, 208[rsp]
	call	"_ZNKSt10filesystem7__cxx1118directory_iteratordeEv"
	mov	QWORD PTR 192[rsp], r12
	mov	rsi, QWORD PTR 8[rax]
	mov	rbx, QWORD PTR [rax]
	lea	rdx, 1[rsi]
	cmp	rsi, 7
	ja	.Lbenchmark_preloaded_block_101
	test	rsi, rsi
	je	.Lbenchmark_preloaded_block_77
	add	rdx, rdx
	mov	r8, r12
	mov	rax, rbx
	cmp	edx, 8
	jnb	.Lbenchmark_preloaded_block_117
.Lbenchmark_preloaded_block_18:
	xor	ecx, ecx
	test	dl, 4
	jne	.Lbenchmark_preloaded_block_115
	and	edx, 2
	jne	.Lbenchmark_preloaded_block_116
.Lbenchmark_preloaded_block_19:
	mov	QWORD PTR 200[rsp], rsi
	mov	rbx, QWORD PTR 192[rsp]
	add	rsi, rsi
	mov	r13, rsi
	mov	QWORD PTR 224[rsp], rdi
	lea	rdi, 240[rsp]
	lea	rbp, [rbx+rsi]
	sar	r13
.Lbenchmark_preloaded_block_20:
	mov	rdx, rdi
.Lbenchmark_preloaded_block_21:
	lea	rax, -2[rbp]
	sub	rax, rbx
	mov	r9, rax
	shr	r9
	lea	r8, 1[r9]
	lea	rcx, [rdx+r8]
	cmp	rbx, rcx
	jnb	.Lbenchmark_preloaded_block_22
	cmp	rdx, rbp
	jb	.Lbenchmark_preloaded_block_142
.Lbenchmark_preloaded_block_22:
	cmp	rax, 60
	jbe	.Lbenchmark_preloaded_block_145
	mov	r10, r8
	mov	rcx, r8
	vpcmpeqd	ymm1, ymm1, ymm1
	xor	eax, eax
	shr	r10, 5
	vpsrlw	ymm1, ymm1, 8
	and	rcx, -32
.Lbenchmark_preloaded_block_23:
	vpand	ymm0, ymm1, YMMWORD PTR [rbx+rax*2]
	vpand	ymm2, ymm1, YMMWORD PTR 32[rbx+rax*2]
	vpackuswb	ymm0, ymm0, ymm2
	vpermq	ymm0, ymm0, 216
	vmovdqu	YMMWORD PTR [rdx+rax], ymm0
	add	rax, 32
	cmp	rax, rcx
	jne	.Lbenchmark_preloaded_block_23
	cmp	r8, rcx
	je	.Lbenchmark_preloaded_block_164
	mov	rax, r10
	lea	r8, [rdx+rcx]
	sal	rax, 6
	add	rax, rbx
	vzeroupper
.Lbenchmark_preloaded_block_24:
	sub	r9, rcx
	mov	r14, r9
	cmp	r9, 14
	jbe	.Lbenchmark_preloaded_block_144
	lea	r11, 1[r9]
	vpcmpeqd	xmm0, xmm0, xmm0
	lea	r9, [rbx+rcx*2]
	mov	r10, r11
	vpsrlw	xmm0, xmm0, 8
	vpand	xmm1, xmm0, XMMWORD PTR [r9]
	shr	r10, 4
	vpand	xmm0, xmm0, XMMWORD PTR 16[r9]
	mov	QWORD PTR 64[rsp], r10
	mov	r10, r11
	vpackuswb	xmm0, xmm1, xmm0
	and	r10, -16
	and	r11d, 15
	vmovdqu	XMMWORD PTR [rdx+rcx], xmm0
	je	.Lbenchmark_preloaded_block_27
	mov	r9, QWORD PTR 64[rsp]
	add	r8, r10
	sal	r9, 5
	add	rax, r9
.Lbenchmark_preloaded_block_25:
	mov	r9, r14
	sub	r9, r10
	cmp	r9, 6
	jbe	.Lbenchmark_preloaded_block_26
	add	rcx, r10
	vmovq	xmm1, QWORD PTR constant_47[rip]
	inc	r9
	lea	r10, [rbx+rcx*2]
	mov	r11, r9
	vmovq	xmm0, QWORD PTR [r10]
	vmovq	xmm2, QWORD PTR 8[r10]
	shr	r11, 3
	vpand	xmm0, xmm1, xmm0
	vpand	xmm1, xmm1, xmm2
	vpackuswb	xmm0, xmm0, xmm1
	vpshufd	xmm0, xmm0, 8
	vmovq	QWORD PTR [rdx+rcx], xmm0
	mov	rdx, r9
	and	rdx, -8
	and	r9d, 7
	je	.Lbenchmark_preloaded_block_27
	sal	r11, 4
	add	r8, rdx
	add	rax, r11
.Lbenchmark_preloaded_block_26:
	movzx	edx, WORD PTR [rax]
	mov	BYTE PTR [r8], dl
	lea	rdx, 2[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	edx, WORD PTR 2[rax]
	mov	BYTE PTR 1[r8], dl
	lea	rdx, 4[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	edx, WORD PTR 4[rax]
	mov	BYTE PTR 2[r8], dl
	lea	rdx, 6[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	edx, WORD PTR 6[rax]
	mov	BYTE PTR 3[r8], dl
	lea	rdx, 8[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	edx, WORD PTR 8[rax]
	mov	BYTE PTR 4[r8], dl
	lea	rdx, 10[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	edx, WORD PTR 10[rax]
	mov	BYTE PTR 5[r8], dl
	lea	rdx, 12[rax]
	cmp	rbp, rdx
	je	.Lbenchmark_preloaded_block_27
	movzx	eax, WORD PTR 12[rax]
	mov	BYTE PTR 6[r8], al
.Lbenchmark_preloaded_block_27:
	mov	rax, QWORD PTR 224[rsp]
	mov	BYTE PTR [rax+r13], 0
	mov	QWORD PTR 232[rsp], r13
	mov	rbp, QWORD PTR 224[rsp]
	cmp	rsi, 6
	jbe	.Lbenchmark_preloaded_block_29
	lea	rbx, 0[rbp+r13]
	mov	rcx, rbp
	mov	r8, r13
.Lbenchmark_preloaded_block_28:
	sub	r8, 3
	mov	edx, 46
	call	"memchr"
	test	rax, rax
	je	.Lbenchmark_preloaded_block_29
	cmp	DWORD PTR [rax], 1970499374
	je	.Lbenchmark_preloaded_block_91
	lea	rcx, 1[rax]
	mov	r8, rbx
	sub	r8, rcx
	cmp	r8, 3
	ja	.Lbenchmark_preloaded_block_28
.Lbenchmark_preloaded_block_29:
	cmp	rbp, rdi
	je	.Lbenchmark_preloaded_block_78
	mov	rax, QWORD PTR 240[rsp]
	mov	rcx, rbp
	lea	rdx, 1[rax]
	call	"_ZdlPvy"
	jmp	.Lbenchmark_preloaded_block_78
.Lbenchmark_preloaded_block_30:
	mov	rax, QWORD PTR [rbx]
	lea	rcx, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rbx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, rcx
	jne	.Lbenchmark_preloaded_block_166
.Lbenchmark_preloaded_block_31:
	mov	rdx, QWORD PTR 24[rax]
	lea	rcx, shared_ptr_destroy[rip]
	cmp	rdx, rcx
	mov	rcx, rbx
	jne	.Lbenchmark_preloaded_block_165
	call	[QWORD PTR 8[rax]]
.Lbenchmark_preloaded_block_32:
	mov	rbx, QWORD PTR 136[rsp]
	test	rbx, rbx
	je	.Lbenchmark_preloaded_block_33
	mov	rdx, QWORD PTR 8[rbx]
	movabs	rax, 4294967297
	cmp	rdx, rax
	je	.Lbenchmark_preloaded_block_113
	lock dec	DWORD PTR 8[rbx]
	je	.Lbenchmark_preloaded_block_156
.Lbenchmark_preloaded_block_33:
	lea	rcx, constant_54[rip]
.Lbenchmark_preloaded_block_34:
	call	__mingw_printf
	call	[QWORD PTR __imp_GetCurrentThread[rip]]
	mov	edx, 4
	mov	rcx, rax
	call	[QWORD PTR __imp_SetThreadAffinityMask[rip]]
.Lbenchmark_preloaded_block_35:
	mov	rsi, QWORD PTR 80[rsp]
	cmp	QWORD PTR 96[rsp], rsi
	je	.Lbenchmark_preloaded_block_136
	xor	r13d, r13d
	xor	edi, edi
	xor	ebx, ebx
	xor	r12d, r12d
	xor	ebp, ebp
.Lbenchmark_preloaded_block_36:
	mov	rdx, QWORD PTR [rsi]
	mov	r14, QWORD PTR 8[rsi]
	mov	rcx, r15
	sub	r14, rdx
	lea	r8, -129[rdx+r14]
.Lbenchmark_preloaded_block_37:
	call	parse_beatmap_body
.Lbenchmark_preloaded_block_38:
	mov	r8d, DWORD PTR 44[r15]
	mov	edx, DWORD PTR 52[r15]
	lea	rbp, -129[rbp+r14]
	add	r12, r8
	add	r13, rdx
	test	r8d, r8d
	je	.Lbenchmark_preloaded_block_41
	sal	r8, 4
	mov	rax, r15
	lea	rdx, 1610612736[r15]
	add	r8, r15
	.p2align 4,,10
	.p2align 3
.Lbenchmark_preloaded_block_39:
	test	BYTE PTR 1073741836[rax], 2
	je	.Lbenchmark_preloaded_block_40
	mov	r9, QWORD PTR [rdx]
	inc	rbx
	test	r9, r9
	je	.Lbenchmark_preloaded_block_40
	mov	rcx, QWORD PTR 8[rdx]
	sub	rcx, r9
	sar	rcx, 3
	add	rdi, rcx
.Lbenchmark_preloaded_block_40:
	add	rax, 16
	add	rdx, 32
	cmp	r8, rax
	jne	.Lbenchmark_preloaded_block_39
.Lbenchmark_preloaded_block_41:
	add	rsi, 24
	cmp	QWORD PTR 96[rsp], rsi
	jne	.Lbenchmark_preloaded_block_36
	mov	rsi, QWORD PTR 96[rsp]
	movabs	rax, -6148914691236517205
	sub	rsi, QWORD PTR 80[rsp]
	mov	rdx, rsi
	sar	rdx, 3
	imul	rdx, rax
	mov	QWORD PTR 72[rsp], rdx
.Lbenchmark_preloaded_block_42:
	mov	DWORD PTR 56[rsp], 50
	mov	r9, r12
	mov	r8, rbp
	lea	rcx, constant_55[rip]
	mov	QWORD PTR 48[rsp], r13
	mov	QWORD PTR 40[rsp], rdi
	mov	QWORD PTR 32[rsp], rbx
.Lbenchmark_preloaded_block_43:
	call	__mingw_printf
.Lbenchmark_preloaded_block_44:
	test	rsi, rsi
	jne	.Lbenchmark_preloaded_block_137
	mov	QWORD PTR 120[rsp], 0
	xor	r13d, r13d
	mov	QWORD PTR 112[rsp], 0
.Lbenchmark_preloaded_block_45:
	mov	QWORD PTR 88[rsp], 50
	vxorps	xmm6, xmm6, xmm6
	mov	eax, 50
	test	rsi, rsi
	jne	.Lbenchmark_preloaded_block_70
.Lbenchmark_preloaded_block_46:
	dec	rax
	jne	.Lbenchmark_preloaded_block_46
	xor	r14d, r14d
.Lbenchmark_preloaded_block_47:
	mov	rsi, QWORD PTR 120[rsp]
	mov	rdx, QWORD PTR 112[rsp]
	mov	rbx, rsi
	sar	rbx, 3
	cmp	rdx, r13
	je	.Lbenchmark_preloaded_block_141
	xor	eax, eax
	mov	r8d, 63
	lea	rdi, 8[r13]
	mov	rcx, r13
	lzcnt	rax, rbx
	sub	r8d, eax
	movsxd	r8, r8d
	add	r8, r8
	call	sort_timings
	cmp	rsi, 128
	jle	.Lbenchmark_preloaded_block_82
	lea	rcx, 128[r13]
	mov	edx, 8
	jmp	.Lbenchmark_preloaded_block_50
.Lbenchmark_preloaded_block_48:
	mov	eax, 8
	sub	rax, rdx
	add	rax, rdi
	cmp	rdx, 8
	je	.Lbenchmark_preloaded_block_163
	cmp	edx, 32
	jb	.Lbenchmark_preloaded_block_99
	cmp	edx, 64
	ja	.Lbenchmark_preloaded_block_107
	mov	r9d, edx
	vmovdqu	ymm2, YMMWORD PTR 0[r13]
	vmovdqu	ymm0, YMMWORD PTR -32[r13+r9]
	vmovdqu	YMMWORD PTR [rax], ymm2
	vmovdqu	YMMWORD PTR -32[rax+r9], ymm0
.Lbenchmark_preloaded_block_49:
	add	rdi, 8
	vmovsd	QWORD PTR 0[r13], xmm1
	add	rdx, 8
	cmp	rcx, rdi
	je	.Lbenchmark_preloaded_block_53
.Lbenchmark_preloaded_block_50:
	vmovsd	xmm1, QWORD PTR [rdi]
	vmovsd	xmm0, QWORD PTR 0[r13]
	vcomisd	xmm0, xmm1
	ja	.Lbenchmark_preloaded_block_48
	vmovsd	xmm0, QWORD PTR -8[rdi]
	lea	rax, -8[rdi]
	vcomisd	xmm0, xmm1
	jbe	.Lbenchmark_preloaded_block_146
.Lbenchmark_preloaded_block_51:
	vmovsd	QWORD PTR 8[rax], xmm0
	mov	r9, rax
	sub	rax, 8
	vmovsd	xmm0, QWORD PTR [rax]
	vcomisd	xmm0, xmm1
	ja	.Lbenchmark_preloaded_block_51
.Lbenchmark_preloaded_block_52:
	add	rdi, 8
	vmovsd	QWORD PTR [r9], xmm1
	add	rdx, 8
	cmp	rcx, rdi
	jne	.Lbenchmark_preloaded_block_50
.Lbenchmark_preloaded_block_53:
	cmp	QWORD PTR 112[rsp], rcx
	je	.Lbenchmark_preloaded_block_57
.Lbenchmark_preloaded_block_54:
	vmovsd	xmm1, QWORD PTR [rcx]
	vmovsd	xmm0, QWORD PTR -8[rcx]
	mov	rdx, rcx
	lea	rax, -8[rcx]
	vcomisd	xmm0, xmm1
	jbe	.Lbenchmark_preloaded_block_56
	.p2align 5
	.p2align 4,,10
	.p2align 3
.Lbenchmark_preloaded_block_55:
	vmovsd	QWORD PTR 8[rax], xmm0
	mov	rdx, rax
	sub	rax, 8
	vmovsd	xmm0, QWORD PTR [rax]
	vcomisd	xmm0, xmm1
	ja	.Lbenchmark_preloaded_block_55
.Lbenchmark_preloaded_block_56:
	add	rcx, 8
	vmovsd	QWORD PTR [rdx], xmm1
	cmp	rcx, QWORD PTR 112[rsp]
	jne	.Lbenchmark_preloaded_block_54
.Lbenchmark_preloaded_block_57:
	vzeroupper
.Lbenchmark_preloaded_block_58:
	vmovsd	xmm1, QWORD PTR constant_57[rip]
	mov	r9, QWORD PTR 112[rsp]
	mov	rdx, r13
	xor	eax, eax
	movabs	rcx, -9223372036854775808
	jmp	.Lbenchmark_preloaded_block_60
.Lbenchmark_preloaded_block_59:
	add	rdx, 8
	vcvttsd2si	rax, xmm0
	cmp	rdx, r9
	je	.Lbenchmark_preloaded_block_62
.Lbenchmark_preloaded_block_60:
	test	rax, rax
	js	.Lbenchmark_preloaded_block_89
	vcvtsi2sd	xmm0, xmm6, rax
.Lbenchmark_preloaded_block_61:
	vaddsd	xmm0, xmm0, QWORD PTR [rdx]
	vcomisd	xmm0, xmm1
	jb	.Lbenchmark_preloaded_block_59
	vsubsd	xmm0, xmm0, xmm1
	add	rdx, 8
	vcvttsd2si	rax, xmm0
	xor	rax, rcx
	cmp	rdx, r9
	jne	.Lbenchmark_preloaded_block_60
.Lbenchmark_preloaded_block_62:
	test	rax, rax
	js	.Lbenchmark_preloaded_block_106
	vcvtsi2sd	xmm3, xmm6, rax
.Lbenchmark_preloaded_block_63:
	vdivsd	xmm1, xmm3, QWORD PTR constant_50[rip]
.Lbenchmark_preloaded_block_64:
	vcvtsi2sd	xmm6, xmm6, rbx
	vdivsd	xmm5, xmm3, xmm6
	shr	rbx
	vmovq	rdx, xmm1
	mov	r8, QWORD PTR 0[r13+rbx*8]
	lea	rcx, constant_58[rip]
	vmovq	xmm2, r8
	vmovq	r9, xmm5
	vmovapd	xmm3, xmm5
.Lbenchmark_preloaded_block_65:
	call	__mingw_printf
	test	r13, r13
	je	.Lbenchmark_preloaded_block_66
	mov	rdx, QWORD PTR 120[rsp]
	mov	rcx, r13
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_66:
	mov	rax, QWORD PTR 80[rsp]
	cmp	QWORD PTR 96[rsp], rax
	je	.Lbenchmark_preloaded_block_68
	mov	rbx, rax
.Lbenchmark_preloaded_block_67:
	mov	rcx, QWORD PTR [rbx]
	test	rcx, rcx
	je	.Lbenchmark_preloaded_block_90
	mov	rdx, QWORD PTR 16[rbx]
	add	rbx, 24
	sub	rdx, rcx
	call	"_ZdlPvy"
	cmp	QWORD PTR 96[rsp], rbx
	jne	.Lbenchmark_preloaded_block_67
.Lbenchmark_preloaded_block_68:
	mov	rcx, QWORD PTR 80[rsp]
	test	rcx, rcx
	je	.Lbenchmark_preloaded_block_69
	mov	rdx, QWORD PTR 104[rsp]
	sub	rdx, rcx
	call	"_ZdlPvy"
	nop
.Lbenchmark_preloaded_block_69:
	vmovaps	xmm6, XMMWORD PTR 272[rsp]
	vmovaps	xmm7, XMMWORD PTR 288[rsp]
	mov	eax, r14d
	vmovaps	xmm8, XMMWORD PTR 304[rsp]
	add	rsp, 328
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	pop	r12
	pop	r13
	pop	r14
	pop	r15
	ret
.Lbenchmark_preloaded_block_70:
	vmovsd	xmm7, QWORD PTR constant_56[rip]
	xor	r14d, r14d
	vxorpd	xmm8, xmm8, xmm8
	.p2align 4,,10
	.p2align 3
.Lbenchmark_preloaded_block_71:
	mov	rdi, QWORD PTR 80[rsp]
	xor	esi, esi
	.p2align 4,,10
	.p2align 3
.Lbenchmark_preloaded_block_72:
	call	"_ZNSt6chrono3_V212steady_clock3nowEv"
	mov	rbp, QWORD PTR [rdi]
	mov	ebx, 3
	mov	QWORD PTR 64[rsp], rax
	mov	rax, QWORD PTR 8[rdi]
	lea	r12, -129[rax]
.Lbenchmark_preloaded_block_73:
	mov	r8, r12
	mov	rdx, rbp
	mov	rcx, r15
	call	parse_beatmap_body
.Lbenchmark_preloaded_block_74:
	dec	ebx
	jne	.Lbenchmark_preloaded_block_73
	call	"_ZNSt6chrono3_V212steady_clock3nowEv"
	vmovsd	xmm1, QWORD PTR 0[r13+rsi*8]
	sub	rax, QWORD PTR 64[rsp]
	vucomisd	xmm1, xmm8
	vcvtsi2sd	xmm0, xmm6, rax
	vdivsd	xmm0, xmm0, xmm7
	jp	.Lbenchmark_preloaded_block_75
	je	.Lbenchmark_preloaded_block_76
.Lbenchmark_preloaded_block_75:
	vminsd	xmm2, xmm0, xmm1
	vmovapd	xmm0, xmm2
.Lbenchmark_preloaded_block_76:
	vmovsd	QWORD PTR 0[r13+rsi*8], xmm0
	inc	rsi
	add	r14d, DWORD PTR 36[r15]
	add	rdi, 24
	cmp	rsi, QWORD PTR 72[rsp]
	jb	.Lbenchmark_preloaded_block_72
	dec	QWORD PTR 88[rsp]
	jne	.Lbenchmark_preloaded_block_71
	jmp	.Lbenchmark_preloaded_block_47
.Lbenchmark_preloaded_block_77:
	movzx	eax, WORD PTR [rbx]
	mov	QWORD PTR 224[rsp], rdi
	mov	BYTE PTR 240[rsp], 0
	mov	WORD PTR 208[rsp], ax
.Lbenchmark_preloaded_block_78:
	mov	rcx, QWORD PTR 192[rsp]
	cmp	rcx, r12
	je	.Lbenchmark_preloaded_block_79
	mov	rax, QWORD PTR 208[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_79:
	lea	rcx, 144[rsp]
.Lbenchmark_preloaded_block_80:
	call	"_ZNSt10filesystem7__cxx1118directory_iteratorppEv"
.Lbenchmark_preloaded_block_81:
	mov	rax, QWORD PTR 152[rsp]
	jmp	.Lbenchmark_preloaded_block_17
.Lbenchmark_preloaded_block_82:
	cmp	rdi, QWORD PTR 112[rsp]
	je	.Lbenchmark_preloaded_block_58
	mov	ebp, 8
	jmp	.Lbenchmark_preloaded_block_86
.Lbenchmark_preloaded_block_83:
	mov	ecx, 8
	sub	rcx, rbp
	add	rcx, rdi
	cmp	rbp, 8
	jle	.Lbenchmark_preloaded_block_148
	mov	r8, rbp
	mov	rdx, r13
	call	"memmove"
.Lbenchmark_preloaded_block_84:
	vmovsd	QWORD PTR 0[r13], xmm7
.Lbenchmark_preloaded_block_85:
	add	rdi, 8
	add	rbp, 8
	cmp	QWORD PTR 112[rsp], rdi
	je	.Lbenchmark_preloaded_block_58
.Lbenchmark_preloaded_block_86:
	vmovsd	xmm7, QWORD PTR [rdi]
	vmovsd	xmm0, QWORD PTR 0[r13]
	vcomisd	xmm0, xmm7
	ja	.Lbenchmark_preloaded_block_83
	vmovsd	xmm0, QWORD PTR -8[rdi]
	lea	rax, -8[rdi]
	vcomisd	xmm0, xmm7
	jbe	.Lbenchmark_preloaded_block_147
.Lbenchmark_preloaded_block_87:
	vmovsd	QWORD PTR 8[rax], xmm0
	mov	rdx, rax
	sub	rax, 8
	vmovsd	xmm0, QWORD PTR [rax]
	vcomisd	xmm0, xmm7
	ja	.Lbenchmark_preloaded_block_87
.Lbenchmark_preloaded_block_88:
	vmovsd	QWORD PTR [rdx], xmm7
	jmp	.Lbenchmark_preloaded_block_85
.Lbenchmark_preloaded_block_89:
	mov	r8, rax
	and	eax, 1
	shr	r8
	or	r8, rax
	vcvtsi2sd	xmm0, xmm6, r8
	vaddsd	xmm0, xmm0, xmm0
	jmp	.Lbenchmark_preloaded_block_61
.Lbenchmark_preloaded_block_90:
	add	rbx, 24
	cmp	QWORD PTR 96[rsp], rbx
	jne	.Lbenchmark_preloaded_block_67
	jmp	.Lbenchmark_preloaded_block_68
.Lbenchmark_preloaded_block_91:
	sub	rax, rbp
	cmp	rax, -1
	je	.Lbenchmark_preloaded_block_29
	lea	rcx, 160[rsp]
	mov	rdx, rbp
.Lbenchmark_preloaded_block_92:
	call	read_file
.Lbenchmark_preloaded_block_93:
	mov	rax, QWORD PTR 96[rsp]
	mov	rbx, QWORD PTR 160[rsp]
	mov	r13, QWORD PTR 168[rsp]
	mov	rsi, QWORD PTR 176[rsp]
	cmp	QWORD PTR 104[rsp], rax
	je	.Lbenchmark_preloaded_block_119
	vmovq	xmm5, rbx
	mov	QWORD PTR 16[rax], rsi
	add	rax, 24
	vpinsrq	xmm0, xmm5, r13, 1
	vmovdqu	XMMWORD PTR -24[rax], xmm0
	mov	QWORD PTR 96[rsp], rax
.Lbenchmark_preloaded_block_94:
	cmp	rsi, r13
	je	.Lbenchmark_preloaded_block_128
.Lbenchmark_preloaded_block_95:
	mov	BYTE PTR 0[r13], 10
	mov	rax, rsi
	inc	r13
	sub	rax, r13
	cmp	rax, 127
	jbe	.Lbenchmark_preloaded_block_132
.Lbenchmark_preloaded_block_96:
	vpxor	xmm0, xmm0, xmm0
	mov	rax, QWORD PTR 96[rsp]
	mov	BYTE PTR 0[r13], 0
	sub	r13, -128
	vmovdqu	YMMWORD PTR -63[r13], ymm0
	vmovdqu	YMMWORD PTR -127[r13], ymm0
	vmovdqu	YMMWORD PTR -95[r13], ymm0
	vmovdqu	YMMWORD PTR -32[r13], ymm0
	mov	QWORD PTR -16[rax], r13
	vzeroupper
.Lbenchmark_preloaded_block_97:
	mov	rbx, QWORD PTR 96[rsp]
	movabs	rax, -6148914691236517205
	sub	rbx, QWORD PTR 80[rsp]
	mov	rdx, rbx
	sar	rdx, 3
	imul	rdx, rax
	test	edx, 1023
	je	.Lbenchmark_preloaded_block_108
.Lbenchmark_preloaded_block_98:
	mov	rcx, QWORD PTR 224[rsp]
	cmp	rbx, 480000
	ja	.Lbenchmark_preloaded_block_152
	cmp	rcx, rdi
	je	.Lbenchmark_preloaded_block_78
	mov	rax, QWORD PTR 240[rsp]
	lea	rdx, 1[rax]
	call	"_ZdlPvy"
	jmp	.Lbenchmark_preloaded_block_78
.Lbenchmark_preloaded_block_99:
	mov	r9d, edx
	vmovdqu	xmm2, XMMWORD PTR 0[r13]
	vmovdqu	xmm0, XMMWORD PTR -16[r13+r9]
	vmovdqu	XMMWORD PTR [rax], xmm2
	vmovdqu	XMMWORD PTR -16[rax+r9], xmm0
	jmp	.Lbenchmark_preloaded_block_49
.Lbenchmark_preloaded_block_100:
	vmovdqa	XMMWORD PTR 144[rsp], xmm0
	xor	eax, eax
	jmp	.Lbenchmark_preloaded_block_16
.Lbenchmark_preloaded_block_101:
	lea	rbp, [rdx+rdx]
	mov	rcx, rbp
.Lbenchmark_preloaded_block_102:
	call	"_Znwy"
.Lbenchmark_preloaded_block_103:
	mov	r8, rbp
	mov	rdx, rbx
	mov	rcx, rax
	mov	QWORD PTR 208[rsp], rsi
	mov	QWORD PTR 192[rsp], rax
	call	"memcpy"
	mov	QWORD PTR 200[rsp], rsi
	add	rsi, rsi
	mov	rbx, QWORD PTR 192[rsp]
	mov	r14, rsi
	mov	QWORD PTR 224[rsp], rdi
	sar	r14
	mov	QWORD PTR 232[rsp], 0
	lea	rbp, [rbx+rsi]
	mov	r13, r14
	cmp	rsi, 30
	jbe	.Lbenchmark_preloaded_block_20
	lea	rcx, 1[r14]
.Lbenchmark_preloaded_block_104:
	call	"_Znwy"
.Lbenchmark_preloaded_block_105:
	mov	QWORD PTR 224[rsp], rax
	mov	rdx, rax
	mov	QWORD PTR 240[rsp], r14
	jmp	.Lbenchmark_preloaded_block_21
.Lbenchmark_preloaded_block_106:
	mov	rdx, rax
	and	eax, 1
	shr	rdx
	or	rdx, rax
	vcvtsi2sd	xmm3, xmm6, rdx
	vaddsd	xmm3, xmm3, xmm3
	jmp	.Lbenchmark_preloaded_block_63
.Lbenchmark_preloaded_block_107:
	mov	r9d, edx
	vmovdqu	ymm4, YMMWORD PTR 0[r13]
	vmovdqu	ymm3, YMMWORD PTR 32[r13]
	lea	r10, 0[r13+r9]
	vmovdqu	ymm2, YMMWORD PTR -32[r10]
	vmovdqu	ymm0, YMMWORD PTR -64[r10]
	vmovdqu	YMMWORD PTR [rax], ymm4
	vmovdqu	YMMWORD PTR 32[rax], ymm3
	vmovdqu	YMMWORD PTR -32[rax+r9], ymm2
	vmovdqu	YMMWORD PTR -64[rax+r9], ymm0
	jmp	.Lbenchmark_preloaded_block_49
.Lbenchmark_preloaded_block_108:
	lea	rcx, constant_49[rip]
.Lbenchmark_preloaded_block_109:
	call	__mingw_printf
.Lbenchmark_preloaded_block_110:
	jmp	.Lbenchmark_preloaded_block_98
.Lbenchmark_preloaded_block_111:
	mov	rax, QWORD PTR [rbx]
	lea	rcx, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rbx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, rcx
	jne	.Lbenchmark_preloaded_block_161
.Lbenchmark_preloaded_block_112:
	mov	rdx, QWORD PTR 24[rax]
	lea	rcx, shared_ptr_destroy[rip]
	cmp	rdx, rcx
	mov	rcx, rbx
	jne	.Lbenchmark_preloaded_block_160
	call	[QWORD PTR 8[rax]]
	mov	rax, QWORD PTR 152[rsp]
	jmp	.Lbenchmark_preloaded_block_16
.Lbenchmark_preloaded_block_113:
	mov	rax, QWORD PTR [rbx]
	lea	rcx, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rbx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, rcx
	jne	.Lbenchmark_preloaded_block_159
.Lbenchmark_preloaded_block_114:
	mov	rdx, QWORD PTR 24[rax]
	lea	rcx, shared_ptr_destroy[rip]
	cmp	rdx, rcx
	mov	rcx, rbx
	jne	.Lbenchmark_preloaded_block_158
	call	[QWORD PTR 8[rax]]
	jmp	.Lbenchmark_preloaded_block_33
.Lbenchmark_preloaded_block_115:
	mov	ecx, DWORD PTR [rax]
	and	edx, 2
	mov	DWORD PTR [r8], ecx
	mov	ecx, 4
	je	.Lbenchmark_preloaded_block_19
.Lbenchmark_preloaded_block_116:
	movzx	eax, WORD PTR [rax+rcx]
	mov	WORD PTR [r8+rcx], ax
	jmp	.Lbenchmark_preloaded_block_19
.Lbenchmark_preloaded_block_117:
	mov	r8d, edx
	xor	eax, eax
	and	r8d, -8
.Lbenchmark_preloaded_block_118:
	mov	ecx, eax
	add	eax, 8
	mov	r9, QWORD PTR [rbx+rcx]
	mov	QWORD PTR [r12+rcx], r9
	cmp	eax, r8d
	jb	.Lbenchmark_preloaded_block_118
	lea	r8, [r12+rax]
	add	rax, rbx
	jmp	.Lbenchmark_preloaded_block_18
.Lbenchmark_preloaded_block_119:
	mov	r8, QWORD PTR 104[rsp]
	movabs	rax, -6148914691236517205
	sub	r8, QWORD PTR 80[rsp]
	mov	rdx, r8
	sar	rdx, 3
	imul	rdx, rax
	movabs	rax, 384307168202282325
	cmp	rdx, rax
	je	.Lbenchmark_preloaded_block_194
	test	rdx, rdx
	mov	eax, 1
	mov	QWORD PTR 64[rsp], r8
	cmovne	rax, rdx
	add	rax, rdx
	movabs	rdx, 384307168202282325
	cmp	rax, rdx
	cmova	rax, rdx
	lea	rbp, [rax+rax*2]
	sal	rbp, 3
	mov	rcx, rbp
.Lbenchmark_preloaded_block_120:
	call	"_Znwy"
.Lbenchmark_preloaded_block_121:
	mov	r8, QWORD PTR 64[rsp]
	vmovq	xmm4, rbx
	mov	r14, rax
	vpinsrq	xmm0, xmm4, r13, 1
	mov	QWORD PTR 16[rax+r8], rsi
	mov	rsi, QWORD PTR 80[rsp]
	vmovdqu	XMMWORD PTR [rax+r8], xmm0
	mov	rax, QWORD PTR 96[rsp]
	cmp	rax, rsi
	je	.Lbenchmark_preloaded_block_157
	sub	rax, 24
	movabs	rdx, 768614336404564651
	mov	r10, rsi
	sub	rax, rsi
	shr	rax, 3
	imul	rax, rdx
	movabs	rdx, 2305843009213693951
	and	rax, rdx
	je	.Lbenchmark_preloaded_block_150
	mov	rdx, r14
	mov	r11, r14
	sub	rdx, rsi
	sub	rdx, 8
	cmp	rdx, 80
	jbe	.Lbenchmark_preloaded_block_150
	lea	r9, 1[rax]
	cmp	rax, 2
	jbe	.Lbenchmark_preloaded_block_149
	mov	rcx, r9
	shr	rcx, 2
	lea	rdx, [rcx+rcx*2]
	sal	rdx, 5
	lea	r8, [r14+rdx]
.Lbenchmark_preloaded_block_122:
	vmovdqu	ymm1, YMMWORD PTR 32[r10]
	vmovdqu	ymm0, YMMWORD PTR 64[r10]
	add	r11, 96
	add	r10, 96
	vmovdqu	ymm2, YMMWORD PTR -96[r10]
	vmovdqu	YMMWORD PTR -64[r11], ymm1
	vmovdqu	YMMWORD PTR -96[r11], ymm2
	vmovdqu	YMMWORD PTR -32[r11], ymm0
	cmp	r8, r11
	jne	.Lbenchmark_preloaded_block_122
	sal	rcx, 2
	cmp	rcx, r9
	je	.Lbenchmark_preloaded_block_125
	add	rdx, QWORD PTR 80[rsp]
	cmp	rcx, rax
	je	.Lbenchmark_preloaded_block_124
	sub	r9, rcx
.Lbenchmark_preloaded_block_123:
	mov	rsi, QWORD PTR 80[rsp]
	lea	rcx, [rcx+rcx*2]
	mov	r10, r9
	sal	rcx, 3
	shr	r10
	lea	r11, [rsi+rcx]
	vmovdqu	xmm1, XMMWORD PTR 16[r11]
	vmovdqu	xmm0, XMMWORD PTR 32[r11]
	vmovdqu	xmm2, XMMWORD PTR [r11]
	vmovdqu	XMMWORD PTR 16[r14+rcx], xmm1
	vmovdqu	XMMWORD PTR [r14+rcx], xmm2
	vmovdqu	XMMWORD PTR 32[r14+rcx], xmm0
	mov	rcx, r9
	and	rcx, -2
	and	r9d, 1
	je	.Lbenchmark_preloaded_block_125
	add	rcx, r10
	sal	rcx, 4
	add	r8, rcx
	add	rdx, rcx
.Lbenchmark_preloaded_block_124:
	vmovdqu	xmm0, XMMWORD PTR [rdx]
	mov	rdx, QWORD PTR 16[rdx]
	mov	QWORD PTR 16[r8], rdx
	vmovdqu	XMMWORD PTR [r8], xmm0
.Lbenchmark_preloaded_block_125:
	lea	rax, [rax+rax*2]
	cmp	QWORD PTR 80[rsp], 0
	lea	rax, 48[r14+rax*8]
	mov	QWORD PTR 96[rsp], rax
	je	.Lbenchmark_preloaded_block_127
	vzeroupper
.Lbenchmark_preloaded_block_126:
	mov	rdx, QWORD PTR 104[rsp]
	mov	rcx, QWORD PTR 80[rsp]
	sub	rdx, rcx
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_127:
	lea	rax, [r14+rbp]
	mov	QWORD PTR 80[rsp], r14
	mov	QWORD PTR 104[rsp], rax
	mov	rax, QWORD PTR 96[rsp]
	mov	r13, QWORD PTR -16[rax]
	mov	rsi, QWORD PTR -8[rax]
	mov	rbx, QWORD PTR -24[rax]
	cmp	rsi, r13
	jne	.Lbenchmark_preloaded_block_95
.Lbenchmark_preloaded_block_128:
	mov	r13, rsi
	movabs	rax, 9223372036854775807
	sub	r13, rbx
	cmp	r13, rax
	je	.Lbenchmark_preloaded_block_172
	test	r13, r13
	mov	ebp, 1
	movabs	rax, 9223372036854775807
	cmovne	rbp, r13
	add	rbp, r13
	cmp	rbp, rax
	cmova	rbp, rax
	mov	rcx, rbp
	vzeroupper
.Lbenchmark_preloaded_block_129:
	call	"_Znwy"
	mov	BYTE PTR [rax+r13], 10
	mov	r14, rax
	test	r13, r13
	je	.Lbenchmark_preloaded_block_130
	mov	r8, r13
	mov	rdx, rbx
	mov	rcx, rax
	call	"memcpy"
.Lbenchmark_preloaded_block_130:
	lea	r13, 1[r14+r13]
	test	rbx, rbx
	je	.Lbenchmark_preloaded_block_131
	mov	rdx, rsi
	mov	rcx, rbx
	sub	rdx, rbx
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_131:
	mov	rax, QWORD PTR 96[rsp]
	lea	rsi, [r14+rbp]
	mov	rbx, r14
	mov	QWORD PTR -24[rax], r14
	mov	QWORD PTR -8[rax], rsi
	mov	rax, rsi
	sub	rax, r13
	cmp	rax, 127
	ja	.Lbenchmark_preloaded_block_96
.Lbenchmark_preloaded_block_132:
	sub	r13, rbx
	movabs	rax, -9223372036854775680
	add	rax, r13
	cmp	rax, 127
	jbe	.Lbenchmark_preloaded_block_167
	mov	eax, 128
	cmp	r13, rax
	cmovnb	rax, r13
	lea	rbp, [rax+r13]
	movabs	rax, 9223372036854775807
	cmp	rbp, rax
	cmova	rbp, rax
	mov	rcx, rbp
	vzeroupper
	call	"_Znwy"
.Lbenchmark_preloaded_block_133:
	vpxor	xmm0, xmm0, xmm0
	mov	BYTE PTR [rax+r13], 0
	mov	r14, rax
	vmovdqu	YMMWORD PTR 65[rax+r13], ymm0
	vmovdqu	YMMWORD PTR 1[rax+r13], ymm0
	vmovdqu	YMMWORD PTR 33[rax+r13], ymm0
	vmovdqu	YMMWORD PTR 96[rax+r13], ymm0
	test	r13, r13
	jne	.Lbenchmark_preloaded_block_162
	vzeroupper
.Lbenchmark_preloaded_block_134:
	test	rbx, rbx
	je	.Lbenchmark_preloaded_block_135
	mov	rdx, rsi
	mov	rcx, rbx
	sub	rdx, rbx
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_135:
	mov	rdx, QWORD PTR 96[rsp]
	lea	rax, 128[r14+r13]
	mov	QWORD PTR -24[rdx], r14
	add	r14, rbp
	mov	QWORD PTR -16[rdx], rax
	mov	QWORD PTR -8[rdx], r14
	jmp	.Lbenchmark_preloaded_block_97
.Lbenchmark_preloaded_block_136:
	mov	QWORD PTR 72[rsp], 0
	xor	ebx, ebx
	xor	r12d, r12d
	xor	ebp, ebp
	xor	r13d, r13d
	xor	edi, edi
	xor	esi, esi
	mov	rdx, QWORD PTR 72[rsp]
	jmp	.Lbenchmark_preloaded_block_42
.Lbenchmark_preloaded_block_137:
	mov	rdi, QWORD PTR 72[rsp]
	lea	rbx, 0[0+rdi*8]
	mov	rcx, rbx
.Lbenchmark_preloaded_block_138:
	call	"_Znwy"
.Lbenchmark_preloaded_block_139:
	mov	QWORD PTR [rax], 0x000000000
	mov	r13, rax
	mov	rax, rdi
	dec	rax
	je	.Lbenchmark_preloaded_block_140
	lea	rcx, 8[r13]
	lea	r8, 0[0+rax*8]
	xor	edx, edx
	call	"memset"
.Lbenchmark_preloaded_block_140:
	lea	rax, 0[r13+rbx]
	mov	QWORD PTR 120[rsp], rbx
	mov	QWORD PTR 112[rsp], rax
	jmp	.Lbenchmark_preloaded_block_45
.Lbenchmark_preloaded_block_141:
	vxorpd	xmm1, xmm1, xmm1
	vmovapd	xmm3, xmm1
	jmp	.Lbenchmark_preloaded_block_64
.Lbenchmark_preloaded_block_142:
	xor	eax, eax
.Lbenchmark_preloaded_block_143:
	movzx	ecx, WORD PTR [rbx+rax*2]
	mov	BYTE PTR [rdx+rax], cl
	inc	rax
	cmp	rax, r8
	jne	.Lbenchmark_preloaded_block_143
	jmp	.Lbenchmark_preloaded_block_27
.Lbenchmark_preloaded_block_144:
	xor	r10d, r10d
	jmp	.Lbenchmark_preloaded_block_25
.Lbenchmark_preloaded_block_145:
	mov	r8, rdx
	mov	rax, rbx
	xor	ecx, ecx
	jmp	.Lbenchmark_preloaded_block_24
.Lbenchmark_preloaded_block_146:
	mov	r9, rdi
	jmp	.Lbenchmark_preloaded_block_52
.Lbenchmark_preloaded_block_147:
	mov	rdx, rdi
	jmp	.Lbenchmark_preloaded_block_88
.Lbenchmark_preloaded_block_148:
	jne	.Lbenchmark_preloaded_block_84
	vmovsd	QWORD PTR [rcx], xmm0
	jmp	.Lbenchmark_preloaded_block_84
.Lbenchmark_preloaded_block_149:
	mov	rdx, rsi
	mov	r8, r14
	xor	ecx, ecx
	jmp	.Lbenchmark_preloaded_block_123
.Lbenchmark_preloaded_block_150:
	mov	rdx, rsi
	mov	rcx, r14
.Lbenchmark_preloaded_block_151:
	vmovdqu	xmm0, XMMWORD PTR [rdx]
	mov	r8, QWORD PTR 16[rdx]
	add	rdx, 24
	add	rcx, 24
	vmovdqu	XMMWORD PTR -24[rcx], xmm0
	mov	QWORD PTR -8[rcx], r8
	cmp	rdx, QWORD PTR 96[rsp]
	jne	.Lbenchmark_preloaded_block_151
	jmp	.Lbenchmark_preloaded_block_125
.Lbenchmark_preloaded_block_152:
	cmp	rcx, rdi
	je	.Lbenchmark_preloaded_block_153
	mov	rax, QWORD PTR 240[rsp]
	lea	rdx, 1[rax]
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_153:
	mov	rcx, QWORD PTR 192[rsp]
	cmp	rcx, r12
	je	.Lbenchmark_preloaded_block_154
	mov	rax, QWORD PTR 208[rsp]
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_154:
	mov	rbx, QWORD PTR 152[rsp]
	test	rbx, rbx
	je	.Lbenchmark_preloaded_block_32
	mov	rdx, QWORD PTR 8[rbx]
	movabs	rax, 4294967297
	cmp	rdx, rax
	je	.Lbenchmark_preloaded_block_30
	lock dec	DWORD PTR 8[rbx]
	jne	.Lbenchmark_preloaded_block_32
	mov	rcx, rbx
	call	shared_ptr_release_cold
	jmp	.Lbenchmark_preloaded_block_32
.Lbenchmark_preloaded_block_155:
	mov	rcx, rbx
	call	shared_ptr_release_cold
	jmp	.Lbenchmark_preloaded_block_15
.Lbenchmark_preloaded_block_156:
	mov	rcx, rbx
	call	shared_ptr_release_cold
	jmp	.Lbenchmark_preloaded_block_33
.Lbenchmark_preloaded_block_157:
	lea	rax, 24[r14]
	cmp	QWORD PTR 80[rsp], 0
	mov	QWORD PTR 96[rsp], rax
	jne	.Lbenchmark_preloaded_block_126
	lea	rax, [r14+rbp]
	mov	r13, QWORD PTR 8[r14]
	mov	rsi, QWORD PTR 16[r14]
	mov	QWORD PTR 80[rsp], r14
	mov	QWORD PTR 104[rsp], rax
	mov	rbx, QWORD PTR [r14]
	jmp	.Lbenchmark_preloaded_block_94
.Lbenchmark_preloaded_block_158:
	call	rdx
	jmp	.Lbenchmark_preloaded_block_33
.Lbenchmark_preloaded_block_159:
	mov	rcx, rbx
	call	rdx
	mov	rax, QWORD PTR [rbx]
	jmp	.Lbenchmark_preloaded_block_114
.Lbenchmark_preloaded_block_160:
	call	rdx
	mov	rax, QWORD PTR 152[rsp]
	jmp	.Lbenchmark_preloaded_block_16
.Lbenchmark_preloaded_block_161:
	mov	rcx, rbx
	call	rdx
	mov	rax, QWORD PTR [rbx]
	jmp	.Lbenchmark_preloaded_block_112
.Lbenchmark_preloaded_block_162:
	mov	r8, r13
	mov	rdx, rbx
	mov	rcx, rax
	vzeroupper
	call	"memcpy"
	jmp	.Lbenchmark_preloaded_block_134
.Lbenchmark_preloaded_block_163:
	vmovsd	QWORD PTR [rax], xmm0
	jmp	.Lbenchmark_preloaded_block_49
.Lbenchmark_preloaded_block_164:
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_27
.Lbenchmark_preloaded_block_165:
	call	rdx
	jmp	.Lbenchmark_preloaded_block_32
.Lbenchmark_preloaded_block_166:
	mov	rcx, rbx
	call	rdx
	mov	rax, QWORD PTR [rbx]
	jmp	.Lbenchmark_preloaded_block_31
.Lbenchmark_preloaded_block_167:
	lea	rcx, constant_43[rip]
	vzeroupper
.Lbenchmark_preloaded_block_168:
	call	"_ZSt20__throw_length_errorPKc"
.Lbenchmark_preloaded_block_169:
.Lbenchmark_preloaded_block_170:
	mov	rbx, rax
	vzeroupper
.Lbenchmark_preloaded_block_171:
	mov	rdi, QWORD PTR 96[rsp]
	cmp	QWORD PTR 80[rsp], rdi
	je	.Lbenchmark_preloaded_block_177
	mov	rdi, QWORD PTR 80[rsp]
	mov	rsi, rdi
	jmp	.Lbenchmark_preloaded_block_204
.Lbenchmark_preloaded_block_172:
	lea	rcx, constant_48[rip]
	vzeroupper
	call	"_ZSt20__throw_length_errorPKc"
.Lbenchmark_preloaded_block_173:
.Lbenchmark_preloaded_block_174:
	mov	rdx, QWORD PTR 256[rsp]
	mov	rbx, rax
	test	rdx, rdx
	jne	.Lbenchmark_preloaded_block_182
	vzeroupper
.Lbenchmark_preloaded_block_175:
	lea	rcx, 224[rsp]
	call	"_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv"
.Lbenchmark_preloaded_block_176:
	mov	rax, QWORD PTR 96[rsp]
	mov	QWORD PTR 80[rsp], rax
.Lbenchmark_preloaded_block_177:
	cmp	QWORD PTR 80[rsp], 0
	je	.Lbenchmark_preloaded_block_178
	mov	rdx, QWORD PTR 104[rsp]
	mov	rcx, QWORD PTR 80[rsp]
	sub	rdx, rcx
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_178:
	mov	rcx, rbx
.Lbenchmark_preloaded_block_179:
	call	"_Unwind_Resume"
.Lbenchmark_preloaded_block_180:
.Lbenchmark_preloaded_block_181:
	ud2
.Lbenchmark_preloaded_block_182:
	lea	rcx, 256[rsp]
	vzeroupper
	call	"_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE"
	jmp	.Lbenchmark_preloaded_block_175
.Lbenchmark_preloaded_block_183:
	mov	rbx, rax
	vzeroupper
.Lbenchmark_preloaded_block_184:
	lea	rcx, 192[rsp]
	call	"_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv"
.Lbenchmark_preloaded_block_185:
	mov	rcx, QWORD PTR 152[rsp]
	test	rcx, rcx
	je	.Lbenchmark_preloaded_block_186
	call	shared_ptr_release
.Lbenchmark_preloaded_block_186:
	mov	rcx, QWORD PTR 136[rsp]
	test	rcx, rcx
	je	.Lbenchmark_preloaded_block_171
	call	shared_ptr_release
	jmp	.Lbenchmark_preloaded_block_171
.Lbenchmark_preloaded_block_187:
.Lbenchmark_preloaded_block_188:
	mov	rbx, rax
	vzeroupper
.Lbenchmark_preloaded_block_189:
	lea	rcx, 224[rsp]
	call	"_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv"
	jmp	.Lbenchmark_preloaded_block_184
.Lbenchmark_preloaded_block_190:
	mov	rbx, rax
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_185
.Lbenchmark_preloaded_block_191:
	mov	rbx, rax
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_176
.Lbenchmark_preloaded_block_192:
	mov	rdi, rax
	test	rbx, rbx
	jne	.Lbenchmark_preloaded_block_197
	vzeroupper
.Lbenchmark_preloaded_block_193:
	mov	rbx, rdi
	jmp	.Lbenchmark_preloaded_block_189
.Lbenchmark_preloaded_block_194:
	lea	rcx, constant_48[rip]
.Lbenchmark_preloaded_block_195:
	call	"_ZSt20__throw_length_errorPKc"
.Lbenchmark_preloaded_block_196:
.Lbenchmark_preloaded_block_197:
	sub	rsi, rbx
	mov	rcx, rbx
	mov	rdx, rsi
	vzeroupper
	call	"_ZdlPvy"
	jmp	.Lbenchmark_preloaded_block_193
.Lbenchmark_preloaded_block_198:
	jmp	.Lbenchmark_preloaded_block_170
.Lbenchmark_preloaded_block_199:
	lea	rcx, 224[rsp]
	mov	rbx, rax
	vzeroupper
	call	path_destroy
	jmp	.Lbenchmark_preloaded_block_176
.Lbenchmark_preloaded_block_200:
	mov	rbx, rax
	xor	eax, eax
	mov	QWORD PTR 104[rsp], rax
	mov	QWORD PTR 96[rsp], rax
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_176
.Lbenchmark_preloaded_block_201:
	mov	rbx, rax
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_175
.Lbenchmark_preloaded_block_202:
	jmp	.Lbenchmark_preloaded_block_188
.Lbenchmark_preloaded_block_203:
	mov	rdi, QWORD PTR 80[rsp]
	mov	rbx, rax
	mov	rsi, rdi
	vzeroupper
.Lbenchmark_preloaded_block_204:
	mov	rcx, QWORD PTR [rdi]
	test	rcx, rcx
	je	.Lbenchmark_preloaded_block_205
	mov	rdx, QWORD PTR 16[rdi]
	sub	rdx, rcx
	call	"_ZdlPvy"
.Lbenchmark_preloaded_block_205:
	add	rdi, 24
	cmp	rdi, QWORD PTR 96[rsp]
	jne	.Lbenchmark_preloaded_block_204
	mov	QWORD PTR 80[rsp], rsi
	jmp	.Lbenchmark_preloaded_block_177
.Lbenchmark_preloaded_block_206:
	mov	rbx, rax
	test	r13, r13
	je	.Lbenchmark_preloaded_block_207
	mov	rdx, QWORD PTR 120[rsp]
	mov	rcx, r13
	vzeroupper
	call	"_ZdlPvy"
	jmp	.Lbenchmark_preloaded_block_171
.Lbenchmark_preloaded_block_207:
	vzeroupper
	jmp	.Lbenchmark_preloaded_block_171
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
.Lbenchmark_preloaded_block_208:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .Lbenchmark_preloaded_block_210-.Lbenchmark_preloaded_block_209
.Lbenchmark_preloaded_block_209:
	.uleb128 .Lbenchmark_preloaded_block_1-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_2-.Lbenchmark_preloaded_block_1
	.uleb128 0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_3-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_4-.Lbenchmark_preloaded_block_3
	.uleb128 .Lbenchmark_preloaded_block_200-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_5-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_6-.Lbenchmark_preloaded_block_5
	.uleb128 .Lbenchmark_preloaded_block_191-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_7-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_8-.Lbenchmark_preloaded_block_7
	.uleb128 .Lbenchmark_preloaded_block_201-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_9-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_10-.Lbenchmark_preloaded_block_9
	.uleb128 .Lbenchmark_preloaded_block_174-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_11-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_12-.Lbenchmark_preloaded_block_11
	.uleb128 .Lbenchmark_preloaded_block_199-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_34-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_35-.Lbenchmark_preloaded_block_34
	.uleb128 .Lbenchmark_preloaded_block_198-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_37-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_38-.Lbenchmark_preloaded_block_37
	.uleb128 .Lbenchmark_preloaded_block_203-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_43-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_44-.Lbenchmark_preloaded_block_43
	.uleb128 .Lbenchmark_preloaded_block_198-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_65-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_74-.Lbenchmark_preloaded_block_65
	.uleb128 .Lbenchmark_preloaded_block_206-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_80-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_81-.Lbenchmark_preloaded_block_80
	.uleb128 .Lbenchmark_preloaded_block_190-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_92-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_93-.Lbenchmark_preloaded_block_92
	.uleb128 .Lbenchmark_preloaded_block_202-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_102-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_103-.Lbenchmark_preloaded_block_102
	.uleb128 .Lbenchmark_preloaded_block_190-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_104-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_105-.Lbenchmark_preloaded_block_104
	.uleb128 .Lbenchmark_preloaded_block_183-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_109-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_110-.Lbenchmark_preloaded_block_109
	.uleb128 .Lbenchmark_preloaded_block_187-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_120-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_121-.Lbenchmark_preloaded_block_120
	.uleb128 .Lbenchmark_preloaded_block_192-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_129-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_133-.Lbenchmark_preloaded_block_129
	.uleb128 .Lbenchmark_preloaded_block_187-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_138-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_139-.Lbenchmark_preloaded_block_138
	.uleb128 .Lbenchmark_preloaded_block_169-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_168-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_173-.Lbenchmark_preloaded_block_168
	.uleb128 .Lbenchmark_preloaded_block_187-.Lbenchmark_preloaded_block_0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_179-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_180-.Lbenchmark_preloaded_block_179
	.uleb128 0
	.uleb128 0
	.uleb128 .Lbenchmark_preloaded_block_195-.Lbenchmark_preloaded_block_0
	.uleb128 .Lbenchmark_preloaded_block_196-.Lbenchmark_preloaded_block_195
	.uleb128 .Lbenchmark_preloaded_block_192-.Lbenchmark_preloaded_block_0
	.uleb128 0
.Lbenchmark_preloaded_block_210:
.section .text$benchmark_preloaded,"x"
	.seh_endproc

# main
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: main
.section .text$main,"x"
.linkonce discard
.p2align 4
.globl main
.def main; .scl 2; .type 32; .endef
	.seh_proc	main
main:
.Lmain_block_0:
	sub	rsp, 40
	.seh_stackalloc	40
	.seh_endprologue
	call	"__main"
	call	benchmark_preloaded
	xor	eax, eax
	add	rsp, 40
	ret
	.seh_endproc
