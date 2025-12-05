# flang-releases

[Flang](https://flang.llvm.org/) (LLVM Fortran compiler) binaries with **wasm32 cross-compilation** support.

## Platforms

| Target                    | Host           |
| ------------------------- | -------------- |
| x86_64-unknown-linux-gnu  | Linux x86_64   |
| aarch64-unknown-linux-gnu | Linux ARM64    |
| x86_64-apple-darwin       | macOS x86_64   |
| arm64-apple-darwin        | macOS ARM64    |
| x86_64-pc-windows-msvc    | Windows x86_64 |

Linux builds are compiled on Alpine (musl libc), producing portable binaries that work on any Linux distribution regardless of glibc version.

Each release includes `libflang_rt.runtime.wasm32.a` for cross-compiling Fortran to WebAssembly.

## Usage

Download from [Releases](https://github.com/miinso/flang-releases/releases) and extract.

```bash
# Native compilation
flang-new -o hello hello.f90

# Cross-compile to wasm32 (requires Emscripten)
flang-new -c --target=wasm32-unknown-emscripten -o hello.o hello.f90
emcc hello.o -L$FLANG/lib/clang/21/lib/wasm32-unknown-emscripten -lflang_rt.runtime.wasm32 -o hello.js
```

## CMake

```cmake
set(CMAKE_Fortran_COMPILER /path/to/flang-new)
```

Or via command line:

```bash
cmake -DCMAKE_Fortran_COMPILER=/path/to/flang-new ..
```

## Make

```makefile
FC = /path/to/flang-new
FFLAGS = -O2

%.o: %.f90
	$(FC) $(FFLAGS) -c $< -o $@
```

## Bazel

Use with [rules_fortran](https://github.com/miinso/rules_fortran):

```starlark
load("@rules_fortran//fortran:repositories.bzl", "flang_register_toolchains")

flang_register_toolchains()
```

## Why

Fortran remains widely used in numerical computing, scientific simulation, and optimization libraries. This project enables running such code in browsers and other WebAssembly runtimes—useful for interactive demos, client-side computation, or porting legacy numerical code to the web.

## Further Reading

- [Fortran in the Browser](https://chrz.de/2020/04/21/fortran-in-the-browser/) (2020)
- [Compile FORTRAN to WebAssembly and Solve Electromagnetic Fields in Web Browsers](https://niconiconi.neocities.org/tech-notes/fortran-in-webassembly-and-field-solver/) (2023)
- [Fortran on WebAssembly](https://gws.phd/posts/fortran_wasm/) (2024)
- [LLVM Fortran Levels Up: Goodbye flang-new, Hello flang!](https://blog.llvm.org/posts/2025-03-11-flang-new/) (2025)
- [math/openblas: switch to flang](https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=228011) (2025)

## Build

See [`.github/workflows/`](.github/workflows/) for build scripts.
