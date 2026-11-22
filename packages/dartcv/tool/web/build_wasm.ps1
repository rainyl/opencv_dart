<#
.SYNOPSIS
  Build the dartcv C wrapper + OpenCV to WebAssembly with Emscripten and link it into an
  ES module: `dartcv.mjs` (loader) + `dartcv.wasm`.

.DESCRIPTION
  Windows counterpart of `tool/web/build_wasm.sh`; it does the same steps and takes the same
  knobs, so both produce the same module.

  Needs Emscripten (the SDK installed, not just emsdk unpacked), CMake and Ninja. Emscripten is
  looked up in this order and used for the duration of the script, whatever installed it:

    1. `-Emsdk <dir>`, either the emsdk root or its `upstream/emscripten` directory;
    2. an `emcc` already on PATH (an activated emsdk, a standalone Emscripten, ...);
    3. `$env:EMSDK` / `$env:EMSDK_ROOT`, then the usual package-manager and default locations:
       scoop, chocolatey, `C:\emsdk`, `%USERPROFILE%\emsdk`, `%LOCALAPPDATA%\emsdk`, ...

  For a fresh emsdk the SDK itself still has to be installed once, e.g. in the emsdk directory:

    .\emsdk.bat install latest
    .\emsdk.bat activate latest

.EXAMPLE
  pwsh -File tool/web/build_wasm.ps1

.EXAMPLE
  pwsh -File tool/web/build_wasm.ps1 -Modules imgproc,imgcodecs -Clean
#>
[CmdletBinding()]
param(
  # dartcv modules to build (core is always on). Default: every module that works in a browser.
  [string[]]$Modules = @(
    'calib3d', 'dnn', 'features2d', 'flann', 'freetype', 'imgcodecs', 'imgproc', 'ml', 'objdetect',
    'photo', 'stitching', 'video', 'videoio', 'aruco', 'img_hash', 'quality', 'wechat_qrcode',
    'ximgproc', 'xobjdetect'
  ),
  # CMake build directory (default build/wasm).
  [string]$BuildDir,
  # Where dartcv.mjs / dartcv.wasm are written (default build/web).
  [string]$OutDir,
  # Optional local OpenCV source tree (skips the download).
  [string]$OpenCVSrc,
  # Optional local opencv_contrib source tree (skips the download).
  [string]$ContribSrc,
  # Emscripten SDK directory: an emsdk root, or the `upstream/emscripten` directory of one.
  # Default: an emcc already on PATH, then $env:EMSDK, then the usual install locations.
  [string]$Emsdk,
  # Delete the build directory first, i.e. reconfigure and rebuild from scratch.
  [switch]$Clean
)

$ErrorActionPreference = 'Stop'
Set-StrictMode -Version 3.0

$PkgDir = (Resolve-Path (Join-Path $PSScriptRoot '../..')).Path
if (-not $BuildDir) { $BuildDir = Join-Path $PkgDir 'build/wasm' }
if (-not $OutDir) { $OutDir = Join-Path $PkgDir 'build/web' }

# highgui needs a GUI backend and gapi is unfinished upstream, so neither is in the default set.
$AllModules = @(
  'calib3d', 'dnn', 'features2d', 'flann', 'freetype', 'highgui', 'imgcodecs', 'imgproc', 'ml',
  'objdetect', 'photo', 'stitching', 'video', 'videoio', 'gapi', 'aruco', 'img_hash', 'quality',
  'wechat_qrcode', 'ximgproc', 'xobjdetect'
)

# ---------------------------------------------------------------- emscripten

# The four tools the build drives; they live in Emscripten's `upstream/emscripten` (emsdk) or in a
# standalone Emscripten install.
$EmscriptenTools = @('emcc', 'em++', 'emcmake', 'emnm')

function Test-EmscriptenDir([string]$dir) {
  return (Test-Path (Join-Path $dir 'emcc.exe')) -or (Test-Path (Join-Path $dir 'emcc'))
}

function Test-EmsdkRoot([string]$dir) {
  return (Test-Path (Join-Path $dir 'emsdk_env.ps1')) -or (Test-Path (Join-Path $dir 'emsdk.bat'))
}

