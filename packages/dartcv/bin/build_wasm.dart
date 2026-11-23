// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Builds the dartcv C wrapper + OpenCV to WebAssembly with Emscripten and links them into an ES
// module: `build/web/dartcv.js` (loader) + `build/web/dartcv.wasm`.
//
// This replaces `tool/web/build_wasm.sh` and `tool/web/build_wasm.ps1` (kept, deprecated, for one
// release): `package:native_toolchain_cmake`'s `CMakeWasmBuilder` drives the Emscripten toolchain,
// the CMake build of `src/` and the linking of the `dartcv_wasm` target, which is what the two
// platform scripts had to reimplement per OS.
//
// It is the package's `bin/` entry point, so an application that depends on dartcv4 can build the
// module straight into its own web directory:
//
//   dart run dartcv4:build_wasm                     # -> ./web/dartcv.js + ./web/dartcv.wasm
//   dart run dartcv4:build_wasm --modules imgproc   # a smaller module
//   dart run dartcv4:build_wasm --out-dir some/dir
//
// and from this package's own checkout it keeps the CI layout (`build/wasm`, `build/web`):
//
//   dart tool/web/build_wasm.dart
//   dart tool/web/build_wasm.dart --modules imgproc,imgcodecs
//   dart tool/web/build_wasm.dart --check-emscripten     # only report the toolchain, build nothing
//
// Emscripten is found by `package:native_toolchain_cmake`: `--emsdk`, then an `emcc` on PATH, then
// `EMSDK`, then the usual emsdk locations. Ninja is required (the builder does not support the
// Makefile generators).

// ignore_for_file: avoid_print

import 'dart:io';
import 'dart:isolate';

import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

/// Every module `src/dartcv/CMakeLists.txt` knows about.
const _allModules = <String>[
  'calib3d',
  'dnn',
  'features2d',
  'flann',
  'freetype',
  'highgui',
  'imgcodecs',
  'imgproc',
  'ml',
  'objdetect',
  'photo',
  'stitching',
  'video',
  'videoio',
  'gapi',
  'aruco',
  'img_hash',
  'quality',
  'wechat_qrcode',
  'ximgproc',
  'xobjdetect',
];

/// highgui needs a GUI backend and gapi is unfinished upstream, so neither is in the default set.
const _browserUnsupportedModules = <String>{'highgui', 'gapi'};

/// OpenCV turns off its filesystem helpers (utils::fs::exists, ...) for Emscripten; the in-memory
/// file system supports the POSIX calls they need, and wechat_qrcode/dnn model loading use them.
///
/// `-fwasm-exceptions` is required: BEGIN_WRAP/END_WRAP turn C++ exceptions into CvStatus, and
/// Emscripten's default (exception catching disabled) would abort instead.
const _cFlags = '-fwasm-exceptions -DOPENCV_HAVE_FILESYSTEM_SUPPORT=1';

/// `-include iterator`: OpenCV 4.13's calib3d/stereo_geom.cpp calls std::back_inserter without
/// including <iterator>; emsdk 6.0.13's libc++ pulls it in, emsdk 7's (LLVM 22) does not. C++ only,
/// a C translation unit (some of Emscripten's are) has no <iterator>.
const _cxxFlags = '$_cFlags -include iterator';

/// OpenCV options a browser build cannot use, or that only bloat it. Same set the shell scripts
/// passed; they are `-D` on the project, not properties of the dartcv target.
const _opencvOptions = <String, String>{
  'WITH_OPENCL': 'OFF',
  'WITH_VULKAN': 'OFF',
  'WITH_PTHREADS_PF': 'OFF',
  'CV_ENABLE_INTRINSICS': 'OFF',
  'BUILD_TIFF': 'OFF',
  'WITH_TIFF': 'OFF',
  'BUILD_OPENJPEG': 'OFF',
  'WITH_OPENJPEG': 'OFF',
  'ENABLE_LIBJPEG_TURBO_SIMD': 'OFF',
  // OpenCV 4.13's CMake still declares cmake_minimum_required below 3.5 in places.
  'CMAKE_POLICY_VERSION_MINIMUM': '3.5',
};

/// A module left out of the build is not an error for the web bindings: the runtime throws
/// `UnsupportedError` for it. Below these, something is wrong with the build itself rather than
/// with the module set, and the module would be useless in a browser.
const _minExports = 500;
const _minWasmBytes = 1000 * 1000;

