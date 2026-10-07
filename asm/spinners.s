.intel_syntax noprefix

# parse_spinner
# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.
# Source: parse_spinner(char const*)
.section .text$parse_spinner,"x"
.p2align 4
.globl parse_spinner
.def parse_spinner; .scl 2; .type 32; .endef
	.seh_proc	parse_spinner
parse_spinner:
.Lparse_spinner_block_0:
	.seh_endprologue
	ret
	.seh_endproc
