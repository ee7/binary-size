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
|                |         |           |                    |                      | 103.1 KiB | 109.3 KiB | 186.9 KiB |
|       ✔️        |         |           |                    |                      |  72.3 KiB |  71.6 KiB | 149.7 KiB |
|       ✔️        |    ✔️    |           |                    |                      |  44.6 KiB |  67.6 KiB | 131.2 KiB |
|       ✔️        |    ✔️    |     ✔️     |                    |                      |  34.5 KiB |  65.1 KiB |  79.0 KiB |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          |                      |  26.5 KiB |  65.1 KiB |  64.0 KiB |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `musl-gcc`[^5]   |  29.9 KiB |           |           |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `musl-clang`[^6] |  30.0 KiB |           |           |
|       ✔️        |    ✔️    |     ✔️     |         ✔️          | via `zig cc`[^7]     |   6.5 KiB |           |           |

[^1]: Perform a release build: `-d:release` (the default is a debug build)
[^2]: Enable Link-Time Optimization: `--passC:-flto --passL:-flto`
[^3]: Remove debug symbols: `--passL:-s`
[^4]: Optimize for reduced binary size: `--opt:size` (the default is `--opt:speed`)
[^5]: Add `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^6]: Add `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^7]: Add `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

### Details

All results from 2023-01-02 on x86_64 with Nim 2.0 nightly release 2022-12-29 (corresponding to a Nim compiler built from commit [nim-lang/Nim@`7f6681b`](https://github.com/nim-lang/Nim/commit/7f6681b4c4ccc0dc43fd256280be4c3ad3c773e5)).

#### Linux

- Arch Linux
- glibc 2.36
- gcc 12.2.0
- clang 14.0.6
- musl 1.2.3
- zig 0.10.0

#### macOS

- macOS 12
- clang 14.0.0

#### Windows

- Windows Server 2022
- Mingw-w64 11.2.0
