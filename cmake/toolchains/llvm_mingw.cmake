include_guard(GLOBAL)

# ── tunables ─────────────────────────────────────────────────────────────────
set(LLVM_MINGW_VERSION
    "20260421"
    CACHE STRING "llvm-mingw release tag")
set(LLVM_MINGW_HOST_OS
    "ubuntu-22.04"
    CACHE STRING "llvm-mingw host OS package suffix")
option(LLVM_MINGW_AUTO_DOWNLOAD "Download llvm-mingw if absent" ON)

# ── host arch ────────────────────────────────────────────────────────────────
if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
    set(_host_arch aarch64)
else()
    set(_host_arch x86_64)
endif()

# ── target triple ────────────────────────────────────────────────────────────
if(NOT DEFINED CMAKE_SYSTEM_PROCESSOR)
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
endif()

if(CMAKE_SYSTEM_PROCESSOR MATCHES "^(aarch64|arm64|ARM64)$")
    set(_triple aarch64-w64-mingw32)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^(x86_64|amd64|AMD64)$")
    set(_triple x86_64-w64-mingw32)
elseif(CMAKE_SYSTEM_PROCESSOR MATCHES "^i[3-6]86$")
    set(_triple i686-w64-mingw32)
else()
    message(
        FATAL_ERROR
            "llvm_mingw: unsupported CMAKE_SYSTEM_PROCESSOR='${CMAKE_SYSTEM_PROCESSOR}'"
    )
endif()

# ── paths ────────────────────────────────────────────────────────────────────
get_filename_component(_root "${CMAKE_CURRENT_LIST_DIR}/../.." ABSOLUTE)
set(_install "${_root}/llvm_mingw")
set(_pkg
    "llvm-mingw-${LLVM_MINGW_VERSION}-ucrt-${LLVM_MINGW_HOST_OS}-${_host_arch}")
set(_url
    "https://github.com/mstorsjo/llvm-mingw/releases/download/${LLVM_MINGW_VERSION}/${_pkg}.tar.xz"
)
set(_archive "${_root}/${_pkg}.tar.xz")

# ── download / extract ───────────────────────────────────────────────────────
if(NOT EXISTS "${_install}/bin/${_triple}-clang")
    if(NOT LLVM_MINGW_AUTO_DOWNLOAD)
        message(
            FATAL_ERROR
                "llvm-mingw not found at '${_install}'\n"
                "Re-run with -DLLVM_MINGW_AUTO_DOWNLOAD=ON or place the toolchain there."
        )
    endif()

    message(STATUS "llvm-mingw: fetching '${_pkg}'")
    file(
        DOWNLOAD "${_url}" "${_archive}"
        SHOW_PROGRESS
        STATUS _dl_status
        TLS_VERIFY ON)
    list(
        GET
        _dl_status
        0
        _dl_code)
    if(NOT
       _dl_code
       EQUAL
       0)
        list(
            GET
            _dl_status
            1
            _dl_msg)
        file(REMOVE "${_archive}")
        message(FATAL_ERROR "llvm-mingw: download failed => '${_dl_msg}'")
    endif()

    message(STATUS "llvm-mingw: extracting '${_pkg}.tar.xz'")
    file(
        ARCHIVE_EXTRACT
        INPUT
        "${_archive}"
        DESTINATION
        "${_root}")
    file(REMOVE_RECURSE "${_install}")
    file(RENAME "${_root}/${_pkg}" "${_install}")
    file(REMOVE "${_archive}")
    message(STATUS "llvm-mingw: installed => '${_install}'")
endif()

# ── toolchain ────────────────────────────────────────────────────────────────
set(CMAKE_C_COMPILER
    "${_install}/bin/${_triple}-clang"
    CACHE FILEPATH "" FORCE)
set(CMAKE_CXX_COMPILER
    "${_install}/bin/${_triple}-clang++"
    CACHE FILEPATH "" FORCE)
set(CMAKE_RC_COMPILER
    "${_install}/bin/${_triple}-windres"
    CACHE FILEPATH "" FORCE)
set(CMAKE_AR
    "${_install}/bin/llvm-ar"
    CACHE FILEPATH "" FORCE)
set(CMAKE_RANLIB
    "${_install}/bin/llvm-ranlib"
    CACHE FILEPATH "" FORCE)
set(CMAKE_LINKER
    "${_install}/bin/ld.lld"
    CACHE FILEPATH "" FORCE)

# ── sysroot (must come after _triple) ────────────────────────────────────────
set(CMAKE_SYSROOT
    "${_install}/${_triple}"
    CACHE PATH "" FORCE)

set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)

# Explicitly pass --sysroot via compiler flags as a belt-and-suspenders guard,
# so even if CMake loses the variable the compiler gets the right sysroot.
string(APPEND CMAKE_C_FLAGS_INIT " --sysroot=${_install}/${_triple}")
string(APPEND CMAKE_CXX_FLAGS_INIT " --sysroot=${_install}/${_triple}")
string(APPEND CMAKE_EXE_LINKER_FLAGS_INIT
       " -fuse-ld=lld --sysroot=${_install}/${_triple}")
string(APPEND CMAKE_SHARED_LINKER_FLAGS_INIT
       " -fuse-ld=lld --sysroot=${_install}/${_triple}")

# ── clang-tidy: disable when cross-compiling ─────────────────────────────────
# host clang-tidy is version-mismatched against bundled libc++ headers
set(CMAKE_C_CLANG_TIDY
    ""
    CACHE STRING "" FORCE)
set(CMAKE_CXX_CLANG_TIDY
    ""
    CACHE STRING "" FORCE)
