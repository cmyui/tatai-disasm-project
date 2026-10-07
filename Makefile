CXX := x86_64-w64-mingw32-g++
CXXFLAGS := -std=c++20 -O3 -march=skylake -masm=intel
MODULES := $(wildcard asm/*.s)
OBJECTS := $(patsubst asm/%.s,build/%.o,$(MODULES))

.PHONY: all regenerate clean disasm
all: build/tatai.exe

# Explicit only: replaces hand-edited assembly modules.
regenerate:
	mkdir -p build
	$(CXX) $(CXXFLAGS) -include gcc_compat.h -S source/Source.cpp -o build/generated.s
	python3 tools/organize_assembly.py build/generated.s

build/%.o: asm/%.s
	mkdir -p build
	$(CXX) -c $< -o $@

build/tatai.exe: $(OBJECTS)
	$(CXX) $(OBJECTS) -static -o $@ -lonecore

disasm: build/tatai.exe
	x86_64-w64-mingw32-objdump -d -C -Mintel $< > build/tatai.disasm.txt

clean:
	rm -rf build
