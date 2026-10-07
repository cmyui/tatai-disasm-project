.intel_syntax noprefix

# shared_ptr_dispose
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::_Sp_counted_ptr<decltype(nullptr), (__gnu_cxx::_Lock_policy)2>::_M_dispose()
.section .text$_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv,"x"
.linkonce discard
.p2align 4
.globl shared_ptr_dispose
.def shared_ptr_dispose; .scl 2; .type 32; .endef
	.seh_proc	shared_ptr_dispose
shared_ptr_dispose:
.Lshared_ptr_dispose_block_0:
	.seh_endprologue
	ret
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv"
.set "_ZNSt15_Sp_counted_ptrIDnLN9__gnu_cxx12_Lock_policyE2EE10_M_disposeEv", shared_ptr_dispose

# shared_ptr_destroy
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_destroy()
.section .text$_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv,"x"
.linkonce discard
.p2align 4
.globl shared_ptr_destroy
.def shared_ptr_destroy; .scl 2; .type 32; .endef
	.seh_proc	shared_ptr_destroy
shared_ptr_destroy:
.Lshared_ptr_destroy_block_0:
	.seh_endprologue
	mov	rax, QWORD PTR [rcx]
	rex.W jmp	[QWORD PTR 8[rax]]
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv"
.set "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_destroyEv", shared_ptr_destroy

# codecvt_decode
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::__codecvt_abstract_base<wchar_t, char, _Mbstatet>::in(_Mbstatet&, char const*, char const*, char const*&, wchar_t*, wchar_t*, wchar_t*&) const
.section .text$_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_,"x"
.linkonce discard
.p2align 4
.globl codecvt_decode
.def codecvt_decode; .scl 2; .type 32; .endef
	.seh_proc	codecvt_decode
codecvt_decode:
.Lcodecvt_decode_block_0:
	.seh_endprologue
	mov	rax, QWORD PTR [rcx]
	rex.W jmp	[QWORD PTR 32[rax]]
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_"
.set "_ZNKSt23__codecvt_abstract_baseIwc9_MbstatetE2inERS0_PKcS4_RS4_PwS6_RS6_", codecvt_decode

# codecvt_destroy
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::codecvt_utf8_utf16<wchar_t, 1114111ul, (std::codecvt_mode)0>::~codecvt_utf8_utf16()
.section .text$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev,"x"
.linkonce discard
.p2align 4
.globl codecvt_destroy
.def codecvt_destroy; .scl 2; .type 32; .endef
	.seh_proc	codecvt_destroy
codecvt_destroy:
.Lcodecvt_destroy_block_0:
	.seh_endprologue
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	mov	QWORD PTR [rcx], rax
	jmp	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev"
.set "_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED1Ev", codecvt_destroy

# codecvt_delete
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::codecvt_utf8_utf16<wchar_t, 1114111ul, (std::codecvt_mode)0>::~codecvt_utf8_utf16()
.section .text$_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev,"x"
.linkonce discard
.p2align 4
.globl codecvt_delete
.def codecvt_delete; .scl 2; .type 32; .endef
	.seh_proc	codecvt_delete
codecvt_delete:
.Lcodecvt_delete_block_0:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR 40[rsp], rcx
	call	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	mov	rcx, QWORD PTR 40[rsp]
	mov	edx, 32
	add	rsp, 56
	jmp	"_ZdlPvy"
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev"
.set "_ZNSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EED0Ev", codecvt_delete

# path_codecvt_destroy
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::filesystem::__cxx11::path::_Codecvt<wchar_t>::~_Codecvt()
.section .text$_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev,"x"
.linkonce discard
.p2align 4
.globl path_codecvt_destroy
.def path_codecvt_destroy; .scl 2; .type 32; .endef
	.seh_proc	path_codecvt_destroy
path_codecvt_destroy:
.Lpath_codecvt_destroy_block_0:
	.seh_endprologue
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	mov	QWORD PTR [rcx], rax
	jmp	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev"
.set "_ZNSt10filesystem7__cxx114path8_CodecvtIwED1Ev", path_codecvt_destroy

