# dot (Graphviz) for dependency/call graphs
find_package(Doxygen OPTIONAL_COMPONENTS dot)

if(DOXYGEN_FOUND)
    # ─── Core ──────────────────────────────────────────────
    set(DOXYGEN_PROJECT_NAME "${PROJECT_NAME}")
    set(DOXYGEN_PROJECT_NUMBER "${PROJECT_VERSION}")
    set(DOXYGEN_PROJECT_BRIEF "${PROJECT_DESCRIPTION}")
    set(DOXYGEN_OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated-docs")
    set(DOXYGEN_CREATE_SUBDIRS YES)
    set(DOXYGEN_FULL_PATH_NAMES NO)

    # ─── Modern C++ parsing ────────────────────────────────
    # Clang-assisted parsing runs on the host.  When cross-compiling
    # it tries to parse cross-sysroot headers — extremely slow or hangs.
    if(NOT CMAKE_CROSSCOMPILING)
        set(DOXYGEN_CLANG_ASSISTED_PARSING YES)
        set(DOXYGEN_CLANG_OPTIONS "-std=c++23 -stdlib=libc++")
    endif()
    set(DOXYGEN_CPP_CLI_SUPPORT YES)
    set(DOXYGEN_MARKDOWN_SUPPORT YES)

    # ─── Output formats ────────────────────────────────────
    set(DOXYGEN_GENERATE_HTML YES)
    set(DOXYGEN_HTML_OUTPUT html)
    set(DOXYGEN_GENERATE_MAN YES)
    set(DOXYGEN_MAN_OUTPUT man)

    # ─── Content ───────────────────────────────────────────
    set(DOXYGEN_EXCLUDE_PATTERNS "*/build/*" "*/third_party/*" "*/tests/*")
    set(DOXYGEN_RECURSIVE YES)
    set(DOXYGEN_EXTRACT_ALL YES)
    set(DOXYGEN_EXTRACT_PRIVATE YES)

    # ─── Presentation ─────────────────────────────────────
    set(DOXYGEN_HTML_COLORSTYLE "dark")
    set(DOXYGEN_INTERACTIVE_SVG YES)
    set(DOXYGEN_USE_MATHJAX YES)
    set(DOXYGEN_MATHJAX_FORMAT TeX)

    # ─── Graphs (only when dot available) ──────────────────
    if(DOXYGEN_DOT_FOUND)
        set(DOXYGEN_HAVE_DOT YES)
        set(DOXYGEN_DOT_IMAGE_FORMAT svg)
        set(DOXYGEN_CLASS_GRAPH YES)
        set(DOXYGEN_COLLABORATION_GRAPH YES)
        set(DOXYGEN_CALL_GRAPH YES)
        set(DOXYGEN_UML_LOOK YES)
        set(DOXYGEN_DOT_UML_DETAILS YES)
        set(DOXYGEN_DOT_WRAP_THRESHOLD 100)
    endif()

    # ─── Target ────────────────────────────────────────────
    doxygen_add_docs(
        ${PROJECT_NAME}-docs "${PROJECT_SOURCE_DIR}/src"
        "${PROJECT_SOURCE_DIR}/include"
        COMMENT "building api documentation with doxygen")

    include(GNUInstallDirs)
    install(
        DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}/generated-docs/"
        DESTINATION "${CMAKE_INSTALL_DOCDIR}"
        COMPONENT documentation
        OPTIONAL)
else()
    message(
        NOTICE
        "doxygen not found -- documentation target disabled\n"
        "  fedora:  sudo dnf install doxygen graphviz\n"
        "  ubuntu:  sudo apt install doxygen graphviz\n"
        "  macos:   brew install doxygen graphviz\n"
        "  windows: choco install doxygen.install graphviz")
endif()
