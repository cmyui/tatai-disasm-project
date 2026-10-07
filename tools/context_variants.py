"""Mechanical register reassignment for isolated four/seven digit experiments."""
import re

def rename(s, mapping):
    aliases={}
    base={'rax':['rax','eax','ax','al','ah'],'rbx':['rbx','ebx','bx','bl','bh'],
          'rcx':['rcx','ecx','cx','cl','ch'],'rdx':['rdx','edx','dx','dl','dh'],
          'rsi':['rsi','esi','si','sil'],'rdi':['rdi','edi','di','dil'],
          'rbp':['rbp','ebp','bp','bpl']}
    for i in range(8,16):base[f'r{i}']=[f'r{i}',f'r{i}d',f'r{i}w',f'r{i}b']
    for a,b in mapping.items():
        for x,y in zip(base[a],base[b]):aliases[x]=y
    return re.sub(r'\b(?:'+ '|'.join(sorted(aliases,key=len,reverse=True))+r')\b',lambda m:aliases[m[0]],s)

def context4(s):
    a=s.index('# parse_objects_4digit\n');b=s.index('# parse_objects_5digit_context',a)
    t=s[a:b];p=t.index('\tpush\tr15');q=t.index('\tmov\tesi, 741092396')
    t=t[:p]+'''\tsub rsp, 40
\t.seh_stackalloc 40
\t.seh_endprologue
\tmov r12, QWORD PTR [r10]
\ttest r12, r12
\tje .Lparse_objects_4digit_block_5
'''+t[q:]
    for x in ['\tmov\trax, r9\n','\tmov\tr10, rcx\n']:t=t.replace(x,'')
    p=t.index('\tsub\trax, r9');q=t.index('\tret',p)
    t=t[:p]+'.Lparse_objects_4digit_block_5:\n\tadd rsp, 40\n'+t[q:]
    # The caller previously advanced output cursors from the packed count even
    # when the last consumed line was followed by a sentinel.
    t=t.replace('\tadd\trbx, 16\n','').replace('\tadd\tr8, 32\n','')
    t=t.replace('\ttest\tr12, r12\n', '\tadd\trbx, 16\n\tadd\tr8, 32\n\ttest\tr12, r12\n')
    t=t.replace('\tmov r12, QWORD PTR [r10]\n\ttest r12, r12', '\tmov r12, QWORD PTR [r10]\n\ttest r12, r12')
    # Rebuild the only fallback call after renaming; context registers survive
    # the ordinary Windows helper, so no packed-return bookkeeping is needed.
    p=t.index('.Lparse_objects_4digit_block_9:');q=t.index('\tmov\tecx, DWORD PTR 12[rbx]',p)
    t=t[:p]+'.Lparse_objects_4digit_block_9:\n\tSWEEP_CALL\n\tinc\tr12\n'+t[q:]
    t=re.sub(r'^\tmov\t(?:r8|r9|r11), QWORD PTR \d+\[rsp\]\n','',t,flags=re.M)
    t=t.replace('\txor\teax, eax\n','')
    t=rename(t,{'r12':'rbx','r11':'rcx','rbx':'r15','rdi':'r13','r10':'rbp','r8':'r14','rax':'r12','rbp':'r10','r13':'r8','r14':'r11','r15':'r9','rcx':'rax'})
    # High-byte CH would become AH (legal); no high-byte extended registers.
    t=t.replace('\tSWEEP_CALL','\tmov rcx, rbx\n\tmov rdx, r15\n\tcall defer_object_header')
    t=t.replace('parse_objects_4digit','parse_objects_4digit_context')
    t=t.replace('# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.','# Internal context: same ownership as the five/six-digit routines.')
    return s[:a]+t+s[b:]

def context7(s):
    a=s.index('# parse_objects_7digit\n');t=s[a:]
    p=t.index('\tpush\tr15');q=t.index('\tmov\tesi, 741092396')
    t=t[:p]+'''\t.seh_endprologue
\tmov rax, QWORD PTR [r8]
\ttest rax, rax
\tje .Lparse_objects_7digit_block_6
'''+t[q:]
    for line in ['\tmov\tQWORD PTR 96[rsp], rbp\n','\tmov\trcx, r9\n','\tmov\tr8, rbp\n','\tmov\tr15, r9\n']:t=t.replace(line,'')
    p=t.index('\tmov\trbp, QWORD PTR 96[rsp]');q=t.index('\tret',p)
    t=t[:p]+'.Lparse_objects_7digit_block_6:\n'+t[q:]
    t=t.replace('\txor\teax, eax\n','')
    # XMM6 belongs to the context. XMM5's digit offset can use XMM8 instead.
    t=t.replace('\tvmovdqa\txmm6, XMMWORD PTR constant_6[rip]','\tvmovdqa\txmm5, XMMWORD PTR constant_6[rip]')
    t=t.replace('\tmov\tesi, -791621424\n','').replace('\tvmovd\txmm5, esi\n','').replace('\tvpbroadcastd\txmm5, xmm5\n','')
    t=t.replace('xmm0, xmm0, xmm5','xmm0, xmm0, xmm8').replace('xmm0, xmm0, xmm6','xmm0, xmm0, xmm5')
    t=rename(t,{'r8':'rbp','r10':'r15','rdi':'r14','rcx':'r12','rbp':'r10','r14':'rcx','r12':'r8'})
    t=t.replace('parse_objects_7digit','parse_objects_7digit_context')
    t=t.replace('# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.','# Internal context: same ownership as five/six-digit routines; leaf, no frame.')
    return s[:a]+t

def callers(s,width):
    if width==4:
        a=s.index('.Lhave_4digit_lines:');b=s.index('\tvmovq rcx, xmm10',a)
        s=s[:a]+'.Lhave_4digit_lines:\n\tcall parse_objects_4digit_context\n\tmov QWORD PTR 40[rsp], r15\n'+s[b:]
    else:
        a=s.index('.Lhave_7digit_lines:');b=s.index('\tvmovq rcx, xmm10',a)
        s=s[:a]+'.Lhave_7digit_lines:\n\tmov r15, QWORD PTR 40[rsp]\n\tcall parse_objects_7digit_context\n\tmov QWORD PTR 40[rsp], r15\n'+s[b:]
    return s