# path_codecvt_delete
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::filesystem::__cxx11::path::_Codecvt<wchar_t>::~_Codecvt()
.section .text$_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev,"x"
.linkonce discard
.p2align 4
.globl path_codecvt_delete
.def path_codecvt_delete; .scl 2; .type 32; .endef
	.seh_proc	path_codecvt_delete
path_codecvt_delete:
.Lpath_codecvt_delete_block_0:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	mov	QWORD PTR [rcx], rax
	mov	QWORD PTR 40[rsp], rcx
	call	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	mov	rcx, QWORD PTR 40[rsp]
	mov	edx, 32
	add	rsp, 56
	jmp	"_ZdlPvy"
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev"
.set "_ZNSt10filesystem7__cxx114path8_CodecvtIwED0Ev", path_codecvt_delete

# path_destroy
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::filesystem::__cxx11::path::~path()
.section .text$_ZNSt10filesystem7__cxx114pathD1Ev,"x"
.linkonce discard
.p2align 4
.globl path_destroy
.def path_destroy; .scl 2; .type 32; .endef
	.seh_proc	path_destroy
path_destroy:
.Lpath_destroy_block_0:
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 32
	.seh_stackalloc	32
	.seh_endprologue
	mov	rdx, QWORD PTR 32[rcx]
	mov	rbx, rcx
	test	rdx, rdx
	je	.Lpath_destroy_block_1
	lea	rcx, 32[rcx]
	call	"_ZNKSt10filesystem7__cxx114path5_List13_Impl_deleterclEPNS2_5_ImplE"
.Lpath_destroy_block_1:
	mov	rcx, QWORD PTR [rbx]
	lea	rax, 16[rbx]
	cmp	rcx, rax
	je	.Lpath_destroy_block_2
	mov	rax, QWORD PTR 16[rbx]
	lea	rdx, 2[rax+rax]
	add	rsp, 32
	pop	rbx
	jmp	"_ZdlPvy"
	.p2align 4,,10
	.p2align 3
.Lpath_destroy_block_2:
	add	rsp, 32
	pop	rbx
	ret
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt10filesystem7__cxx114pathD1Ev"
.set "_ZNSt10filesystem7__cxx114pathD1Ev", path_destroy

# throw_path_conversion_error
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::filesystem::__cxx11::__detail::__throw_conversion_error()
.section .text$_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv,"x"
.linkonce discard
.p2align 4
.globl throw_path_conversion_error
.def throw_path_conversion_error; .scl 2; .type 32; .endef
	.seh_proc	throw_path_conversion_error
throw_path_conversion_error:
.Lthrow_path_conversion_error_block_0:
	push	r13
	.seh_pushreg	r13
	push	r12
	.seh_pushreg	r12
	push	rsi
	.seh_pushreg	rsi
	push	rbx
	.seh_pushreg	rbx
	sub	rsp, 88
	.seh_stackalloc	88
	.seh_endprologue
	mov	ecx, 48
	mov	r12d, 42
	call	"__cxa_allocate_exception"
	mov	rsi, rax
	call	"_ZNSt3_V216generic_categoryEv"
	mov	ecx, 34
	mov	r13, rax
.Lthrow_path_conversion_error_block_1:
	call	"_Znwy"
.Lthrow_path_conversion_error_block_2:
	vmovdqa	ymm0, YMMWORD PTR constant_23[rip]
	mov	BYTE PTR 32[rax], 101
	lea	r8, 32[rsp]
	lea	rdx, 48[rsp]
	mov	BYTE PTR 33[rax], 0
	mov	rcx, rsi
	vmovdqu	YMMWORD PTR [rax], ymm0
	mov	QWORD PTR 48[rsp], rax
	mov	QWORD PTR 64[rsp], 33
	mov	QWORD PTR 56[rsp], 33
	mov	QWORD PTR 32[rsp], r12
	mov	QWORD PTR 40[rsp], r13
	vzeroupper
.Lthrow_path_conversion_error_block_3:
	call	"_ZNSt10filesystem7__cxx1116filesystem_errorC1ERKNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEESt10error_code"
