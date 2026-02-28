#include <print>
#include <version>

int main()
{
#if defined(_WIN32) || defined(_WIN64)
    constexpr auto os = "Windows";
#elif defined(__linux__)
    constexpr auto os = "Linux";
#elif defined(__APPLE__) && defined(__MACH__)
    constexpr auto os = "macOS";
#elif defined(__FreeBSD__)
    constexpr auto os = "FreeBSD";
#elif defined(__unix__) || defined(__unix)
    constexpr auto os = "Unix";
#else
    constexpr auto os = "Unknown";
#endif

#if defined(__clang__)
    constexpr auto compiler     = "Clang";
    constexpr auto compiler_ver = __clang_major__;
#elif defined(__GNUC__)
    constexpr auto compiler     = "GCC";
    constexpr auto compiler_ver = __GNUC__;
#elif defined(_MSC_VER)
    constexpr auto compiler     = "MSVC";
    constexpr auto compiler_ver = _MSC_VER / 100;
#else
    constexpr auto compiler     = "Unknown";
    constexpr auto compiler_ver = 0;
#endif

    constexpr auto cpp_std = __cplusplus;

    std::print("System Info\n");
    std::print("  OS: {}\n", os);
    std::print("  Compiler: {} {}\n", compiler, compiler_ver);
    std::print("  C++ Standard: {}\n", cpp_std);

#ifdef __cpp_lib_print
    std::print("  std::print: {}\n", __cpp_lib_print);
#endif

    std::print("\nHello, World!\n");

    return EXIT_SUCCESS;
}
