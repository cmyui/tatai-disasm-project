.intel_syntax noprefix

# memory_commit
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: byte_allocator::commit_memory(void*, unsigned long long)
.section .text$memory_commit,"x"
.p2align 4
.globl memory_commit
.def memory_commit; .scl 2; .type 32; .endef
	.seh_proc	memory_commit
memory_commit:
.Lmemory_commit_block_0:
	.seh_endprologue
	mov	r9d, 4
	mov	r8d, 4096
	rex.W jmp	[QWORD PTR __imp_VirtualAlloc[rip]]
	.seh_endproc

# memory_resize
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: byte_allocator::NOINLINE_resize(unsigned long long, void*, unsigned int&)
.section .text$memory_resize,"x"
.p2align 4
.globl memory_resize
.def memory_resize; .scl 2; .type 32; .endef
	.seh_proc	memory_resize
memory_resize:
.Lmemory_resize_block_0:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	r11, rdx
	mov	edx, DWORD PTR [r8]
	mov	r10, r8
	cmp	rdx, rcx
	jb	.Lmemory_resize_block_3
.Lmemory_resize_block_1:
	mov	rax, r11
.Lmemory_resize_block_2:
	add	rsp, 32
	pop	rbx
	ret
	.p2align 4,,10
	.p2align 3
.Lmemory_resize_block_3:
	add	rcx, 524287
	xor	eax, eax
	and	rcx, -524288
	mov	rbx, rcx
	cmp	rcx, 536870912
	ja	.Lmemory_resize_block_2
	mov	rax, rcx
	mov	r9d, 4
	lea	rcx, [r11+rdx]
	mov	r8d, 4096
	sub	rax, rdx
	mov	QWORD PTR 56[rsp], r11
	mov	rdx, rax
	mov	QWORD PTR 64[rsp], r10
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Lmemory_resize_block_2
	mov	r10, QWORD PTR 64[rsp]
	mov	r11, QWORD PTR 56[rsp]
	mov	DWORD PTR [r10], ebx
	jmp	.Lmemory_resize_block_1
	.seh_endproc

# memory_region_create
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: create_memory_region(unsigned int)
.section .text$memory_region_create,"x"
.p2align 4
.globl memory_region_create
.def memory_region_create; .scl 2; .type 32; .endef
	.seh_proc	memory_region_create
memory_region_create:
.Lmemory_region_create_block_0:
	push	rbp
	.seh_pushreg	rbp
	push	rdi
	.seh_pushreg	rdi
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 120
	.seh_stackalloc	120
	.seh_endprologue
	movabs	rax, 8589934592
	vpxor	xmm0, xmm0, xmm0
	mov	QWORD PTR 96[rsp], rax
	lea	rax, 80[rsp]
	mov	esi, ecx
	vmovdqa	XMMWORD PTR 80[rsp], xmm0
	mov	QWORD PTR 64[rsp], 1
	mov	QWORD PTR 72[rsp], rax
	call	[QWORD PTR __imp_GetCurrentProcess[rip]]
	lea	rdx, 64[rsp]
	mov	DWORD PTR 48[rsp], 1
	mov	r9d, 8192
	mov	QWORD PTR 40[rsp], rdx
	movabs	r8, 8589934592
	xor	edx, edx
	mov	rcx, rax
	mov	DWORD PTR 32[rsp], 1
	call	[QWORD PTR __imp_VirtualAlloc2[rip]]
	mov	rbp, QWORD PTR __imp_VirtualAlloc[rip]
	mov	r9d, 4
	mov	r8d, 4096
	mov	edx, 4096
	mov	rcx, rax
	mov	rdi, rax
	call	rbp
	xor	edx, edx
	mov	r8d, 4096
	mov	rbx, rax
	mov	rcx, rax
	call	"memset"
	mov	DWORD PTR 76[rbx], esi
	and	esi, 8
	mov	DWORD PTR [rbx], 4096
	jne	.Lmemory_region_create_block_6
	lea	rcx, 536870912[rdi]
	mov	r9d, 4
	mov	r8d, 4096
	mov	edx, 524288
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_1
	mov	DWORD PTR 4[rbx], 524288
.Lmemory_region_create_block_1:
	mov	eax, DWORD PTR 8[rbx]
	cmp	rax, 524287
	jbe	.Lmemory_region_create_block_7
.Lmemory_region_create_block_2:
	mov	eax, DWORD PTR 12[rbx]
	cmp	rax, 524287
	jbe	.Lmemory_region_create_block_8
.Lmemory_region_create_block_3:
	mov	eax, DWORD PTR 16[rbx]
	cmp	rax, 524287
	jbe	.Lmemory_region_create_block_9
.Lmemory_region_create_block_4:
	mov	eax, DWORD PTR 20[rbx]
	cmp	rax, 524287
	jbe	.Lmemory_region_create_block_10
.Lmemory_region_create_block_5:
	mov	eax, DWORD PTR 24[rbx]
	cmp	rax, 524287
	jbe	.Lmemory_region_create_block_11
.Lmemory_region_create_block_6:
	mov	rax, rbx
	add	rsp, 120
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.Lmemory_region_create_block_7:
	mov	edx, 524288
	lea	rcx, 1073741824[rdi+rax]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_2
	mov	DWORD PTR 8[rbx], 524288
	jmp	.Lmemory_region_create_block_2
	.p2align 4,,10
	.p2align 3
.Lmemory_region_create_block_8:
	mov	edx, 524288
	lea	rcx, 1610612736[rdi+rax]
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_3
	mov	DWORD PTR 12[rbx], 524288
	jmp	.Lmemory_region_create_block_3
	.p2align 4,,10
	.p2align 3
.Lmemory_region_create_block_9:
	mov	ecx, 2147483648
	mov	edx, 524288
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	add	rax, rcx
	lea	rcx, [rdi+rax]
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_4
	mov	DWORD PTR 16[rbx], 524288
	jmp	.Lmemory_region_create_block_4
	.p2align 4,,10
	.p2align 3
.Lmemory_region_create_block_10:
	mov	ecx, 2684354560
	mov	edx, 524288
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	add	rax, rcx
	lea	rcx, [rdi+rax]
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_5
	mov	DWORD PTR 20[rbx], 524288
	jmp	.Lmemory_region_create_block_5
	.p2align 4,,10
	.p2align 3
.Lmemory_region_create_block_11:
	mov	ecx, 3221225472
	mov	edx, 524288
	mov	r9d, 4
	mov	r8d, 4096
	sub	rdx, rax
	add	rax, rcx
	lea	rcx, [rdi+rax]
	call	rbp
	test	rax, rax
	je	.Lmemory_region_create_block_6
	mov	DWORD PTR 24[rbx], 524288
	jmp	.Lmemory_region_create_block_6
	.seh_endproc