# `$env:EMSDK` and `$env:EMSDK_ROOT` first, then whatever scoop and chocolatey ship, then the
# locations emsdk itself defaults to. Nothing here assumes one package manager.
function Get-EmscriptenCandidates {
  $list = @()
  foreach ($name in @('EMSDK', 'EMSDK_ROOT')) {
    $value = [Environment]::GetEnvironmentVariable($name)
    if ($value) { $list += $value }
  }
  $list += @(
    (Join-Path $HOME 'scoop/apps/emscripten/current'),
    (Join-Path $HOME 'scoop/persist/emscripten'),
    'C:\emsdk',
    (Join-Path $HOME 'emsdk'),
    (Join-Path $HOME 'Documents/emsdk'),
    (Join-Path $env:LOCALAPPDATA 'emsdk'),
    (Join-Path $env:ProgramData 'emsdk'),
    'C:\tools\emsdk'
  )
  if ($env:ProgramFiles) { $list += (Join-Path $env:ProgramFiles 'emsdk') }
  # Any other scoop app or chocolatey package, e.g. chocolatey's emsdk/emscripten packages.
  $packageDirs = @(
    (Join-Path $HOME 'scoop/apps'),
    (Join-Path $env:ProgramData 'chocolatey/lib')
  )
  foreach ($root in $packageDirs) {
    if (-not (Test-Path $root)) { continue }
    foreach ($package in Get-ChildItem $root -Directory -ErrorAction SilentlyContinue) {
      $list += $package.FullName
      $list += (Join-Path $package.FullName 'tools')
    }
  }
  return $list | Where-Object { $_ } | Select-Object -Unique
}

# Returns @{ Emsdk = <emsdk root or $null>; Emscripten = <dir with emcc> }.
function Resolve-Emscripten {
  $roots = @()
  if ($Emsdk) { $roots += $Emsdk }
  $roots += Get-EmscriptenCandidates

  $seen = @{}
  $incomplete = @()
  foreach ($root in $roots) {
    if (-not (Test-Path $root)) { continue }
    $full = (Resolve-Path $root).Path
    if ($seen.ContainsKey($full)) { continue }
    $seen[$full] = $true

    if (Test-EmscriptenDir $full) { return @{ Emsdk = $null; Emscripten = $full } }

    $tools = Join-Path $full 'upstream/emscripten'
    if (Test-EmscriptenDir $tools) {
      if (Test-Path (Join-Path $tools 'tools')) { return @{ Emsdk = $full; Emscripten = $tools } }
      $incomplete += $full
    }
  }
  return @{ Emsdk = $null; Emscripten = $null; Incomplete = $incomplete }
}

function Get-ToolDir([string]$name) {
  $cmd = Get-Command $name -ErrorAction SilentlyContinue
  if ($cmd -and $cmd.Source) { return Split-Path -Parent $cmd.Source }
  if ($cmd -and $cmd.Path) { return Split-Path -Parent $cmd.Path }
  return $null
}

$EmsdkDir = $null
$EmscriptenDir = $null

# An `emcc` that is already on PATH (activated emsdk, standalone Emscripten, a shim, ...) needs no
# environment setup at all - unless -Emsdk asked for a specific SDK.
$pathTools = @($EmscriptenTools | Where-Object { Get-Command $_ -ErrorAction SilentlyContinue })
if (-not $Emsdk -and $pathTools.Count -eq $EmscriptenTools.Count) {
  $EmscriptenDir = Get-ToolDir 'emcc'
  Write-Host "emscripten: $EmscriptenDir (from PATH)"
} else {
  $resolved = Resolve-Emscripten
  if ($resolved.Emscripten) {
    $EmsdkDir = $resolved.Emsdk
    $EmscriptenDir = $resolved.Emscripten
  } elseif ($resolved.Incomplete -and $resolved.Incomplete.Count -gt 0) {
    # A fresh emsdk checkout: only emsdk itself is there, the SDK has not been installed yet.
    $root = $resolved.Incomplete[0]
    throw @"
Emscripten is not installed in ${root}: upstream/emscripten has no tools/ directory. Install the SDK
once (emsdk, whatever installed emsdk itself):

  cd "$root"
  .\emsdk.bat install latest
  .\emsdk.bat activate latest
"@
  } else {
    throw @"
Emscripten not found. Install it (emsdk, scoop, chocolatey, ...), put `emcc` on PATH, or point
`-Emsdk` at the emsdk root / at the directory holding emcc:

  https://emscripten.org/docs/getting_started/downloads.html
"@
  }

  if ($EmsdkDir) {
    Write-Host "emsdk:  $EmsdkDir"
    # Emscripten needs its own node/python and the tools directory on PATH. `emsdk_env.ps1` does
    # that too, but it goes through emsdk.py, which decides how to emit the environment for the
    # calling shell (and gets it wrong when PowerShell is started from Git Bash), so set the four
    # variables emsdk itself would set.
    $env:EMSDK = $EmsdkDir
    foreach ($tool in @('python', 'node')) {
      $exe = Get-ChildItem (Join-Path $EmsdkDir $tool) -Filter "$tool.exe" -Recurse -Depth 2 -ErrorAction SilentlyContinue |
        Sort-Object FullName -Descending | Select-Object -First 1
      if ($exe) { Set-Item "Env:EMSDK_$(($tool).ToUpperInvariant())" $exe.FullName }
    }
    $env:PATH = "$EmscriptenDir;$EmsdkDir;$env:PATH"
  } else {
    # `-Emsdk` pointing straight at an Emscripten tree, no emsdk around it.
    $env:PATH = "$EmscriptenDir;$env:PATH"
  }
  Write-Host "emscripten: $EmscriptenDir"
}

