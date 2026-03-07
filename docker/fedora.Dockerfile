# syntax=docker/dockerfile:1
FROM fedora:latest AS build

LABEL maintainer="e-gleba" \
    description="C/C++ build environment (GCC + Clang, CMake, Ninja)"

WORKDIR /app

# ── System dependencies ──────────────────────────────────────────────
# Single layer: toolchains + SDL3 Wayland build deps + cleanup
# Ref: https://wiki.libsdl.org/SDL3/README/linux (Fedora section)
RUN --mount=type=cache,target=/var/cache/dnf \
    dnf -y upgrade --refresh && \
    dnf -y install \
    # toolchains
    clang \
    clang-tools-extra \
    gcc-c++ \
    # build system
    cmake \
    ninja-build \
    git \
    # docs
    doxygen \
    # SDL3 Wayland deps (pthreads/dlopen come from glibc-devel via gcc-c++)
    wayland-devel \
    libxkbcommon-devel \
    mesa-libEGL-devel \
    # pkg-config for SDL3's CheckALSA/CheckWayland/etc.
    pkgconf-pkg-config \
    && dnf clean all

COPY . .

RUN cmake --list-presets 2>&1 | head -20

ENTRYPOINT ["cmake", "--workflow", "--preset=gcc-full"]

