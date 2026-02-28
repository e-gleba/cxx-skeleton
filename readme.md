# cxx-skeleton

<p align="center">
  <img src=".github/logo.png" alt="cxx-skeleton logo" width="200"/>
</p>

<p align="center">
  <a href="https://isocpp.org/"><img src="https://img.shields.io/badge/C%2B%2B-23%2F26-00599C?style=for-the-badge&logo=cplusplus&logoColor=white&labelColor=1C1C1C" alt="C++ Standard"/></a>
  <a href="https://cmake.org"><img src="https://img.shields.io/badge/CMake-3.30%2B-064F8C?style=for-the-badge&logo=cmake&logoColor=white&labelColor=1C1C1C" alt="CMake"/></a>
  <a href="LICENSE"><img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge&labelColor=1C1C1C" alt="License"/></a>
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

- [C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/) — Best practices
- [cppreference.com](https://en.cppreference.com/) — Language reference
- [Compiler Explorer](https://godbolt.org/) — Assembly inspection
- [Performance-Aware Programming](https://www.computerenhance.com/) — Casey Muratori's course

## License

MIT — See [license](license) for details.
