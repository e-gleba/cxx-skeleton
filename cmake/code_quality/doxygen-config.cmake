find_package(Doxygen)

if(DOXYGEN_FOUND)
    # Core Doxygen configuration
    set(DOXYGEN_PROJECT_NAME "${PROJECT_NAME}")
    set(DOXYGEN_PROJECT_NUMBER "${PROJECT_VERSION}")
    set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated-docs")
    set(DOXYGEN_CREATE_SUBDIRS YES)
    set(DOXYGEN_FULL_PATH_NAMES NO)

    # Modern C++ features
    # Documentation is a host-only activity. When cross-compiling,
    # Doxygen would run on the host but try to parse headers from
    # the cross-sysroot, which is extremely slow or hangs entirely
    # (especially with CLANG_ASSISTED_PARSING). Skip entirely.
    if(NOT CMAKE_CROSSCOMPILING)
        set(DOXYGEN_CLANG_ASSISTED_PARSING YES)
    endif()
    set(DOXYGEN_CLANG_OPTIONS "-std=c++23 -stdlib=libc++")
    set(DOXYGEN_CPP_CLI_SUPPORT YES)
    set(DOXYGEN_MARKDOWN_SUPPORT YES)

    # Output formats
    set(DOXYGEN_GENERATE_HTML YES)
    set(DOXYGEN_HTML_OUTPUT html)
    set(DOXYGEN_GENERATE_MAN YES)
    set(DOXYGEN_MAN_OUTPUT man)

    # Content configuration
    set(DOXYGEN_EXCLUDE_PATTERNS "*/build/*" "*/third_party/*" "*/tests/*")

    set(DOXYGEN_RECURSIVE YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_EXTRACT_PRIVATE YES)

    # Modern documentation features
    set(DOXYGEN_HTML_COLORSTYLE "dark")
    set(DOXYGEN_INTERACTIVE_SVG YES)
    set(DOXYGEN_MATHJAX_FORMAT TeX)
    set(DOXYGEN_USE_MATHJAX YES)

    doxygen_add_docs(
        doxygen
        "${PROJECT_SOURCE_DIR}/src"
        "${PROJECT_SOURCE_DIR}/include"
        ALL
        COMMENT "Building API documentation")

    # Trailing / on DIRECTORY source: installs CONTENTS of the
    # directory, not the directory itself. Without it, you get
    # <prefix>/share/doc/<name>/generated-docs/html/ instead of
    # <prefix>/share/doc/<name>/html/.
    # Ref: https://cmake.org/cmake/help/latest/command/install.html#directory
    include(GNUInstallDirs)
    install(
        DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated-docs/"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}"
        COMPONENT documentation
        OPTIONAL)
else()
    message(
        NOTICE
        "Doxygen not found — documentation target disabled\n"
        "Install with:\n"
        "  Fedora:  sudo dnf install doxygen graphviz\n"
        "  Ubuntu:  sudo apt install doxygen\n"
        "  macOS:   brew install doxygen\n"
        "  Windows: choco install doxygen.install")
endif()