const _usage = r'''
Build dartcv for the web: dartcv.js + dartcv.wasm.

  dart run dartcv4:build_wasm        # in an app that depends on dartcv4 -> web/ by default
  dart tool/web/build_wasm.dart      # in this package -> build/web, build tree in build/wasm

  --modules <a,b|all>   dartcv modules to build (default: every one that works in a browser).
                        `all` adds highgui and gapi, which are not expected to link.
  --build-dir <dir>     CMake build directory (default: build/wasm in this package,
                        build/dartcv_wasm elsewhere; $BUILD_DIR)
  --out-dir <dir>       where dartcv.js / dartcv.wasm are written (default: build/web in this
                        package, web/ elsewhere; $OUT_DIR)
  --opencv-src <dir>    local OpenCV source tree, skips the download ($OPENCV_SRC)
  --contrib-src <dir>   local opencv_contrib source tree, skips the download ($CONTRIB_SRC)
  --emsdk <dir>         emsdk root, or the directory holding emcc (default: $EMSDK, then PATH)
  --jobs <n>            parallel build jobs (default: CMake's)
  --clean               delete the build directory first
  --single-file         embed the .wasm in dartcv.js (`-sSINGLE_FILE=1`)
  --check-emscripten    report the Emscripten/Ninja/CMake that would be used, build nothing
  -v, --verbose         show the CMake command lines
  -h, --help            this message
''';

Future<void> main(List<String> args) async {
  // A named logger may only carry its own level when hierarchy is enabled; the CMake/emcc command
  // lines the builder logs are what `--verbose` is for.
  hierarchicalLoggingEnabled = true;

  final _Options options;
  try {
    options = _Options.parse(args);
  } on _UsageError catch (error) {
    stderr
      ..writeln('error: ${error.message}')
      ..writeln()
      ..writeln(_usage);
    exitCode = 64;
    return;
  }
  if (options.help) {
    print(_usage);
    return;
  }

  final logger = Logger('dartcv-wasm')
    ..level = options.verbose ? Level.ALL : Level.WARNING
    ..onRecord.listen((record) {
      if (record.level >= Level.WARNING && record.level < Level.SEVERE) {
        stderr.writeln(record.message);
      } else if (record.level < Level.WARNING) {
        stdout.writeln(record.message);
      } else {
        stderr.writeln(record.message);
      }
    });

  try {
    await _run(options, logger);
  } on _Failure catch (error) {
    stderr.writeln('error: ${error.message}');
    exitCode = 1;
  }
}

