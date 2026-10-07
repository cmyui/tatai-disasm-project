.intel_syntax noprefix

# read_file_into
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: read_file2(char const*, std::vector<unsigned char, std::allocator<unsigned char> >&)
.section .text$read_file_into,"x"
.p2align 4
.globl read_file_into
.def read_file_into; .scl 2; .type 32; .endef
	.seh_proc	read_file_into
read_file_into:
.Lread_file_into_block_0:
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
	sub	rsp, 584
	.seh_stackalloc	584
	.seh_endprologue
	mov	rax, QWORD PTR [rdx]
	mov	r12, rcx
	mov	rbx, rdx
	cmp	QWORD PTR 8[rdx], rax
	je	.Lread_file_into_block_1
	mov	QWORD PTR 8[rdx], rax
.Lread_file_into_block_1:
	lea	rcx, 304[rsp]
	lea	rbp, 80[rsp]
	call	"_ZNSt8ios_baseC2Ev"
	mov	rax, QWORD PTR runtime_ref_86[rip]
	xor	edx, edx
	vpxor	xmm0, xmm0, xmm0
	mov	WORD PTR 528[rsp], dx
	xor	edx, edx
	add	rax, 16
	vmovdqu	YMMWORD PTR 536[rsp], ymm0
	mov	QWORD PTR 304[rsp], rax
	mov	rax, QWORD PTR runtime_ref_85[rip]
	mov	QWORD PTR 520[rsp], 0
	mov	rdi, QWORD PTR 8[rax]
	mov	r13, QWORD PTR 16[rax]
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 80[rsp], rdi
	mov	QWORD PTR 80[rsp+rax], r13
	mov	QWORD PTR 88[rsp], 0
	mov	rcx, QWORD PTR -24[rdi]
	add	rcx, rbp
	vzeroupper
.Lread_file_into_block_2:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E"
.Lread_file_into_block_3:
	mov	rsi, QWORD PTR runtime_ref_84[rip]
	lea	rcx, 96[rsp]
	lea	rax, 24[rsi]
	mov	QWORD PTR 80[rsp], rax
	lea	rax, 64[rsi]
	mov	QWORD PTR 304[rsp], rax
.Lread_file_into_block_4:
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev"
.Lread_file_into_block_5:
	lea	rdx, 96[rsp]
	lea	rcx, 304[rsp]
.Lread_file_into_block_6:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E"
	mov	r8d, 14
	mov	rdx, r12
	lea	rcx, 96[rsp]
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode"
	mov	rdx, QWORD PTR 80[rsp]
	mov	rcx, QWORD PTR -24[rdx]
	add	rcx, rbp
	test	rax, rax
	je	.Lread_file_into_block_19
	xor	edx, edx
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
.Lread_file_into_block_7:
.Lread_file_into_block_8:
	lea	rcx, 168[rsp]
	call	"_ZNKSt12__basic_fileIcE7is_openEv"
	test	al, al
	je	.Lread_file_into_block_14
	lea	rcx, 64[rsp]
	mov	rdx, rbp
.Lread_file_into_block_9:
	call	"_ZNSi5tellgEv"
	mov	rax, QWORD PTR 8[rbx]
	mov	r10, QWORD PTR [rbx]
	mov	r12, QWORD PTR 64[rsp]
	mov	r9, rax
	sub	r9, r10
	cmp	r9, r12
	jb	.Lread_file_into_block_22
	cmp	r12, r9
	jb	.Lread_file_into_block_18
.Lread_file_into_block_10:
	test	r12, r12
	je	.Lread_file_into_block_12
.Lread_file_into_block_11:
	xor	r8d, r8d
	xor	edx, edx
	mov	rcx, rbp
	call	"_ZNSi5seekgExSt12_Ios_Seekdir"
	mov	rdx, QWORD PTR [rbx]
	mov	r8, r12
	mov	rcx, rbp
	call	"_ZNSi4readEPcx"
.Lread_file_into_block_12:
	lea	rcx, 96[rsp]
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv"
.Lread_file_into_block_13:
	test	rax, rax
	je	.Lread_file_into_block_29
