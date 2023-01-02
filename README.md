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

| Compilation options                                                         |    Linux |     macOS |   OpenBSD |   Windows |
| --------------------------------------------------------------------------- | -------: | --------: | --------: | --------: |
| `--mm:orc`                                                                  | 98.3 KiB | 108.2 KiB | 100.0 KiB | 168.2 KiB |
| `--mm:orc -d:release`                                                       | 67.5 KiB |  70.6 KiB |  53.3 KiB | 141.3 KiB |
| `--mm:orc -d:release --passC:-flto --passL:-flto`                           | 43.7 KiB |  67.0 KiB |  32.3 KiB | 121.6 KiB |
| `--mm:orc -d:release --passC:-flto --passL:-flto --passL:-s`                | 34.2 KiB |  65.0 KiB |  27.3 KiB |  71.0 KiB |
| `--mm:orc -d:release --passC:-flto --passL:-flto --passL:-s --opt:size`[^1] | 26.2 KiB |  49.1 KiB |  23.6 KiB |  61.5 KiB |
| and static link via `musl-gcc`[^2]                                          | 25.7 KiB |           |           |           |
| and static link via `musl-clang`[^3]                                        | 29.8 KiB |           |           |           |
| and static link via `zig cc`[^4]                                            |  6.5 KiB |           |           |           |

[^1]: The "base options" for the below rows
[^2]: The "base options", plus `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^3]: The "base options", plus `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^4]: The "base options", plus `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

### Details

All results from 2023-01-02 on x86_64 with Nim 1.6.10 (released 2022-11-23).

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
