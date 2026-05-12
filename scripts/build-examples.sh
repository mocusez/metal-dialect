#!/bin/bash
set -euo pipefail

preset=${METAL_PRESET:-debug}
example_src_dir=${METAL_EXAMPLES_DIR:-examples/mlir}
example_build_dir=${METAL_EXAMPLE_BUILD_DIR:-build/${preset}/bin/examples}
helper=${METAL_MLIR2BIN:-scripts/mlir2bin-lib.sh}

mkdir -p "$example_build_dir"
for mlir in "$example_src_dir"/*.mlir; do
  name=$(basename "$mlir" .mlir)
  out_dir="$example_build_dir/$name"
  mkdir -p "$out_dir"
  "$helper" "$mlir" "$out_dir" "$preset"
done
