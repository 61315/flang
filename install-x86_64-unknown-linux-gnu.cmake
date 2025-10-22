# install-x86_64-unknown-linux-gnu.cmake

if(NOT DEFINED LLVM_INSTALL_DIR)
  set(LLVM_INSTALL_DIR "${CMAKE_CURRENT_LIST_DIR}/install")
endif()

if(NOT DEFINED PACKAGE_PREFIX)
  set(PACKAGE_PREFIX "${CMAKE_CURRENT_LIST_DIR}/dist")
endif()

# bin/
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/bin"
  TYPE PROGRAM
  FILES
    "${LLVM_INSTALL_DIR}/bin/flang"
    "${LLVM_INSTALL_DIR}/bin/flang-21"
    "${LLVM_INSTALL_DIR}/bin/flang-new"
)

# include/flang/*.mod
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/include/flang"
  TYPE FILE
  FILES
    "${LLVM_INSTALL_DIR}/include/flang/__cuda_builtins.mod"
    "${LLVM_INSTALL_DIR}/include/flang/__cuda_device.mod"
    "${LLVM_INSTALL_DIR}/include/flang/__fortran_builtins.mod"
    "${LLVM_INSTALL_DIR}/include/flang/__fortran_ieee_exceptions.mod"
    "${LLVM_INSTALL_DIR}/include/flang/__fortran_type_info.mod"
    "${LLVM_INSTALL_DIR}/include/flang/__ppc_types.mod"
    "${LLVM_INSTALL_DIR}/include/flang/cooperative_groups.mod"
    "${LLVM_INSTALL_DIR}/include/flang/cudadevice.mod"
    "${LLVM_INSTALL_DIR}/include/flang/ieee_arithmetic.mod"
    "${LLVM_INSTALL_DIR}/include/flang/ieee_exceptions.mod"
    "${LLVM_INSTALL_DIR}/include/flang/ieee_features.mod"
    "${LLVM_INSTALL_DIR}/include/flang/iso_c_binding.mod"
    "${LLVM_INSTALL_DIR}/include/flang/iso_fortran_env.mod"
    "${LLVM_INSTALL_DIR}/include/flang/iso_fortran_env_impl.mod"
    "${LLVM_INSTALL_DIR}/include/flang/omp_lib.mod"
    "${LLVM_INSTALL_DIR}/include/flang/omp_lib_kinds.mod"
)

# include/flang/*.h
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/include/flang"
  TYPE FILE
  FILES
    "${LLVM_INSTALL_DIR}/include/flang/ISO_Fortran_binding.h"
    "${LLVM_INSTALL_DIR}/include/flang/omp_lib.h"
)

# fortran runtime libs
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/lib"
  TYPE FILE
  FILES
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-unknown-linux-gnu/libflang_rt.runtime.a"
)

# drop arch tag
configure_file(
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-unknown-linux-gnu/libclang_rt.builtins.a"
    "${PACKAGE_PREFIX}/lib/libclang_rt.builtins.a"
    COPYONLY
)

# compiler libraries
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/lib"
  TYPE FILE
  FILES
    # "${LLVM_INSTALL_DIR}/lib/libCUFAttrs.a"
    # "${LLVM_INSTALL_DIR}/lib/libCUFDialect.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRAnalysis.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRBuilder.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRCodeGen.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRCodeGenDialect.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRDialect.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRDialectSupport.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIROpenACCSupport.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIROpenMPSupport.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRSupport.a"
    # "${LLVM_INSTALL_DIR}/lib/libFIRTransforms.a"
    # "${LLVM_INSTALL_DIR}/lib/libflangFrontend.a"
    # "${LLVM_INSTALL_DIR}/lib/libflangFrontendTool.a"
    # "${LLVM_INSTALL_DIR}/lib/libFlangOpenMPTransforms.a"
    # "${LLVM_INSTALL_DIR}/lib/libflangPasses.a"
    "${LLVM_INSTALL_DIR}/lib/libFortranDecimal.a"
    # "${LLVM_INSTALL_DIR}/lib/libFortranEvaluate.a"
    # "${LLVM_INSTALL_DIR}/lib/libFortranLower.a"
    # "${LLVM_INSTALL_DIR}/lib/libFortranParser.a"
    # "${LLVM_INSTALL_DIR}/lib/libFortranSemantics.a"
    # "${LLVM_INSTALL_DIR}/lib/libFortranSupport.a"
    # "${LLVM_INSTALL_DIR}/lib/libHLFIRDialect.a"
    # "${LLVM_INSTALL_DIR}/lib/libHLFIRTransforms.a"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libarcher.so"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libarcher_static.a"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libgomp.so"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libgomp.so.1"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libiomp5.so"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libomp.so"
    "${LLVM_INSTALL_DIR}/lib/x86_64-unknown-linux-gnu/libompd.so"
)
