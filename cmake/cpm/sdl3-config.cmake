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
    GIT_SHALLOW
    ON
    SYSTEM
    TRUE
    EXCLUDE_FROM_ALL
    TRUE
    OPTIONS
    # Library type
    "SDL_SHARED ON"
    "SDL_STATIC OFF"
    # Build tooling
    "SDL_CCACHE ON"
    # Kill all test/example/install bloat
    "SDL_TEST_LIBRARY OFF"
    "SDL_TESTS OFF"
    "SDL_EXAMPLES OFF"
    "SDL_INSTALL_TESTS OFF"
    "SDL_DISABLE_INSTALL ON"
    "SDL_DISABLE_INSTALL_DOCS ON"
    # Video — Wayland only
    "SDL_WAYLAND ON"
    "SDL_X11 OFF"
    "SDL_KMSDRM OFF"
    "SDL_OFFSCREEN OFF"
    # Render — minimal
    "SDL_VULKAN OFF"
    "SDL_RENDER_VULKAN OFF"
    "SDL_RENDER_GPU OFF"
    "SDL_OPENGLES OFF"
    # Audio — only modern backends
    "SDL_ALSA OFF"
    "SDL_JACK OFF"
    "SDL_SNDIO OFF"
    "SDL_DISKAUDIO OFF"
    "SDL_DUMMYAUDIO ON"
    "SDL_PIPEWIRE ON"
    "SDL_PULSEAUDIO ON"
    # Input — trim if you don't need it
    "SDL_HAPTIC OFF"
    "SDL_SENSOR OFF"
    "SDL_HIDAPI OFF"
    "SDL_VIRTUAL_JOYSTICK OFF"
    # Misc — disable what you don't use
    "SDL_CAMERA OFF"
    "SDL_DIALOG OFF"
    "SDL_LOCALE OFF"
    "SDL_POWER OFF"
    # Platform integration — trim
    "SDL_IBUS OFF"
    "SDL_FCITX OFF"
    # CPU
    "SDL_ASSEMBLY OFF"
    # Disable X11 screensaver extension
    "SDL_X11_XSCRNSAVER OFF")
