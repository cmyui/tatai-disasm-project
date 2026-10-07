#!/usr/bin/env python3
"""Build and run a fresh, paused-preload VTune comparison sequentially."""
import argparse
import hashlib
import json
from pathlib import Path
import subprocess
from sweep import powershell, quote
ROOT=Path(__file__).resolve().parent.parent
p=argparse.ArgumentParser(description=__doc__)
p.add_argument('--name',required=True)
p.add_argument('--variant',required=True)
p.add_argument('--itt-include',type=Path,required=True)
p.add_argument('--itt-source',type=Path,required=True)
p.add_argument('--build-only',action='store_true')
p.add_argument('--host',default='windows')
p.add_argument('--maps',default=r'C:\Users\cmyui\Desktop\programming\tatai\maps')
p.add_argument('--vtune',default=r'C:\ProgramData\Codex\vtune-2025-portable\_installdir\vtune\2025.3\bin64\vtune.exe')
a=p.parse_args()
if not all(c.isalnum() or c=='-' for c in a.name):p.error('invalid name')
out=ROOT/'build/profiles'/a.name;out.mkdir(parents=True,exist_ok=True)
variant=ROOT/'build/variants'/a.variant
cc='x86_64-w64-mingw32-g++';objects=[]
for src in sorted(variant.glob('*.s')):
    obj=out/(src.stem+'.o')
    subprocess.run([cc,'-g','-Wa,-L,-mbranches-within-32B-boundaries','-c',str(src),'-o',str(obj)],check=True);objects.append(str(obj))
subprocess.run(['x86_64-w64-mingw32-gcc','-O2','-I'+str(a.itt_include),'-I'+str(a.itt_source),'-c',str(a.itt_source/'ittnotify_static.c'),'-o',str(out/'itt.o')],check=True)
subprocess.run([cc,'-std=c++20','-O3','-march=skylake','-I'+str(a.itt_include),str(ROOT/'tools/profile.cpp'),str(out/'itt.o'),*objects,'-static','-o',str(out/'profile.exe'),'-lonecore'],check=True)
(out/'metadata.json').write_text(json.dumps(dict(variant=a.variant,executable_sha256=hashlib.sha256((out/'profile.exe').read_bytes()).hexdigest(),sources=json.loads((variant/'sources.json').read_text()),passes=51,repeats=8,maps=20001,core=2,collection='uarch-exploration'),indent=2)+'\n')
with (out/'disassembly.txt').open('w') as f:subprocess.run(['x86_64-w64-mingw32-objdump','-d','-Mintel',str(out/'profile.exe')],stdout=f,check=True)
if a.build_only:raise SystemExit()
remote='C:/ProgramData/Codex/profiles/'+a.name
powershell(a.host,f'New-Item -ItemType Directory -Force {quote(remote)} | Out-Null')
subprocess.run(['scp',str(out/'profile.exe'),a.host+':'+remote+'/profile.exe'],check=True)
powershell(a.host,f"""$ErrorActionPreference='Continue'
$m=New-Object System.Threading.Mutex($false,'Local\\TataiParserBenchmark')
if(-not $m.WaitOne(0)){{throw 'Another parser measurement owns the host'}}
try {{
& {quote(a.vtune)} -collect uarch-exploration -start-paused -result-dir {quote(remote+'/result')} -- {quote(remote+'/profile.exe')} {quote(a.maps)} 20001 > {quote(remote+'/collect.out')} 2> {quote(remote+'/collect.err')}
if($LASTEXITCODE -ne 0){{throw 'VTune collection failed'}}
& {quote(a.vtune)} -report summary -report-knob show-issues=false -r {quote(remote+'/result')} -report-output {quote(remote+'/summary.txt')}
& {quote(a.vtune)} -report hotspots -r {quote(remote+'/result')} -format csv -report-output {quote(remote+'/functions.csv')}
}} finally {{$m.ReleaseMutex();$m.Dispose()}}
""")
for name in ['summary.txt','functions.csv','collect.out','collect.err']:
    subprocess.run(['scp',a.host+':'+remote+'/'+name,str(out/name)],check=True)