.Lread_file_into_block_14:
	lea	rax, 24[rsi]
	lea	rcx, 96[rsp]
	add	rsi, 64
	mov	QWORD PTR 80[rsp], rax
	mov	rax, QWORD PTR runtime_ref_83[rip]
	mov	QWORD PTR 304[rsp], rsi
	add	rax, 16
	mov	QWORD PTR 96[rsp], rax
.Lread_file_into_block_15:
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv"
.Lread_file_into_block_16:
.Lread_file_into_block_17:
	lea	rcx, 168[rsp]
	call	"_ZNSt12__basic_fileIcED1Ev"
	mov	rax, QWORD PTR runtime_ref_82[rip]
	lea	rcx, 152[rsp]
	add	rax, 16
	mov	QWORD PTR 96[rsp], rax
	call	"_ZNSt6localeD1Ev"
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 80[rsp], rdi
	lea	rcx, 304[rsp]
	mov	QWORD PTR 80[rsp+rax], r13
	mov	rax, QWORD PTR runtime_ref_86[rip]
	mov	QWORD PTR 88[rsp], 0
	add	rax, 16
	mov	QWORD PTR 304[rsp], rax
	call	"_ZNSt8ios_baseD2Ev"
	nop
	add	rsp, 584
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
.Lread_file_into_block_18:
	add	r10, r12
	cmp	rax, r10
	je	.Lread_file_into_block_10
	mov	QWORD PTR 8[rbx], r10
	jmp	.Lread_file_into_block_10
	.p2align 4,,10
	.p2align 3
.Lread_file_into_block_19:
	mov	edx, DWORD PTR 32[rcx]
	or	edx, 4
.Lread_file_into_block_20:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
.Lread_file_into_block_21:
	jmp	.Lread_file_into_block_8
	.p2align 4,,10
	.p2align 3
.Lread_file_into_block_22:
	mov	rcx, QWORD PTR 16[rbx]
	mov	rdx, r12
	sub	rdx, r9
	mov	r14, rcx
	sub	rcx, rax
	cmp	rcx, rdx
	jnb	.Lread_file_into_block_27
	movabs	rax, 9223372036854775807
	sub	rax, r9
	cmp	rax, rdx
	jb	.Lread_file_into_block_30
	cmp	r9, rdx
	mov	rax, rdx
	mov	QWORD PTR 48[rsp], rdx
	cmovnb	rax, r9
	mov	QWORD PTR 56[rsp], r10
	mov	QWORD PTR 40[rsp], r9
	lea	rdx, [rax+r9]
	movabs	rax, 9223372036854775807
	cmp	rdx, rax
	cmovbe	rax, rdx
	mov	rcx, rax
	mov	r15, rax
.Lread_file_into_block_23:
	call	"_Znwy"
	mov	rdx, QWORD PTR 48[rsp]
	mov	r9, QWORD PTR 40[rsp]
	mov	r11, rax
	mov	r10, QWORD PTR 56[rsp]
	dec	rdx
	mov	BYTE PTR [rax+r9], 0
	je	.Lread_file_into_block_24
	lea	rcx, 1[rax+r9]
	mov	r8, rdx
	xor	edx, edx
	mov	QWORD PTR 48[rsp], r9
	mov	QWORD PTR 40[rsp], r10
	mov	QWORD PTR 56[rsp], rax
	call	"memset"
	mov	r11, QWORD PTR 56[rsp]
	mov	r9, QWORD PTR 48[rsp]
	mov	r10, QWORD PTR 40[rsp]
.Lread_file_into_block_24:
	test	r9, r9
	je	.Lread_file_into_block_25
	mov	rdx, r10
	mov	rcx, r11
	mov	r8, r9
	mov	QWORD PTR 40[rsp], r10
	call	"memcpy"
	mov	r10, QWORD PTR 40[rsp]
	mov	r11, rax
.Lread_file_into_block_25:
	test	r10, r10
	je	.Lread_file_into_block_26
	mov	rdx, r14
	mov	rcx, r10
	mov	QWORD PTR 40[rsp], r11
	sub	rdx, r10
	call	"_ZdlPvy"
	mov	r11, QWORD PTR 40[rsp]
