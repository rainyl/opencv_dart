// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';
import 'package:native_toolchain_cmake/src/native_toolchain/msvc.dart';

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
  final packagePath = Directory(await getPackagePath('dartcv4'));
  final modules = optionalModules ?? {...defaultIncludedModules};
  final userDefines = input.userDefines;
  final debugMode = userDefines["debug"] as bool? ?? false;
  final includeModules = userDefines["include_modules"] as List?;
  final excludeModules = userDefines["exclude_modules"] as List?;
  final targetOS = input.config.code.targetOS;

  final logger = Logger('')
    ..level = Level.ALL
    ..onRecord.listen((record) => debugMode ? stderr.write(record.message) : print(record.message));

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

  var winGenerator = Generator.defaultGenerator;
  if (input.config.code.targetOS == OS.windows) {
    final tools = await visualStudio.defaultResolver?.resolve(logger: logger);
    if (tools == null) {
      throw StateError('Failed to resolve Visual Studio tools');
    }
    for (final tool in tools) {
      if (tool.version?.major == 16) {
        winGenerator = Generator.vs2019;
      } else if (tool.version?.major == 17) {
        winGenerator = Generator.vs2022;
      } else {
        logger.warning(
          'Skip Visual Studio version: ${tool.version}, '
          'Currently on Visual Studio 2019 or 2022 is supported.',
        );
      }
    }
  }

  final generator = switch (targetOS) {
    OS.linux => Generator.make,
    OS.macOS || OS.iOS => Generator.xcode,
    OS.windows => winGenerator,
    OS.android => Generator.ninja,
    _ => throw ArgumentError.value(targetOS, 'targetOS', 'Unsupported target OS'),
  };
  logger.warning('Using generator: ${generator.name}');

  final builder = CMakeBuilder.create(
    logLevel: debugMode ? LogLevel.DEBUG : LogLevel.STATUS,
    appleArgs: const AppleBuilderArgs(enableArc: false, enableBitcode: false, enableVisibility: true),
    name: input.packageName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    buildLocal: false,
    generator: generator,
    defines: {
      if (targetOS == OS.macOS) 'DEPLOYMENT_TARGET': '10.15',
      if (targetOS == OS.iOS) 'DEPLOYMENT_TARGET': '12.0',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_TIFF': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'BUILD_OPENJPEG': 'OFF',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENJPEG': 'OFF',
      if (targetOS == OS.iOS) 'WITH_OPENCL': 'OFF',
      if (targetOS == OS.iOS) 'WITH_OPENCLAMDBLAS': 'OFF',
      if (targetOS == OS.iOS) 'WITH_OPENCLAMDFFT': 'OFF',
      if (targetOS == OS.macOS) 'WITH_OPENCL': 'ON',
      if (targetOS == OS.macOS) 'WITH_OPENCLAMDBLAS': 'ON',
      if (targetOS == OS.macOS) 'WITH_OPENCLAMDFFT': 'ON',
      if (targetOS == OS.iOS || targetOS == OS.macOS) 'WITH_OPENCL_SVM': 'OFF',
      // 'FFMPEG_USE_STATIC_LIBS': 'OFF',
      'DARTCV_ENABLE_INSTALL': 'ON',
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
