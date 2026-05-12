#!/bin/bash
set -euo pipefail

input=$1
output=$2
preset=${3:-debug}

llc_bin=${LLC_BIN:-$(command -v llc)}
metal_translate=${METAL_TRANSLATE:-build/${preset}/bin/metal-translate}
metal_opt=${METAL_OPT:-build/${preset}/bin/metal-opt}
runtime_file=${METAL_RUNTIME_LIB:-MetalRuntime/.build/release/libMetalRuntime.a}

metal_file=$output/default.metal
metal_lib=$output/default.metallib
mlir_llvm_file=$output/llvm.mlir
llvm_file=$output/llvm.ll
assembly_file=$output/assembly.s
binary_file=$output/$(basename "$input" .mlir)

# mlir to metal shading language
"$metal_translate" "$input" --mlir-to-msl > "$metal_file"

# make metal library
xcrun -sdk macosx metal "$metal_file" -o "$metal_lib"

# mlir to mlir-llvm
"$metal_opt" "$input" --convert-metal-to-llvm > "$mlir_llvm_file"

# mlir-llvm to llvm
"$metal_translate" "$mlir_llvm_file" --mlir-to-llvmir > "$llvm_file"

# llvm to assembly
"$llc_bin" "$llvm_file" -o "$assembly_file"

# Compile & Link
clang "$assembly_file" "$runtime_file" \
  -L/usr/lib/swift \
  -L"$(xcode-select -p)/Toolchains/XcodeDefault.xctoolchain/usr/lib/swift/macosx" \
  -framework CoreGraphics \
  -o "$binary_file"

# Remove tmp files
rm "$metal_file" "$mlir_llvm_file" "$llvm_file" "$assembly_file"
