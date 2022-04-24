import std/[os, osproc, strformat, strutils]

proc execAndCheck(cmd: string) =
  ## Runs `cmd`, and raises an exception if the exit code is non-zero.
  let (output, exitCode) = execCmdEx(cmd)
  if exitCode != 0:
    stderr.writeLine output
    raise newException(OSError, "Command returned non-zero exit code: " & cmd)

when defined(linux):
  proc warn(msg: string) =
    stderr.write "Warning: "
    stderr.writeLine msg

proc getCompilationOptions: seq[string] =
  result = @[
    "",
    "-d:release",
    "-d:danger",
    "-d:danger --passC:-flto --passL:-flto",
    "-d:danger --passC:-flto --passL:-flto --passL:-s",
    "-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc",
    "-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size",
  ]

  when defined(linux):
    if findExe("musl-gcc").len > 0:
      const muslGcc =
        "--cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static"
      result.add &"-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size {muslGcc}"
    else:
      warn("musl-gcc not found")

    if findExe("musl-clang").len > 0:
      const muslClang =
        "--cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static"
      result.add &"-d:danger --passC:-flto --passL:-flto --passL:-s --mm:arc --opt:size {muslClang}"
    else:
      warn("musl-clang not found")

    if findExe("zig").len > 0:
      const pathZigcc = currentSourcePath().parentDir() / "zigcc"
      const zig =
        "--panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler " &
        &"--cc=clang --clang.exe='{pathZigcc}' --clang.linkerexe='{pathZigcc}' " &
        "--passC:'-flto -target x86_64-linux-musl' " &
        "--passL:'-flto -target x86_64-linux-musl'"
      result.add &"-d:danger --mm:arc --opt:size {zig}"
    else:
      warn("zig not found")

proc main =
  const filename = "hello"
  const binaryPath = when defined(windows): &"{filename}.exe" else: filename
  let options = getCompilationOptions()
  for opts in options:
    let cmd = fmt"nim c --skipParentCfg --skipProjCfg {opts} {filename}"
    execAndCheck(cmd)

    # strip the zigcc binary, where `--passL:-s` doesn't work.
    if "zigcc" in opts:
      execAndCheck(&"strip -s -R .comment {filename}")

    let binarySize = getFileSize(binaryPath) div 1000
    echo &"{binarySize:>3} kB {opts}"
    let cmdRunHello = when defined(windows): binaryPath else: &"./{binaryPath}"
    doAssert execCmdEx(cmdRunHello) == ("Hello, World!\n", 0)

when isMainModule:
  main()