.Lthrow_path_conversion_error_block_4:
	lea	rcx, 48[rsp]
	call	"_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv"
	lea	r8, "_ZNSt10filesystem7__cxx1116filesystem_errorD1Ev"[rip]
	lea	rdx, "_ZTINSt10filesystem7__cxx1116filesystem_errorE"[rip]
	mov	rcx, rsi
.Lthrow_path_conversion_error_block_5:
	call	"__cxa_throw"
.Lthrow_path_conversion_error_block_6:
	lea	rcx, 48[rsp]
	mov	rbx, rax
	vzeroupper
	call	"_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv"
	jmp	.Lthrow_path_conversion_error_block_8
.Lthrow_path_conversion_error_block_7:
	mov	rbx, rax
	vzeroupper
.Lthrow_path_conversion_error_block_8:
	mov	rcx, rsi
	call	"__cxa_free_exception"
	mov	rcx, rbx
	call	"_Unwind_Resume"
	nop
.Lthrow_path_conversion_error_block_9:
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
.Lthrow_path_conversion_error_block_10:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .Lthrow_path_conversion_error_block_12-.Lthrow_path_conversion_error_block_11
.Lthrow_path_conversion_error_block_11:
	.uleb128 .Lthrow_path_conversion_error_block_1-.Lthrow_path_conversion_error_block_0
	.uleb128 .Lthrow_path_conversion_error_block_2-.Lthrow_path_conversion_error_block_1
	.uleb128 .Lthrow_path_conversion_error_block_7-.Lthrow_path_conversion_error_block_0
	.uleb128 0
	.uleb128 .Lthrow_path_conversion_error_block_3-.Lthrow_path_conversion_error_block_0
	.uleb128 .Lthrow_path_conversion_error_block_4-.Lthrow_path_conversion_error_block_3
	.uleb128 .Lthrow_path_conversion_error_block_6-.Lthrow_path_conversion_error_block_0
	.uleb128 0
	.uleb128 .Lthrow_path_conversion_error_block_5-.Lthrow_path_conversion_error_block_0
	.uleb128 .Lthrow_path_conversion_error_block_9-.Lthrow_path_conversion_error_block_5
	.uleb128 0
	.uleb128 0
.Lthrow_path_conversion_error_block_12:
	.section .text$_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv,"x"
	.linkonce discard
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv"
.set "_ZNSt10filesystem7__cxx118__detail24__throw_conversion_errorEv", throw_path_conversion_error

# shared_ptr_release_cold
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release_last_use_cold()
.section .text$_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE24_M_release_last_use_coldEv,"x"
.linkonce discard
.p2align 4
.globl shared_ptr_release_cold
.def shared_ptr_release_cold; .scl 2; .type 32; .endef
	.seh_proc	shared_ptr_release_cold
shared_ptr_release_cold:
.Lshared_ptr_release_cold_block_0:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	lea	rdx, shared_ptr_dispose[rip]
	mov	rax, QWORD PTR [rcx]
	mov	rax, QWORD PTR 16[rax]
	cmp	rax, rdx
	jne	.Lshared_ptr_release_cold_block_3
.Lshared_ptr_release_cold_block_1:
	lock dec	DWORD PTR 12[rcx]
	jne	.Lshared_ptr_release_cold_block_2
	mov	rax, QWORD PTR [rcx]
	lea	r8, shared_ptr_destroy[rip]
	mov	rdx, QWORD PTR 24[rax]
	cmp	rdx, r8
	jne	.Lshared_ptr_release_cold_block_4
	mov	rax, QWORD PTR 8[rax]
	add	rsp, 56
	rex.W jmp	rax
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_cold_block_2:
	add	rsp, 56
	ret
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_cold_block_3:
	mov	QWORD PTR 40[rsp], rcx
	call	rax
	mov	rcx, QWORD PTR 40[rsp]
	jmp	.Lshared_ptr_release_cold_block_1
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_cold_block_4:
	add	rsp, 56
	rex.W jmp	rdx
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE24_M_release_last_use_coldEv"
.set "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE24_M_release_last_use_coldEv", shared_ptr_release_cold

