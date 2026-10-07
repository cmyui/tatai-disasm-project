#!/usr/bin/env python3
"""Compile the frozen C++ baseline only; never regenerate production assembly."""
from pathlib import Path
import argparse
import subprocess
import hashlib
import json
ROOT=Path(__file__).resolve().parent.parent
p=argparse.ArgumentParser();p.add_argument('--source',type=Path,default=ROOT/'source');p.add_argument('--candidate',type=Path,required=True);p.add_argument('--name',required=True);a=p.parse_args()
out=ROOT/'build/cpp-comparisons'/a.name;out.mkdir(parents=True,exist_ok=True)
subprocess.run(['make','build/verify_harness.o','build/audit_call.o'],cwd=ROOT,check=True)
subprocess.run(['python3','tools/build_reference.py','4698eb4'],cwd=ROOT,check=True)
flags=['-std=c++20','-O3','-march=skylake','-Dmain=original_cpp_main','-include',str(ROOT/'gcc_compat.h')]
subprocess.run(['x86_64-w64-mingw32-g++',*flags,'-c',str(a.source/'Source.cpp'),'-o',str(out/'original.o')],check=True)
subprocess.run(['x86_64-w64-mingw32-objcopy',
 '--redefine-sym','_Z25parse_beatmap_from_memoryP21_memory_region_headerPKcS2_=reference_parse_beatmap',
 '--redefine-sym','_Z20create_memory_regionj=reference_memory_region_create',
 '--redefine-sym','total_count_opt=reference_total_count_opt',str(out/'original.o'),str(out/'reference.o')],check=True)
objects=sorted(a.candidate.glob('*.o'))
subprocess.run(['x86_64-w64-mingw32-g++',str(ROOT/'build/verify_harness.o'),str(ROOT/'build/audit_call.o'),*map(str,objects),str(out/'reference.o'),str(ROOT/'build/reference/adapter.o'),'-static','-o',str(out/'verify.exe'),'-lonecore'],check=True)
files={f.name:hashlib.sha256(f.read_bytes()).hexdigest() for f in a.source.iterdir() if f.suffix in ['.cpp','.h']}
(out/'sources.json').write_text(json.dumps(dict(cpp_sources=files,compiler_flags=["gcc_compat.h" if str(ROOT) in f else f for f in flags],reference_object_sha256=hashlib.sha256((out/'original.o').read_bytes()).hexdigest(),candidate=json.loads((a.candidate/'sources.json').read_text())),indent=2)+'\n')
