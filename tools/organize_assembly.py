#!/usr/bin/env python3
"""Create editable, independently assembled modules from GCC's assembly."""
from pathlib import Path
import re
import sys
import subprocess

root = Path(__file__).resolve().parent.parent
text = Path(sys.argv[1]).read_text()
functions = list(re.finditer(r'^\s*\.seh_proc\s+([^\n]+)\n.*?^\s*\.seh_endproc[^\n]*\n', text, re.M | re.S))
names = [m[1].strip().strip('"') for m in functions]
# These names describe the emitted functions, including template specializations.
friendly = '''shared_ptr_dispose shared_ptr_destroy codecvt_decode codecvt_destroy codecvt_delete path_codecvt_destroy path_codecvt_delete sort_timings slider_type_valid memory_commit memory_resize memory_region_create defer_object_header defer_slider_body parse_object_5digit parse_object_6digit parse_slider_negative parse_decimal parse_spinner parse_slider_general find_hitobjects path_destroy throw_path_conversion_error shared_ptr_release_cold shared_ptr_release parse_timing_points_v14 parse_timing_points_legacy parse_beatmap_header parse_objects_4digit parse_objects_5digit parse_objects_6digit parse_objects_7digit parse_beatmap_body parse_beatmap path_convert_utf8 read_file_into benchmark_folder read_file benchmark_preloaded main'''.split()
assert len(names) == len(friendly), 'GCC function inventory changed; review the name map'
renames = dict(zip(names, friendly))

def module(name):
    if name.startswith('memory_'): return 'memory'
    if name.startswith('defer_'): return 'deferrals'
    if name.startswith('parse_objects_'): return 'object_loop'
    if name.startswith('parse_object_'): return 'object_headers'
    if name.startswith('parse_slider_') or name == 'slider_type_valid': return 'sliders'
    if name == 'parse_spinner': return 'spinners'
    if name == 'parse_decimal': return 'decimals'
    if name.startswith('parse_timing') or name == 'parse_beatmap_header': return 'headers'
    if name.startswith('parse_beatmap') or name == 'find_hitobjects': return 'beatmap'
    if name.startswith('read_file'): return 'file_io'
    if name.startswith('benchmark') or name == 'main' or name == 'sort_timings': return 'benchmark'
    return 'runtime'

# Shared constants need external visibility when referenced by different objects.
remaining = text
for m in reversed(functions): remaining = remaining[:m.start()] + remaining[m.end():]
shared_labels = re.findall(r'^([.\w]+):', remaining, re.M)
for label in shared_labels:
    if label.startswith('.LC'): renames[label] = 'constant_' + label[3:]
    elif label.startswith('.refptr.'): renames[label] = 'runtime_ref_' + str(len(renames))

# Readable names for the parser's generated data tables.
for symbol in re.findall(r'^"(_Z[^"\n]+)":', remaining, re.M):
    for key, new in [('NEGATIVE_INFO','slider_negative_table'), ('verification_table','header_key_validation'), ('R_POW10','decimal_powers'),
                     ('DECIMAL_SHUF_UNIFIED','decimal_shuffles'), ('slider_body_positive','slider_positive_table'),
                     ('POINT_SINGLE_SHUF_DELIM2','slider_single_table')]:
        if key in symbol: renames[symbol] = new; break
    match = re.search(r'parse_([4567])_time', symbol)
    if match: renames[symbol] = 'object_' + match[1] + ('_coordinate_shuffles' if 'SHUF_XY' in symbol else '_header_shuffles')

# Basic block and exception labels are scoped by their containing function.
for m, name in zip(functions, friendly):
    labels = re.findall(r'^(\.L[\w]+):', m[0], re.M)
    for i, label in enumerate(labels): renames[label] = f'.L{name}_block_{i}'
pattern = re.compile('|'.join(re.escape(k) for k in sorted(renames, key=len, reverse=True)))
def rename(body): return pattern.sub(lambda m: renames[m[0]], body)