# shared_ptr_release
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: std::_Sp_counted_base<(__gnu_cxx::_Lock_policy)2>::_M_release()
.section .text$_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv,"x"
.linkonce discard
.p2align 4
.globl shared_ptr_release
.def shared_ptr_release; .scl 2; .type 32; .endef
	.seh_proc	shared_ptr_release
shared_ptr_release:
.Lshared_ptr_release_block_0:
	sub	rsp, 56
	.seh_stackalloc	56
	.seh_endprologue
	movabs	rax, 4294967297
	mov	rdx, QWORD PTR 8[rcx]
	cmp	rdx, rax
	je	.Lshared_ptr_release_block_1
	lock dec	DWORD PTR 8[rcx]
	je	.Lshared_ptr_release_block_5
	add	rsp, 56
	ret
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_block_1:
	mov	rax, QWORD PTR [rcx]
	lea	r8, shared_ptr_dispose[rip]
	mov	QWORD PTR 8[rcx], 0
	mov	rdx, QWORD PTR 16[rax]
	cmp	rdx, r8
	jne	.Lshared_ptr_release_block_3
.Lshared_ptr_release_block_2:
	mov	rdx, QWORD PTR 24[rax]
	lea	r8, shared_ptr_destroy[rip]
	cmp	rdx, r8
	jne	.Lshared_ptr_release_block_4
	mov	rax, QWORD PTR 8[rax]
	add	rsp, 56
	rex.W jmp	rax
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_block_3:
	mov	QWORD PTR 40[rsp], rcx
	call	rdx
	mov	rcx, QWORD PTR 40[rsp]
	mov	rax, QWORD PTR [rcx]
	jmp	.Lshared_ptr_release_block_2
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_block_4:
	add	rsp, 56
	rex.W jmp	rdx
	.p2align 4,,10
	.p2align 3
.Lshared_ptr_release_block_5:
	add	rsp, 56
	jmp	shared_ptr_release_cold
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv"
.set "_ZNSt16_Sp_counted_baseILN9__gnu_cxx12_Lock_policyE2EE10_M_releaseEv", shared_ptr_release

# path_convert_utf8
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: auto std::filesystem::__cxx11::path::_S_convert<char>(char const*, char const*)
.section .text$_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_,"x"
.linkonce discard
.p2align 4
.globl path_convert_utf8
.def path_convert_utf8; .scl 2; .type 32; .endef
	.seh_proc	path_convert_utf8
path_convert_utf8:
.Lpath_convert_utf8_block_0:
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
	.seh_endprologue
	xor	edi, edi
	lea	rax, 16[rcx]
	mov	WORD PTR 16[rcx], di
	mov	rsi, rcx
	mov	rbx, rdx
	mov	QWORD PTR [rcx], rax
	xor	edx, edx
	mov	rbp, r8
	mov	QWORD PTR 8[rcx], 0
	lea	rcx, 144[rsp]
	mov	QWORD PTR 72[rsp], rax
.Lpath_convert_utf8_block_1:
	call	"_ZNSt7codecvtIwc9_MbstatetEC2Ey"
.Lpath_convert_utf8_block_2:
	lea	rax, "_ZTVNSt10filesystem7__cxx114path8_CodecvtIwEE"[rip+16]
	mov	QWORD PTR 168[rsp], 1114111
	mov	QWORD PTR 144[rsp], rax
	mov	QWORD PTR 136[rsp], 0
	cmp	rbx, rbp
	je	.Lpath_convert_utf8_block_24
	lea	rcx, 144[rsp]
	mov	QWORD PTR 120[rsp], rbx
	xor	r15d, r15d
	lea	r13, 128[rsp]
	call	"_ZNKSt25__codecvt_utf8_utf16_baseIwE13do_max_lengthEv"
	mov	rdx, QWORD PTR 8[rsi]
	lea	r12d, 1[rax]
	mov	rax, QWORD PTR 120[rsp]
	movsxd	r12, r12d
