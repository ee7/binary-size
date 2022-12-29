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

| Compilation options                                                        |     Linux |      macOS |   OpenBSD |   Windows |
| -------------------------------------------------------------------------- | --------: | ---------: | --------: | --------: |
| (none)                                                                     | 107.5 KiB |  126.2 KiB | 117.0 KiB | 146.1 KiB |
| `-d:release`                                                               |  82.2 KiB |   89.5 KiB |  66.7 KiB | 114.0 KiB |
| `-d:danger`                                                                |  85.2 KiB |   72.5 KiB |  61.5 KiB | 108.3 KiB |
| `-d:danger --passC:-flto --passL:-flto`                                    |  52.4 KiB |   51.3 KiB |  26.3 KiB |  97.1 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s`                         |  46.3 KiB |   48.9 KiB |  21.0 KiB |  47.5 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc`                |  22.2 KiB |   48.6 KiB |   7.1 KiB |  33.0 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size`[^1] |  18.2 KiB |   48.6 KiB |   7.1 KiB |  25.0 KiB |
| and static link via `musl-gcc`[^2]                                         |  21.7 KiB |            |           |           |
| and static link via `musl-clang`[^3]                                       |  17.7 KiB |            |           |           |
| and static link via `zig cc`[^4]                                           |   4.7 KiB |            |           |           |

[^1]: The "base options" for the below rows
[^2]: The "base options", plus `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^3]: The "base options", plus `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^4]: The "base options", plus `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

### Details

All results from 2022-04-24 on x86_64 with Nim 1.6.4 (released 2022-02-08).

#### Linux

- Arch Linux
- glibc 2.35
- gcc 11.2.0
- clang 13.0.1
- musl 1.2.3
- zig 0.9.1

#### macOS

- macOS 11
- clang 13.0.0

#### OpenBSD

- OpenBSD 7.1
- clang 13.0.0

#### Windows

- Windows Server 2022
- Mingw-w64 8.1.0
