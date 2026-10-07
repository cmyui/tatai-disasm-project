#!/usr/bin/env python3
"""Assemble a Git revision's parser with isolated symbols for native comparison."""
from pathlib import Path
import re
import subprocess
import sys

root = Path(__file__).resolve().parent.parent
ref = subprocess.check_output(['git', 'rev-parse', sys.argv[1]], cwd=root, text=True).strip()
files = subprocess.check_output(['git', 'ls-tree', '-r', '--name-only', ref, 'asm/'], cwd=root, text=True).splitlines()
excluded = {'benchmark.s', 'file_io.s', 'runtime.s', 'runtime_data.s'}
modules = {Path(p).name: subprocess.check_output(['git', 'show', f'{ref}:{p}'], cwd=root, text=True)
           for p in files if p.endswith('.s') and Path(p).name not in excluded}
symbols = set()
for text in modules.values():
    symbols.update(re.findall(r'^\s*\.(?:globl|global)\s+"?(\w+)"?\s*$', text, re.M))
pattern = re.compile(r'(?<![\w])(' + '|'.join(re.escape(s) for s in sorted(symbols, key=len, reverse=True)) + r')(?![\w])')
destination = root / 'build/reference'
destination.mkdir(parents=True, exist_ok=True)
for old in destination.glob('*.o'):
    old.unlink()
for name, text in modules.items():
    source = destination / name
    source.write_text(pattern.sub(lambda m: 'reference_' + m[0], text))
    subprocess.run(['x86_64-w64-mingw32-g++', '-Wa,-mbranches-within-32B-boundaries', '-c', str(source), '-o', str(source.with_suffix('.o'))], check=True)
(destination / 'revision.txt').write_text(ref + '\n')
print('Reference parser:', ref)
