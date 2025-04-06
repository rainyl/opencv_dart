// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:native_assets_cli/code_assets_builder.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';
import 'package:yaml/yaml.dart';

import 'parse_user_defines.dart';

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {List<String>? optionalModules}) async {
  final packagePath = Directory(await getPackagePath('dartcv4'));
  final logger = Logger('')
    ..level = Level.ALL
    // ..onRecord.listen((record) => print(record.message));
    ..onRecord.listen((record) => stderr.write(record.message));

  // final userDefines = input.userDefines;
  final userDefines = await parseUserDefines(
    File.fromUri(packagePath.uri.resolve('pubspec.yaml')),
    'dartcv4',
    logger: logger,
  );
  logger.info(userDefines);
  // {include_modules: [calib3d, contrib, dnn, features2d, highgui, imgcodecs, imgproc, objdetect, photo, stitching, video, videoio]}

  optionalModules ??= [];
  if (userDefines.containsKey('include_modules')) {
    final moduels = userDefines['include_modules'] as YamlList?;
    if (moduels != null) {
      optionalModules.addAll(moduels.cast<String>());
    }
  }

  final moduleDefines = {
    'DARTCV_WITH_CALIB3D': optionalModules.contains('calib3d') ? 'ON' : 'OFF',
    'DARTCV_WITH_CONTRIB': optionalModules.contains('contrib') ? 'ON' : 'OFF',
    'DARTCV_WITH_DNN': optionalModules.contains('dnn') ? 'ON' : 'OFF',
    'DARTCV_WITH_FEATURES2D': optionalModules.contains('features2d') ? 'ON' : 'OFF',
    'DARTCV_WITH_HIGHGUI': optionalModules.contains('highgui') ? 'ON' : 'OFF',
    // 'DARTCV_WITH_IMGCODECS': optionalModules.contains('imgcodecs')? 'ON' : 'OFF',
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
}