.Lpath_convert_utf8_block_3:
	mov	rbx, rbp
	xor	ecx, ecx
	sub	rbx, rax
	imul	rbx, r12
	mov	r14, rbx
	add	r14, rdx
	setc	cl
	mov	r10, r14
	cmp	rdx, r14
	jb	.Lpath_convert_utf8_block_14
	mov	rdi, QWORD PTR [rsi]
	test	rcx, rcx
	jne	.Lpath_convert_utf8_block_13
	lea	rcx, [rdi+r15*2]
	mov	r10, rdx
.Lpath_convert_utf8_block_4:
	lea	rdx, [rdi+r10*2]
	mov	QWORD PTR 40[rsp], rcx
	mov	r9, rbp
	mov	r8, rax
	mov	QWORD PTR 48[rsp], rdx
	lea	rdx, 120[rsp]
	mov	QWORD PTR 32[rsp], rdx
	lea	rdx, 136[rsp]
	mov	QWORD PTR 56[rsp], r13
	mov	QWORD PTR 128[rsp], rcx
	lea	rcx, 144[rsp]
.Lpath_convert_utf8_block_5:
	call	"_ZNKSt25__codecvt_utf8_utf16_baseIwE5do_inER9_MbstatetPKcS4_RS4_PwS6_RS6_"
.Lpath_convert_utf8_block_6:
	mov	r14, QWORD PTR 128[rsp]
	mov	rdi, QWORD PTR [rsi]
	mov	r10, r14
	sub	r10, rdi
	mov	rbx, r10
	sar	rbx
	mov	r15, rbx
	cmp	eax, 1
	jne	.Lpath_convert_utf8_block_31
	mov	rax, QWORD PTR 120[rsp]
	mov	r8, QWORD PTR 8[rsi]
	cmp	rbp, rax
	je	.Lpath_convert_utf8_block_7
	mov	rcx, r8
	mov	rdx, r8
	sub	rcx, rbx
	cmp	r12, rcx
	jg	.Lpath_convert_utf8_block_3
.Lpath_convert_utf8_block_7:
	cmp	r8, rbx
	jb	.Lpath_convert_utf8_block_20
	cmp	rbx, r8
	jb	.Lpath_convert_utf8_block_23
.Lpath_convert_utf8_block_8:
	cmp	rbp, QWORD PTR 120[rsp]
	je	.Lpath_convert_utf8_block_25
.Lpath_convert_utf8_block_9:
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	lea	rcx, 144[rsp]
	mov	QWORD PTR 144[rsp], rax
	call	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	mov	rcx, QWORD PTR [rsi]
	cmp	QWORD PTR 72[rsp], rcx
	je	.Lpath_convert_utf8_block_10
	mov	rdx, QWORD PTR 16[rsi]
	inc	rdx
	add	rdx, rdx
	call	"_ZdlPvy"
.Lpath_convert_utf8_block_10:
.Lpath_convert_utf8_block_11:
	call	throw_path_conversion_error
.Lpath_convert_utf8_block_12:
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_13:
	xor	r9d, r9d
	lea	rcx, [rdi+r15*2]
	mov	WORD PTR [rdi+r14*2], r9w
	mov	QWORD PTR 8[rsi], r14
	jmp	.Lpath_convert_utf8_block_4
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_14:
	movabs	rax, 4611686018427387902
	sub	rax, rdx
	cmp	rax, rbx
	jb	.Lpath_convert_utf8_block_45
	mov	rdi, QWORD PTR [rsi]
	cmp	QWORD PTR 72[rsp], rdi
	je	.Lpath_convert_utf8_block_26
	mov	rax, QWORD PTR 16[rsi]
	cmp	rax, r14
	jb	.Lpath_convert_utf8_block_19
.Lpath_convert_utf8_block_15:
	lea	r8, [rdx+rdx]
.Lpath_convert_utf8_block_16:
	lea	rcx, [rdi+r8]
	cmp	rbx, 1
	je	.Lpath_convert_utf8_block_18
	test	rbx, rbx
	je	.Lpath_convert_utf8_block_17
	lea	r8, [rbx+rbx]
	xor	edx, edx
	mov	QWORD PTR 80[rsp], r10
	call	"memset"
	mov	r10, QWORD PTR 80[rsp]
