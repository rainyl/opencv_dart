// Copyright (c) 2025, rainyl. All rights reserved. Use of this source code is governed by a
// Apache-2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

// ignore: unused_import
import 'dart:io';

import 'package:dartcv4/src/hook_helpers/parse_user_define.dart';
import 'package:logging/logging.dart';
import 'package:native_assets_cli/native_assets_cli.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

void main(List<String> args) async {
  await build(args, _builder);
}

Future<void> _builder(BuildInput input, BuildOutputBuilder output) async {
  final packageName = input.packageName;
  final packagePath = Uri.directory(await getPackagePath(packageName));
  final sourceDir = packagePath.resolve('src/');
  // final outDir = Uri.directory(packagePath).resolve('build/');
  final logger =
      Logger("")
        ..level = Level.ALL
        ..onRecord.listen((record) => stderr.writeln(record.message));
  // ..onRecord.listen((record) => print(record.message));

  final exModsDefault = parseUserDefinedExcludeModules(packagePath.resolve("pubspec.yaml").toFilePath());
  final exModsUser = parseUserDefinedExcludeModules(
    Platform.script.resolve('../../../../pubspec.yaml').toFilePath(),
  );
  final exModsFinal = exModsDefault + exModsUser;

  logger.info("default exclude modules: $exModsDefault");
  logger.info("user exclude modules: $exModsUser");
  logger.info("final exclude modules: $exModsFinal");

  final builder = CMakeBuilder.create(
    name: packageName,
    sourceDir: sourceDir,
    // outDir: outDir,
    generator: Generator.ninja,
    targets: ['install'],
    defines: {
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install').toFilePath(),
      'DARTCV_WITH_CALIB3D': exModsFinal.contains('calib3d') ? "OFF" : "ON",
      'DARTCV_WITH_CONTRIB': exModsFinal.contains('contrib') ? "OFF" : "ON",
      'DARTCV_WITH_DNN': exModsFinal.contains('dnn') ? "OFF" : "ON",
      'DARTCV_WITH_FEATURES2D': exModsFinal.contains('features2d') ? "OFF" : "ON",
      'DARTCV_WITH_FLANN': exModsFinal.contains('flann') ? "OFF" : "ON",
      'DARTCV_WITH_HIGHGUI': exModsFinal.contains('highgui') ? "OFF" : "ON",
      'DARTCV_WITH_IMGPROC': exModsFinal.contains('imgproc') ? "OFF" : "ON",
      'DARTCV_WITH_IMGCODECS': exModsFinal.contains('imgcodecs') ? "OFF" : "ON",
      'DARTCV_WITH_OBJDETECT': exModsFinal.contains('objdetect') ? "OFF" : "ON",
      'DARTCV_WITH_PHOTO': exModsFinal.contains('photo') ? "OFF" : "ON",
      'DARTCV_WITH_STITCHING': exModsFinal.contains('stitching') ? "OFF" : "ON",
      'DARTCV_WITH_VIDEO': exModsFinal.contains('video') ? "OFF" : "ON",
      'DARTCV_WITH_VIDEOIO': exModsFinal.contains('videoio') ? "OFF" : "ON",
    },
    buildLocal: true,
  );

  await builder.run(input: input, output: output, logger: logger);

  await output.findAndAddCodeAssets(
    input,
    outDir: input.outputDirectory.resolve('install'),
    names: {"dartcv": "dartcv.dart"},
  );
}
