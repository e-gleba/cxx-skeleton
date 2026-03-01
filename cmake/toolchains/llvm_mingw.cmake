cmake_minimum_required(VERSION 3.31)

set(CMAKE_SYSTEM_NAME Windows)
if(NOT CMAKE_SYSTEM_PROCESSOR)
    set(CMAKE_SYSTEM_PROCESSOR x86_64)
endif()

# --- Arch → triple mapping ---
set(supported_triples
    x86_64
    x86_64-w64-mingw32
    i686
    i686-w64-mingw32
    aarch64
    aarch64-w64-mingw32
    armv7
    armv7-w64-mingw32)

list(LENGTH supported_triples triple_count)
math(EXPR last_index "${triple_count} - 1")
set(lm_triple "")
foreach(idx RANGE 0 ${last_index} 2)
    math(EXPR val_idx "${idx} + 1")
    list(
        GET
        supported_triples
        ${idx}
        arch)
    list(
        GET
        supported_triples
        ${val_idx}
        triple)
    if(CMAKE_SYSTEM_PROCESSOR STREQUAL arch)
        set(lm_triple "${triple}")
        break()
    endif()
endforeach()
if(NOT lm_triple)
    message(FATAL_ERROR "Unsupported target: ${CMAKE_SYSTEM_PROCESSOR}")
endif()

# --- Auto-download llvm-mingw ---
set(lm_ver "20260224")
set(lm_root "${CMAKE_SOURCE_DIR}/llvm_mingw")
option(DOWNLOAD_LLVM_MINGW_IF_NOT_EXIST "Fetch llvm-mingw automatically" ON)

if(CMAKE_HOST_SYSTEM_PROCESSOR MATCHES "aarch64|arm64|ARM64")
    set(host_arch aarch64)
else()
    set(host_arch x86_64)
endif()

set(pkg_name "llvm-mingw-${lm_ver}-ucrt-ubuntu-22.04-${host_arch}")

if(NOT EXISTS "${lm_root}/bin/clang")
    if(NOT DOWNLOAD_LLVM_MINGW_IF_NOT_EXIST)
        message(
            FATAL_ERROR
                "llvm-mingw not found at '${lm_root}' — re-run with -DDOWNLOAD_LLVM_MINGW_IF_NOT_EXIST=ON"
            )
    endif()

    set(archive_url
        "https://github.com/mstorsjo/llvm-mingw/releases/download/${lm_ver}/${pkg_name}.tar.xz"
        )
    set(archive_path "${CMAKE_SOURCE_DIR}/${pkg_name}.tar.xz")

    message(
        STATUS
            "Fetching llvm-mingw ${lm_ver} [host=${host_arch} target=${lm_triple}]…"
        )
    file(DOWNLOAD "${archive_url}" "${archive_path}" SHOW_PROGRESS)
    execute_process(
        COMMAND ${CMAKE_COMMAND} -E tar xf "${archive_path}"
        WORKING_DIRECTORY "${CMAKE_SOURCE_DIR}" COMMAND_ERROR_IS_FATAL ANY)

    file(REMOVE_RECURSE "${lm_root}")
    file(RENAME "${CMAKE_SOURCE_DIR}/${pkg_name}" "${lm_root}")
    file(REMOVE "${archive_path}")
endif()

# --- Compilers & tools ---
set(CMAKE_SYSROOT "${lm_root}/${lm_triple}")
set(CMAKE_FIND_ROOT_PATH "${lm_root}" "${CMAKE_SYSROOT}")

set(CMAKE_C_COMPILER "${lm_root}/bin/${lm_triple}-clang")
set(CMAKE_CXX_COMPILER "${lm_root}/bin/${lm_triple}-clang++")
set(CMAKE_RC_COMPILER "${lm_root}/bin/${lm_triple}-windres")
set(CMAKE_C_COMPILER_TARGET "${lm_triple}")
set(CMAKE_CXX_COMPILER_TARGET "${lm_triple}")

# LLVM tools — loop to avoid repetition
foreach(
    tool
    AR
    RANLIB
    STRIP
    OBJCOPY
    OBJDUMP
    NM
    DLLTOOL
    ADDR2LINE
    SIZE
    READELF
    MT)
    string(TOLOWER "${tool}" tool_lower)
    set(CMAKE_${tool} "${lm_root}/bin/llvm-${tool_lower}")
endforeach()

# --- Linker (LLD, fully static C++ runtime) ---
set(CMAKE_LINKER_TYPE LLD)

set(static_link_flags "-static-libgcc -static-libstdc++")
foreach(link_type EXE SHARED MODULE)
    set(CMAKE_${link_type}_LINKER_FLAGS_INIT "${static_link_flags}")
endforeach()

# --- Search-path policy ---
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
