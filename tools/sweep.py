#!/usr/bin/env python3
"""Run isolated Windows parser comparisons and retain their provenance."""
import argparse
import base64
import csv
import hashlib
import json
from pathlib import Path
import re
import statistics
import subprocess
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parent.parent

def sha(path):
    return hashlib.sha256(Path(path).read_bytes()).hexdigest()

def command(args):
    return subprocess.check_output(args, cwd=ROOT, text=True).strip()

def quote(s):
    return "'" + str(s).replace("'", "''") + "'"

def powershell(host, script):
    script = "$ProgressPreference='SilentlyContinue'; " + script
    encoded = base64.b64encode(script.encode('utf-16le')).decode()
    result=subprocess.run(['ssh', '-o', 'BatchMode=yes', '-o', 'ConnectTimeout=10', host,
                    'powershell -NoProfile -EncodedCommand ' + encoded])
    if result.returncode:raise RuntimeError(f'Remote measurement failed with exit {result.returncode}')

def summary(path, passes=31):
    text = path.read_text(encoding='utf-8-sig')
    rows = [tuple(map(float, r)) for r in re.findall(
        r'pass=(\d+) reference=([\d.]+) candidate=([\d.]+) ratio=([\d.]+)', text) if r[0] != '0']
    if len(rows) != passes-1 or 'checksum=' not in text or 'matched=' not in text:
        raise RuntimeError(f'Incomplete benchmark: {path}')
    ratio = statistics.median(r[3] for r in rows)
    return dict(reference_ns=statistics.median(r[1] for r in rows),
                candidate_ns=statistics.median(r[2] for r in rows), ratio=ratio,
                reduction_percent=100*(1-ratio), faster_pairs=sum(r[3]<1 for r in rows),
                correctness=re.search(r'matched=.*', text)[0],
                alignment_counts=([int(x) for x in re.search(r'input_alignment_counts=([0-9,]+)',text)[1].split(',')] if 'input_alignment_counts=' in text else None), samples=rows)

def selected(row, cohort):
    n=lambda k:int(row[k])
    if cohort=='all':return True
    if cohort=='timing-legacy':return n('version')>7
    if cohort=='timing-v14':return n('version')<=7
    if cohort=='fallback':return n('object_fallback')+n('slider_fallback')>0
    if cohort=='long-sliders':return n('max_points')>=16
    if cohort=='negative-sliders':return n('negative_calls')>0
    if cohort=='single-sliders':return n('sliders')>0 and n('max_points')==1
    if cohort=='integer-lengths':return n('sliders')>0 and n('decimal_lengths')==0
    if cohort=='fractional-lengths':return n('decimal_lengths')>0
    if cohort=='large':return n('bytes')>=65536
    if cohort=='small':return n('bytes')<4096
    return n(cohort)>0

def main():
    p=argparse.ArgumentParser(description=__doc__)
    p.add_argument('--name',required=True)
    p.add_argument('--exe',type=Path,required=True)
    p.add_argument('--reference',required=True)
    p.add_argument('--manifest',type=Path,required=True)
    p.add_argument('--host',default='windows')
    p.add_argument('--maps',default=r'C:\Users\cmyui\Desktop\programming\tatai\maps')
    p.add_argument('--alignment',choices=['natural','varied'],default='natural')
    p.add_argument('--limit',type=int,default=20001)
    p.add_argument('--runs',type=int,default=1)
    p.add_argument('--passes',type=int,default=31)
    p.add_argument('--cohort',choices=['all','timing-legacy','timing-v14','fallback','long-sliders',
        'negative-sliders','single-sliders','integer-lengths','fractional-lengths','large','small','short_time','time4','time5','time6','time7','long_time'],default='all')
    p.add_argument('--storage',choices=['warm','first','growth'],default='warm')
    p.add_argument('--note',default='')
    a=p.parse_args()
    if not re.fullmatch(r'[a-z0-9][a-z0-9-]*',a.name):p.error('name must be lowercase letters/digits/hyphens')
    if a.runs<1 or a.limit<0 or a.passes<3:p.error('invalid runs or limit')
    out=ROOT/'build/sweep'/a.name;out.mkdir(parents=True,exist_ok=False)
    exe=a.exe.resolve();manifest=a.manifest.resolve()
    with manifest.open(encoding='utf-8-sig',newline='') as f: rows=list(csv.DictReader(f))
    files=[r['file'] for r in rows if selected(r,a.cohort)]
    if not files:raise RuntimeError('Empty cohort')
    (out/'maps.txt').write_text('\n'.join(files)+'\n')
    diff=command(['git','diff','HEAD']);(out/'working.diff').write_text(diff)
    metadata=dict(time=datetime.now(timezone.utc).isoformat(),candidate_revision=command(['git','rev-parse','HEAD']),
        reference_revision=command(['git','rev-parse',a.reference]),executable_sha256=sha(exe),
        manifest_sha256=sha(manifest),selection_sha256=sha(out/'maps.txt'),selected_maps=len(files),
        compiler=command(['x86_64-w64-mingw32-g++','--version']).splitlines()[0],
        harness_flags='-std=c++20 -O3 -march=skylake',assembler_flags='-Wa,-mbranches-within-32B-boundaries',
        arguments=vars(a)|{'exe':str(exe),'manifest':str(manifest)},dirty_diff_sha256=sha(out/'working.diff'))
    if (exe.parent/'sources.json').exists():metadata['build_sources']=json.loads((exe.parent/'sources.json').read_text())
    (out/'metadata.json').write_text(json.dumps(metadata,indent=2)+'\n')
    remote='C:/ProgramData/Codex/sweep/'+a.name
    powershell(a.host,f"$ErrorActionPreference='Stop';New-Item -ItemType Directory -Force {quote(remote)} | Out-Null")
    subprocess.run(['scp',str(exe),a.host+':'+remote+'/verify.exe'],check=True)
    subprocess.run(['scp',str(out/'maps.txt'),a.host+':'+remote+'/maps.txt'],check=True)
    for i in range(a.runs):
        log=f'{remote}/run-{i+1}.txt'
        failure=None
        try:
            powershell(a.host,f"""$ErrorActionPreference='Stop'
$m=New-Object System.Threading.Mutex($false,'Local\\TataiParserBenchmark')
if(-not $m.WaitOne(0)){{throw 'Another parser measurement owns the host'}}
try {{
$env:TATAI_MAP_LIST={quote(remote+'/maps.txt')}
$env:TATAI_STORAGE={quote(a.storage)}
$env:TATAI_PASSES={quote(a.passes)}
$ErrorActionPreference='Continue'
& {quote(remote+'/verify.exe')} {quote(a.maps)} {a.limit} --benchmark {a.alignment} 2>&1 | Out-File -Encoding utf8 {quote(log)}
if($LASTEXITCODE -ne 0){{throw "Verifier exit=$LASTEXITCODE"}}
}} finally {{$m.ReleaseMutex();$m.Dispose()}}
""")
        except RuntimeError as error:
            failure=error
        local=out/f'run-{i+1}.txt'
        subprocess.run(['scp',a.host+':'+log,str(local)],check=True)
        if failure:raise failure
        result=summary(local,a.passes);(out/f'run-{i+1}.json').write_text(json.dumps(result,indent=2)+'\n')
        print(json.dumps(result|{'samples':len(result['samples'])}),flush=True)

if __name__=='__main__':main()
