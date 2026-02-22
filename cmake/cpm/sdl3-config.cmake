# When update, do not forget to place java impl in sync
cpmaddpackage(
    NAME
    SDL3
    GITHUB_REPOSITORY
    libsdl-org/SDL
    GIT_TAG
    a8589a84226a6202831a3d49ff4edda4acab9acd
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
    OFF")