cmake_minimum_required(VERSION 3.20.0)
project(metal LANGUAGES CXX C)

set(CMAKE_BUILD_WITH_INSTALL_NAME_DIR ON)

set(CMAKE_CXX_STANDARD 17 CACHE STRING "C++ standard to conform to")

find_package(MLIR REQUIRED CONFIG)

message(STATUS "Using MLIRConfig.cmake in: ${MLIR_DIR}")
message(STATUS "Using LLVMConfig.cmake in: ${LLVM_DIR}")

set(LLVM_RUNTIME_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/bin)
set(LLVM_LIBRARY_OUTPUT_INTDIR ${CMAKE_BINARY_DIR}/lib)
set(MLIR_BINARY_DIR ${CMAKE_BINARY_DIR})

list(APPEND CMAKE_MODULE_PATH "${MLIR_CMAKE_DIR}")
list(APPEND CMAKE_MODULE_PATH "${LLVM_CMAKE_DIR}")

include(TableGen)
include(AddLLVM)
include(AddMLIR)
include(HandleLLVMOptions)

set(METAL_SOURCE_DIR ${PROJECT_SOURCE_DIR})
set(METAL_BINARY_DIR ${PROJECT_BINARY_DIR})
include_directories(${LLVM_INCLUDE_DIRS})
include_directories(${MLIR_INCLUDE_DIRS})
include_directories(${METAL_SOURCE_DIR}/include)
include_directories(${METAL_BINARY_DIR}/include)
add_definitions(${LLVM_DEFINITIONS})

# conda-forge installs test helper tools such as FileCheck/count/not under
# libexec/llvm while LLVM_TOOLS_BINARY_DIR points at bin. Build a local tool
# shim so lit can resolve both normal LLVM binaries and libexec test helpers.
set(METAL_LLVM_TOOLS_DIR ${CMAKE_BINARY_DIR}/llvm-tools)
file(MAKE_DIRECTORY ${METAL_LLVM_TOOLS_DIR})
set(METAL_LLVM_ORIGINAL_TOOLS_DIR ${LLVM_TOOLS_BINARY_DIR})
foreach(tool mlir-opt llc llvm-lit FileCheck count not)
    string(REPLACE "-" "_" tool_var ${tool})
    find_program(METAL_${tool_var}_PATH ${tool}
        PATHS
            ${METAL_LLVM_ORIGINAL_TOOLS_DIR}
            ${METAL_LLVM_ORIGINAL_TOOLS_DIR}/../libexec/llvm
        NO_DEFAULT_PATH)
    if(METAL_${tool_var}_PATH)
        execute_process(
            COMMAND ${CMAKE_COMMAND} -E create_symlink
                    ${METAL_${tool_var}_PATH}
                    ${METAL_LLVM_TOOLS_DIR}/${tool})
    endif()
endforeach()
set(LLVM_TOOLS_BINARY_DIR ${METAL_LLVM_TOOLS_DIR})
set(LLVM_TOOLS_DIR ${METAL_LLVM_TOOLS_DIR})

add_subdirectory(include)
add_subdirectory(lib)
add_subdirectory(test)
add_subdirectory(metal-opt)
add_subdirectory(metal-translate)
add_subdirectory(examples)
