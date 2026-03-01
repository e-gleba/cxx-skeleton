cpmaddpackage(
    NAME
    tracy
    VERSION
    0.13.1
    GITHUB_REPOSITORY
    wolfpld/tracy
    GIT_SHALLOW
    TRUE
    GIT_PROGRESS
    TRUE
    EXCLUDE_FROM_ALL
    YES
    SYSTEM
    YES
    OPTIONS
    # build config
    "TRACY_STATIC ON"
    "TRACY_LTO OFF"
    # core functionality
    "TRACY_ENABLE ON" # master switch
    "TRACY_ON_DEMAND OFF" # start profiling only when connected to server
    "TRACY_DELAYED_INIT OFF" # defer init until first tracy call
    "TRACY_MANUAL_LIFETIME OFF" # manual profile start/stop (requires DELAYED_INIT=ON)
    # callstack options
    "TRACY_CALLSTACK OFF" # force callstack capture for all zones (perf hit)
    "TRACY_NO_CALLSTACK OFF" # disable callstack entirely
    "TRACY_NO_CALLSTACK_INLINES OFF" # strip inline funcs from stacks
    "TRACY_LIBUNWIND_BACKTRACE OFF" # use libunwind instead of platform default
    "TRACY_SYMBOL_OFFLINE_RESOLVE OFF" # defer symbol resolution to offline analysis
    "TRACY_LIBBACKTRACE_ELF_DYNLOAD_SUPPORT OFF" # support for dynamically loaded libs
    # network/discovery
    "TRACY_ONLY_LOCALHOST OFF" # bind to 127.0.0.1 only
    "TRACY_NO_BROADCAST OFF" # disable LAN discovery broadcasts
    "TRACY_ONLY_IPV4 OFF" # ipv4-only mode
    # data capture toggles
    "TRACY_NO_CODE_TRANSFER OFF" # disable source code fetch
    "TRACY_NO_CONTEXT_SWITCH OFF" # disable OS context switch events
    "TRACY_NO_SAMPLING OFF" # disable statistical sampling
    "TRACY_NO_VSYNC_CAPTURE OFF" # disable vsync event capture
    "TRACY_NO_FRAME_IMAGE OFF" # disable frame screenshots
    "TRACY_NO_SYSTEM_TRACING OFF" # disable systrace (linux ftrace/android)
    "TRACY_NO_EXIT OFF" # block app exit until profile uploaded
    # validation/debugging
    "TRACY_NO_VERIFY OFF" # skip zone validation in C api
    "TRACY_NO_CRASH_HANDLER OFF" # disable crash handler
    "TRACY_IGNORE_MEMORY_FAULTS OFF" # ignore unmatched free() events
    "TRACY_VERBOSE OFF" # spam console with profiler internals
    # platform workarounds
    "TRACY_TIMER_FALLBACK OFF" # use lower-res timers (ancient hw)
    "TRACY_PATCHABLE_NOPSLEDS OFF" # nop sleds for rr/gdb patching
    "TRACY_DEMANGLE OFF" # disable default symbol demangling
    # optional integrations
    "TRACY_FIBERS OFF" # fiber/coroutine support
    "TRACY_DEBUGINFOD OFF" # debuginfod symbol server (needs libdebuginfod)
    "TRACY_Fortran OFF" # fortran bindings
    "TRACY_CLIENT_PYTHON OFF" # python bindings (forces shared lib)
    # rocm gpu profiling (auto-detected if /opt/rocm exists)
    # "TRACY_ROCPROF_CALIBRATION OFF"      # continuous gpu time calibration (rocm only)
)

if(${tracy_ADDED})
    include(GNUInstallDirs)
    include(ExternalProject)

    # Allow the user to override where host tools are installed.
    # Defaults to <install_prefix>/tools/tracy.
    set(TRACY_TOOLS_INSTALL_DIR
        "${CMAKE_INSTALL_LIBEXECDIR}/tracy"
        CACHE PATH "Installation directory for Tracy profiler tools")

    # Use a stable directory layout under the main build tree.
    set(tracy_profiler_prefix "${CMAKE_BINARY_DIR}/_deps/tracy-profiler")

    externalproject_add(
        tracy_profiler
        # ── Source ─────────────────────────────────────────
        # CPM already downloaded the source. Point directly
        # at the profiler subdirectory — no re-download.
        SOURCE_DIR "${Tracy_SOURCE_DIR}/profiler"
        PREFIX "${tracy_profiler_prefix}"
        BINARY_DIR "${tracy_profiler_prefix}/build"
        STAMP_DIR "${tracy_profiler_prefix}/stamp"
        TMP_DIR "${tracy_profiler_prefix}/tmp"
        INSTALL_DIR "${tracy_profiler_prefix}/install"
        # ── No download step — source already exists ──────
        DOWNLOAD_COMMAND ""
        # ── Configure ──────────────────────────────────────
        # Forward the HOST compiler (not the cross-compiler).
        # CMAKE_CROSSCOMPILING is FALSE here, so CMAKE_C/CXX
        # _COMPILER point to the host compiler. We explicitly
        # do NOT forward CMAKE_TOOLCHAIN_FILE.
        CMAKE_ARGS -DCMAKE_BUILD_TYPE=Release
                   -DCMAKE_INSTALL_PREFIX=<INSTALL_DIR>
                   # Forward host compiler explicitly so the
                   # ExternalProject doesn't accidentally inherit a
                   # cross-compilation toolchain from the environment.
                   -DCMAKE_C_COMPILER=${CMAKE_C_COMPILER}
                   -DCMAKE_CXX_COMPILER=${CMAKE_CXX_COMPILER}
                   # Tracy profiler's own options:
                   -DTRACY_NO_ISA_EXTENSIONS=ON
        # ── Build ──────────────────────────────────────────
        BUILD_COMMAND
            "${CMAKE_COMMAND}" --build <BINARY_DIR> --config Release --parallel
        # ── Install into local staging prefix ──────────────
        INSTALL_COMMAND
            "${CMAKE_COMMAND}" --install <BINARY_DIR> --config Release --prefix
            <INSTALL_DIR>
        # ── Behavior ───────────────────────────────────────
        # Don't rebuild every time — source doesn't change
        # after CPM downloads it.
        BUILD_ALWAYS OFF
        USES_TERMINAL_BUILD ON
        USES_TERMINAL_CONFIGURE ON)

    # ── Install the profiler into the main project's install tree ──
    # ExternalProject installs into a local staging directory.
    # This install(DIRECTORY) copies the staged binaries into the
    # real install prefix when the user runs cmake --install.
    #
    # The trailing / on DIRECTORY is critical — it installs the
    # CONTENTS, not the directory itself.
    #
    # OPTIONAL: the profiler may not be built (e.g., missing
    # system dependencies like wayland/X11 dev headers). Don't
    # fail the install if it's absent.
    install(
        DIRECTORY "${tracy_profiler_prefix}/install/bin/"
        DESTINATION "${TRACY_TOOLS_INSTALL_DIR}"
        COMPONENT tools
        USE_SOURCE_PERMISSIONS OPTIONAL)

    # Also install any Tracy profiler shared libs if present.
    install(
        DIRECTORY "${tracy_profiler_prefix}/install/lib/"
        DESTINATION "${TRACY_TOOLS_INSTALL_DIR}"
        COMPONENT tools
        USE_SOURCE_PERMISSIONS OPTIONAL FILES_MATCHING
        PATTERN "*.so*"
        PATTERN "*.dylib*")
endif()
