# Makefile to demonstrate LLVM WebAssembly offset folding bug

CLANG = clang
WASM2WAT = wasm2wat
WASM_OBJDUMP = wasm-objdump
TARGET = wasm32-unknown-unknown

all: bug.wasm bug.wat

bug.wasm: llvm_bug_minimal.ll
	$(CLANG) -target $(TARGET) -O3 -c $< -o $@

bug.wat: bug.wasm
	$(WASM2WAT) $< -o $@

# Show the unoptimized pattern in the output
show-bug: bug.wasm
	@echo "Showing unoptimized patterns (should use offset= instead):"
	@echo "----------------------------------------"
	@$(WASM_OBJDUMP) -d $< | grep -B1 -A1 "i32.const 8" | head -6
	@echo "----------------------------------------"
	@$(WASM_OBJDUMP) -d $< | grep -B1 -A1 "i32.const 2576" | head -6

clean:
	rm -f bug.wasm bug.wat

.PHONY: all show-bug clean