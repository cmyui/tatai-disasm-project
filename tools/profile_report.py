#!/usr/bin/env python3
"""Resolve VTune's MinGW function addresses and export a compact comparison."""
import argparse
import csv
import json
from pathlib import Path
import subprocess

p=argparse.ArgumentParser(description=__doc__)
p.add_argument('names',nargs='+')
a=p.parse_args()
root=Path(__file__).resolve().parent.parent
out=root/'experiments/profiles';out.mkdir(parents=True,exist_ok=True)
columns=['CPU Time','Clockticks','Instructions Retired','CPI Rate','Retiring(%)',
 'Front-End Bound(%)','Bad Speculation(%)','Back-End Bound(%)','Average CPU Frequency']
for name in a.names:
 source=root/'build/profiles'/name
 symbols={}
 for line in subprocess.check_output(['x86_64-w64-mingw32-nm','-n',str(source/'profile.exe')],text=True).splitlines():
  fields=line.split()
  if len(fields)==3 and fields[1]=='T':symbols[int(fields[0],16)]=fields[2]
 with (source/'functions.csv').open() as f:rows=list(csv.DictReader(f,delimiter='\t'))
 functions=[]
 for row in rows:
  if row['Module']!='profile.exe':continue
  address=int(row['Start Address'],16)
  if address not in symbols:continue
  functions.append({'function':symbols[address],'address':hex(address),**{c:row[c] for c in columns}})
 metadata=json.loads((source/'metadata.json').read_text())
 (out/(name+'.json')).write_text(json.dumps(dict(metadata=metadata,functions=functions),indent=2)+'\n')
 # Omit local machine identity and installation paths from published evidence.
 summary=(source/'summary.txt').read_text().split('Collection and Platform Info')[0]
 (out/(name+'.txt')).write_text(summary)
