CXX := x86_64-w64-mingw32-g++
CXXFLAGS := -std=c++20 -O3 -march=skylake -masm=intel
ASFLAGS := -Wa,-mbranches-within-32B-boundaries
MODULES := $(wildcard asm/*.s)
OBJECTS := $(patsubst asm/%.s,build/%.o,$(MODULES))

.PHONY: all clean disasm bench test
all: build/tatai.exe

build:
	mkdir -p $@

build/%.o: asm/%.s Makefile
	mkdir -p build
	$(CXX) $(ASFLAGS) -c $< -o $@

build/tatai.exe: $(OBJECTS)
	$(CXX) $(OBJECTS) -static -o $@ -lonecore

disasm: build/tatai.exe
	x86_64-w64-mingw32-objdump -d -C -Mintel $< > build/tatai.disasm.txt

clean:
	rm -rf build

PARSER_OBJECTS := $(filter-out build/benchmark.o build/file_io.o build/runtime.o build/runtime_data.o,$(OBJECTS))

build/benchmark_harness.o: tools/benchmark.cpp tools/parser_layout.h | build
	$(CXX) $(CXXFLAGS) -c $< -o $@

build/benchmark.exe: build/benchmark_harness.o $(PARSER_OBJECTS)
	$(CXX) $^ -static -o $@ -lonecore

build/audit_call.o: tools/audit_call.s | build
	$(CXX) -c $< -o $@

build/test.o: tools/test.cpp tools/parser_layout.h | build
	$(CXX) $(CXXFLAGS) -c $< -o $@

build/test.exe: build/test.o build/audit_call.o $(PARSER_OBJECTS)
	$(CXX) $^ -static -o $@ -lonecore

bench: build/benchmark.exe
test: build/test.exe
