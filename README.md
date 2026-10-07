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

RAX, RCX, RDX, R8–R11, RBX, R13, RSI and YMM0–YMM5 are scratch. The upper
128 bits of YMM6, YMM8 and YMM9 are also scratch; their low XMM halves remain
preserved. XMM7 and XMM11–XMM15 are untouched. The caller initializes the shared
vectors once for this phase. Each routine reserves 40 bytes for aligned Windows fallback calls
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

Paired slider lengths classify and shuffle each input independently, then use
one AVX2 lane per decimal for digit reduction and 64-bit integer reconstruction.
The unsigned product of the leading eight digits by 100,000,000 and addition of
the trailing eight digits remain in SIMD registers. Each result then uses the
reference's signed integer-to-double conversion and scalar power-of-ten multiply,
preserving its exact rounding. Odd tails and deferred sliders retain their
existing decimal paths. XMM10 already has a save slot in the outer frame and
holds the reconstruction multiplier; the pair path needs no extra stack space.

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

Five- and six-digit object routines decode two eligible headers at once, one
per 128-bit lane of an AVX2 register. Both lines must match the routine's timestamp
width and have supported nonnegative coordinates and a single-digit type. The
original single-header paths handle odd tails, width transitions and unusual
shapes. Pair validation completes before any output or cursor changes.

The slider bit of a single decimal type digit is also its ASCII bit 1, so the
deferral queue can advance without waiting for the SIMD conversion, store and
reload. Queue writes retain input order. Both shuffle-table bases and the shared
context remain in registers; pairing uses no additional stack space. Constants
occupy both YMM lanes and are restored after Windows-ABI fallback calls.

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
continuations and four-digit fallback shapes. Paired-header cases cover all
one- through four-digit coordinate-width combinations, circle/slider ordering,
all 256 type values, odd tails, signed fallbacks and timestamp-width transitions
in either pairing position. An optional second argument limits the corpus for a
quick check; zero selects all maps. Decimal-pair cases cover digit and decimal-point
positions, leading zeroes, 16-byte truncation, values around 2^53, and odd tails.
The resolved reference revision is recorded in `build/reference/revision.txt`.

To time both revisions in the same process after verifying their output, add a
corpus limit and `--benchmark`:

```powershell
.\build\verify.exe C:\path\to\maps 20001 --benchmark
```

This pins one core, alternates reference/candidate order and reports 31 paired
passes in nanoseconds per map. Exclude pass zero when summarizing timings.

## Reproducible sweep measurements

`make build/classify.exe` builds an **untimed**, instrumented corpus inventory.
Run it with the map directory and redirect stdout to a CSV. Each row records the
file SHA-256, size, format version, timestamp widths, slider/decimal shapes, and
actual fallback/negative-helper call counts. Timed binaries omit these counters.

`make verify REFERENCE_REF=<revision>` builds the reference allocator and output
serializer against that revision's own layout in a separate namespace. The
initial assembly revision predates the harness and uses the unchanged layout
snapshot from `1dacd0f`. Keep this independent when changing candidate layouts.

The verifier accepts `MAPS LIMIT --benchmark natural` or `varied` (the default).
Guard tests always cover all alignments. `TATAI_MAP_LIST` optionally names a UTF-8
file containing one corpus filename per line; selection occurs before timing.

```sh
python3 tools/sweep.py --name UNIQUE --exe build/verify.exe --reference REF \
  --manifest MANIFEST.csv --limit 0 --runs 2
```

The runner transfers
the binary to `ssh windows`, selects the requested cohort, serializes measurements
with a host mutex, and retains logs and provenance in `build/sweep/UNIQUE`.
Use `--alignment varied` for alignment stress and `--cohort` to select a targeted
category. Full-corpus acceptance uses two independent launches; each has 31
alternating passes of four repetitions, with pass zero excluded. Checksums are
read after the timed region, so differing output layouts add no timed adapters.
Experiment outcomes and rejected hypotheses are recorded in `experiments/sweep.md`.

