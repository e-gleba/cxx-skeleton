# modern c++ project template

## features

- **🔬 c++23/26 ready**
- **📦 cpm package management**
- **📄 doxygen/clang_doc**
- **🧪 CTest**: (doctest + androidTest)
- **🐳 docker**
- **🌐 Cross-Platform**: Linux, Windows, Android, macOS support
- **💻 ide compatibility**: Works with QtCreator, CLion, Visual Studio, KDevelop

## prerequisites

- `cmake 3.30.0+`
- `C++ compiler with C++23 support`
- `ninja`
- `(optional) cmake/cfg/*.cmake tools`

## installation

### macos

```bash
# Homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Dependencies
brew install cmake llvm doxygen
```

### windows

```powershell
# Chocolatey
@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"

# Dependencies
choco install cmake llvm visualstudio2019buildtools doxygen
```

### linux

#### debian

```bash
sudo apt-get update
sudo apt-get install cmake g++ doxygen llvm clang-tools python-devel
```

#### fedora

```bash
sudo dnf check-update
sudo dnf install cmake gcc-c++ doxygen llvm python-devel
```

## build & deploy

### build project

```bash
cmake --preset=gcc .
cd build/release
cmake --build . --config gcc
```

### run tests

```bash
cd build/gcc
ctest --output-on-failure
```

### docker build

```bash
docker build -t my-image -f docker/<desired_os>.Dockerfile .
```

## documentation

```bash
cd build/gcc
cmake --build . --target doxygen

# Browse documentation
cd build/gcc/docs/doxygen/html
python -m http.server 8080
```

## learning

### essential

- **[C++ Weekly](https://www.youtube.com/@cppweekly)** by Jason Turner — Weekly doses of modern C++
- **[Performance-Aware Programming](https://www.computerenhance.com/)** by Casey Muratori — Hardware-conscious development
- **[C++ Core Guidelines](https://isocpp.github.io/CppCoreGuidelines/)** by Stroustrup & Sutter — Industry best practices
- **[Effective Modern C++](https://www.oreilly.com/library/view/effective-modern-c/9781491908419/)** by Scott Meyers — Essential patterns

### references

- **[cppreference.com](https://en.cppreference.com/)** — Comprehensive language reference
- **[C++23 Features](https://en.cppreference.com/w/cpp/23)** — Latest standard capabilities
- **[Compiler Explorer](https://godbolt.org/)** — Live assembly output analysis
- **[Quick Bench](https://quick-bench.com/)** — Online micro-benchmarking
- **[cpp insights](https://cppinsights.io/)** — Online insights on how compiler will understand the code
