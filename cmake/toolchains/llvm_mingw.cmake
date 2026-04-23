# cmake/toolchains/llvm_mingw.cmake
include_guard(GLOBAL)

set(CMAKE_SYSTEM_NAME Windows)

if(NOT DEFINED CMAKE_SYSTEM_PROCESSOR)
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
endif()

set(LLVM_MINGW_VERSION
    "20260421"
    CACHE STRING "llvm-mingw release tag")
set(LLVM_MINGW_HOST_OS
    "ubuntu-22.04"
    CACHE STRING "llvm-mingw host package suffix")
option(LLVM_MINGW_AUTO_DOWNLOAD "Download llvm-mingw if missing" ON)

if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
    set(_host_arch aarch64)
else()
    set(_host_arch x86_64)
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
    set(_triple aarch64-w64-mingw32)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|amd64|AMD64)$")
    set(_triple x86_64-w64-mingw32)
else()
    message(
        FATAL_ERROR
            "unsupported CMAKE_SYSTEM_PROCESSOR='${CMAKE_SYSTEM_PROCESSOR}'")
endif()

get_filename_component(_root_dir "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
set(_install_dir "${_root_dir}/llvm_mingw")
set(_pkg
    "llvm-mingw-${LLVM_MINGW_VERSION}-ucrt-${LLVM_MINGW_HOST_OS}-${_host_arch}")
set(_url
    "https://github.com/mstorsjo/llvm-mingw/releases/download/${LLVM_MINGW_VERSION}/${_pkg}.tar.xz"
)
set(_archive "${_root_dir}/${_pkg}.tar.xz")

if(NOT EXISTS "${_install_dir}/bin/${_triple}-clang")
    if(NOT LLVM_MINGW_AUTO_DOWNLOAD)
        message(FATAL_ERROR "llvm-mingw not found: '${_install_dir}'")
    endif()

    file(
        DOWNLOAD "${_url}" "${_archive}"
        SHOW_PROGRESS
        STATUS _dl
        TLS_VERIFY ON)
    list(
        GET
        _dl
        0
        _dl_code)
    if(NOT
       _dl_code
       EQUAL
       0)
        list(
            GET
            _dl
            1
            _dl_msg)
        file(REMOVE "${_archive}")
        message(FATAL_ERROR "download failed: '${_dl_msg}'")
    endif()

    file(
        ARCHIVE_EXTRACT
        INPUT
        "${_archive}"
        DESTINATION
        "${_root_dir}")
    file(REMOVE_RECURSE "${_install_dir}")
    file(RENAME "${_root_dir}/${_pkg}" "${_install_dir}")
    file(REMOVE "${_archive}")
endif()

set(CMAKE_C_COMPILER
    "${_install_dir}/bin/${_triple}-clang"
    CACHE FILEPATH "" FORCE)
set(CMAKE_CXX_COMPILER
    "${_install_dir}/bin/${_triple}-clang++"
    CACHE FILEPATH "" FORCE)
set(CMAKE_RC_COMPILER
    "${_install_dir}/bin/${_triple}-windres"
    CACHE FILEPATH "" FORCE)
set(CMAKE_AR
    "${_install_dir}/bin/llvm-ar"
    CACHE FILEPATH "" FORCE)
set(CMAKE_RANLIB
    "${_install_dir}/bin/llvm-ranlib"
    CACHE FILEPATH "" FORCE)

set(CMAKE_SYSROOT
    "${_install_dir}/${_triple}"
    CACHE PATH "" FORCE)
set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
