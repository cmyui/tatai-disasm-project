.intel_syntax noprefix

# defer_object_header
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: push_error_object_header_list(char const*, _object_header*)
.section .text$defer_object_header,"x"
.p2align 4
.globl defer_object_header
.def defer_object_header; .scl 2; .type 32; .endef
	.seh_proc	defer_object_header
defer_object_header:
.Ldefer_object_header_block_0:
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
	movabs	rbx, -8589934592
	mov	r11d, 3758096384
	mov	DWORD PTR 12[rdx], 0
	and	rbx, rdx
	mov	rbp, rcx
	mov	rdi, rdx
	add	r11, rbx
	mov	esi, DWORD PTR 64[rbx]
	mov	ecx, DWORD PTR 28[rbx]
	lea	eax, 1[rsi]
	mov	DWORD PTR 64[rbx], eax
	sal	rax, 4
	cmp	rcx, rax
	jb	.Ldefer_object_header_block_2
.Ldefer_object_header_block_1:
	sal	rsi, 4
	mov	QWORD PTR [r11+rsi], rbp
	mov	QWORD PTR 8[r11+rsi], rdi
	add	rsp, 56
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.Ldefer_object_header_block_2:
	lea	r10, 524287[rax]
	and	r10, -524288
	cmp	r10, 536870912
	ja	.Ldefer_object_header_block_3
	mov	rdx, r10
	mov	r9d, 4
	mov	r8d, 4096
	mov	QWORD PTR 40[rsp], r10
	sub	rdx, rcx
	add	rcx, r11
	mov	QWORD PTR 32[rsp], r11
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	test	rax, rax
	je	.Ldefer_object_header_block_3
	mov	r10, QWORD PTR 40[rsp]
	mov	r11, QWORD PTR 32[rsp]
	mov	DWORD PTR 28[rbx], r10d
	jmp	.Ldefer_object_header_block_1
	.p2align 4,,10
	.p2align 3
.Ldefer_object_header_block_3:
	xor	r11d, r11d
	jmp	.Ldefer_object_header_block_1
	.seh_endproc

# defer_slider_body
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: push_error_slider_body_list(_slider_data*)
.section .text$defer_slider_body,"x"
.p2align 4
.globl defer_slider_body
.def defer_slider_body; .scl 2; .type 32; .endef
	.seh_proc	defer_slider_body
defer_slider_body:
.Ldefer_slider_body_block_0:
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
	movabs	rsi, -8589934592
	movabs	rbx, 4294967296
	and	rsi, rcx
	mov	rax, QWORD PTR [rcx]
	mov	rbp, QWORD PTR 8[rcx]
	mov	r10, rcx
	mov	edi, DWORD PTR 68[rsi]
	add	rbx, rsi
	mov	QWORD PTR 8[rcx], rax
	mov	ecx, DWORD PTR 32[rsi]
	lea	eax, 1[rdi]
	mov	DWORD PTR 68[rsi], eax
	sal	rax, 4
	cmp	rcx, rax
	jb	.Ldefer_slider_body_block_2
.Ldefer_slider_body_block_1:
	sal	rdi, 4
	mov	QWORD PTR [rbx+rdi], rbp
	mov	QWORD PTR 8[rbx+rdi], r10
	add	rsp, 56
	pop	rbx
	pop	rsi
	pop	rdi
	pop	rbp
	ret
	.p2align 4,,10
	.p2align 3
.Ldefer_slider_body_block_2:
	lea	r11, 524287[rax]
	and	r11, -524288
	cmp	r11, 536870912
	ja	.Ldefer_slider_body_block_3
	mov	rdx, r11
	mov	r9d, 4
	mov	r8d, 4096
	mov	QWORD PTR 96[rsp], r10
	sub	rdx, rcx
	add	rcx, rbx
	mov	QWORD PTR 40[rsp], r11
	call	[QWORD PTR __imp_VirtualAlloc[rip]]
	mov	r10, QWORD PTR 96[rsp]
	test	rax, rax
	je	.Ldefer_slider_body_block_3
	mov	r11, QWORD PTR 40[rsp]
	mov	DWORD PTR 32[rsi], r11d
	jmp	.Ldefer_slider_body_block_1
	.p2align 4,,10
	.p2align 3
.Ldefer_slider_body_block_3:
	xor	ebx, ebx
	jmp	.Ldefer_slider_body_block_1
	.seh_endproc
