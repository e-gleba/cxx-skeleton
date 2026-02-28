# cxx-skeleton

<p align="center">
  <img src=".github/logo.png" alt="cxx-skeleton logo" width="200"/>
</p>

<p align="center">
  <a href="https://isocpp.org/"><img src="https://img.shields.io/badge/C%2B%2B-23%2F26-00599C?style=for-the-badge&logo=cplusplus&logoColor=white&labelColor=1C1C1C" alt="C++ Standard"/></a>
  <a href="https://cmake.org"><img src="https://img.shields.io/badge/CMake-3.30%2B-064F8C?style=for-the-badge&logo=cmake&logoColor=white&labelColor=1C1C1C" alt="CMake"/></a>
  <a href="license"><img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge&labelColor=1C1C1C" alt="License"/></a>
</p>

Modern C++ project template with batteries included. Built for performance-aware development with minimal dependencies and maximum control.

## Features

- C++23/26 support with compiler presets (clang, gcc, msvc)
- CPM package manager integration
- Cross-platform builds (Linux, Windows, macOS, Android)
- Testing with doctest and CTest
- Code quality tooling (clang-format, clang-tidy, cmake-format)
- Pre-commit hooks for consistent formatting
- Doxygen documentation generation
- Docker configurations for reproducible builds
- IDE support (CLion, Visual Studio, QtCreator, KDevelop)

## Prerequisites

```

cmake 3.30.0+
C++23-capable compiler (clang 16+, gcc 13+, msvc 19.35+)
ninja (recommended)

```

## Quick Start

```bash
cmake --preset=gcc .
cmake --build build/gcc
ctest --test-dir build/gcc --output-on-failure
```

## Installation

### macOS

```bash
brew install cmake llvm doxygen ninja
```

### Windows

```powershell
choco install cmake llvm ninja doxygen visualstudio2022buildtools
```

### Linux

**Ubuntu/Debian:**

```bash
sudo apt install cmake g++ ninja-build doxygen llvm clang-tools
```

**Fedora:**

```bash
sudo dnf install cmake gcc-c++ ninja-build doxygen llvm clang-tools-extra
```

## Build Configuration

Available presets:

- `gcc` — GCC with optimizations
- `clang` — Clang with sanitizers
- `msvc` — MSVC on Windows
- `android` — Android NDK cross-compilation

```bash
cmake --preset=<preset_name> .
cmake --build build/<preset_name> --config Release
```

## Testing

```bash
cd build/<preset_name>
ctest --output-on-failure
```

## Documentation

```bash
cmake --build build/<preset_name> --target doxygen
```

Documentation will be generated in `build/<preset_name>/docs/doxygen/html`.

## Docker

```bash
docker build -t cxx-skeleton -f docker/fedora.Dockerfile .
```

## Code Quality

Format code:

```bash
cmake --build build/<preset_name> --target format
```

Run static analysis:

```bash
cmake --build build/<preset_name> --target tidy
```

## References

### Standards & Documentation

- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/) — Best practices by Stroustrup & Sutter
- [cppreference.com](https://en.cppreference.com/) — Comprehensive language reference
- [C++ Draft Standard](https://eel.is/c++draft) — Latest working draft (HTML)
- [C++ Standards Archive](https://timsong-cpp.github.io/cppwp) — Historical standard versions
- [WG21 Link Shortener](https://wg21.link) — Quick access to proposals and papers
- [C++ Evolution Viewer](https://cppevo.dev) — Feature evolution tracker
- [C++ Standard Search](https://search.cpp-lang.org) — Fast standard text search

### Tools & Analysis

- [Compiler Explorer](https://godbolt.org/) — Live assembly output and optimization inspection
- [C++ Insights](https://cppinsights.io/) — Compiler transformations visualized
- [Quick Bench](https://quick-bench.com/) — Online micro-benchmarking
- [Include What You Use](https://include-what-you-use.org/) — Header dependency analysis
- [Perfetto UI](https://ui.perfetto.dev) — Chrome trace viewer for build profiling

### Performance

- [Performance-Aware Programming](https://www.computerenhance.com/) — Casey Muratori's course
- [Agner Fog's Optimization Manuals](https://agner.org/optimize) — Low-level optimization guides
- [uops.info](https://uops.info/) — CPU instruction latencies and throughput

### Learning Resources

- [C++ Weekly](https://youtube.com/@cppweekly) — Jason Turner's weekly episodes
- [C++ Stories](https://www.cppstories.com) — Bartek Filipek's articles
- [CppCon Talks](https://youtube.com/@CppCon) — Conference presentations
- [Handmade Hero](https://handmadehero.org) — Casey Muratori's game from scratch

### Compiler Documentation

- [Clang Documentation](https://clang.llvm.org/docs) — LLVM/Clang compiler reference
- [GCC Online Docs](https://gcc.gnu.org/onlinedocs) — GNU compiler collection
- [MSVC C++ Docs](https://learn.microsoft.com/cpp) — Microsoft Visual C++

### Tooling

- [Compiler Feature Support](https://cppstat.dev) — C++ feature implementation status
- [End of Life Dates](https://endoflife.date) — Compiler and library support lifecycles

## License

MIT — See [license](license) for details.