foreach ($tool in $EmscriptenTools) {
  if (-not (Get-Command $tool -ErrorAction SilentlyContinue)) {
    throw "$tool not found in $EmscriptenDir"
  }
}

$emccVersion = & emcc --version 2>&1
if ($LASTEXITCODE -ne 0) { throw "emcc --version failed: $($emccVersion -join "`n")" }
Write-Host ($emccVersion -split "`n")[0]

# ---------------------------------------------------------------- cmake

$generator = @()
if (Get-Command ninja -ErrorAction SilentlyContinue) {
  $generator = @('-G', 'Ninja')
} elseif (Get-Command mingw32-make -ErrorAction SilentlyContinue) {
  $generator = @('-G', 'MinGW Makefiles')
} else {
  throw 'Neither Ninja nor mingw32-make was found: CMake would pick Visual Studio, which cannot build this module. Install ninja (`scoop install ninja`).'
}

# `-Modules imgproc,imgcodecs` arrives as one string when the script is started with `-File`, so
# split on commas as well and reject names that are not modules (a typo would silently disable
# everything).
$Modules = @($Modules | ForEach-Object { $_ -split '[,;\s]+' } | Where-Object { $_ })
$unknown = @($Modules | Where-Object { $AllModules -notcontains $_ })
if ($unknown.Count -gt 0) {
  throw "unknown module(s): $($unknown -join ', '). Valid modules are: $($AllModules -join ', ')"
}

$moduleArgs = foreach ($m in $AllModules) {
  if ($Modules -contains $m) { "-DDARTCV_WITH_$($m.ToUpperInvariant())=ON" }
  else { "-DDARTCV_WITH_$($m.ToUpperInvariant())=OFF" }
}

# OpenCV turns off its filesystem helpers (utils::fs::exists, ...) for Emscripten; the in-memory
# file system supports the POSIX calls they need, and wechat_qrcode/dnn model loading use them.
# `-fwasm-exceptions` is required: BEGIN_WRAP/END_WRAP turn C++ exceptions into CvStatus, and
# Emscripten's default (exception catching disabled) would abort instead.
$cflagsWasm = '-fwasm-exceptions -DOPENCV_HAVE_FILESYSTEM_SUPPORT=1'
# `-include iterator`: OpenCV 4.13's calib3d/stereo_geom.cpp calls std::back_inserter without
# including <iterator>; emsdk 6.0.13's libc++ pulls it in, emsdk 7's (LLVM 22) does not. C++ only,
# a C translation unit (some of Emscripten's are) has no <iterator>.
$cxxflagsWasm = "$cflagsWasm -include iterator"

if ($Clean -and (Test-Path $BuildDir)) {
  Write-Host "removing $BuildDir"
  Remove-Item -Recurse -Force $BuildDir
}

if (-not (Test-Path (Join-Path $BuildDir 'CMakeCache.txt'))) {
  $fetchArgs = @()
  if ($OpenCVSrc) { $fetchArgs += "-DFETCHCONTENT_SOURCE_DIR_OPENCV=$OpenCVSrc" }
  if ($ContribSrc) { $fetchArgs += "-DFETCHCONTENT_SOURCE_DIR_OPENCV_CONTRIB=$ContribSrc" }

  $configureArgs = @(
    'cmake',
    '-S', (Join-Path $PkgDir 'src'),
    '-B', $BuildDir
  ) + $generator + @('-DCMAKE_BUILD_TYPE=Release') + $fetchArgs + $moduleArgs + @(
    '-DWITH_OPENCL=OFF',
    '-DWITH_VULKAN=OFF',
    '-DWITH_PTHREADS_PF=OFF',
    '-DCV_ENABLE_INTRINSICS=OFF',
    '-DBUILD_TIFF=OFF',
    '-DWITH_TIFF=OFF',
    '-DBUILD_OPENJPEG=OFF',
    '-DWITH_OPENJPEG=OFF',
    '-DENABLE_LIBJPEG_TURBO_SIMD=OFF',
    '-DCMAKE_POLICY_VERSION_MINIMUM=3.5',
    "-DCMAKE_C_FLAGS=$cflagsWasm",
    "-DCMAKE_CXX_FLAGS=$cxxflagsWasm"
  )

  Write-Host 'configuring (emcmake cmake)'
  & emcmake @configureArgs
  if ($LASTEXITCODE -ne 0) { throw "cmake configure failed with exit code $LASTEXITCODE" }
}

Write-Host 'building libdartcv'
& cmake --build $BuildDir --target dartcv
if ($LASTEXITCODE -ne 0) { throw "cmake build failed with exit code $LASTEXITCODE" }

# ---------------------------------------------------------------- link

# CMake builds dartcv as a dylink side module (libdartcv.so); we link its objects and the OpenCV
# static libraries into one main module instead.
$objDir = Join-Path $BuildDir 'dartcv/CMakeFiles/dartcv.dir'
$objs = @(Get-ChildItem $objDir -Recurse -Filter '*.cpp.o' | ForEach-Object { $_.FullName } | Sort-Object)
if ($objs.Count -eq 0) { throw "no object files under $objDir" }

$depsDir = Join-Path $BuildDir '_deps'
$libs = @(
  Get-ChildItem $depsDir -Recurse -Filter '*.a' |
    Where-Object { $_.FullName -notmatch '[\\/]CMakeFiles[\\/]' } |
    ForEach-Object { $_.FullName } |
    Sort-Object
)

# Export list: every C symbol the Dart bindings declare (lib/src/g/*.g.dart) that this build
# defines. Symbols of modules left out of $Modules are skipped; the web bindings throw
# UnsupportedError for them at call time.
New-Item -ItemType Directory -Force -Path $OutDir | Out-Null
$exportFile = Join-Path $OutDir 'exports.txt'
$declared = @(
  Get-ChildItem (Join-Path $PkgDir 'lib/src/g') -Filter '*.g.dart' |
    Select-String -Pattern '^external [^=(]* ([A-Za-z_][A-Za-z0-9_]*)\(' |
    ForEach-Object { $_.Matches[0].Groups[1].Value } |
    Sort-Object -Unique
)
$defined = New-Object 'System.Collections.Generic.HashSet[string]'
foreach ($line in (& emnm --defined-only -j @objs 2>$null)) {
  $s = "$line".Trim()
  if ($s -and -not $s.EndsWith(':')) { [void]$defined.Add($s) }
}
$exported = @(
  foreach ($name in $declared) { if ($defined.Contains($name)) { "_$name" } }
) + @('_malloc', '_free')
$exported = @($exported | Sort-Object -Unique)
[System.IO.File]::WriteAllText($exportFile, (($exported -join "`n") + "`n"))
Write-Host "exporting $($exported.Count) symbols"

# A Windows command line caps out at ~32k characters and this list is longer than that, hence a
# response file. ximgproc's EdgeDrawing has 64 MB of static lookup tables (zero-initialised, so
# not in the .wasm file), hence the large initial memory.
$rsp = Join-Path $OutDir 'link.rsp'
$linkArgs = @('-O3') +
  @($objs + $libs | ForEach-Object { '"' + ($_ -replace '\\', '/') + '"' }) +
  @(
    "-o `"$($OutDir -replace '\\', '/')/dartcv.mjs`"",
    '-sMODULARIZE=1',
    '-sEXPORT_ES6=1',
    '-sEXPORT_NAME=createDartcvModule',
    '-sENVIRONMENT=web,worker,node',
    '-sALLOW_MEMORY_GROWTH=1',
    '-sINITIAL_MEMORY=96MB',
    '-sSTACK_SIZE=1MB',
    '-fwasm-exceptions',
    '-sALLOW_TABLE_GROWTH=1',
    '-sFORCE_FILESYSTEM=1',
    "-sEXPORTED_FUNCTIONS=`"@$($exportFile -replace '\\', '/')`"",
    '-sEXPORTED_RUNTIME_METHODS=HEAPU8,wasmMemory,addFunction,removeFunction,FS',
    '-sERROR_ON_UNDEFINED_SYMBOLS=1'
  )
[System.IO.File]::WriteAllText($rsp, (($linkArgs -join "`n") + "`n"))

Write-Host 'linking dartcv.mjs'
& em++ "@$rsp"
if ($LASTEXITCODE -ne 0) { throw "em++ failed with exit code $LASTEXITCODE" }

Get-ChildItem $OutDir -Filter 'dartcv.*' | Format-Table Name, Length -AutoSize
