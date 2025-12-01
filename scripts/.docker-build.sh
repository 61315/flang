#!/bin/bash
set -e

echo "=== Installing Ninja 1.13.1 ==="
mkdir -p /ninja-build && cd /ninja-build
wget -q https://github.com/ninja-build/ninja/archive/refs/tags/v1.13.1.tar.gz
tar xzf v1.13.1.tar.gz
cd ninja-1.13.1
cmake -B build -DCMAKE_BUILD_TYPE=Release -DBUILD_TESTING=OFF
cmake --build build -j$(nproc)
cp build/ninja /usr/local/bin/
ninja --version

cd /work

echo ""
echo "=== Copying CMakePresets.json ==="
cp /work/cmake/CMakePresets.json /llvm-project/llvm/

echo ""
echo "=== Configuring CMake ==="
cmake --preset linux-static-x86_64 -S /llvm-project/llvm -B /build \
      -DCMAKE_C_COMPILER_LAUNCHER=sccache \
      -DCMAKE_CXX_COMPILER_LAUNCHER=sccache \
      -DLLVM_PARALLEL_COMPILE_JOBS=15

if [ "false" = "true" ]; then
    echo ""
    echo "Config succeeded! (--config-only, skipping build)"
    exit 0
fi

echo ""
echo "=== Building ==="
ninja -C /build -j15 runtimes

echo ""
echo "=== Installing ==="
ninja -C /build runtimes/install
ninja -C /build tools/flang/tools/install
ninja -C /build tools/llvm-nm/install
ninja -C /build tools/llvm-ar/install

echo ""
echo "=== Testing flang ==="
/work/install/bin/flang --version

echo ""
echo "=== sccache Statistics ==="
sccache --show-stats
