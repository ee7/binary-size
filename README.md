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

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking             |
| ----------: | ------------ | ---- | ----- | ---- | ----- | ---------- | ------------------- |
|   107.5 KiB | debug        | no   | no    | refc | speed | gcc        | dynamic             |
|    82.2 KiB | `-d:release` | no   | no    | refc | speed | gcc        | dynamic             |
|    85.2 KiB | `-d:danger`  | no   | no    | refc | speed | gcc        | dynamic             |
|    52.4 KiB | `-d:danger`  | yes  | no    | refc | speed | gcc        | dynamic             |
|    46.3 KiB | `-d:danger`  | yes  | yes   | refc | speed | gcc        | dynamic             |
|    22.2 KiB | `-d:danger`  | yes  | yes   | arc  | speed | gcc        | dynamic             |
|    18.2 KiB | `-d:danger`  | yes  | yes   | arc  | size  | gcc        | dynamic             |
|    21.7 KiB | `-d:danger`  | yes  | yes   | arc  | size  | gcc        | static (musl-gcc)   |
|    17.7 KiB | `-d:danger`  | yes  | yes   | arc  | size  | clang      | static (musl-clang) |
|     4.7 KiB | `-d:danger`  | yes  | yes   | arc  | size  | clang      | static (zig cc) [1] |

[1] `--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler --cc=clang --clang.exe='/foo/zigcc' --clang.linkerexe='/foo/zigcc' --passC:'-flto -target x86_64-linux-musl' --passL:'-flto -target x86_64-linux-musl'`

### OpenBSD 7.1 (released 2022-04-21)

As of 2022-04-24 on amd64 with:
- Nim 1.6.4 (released 2022-02-08)
- clang 13.0.0

| Binary size | Build kind   | flto | strip | mm   | opt   | C compiler | linking |
| ----------: | ------------ | ---- | ----- | ---- | ----- | ---------- | ------- |
|   117.0 KiB | debug        | no   | no    | refc | speed | clang      | dynamic |
|    66.7 KiB | `-d:release` | no   | no    | refc | speed | clang      | dynamic |
|    61.5 KiB | `-d:danger`  | no   | no    | refc | speed | clang      | dynamic |
|    26.3 KiB | `-d:danger`  | yes  | no    | refc | speed | clang      | dynamic |
|    21.0 KiB | `-d:danger`  | yes  | yes   | refc | speed | clang      | dynamic |
|     7.1 KiB | `-d:danger`  | yes  | yes   | arc  | speed | clang      | dynamic |
|     7.1 KiB | `-d:danger`  | yes  | yes   | arc  | size  | clang      | dynamic |