Future<void> _run(_Options options, Logger logger) async {
  final packageDir = _packageDir();
  // In this package's checkout the CI layout stays the default (`build/wasm` is the cache key and
  // `test/web_test.dart` loads `build/web`); from an application, `web/` is where a Flutter web
  // build picks the files up, and the build tree belongs to the application.
  final inPackage = _sameDirectory(packageDir, Directory.current);
  final base = inPackage ? packageDir : Directory.current;
  final outDir = Directory(_absolute(options.outDir ?? (inPackage ? 'build/web' : 'web'), base));
  final buildDir = Directory(
    _absolute(options.buildDir ?? (inPackage ? 'build/wasm' : 'build/dartcv_wasm'), base),
  );
  final modules = options.modules ?? _defaultModules;

  final unknown = modules.where((m) => !_allModules.contains(m)).toList();
  if (unknown.isNotEmpty) {
    throw _Failure(
      'unknown module(s): ${unknown.join(', ')}. Valid modules are: ${_allModules.join(', ')}',
    );
  }
  final unsupported = modules.where(_browserUnsupportedModules.contains).toList();
  if (unsupported.isNotEmpty) {
    stderr.writeln(
      'warning: ${unsupported.join(', ')} '
      '${unsupported.length == 1 ? 'is' : 'are'} not expected to link for the web '
      '(highgui needs a GUI backend, gapi is unfinished upstream)',
    );
  }

  final emscripten = _emscripten(options.emsdk);
  final toolchain = await _preflight(emscripten, options, logger);
  if (options.checkEmscripten) {
    return;
  }

  if (options.clean && buildDir.existsSync()) {
    print('removing ${buildDir.path}');
    buildDir.deleteSync(recursive: true);
  }

  // A build artefact, so it lives in the build directory: in an application the output directory is
  // its `web/`, which must only receive the two files that get served.
  final exportFile = File('${buildDir.path}/exports.txt');
  final declared = _writeExports(Directory('${packageDir.path}/lib/src/g'), exportFile);
  print('exporting $declared declared symbols from ${exportFile.path}');

  final builder = CMakeWasmBuilder.create(
    name: 'dartcv',
    sourceDir: Uri.directory('${packageDir.path}/src'),
    // `runStandalone` would default this to `<out>/cmake`; keeping it at build/wasm is what the
    // CI cache (and the deprecated scripts) use.
    outDir: buildDir.uri,
    targets: const ['dartcv_wasm'],
    defines: _defines(options, modules, exportFile),
    singleFile: options.singleFile,
    buildMode: BuildMode.release,
    generator: Generator.ninja,
    emscriptenArgs: emscripten.args,
    environment: emscripten.environment,
    parallelJobs: options.jobs,
    logLevel: options.verbose ? LogLevel.VERBOSE : LogLevel.STATUS,
    logger: logger,
  );

  print('building ${modules.length} modules with Emscripten ${toolchain.version ?? '(unknown)'}');
  final artifacts = await builder.runStandalone(
    outputDirectory: outDir.uri,
    logger: logger,
  );

  _verify(outDir, exportFile, options.singleFile, artifacts);

  // Stamp the module with the version it was built from: `initDartcv()` compares it with the package
  // the app uses and warns about a `dartcv.js` left over from another release.
  final version = _packageVersion(packageDir);
  _embedModuleVersion(File('${outDir.path}/dartcv.js'), version);
  print('version:  $version (exported as dartcvVersion)');
}

/// The package version the module must claim, from `pubspec.yaml`, cross-checked against the
/// constant `initDartcv()` compares with (generated by `tool/web/gen_web_bindings.dart`).
String _packageVersion(Directory packageDir) {
  final pubspec = File('${packageDir.path}/pubspec.yaml').readAsStringSync();
  final match = RegExp(r'^version: *(.+)$', multiLine: true).firstMatch(pubspec);
  final version = match?.group(1)?.trim();
  if (version == null || version.isEmpty) {
    throw _Failure('no `version:` in ${packageDir.path}/pubspec.yaml');
  }

  final declared = File('${packageDir.path}/lib/src/package_version.dart');
  final constant = declared.existsSync()
      ? RegExp("packageVersion = '([^']*)'").firstMatch(declared.readAsStringSync())?.group(1)
      : null;
  if (constant != version) {
    throw _Failure(
      '${declared.path} says ${constant ?? '(nothing)'} but pubspec.yaml says $version: '
      'run `dart tool/web/gen_web_bindings.dart`.',
    );
  }
  return version;
}

/// Appends `export const dartcvVersion = '<version>';` to the ES module Emscripten wrote.
///
/// A named export is the only way into the module object that does not need a generated binding or a
/// C function of its own; `initDartcv()` reads it before instantiating anything.
void _embedModuleVersion(File js, String version) {
  final line = "export const dartcvVersion = '$version';";
  var source = js.readAsStringSync();
  // Repeated builds must not stack the export: drop the one an earlier build appended.
  source = source.replaceAll(RegExp("export const dartcvVersion = '[^']*';\n?"), '');
  if (!source.endsWith('\n')) source = '$source\n';
  js.writeAsStringSync('$source$line\n', flush: true);
}

