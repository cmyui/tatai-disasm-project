CXX := x86_64-w64-mingw32-g++
CXXFLAGS := -std=c++20 -O3 -march=skylake -masm=intel
ASFLAGS := -Wa,-mbranches-within-32B-boundaries
MODULES := $(wildcard asm/*.s)
OBJECTS := $(patsubst asm/%.s,build/%.o,$(MODULES))

.PHONY: all regenerate clean disasm
all: build/tatai.exe

# Explicit only: replaces hand-edited assembly modules.
regenerate:
	mkdir -p build
	$(CXX) $(CXXFLAGS) -include gcc_compat.h -S source/Source.cpp -o build/generated.s
	python3 tools/organize_assembly.py build/generated.s

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

build/benchmark_harness.o: tools/benchmark.cpp tools/parser_layout.h tools/parser_output.h
	mkdir -p build
	$(CXX) -std=c++20 -O3 -march=skylake -c tools/benchmark.cpp -o $@

build/benchmark.exe: build/benchmark_harness.o $(PARSER_OBJECTS)
	$(CXX) $^ -static -o $@ -lonecore

REFERENCE_REF ?= origin/main
.PHONY: verify
build/verify_harness.o: tools/verify.cpp tools/parser_output.h tools/parser_layout.h
	mkdir -p build
	$(CXX) -std=c++20 -O3 -march=skylake -c $< -o $@

build/audit_call.o: tools/audit_call.s
	$(CXX) -c $< -o $@

verify: build/verify_harness.o build/audit_call.o $(PARSER_OBJECTS)
	python3 tools/build_reference.py $(REFERENCE_REF)
	$(CXX) build/verify_harness.o build/audit_call.o $(PARSER_OBJECTS) build/reference/*.o -static -o build/verify.exe -lonecore

build/classify.exe: tools/classify.cpp tools/build_classifier.py tools/parser_layout.h $(MODULES)
	python3 tools/build_classifier.py