.Lread_file_into_block_26:
	lea	rax, [r11+r12]
	mov	QWORD PTR [rbx], r11
	add	r11, r15
	mov	QWORD PTR 8[rbx], rax
	mov	QWORD PTR 16[rbx], r11
	jmp	.Lread_file_into_block_11
	.p2align 4,,10
	.p2align 3
.Lread_file_into_block_27:
	mov	r8, rdx
	mov	BYTE PTR [rax], 0
	lea	rcx, 1[rax]
	dec	r8
	je	.Lread_file_into_block_28
	lea	r14, [rax+rdx]
	xor	edx, edx
	call	"memset"
	mov	rcx, r14
.Lread_file_into_block_28:
	mov	QWORD PTR 8[rbx], rcx
	jmp	.Lread_file_into_block_11
	.p2align 4,,10
	.p2align 3
.Lread_file_into_block_29:
	mov	rax, QWORD PTR 80[rsp]
	mov	rcx, QWORD PTR -24[rax]
	add	rcx, rbp
	mov	edx, DWORD PTR 32[rcx]
	or	edx, 4
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
	jmp	.Lread_file_into_block_14
.Lread_file_into_block_30:
	lea	rcx, constant_43[rip]
	call	"_ZSt20__throw_length_errorPKc"
.Lread_file_into_block_31:
.Lread_file_into_block_32:
	lea	rcx, 96[rsp]
	mov	rbx, rax
	vzeroupper
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev"
.Lread_file_into_block_33:
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 80[rsp], rdi
	mov	QWORD PTR 80[rsp+rax], r13
	xor	eax, eax
	mov	QWORD PTR 88[rsp], rax
	jmp	.Lread_file_into_block_37
.Lread_file_into_block_34:
	mov	rbx, rax
	mov	rcx, rbp
	vzeroupper
	call	"_ZNSt14basic_ifstreamIcSt11char_traitsIcEED1Ev"
	mov	rcx, rbx
.Lread_file_into_block_35:
	call	"_Unwind_Resume"
.Lread_file_into_block_36:
	mov	rbx, rax
	vzeroupper
.Lread_file_into_block_37:
	mov	rax, QWORD PTR runtime_ref_86[rip]
	lea	rcx, 304[rsp]
	add	rax, 16
	mov	QWORD PTR 304[rsp], rax
	call	"_ZNSt8ios_baseD2Ev"
	mov	rcx, rbx
	call	"_Unwind_Resume"
.Lread_file_into_block_38:
.Lread_file_into_block_39:
	mov	rbx, rax
	vzeroupper
	jmp	.Lread_file_into_block_33
.Lread_file_into_block_40:
	mov	rcx, rax
	vzeroupper
	call	"__cxa_begin_catch"
	call	"__cxa_end_catch"
	jmp	.Lread_file_into_block_17
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
	.align 4
.Lread_file_into_block_41:
	.byte	0xff
	.byte	0x9b
	.uleb128 .Lread_file_into_block_45-.Lread_file_into_block_42
.Lread_file_into_block_42:
	.byte	0x1
	.uleb128 .Lread_file_into_block_44-.Lread_file_into_block_43
.Lread_file_into_block_43:
	.uleb128 .Lread_file_into_block_2-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_3-.Lread_file_into_block_2
	.uleb128 .Lread_file_into_block_36-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_4-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_5-.Lread_file_into_block_4
	.uleb128 .Lread_file_into_block_39-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_6-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_7-.Lread_file_into_block_6
	.uleb128 .Lread_file_into_block_32-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_9-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_13-.Lread_file_into_block_9
	.uleb128 .Lread_file_into_block_34-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_15-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_16-.Lread_file_into_block_15
	.uleb128 .Lread_file_into_block_40-.Lread_file_into_block_0
	.uleb128 0x1
	.uleb128 .Lread_file_into_block_20-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_21-.Lread_file_into_block_20
	.uleb128 .Lread_file_into_block_32-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_23-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_31-.Lread_file_into_block_23
	.uleb128 .Lread_file_into_block_34-.Lread_file_into_block_0
	.uleb128 0
	.uleb128 .Lread_file_into_block_35-.Lread_file_into_block_0
	.uleb128 .Lread_file_into_block_38-.Lread_file_into_block_35
	.uleb128 0
	.uleb128 0