Untimed verification checks every Windows nonvolatile GPR and XMM register around
both parser entry points. The probe has its own Windows unwind metadata. Timing
cases cover duplicate suppression, inheritance, signed times and format versions.
The cohort names `timing-v14` and `timing-legacy` follow assembly dispatch:
respectively versions <=7 and >7, despite the historical function names.

### Storage lifetime and input contract

The region header owns nine logical 512 MiB slots in an aligned reservation.
Slot 0 contains the header. Slots 1–8 hold lines, object headers, object bodies,
timing points, slider deferrals, anchors, object-error records and slider-error
records, respectively. Commits grow in 512 KiB units and remain reusable between
maps. The current parser preallocates conservative capacities from input length;
this is part of parsing, not file loading.

Header/timing consumers finish before the line slot becomes the bounded object
refill buffer. Object headers, bodies, timing points and anchors remain live until
the caller finishes consuming that map. Slider deferrals retain both input and
output ownership; after point parsing, their input pointer is replaced by the
length-field pointer. General-slider recovery still needs its error records until
the final pass. These overlapping lifetimes prohibit treating all scratch/output
regions as interchangeable. The next parse invalidates prior output ownership.

Keep the input resident and unchanged throughout parsing. Supply 128 readable
padding bytes after its logical end, including a terminating newline where the
file does not contain one. The aligned initial scanner also requires the mapped
32-byte block containing the first byte to be readable; it masks any prefix bytes.
The guarded verifier checks both page boundaries and all 32 input offsets.
Unsupported/malformed input is tested only where the reference has defined behavior;
a reference crash is not an expected-output oracle.

### Isolated experiments and allocation protocols

```sh
python3 tools/variants.py prefetch-1024 --source-ref 1dacd0f --reference 1dacd0f
python3 tools/sweep.py --name example --exe build/variants/prefetch-1024/verify.exe \
  --reference 1dacd0f --manifest MANIFEST.csv --limit 0 --runs 2
```

Recipes modify isolated assembly copies, never production files. `--source-ref`
fixes their input revision independently of the checkout. The runner records the
executable, assembly, recipe and harness hashes, exact flags, corpus manifest and
selection hashes, raw samples and serialized-output/ABI results. Actual input
alignment histograms are emitted by the verifier. Natural allocator alignment and
`--alignment varied` are separate experiments.

`--passes 11` is an inexpensive screen; it cannot qualify a retained change.
Acceptance uses the default 31 passes in each of two launches. `--storage warm`
reuses committed capacity. `first` decommits before every map outside the clock;
`growth` decommits before each corpus repetition. Both time each map separately,
including commits inside parsing, and therefore include per-map clock overhead.
They are allocation diagnostics, not directly comparable with the warm aggregate
clock. Inputs remain preloaded in every mode.

`tools/cpp_comparison.py` compiles the frozen original C++ directly to an object
with `-std=c++20 -O3 -march=skylake`, renames its symbols and links the isolated
reference serializer/allocator with a selected assembly candidate. It does not
regenerate assembly. This provides the cumulative original-C++ comparison.

```sh
python3 tools/cpp_comparison.py --candidate build/variants/prefetch-1024 --name original-comparison
python3 tools/sweep.py --name original-comparison \
  --exe build/cpp-comparisons/original-comparison/verify.exe --reference 4698eb4 \
  --manifest MANIFEST.csv --limit 0 --runs 2
```

`tools/profile.py` builds a separate ITT-instrumented executable, preloads and warms
while collection is paused, and runs VTune's hardware `uarch-exploration` collection
on the same pinned core. Supply the Intel ITT include/source directories and a
Coffee-Lake-compatible VTune executable through its command-line options. Native
measurement and profiling runs share a host mutex. `tools/profile_report.py`
resolves MinGW addresses using the exact executable's symbol table.

See [the coverage matrix](experiments/audit.md), [experiment outcomes](experiments/sweep.md)
and [machine-readable samples](experiments/results/) for the completed/rejected
transfers. `tools/export_sweep.py` exports provenance and samples without publishing
private corpus filenames or local host paths.
