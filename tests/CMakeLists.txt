cmake_minimum_required(VERSION 3.30)

file(
    GLOB_RECURSE
    src
    CONFIGURE_DEPENDS
    "*.cpp")

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    add_library(tests SHARED ${src})
else()
    add_executable(tests ${src})
endif()

if(NOT
   CMAKE_SYSTEM_NAME
   STREQUAL
   "Android")
    set_source_files_properties(junit4_jni.cpp PROPERTIES HEADER_FILE_ONLY TRUE)
endif()

target_include_directories(tests PRIVATE ${CMAKE_CURRENT_LIST_DIR})

set_target_properties(tests PROPERTIES CXX_STANDARD 23 CXX_STANDARD_REQUIRED ON
                                       CXX_EXTENSIONS OFF)

target_link_libraries(tests PRIVATE doctest::doctest
                                    $<$<PLATFORM_ID:Android>:log>)

target_compile_definitions(
    tests
    PRIVATE
        # Use full macro names (e.g., DOCTEST_TEST_CASE instead of TEST_CASE)
        DOCTEST_CONFIG_SUPER_FAST_ASSERTS
        DOCTEST_CONFIG_NO_SHORT_MACRO_NAMES
        # Enable all asserts (even in release-like builds)
        DOCTEST_CONFIG_ASSERTS_RETURN_VALUES # makes asserts usable in constexpr/void contexts
        # For better debugging:
        DOCTEST_CONFIG_USE_STD_HEADERS # use <iostream>, <string>, etc. instead of reimplementing
    )

if(CMAKE_SYSTEM_NAME MATCHES "Linux|Windows|Darwin")
    if(NOT CMAKE_CROSSCOMPILING)
        include(doctest)
        doctest_discover_tests(tests)
    endif()
endif()
