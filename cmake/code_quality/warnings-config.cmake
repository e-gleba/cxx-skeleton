add_library(warnings INTERFACE)

target_compile_options(
    warnings
    INTERFACE # GCC / Clang / AppleClang
              $<$<NOT:$<CXX_COMPILER_ID:MSVC>>:
              -Wall
              -Wextra
              -Wpedantic
              -Wconversion
              -Werror
              >
              $<$<CXX_COMPILER_ID:MSVC>:
              /W4
              /WX
              /wd4100 # unreferenced formal parameter
              /wd4505 # unreferenced local function removed
              >)

set_target_properties(warnings PROPERTIES CMAKE_COMPILE_WARNINGS_AS_ERROR TRUE)
