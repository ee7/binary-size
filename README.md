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

| Compilation options                                                |     Linux |     macOS |   OpenBSD |   Windows |
| ------------------------------------------------------------------ | --------: | --------: | --------: | --------: |
| (none)                                                             | 103.1 KiB | 109.3 KiB | 108.8 KiB | 186.9 KiB |
| `-d:release`                                                       |  72.3 KiB |  71.6 KiB |  54.7 KiB | 149.7 KiB |
| `-d:release --passC:-flto --passL:-flto`                           |  44.6 KiB |  67.6 KiB |  35.0 KiB | 131.2 KiB |
| `-d:release --passC:-flto --passL:-flto --passL:-s`                |  34.5 KiB |  65.1 KiB |  29.3 KiB |  79.0 KiB |
| `-d:release --passC:-flto --passL:-flto --passL:-s --opt:size`[^1] |  26.5 KiB |  65.1 KiB |  25.6 KiB |  64.0 KiB |
| and static link via `musl-gcc`[^2]                                 |  29.9 KiB |           |           |           |
| and static link via `musl-clang`[^3]                               |  30.0 KiB |           |           |           |
| and static link via `zig cc`[^4]                                   |   6.5 KiB |           |           |           |

[^1]: The "base options" for the below rows
[^2]: The "base options", plus `--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static`
[^3]: The "base options", plus `--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static`
[^4]: The "base options", plus `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='zigcc' --clang.linkerexe='zigcc' --passC:'-target x86_64-linux-musl' --passL:'-target x86_64-linux-musl'`

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

#### OpenBSD

- OpenBSD 7.2
- clang 13.0.0

#### Windows

- Windows Server 2022
- Mingw-w64 11.2.0
