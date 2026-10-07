#!/usr/bin/env python3
"""Render exported sweep samples; positive reduction means less parse time."""
from pathlib import Path
import json
root=Path(__file__).resolve().parent.parent
rows=['# Measurement index','',
 'Positive reduction means less time. Screens with 10 measured pairs are not acceptance runs.',
 'Every row links executable/source/corpus hashes, correctness totals and raw paired samples.',
 'Pass zero is excluded. The protocol field records alignment, storage, cohort and repetitions.',
 '', '| Experiment / launch | Maps | Pairs | Time reduction | Faster pairs |',
 '|---|---:|---:|---:|---:|']
for p in sorted((root/'experiments/results').glob('*.json')):
 data=json.loads(p.read_text())
 for i,r in enumerate(data['runs'],1):
  import re
  maps=re.search(r'corpus_maps=(\d+)',r['correctness'])[1]
  rows.append(f"| [{p.stem} / {i}](results/{p.name}) | {maps} | {len(r['samples'])} | {r['reduction_percent']:+.4f}% | {r['faster_pairs']}/{len(r['samples'])} |")
(root/'experiments/measurements.md').write_text('\n'.join(rows)+'\n')
