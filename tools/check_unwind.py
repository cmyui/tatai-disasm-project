#!/usr/bin/env python3
"""Compare per-function Windows unwind bytes for changes that retain frames."""
import argparse
import hashlib
import json
from pathlib import Path
import re
import subprocess
import tempfile
p=argparse.ArgumentParser(description=__doc__);p.add_argument('reference',type=Path);p.add_argument('candidate',type=Path);a=p.parse_args()
results={}
with tempfile.TemporaryDirectory() as temp:
 for obj in sorted(a.candidate.glob('*.o')):
  other=a.reference/obj.name
  if not other.exists():raise RuntimeError(f'Missing reference object: {obj.name}')
  sections=re.findall(r'^\s*\d+ (\.xdata\S*)',subprocess.check_output(['x86_64-w64-mingw32-objdump','-h',str(obj)],text=True),re.M)
  for section in sections:
   data=[]
   for i,path in enumerate([other,obj]):
    output=Path(temp)/str(i)
    subprocess.run(['x86_64-w64-mingw32-objcopy','-O','binary','--only-section='+section,str(path),str(output)],check=True)
    data.append(output.read_bytes())
   if data[0]!=data[1]:raise RuntimeError(f'Changed unwind program: {obj.name} {section}')
   results[obj.name+':'+section]=hashlib.sha256(data[1]).hexdigest()
print(json.dumps({'identical_unwind_programs':len(results),'sections':results},indent=2))
