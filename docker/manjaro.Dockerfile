# syntax=docker/dockerfile:1
FROM manjarolinux/base:latest AS build

LABEL maintainer="e-gleba" \
    description="C/C++ build environment (GCC + Clang, CMake, Ninja) on Manjaro"

WORKDIR /app

# ── System dependencies ──────────────────────────────────────────────
# base-devel provides gcc, make, glibc headers (pthread.h, dlfcn.h)
# SDL3 Wayland deps included to prevent CheckPTHREAD/CheckDLOPEN fatals
RUN --mount=type=cache,target=/var/cache/pacman/pkg \
    pacman -Syu --noconfirm && \
    pacman -S --needed --noconfirm \
    base-devel \
    clang \
    cmake \
    ninja \
    git \
    doxygen \
    wayland \
    libxkbcommon \
    mesa \
    pkgconf \
    && yes | pacman -Scc

COPY . .

# ── Validate presets are readable (fail fast) ────────────────────────
RUN cmake --list-presets 2>&1 | head -20

ENTRYPOINT ["cmake", "--workflow", "--preset=gcc-full"]

