# MLIR Metal dialect

This project is built and tested through [Pixi](https://pixi.sh/) on Apple Silicon macOS only.
LLVM/MLIR comes from conda-forge LLVM 22 packages; 
and was change from https://github.com/NicolaLancellotti/metal-dialect

## Supported platform

- `osx-arm64`
- Xcode command line tools / Xcode for Apple Metal, Swift, and system toolchain support

## Getting started

Install Pixi, then run commands from the repository root:

```sh
pixi install
pixi run configure
pixi run build
pixi run check-metal
pixi run runtime-build
pixi run examples-build
pixi run examples-run
```

The full validation path is:

```sh
pixi run validate
```

## Common tasks

- `pixi run configure` configures `build/debug` with CMake and Ninja.
- `pixi run build` builds `metal-opt`, `metal-translate`, tests, and examples.
- `pixi run check-metal` runs the lit regression suite.
- `pixi run runtime-build` builds `MetalRuntime` with SwiftPM.
- `pixi run examples-build` compiles all MLIR examples under `examples/mlir`.
- `pixi run examples-run` executes the generated examples.


