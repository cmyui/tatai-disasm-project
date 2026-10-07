"""Pass two newline positions straight from the scanner into a header kernel."""
import re

def direct_scan(source,module,object_source):
    if module=='beatmap':
        for width,block in [(5,21),(6,22)]:
            a=source.index(f'.Lparse_beatmap_body_block_{block}:');b=source.index(f'.Lhave_{width}digit_lines:',a)
            t=source[a:b].replace('call refill_object_lines',f'call refill_decode_{width}\n\tmov QWORD PTR 40[rsp], r15')
            source=source[:a]+t+source[b:]
        return source
    if module!='line_scan':return source
    for width,loop in [(5,1),(6,6)]:
        name=f'parse_objects_{width}digit_context'
        a=object_source.index(name+':');b=object_source.index('\t.seh_endproc',a)
        obj=object_source[a:b]
        init=obj[obj.index('\tvbroadcasti128'):obj.index(f'.L{name}_block_{loop}:')]
        # Six-digit single-object blocks precede its pair kernel; only the entry
        # setup before the first jump belongs in the scanner's initialization.
        if width==6:init=init[:init.index(f'\tjmp\t.L{name}_block_6')]
        kernel=obj[obj.index(f'.L{name}_block_{loop}:')+len(f'.L{name}_block_{loop}:'):obj.index(f'.L{name}_single:')]
        kernel=kernel[kernel.index('\tvmovdqu\txmm0, [rbx]'):]
        kernel=kernel[:kernel.index('\tadd\trbp, 16')]
        kernel=re.sub(r'\.L'+name+r'_single',f'.Ldirect_{width}_reject',kernel)
        # All paired validation branches precede the first output store.
        for suffix in re.findall(r'\.L'+name+r'_\w+',kernel):
            assert suffix==f'.Ldirect_{width}_reject',suffix
        s=f'''
.section .text$refill_decode_{width},"x"
.globl refill_decode_{width}
.def refill_decode_{width}; .scl 2; .type 32; .endef
.seh_proc refill_decode_{width}
refill_decode_{width}:
 sub rsp, 88
 .seh_stackalloc 88
 .seh_endprologue
 mov QWORD PTR 32[rsp], rdx
 lea rax, 1024[rdx]
 cmp rax, r8
 cmova rax, r8
 mov QWORD PTR 40[rsp], rax
 lea rax, 536870912[rdi]
 mov QWORD PTR 56[rsp], rax
 mov QWORD PTR 64[rsp], 0
 mov DWORD PTR 80[rsp], 0
{init}
.Ldirect_{width}_scan:
 mov rdx, QWORD PTR 32[rsp]
 cmp rdx, QWORD PTR 40[rsp]
 jae .Ldirect_{width}_finish
 prefetcht0 BYTE PTR 512[rdx]
 mov eax, 10
 vmovd xmm0, eax
 vpbroadcastb ymm0, xmm0
 vpcmpeqb ymm1, ymm0, YMMWORD PTR [rdx]
 vpmovmskb eax, ymm1
 vpcmpeqb ymm1, ymm0, YMMWORD PTR 32[rdx]
 vpmovmskb ecx, ymm1
 shl rcx, 32
 or rax, rcx
 mov rcx, QWORD PTR 40[rsp]
 sub rcx, rdx
 cmp rcx, 64
 jae .Ldirect_{width}_mask
 bzhi rax, rax, rcx
.Ldirect_{width}_mask:
 popcnt rcx, rax
 add DWORD PTR 40[rdi], ecx
 mov QWORD PTR 48[rsp], rax
.Ldirect_{width}_next:
 mov rax, QWORD PTR 48[rsp]
 test rax, rax
 je .Ldirect_{width}_advance
 tzcnt r11, rax
 blsr rax, rax
 mov QWORD PTR 48[rsp], rax
 mov rdx, QWORD PTR 32[rsp]
 lea r11, 1[rdx+r11]
 cmp DWORD PTR 80[rsp], 0
 jne .Ldirect_{width}_buffer_one
 mov rbx, QWORD PTR 64[rsp]
 test rbx, rbx
 jne .Ldirect_{width}_kernel
 mov QWORD PTR 64[rsp], r11
 jmp .Ldirect_{width}_next
.Ldirect_{width}_kernel:
 mov QWORD PTR 72[rsp], r11
{kernel}
 mov QWORD PTR 64[rsp], 0
 jmp .Ldirect_{width}_next
.Ldirect_{width}_reject:
 # The rejected pair and the rest of this batch retain the ordinary decoder.
 mov DWORD PTR 80[rsp], 1
 mov rax, QWORD PTR 56[rsp]
 mov rdx, QWORD PTR 64[rsp]
 mov QWORD PTR [rax], rdx
 add rax, 8
 mov QWORD PTR 56[rsp], rax
 mov QWORD PTR 64[rsp], 0
 mov r11, QWORD PTR 72[rsp]
.Ldirect_{width}_buffer_one:
 mov rax, QWORD PTR 56[rsp]
 mov QWORD PTR [rax], r11
 add rax, 8
 mov QWORD PTR 56[rsp], rax
 jmp .Ldirect_{width}_next
.Ldirect_{width}_advance:
 add QWORD PTR 32[rsp], 64
 jmp .Ldirect_{width}_scan
.Ldirect_{width}_finish:
 mov rax, QWORD PTR 56[rsp]
 mov rdx, QWORD PTR 64[rsp]
 test rdx, rdx
 je .Ldirect_{width}_sentinel
 mov QWORD PTR [rax], rdx
 add rax, 8
.Ldirect_{width}_sentinel:
 vpxor xmm0, xmm0, xmm0
 vmovdqu XMMWORD PTR [rax], xmm0
 mov rdx, QWORD PTR 40[rsp]
 add rsp, 88
 ret
.seh_endproc
'''
        source+='\n'+s
    return source

def direct_scan_registers(source,module,object_source):
    source=direct_scan(source,module,object_source)
    if module!='line_scan':return source
    a=source.index('.section .text$refill_decode_5');prefix=source[:a];s=source[a:]
    s=s.replace(' mov QWORD PTR 64[rsp], 0',' xor ebx, ebx')
    s=s.replace(' mov QWORD PTR 48[rsp], rax',' mov rbp, rax')
    s=s.replace(' mov rax, QWORD PTR 48[rsp]',' mov rax, rbp')
    s=s.replace(' mov rbx, QWORD PTR 64[rsp]\n','')
    s=s.replace(' mov QWORD PTR 64[rsp], r11',' mov rbx, r11')
    s=s.replace(' mov QWORD PTR 72[rsp], r11\n','')
    s=s.replace(' mov rdx, QWORD PTR 64[rsp]',' mov rdx, rbx')
    s=s.replace(' mov r11, QWORD PTR 72[rsp]\n','')
    # The pair kernel never changes RBX/R11 before acceptance or rejection.
    # Preserve those two pointers directly instead of round-tripping them.
    for width in [5,6]:
        marker=f'.Ldirect_{width}_scan:\n'
        s=s.replace(marker,' mov eax, 10\n vmovd xmm7, eax\n'+marker,1)
    s=s.replace(' mov eax, 10\n vmovd xmm0, eax\n vpbroadcastb ymm0, xmm0',' vpbroadcastb ymm0, xmm7')
    return prefix+s