/// Resolves the toolchain the build will use, and fails with an actionable message when something
/// is missing rather than letting CMake fail halfway through a configure.
Future<({String? version, String emcc, String toolchainFile})> _preflight(
  _Emscripten emscripten,
  _Options options,
  Logger logger,
) async {
  final ninjaVersion = _probe('ninja', const ['--version']);
  if (ninjaVersion == null) {
    throw const _Failure(
      'Ninja is required for the Emscripten build and was not found on PATH.\n'
      '  scoop install ninja    # Windows\n'
      '  brew install ninja     # macOS\n'
      '  apt install ninja-build  # Debian/Ubuntu',
    );
  }
  final cmakeVersion = _probe('cmake', const ['--version']);
  if (cmakeVersion == null) {
    throw const _Failure('CMake is required and was not found on PATH.');
  }

  final ({String? version, String emcc, String toolchainFile}) toolchain;
  try {
    final resolved = await resolveEmscripten(
      args: emscripten.args,
      environment: emscripten.environment,
      logger: logger,
    );
    final version = resolved.emcc.version?.toString();
    print('emscripten: ${resolved.emcc.uri.toFilePath()} ($version)');
    print('toolchain:  ${resolved.toolchainFile.toFilePath()}');
    toolchain = (
      version: version,
      emcc: resolved.emcc.uri.toFilePath(),
      toolchainFile: resolved.toolchainFile.toFilePath(),
    );
  } catch (error) {
    throw _Failure(
      '$error\n'
      'Install Emscripten 6.0 or newer (https://emscripten.org/docs/getting_started/downloads.html),\n'
      'put `emcc` on PATH, set EMSDK, or pass --emsdk <dir>.',
    );
  }
  print('ninja:      ${ninjaVersion.split('\n').first}');
  print('cmake:      ${cmakeVersion.split('\n').first}');
  return toolchain;
}

/// Where Emscripten is, in the two shapes the builder accepts.
///
/// `--emsdk` takes either an emsdk root or the directory holding `emcc` (the PowerShell script did
/// too), and they are not interchangeable: a root means `<emsdk>/upstream/emscripten/emcc`, while
/// the other needs `<dir>/emcc`. Tool discovery reads neither from the builder args (it looks at
/// `EMSDK` and `PATH`), so the same choice is also expressed as the child environment.
final class _Emscripten {
  final EmscriptenBuilderArgs args;
  final Map<String, String> environment;

  const _Emscripten({required this.args, required this.environment});
}

_Emscripten _emscripten(String? emsdk) {
  final environment = Map<String, String>.from(Platform.environment);
  final root = emsdk ?? Platform.environment['EMSDK'];
  if (root == null || root.isEmpty) {
    return _Emscripten(args: const EmscriptenBuilderArgs(), environment: environment);
  }
  final path = _forwardSlashes(Directory(root).absolute.path);
  final emcc = File('$path/emcc');
  final holdsEmcc = emcc.existsSync() || File('$path/emcc.exe').existsSync();
  if (holdsEmcc) {
    environment['PATH'] = [
      path,
      environment['PATH'],
    ].whereType<String>().join(Platform.isWindows ? ';' : ':');
    // `<emsdk>/upstream/emscripten` also has to know which emsdk it belongs to: emcc looks for its
    // LLVM, node and sysroot through `EMSDK`, which a bare directory cannot tell it.
    final upstream = Directory(path).parent;
    if (_forwardSlashes(upstream.path).endsWith('/upstream')) {
      environment['EMSDK'] = _forwardSlashes(upstream.parent.absolute.path);
    }
    return _Emscripten(
      args: EmscriptenBuilderArgs(emscriptenRoot: path),
      environment: environment,
    );
  }
  environment['EMSDK'] = path;
  return _Emscripten(
    args: EmscriptenBuilderArgs(emsdkPath: path),
    environment: environment,
  );
}

Map<String, String> _defines(_Options options, List<String> modules, File exportFile) => {
  for (final module in _allModules)
    'DARTCV_WITH_${module.toUpperCase()}': modules.contains(module) ? 'ON' : 'OFF',
  if (options.opencvSrc != null)
    'FETCHCONTENT_SOURCE_DIR_OPENCV': _forwardSlashes(Directory(options.opencvSrc!).absolute.path),
  if (options.contribSrc != null)
    'FETCHCONTENT_SOURCE_DIR_OPENCV_CONTRIB': _forwardSlashes(
      Directory(options.contribSrc!).absolute.path,
    ),
  // The list is a response file for emcc: see `src/dartcv/CMakeLists.txt`.
  'DARTCV_WASM_EXPORTS': _forwardSlashes(exportFile.absolute.path),
  'CMAKE_C_FLAGS': _cFlags,
  'CMAKE_CXX_FLAGS': _cxxFlags,
  ..._opencvOptions,
};

