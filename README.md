# Tatai assembly project

Edit the flat `.s` files in `asm/` and run `make`. Each module assembles independently;
the linker produces `build/tatai.exe`. Run `make disasm` for the linked Intel-syntax
machine-code listing. Run `make clean` to remove build outputs.

## Modules

| File | Responsibility |
|---|---|
| `beatmap.s` | Beatmap entry point, body parsing and hitobject discovery |
| `headers.s`, `header_tables.s` | Beatmap headers and timing points |
| `object_headers.s`, `object_tables.s` | Timestamp and coordinate decoding |
| `object_loop.s` | Object-loop specializations for 4–7 digit timestamps |
| `sliders.s`, `slider_tables.s` | Slider types, negative coordinates and general fallback |
| `spinners.s` | Spinner end-time parsing |
| `decimals.s`, `decimal_tables.s` | Decimal conversion |
| `memory.s` | Windows virtual-memory allocation |
| `deferrals.s` | Deferred object and slider work |
| `file_io.s` | Corpus file loading |
| `benchmark.s` | Main program and benchmark loops |
| `constants.s` | Shared strings, scalar constants and SIMD constants |
| `runtime.s`, `runtime_data.s` | C++ library support, exception handling and RTTI |

Public parser names are readable assembly symbols such as `parse_beatmap`,
`parse_objects_5digit`, `parse_slider_negative` and `memory_region_create`.
Local block labels carry the containing function's name. `asm/INDEX.md` maps entry
points to their original source declarations. The build still uses libstdc++ for
file loading and benchmarks, so runtime ABI aliases and imported library names
remain where necessary.

## Optimization requirements

Preserve parsed results 1:1 for every map and keep behavior safe. Verify all
available maps against the reference parser, including deferred/fallback paths,
and check memory access bounds and failure behavior when changing input handling.

Alignment, buffer ownership, data structures, lookup tables, constants, internal
calling conventions, inlining and module boundaries may all change. Update their
producers, consumers and verification harness together; the current implementation
is not a compatibility requirement.

The assembly currently uses GNU assembler Intel syntax and the Windows x64 ABI.
Integer and pointer arguments use RCX, RDX, R8 and R9; callers reserve 32 bytes of
shadow space. Calls across Windows or C++ boundaries must satisfy the applicable
ABI, and unwind metadata must describe the actual stack/register layout. Internal
assembly calls may use a different convention when both sides agree.

Some source helpers are inlined into larger functions. They have no separate call
boundary to edit; their instructions live in `beatmap.s` or `object_loop.s`.

## Toolchain and source regeneration

MinGW-w64 GCC 16.2.0 (`x86_64-w64-mingw32-g++`) runs on this Mac. Source generation
uses C++20, `-O3 -march=skylake -masm=intel`, without LTO. The result targets Windows
x64 with AVX2/BMI2 and cannot run natively on macOS. The C++ runtime links statically;
Windows allocation APIs link through `onecore`.

`make regenerate` explicitly replaces the assembly modules using the snapshot in
`source/`. It discards assembly edits. `gcc_compat.h` provides the required standard
includes, MSVC assumption semantics, and an x86-compatible masked shift.
Regeneration checks the emitted function inventory; update the name mapping in
`tools/organize_assembly.py` if source changes add or remove functions.

The existing benchmark reads `C:/Users/cmyui/Desktop/programming/tatai/maps`.
Change the source snapshot and regenerate to use another corpus location.

## Assembly tuning and verification

The current assembly keeps SIMD delimiter/digit constants in nonvolatile registers
across the 5- and 6-digit object loops. Their save slots and Windows unwind metadata
are included. The body scanner uses 32-byte aligned loads, masks bytes before the
input start, and prefetches 512 bytes ahead. The slider path decodes only the
hitsound field length where its numeric value is unused. Assembly-time branch
padding keeps branches within 32-byte boundaries; this tuning targets the i7-8700.
These changes preserve the existing inlined helpers and call boundaries.

Input buffers still require the original readable tail padding for SIMD loads.
The aligned scanner may read up to 31 bytes before the input pointer, within its
mapped page; those bytes are masked out. Do not regenerate when retaining these
assembly optimizations.

Build the independent parser harness with `make build/benchmark.exe`. On Windows:

```powershell
.\build\benchmark.exe C:\path\to\maps 20001
.\build\benchmark.exe C:\path\to\maps 20001 parsed-output.bin
```

The first command preloads sorted `.osu` files, pins one CPU core, warms the parser,
and reports 21 passes in nanoseconds per map. A zero limit selects all maps. The
second command serializes parsed headers, objects, slider points and timing fields,
excluding pointers and padding, for comparison against a reference build.
