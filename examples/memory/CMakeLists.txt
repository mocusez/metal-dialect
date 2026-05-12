add_llvm_executable(examplesMemory
        main.cpp
)

target_link_libraries(examplesMemory
        PRIVATE
        MLIRExecutionEngine
        MLIRIR
        MLIRParser
        MLIRPass
        MLIRTranslateLib
        MLIRSPIRVDialect
        MLIRSupport
        LLVMSupport
        MLIRMetal
        examplesUtility
)
