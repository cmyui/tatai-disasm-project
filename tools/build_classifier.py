#!/usr/bin/env python3
"""Instrument fallback entry counts only in the untimed corpus classifier."""
from pathlib import Path
import subprocess
root=Path(__file__).resolve().parent.parent
out=root/'build/classifier';out.mkdir(parents=True,exist_ok=True)
objects=[]
for p in sorted((root/'asm').glob('*.s')):
    if p.stem in ['benchmark','file_io','runtime','runtime_data']:continue
    s=p.read_text()
    for i,name in enumerate(['defer_object_header','defer_slider_body','parse_slider_general','parse_slider_negative']):
        marker=name+':\n'
        if marker in s:
            start=s.index(marker);at=s.index('\t.seh_endprologue\n',start)+len('\t.seh_endprologue\n')
            s=s[:at]+f'\tinc QWORD PTR sweep_counts+{i*8}[rip]\n'+s[at:]
    dst=out/p.name;dst.write_text(s);obj=dst.with_suffix('.o')
    subprocess.run(['x86_64-w64-mingw32-g++','-Wa,-mbranches-within-32B-boundaries','-c',str(dst),'-o',str(obj)],check=True);objects.append(str(obj))
subprocess.run(['x86_64-w64-mingw32-g++','-std=c++20','-O3','-march=skylake',str(root/'tools/classify.cpp'),*objects,'-static','-o',str(root/'build/classify.exe'),'-lonecore','-lbcrypt'],check=True)
