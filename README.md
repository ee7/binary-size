# Nim binary size

"Hello, World!" binary size in Nim.

## Instructions

Run

```sh
nim c -r build.nim
```

which compiles the Nim program

```Nim
echo "Hello, World!"
```

with various sets of compilation options.

## Results

| -d:release[^1] | LTO[^2] | strip[^3] | --opt:size[^4]     | statically link      |     Linux |     macOS |   Windows |
| :------------: | :-----: | :-------: | :----------------: | :------------------- | --------: | --------: | --------: |
|                |         |           |                    |                      |  98.2 KiB | 109.4 KiB | 188.7 KiB |
|       ✔️        |         |           |                    |                      |  67.3 KiB |  71.7 KiB | 151.5 KiB |
|       ✔️        |    ✔️    |           |                    |                      |  39.5 KiB |  67.6 KiB | 132.0 KiB |
|       ✔️        |    ✔️    |     ✔️     |                    |                      |  34.5 KiB |  65.1 KiB |  79.5 KiB |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          |                      |  26.5 KiB |  49.1 KiB |  64.0 KiB |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `musl-gcc`[^5]   |  30.0 KiB |           |           |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `musl-clang`[^6] |  30.0 KiB |           |           |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `zig cc`[^7]     |   6.1 KiB |           |           |

[^1]: Perform a release build: `-d:release` (the default is a debug build)
[^2]: Enable Link-Time Optimization: `--passC:-flto --passL:-flto`
[^3]: Remove debug symbols: `--passL:-s`
[^4]: Optimize for reduced binary size: `--opt:size` (the default is `--opt:speed`)
[^5]: Add `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^6]: Add `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^7]: Add `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

### Details

All results from 2023-03-31 on x86_64 with Nim 2.0 nightly release 2023-03-30 (corresponding to a Nim compiler built from commit [nim-lang/Nim@`2e4ba4a`](https://github.com/nim-lang/Nim/commit/2e4ba4ad93c6d9021b6de975cf7ac78e67acba26)).

#### Linux

- Arch Linux
- glibc 2.37
- gcc 12.2.1
- clang 15.0.7
- musl 1.2.3
- zig 0.10.1

#### macOS

- macOS 12
- clang 14.0.0

#### Windows

- Windows Server 2022
- Mingw-w64 11.2.0
