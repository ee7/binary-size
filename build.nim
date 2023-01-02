import std/[os, osproc, strformat, strutils]

type
  BuildKind = enum
    bkDebug = ""
    bkRelease = "release"
    bkDanger = "danger"

  Mm = enum
    mmRefc = "refc"
    mmArc = "arc"
    mmOrc = "orc"

  Opt = enum
    optSpeed = "speed"
    optSize = "size"

  LinkingKind = enum
    lkDynamic
    lkStaticMuslGcc
    lkStaticMuslClang
    lkStaticMuslZig

  CompileOptions = object
    buildKind: BuildKind
    flto: bool
    strip: bool
    mm: Mm
    opt: Opt
    linkingKind: LinkingKind

func init(T: typedesc[CompileOptions],
          buildKind = bkDebug,
          flto = false,
          strip = false,
          mm = mmRefc,
          opt = optSpeed,
          linkingKind = lkDynamic): T =
  T(
    buildKind: buildKind,
    flto: flto,
    strip: strip,
    mm: mm,
    opt: opt,
    linkingKind: linkingKind,
  )

when defined(linux):
  proc warn(msg: string) =
    stderr.write "Warning: "
    stderr.writeLine msg

proc getCompilationOptions: seq[CompileOptions] =
  result = @[
    CompileOptions.init(mm = mmOrc),
    CompileOptions.init(bkRelease, mm = mmOrc),
    CompileOptions.init(bkRelease, flto = true, mm = mmOrc),
    CompileOptions.init(bkRelease, flto = true, strip = true, mmOrc),
    CompileOptions.init(bkRelease, flto = true, strip = true, mmOrc, optSize),
  ]

  when defined(linux):
    if findExe("musl-gcc").len > 0:
      result.add CompileOptions.init(bkRelease, flto = true, strip = true, mmOrc,
                                     optSize, lkStaticMuslGcc)
    else:
      warn("musl-gcc not found")

    if findExe("musl-clang").len > 0:
      result.add CompileOptions.init(bkRelease, flto = true, strip = true, mmOrc,
                                     optSize, lkStaticMuslClang)
    else:
      warn("musl-clang not found")

    if findExe("zig").len > 0:
      result.add CompileOptions.init(bkRelease, mm = mmOrc, opt = optSize,
                                     linkingKind = lkStaticMuslZig)
    else:
      warn("zig not found")

func `$`(c: CompileOptions): string =
  result = if c.buildKind == bkDebug: "" else: &"-d:{c.buildKind}"
  if c.flto:
    result.add " --passC:-flto --passL:-flto"
  if c.strip:
    result.add " --passL:-s"
  if c.mm in {mmArc, mmOrc}:
    result.add &" --mm:{c.mm}"
  if c.opt == optSize:
    result.add &" --opt:{c.opt}"
  case c.linkingKind
    of lkDynamic:
      discard
    of lkStaticMuslGcc:
      result.add " --cc:gcc --gcc.exe:musl-gcc --gcc.linkerexe:musl-gcc --passL:-static"
    of lkStaticMuslClang:
      result.add " --cc:clang --clang.exe:musl-clang --clang.linkerexe:musl-clang --passL:-static"
    of lkStaticMuslZig:
      const pathZigcc = currentSourcePath().parentDir() / "zigcc"
      result.add " --panics:on -d:useMalloc --os:any -d:posix -d:noSignalHandler" &
                &" --cc=clang --clang.exe='{pathZigcc}' --clang.linkerexe='{pathZigcc}'" &
                 " --passC:'-flto -target x86_64-linux-musl'" &
                 " --passL:'-flto -target x86_64-linux-musl'"

proc execAndCheck(cmd: string) =
  ## Runs `cmd`, and raises an exception if the exit code is non-zero.
  let (output, exitCode) = execCmdEx(cmd)
  if exitCode != 0:
    stderr.writeLine output
    raise newException(OSError, "Command returned non-zero exit code: " & cmd)

proc main =
  const filename = "hello"
  const binaryPath = when defined(windows): &"{filename}.exe" else: filename
  let options = getCompilationOptions()
  for opts in options:
    let s = $opts
    let cmd = fmt"nim c --skipParentCfg --skipProjCfg {s} {filename}"
    execAndCheck(cmd)

    # strip the zigcc binary, where `--passL:-s` doesn't work.
    if opts.linkingKind == lkStaticMuslZig:
      execAndCheck(&"strip -s -R .comment {filename}")

    let binarySize = getFileSize(binaryPath).float / 1024
    echo &"{binarySize:>5.1f} KiB {s}"
    let cmdRunHello = when defined(windows): binaryPath else: &"./{binaryPath}"
    doAssert execCmdEx(cmdRunHello) == ("Hello, World!\n", 0)

when isMainModule:
  main()
