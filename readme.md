# cmake_template

<p align="center">
  <img src=".github/logo.png" alt="cmake_template logo" width="200"/>
</p>

<p align="center">
  <a href="https://github.com/e-gleba/cmake_template/actions/workflows/cmake_multi_platform.yml"><img src="https://img.shields.io/github/actions/workflow/status/e-gleba/cmake_template/cmake_multi_platform.yml?branch=main&style=for-the-badge&labelColor=1C1C1C&logo=github&label=CI" alt="CI"/></a>
  <a href="https://isocpp.org/"><img src="https://img.shields.io/badge/C%2B%2B-23%2F26-00599C?style=for-the-badge&logo=cplusplus&logoColor=white&labelColor=1C1C1C" alt="C++ Standard"/></a>
  <a href="https://cmake.org"><img src="https://img.shields.io/badge/CMake-3.31%2B-064F8C?style=for-the-badge&logo=cmake&logoColor=white&labelColor=1C1C1C" alt="CMake"/></a>
  <a href="https://github.com/e-gleba/cmake_template/blob/main/license.md"><img src="https://img.shields.io/badge/License-MIT-blue?style=for-the-badge&labelColor=1C1C1C" alt="License"/></a>
  <a href="docs/contributing.md"><img src="https://img.shields.io/badge/Contributing-Guide-4CAF50?style=for-the-badge&labelColor=1C1C1C" alt="Contributing Guide"/></a>
</p>

**Production-ready, battle-tested C++ CMake template** featuring first-class support for **Android NDK**, **Linux-to-Windows cross-compilation** via llvm-mingw, **Docker**-based reproducibility, **CPack** packaging, and **one-command CI pipelines** via CMake workflows.

Targets modern C++23/26. Uses Ninja Multi-Config, CPM for dependencies, comprehensive code-quality tooling (clang-format, clang-tidy, pre-commit), and professional documentation. From `git clone` to packaged artifact in minutes — zero friction.

## Quick Start

```bash
# Native development (GCC)
cmake --preset=gcc
cmake --build --preset=gcc-release
ctest --preset=gcc-release

# Full pipeline (configure, build, test, package)
cmake --workflow --preset=gcc-full
```

See [docs/presets.md](docs/presets.md) (now the consolidated professional guide covering presets **and** platforms) for Android, Windows cross, and more.

## Why This Template?

Most starters provide basic builds. This one is engineered for **real-world cross-platform shipping**:

- **Android NDK out-of-the-box** — 4 ABIs (arm64, arm32, x64, x86), API 24, with workflow support.
- **Seamless Linux → Windows cross-compilation** — llvm-mingw presets for x86_64, i686, aarch64.
- **Reproducible environments** via Dockerfiles and pinned toolchains.
- **CMake Workflows** for reliable CI/CD without complex YAML matrices initially.
- **Modern tooling** — C++23/26 ready, excellent static analysis, formatting, CPack for distribution.
- **Professional documentation** — upgraded CONTRIBUTING.md, consolidated presets/platforms guide, architecture overview.

The template deliberately stays generic (no Qt, JUCE, or domain-specific scaffolding) so it serves as a solid foundation for any C++ project while excelling at build engineering.

## Supported Platforms & Presets

See the comprehensive **[Presets, Platforms & Cross-Compilation Guide](docs/presets.md)**. It has been significantly upgraded with:

- Merged content from the former `platforms.md`
- Professional tables, philosophy, troubleshooting, and extension guides
- Detailed roadmap for **macOS and iOS support**

**macOS / iOS Planning (High Priority)**

We are actively planning first-class native macOS and iOS support using CMake's `Xcode` generator. See open issue [#20](https://github.com/e-gleba/cmake_template/issues/20) for the full specification, including:

- `macos-xcode` and universal binary presets
- iOS device and simulator presets (`CMAKE_SYSTEM_NAME=iOS`)
- Proper code signing, entitlements, and deployment target handling
- GitHub `macos-*` runner integration
- Documentation for Xcode project generation, Instruments, and App Store workflows

This will make the template one of the most complete cross-platform CMake starters available. Contributions toward this issue are welcome (labeled `help wanted`).

## Comparison with Other Templates

| Feature | cmake_template | cpp-best-practices/cmake_template | Other Common Starters |
|---------|----------------|-----------------------------------|-----------------------|
| C++ Standard | **23/26** | 17/20 | Varies (often older) |
| CMake Presets | **10+ with full workflows** | Basic | Usually minimal |
| Android NDK (multiple ABIs) | ✅ Full workflows | ❌ | Rare |
| Linux → Windows Cross (llvm-mingw) | ✅ | ❌ | Rare |
| Docker Reproducibility + CI | ✅ | Partial | Varies |
| CPack Packaging | ✅ Multiple formats | ❌ | Rare |
| Professional Docs & Contributing Guide | **Upgraded top-tier** | Good | Varies |
| macOS/iOS Xcode Support | **Planned (#20)** | Limited | Specialized templates only |
| Sanitizers, WASM, vcpkg, Steam | **Roadmap (see issues)** | Some included | Varies |

This template stands out for its focus on **cross-compilation engineering**, packaging, and production reproducibility while maintaining simplicity.

## Roadmap

- **High priority**: macOS/iOS with Xcode generator ([#20](https://github.com/e-gleba/cmake_template/issues/20))
- Sanitizers (ASan/UBSan/TSan) integration
- Emscripten/WASM preset
- vcpkg alongside CPM
- Prebuilt/air-gapped dependency support
- Steam Runtime / Steam Deck verification
- Enhanced CI with CodeQL, coverage, more Docker variants

Contributions accelerating any of these are highly valued.

## Consulting Services

Need expert help with **CMake architecture**, **cross-compilation pipelines**, **modern C++ build systems**, **CI/CD optimization**, or **CPack packaging**?

- 🌐 [e-gleba.github.io](https://e-gleba.github.io) — portfolio, blog, contact
- 📧 i@egleba.ru (fastest)
- Open to freelance/contract work and team workshops

This repository itself demonstrates the quality of deliverables you can expect.

## More Details

- [Presets, Platforms & Cross-Compilation (consolidated)](docs/presets.md)
- [Architecture & Project Structure](docs/architecture.md)
- [Docker Guide](docs/docker.md)
- [References](docs/references.md)
- [Contributing (Professional Guide)](docs/contributing.md)

---

**Star the repo if you find it useful.** Feedback, issues, and PRs make it better for everyone.

*Made with focus on simplicity, professionalism, and real-world usability.*
