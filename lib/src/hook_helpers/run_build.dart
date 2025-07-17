// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:dartcv4/src/hook_helpers/libtool_macos.dart';
import 'package:hooks/hooks.dart';
import 'package:logging/logging.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {List<String>? optionalModules}) async {
  final packagePath = Directory(await getPackagePath('dartcv4'));
  final logger = Logger('')
    ..level = Level.ALL
    // ..onRecord.listen((record) => print(record.message));
    ..onRecord.listen((record) => stderr.write(record.message));

  optionalModules ??= [];
  final userDefines = input.userDefines;
  final includeModules = userDefines["include_modules"] as List?;
  final excludeModules = userDefines["exclude_modules"] as List?;
  if (includeModules != null) {
    optionalModules.addAll(includeModules.cast<String>());
  }
  if (excludeModules != null) {
    optionalModules.removeWhere(excludeModules.contains);
  }
  logger.info("[dartcv4] include modules: $includeModules\n");
  logger.info("[dartcv4] exclude modules: $excludeModules\n");
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
    name: input.packageName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    buildLocal: true,
    // Waiting for the support of user-defined variables,
    // which can be used to choose the components
    defines: {
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
  if (optionalModules.contains('highgui') || optionalModules.contains('videoio')) {
    for (final lib in ffmpegLibs) {
      final r = await output.findAndAddCodeAssets(
        input,
        outDir: input.outputDirectory.resolve('install/'),
        names: {'lib$lib\\.\\d+\\.(so|dll|dylib)': "$lib.dart"},
        regExp: true,
      );

      // TODO: dartdev does not support adding FAT libraries yet.
      // https://github.com/dart-lang/sdk/issues/61130

      // final libFile = r.first.file!;
      // final targetArch = input.config.code.targetArchitecture;

      // final archs = await getArchitectures(libFile, logger: logger);

      // if (archs.keys.length > 1) {
      //   logger.info('$lib has multiple architectures, thining and overriting with $targetArch');
      //   await splitDylibArchitectures(libFile, targetArch, libFile);
      // }
    }
  }
}