/// Writes the export list `src/dartcv/CMakeLists.txt` links with, and returns how many symbols it
/// declares.
///
/// Every `@ffi.Native` the web bindings can call is declared as `external ... name(` in
/// `lib/src/g/*.g.dart`, and the module exports exactly those that this build defines:
/// `-Wl,--export-if-defined=` is silent about the rest, so a module left out of the build is not an
/// error here (the runtime throws `UnsupportedError` for those calls).
int _writeExports(Directory generatedDir, File exportFile) {
  final declaration = RegExp(r'^external [^=(]* ([A-Za-z_][A-Za-z0-9_]*)\(', multiLine: true);
  final symbols = <String>{};
  for (final file in generatedDir.listSync().whereType<File>()) {
    if (!file.path.endsWith('.g.dart')) continue;
    symbols.addAll(declaration.allMatches(file.readAsStringSync()).map((m) => m.group(1)!));
  }
  if (symbols.isEmpty) {
    throw _Failure('no `external` declarations found in ${generatedDir.path}: wrong directory?');
  }

  // `--export-if-defined` takes the *wasm* symbol name, which has no leading underscore (writing
  // `_cv_...` there silently exports nothing); `_malloc`/`_free` are an Emscripten setting instead,
  // so they are not part of this list.
  final lines =
      symbols.map((s) => '-Wl,--export-if-defined=${s.startsWith('_') ? s.substring(1) : s}').toList()
        ..sort();
  final content = '${lines.join('\n')}\n';

  // Rewriting an identical file would make the link depend on a changed timestamp and rebuild the
  // module on every run.
  if (!exportFile.existsSync() || exportFile.readAsStringSync() != content) {
    exportFile.parent.createSync(recursive: true);
    exportFile.writeAsStringSync(content, flush: true);
  }
  return symbols.length;
}

void _verify(Directory outDir, File exportFile, bool singleFile, List<Uri> artifacts) {
  final exports = exportFile.readAsLinesSync().where((line) => line.isNotEmpty).length;
  if (exports < _minExports) {
    throw _Failure('only $exports exported symbols (expected at least $_minExports)');
  }

  final wasm = File('${outDir.path}/dartcv.wasm');
  final js = File('${outDir.path}/dartcv.js');
  if (!js.existsSync()) {
    throw _Failure('dartcv.js was not written to ${outDir.path}');
  }
  if (singleFile) {
    if (wasm.existsSync()) {
      throw _Failure('${wasm.path} should not exist in a --single-file build');
    }
  } else if (!wasm.existsSync()) {
    throw _Failure('dartcv.wasm was not written to ${outDir.path}');
  } else if (wasm.lengthSync() < _minWasmBytes) {
    throw _Failure('dartcv.wasm is suspiciously small (${wasm.lengthSync()} bytes)');
  }

  for (final artifact in artifacts) {
    final file = File.fromUri(artifact);
    stdout.writeln('${file.path}  ${_human(file.lengthSync())}');
  }
  stdout.writeln('exports: $exports');
}

String _human(int bytes) => bytes >= 1000 * 1000
    ? '${(bytes / (1000 * 1000)).toStringAsFixed(1)} MB'
    : '${(bytes / 1000).toStringAsFixed(1)} kB';

String? _probe(String executable, List<String> arguments) {
  try {
    final result = Process.runSync(executable, arguments);
    if (result.exitCode != 0) return null;
    return '${result.stdout}'.trim();
  } on ProcessException {
    return null;
  }
}

/// The dartcv4 package to build from.
///
/// `dart run dartcv4:build_wasm` runs this file out of the pub cache while the working directory
/// belongs to the application, so the package config is the authority there; the script path and a
/// walk up from the working directory cover running it from a checkout.
Directory _packageDir() {
  final resolved = Isolate.resolvePackageUriSync(Uri.parse('package:dartcv4/dartcv.dart'));
  if (resolved != null) {
    final candidate = File.fromUri(resolved).parent.parent;
    if (File('${candidate.path}/src/CMakeLists.txt').existsSync()) return candidate;
  }

  var candidate = File.fromUri(Platform.script).absolute.parent.parent.parent;
  if (File('${candidate.path}/src/CMakeLists.txt').existsSync()) return candidate;

  candidate = Directory.current;
  while (true) {
    if (File('${candidate.path}/src/CMakeLists.txt').existsSync() &&
        File('${candidate.path}/lib/src/g/core.g.dart').existsSync()) {
      return candidate;
    }
    final parent = candidate.parent;
    if (parent.path == candidate.path) {
      throw const _Failure('cannot find the packages/dartcv directory (run this from packages/dartcv)');
    }
    candidate = parent;
  }
}