.Lpath_convert_utf8_block_17:
	xor	eax, eax
	lea	rcx, [rdi+r15*2]
	mov	WORD PTR [rdi+r14*2], ax
	mov	rax, QWORD PTR 120[rsp]
	mov	QWORD PTR 8[rsi], r14
	jmp	.Lpath_convert_utf8_block_4
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_18:
	xor	r11d, r11d
	mov	WORD PTR [rcx], r11w
	jmp	.Lpath_convert_utf8_block_17
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_19:
	movabs	rcx, 4611686018427387902
	cmp	rcx, r14
	jb	.Lpath_convert_utf8_block_55
	add	rax, rax
	mov	QWORD PTR 80[rsp], rax
	cmp	r14, rax
	jnb	.Lpath_convert_utf8_block_32
	mov	rcx, rax
	movabs	rax, 4611686018427387902
	cmp	rax, rcx
	jnb	.Lpath_convert_utf8_block_43
	movabs	rax, 4611686018427387902
	movabs	rcx, 9223372036854775806
	mov	QWORD PTR 80[rsp], rax
	jmp	.Lpath_convert_utf8_block_27
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_20:
	movabs	rax, 4611686018427387902
	mov	r13, rbx
	mov	rdx, rax
	sub	r13, r8
	sub	rdx, r8
	cmp	rdx, r13
	jb	.Lpath_convert_utf8_block_51
	cmp	QWORD PTR 72[rsp], rdi
	je	.Lpath_convert_utf8_block_42
	mov	r12, QWORD PTR 16[rsi]
	cmp	r12, rbx
	jb	.Lpath_convert_utf8_block_36
.Lpath_convert_utf8_block_21:
	lea	r12, [r8+r8]
.Lpath_convert_utf8_block_22:
	lea	rcx, [rdi+r12]
	cmp	r13, 1
	je	.Lpath_convert_utf8_block_35
	lea	r8, [r13+r13]
	xor	edx, edx
	call	"memset"
.Lpath_convert_utf8_block_23:
	xor	edx, edx
	mov	WORD PTR [r14], dx
	mov	QWORD PTR 8[rsi], rbx
	jmp	.Lpath_convert_utf8_block_8
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_24:
	mov	rax, QWORD PTR [rsi]
	xor	ebx, ebx
	mov	WORD PTR [rax], bx
	mov	QWORD PTR 8[rsi], 0
.Lpath_convert_utf8_block_25:
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	lea	rcx, 144[rsp]
	mov	QWORD PTR 144[rsp], rax
	call	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
	mov	rax, rsi
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
.Lpath_convert_utf8_block_26:
	cmp	r14, 7
	jbe	.Lpath_convert_utf8_block_15
	movabs	rax, 4611686018427387902
	cmp	rax, r14
	jb	.Lpath_convert_utf8_block_55
	cmp	r14, 13
	ja	.Lpath_convert_utf8_block_32
	mov	QWORD PTR 80[rsp], 14
	mov	ecx, 30
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_27:
	mov	QWORD PTR 96[rsp], rdx
	mov	QWORD PTR 88[rsp], r10
.Lpath_convert_utf8_block_28:
	call	"_Znwy"
	mov	rdx, QWORD PTR 96[rsp]
	mov	r10, QWORD PTR 88[rsp]
	mov	r9, rax
	test	rdx, rdx
	lea	r8, [rdx+rdx]
	je	.Lpath_convert_utf8_block_34
	cmp	rdx, 1
	je	.Lpath_convert_utf8_block_33
	mov	rdx, rdi
	mov	rcx, rax
	mov	QWORD PTR 96[rsp], r10
	mov	QWORD PTR 88[rsp], r8
	call	"memcpy"
	cmp	QWORD PTR 72[rsp], rdi
	mov	r8, QWORD PTR 88[rsp]
	mov	r10, QWORD PTR 96[rsp]
	mov	r9, rax
	je	.Lpath_convert_utf8_block_30
