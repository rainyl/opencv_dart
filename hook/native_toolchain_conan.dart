import 'dart:convert';
import 'dart:io';

import 'package:logging/logging.dart';
import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:path/path.dart' as p;

abstract class Builder {
  Future<void> run({
    required BuildConfig buildConfig,
    required BuildOutput buildOutput,
    required Logger? logger,
  });
}

class ConanBuilder implements Builder {
  /// Name of the library or executable to build.
  ///
  /// The filename will be decided by [BuildConfig.targetOS] and
  /// [OS.libraryFileName] or [OS.executableFileName].
  ///
  /// File will be placed in [BuildConfig.outputDirectory].
  final String name;

  /// Asset identifier.
  ///
  /// Used to output the [BuildOutput.assets].
  ///
  /// If omitted, no asset will be added to the build output.
  final String? assetName;

  /// Include directories to pass to the compiler.
  ///
  /// Resolved against [BuildConfig.packageRoot].
  ///
  /// Used to output the [BuildOutput.dependencies].
  final List<String> includes;

  final String? preset;

  /// Definitions of preprocessor macros.
  ///
  /// When the value is `null`, the macro is defined without a value.
  final Map<String, String?> defines;

  /// The dart files involved in building this artifact.
  ///
  /// Resolved against [BuildConfig.packageRoot].
  ///
  /// Used to output the [BuildOutput.dependencies].
  final List<String> dartBuildFiles;

  /// The language standard to use.
  ///
  /// When set to `null`, the default behavior of the compiler will be used.
  final String? std;

  ConanBuilder.library({
    required this.name,
    this.assetName,
    this.includes = const [],
    this.preset,
    this.defines = const {},
    this.dartBuildFiles = const [],
    this.std,
  });

