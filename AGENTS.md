# Repository Guidelines

## Project Structure & Module Organization

This repository implements an MLIR-based Metal dialect and runtime. Core dialect definitions live in `include/metal`, with implementations and conversion passes in `lib/metal`. Command-line tools are in `metal-opt` and `metal-translate`. Tests are under `test`, including lit suites and C API tests. Runtime support is in `MetalRuntime`, and runnable examples are split between generated MLIR inputs in `examples/mlir` and C++ example drivers in `examples/*`.

## Build, Test, and Development Commands

Pixi is the supported entrypoint on `osx-arm64`.

- `pixi install` — create the conda-forge environment.
- `pixi run configure` — configure `build/debug` with CMake and Ninja.
- `pixi run build` — build tools, libraries, and examples.
- `pixi run check-metal` — run the lit regression suite.
- `pixi run runtime-build` — build `MetalRuntime` with SwiftPM.
- `pixi run examples-build` — compile MLIR examples into binaries.
- `pixi run examples-run` — execute generated examples.
- `pixi run validate` — run the full validation path.

Do not add Make-based workflows or LLVM source-build steps.

## Coding Style & Naming Conventions

Use C++17 for C++ sources. Follow the existing LLVM/MLIR style: 2-space indentation in C++/TableGen where present, descriptive operation/pass names, and dialect classes under the `mlir::metal` namespace. Keep shell scripts POSIX-friendly Bash with `set -euo pipefail`. Prefer explicit CMake configuration through Pixi variables instead of host-global paths.

## Testing Guidelines

Use LLVM lit for compiler tests (`test/**/*.mlir`) and CMake targets for integration checks. Add or update `// RUN:` and `// CHECK:` lines when changing IR output. Run `pixi run check-metal` for dialect/compiler changes and `pixi run validate` before submitting migration or runtime changes.

## Commit & Pull Request Guidelines

The current history is minimal; use concise, imperative commit subjects and include validation evidence. Follow the project Lore trailer pattern when applicable: `Constraint:`, `Rejected:`, `Confidence:`, `Scope-risk:`, `Tested:`, and `Not-tested:`. Pull requests should describe the change, list affected areas, mention any LLVM/MLIR compatibility impact, and include the exact Pixi commands run.

## Configuration Notes

LLVM/MLIR must come from conda-forge LLVM 22 packages in Pixi. Xcode may supply Metal, Swift, and system toolchain support only; avoid Homebrew or system LLVM dependencies.