.Lread_file_into_block_44:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.Lread_file_into_block_45:
.section .text$read_file_into,"x"
	.seh_endproc

# read_file
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: read_file(char const*)
.section .text$read_file,"x"
.p2align 4
.globl read_file
.def read_file; .scl 2; .type 32; .endef
	.seh_proc	read_file
read_file:
.Lread_file_block_0:
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
	sub	rsp, 568
	.seh_stackalloc	568
	.seh_endprologue
	mov	rsi, rcx
	lea	rcx, 288[rsp]
	mov	rbp, rdx
	call	"_ZNSt8ios_baseC2Ev"
	mov	rax, QWORD PTR runtime_ref_86[rip]
	xor	edx, edx
	vpxor	xmm0, xmm0, xmm0
	mov	WORD PTR 512[rsp], dx
	lea	rcx, 64[rsp]
	xor	edx, edx
	add	rax, 16
	vmovdqu	YMMWORD PTR 520[rsp], ymm0
	mov	QWORD PTR 288[rsp], rax
	mov	rax, QWORD PTR runtime_ref_85[rip]
	mov	QWORD PTR 504[rsp], 0
	mov	rdi, QWORD PTR 8[rax]
	mov	r14, QWORD PTR 16[rax]
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 64[rsp], rdi
	mov	QWORD PTR 64[rsp+rax], r14
	mov	QWORD PTR 72[rsp], 0
	add	rcx, QWORD PTR -24[rdi]
	vzeroupper
.Lread_file_block_1:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E"
.Lread_file_block_2:
	mov	rbx, QWORD PTR runtime_ref_84[rip]
	lea	rcx, 80[rsp]
	lea	rax, 24[rbx]
	mov	QWORD PTR 64[rsp], rax
	lea	rax, 64[rbx]
	mov	QWORD PTR 288[rsp], rax
.Lread_file_block_3:
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEEC1Ev"
.Lread_file_block_4:
	lea	rdx, 80[rsp]
	lea	rcx, 288[rsp]
.Lread_file_block_5:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE4initEPSt15basic_streambufIcS1_E"
	mov	r8d, 14
	mov	rdx, rbp
	lea	rcx, 80[rsp]
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE4openEPKcSt13_Ios_Openmode"
	mov	rdx, QWORD PTR 64[rsp]
	lea	rcx, 64[rsp]
	add	rcx, QWORD PTR -24[rdx]
	test	rax, rax
	je	.Lread_file_block_22
	xor	edx, edx
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
.Lread_file_block_6:
.Lread_file_block_7:
	lea	rcx, 152[rsp]
	call	"_ZNKSt12__basic_fileIcE7is_openEv"
	test	al, al
	je	.Lread_file_block_29
	lea	rcx, 48[rsp]
	lea	rdx, 64[rsp]
.Lread_file_block_8:
	call	"_ZNSi5tellgEv"
	mov	r13, QWORD PTR 48[rsp]
	test	r13, r13
	js	.Lread_file_block_35
	je	.Lread_file_block_25
	mov	rcx, r13
	call	"_Znwy"
.Lread_file_block_9:
	mov	rbp, rax
	mov	r8, r13
	lea	rax, [rax+r13]
	mov	QWORD PTR 40[rsp], rax
	lea	r15, 1[rbp]
	mov	BYTE PTR 0[rbp], 0
	dec	r8
	jne	.Lread_file_block_21
.Lread_file_block_10:
	xor	r8d, r8d
	xor	edx, edx
	lea	rcx, 64[rsp]
.Lread_file_block_11:
	call	"_ZNSi5seekgExSt12_Ios_Seekdir"
	mov	r8, r13
	mov	rdx, rbp
	lea	rcx, 64[rsp]
	call	"_ZNSi4readEPcx"
