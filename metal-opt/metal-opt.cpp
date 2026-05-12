//===--- metal-opt.cpp ------------------------------------------*- C++ -*-===//
//
// This source file is part of the metal-dialect open source project
// See LICENSE.txt for license information
//
//===----------------------------------------------------------------------===//

#include "metal/Conversion/MetalPasses.h"
#include "metal/IR/MetalDialect.h"
#include "mlir/Dialect/Arith/IR/Arith.h"
#include "mlir/Dialect/ControlFlow/IR/ControlFlowOps.h"
#include "mlir/Dialect/Func/IR/FuncOps.h"
#include "mlir/Dialect/LLVMIR/LLVMDialect.h"
#include "mlir/Dialect/MemRef/IR/MemRef.h"
#include "mlir/IR/MLIRContext.h"
#include "mlir/Support/FileUtilities.h"
#include "mlir/Tools/mlir-opt/MlirOptMain.h"

int main(int argc, char **argv) {
  mlir::metal::registerMetalConversionPasses();

  mlir::DialectRegistry registry;
  registry.insert<mlir::arith::ArithDialect, mlir::cf::ControlFlowDialect,
                  mlir::func::FuncDialect, mlir::LLVM::LLVMDialect,
                  mlir::memref::MemRefDialect, mlir::metal::MetalDialect>();

  return mlir::asMainReturnCode(
      mlir::MlirOptMain(argc, argv, "Metal optimizer driver\n", registry));
}
