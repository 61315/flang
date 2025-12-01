FROM alpine:latest

RUN apk add --no-cache \
    build-base \
    clang \
    # clang-dev \
    cmake \
    # ninja \
    python3 \
    git \
    mold \
    # llvm \
    # llvm-dev \
    # llvm-static \
    # gfortran \
    bash \
    curl \
    tar \
    xz \
    unzip \
    linux-headers

# alpine default is 1.9, we need post 1.9
# ARG NINJA_VERSION=1.13.1
# RUN cd /tmp && \
#     wget -q https://github.com/ninja-build/ninja/archive/refs/tags/v${NINJA_VERSION}.tar.gz && \
#     tar xzf v${NINJA_VERSION}.tar.gz && \
#     cd ninja-${NINJA_VERSION} && \
#     cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF && \
#     cmake --build build && \
#     cp build/ninja /usr/local/bin/ && \
#     cd / && \
#     rm -rf /tmp/ninja-${NINJA_VERSION} /tmp/v${NINJA_VERSION}.tar.gz && \
#     ninja --version

# sccache
ARG SCCACHE_VERSION=v0.12.0
RUN ARCH=$(uname -m) && \
    if [ "$ARCH" = "x86_64" ]; then SCCACHE_ARCH="x86_64"; \
    elif [ "$ARCH" = "aarch64" ]; then SCCACHE_ARCH="aarch64"; \
    else echo "Unsupported architecture: $ARCH" && exit 1; fi && \
    curl -L "https://github.com/mozilla/sccache/releases/download/${SCCACHE_VERSION}/sccache-${SCCACHE_VERSION}-${ARCH}-unknown-linux-musl.tar.gz" \
    -o sccache.tar.gz && \
    tar xzf sccache.tar.gz && \
    mv sccache-${SCCACHE_VERSION}-${ARCH}-unknown-linux-musl/sccache /usr/local/bin/ && \
    chmod +x /usr/local/bin/sccache && \
    rm -rf sccache.tar.gz sccache-${SCCACHE_VERSION}-${ARCH}-unknown-linux-musl

WORKDIR /work

# env vars
ENV CC=clang
ENV CXX=clang++
# ENV FC=gfortran
# ENV SCCACHE_DIR=/cache/sccache
ENV SCCACHE_CACHE_SIZE="10G"

CMD ["/bin/bash"]
