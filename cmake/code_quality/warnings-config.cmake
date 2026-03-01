# ─── Compiler Warnings ─────────────────────────────────────────────
# INTERFACE library that propagates warning flags to all consumers
# via target_link_libraries(... PRIVATE warnings).
#
# Loaded via find_package(warnings CONFIG REQUIRED).
# ───────────────────────────────────────────────────────────────────

add_library(warnings INTERFACE)

# ─── Warnings-as-errors toggle ─────────────────────────────────────
# Enabled by default for development. CI or consumers can disable
# with -DWARNINGS_AS_ERRORS=OFF if needed (e.g., upgrading a
# compiler that introduces new warnings).
option(WARNINGS_AS_ERRORS "Treat compiler warnings as errors" ON)

# ─── Warning flags ─────────────────────────────────────────────────
# COMPILE_LANG_AND_ID ensures flags only apply to the correct
# language + compiler combination. The old pattern
# $<NOT:$<CXX_COMPILER_ID:MSVC>> matches ANY non-MSVC compiler,
# including ones that don't understand GCC/Clang flags (e.g., Intel
# classic, NVCC). COMPILE_LANG_AND_ID is precise.
# Ref: https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html
target_compile_options(
    warnings
    INTERFACE # ── GCC / Clang / AppleClang (C++) ─────────────────────
              $<$<COMPILE_LANG_AND_ID:CXX,GNU,Clang,AppleClang>:
              -Wall
              -Wextra
              -Wpedantic
              -Wconversion
              -Wshadow
              -Wnon-virtual-dtor
              -Wold-style-cast
              -Wcast-align
              -Woverloaded-virtual
              -Wformat=2
              $<$<BOOL:${WARNINGS_AS_ERRORS}>:-Werror>
              >
              # ── GCC / Clang / AppleClang (C) ──────────────────────
              $<$<COMPILE_LANG_AND_ID:C,GNU,Clang,AppleClang>:
              -Wall
              -Wextra
              -Wpedantic
              -Wconversion
              -Wshadow
              -Wcast-align
              -Wformat=2
              $<$<BOOL:${WARNINGS_AS_ERRORS}>:-Werror>
              >
              # ── MSVC (C and C++) ──────────────────────────────────
              $<$<COMPILE_LANG_AND_ID:CXX,MSVC>:
              /W4
              # /wd4100: unreferenced formal parameter.
              #   Common in interface implementations and
              #   callback signatures where parameters are
              #   required by the API but unused in a
              #   specific override. Suppressing is standard
              #   practice for MSVC /W4 builds.
              /wd4100
              # /wd4505: unreferenced local function removed.
              #   Triggers on static functions in headers that
              #   are included but not called in every TU.
              #   Unavoidable with header-only libraries.
              /wd4505
              $<$<BOOL:${WARNINGS_AS_ERRORS}>:/WX>
              >
              $<$<COMPILE_LANG_AND_ID:C,MSVC>:
              /W4
              /wd4100
              /wd4505
              $<$<BOOL:${WARNINGS_AS_ERRORS}>:/WX>
              >)
