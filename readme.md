# cmake_template

<p align="center">
  <img src=".github/logo.png" alt="cxx-skeleton logo" width="200"/>
</p>

<p align="center">
  <a href="https://github.com/e-gleba/cmake_template/actions/workflows/cmake_multi_platform.yml"><img src="https://img.shields.io/github/actions/workflow/status/e-gleba/cmake_template/cmake_multi_platform.yml?branch=main&style=for-the-badge&labelColor=1C1C1C&logo=github&label=CI" alt="CI"/></a>
  <a href="https://isocpp.org/"><img src="https://img.shields.io/badge/C%2B%2B-23%2F26-00599C?style=for-the-badge&logo=cplusplus&logoColor=white&labelColor=1C1C1C" alt="C++ Standard"/></a>
  <a href="https://cmake.org"><img src="https://img.shields.io/badge/CMake-3.31%2B-064F8C?style=for-the-badge&logo=cmake&logoColor=white&labelColor=1C1C1C" alt="CMake"/></a>
  <a href="license.md"><img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge&labelColor=1C1C1C" alt="License"/></a>
</p>

Production-ready C++ template with **Android NDK**, **cross-compilation to Windows**, **Docker**, **CPack**, and **one-command CI pipelines**. Targets C++23/26. Ninja Multi-Config, CPM, code-quality tooling — zero friction from clone to package.

## Quick Start

```bash
cmake --preset=gcc
cmake --build --preset=gcc-release
ctest --preset=gcc-release
```
## Documentation

- [Docker Guide](docs/docker.md)
- [Presets](docs/presets.md)
- [Platforms](docs/platforms.md)
- [References](docs/references.md)