.Lread_file_block_12:
.Lread_file_block_13:
	lea	rcx, 80[rsp]
.Lread_file_block_14:
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv"
.Lread_file_block_15:
	test	rax, rax
	je	.Lread_file_block_26
.Lread_file_block_16:
	mov	rax, QWORD PTR 40[rsp]
	mov	QWORD PTR [rsi], rbp
	mov	QWORD PTR 8[rsi], r15
	mov	QWORD PTR 16[rsi], rax
.Lread_file_block_17:
	lea	rax, 24[rbx]
	lea	rcx, 80[rsp]
	add	rbx, 64
	mov	QWORD PTR 64[rsp], rax
	mov	rax, QWORD PTR runtime_ref_83[rip]
	mov	QWORD PTR 288[rsp], rbx
	add	rax, 16
	mov	QWORD PTR 80[rsp], rax
.Lread_file_block_18:
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEE5closeEv"
.Lread_file_block_19:
.Lread_file_block_20:
	lea	rcx, 152[rsp]
	call	"_ZNSt12__basic_fileIcED1Ev"
	mov	rax, QWORD PTR runtime_ref_82[rip]
	lea	rcx, 136[rsp]
	add	rax, 16
	mov	QWORD PTR 80[rsp], rax
	call	"_ZNSt6localeD1Ev"
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 64[rsp], rdi
	lea	rcx, 288[rsp]
	mov	QWORD PTR 64[rsp+rax], r14
	mov	rax, QWORD PTR runtime_ref_86[rip]
	mov	QWORD PTR 72[rsp], 0
	add	rax, 16
	mov	QWORD PTR 288[rsp], rax
	call	"_ZNSt8ios_baseD2Ev"
	mov	rax, rsi
	add	rsp, 568
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
.Lread_file_block_21:
	mov	rcx, r15
	xor	edx, edx
	call	"memset"
	mov	r15, QWORD PTR 40[rsp]
	jmp	.Lread_file_block_10
	.p2align 4,,10
	.p2align 3
.Lread_file_block_22:
	mov	edx, DWORD PTR 32[rcx]
	or	edx, 4
.Lread_file_block_23:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
.Lread_file_block_24:
	jmp	.Lread_file_block_7
	.p2align 4,,10
	.p2align 3
.Lread_file_block_25:
	mov	QWORD PTR 40[rsp], 0
	xor	ebp, ebp
	xor	r15d, r15d
	jmp	.Lread_file_block_13
	.p2align 4,,10
	.p2align 3
.Lread_file_block_26:
	mov	rax, QWORD PTR 64[rsp]
	lea	rcx, 64[rsp]
	add	rcx, QWORD PTR -24[rax]
	mov	edx, DWORD PTR 32[rcx]
	or	edx, 4
.Lread_file_block_27:
	call	"_ZNSt9basic_iosIcSt11char_traitsIcEE5clearESt12_Ios_Iostate"
.Lread_file_block_28:
	jmp	.Lread_file_block_16
	.p2align 4,,10
	.p2align 3
.Lread_file_block_29:
	vpxor	xmm0, xmm0, xmm0
	mov	QWORD PTR 16[rsi], 0
	vmovdqu	XMMWORD PTR [rsi], xmm0
	jmp	.Lread_file_block_17
.Lread_file_block_30:
	mov	rbx, rax
.Lread_file_block_31:
	mov	rdx, r13
	mov	rcx, rbp
	vzeroupper
	call	"_ZdlPvy"
.Lread_file_block_32:
	lea	rcx, 64[rsp]
	call	"_ZNSt14basic_ifstreamIcSt11char_traitsIcEED1Ev"
	mov	rcx, rbx
.Lread_file_block_33:
	call	"_Unwind_Resume"
.Lread_file_block_34:
.Lread_file_block_35:
	lea	rcx, constant_52[rip]
.Lread_file_block_36:
	call	"_ZSt20__throw_length_errorPKc"
.Lread_file_block_37:
.Lread_file_block_38:
	mov	rbx, rax
	vzeroupper