  @override
  Future<void> run({
    required BuildConfig buildConfig,
    required BuildOutput buildOutput,
    required Logger? logger,
  }) async {
    final outDir = buildConfig.outputDirectory;
    final packageRoot = buildConfig.packageRoot;
    await Directory.fromUri(outDir).create(recursive: true);
    final linkMode = _linkMode(buildConfig.linkModePreference);
    final targetOS = buildConfig.targetOS;
    // final libUri = outDir.resolve(buildConfig.targetOS.libraryFileName(name, linkMode));
    // final exeUri = outDir.resolve(buildConfig.targetOS.executableFileName(name));
    // final sources = packageRoot.resolveUri(Uri.file(source));
    // final includes = [
    //   for (final directory in this.includes) packageRoot.resolveUri(Uri.file(directory)),
    // ];
    // final dartBuildFiles = [
    //   for (final source in this.dartBuildFiles) packageRoot.resolve(source),
    // ];

    final errMsg = "OS: $targetOS, Architecture: ${buildConfig.targetArchitecture} not supported";
    final profile = switch (targetOS) {
      OS.windows => "",
      OS.linux => "",
      OS.macOS => "",
      OS.android => switch (buildConfig.targetArchitecture) {
          Architecture.arm => "profiles/android-armv8",
          Architecture.arm64 => "profiles/android-armv7",
          Architecture.x64 => "profiles/android-x86_64",
          null => buildConfig.dryRun ? "profiles/android-x86_64" : throw UnsupportedError(errMsg),
          _ => throw UnsupportedError(errMsg),
        },
      OS.iOS => switch (buildConfig.targetArchitecture) {
          Architecture.arm64 => "profiles/ios-armv8",
          Architecture.x64 => "profiles/ios-x86_64",
          null => buildConfig.dryRun ? "profiles/ios-x86_64" : throw UnsupportedError(errMsg),
          _ => throw UnsupportedError(errMsg),
        },
      _ => throw UnimplementedError(),
    };

    if (buildConfig.dryRun) {
      final result = await runProcess(
        executable: "conan",
        arguments: ["--version"],
        logger: logger,
      );
      assert(result.exitCode == 0, "Conan not installed");
    } else {
      if (targetOS == OS.iOS) {
        var profileStr = await File.fromUri(packageRoot.resolve(profile)).readAsString();
        final lines = profileStr.split("\n");
        final toolchainPath = p.normalize(packageRoot.resolve("profiles/ios.toolchain.cmake").toFilePath());
        const userToolchain = "tools.cmake.cmaketoolchain:user_toolchain";
        final newLines = lines.map(
          (e) => e.contains("=") && e.startsWith(userToolchain) ? '$userToolchain=["$toolchainPath"]' : e,
        );
        profileStr = newLines.join("\n");
        await File.fromUri(packageRoot.resolve(profile)).writeAsString(profileStr);
      }

      final profileOptions = targetOS == OS.android || targetOS == OS.iOS
          ? ["-pr:h", p.normalize("${packageRoot.toFilePath()}/$profile")]
          : <String>[];
      final ndkOptions = <String>[];
      if (targetOS == OS.android) {
        final ndkUri = buildConfig.cCompiler.compiler?.resolve("../../../../..");
        if (ndkUri == null) throw p.PathException("Android NDK not found!");
        ndkOptions.addAll(["-c", "tools.android:ndk_path=${p.normalize(ndkUri.toFilePath())}"]);
      }
      final stdOptions = targetOS == OS.windows ? ["-s", "compiler.cppstd=20"] : <String>[];
      final result = await runProcess(
        executable: "conan",
        arguments: [
          "build",
          p.normalize(packageRoot.toFilePath()),
          "-b",
          "missing",
          ...profileOptions,
          ...ndkOptions,
          ...stdOptions,
          "-o",
          "package_root=${p.normalize(packageRoot.toFilePath())}",
          "-o",
          "output_dir=${p.normalize(outDir.toFilePath())}",
        ],
        logger: logger,
        workingDirectory: outDir,
        captureOutput: false,
        throwOnUnexpectedExitCode: true,
      );
      assert(result.exitCode == 0);
    }

    final ext = switch (targetOS) {
      OS.windows => "dll",
      OS.linux => "so",
      OS.macOS => "dylib",
      OS.android => "so",
      OS.fuchsia => "so",
      OS.iOS => "framework",
      OS() => throw UnimplementedError(),
    };
    final installDir = Directory.fromUri(outDir.resolve("install"));
    if (!installDir.existsSync()) {
      installDir.createSync(recursive: true);
    }
    final libEntities = installDir.listSync();

    if (assetName != null) {
      final assets = <Asset>[];
      for (final entity in libEntities) {
        final fileName = p.basename(entity.path);
        Uri assetUri;
        // for windows, linux, android, the final lib is a file,
        // i.e., .dll, .so files
        if (entity is File && entity.path.endsWith(ext)) {
          assetUri = entity.uri;
        }
        // for ios, the final lib is .framework, i.e., a directory,
        else if (entity is Directory && targetOS == OS.iOS) {
          assetUri = entity.uri.resolve("opencv_dart");
        } else {
          continue;
        }
        assets.add(
          NativeCodeAsset(
            package: buildConfig.packageName,
            name: fileName.contains(buildConfig.packageName)
                ? assetName!
                : p.basenameWithoutExtension(fileName),
            file: assetUri,
            linkMode: linkMode,
            os: targetOS,
            architecture: buildConfig.dryRun ? null : buildConfig.targetArchitecture,
          ),
        );
      }
      buildOutput.addAssets(assets);
    }
    // if (!buildConfig.dryRun) {
    //   final includeFiles = await Stream.fromIterable(includes)
    //       .asyncExpand(
    //         (include) => Directory(include.toFilePath())
    //             .list(recursive: true)
    //             .where((entry) => entry is File)
    //             .map((file) => file.uri),
    //       )
    //       .toList();

    //   // buildOutput.addDependencies({
    //   //   // Note: We use a Set here to deduplicate the dependencies.
    //   //   // ...sources,
    //   //   ...includeFiles,
    //   //   ...dartBuildFiles,
    //   // });
    // }
  }
}

