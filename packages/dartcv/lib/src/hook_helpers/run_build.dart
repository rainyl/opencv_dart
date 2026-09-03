// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

import 'patchelf_linux.dart';

const defaultIncludedModules = {
  'imgcodecs',
  'imgproc',
};

// large modules are disabled by default
const defaultExcludedModules = {
  'calib3d',
  'dnn',
  'features2d',
  'flann',
  'freetype',
  'highgui',
  'objdetect',
  'photo',
  'stitching',
  'video',
  'videoio',
  'aruco',
  'img_hash',
  'quality',
  'wechat_qrcode',
  'ximgproc',
  'xobjdetect',
};

const allowedModules = {
  ...defaultIncludedModules,
  ...defaultExcludedModules,
};

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {Set<String>? optionalModules}) async {
  // Consumers can set `hooks.user_defines.dartcv4.skip_build: true` in their pubspec.yaml
  // to skip the native build entirely (e.g. for unit test runs that never call into
  // dartcv4's native code, where compiling/downloading OpenCV is pure CI overhead).
  if (input.userDefines['skip_build'] == true) {
    return;
  }

  // Check if code assets are expected (not for web builds).
  // Web builds use WASM/JS interop, not native code assets.
  if (!input.config.buildCodeAssets) {
    return;
  }

  final packagePath = Directory(await getPackagePath('dartcv4'));
  final modules = optionalModules ?? {...defaultIncludedModules};
  final userDefines = input.userDefines;
  final debugMode = userDefines["debug"] as bool? ?? false;
  final parallelJobs = userDefines["parallel_jobs"] as int? ?? Platform.numberOfProcessors;
  final includeModules = userDefines["include_modules"] as List?;
  final excludeModules = userDefines["exclude_modules"] as List?;
  // Which OpenCV to build against.
  //
  // `opencv_version` builds that upstream tag from source instead of the
  // version this package pins, for consumers who need their results to match
  // another environment running a specific OpenCV. `opencv_dir` points at an
  // OpenCV that is already built — it wins over `opencv_version`, and may also
  // be given per platform, since a cross-compiled OpenCV lives in a different
  // place for each target.
  final opencvVersion = userDefines["opencv_version"] as String?;
  final platformDefines = {
    OS.windows: userDefines["windows"] as Map<String, dynamic>?,
    OS.linux: userDefines["linux"] as Map<String, dynamic>?,
    OS.macOS: userDefines["macos"] as Map<String, dynamic>?,
    OS.android: userDefines["android"] as Map<String, dynamic>?,
    OS.iOS: userDefines["ios"] as Map<String, dynamic>?,
  };
  final targetOS = input.config.code.targetOS;
  // Whether to build OpenCV with OpenCL support for the target platform.
  // NOTE: with OpenCL enabled, the OpenCV runtime may hang at process exit (race condition in OpenCL teardown).
  // Reads `use_opencl` from the platform-specific user defines
  // (e.g. `hooks.user_defines.dartcv4.windows.use_opencl` in pubspec.yaml).
  // Defaults to false when unspecified; always false on iOS (not supported).
  final opencvDir = (platformDefines[targetOS]?['opencv_dir'] ?? userDefines['opencv_dir']) as String?;
  final useOpenCL = targetOS != OS.iOS && (platformDefines[targetOS]?['use_opencl'] as bool? ?? false);

  // Whether to enable linker dead-code elimination (`DARTCV_TREESHAKE`).
  final treeshake = userDefines["treeshake"] as bool? ?? false;
  // Optional keep-list of exported dartcv symbols, normally produced by
  // `hook/link.dart` from the recorded `@ffi.Native` usages (AOT builds).
  // When present, CMake restricts the DLL exports to these symbols and strips
  // everything unreachable from them. The file lives in the shared
  // `hooks_runner/shared/<package>/` directory (checksum-independent) so both
  // this build hook and the link hook can find it across build passes.
  final keepFileUri = input.outputDirectory.resolve('../../dartcv_keep.txt');
  final keepFile = File.fromUri(keepFileUri).existsSync() ? keepFileUri.toFilePath() : null;

  final logger = Logger('')
    ..level = Level.ALL
    ..onRecord.listen((record) => debugMode ? stderr.write(record.message) : print(record.message));
  logger.info("[dartcv4] use_opencl: $useOpenCL\n");
  logger.info("[dartcv4] treeshake: $treeshake keep_file: ${keepFile ?? 'none'}\n");

  final includeList = (includeModules ?? const []).cast<String>();
  final excludeList = (excludeModules ?? const []).cast<String>();

  final includeModulesFiltered = includeList.where(allowedModules.contains).toSet();
  final excludeModulesFiltered = excludeList.where(allowedModules.contains).toSet();

  if (includeModulesFiltered.isNotEmpty) {
    modules
      ..clear()
      ..addAll(includeModulesFiltered);
  }
  if (excludeModulesFiltered.isNotEmpty) {
    modules.removeAll(excludeModulesFiltered);
  }
  logger.info("[dartcv4] include modules: $includeModulesFiltered\n");
  logger.info("[dartcv4] exclude modules: $excludeModulesFiltered\n");
  logger.info("[dartcv4] merged modules: $modules\n");
  logger.info("[dartcv4] platform defines: $platformDefines\n");
  if (opencvDir != null) {
    logger.info("[dartcv4] using the OpenCV in: $opencvDir\n");
  } else if (opencvVersion != null) {
    logger.info("[dartcv4] building OpenCV $opencvVersion from source\n");
  }

  final moduleDefines = {
    'DARTCV_WITH_CALIB3D': modules.contains('calib3d') ? 'ON' : 'OFF',
    'DARTCV_WITH_DNN': modules.contains('dnn') ? 'ON' : 'OFF',
    'DARTCV_WITH_FEATURES2D': modules.contains('features2d') ? 'ON' : 'OFF',
    'DARTCV_WITH_FLANN': modules.contains('flann') ? 'ON' : 'OFF',
    'DARTCV_WITH_FREETYPE': modules.contains('freetype') ? 'ON' : 'OFF',
    'DARTCV_WITH_HIGHGUI': modules.contains('highgui') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGCODECS': modules.contains('imgcodecs') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGPROC': modules.contains('imgproc') ? 'ON' : 'OFF',
    'DARTCV_WITH_OBJDETECT': modules.contains('objdetect') ? 'ON' : 'OFF',
    'DARTCV_WITH_PHOTO': modules.contains('photo') ? 'ON' : 'OFF',
    'DARTCV_WITH_STITCHING': modules.contains('stitching') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEO': modules.contains('video') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEOIO': modules.contains('videoio') ? 'ON' : 'OFF',
    // Contrib modules
    'DARTCV_WITH_ARUCO': modules.contains('aruco') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMG_HASH': modules.contains('img_hash') ? 'ON' : 'OFF',
    'DARTCV_WITH_QUALITY': modules.contains('quality') ? 'ON' : 'OFF',
    'DARTCV_WITH_WECHAT_QRCODE': modules.contains('wechat_qrcode') ? 'ON' : 'OFF',
    'DARTCV_WITH_XIMGPROC': modules.contains('ximgproc') ? 'ON' : 'OFF',
    'DARTCV_WITH_XOBJDETECT': modules.contains('xobjdetect') ? 'ON' : 'OFF',
  };

  final generator = _getGenerator(targetOS, platformDefines);
  logger.warning('Using generator: ${generator.name}');

  final builder = CMakeBuilder.create(
    logLevel: debugMode ? LogLevel.DEBUG : LogLevel.STATUS,
    appleArgs: const AppleBuilderArgs(enableArc: false, enableBitcode: false, enableVisibility: true),
    name: input.packageName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    buildLocal: false,
    generator: generator,
    parallelJobs: parallelJobs,
    defines: {
      if (targetOS == OS.macOS) 'DEPLOYMENT_TARGET': '10.15',
      if (targetOS == OS.iOS) 'DEPLOYMENT_TARGET': '12.0',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_OPENJPEG': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENJPEG': 'OFF',
      'WITH_OPENCL': useOpenCL ? 'ON' : 'OFF',
      if (useOpenCL && targetOS == OS.macOS) 'WITH_OPENCLAMDBLAS': 'ON',
      if (useOpenCL && targetOS == OS.macOS) 'WITH_OPENCLAMDFFT': 'ON',
      if (!useOpenCL) 'WITH_OPENCLAMDBLAS': 'OFF',
      if (!useOpenCL) 'WITH_OPENCLAMDFFT': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENCL_SVM': 'OFF',
      // 'FFMPEG_USE_STATIC_LIBS': 'OFF',
      if (opencvDir != null) ...{
        'DARTCV_BUILD_OPENCV_FROM_SOURCE': 'OFF',
        'DARTCV_DISABLE_DOWNLOAD_OPENCV': 'ON',
        'OpenCV_DIR': opencvDir,
      } else if (opencvVersion != null) ...{
        'DARTCV_BUILD_OPENCV_FROM_SOURCE': 'ON',
        'OPENCV_VERSION': opencvVersion,
      },
      'DARTCV_ENABLE_INSTALL': 'ON',
      'DARTCV_TREESHAKE': treeshake ? 'ON' : 'OFF',
      if (keepFile != null) 'DARTCV_KEEP_FILE': keepFile,
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install/').toFilePath(),
      'CMAKE_POLICY_VERSION_MINIMUM': '3.5',
      ...moduleDefines,
    },
  );
  await builder.run(input: input, output: output, logger: logger);

  await output.findAndAddCodeAssets(
    input,
    outDir: input.outputDirectory.resolve('install/'),
    names: {'dartcv': 'dartcv.dart'},
  );

  final ffmpegLibs = {"avcodec", "avdevice", "avfilter", "avformat", "avutil", "swresample", "swscale"};
  String ffPattern(String lib) => '(?:lib)?$lib(?:.\\d+)?(?:\\.(?:so|dll|dylib))';
  if (modules.contains('highgui') || modules.contains('videoio')) {
    final r = await output.findAndAddCodeAssets(
      input,
      outDir: input.outputDirectory.resolve('install/'),
      names: {for (final lib in ffmpegLibs) ffPattern(lib): "$lib.dart"},
      regExp: true,
    );

    if (input.config.code.targetOS == OS.linux) {
      for (final lib in r) {
        await setRPath(lib.file!, name: r'$ORIGIN');
      }
    }

    // TODO: dartdev does not support adding FAT libraries yet.
    // https://github.com/dart-lang/sdk/issues/61130

    if (r.isEmpty) {
      logger.warning("FFMPEG libraries not found, please check your build configuration.");
    } else {
      final libFiles = r.map((e) => e.file!.toFilePath()).toList();
      logger.info("adding FFMPEG libraries: $libFiles");
    }
  }
}

Generator _getGenerator(OS targetOS, Map<OS, Map<String, dynamic>?> platformDefines) {
  if (platformDefines[targetOS] == null || platformDefines[targetOS]?['generator'] == null) {
    return switch (targetOS) {
      OS.linux => Generator.make,
      OS.macOS || OS.iOS => Generator.xcode,
      OS.windows => Generator.defaultGenerator,
      OS.android => Generator.ninja,
      _ => throw ArgumentError.value(targetOS, 'targetOS', 'Unsupported target OS'),
    };
  }
  final generatorName = platformDefines[targetOS]!['generator'] as String;
  return switch (generatorName) {
    'Ninja' => Generator.ninja,
    'Unix Makefiles' => Generator.make,
    'Xcode' => Generator.xcode,
    'Visual Studio 16 2019' => Generator.vs2019,
    'Visual Studio 17 2022' => Generator.vs2022,
    'Visual Studio 18 2026' => Generator.vs2026,
    _ => throw ArgumentError.value(generatorName, 'generator', 'Unsupported generator'),
  };
}
