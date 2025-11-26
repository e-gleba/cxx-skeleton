# 🚀 Modern C++ Project Template

[![C++ Standard](https://img.shields.io/badge/C%2B%2B-23%2F26-00599C?style=for-the-badge&logo=cplusplus&logoColor=white&labelColor=1C1C1C)](https://isocpp.org/)
[![CMake](https://img.shields.io/badge/CMake-3.30%2B-064F8C?style=for-the-badge&logo=cmake&logoColor=white&labelColor=1C1C1C)](https://cmake.org)
[![License](https://img.shields.io/badge/License-AGPL--3.0-FF6B6B?style=for-the-badge&logo=gnu&logoColor=white&labelColor=1C1C1C)](https://www.gnu.org/licenses/agpl-3.0.html)

## 🌟 Features

- **🔬 C++23 Ready Presets**: Leverage cutting-edge C++ features
- **🛡️ Code Quality Tools**: Integrated targets for maintaining high standards
- **📦 CPM Package Management**: Simplified dependency handling
- **📄 Doxygen Configuration**: Seamless documentation generation
- **🧪 CTest Integration**: Straightforward testing setup (doctest + androidTest)
- **🐳 Docker Support**: Pre-configured containerization
- **💻 IDE Compatibility**: Works with QtCreator, CLion, Visual Studio, KDevelop
- **🌐 Cross-Platform**: Linux, Windows, Android, macOS support
- **🏗️ CMake-Driven**: Streamlined CI/CD configuration

## 🚧 Prerequisites

- `cmake 3.30.0+`
- `C++ compiler with C++23 support`
- `ninja`
- `(optional) cmake/cfg/*.cmake tools`

## 💾 Installation

### 🍎 macOS

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Dependencies
brew install cmake llvm doxygen
```

### 🪟 Windows

```powershell
# Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Dependencies
choco install cmake llvm visualstudio2019buildtools doxygen
```

### 🐧 Linux

#### Ubuntu/Debian

```bash
sudo apt-get update
sudo apt-get install cmake g++ doxygen llvm clang-tools python-devel
```

#### Fedora

```bash
sudo dnf check-update
sudo dnf install cmake gcc-c++ doxygen llvm python-devel
```

## 🛠️ Build & Deployment

### Build Project

```bash
cmake --preset=gcc .
cd build/release
cmake --build . --config gcc
```

### Run Tests

```bash
cd build/gcc
ctest --output-on-failure
```

### Docker Build

```bash
docker build -t my-image -f docker/<desired_os>.Dockerfile .
```

## 📚 Documentation

```bash
cd build/gcc
cmake --build . --target doxygen

# Browse documentation
cd build/gcc/docs/doxygen/html
python -m http.server 8080
```

## 🚧 Roadmap

- [ ] develop

## 📖 Learning Resources

### Essential Reading

- **[C++ Weekly](https://www.youtube.com/@cppweekly)** by Jason Turner — Weekly doses of modern C++
- **[Performance-Aware Programming](https://www.computerenhance.com/)** by Casey Muratori — Hardware-conscious development
- **[C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/)** by Stroustrup & Sutter — Industry best practices
- **[Effective Modern C++](https://www.oreilly.com/library/view/effective-modern-c/9781491908419/)** by Scott Meyers — Essential patterns

### Technical References

- **[cppreference.com](https://en.cppreference.com/)** — Comprehensive language reference
- **[C++23 Features](https://en.cppreference.com/w/cpp/23)** — Latest standard capabilities
- **[Compiler Explorer](https://godbolt.org/)** — Live assembly output analysis
- **[Quick Bench](https://quick-bench.com/)** — Online micro-benchmarking
- **[cpp insights](https://cppinsights.io/)** — Online insights on how compiler will understand the code

## 🤝 Contributing

Contributions are welcome! Fork the repository and submit a pull request.

## 📄 License

[AGPL-3.0 License](license)

## 🙏 Acknowledgments

Thanks to CMake, CTest, and the open-source community.

---

> _"C++ is a language for people who want both elegance and efficiency."_ — **Bjarne Stroustrup**

Built with 💙 by developers who believe that **performance-aware programming** is not premature optimization — it's responsible engineering.
