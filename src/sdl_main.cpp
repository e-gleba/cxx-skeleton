#include <SDL3/SDL.h>
#include <SDL3/SDL_main.h>
#include <SDL3/SDL_messagebox.h>

#include <cstdlib>

int main([[maybe_unused]] int argc, [[maybe_unused]] char* argv[])
{
    if (!SDL_Init(SDL_INIT_EVENTS | SDL_INIT_VIDEO)) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "SDL_Init failed: %s", SDL_GetError());
        return EXIT_FAILURE;
    }

    struct sdl_guard final { ~sdl_guard() { SDL_Quit(); } } sdl_guard;

    const SDL_MessageBoxButtonData buttons[] = {
            { SDL_MESSAGEBOX_BUTTON_RETURNKEY_DEFAULT, 1, "Info" },
            { SDL_MESSAGEBOX_BUTTON_ESCAPEKEY_DEFAULT, 2, "Exit" },
    };

    const SDL_MessageBoxData box = {
            SDL_MESSAGEBOX_INFORMATION, // flags
            nullptr,                    // parent window
            "Hello World",              // title
            "!! Your SDL project successfully runs on Android !!", // message
            (int)(sizeof(buttons) / sizeof(buttons[0])), // num buttons
            buttons,                    // buttons
            nullptr                     // color scheme
    };

    int button_id = -1;
    if (!SDL_ShowMessageBox(&box, &button_id)) {
        SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "ShowMessageBox failed: %s", SDL_GetError());
        return EXIT_FAILURE;
    }

    if (button_id == 1) {
        // Minimal “about me” info; tweak as needed
        if (!SDL_ShowSimpleMessageBox(
                SDL_MESSAGEBOX_INFORMATION,
                "About",
                "Minimalist system architect.\n"
                "- C/C++/Python\n"
                "- alt linux, bash\n"
                "- snake_case, dir-name, less code fewer bugs\n",
                nullptr)) {
            SDL_LogError(SDL_LOG_CATEGORY_APPLICATION, "Info box failed: %s", SDL_GetError());
            return EXIT_FAILURE;
        }
    }

    return EXIT_SUCCESS;
}