LinkMode _linkMode(LinkModePreference preference) {
  if (preference == LinkModePreference.dynamic || preference == LinkModePreference.preferDynamic) {
    return DynamicLoadingBundled();
  }
  assert(preference == LinkModePreference.static || preference == LinkModePreference.preferStatic);
  return StaticLinking();
}

/// Runs a [Process].
///
/// If [logger] is provided, stream stdout and stderr to it.
///
/// If [captureOutput], captures stdout and stderr.
Future<RunProcessResult> runProcess({
  required String executable,
  required Logger? logger,
  List<String> arguments = const [],
  Uri? workingDirectory,
  Map<String, String>? environment,
  bool includeParentEnvironment = true,
  bool captureOutput = true,
  int expectedExitCode = 0,
  bool throwOnUnexpectedExitCode = false,
}) async {
  if (Platform.isWindows && !includeParentEnvironment) {
    const winEnvKeys = [
      'SYSTEMROOT',
      'TEMP',
      'TMP',
    ];
    environment = {
      for (final winEnvKey in winEnvKeys) winEnvKey: Platform.environment[winEnvKey]!,
      ...?environment,
    };
  }

  final printWorkingDir = workingDirectory != null && workingDirectory != Directory.current.uri;
  final commandString = [
    if (printWorkingDir) '(cd ${workingDirectory.toFilePath()};',
    ...?environment?.entries.map((entry) => '${entry.key}=${entry.value}'),
    executable,
    ...arguments.map((a) => a.contains(' ') ? "'$a'" : a),
    if (printWorkingDir) ')',
  ].join(' ');
  logger?.info('Running `$commandString`.');

  final stdoutBuffer = StringBuffer();
  final stderrBuffer = StringBuffer();
  final process = await Process.start(
    executable,
    arguments,
    workingDirectory: workingDirectory?.toFilePath(),
    environment: environment,
    includeParentEnvironment: includeParentEnvironment,
    runInShell: Platform.isWindows && !includeParentEnvironment,
  );

  final stdoutSub = process.stdout.transform(utf8.decoder).transform(const LineSplitter()).listen(
        captureOutput
            ? (s) {
                logger?.fine(s);
                stdoutBuffer.writeln(s);
              }
            : logger?.fine,
      );
  final stderrSub = process.stderr.transform(utf8.decoder).transform(const LineSplitter()).listen(
        captureOutput
            ? (s) {
                logger?.severe(s);
                stderrBuffer.writeln(s);
              }
            : logger?.severe,
      );

  final (exitCode, _, _) =
      await (process.exitCode, stdoutSub.asFuture<void>(), stderrSub.asFuture<void>()).wait;
  final result = RunProcessResult(
    pid: process.pid,
    command: commandString,
    exitCode: exitCode,
    stdout: stdoutBuffer.toString(),
    stderr: stderrBuffer.toString(),
  );
  if (throwOnUnexpectedExitCode && expectedExitCode != exitCode) {
    throw ProcessException(
      executable,
      arguments,
      "Full command string: '$commandString'.\n"
      "Exit code: '$exitCode'.\n"
      'For the output of the process check the logger output.',
    );
  }
  await stdoutSub.cancel();
  await stderrSub.cancel();
  return result;
}

/// Drop in replacement of [ProcessResult].
class RunProcessResult {
  final int pid;

  final String command;

  final int exitCode;

  final String stderr;

  final String stdout;

  RunProcessResult({
    required this.pid,
    required this.command,
    required this.exitCode,
    required this.stderr,
    required this.stdout,
  });

  @override
  String toString() => '''
command: $command
exitCode: $exitCode
stdout: $stdout
stderr: $stderr''';
}
