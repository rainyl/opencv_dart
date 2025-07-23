// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

import 'patchelf_linux.dart';

const allowedModules = {
  'calib3d',
  'contrib',
  'dnn',
  'features2d',
  'highgui',
  'imgcodecs',
  'imgproc',
  'objdetect',
  'photo',
  'stitching',
  'video',
  'videoio',
};

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {Set<String>? optionalModules}) async {
  final packagePath = Directory(await getPackagePath('dartcv4'));
  final logger = Logger('')
    ..level = Level.ALL
    // ..onRecord.listen((record) => print(record.message));
    ..onRecord.listen((record) => stderr.write(record.message));

  optionalModules ??= allowedModules.toSet();
  final userDefines = input.userDefines;
  final includeModules = userDefines["include_modules"] as List?;
  final excludeModules = userDefines["exclude_modules"] as List?;

  // do not trust user input, filter the modules
  final includeModulesFiltered = includeModules?.where(allowedModules.contains).toList();
  final excludeModulesFiltered = excludeModules?.where(allowedModules.contains).toList();

  if (includeModulesFiltered != null) {
    optionalModules.addAll(includeModulesFiltered.cast<String>());
  }
  if (excludeModulesFiltered != null) {
    optionalModules.removeWhere(excludeModulesFiltered.contains);
  }
  logger.info("[dartcv4] include modules: $includeModulesFiltered\n");
  logger.info("[dartcv4] exclude modules: $excludeModulesFiltered\n");
  logger.info("[dartcv4] merged modules: $optionalModules\n");

  final moduleDefines = {
    'DARTCV_WITH_CALIB3D': optionalModules.contains('calib3d') ? 'ON' : 'OFF',
    'DARTCV_WITH_CONTRIB': optionalModules.contains('contrib') ? 'ON' : 'OFF',
    'DARTCV_WITH_DNN': optionalModules.contains('dnn') ? 'ON' : 'OFF',
    'DARTCV_WITH_FEATURES2D': optionalModules.contains('features2d') ? 'ON' : 'OFF',
    'DARTCV_WITH_HIGHGUI': optionalModules.contains('highgui') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGCODECS': optionalModules.contains('imgcodecs') ? 'ON' : 'OFF',
    'DARTCV_WITH_IMGPROC': optionalModules.contains('imgproc') ? 'ON' : 'OFF',
    'DARTCV_WITH_OBJDETECT': optionalModules.contains('objdetect') ? 'ON' : 'OFF',
    'DARTCV_WITH_PHOTO': optionalModules.contains('photo') ? 'ON' : 'OFF',
    'DARTCV_WITH_STITCHING': optionalModules.contains('stitching') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEO': optionalModules.contains('video') ? 'ON' : 'OFF',
    'DARTCV_WITH_VIDEOIO': optionalModules.contains('videoio') ? 'ON' : 'OFF',
  };

  final builder = CMakeBuilder.create(
    logLevel: LogLevel.DEBUG,
    name: input.packageName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    buildLocal: true,
    defines: {
      'FFMPEG_USE_STATIC_LIBS': 'OFF',
      'DARTCV_ENABLE_INSTALL': 'ON',
      'DARTCV_WORLD': 'OFF',
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install/').toFilePath(),
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
  if (optionalModules.contains('highgui') || optionalModules.contains('videoio')) {
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

    final libFiles = r.map((e) => e.file!.toFilePath()).toList();
    logger.info("adding FFMPEG libraries: $libFiles");
  }
}
