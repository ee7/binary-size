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

As of 2021-10-19 on amd64 with:
- Nim 1.6.0 (released 2021-10-19)
- gcc 11.1.0
- clang 12.0.1
- musl 1.2.2
- zig 0.8.1

| Binary size | Compilation options |
| ----------: | ------------------- |
|      110 kB | (none) |
|       84 kB | `-d:release` |
|       87 kB | `-d:danger` |
|       53 kB | `-d:danger --passC:-flto --passL:-flto` |
|       47 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|       22 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc` |
|       18 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size` |
|       22 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size --cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static` |
|       18 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size --cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static ` |
|      4.8 kB | `-d:danger --gc:arc --opt:size --panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='/foo/zigcc' --clang.linkerexe='/foo/zigcc' --passC:'-flto -target x86_64-linux-musl' --passL:'-flto -target x86_64-linux-musl'` |

### OpenBSD 7.0 (released 2021-10-14)

As of 2021-10-19 on amd64 with:
- Nim 1.6.0 (released 2021-10-19)
- clang 11.1.0

| Binary size | Compilation options |
| ----------: | ------------------- |
|      119 kB | (none) |
|       70 kB | `-d:release` |
|       63 kB | `-d:danger` |
|       27 kB | `-d:danger --passC:-flto --passL:-flto` |
|       21 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s` |
|      7.2 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc` |
|      7.2 kB | `-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size` |
