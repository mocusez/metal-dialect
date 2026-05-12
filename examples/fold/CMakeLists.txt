add_llvm_executable(examplesFold
        main.cpp
)

target_link_libraries(examplesFold
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
