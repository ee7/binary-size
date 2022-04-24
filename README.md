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

### Arch Linux

As of 2022-04-24 on amd64 with:
- Nim 1.6.4 (released 2022-02-08)
- gcc 11.2.0
- clang 13.0.1
- musl 1.2.3
- zig 0.9.1

| Binary size | Compilation options |
| ----------: | ------------------- |
|    110.1 kB | (none) |
|     84.2 kB | `-d:release` |
|     87.3 kB | `-d:danger` |
|     53.7 kB | `-d:danger --passC:-flto --passL:-flto` |
|     47.4 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|     22.8 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|     18.7 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |
|     22.2 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size --cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static` |
|     18.1 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size --cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static` |
|      4.8 kB | `-d:danger --mm:arc --opt:size --panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='/foo/zigcc' --clang.linkerexe='/foo/zigcc' --passC:'-flto -target x86_64-linux-musl' --passL:'-flto -target x86_64-linux-musl'` |

### OpenBSD 7.1 (released 2022-04-21)

As of 2022-04-24 on amd64 with:
- Nim 1.6.4 (released 2022-02-08)
- clang 13.0.0

| Binary size | Compilation options |
| ----------: | ------------------- |
|    119.8 kB | (none) |
|     68.3 kB | `-d:release` |
|     63.0 kB | `-d:danger` |
|     26.9 kB | `-d:danger --passC:-flto --passL:-flto` |
|     21.5 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|      7.2 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc` |
|      7.2 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size` |
