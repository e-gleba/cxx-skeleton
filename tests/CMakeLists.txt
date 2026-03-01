cmake_minimum_required(VERSION 3.31)

file(
    GLOB_RECURSE
    src
    CONFIGURE_DEPENDS
    "${CMAKE_CURRENT_LIST_DIR}/*.cpp")

if(CMAKE_SYSTEM_NAME STREQUAL "Android")
    add_library(tests SHARED ${src})
else()
    add_executable(tests ${src})
endif()

if(NOT
   CMAKE_SYSTEM_NAME
   STREQUAL
   "Android")
    set_source_files_properties("junit4_jni.cpp" PROPERTIES HEADER_FILE_ONLY
                                                            TRUE)
endif()

target_include_directories(tests PRIVATE ${CMAKE_CURRENT_LIST_DIR})

set_target_properties(
    tests
    PROPERTIES CXX_STANDARD 23
               CXX_STANDARD_REQUIRED ON
               CXX_SCAN_FOR_MODULES OFF
               CXX_EXTENSIONS OFF)

target_link_libraries(tests PRIVATE doctest::doctest
                                    $<$<PLATFORM_ID:Android>:log>)

target_compile_definitions(
    tests
    PRIVATE DOCTEST_CONFIG_SUPER_FAST_ASSERTS
            DOCTEST_CONFIG_NO_SHORT_MACRO_NAMES
            DOCTEST_CONFIG_ASSERTS_RETURN_VALUES
            DOCTEST_CONFIG_USE_STD_HEADERS)

if(NOT CMAKE_CROSSCOMPILING)
    include(doctest)
    doctest_discover_tests(tests)
endif()
