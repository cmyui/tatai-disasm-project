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

Preserve parsed results 1:1 for every map and keep behavior safe. Run the small
unit tests after changes, add focused cases for changed input handling, and compare
short benchmark runs on the same preloaded maps.

Alignment, buffer ownership, data structures, lookup tables, constants, internal
calling conventions, inlining and module boundaries may all change. Update their
producers, consumers and tests together; the current implementation
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

## Build and run

Use MinGW-w64 GCC (`x86_64-w64-mingw32-g++`). Binaries target Windows x64
with AVX2/BMI2. Assembly is the source of truth; edit it directly.

```sh
make all disasm
make bench test
```

On Windows:

```powershell
.\build\test.exe
.\build\benchmark.exe C:\path\to\maps 20001 5
```

The benchmark takes a map folder, optional map limit (zero means all), and optional
pass count. It preloads inputs, warms the parser, pins core 2, and prints time per
map over four repetitions per pass. Compare the same selection before and after
an assembly edit. The unit tests check header fields, slider decoding, decimal bits,
failed-slider recovery, and external register preservation.

## Storage and input requirements

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
