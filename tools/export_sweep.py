#!/usr/bin/env python3
"""Publish measurements without copying private corpus filenames or host paths."""
from pathlib import Path
import json
root=Path(__file__).resolve().parent.parent
out=root/'experiments/results';out.mkdir(parents=True,exist_ok=True)
for directory in sorted((root/'build/sweep').iterdir()):
    metadata=directory/'metadata.json'
    if not metadata.exists():continue
    m=json.loads(metadata.read_text())
    evidence={key:m[key] for key in ['candidate_revision','reference_revision','executable_sha256',
        'manifest_sha256','selection_sha256','selected_maps','compiler','harness_flags','assembler_flags','dirty_diff_sha256']}
    evidence['protocol']={key:value for key,value in m['arguments'].items() if key in ['alignment','limit','runs','cohort','storage','passes','note']}
    evidence['sources']=m.get('build_sources')
    runs=[]
    for path in sorted(directory.glob('run-*.json')):runs.append(json.loads(path.read_text()))
    if not runs:continue
    evidence['runs']=runs
    (out/(directory.name+'.json')).write_text(json.dumps(evidence,indent=2)+'\n')
