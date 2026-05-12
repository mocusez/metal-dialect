#!/bin/bash
set -euo pipefail

preset=${METAL_PRESET:-debug}
example_build_dir=${METAL_EXAMPLE_BUILD_DIR:-build/${preset}/bin/examples}

for dir in "$example_build_dir"/*; do
  [ -d "$dir" ] || continue
  name=$(basename "$dir")
  echo "Running $dir/$name"
  (cd "$dir" && "./$name")
done