.Lpath_convert_utf8_block_29:
	mov	rax, QWORD PTR 16[rsi]
	mov	rcx, rdi
	mov	QWORD PTR 104[rsp], r9
	mov	QWORD PTR 96[rsp], r8
	lea	rdx, 2[rax+rax]
	mov	QWORD PTR 88[rsp], r10
	call	"_ZdlPvy"
	mov	r9, QWORD PTR 104[rsp]
	mov	r8, QWORD PTR 96[rsp]
	mov	r10, QWORD PTR 88[rsp]
.Lpath_convert_utf8_block_30:
	mov	rax, QWORD PTR 80[rsp]
	mov	QWORD PTR [rsi], r9
	mov	rdi, r9
	mov	QWORD PTR 16[rsi], rax
	jmp	.Lpath_convert_utf8_block_16
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_31:
	cmp	eax, 2
	je	.Lpath_convert_utf8_block_9
	mov	r8, QWORD PTR 8[rsi]
	jmp	.Lpath_convert_utf8_block_7
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_32:
	mov	QWORD PTR 80[rsp], r14
	lea	rcx, 2[r14+r14]
	jmp	.Lpath_convert_utf8_block_27
	.p2align 4,,10
	.p2align 3
.Lpath_convert_utf8_block_33:
	movzx	eax, WORD PTR [rdi]
	mov	WORD PTR [r9], ax
.Lpath_convert_utf8_block_34:
	cmp	QWORD PTR 72[rsp], rdi
	jne	.Lpath_convert_utf8_block_29
	jmp	.Lpath_convert_utf8_block_30
.Lpath_convert_utf8_block_35:
	xor	r8d, r8d
	mov	WORD PTR [rcx], r8w
	jmp	.Lpath_convert_utf8_block_23
.Lpath_convert_utf8_block_36:
	movabs	rdx, 9223372036854775804
	cmp	rdx, r10
	jb	.Lpath_convert_utf8_block_53
	lea	r14, [r12+r12]
	cmp	rbx, r14
	jnb	.Lpath_convert_utf8_block_44
	lea	rcx, 2[r14+r14]
	cmp	rax, r14
	jnb	.Lpath_convert_utf8_block_37
	movabs	rcx, 9223372036854775806
	mov	r14, rax
.Lpath_convert_utf8_block_37:
	mov	QWORD PTR 88[rsp], r8
	mov	QWORD PTR 80[rsp], r10
	call	"_Znwy"
	mov	r8, QWORD PTR 88[rsp]
	mov	r10, QWORD PTR 80[rsp]
	mov	r15, rax
	test	r8, r8
	lea	r12, [r8+r8]
	je	.Lpath_convert_utf8_block_41
	cmp	r8, 1
	je	.Lpath_convert_utf8_block_40
	mov	r8, r12
	mov	rdx, rdi
	mov	rcx, rax
	mov	QWORD PTR 80[rsp], r10
	call	"memcpy"
	cmp	QWORD PTR 72[rsp], rdi
	mov	r10, QWORD PTR 80[rsp]
	je	.Lpath_convert_utf8_block_39
.Lpath_convert_utf8_block_38:
	mov	rax, QWORD PTR 16[rsi]
	mov	rcx, rdi
	mov	QWORD PTR 80[rsp], r10
	lea	rdx, 2[rax+rax]
	call	"_ZdlPvy"
	mov	r10, QWORD PTR 80[rsp]
.Lpath_convert_utf8_block_39:
	mov	QWORD PTR 16[rsi], r14
	mov	rdi, r15
	lea	r14, [r15+r10]
	mov	QWORD PTR [rsi], r15
	jmp	.Lpath_convert_utf8_block_22
.Lpath_convert_utf8_block_40:
	movzx	eax, WORD PTR [rdi]
	mov	WORD PTR [r15], ax
.Lpath_convert_utf8_block_41:
	cmp	QWORD PTR 72[rsp], rdi
	jne	.Lpath_convert_utf8_block_38
	jmp	.Lpath_convert_utf8_block_39
.Lpath_convert_utf8_block_42:
	cmp	r10, 14
	jbe	.Lpath_convert_utf8_block_21
	movabs	rax, 9223372036854775804
	cmp	rax, r10
	jb	.Lpath_convert_utf8_block_53
	cmp	r10, 26
	ja	.Lpath_convert_utf8_block_44
	mov	ecx, 30
	mov	r14d, 14
	jmp	.Lpath_convert_utf8_block_37