String _absolute(String path, Directory base) => Directory(path).isAbsolute ? path : '${base.path}/$path';

bool _sameDirectory(Directory a, Directory b) =>
    a.absolute.uri.normalizePath().toString() == b.absolute.uri.normalizePath().toString();

String _forwardSlashes(String path) => path.replaceAll(r'\', '/');

/// Modules from the environment are space or comma separated, as the shell scripts took them.
List<String>? _modules(String? value) {
  if (value == null || value.isEmpty) return null;
  final names = value.split(RegExp(r'[,;\s]+')).where((name) => name.isNotEmpty).toList();
  if (names.length == 1 && names.single == 'all') return _allModules;
  return names;
}

final _defaultModules = [
  for (final module in _allModules)
    if (!_browserUnsupportedModules.contains(module)) module,
];

final class _Options {
  final bool help;
  final bool verbose;
  final bool clean;
  final bool singleFile;
  final bool checkEmscripten;
  final List<String>? modules;
  final String? buildDir;
  final String? outDir;
  final String? opencvSrc;
  final String? contribSrc;
  final String? emsdk;
  final int? jobs;

  const _Options({
    required this.help,
    required this.verbose,
    required this.clean,
    required this.singleFile,
    required this.checkEmscripten,
    required this.modules,
    required this.buildDir,
    required this.outDir,
    required this.opencvSrc,
    required this.contribSrc,
    required this.emsdk,
    required this.jobs,
  });

  /// Flags win over the environment, which wins over the default; the environment variables are
  /// the ones the shell scripts took, so an existing CI job keeps working unchanged.
  factory _Options.parse(List<String> args) {
    var help = false;
    var verbose = false;
    var clean = false;
    var singleFile = false;
    var checkEmscripten = false;
    List<String>? modules = _modules(Platform.environment['MODULES']);
    String? buildDir = Platform.environment['BUILD_DIR'];
    String? outDir = Platform.environment['OUT_DIR'];
    String? opencvSrc = Platform.environment['OPENCV_SRC'];
    String? contribSrc = Platform.environment['CONTRIB_SRC'];
    String? emsdk = Platform.environment['EMSDK'];
    int? jobs;

    for (var i = 0; i < args.length; i++) {
      final argument = args[i];
      final separator = argument.indexOf('=');
      final name = separator < 0 ? argument : argument.substring(0, separator);
      final inline = separator < 0 ? null : argument.substring(separator + 1);
      String value() {
        if (inline != null) return inline;
        if (i + 1 >= args.length) throw _UsageError('$name needs a value');
        return args[++i];
      }

      switch (name) {
        case '-h' || '--help':
          help = true;
        case '-v' || '--verbose':
          verbose = true;
        case '--clean':
          clean = true;
        case '--single-file':
          singleFile = true;
        case '--check-emscripten':
          checkEmscripten = true;
        case '--modules':
          modules = _modules(value());
        case '--build-dir':
          buildDir = value();
        case '--out-dir':
          outDir = value();
        case '--opencv-src':
          opencvSrc = value();
        case '--contrib-src':
          contribSrc = value();
        case '--emsdk':
          emsdk = value();
        case '--jobs':
          final raw = value();
          jobs = int.tryParse(raw);
          if (jobs == null || jobs < 1) throw _UsageError('--jobs needs a positive integer, got "$raw"');
        default:
          throw _UsageError('unknown option "$argument"');
      }
    }

    return _Options(
      help: help,
      verbose: verbose,
      clean: clean,
      singleFile: singleFile,
      checkEmscripten: checkEmscripten,
      modules: modules,
      buildDir: buildDir,
      outDir: outDir,
      opencvSrc: opencvSrc,
      contribSrc: contribSrc,
      emsdk: emsdk,
      jobs: jobs,
    );
  }
}

final class _UsageError implements Exception {
  final String message;
  const _UsageError(this.message);
}

/// A build failure whose message is meant for the user, not a stack trace.
final class _Failure implements Exception {
  final String message;
  const _Failure(this.message);
}
