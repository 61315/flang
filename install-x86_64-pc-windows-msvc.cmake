# install-x86_64-pc-windows-msvc.cmake

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
    "${LLVM_INSTALL_DIR}/bin/flang-new.exe"
    "${LLVM_INSTALL_DIR}/bin/flang.exe"
    "${LLVM_INSTALL_DIR}/bin/libomp.dll"
    "${LLVM_INSTALL_DIR}/bin/libiomp5md.dll"
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
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-pc-windows-msvc/flang_rt.runtime.dynamic.lib"
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-pc-windows-msvc/flang_rt.runtime.static.lib"
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-pc-windows-msvc/flang_rt.runtime.dynamic_dbg.lib"
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/x86_64-pc-windows-msvc/flang_rt.runtime.static_dbg.lib"
)

# drop arch tag
configure_file(
    "${LLVM_INSTALL_DIR}/lib/clang/21/lib/windows/clang_rt.builtins-x86_64.lib"
    "${PACKAGE_PREFIX}/lib/clang_rt.builtins.lib"
    COPYONLY
)

# compiler libraries
file(INSTALL
  DESTINATION "${PACKAGE_PREFIX}/lib"
  TYPE FILE
  FILES
    # "${LLVM_INSTALL_DIR}/lib/CUFAttrs.lib"
    # "${LLVM_INSTALL_DIR}/lib/CUFDialect.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRAnalysis.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRBuilder.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRCodeGen.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRCodeGenDialect.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRDialect.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRDialectSupport.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIROpenACCSupport.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIROpenMPSupport.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRSupport.lib"
    # "${LLVM_INSTALL_DIR}/lib/FIRTransforms.lib"
    # "${LLVM_INSTALL_DIR}/lib/flangFrontend.lib"
    # "${LLVM_INSTALL_DIR}/lib/flangFrontendTool.lib"
    # "${LLVM_INSTALL_DIR}/lib/FlangOpenMPTransforms.lib"
    # "${LLVM_INSTALL_DIR}/lib/flangPasses.lib"
    "${LLVM_INSTALL_DIR}/lib/FortranDecimal.lib"
    # "${LLVM_INSTALL_DIR}/lib/FortranEvaluate.lib"
    # "${LLVM_INSTALL_DIR}/lib/FortranLower.lib"
    # "${LLVM_INSTALL_DIR}/lib/FortranParser.lib"
    # "${LLVM_INSTALL_DIR}/lib/FortranSemantics.lib"
    # "${LLVM_INSTALL_DIR}/lib/FortranSupport.lib"
    # "${LLVM_INSTALL_DIR}/lib/HLFIRDialect.lib"
    # "${LLVM_INSTALL_DIR}/lib/HLFIRTransforms.lib"
    "${LLVM_INSTALL_DIR}/lib/libiomp5md.lib"
    "${LLVM_INSTALL_DIR}/lib/libomp.lib"
)
