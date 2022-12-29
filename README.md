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
| (none)                                                                     | 112.5 KiB |  126.3 KiB | 117.5 KiB | 180.9 KiB |
| `-d:release`                                                               |  95.1 KiB |   89.6 KiB |  68.7 KiB | 161.0 KiB |
| `-d:danger`                                                                |  89.8 KiB |   72.6 KiB |  62.8 KiB | 162.5 KiB |
| `-d:danger --passC:-flto --passL:-flto`                                    |  60.9 KiB |   51.3 KiB |  26.7 KiB | 134.2 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s`                         |  50.2 KiB |   48.9 KiB |  21.3 KiB |  81.5 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc`                |  22.1 KiB |   48.6 KiB |   6.9 KiB |  59.5 KiB |
| `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size`[^1] |  18.2 KiB |   48.6 KiB |   6.9 KiB |  55.5 KiB |
| and static link via `musl-gcc`[^2]                                         |  21.7 KiB |            |           |           |
| and static link via `musl-clang`[^3]                                       |  17.8 KiB |            |           |           |
| and static link via `zig cc`[^4]                                           |   6.3 KiB |            |           |           |

[^1]: The "base options" for the below rows
[^2]: The "base options", plus `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^3]: The "base options", plus `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^4]: The "base options", plus `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

### Details

All results from 2022-12-29 on x86_64 with Nim 1.6.10 (released 2022-11-23).

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

#### OpenBSD

- OpenBSD 7.2
- clang 13.0.0

#### Windows

- Windows Server 2022
- Mingw-w64 11.2.0
