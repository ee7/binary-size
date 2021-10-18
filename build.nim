import std/[os, osproc, strformat]

proc execAndCheck(cmd: string) =
  ## Runs `cmd`, and raises an exception if the exit code is non-zero.
  let (output, exitCode) = execCmdEx(cmd)
  if exitCode != 0:
    stderr.writeLine output
    raise newException(OSError, "Command returned non-zero exit code: " & cmd)

const
  filename = "hello"
  muslGcc = "--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static"
  muslClang = "--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static"
  pathZigcc = currentSourcePath().parentDir() / "zigcc"
  zig =
    "--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler " &
    &"--cc=clang --clang.exe='{pathZigcc}' --clang.linkerexe='{pathZigcc}' " &
    "--passC:'-flto -target x86_64-linux-musl' " &
    "--passL:'-flto -target x86_64-linux-musl'"
  options = [
    "",
    "-d:release",
    "-d:danger",
    "-d:danger --passC:-flto --passL:-flto",
    "-d:danger --passC:-flto --passL:-flto --passL:-s",
    "-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc",
    "-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size",
    &"-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size {muslGcc}",
    &"-d:danger --passC:-flto --passL:-flto --passL:-s --gc:arc --opt:size {muslClang}",
    &"-d:danger --gc:arc --opt:size {zig}",
  ]

proc main =
  for i, opts in options:
    let cmd = fmt"nim c --skipParentCfg --skipProjCfg {opts} {filename}"
    execAndCheck(cmd)

    # strip the zigcc binary, where `--passL:-s` doesn't work.
    if i == options.high:
      execAndCheck(&"strip -s -R .comment {filename}")

    let binarySize = getFileSize(filename) div 1000
    echo &"{binarySize:>3} kB {opts}"
    doAssert execCmdEx(&"./{filename}") == ("Hello, World!\n", 0)

when isMainModule:
  main()
