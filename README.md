# Tatai assembly project

Edit the flat `.s` files in `asm/` and run `make`. Each module assembles independently;
the linker produces `build/tatai.exe`. Run `make disasm` for the linked Intel-syntax
machine-code listing. Run `make clean` to remove build outputs.

## Modules

| File | Responsibility |
|---|---|
| `beatmap.s` | Beatmap entry point, body parsing and hitobject discovery |
| `line_scan.s` | Bounded hit-object line-pointer refills |
| `headers.s`, `header_tables.s` | Beatmap headers and timing points |
| `object_headers.s`, `object_tables.s` | Timestamp and coordinate decoding |
| `object_loop.s` | Object-loop specializations for 4–7 digit timestamps |
| `sliders.s`, `slider_tables.s` | Slider types, negative coordinates and general fallback |
| `spinners.s` | Unused reference spinner helper |
| `decimals.s`, `decimal_tables.s` | Decimal conversion |
| `memory.s` | Windows virtual-memory allocation |
| `deferrals.s` | Deferred object and slider work |
| `file_io.s` | Corpus file loading |
| `benchmark.s` | Main program and benchmark loops |
| `constants.s` | Shared strings, scalar constants and SIMD constants |
| `runtime.s`, `runtime_data.s` | C++ library support, exception handling and RTTI |

Parser entry points have readable assembly names such as `parse_beatmap`,
`parse_objects_5digit_context`, `parse_slider_negative` and `memory_region_create`.
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

## Internal object context

`parse_objects_5digit_context` and `parse_objects_6digit_context` are assembly-only
entry points. Their input and output cursors stay in the same registers:

| Register | Value |
|---|---|
| RDI | Memory-region header, preserved |
| RBP | Next line pointer, advanced in place |
| R15 | Next object header, advanced in place |
| R14 | Next object body, advanced in place |
| R12 | Next slider deferral, advanced in place |
| XMM6 | Comma vector, preserved |
| XMM8 | ASCII digit offset vector, preserved |
| XMM9 | Object-result shuffle, preserved |
| XMM10 | Line-list end pointer in its low 64 bits, preserved |

RAX, RCX, RDX, R8–R11, RBX, R13, RSI and XMM0–XMM5 are scratch. XMM7 and
XMM11–XMM15 are untouched. The caller initializes the shared vectors once for
this phase. Each routine reserves 40 bytes for aligned Windows fallback calls
and updates the four cursors even when the next line is the null sentinel.
There is no packed return value or per-call preservation of the cursors. The
outer `parse_beatmap` boundary retains the Windows ABI and restores its caller's
nonvolatile registers. Four- and seven-digit routines currently use the Windows
calling convention.

## Parsing scope and implementation

The reference C++ extracts format version, mode, circle size, stack leniency,
approach rate, overall difficulty, slider multiplier/tick rate, object position,
time/type, slider anchors/repeats/length and reduced timing points. Metadata and
storyboard
content and hitsound/sample fields are outside the returned model. Spinner object
headers are parsed, but their body/end-time storage is not populated by the
reference; verification excludes those unwritten bytes. The [format specification](https://osu.ppy.sh/wiki/en/Client/File_formats/osu_%28file_format%29)
describes the surrounding syntax; reference-parser behavior defines equivalence,
including its clamping, version handling, decimal rounding and fallback behavior.

Newline masks build batches of line pointers. Timestamp-width runs select
coordinate/type shuffles from delimiter positions instead of looping over ASCII
digits. Slider delimiter masks select validated lookup entries for up to two
points; negative coordinates use another lookup, and unusual shapes are deferred
to a general parser. Decimal conversion uses SIMD multiply/add stages and a power
of ten. The allocator reserves aligned address regions so fallback routines can
recover the owning parser state from an output pointer.

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

The current assembly keeps SIMD delimiter/digit constants in the shared register
context across the 5- and 6-digit object loops. Nonvolatile state is saved at the
outer Windows boundary, and unwind metadata describes each stack frame. The body scanner uses 32-byte aligned loads, masks bytes before the
input start, and prefetches 512 bytes ahead. Each full block emits three
speculative line pointers, advances by the actual newline count, and handles any
remaining matches in an overflow loop. The slider path decodes only the
hitsound field length where its numeric value is unused. Assembly-time branch
padding keeps branches within 32-byte boundaries; this tuning targets the i7-8700.
The positive slider path indexes a 1 MiB table directly by its delimiter mask,
then validates the entry and consumes its metadata. Only 90 entries are populated;
the page-aligned table places them in 90 cache lines across 17 pages.
`tools/generate_slider_positive_table.py` emits this first table in
`asm/slider_tables.s`.

Five- and six-digit object routines use the shared register context above. The five-digit loop keeps
both shuffle-table bases in registers and advances its deferral cursor directly;
its fast path returns to the loop head with one conditional branch.

Hit-object line pointers are discovered and consumed in 1 KiB input batches.
Header/timing parsing completes before the line array is reused as scratch.
The refill helper uses a private calling convention: RBP and RSI are replaced
with the new line range by the caller, so the helper needs no save frame.
Each batch resumes the same timestamp-width decoder, while slider deferrals
retain their original ordering and are processed after object headers. Lines may
cross batch boundaries because decoding reads the original padded input directly.
The line array is internal scratch, not a retained index of the complete file.
An early section marker that truncates header parsing triggers a full-input rescan.

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
excluding pointers, padding and unwritten spinner bodies, for comparison against
a reference build.

For a native comparison against a Git revision, build both parsers into one test
executable with isolated reference symbols:

```sh
make verify REFERENCE_REF=origin/main
```

```powershell
.\build\verify.exe C:\path\to\maps
```

This compares the serialized fields exactly for every `.osu` file in sorted order,
varying input alignment across the corpus. It also exercises timestamp-width
transitions, object-header and slider fallbacks, negative coordinates and repeat
counts on inputs at all 32 alignments between inaccessible guard pages. Scanner cases also cover dense newlines, long
gaps, and transitions around SIMD boundaries. Chunk cases cover timestamp-width
transitions, long lines, large headers, decreasing timestamps, and early section
markers, at all alignments beside guard pages. Positive-slider cases exhaust
one- through four-digit coordinate widths for single and paired points, including
continuations and four-digit fallback shapes. An optional
second argument limits the corpus for a quick check; zero selects all maps.
The resolved reference revision is recorded in `build/reference/revision.txt`.

To time both revisions in the same process after verifying their output, add a
corpus limit and `--benchmark`:

```powershell
.\build\verify.exe C:\path\to\maps 20001 --benchmark
```

This pins one core, alternates reference/candidate order and reports 31 paired
passes in nanoseconds per map. Exclude pass zero when summarizing timings.