.Lread_file_block_39:
	mov	rax, QWORD PTR -24[rdi]
	mov	QWORD PTR 64[rsp], rdi
	mov	QWORD PTR 64[rsp+rax], r14
	xor	eax, eax
	mov	QWORD PTR 72[rsp], rax
	jmp	.Lread_file_block_41
.Lread_file_block_40:
	mov	rbx, rax
	vzeroupper
.Lread_file_block_41:
	mov	rax, QWORD PTR runtime_ref_86[rip]
	lea	rcx, 288[rsp]
	add	rax, 16
	mov	QWORD PTR 288[rsp], rax
	call	"_ZNSt8ios_baseD2Ev"
	mov	rcx, rbx
.Lread_file_block_42:
	call	"_Unwind_Resume"
.Lread_file_block_43:
.Lread_file_block_44:
	mov	rbx, rax
	test	rbp, rbp
	jne	.Lread_file_block_31
	vzeroupper
	jmp	.Lread_file_block_32
.Lread_file_block_45:
	mov	rbx, rax
	vzeroupper
	jmp	.Lread_file_block_32
.Lread_file_block_46:
	lea	rcx, 80[rsp]
	mov	rbx, rax
	vzeroupper
	call	"_ZNSt13basic_filebufIcSt11char_traitsIcEED1Ev"
	jmp	.Lread_file_block_39
.Lread_file_block_47:
	mov	rcx, rax
	vzeroupper
	call	"__cxa_begin_catch"
	call	"__cxa_end_catch"
	jmp	.Lread_file_block_20
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
	.align 4
.Lread_file_block_48:
	.byte	0xff
	.byte	0x9b
	.uleb128 .Lread_file_block_52-.Lread_file_block_49
.Lread_file_block_49:
	.byte	0x1
	.uleb128 .Lread_file_block_51-.Lread_file_block_50
.Lread_file_block_50:
	.uleb128 .Lread_file_block_1-.Lread_file_block_0
	.uleb128 .Lread_file_block_2-.Lread_file_block_1
	.uleb128 .Lread_file_block_40-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_3-.Lread_file_block_0
	.uleb128 .Lread_file_block_4-.Lread_file_block_3
	.uleb128 .Lread_file_block_38-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_5-.Lread_file_block_0
	.uleb128 .Lread_file_block_6-.Lread_file_block_5
	.uleb128 .Lread_file_block_46-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_8-.Lread_file_block_0
	.uleb128 .Lread_file_block_9-.Lread_file_block_8
	.uleb128 .Lread_file_block_45-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_11-.Lread_file_block_0
	.uleb128 .Lread_file_block_12-.Lread_file_block_11
	.uleb128 .Lread_file_block_30-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_14-.Lread_file_block_0
	.uleb128 .Lread_file_block_15-.Lread_file_block_14
	.uleb128 .Lread_file_block_44-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_18-.Lread_file_block_0
	.uleb128 .Lread_file_block_19-.Lread_file_block_18
	.uleb128 .Lread_file_block_47-.Lread_file_block_0
	.uleb128 0x1
	.uleb128 .Lread_file_block_23-.Lread_file_block_0
	.uleb128 .Lread_file_block_24-.Lread_file_block_23
	.uleb128 .Lread_file_block_46-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_27-.Lread_file_block_0
	.uleb128 .Lread_file_block_28-.Lread_file_block_27
	.uleb128 .Lread_file_block_44-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_33-.Lread_file_block_0
	.uleb128 .Lread_file_block_34-.Lread_file_block_33
	.uleb128 0
	.uleb128 0
	.uleb128 .Lread_file_block_36-.Lread_file_block_0
	.uleb128 .Lread_file_block_37-.Lread_file_block_36
	.uleb128 .Lread_file_block_45-.Lread_file_block_0
	.uleb128 0
	.uleb128 .Lread_file_block_42-.Lread_file_block_0
	.uleb128 .Lread_file_block_43-.Lread_file_block_42
	.uleb128 0
	.uleb128 0
.Lread_file_block_51:
	.byte	0x1
	.byte	0
	.align 4
	.long	0

.Lread_file_block_52:
.section .text$read_file,"x"
	.seh_endproc
