# When updating, do not forget to place java impl in sync
cpmaddpackage(
    NAME
    SDL3
    GITHUB_REPOSITORY
    libsdl-org/SDL
    VERSION
    3.4.2
    GIT_TAG
    release-3.4.2
    SYSTEM
    ON
    GIT_SHALLOW
    ON
    OPTIONS
    # Core library config - fast shared build
    "SDL_STATIC
    OFF"
    "SDL_SHARED
    ON"
    # Performance optimizations
    "SDL_CCACHE
    ON"
    "CMAKE_BUILD_TYPE RelWithDebInfo"
    # Disable unnecessary features for speed
    "SDL_TEST_LIBRARY OFF"
    "SDL_TESTS OFF"
    "SDL_EXAMPLES OFF"
    "SDL_INSTALL_TESTS OFF"
    "SDL_DISABLE_INSTALL_DOCS ON"
    # Platform optimizations (Linux/Wayland focused)
    "SDL_X11
    OFF"
    "SDL_WAYLAND
    ON"
    "SDL_VULKAN
    OFF"
    "SDL_RENDER_VULKAN
    OFF"
    "SDL_ASSEMBLY
    OFF"
    # Disable X11 screensaver extension
    "SDL_X11_XSCRNSAVER OFF")
