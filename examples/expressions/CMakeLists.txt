add_llvm_executable(examplesExpressions
        main.cpp
)

target_link_libraries(examplesExpressions
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
