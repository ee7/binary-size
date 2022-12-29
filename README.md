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

All results from 2022-04-24 on x86_64 with Nim 1.6.4 (released 2022-02-08).

### Arch Linux

Details:

- gcc 11.2.0
- clang 13.0.1
- musl 1.2.3
- zig 0.9.1

| Binary size | Compilation options |
| ----------: | ------------------- |
|   107.5 KiB | (none) |
|    82.2 KiB | `-d:release` |
|    85.2 KiB | `-d:danger` |
|    52.4 KiB | `-d:danger --passC:-flto --passL:-flto` |
|    46.3 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|    22.2 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|    18.2 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |
|    21.7 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size --cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static` |
|    17.7 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size --cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static` |
|     4.7 KiB | `-d:danger --mm:arc --opt:size --panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='/foo/zigcc' --clang.linkerexe='/foo/zigcc' --passC:'-flto -target x86_64-linux-musl' --passL:'-flto -target x86_64-linux-musl'` |

### macOS 11

Details:

- clang 13.0.0

| Binary size | Compilation options |
| ----------: | ------------------- |
|   126.2 KiB | (none) |
|    89.5 KiB | `-d:release` |
|    72.5 KiB | `-d:danger` |
|    51.3 KiB | `-d:danger --passC:-flto --passL:-flto` |
|    48.9 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|    48.6 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|    48.6 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |

### OpenBSD 7.1 (released 2022-04-21)

Details:

- clang 13.0.0

| Binary size | Compilation options |
| ----------: | ------------------- |
|   117.0 KiB | (none) |
|    66.7 KiB | `-d:release` |
|    61.5 KiB | `-d:danger` |
|    26.3 KiB | `-d:danger --passC:-flto --passL:-flto` |
|    21.0 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|     7.1 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|     7.1 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |

### Windows Server 2022

Details:

- Mingw-w64 8.1.0

| Binary size | Compilation options |
| ----------: | ------------------- |
|   146.1 KiB | (none) |
|   114.0 KiB | `-d:release` |
|   108.3 KiB | `-d:danger` |
|    97.1 KiB | `-d:danger --passC:-flto --passL:-flto` |
|    47.5 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|    33.0 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|    25.0 KiB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |
