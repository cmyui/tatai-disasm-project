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
# The initial assembly revision predates the harness; its layout was captured
# unchanged at this revision. Later references carry their own definitions.
layout_ref = ref if 'tools/parser_layout.h' in subprocess.check_output(
    ['git', 'ls-tree', '-r', '--name-only', ref], cwd=root, text=True).splitlines() else '1dacd0f'
for name in ('parser_layout.h', 'parser_output.h'):
    (destination / name).write_bytes(subprocess.check_output(
        ['git', 'show', f'{layout_ref}:tools/{name}'], cwd=root))
(destination / 'adapter.cpp').write_text('''#include <sstream>
#include <cstdint>
#include <cstring>
#include <cstdio>
namespace reference_model {
#include "parser_output.h"
}
extern "C" reference_model::_memory_region_new *reference_memory_region_create(uint32_t);
extern "C" void *reference_create() {
  auto *p=reference_memory_region_create(0);return p ? &p->header : nullptr;
}
std::string reference_serialize(void *p) {
  std::ostringstream s;reference_model::Output out(s);
  out.map(*static_cast<reference_model::_memory_region_header *>(p));return s.str();
}
extern "C" uint32_t reference_count(void *p) {
  return static_cast<reference_model::_memory_region_header *>(p)->ELEM_COUNT[reference_model::MEM_object_header];
}
''')
subprocess.run(['x86_64-w64-mingw32-g++', '-std=c++20', '-O3', '-march=skylake',
                '-c', str(destination / 'adapter.cpp'), '-o', str(destination / 'adapter.o')], check=True)
print('Reference parser:', ref)