modules = {}
for m, old, new in zip(functions, names, friendly):
    group = module(new)
    declaration = subprocess.check_output(['x86_64-w64-mingw32-c++filt', old], text=True).strip()
    section = old if group == 'runtime' and '.text$' + old in text else new
    comdat = '.linkonce discard\n' if section == old else ''
    if 'parse_object_loop' in old:
        declaration = 'Parse objects using ' + new[-6] + '-digit timestamps (RCX: begin, RDX: end, R8: object bodies, R9: deferrals)'
    header = f'\n# {new}\n# Windows x64 ABI: RCX, RDX, R8, R9; 32-byte caller shadow space.\n# Source: {declaration}\n.section .text${section},"x"\n{comdat}.p2align 4\n.globl {new}\n.def {new}; .scl 2; .type 32; .endef\n'
    body = rename(m[0])
    # Exception handling may switch back to its original function section.
    body = re.sub(r'\.section\s+\.text\$[^,\n]+', '.section .text$' + section, body)
    body = re.sub(r'^\s*\.text\s*$', '.section .text$' + section + ',"x"', body, flags=re.M)
    if group == 'runtime':
        body += f'\n# Compatibility symbol for the linked C++ runtime.\n.globl "{old}"\n.set "{old}", {new}\n'
    modules.setdefault(group, []).append(header + body)

# Remove function declarations and section switches from the leftover data stream.
# Each function now declares its own text section and visibility.
remaining = re.sub(r'^\s*\.(?:globl|def)\s+"?(?:' + '|'.join(re.escape(n) for n in names) + r')"?[^\n]*\n', '', remaining, flags=re.M)
remaining = re.sub(r'^\s*\.set\s+"_Z17parse_object_loop[^\n]*\n', '', remaining, flags=re.M)
remaining = re.sub(r'^\s*\.def\s+"_Z17parse_object_loop[^\n]*\n', '', remaining, flags=re.M)
remaining = re.sub(r'^\s*\.(?:text|section\s+\.text[^\n]*)\n', '', remaining, flags=re.M)
# Prefix shared local constants with global declarations.
remaining = rename(remaining)
for old in shared_labels:
    new = renames.get(old)
    if new: remaining = remaining.replace(new + ':', '.globl ' + new + '\n' + new + ':')
for new in renames.values():
    remaining = remaining.replace('"' + new + '":', '.globl ' + new + '\n"' + new + '":')
# Give each data definition explicit visibility before assigning its module.
remaining = re.sub(r'^"([A-Za-z_][\w.]*)":', lambda m: '.globl "' + m[1] + '"\n' + m[0], remaining, flags=re.M)
chunks = re.split(r'(?=^\s*\.section[^\n]*\n|^\s*\.bss\s*$)', remaining, flags=re.M)
for chunk in chunks:
    if not chunk.strip(): continue
    head = chunk.splitlines()[0]
    if 'slider_' in head or 'slider_negative_table' in chunk: group = 'slider_tables'
    elif 'decimal_' in head: group = 'decimal_tables'
    elif 'object_' in head: group = 'object_tables'
    elif 'header_key_validation' in head: group = 'header_tables'
    elif '_ZT' in head or 'runtime_ref_' in head: group = 'runtime_data'
    else: group = 'constants'
    modules.setdefault(group, []).append(chunk)


for name, bodies in modules.items():
    body = ''.join(bodies)
    # Simple symbols need no quoting in GNU assembly.
    body = re.sub(r'"([A-Za-z_][A-Za-z0-9_]*)"', lambda m: m[1] if m[1] in renames.values() or m[1] == 'main' else m[0], body)
    (root / 'asm' / (name + '.s')).write_text('.intel_syntax noprefix\n' + body)
index = '# Assembly functions\n\n| Module | Entry point | Source declaration |\n|---|---|---|\n'
for old, new in zip(names, friendly):
    declaration = subprocess.check_output(['x86_64-w64-mingw32-c++filt', old], text=True).strip()
    index += f'| `{module(new)}.s` | `{new}` | `{declaration}` |\n'
(root / 'asm/INDEX.md').write_text(index)