.Lpath_convert_utf8_block_43:
	lea	rcx, 2[rcx+rcx]
	jmp	.Lpath_convert_utf8_block_27
.Lpath_convert_utf8_block_44:
	lea	rcx, 2[r10]
	mov	r14, rbx
	jmp	.Lpath_convert_utf8_block_37
.Lpath_convert_utf8_block_45:
	lea	rcx, constant_41[rip]
	call	"_ZSt20__throw_length_errorPKc"
.Lpath_convert_utf8_block_46:
.Lpath_convert_utf8_block_47:
	mov	rbx, rax
	lea	rax, "_ZTVSt18codecvt_utf8_utf16IwLm1114111ELSt12codecvt_mode0EE"[rip+16]
	lea	rcx, 144[rsp]
	mov	QWORD PTR 144[rsp], rax
	vzeroupper
	call	"_ZNSt25__codecvt_utf8_utf16_baseIwED2Ev"
.Lpath_convert_utf8_block_48:
	mov	rcx, rsi
	call	"_ZNSt7__cxx1112basic_stringIwSt11char_traitsIwESaIwEE10_M_disposeEv"
	mov	rcx, rbx
.Lpath_convert_utf8_block_49:
	call	"_Unwind_Resume"
.Lpath_convert_utf8_block_50:
.Lpath_convert_utf8_block_51:
	lea	rcx, constant_41[rip]
.Lpath_convert_utf8_block_52:
	call	"_ZSt20__throw_length_errorPKc"
.Lpath_convert_utf8_block_53:
	lea	rcx, constant_42[rip]
	call	"_ZSt20__throw_length_errorPKc"
.Lpath_convert_utf8_block_54:
	mov	rbx, rax
	vzeroupper
	jmp	.Lpath_convert_utf8_block_48
.Lpath_convert_utf8_block_55:
	lea	rcx, constant_42[rip]
	call	"_ZSt20__throw_length_errorPKc"
	nop
.Lpath_convert_utf8_block_56:
	.seh_handler	"__gxx_personality_seh0", @unwind, @except
	.seh_handlerdata
.Lpath_convert_utf8_block_57:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .Lpath_convert_utf8_block_59-.Lpath_convert_utf8_block_58
.Lpath_convert_utf8_block_58:
	.uleb128 .Lpath_convert_utf8_block_1-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_2-.Lpath_convert_utf8_block_1
	.uleb128 .Lpath_convert_utf8_block_54-.Lpath_convert_utf8_block_0
	.uleb128 0
	.uleb128 .Lpath_convert_utf8_block_5-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_6-.Lpath_convert_utf8_block_5
	.uleb128 .Lpath_convert_utf8_block_47-.Lpath_convert_utf8_block_0
	.uleb128 0
	.uleb128 .Lpath_convert_utf8_block_11-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_12-.Lpath_convert_utf8_block_11
	.uleb128 0
	.uleb128 0
	.uleb128 .Lpath_convert_utf8_block_28-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_46-.Lpath_convert_utf8_block_28
	.uleb128 .Lpath_convert_utf8_block_47-.Lpath_convert_utf8_block_0
	.uleb128 0
	.uleb128 .Lpath_convert_utf8_block_49-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_50-.Lpath_convert_utf8_block_49
	.uleb128 0
	.uleb128 0
	.uleb128 .Lpath_convert_utf8_block_52-.Lpath_convert_utf8_block_0
	.uleb128 .Lpath_convert_utf8_block_56-.Lpath_convert_utf8_block_52
	.uleb128 .Lpath_convert_utf8_block_47-.Lpath_convert_utf8_block_0
	.uleb128 0
.Lpath_convert_utf8_block_59:
	.section .text$_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_,"x"
	.linkonce discard
	.seh_endproc

# Compatibility symbol for the linked C++ runtime.
.globl "_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_"
.set "_ZNSt10filesystem7__cxx114path10_S_convertIcEEDaPKT_S5_", path_convert_utf8
