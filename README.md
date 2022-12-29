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

- glibc 2.35
- gcc 11.2.0
- clang 13.0.1
- musl 1.2.3
- zig 0.9.1

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking             |
| ----------: | ------------ | :--: | :---: | ---- | ----- | ---------- | ------------------- |
|   107.5 KiB | debug        |      |       | refc | speed | gcc        | dynamic             |
|    82.2 KiB | `-d:release` |      |       | refc | speed | gcc        | dynamic             |
|    85.2 KiB | `-d:danger`  |      |       | refc | speed | gcc        | dynamic             |
|    52.4 KiB | `-d:danger`  |  ✔️   |       | refc | speed | gcc        | dynamic             |
|    46.3 KiB | `-d:danger`  |  ✔️   |  ✔️    | refc | speed | gcc        | dynamic             |
|    22.2 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | speed | gcc        | dynamic             |
|    18.2 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | gcc        | dynamic             |
|    21.7 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | gcc        | static (musl-gcc)   |
|    17.7 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | clang      | static (musl-clang) |
|     4.7 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | clang      | static (zig cc)[^1] |

[^1]: Extra options: `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler`

### macOS 11

Details:

- clang 13.0.0

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking |
| ----------: | ------------ | :--: | :---: | ---- | ----- | ---------- | ------- |
|   126.2 KiB | debug        |      |       | refc | speed | clang      | dynamic |
|    89.5 KiB | `-d:release` |      |       | refc | speed | clang      | dynamic |
|    72.5 KiB | `-d:danger`  |      |       | refc | speed | clang      | dynamic |
|    51.3 KiB | `-d:danger`  |  ✔️   |       | refc | speed | clang      | dynamic |
|    48.9 KiB | `-d:danger`  |  ✔️   |  ✔️    | refc | speed | clang      | dynamic |
|    48.6 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | speed | clang      | dynamic |
|    48.6 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | clang      | dynamic |

### OpenBSD 7.1 (released 2022-04-21)

Details:

- clang 13.0.0

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking |
| ----------: | ------------ | :--: | :---: | ---- | ----- | ---------- | ------- |
|   117.0 KiB | debug        |      |       | refc | speed | clang      | dynamic |
|    66.7 KiB | `-d:release` |      |       | refc | speed | clang      | dynamic |
|    61.5 KiB | `-d:danger`  |      |       | refc | speed | clang      | dynamic |
|    26.3 KiB | `-d:danger`  |  ✔️   |       | refc | speed | clang      | dynamic |
|    21.0 KiB | `-d:danger`  |  ✔️   |  ✔️    | refc | speed | clang      | dynamic |
|     7.1 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | speed | clang      | dynamic |
|     7.1 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | clang      | dynamic |

### Windows Server 2022

Details:

- Mingw-w64 8.1.0

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking |
| ----------: | ------------ | :--: | :---: | ---- | ----- | ---------- | ------- |
|   146.1 KiB | debug        |      |       | refc | speed | Mingw-w64  | dynamic |
|   114.0 KiB | `-d:release` |      |       | refc | speed | Mingw-w64  | dynamic |
|   108.3 KiB | `-d:danger`  |      |       | refc | speed | Mingw-w64  | dynamic |
|    97.1 KiB | `-d:danger`  |  ✔️   |       | refc | speed | Mingw-w64  | dynamic |
|    47.5 KiB | `-d:danger`  |  ✔️   |  ✔️    | refc | speed | Mingw-w64  | dynamic |
|    33.0 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | speed | Mingw-w64  | dynamic |
|    25.0 KiB | `-d:danger`  |  ✔️   |  ✔️    | arc  | size  | Mingw-w64  | dynamic |
