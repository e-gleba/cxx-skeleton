#include <SDL3/SDL.h>
#include <SDL3/SDL_main.h>

#include <cstdlib>

int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
{
    if (!SDL_Init(SDL_INIT_VIDEO)) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION,
                     "SDL_Init failed: %s",
                     SDL_GetError());
        return EXIT_FAILURE;
    }

    struct sdl_guard final
    {
        ~sdl_guard() { SDL_Quit(); }
    } guard;

    constexpr SDL_MessageBoxButtonData buttons[] = {
        { SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT, 0, "OK" },
        { SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT, 1, "Exit" }
    };

    const SDL_MessageBoxData box = { SDL_MESSAGEBOX_INFORMATION,
                                     nullptr,
                                     "Hello World",
                                     "SDL3 + C++23",
                                     2,
                                     buttons,
                                     nullptr };

    int button_id = -1;
    if (!SDL_ShowMessageBox(&box, &button_id)) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION,
                     "ShowMessageBox failed: %s",
                     SDL_GetError());
        return EXIT_FAILURE;
    }

    return EXIT_SUCCESS;
}
