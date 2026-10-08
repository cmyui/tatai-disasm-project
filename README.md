# Tatai assembly project

Edit the flat `.s` files in `asm/` directly. Build with MinGW-w64 GCC
(`x86_64-w64-mingw32-g++`); binaries target Windows x64 with AVX2/BMI2.

```sh
make all disasm
make bench
```

`build/tatai.exe` retains the original application benchmark. The standalone
benchmark accepts a map directory, optional map limit (zero means all), and
optional pass count:

```powershell
.\build\benchmark.exe C:\path\to\maps 20001 5
```

It preloads inputs, warms the parser, pins core 2, and reports time per map over
four repetitions per pass. Compare the same inputs before and after assembly
changes. `make clean` removes build outputs.

Preserve parsed results, decimal bits, ordering, and safe behavior. Internal
layouts and calling conventions may change together with their consumers.
External Windows calls must preserve the ABI and accurate unwind metadata.

Keep input bytes resident throughout parsing. Supply 128 readable bytes after
the logical input end and a terminating newline. The aligned 32-byte block
containing the first input byte must also be readable. A new parse reuses the
memory region and invalidates the previous map's output.
