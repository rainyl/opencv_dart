// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

import 'dart:io';

import 'package:logging/logging.dart';
import 'package:native_assets_cli/code_assets_builder.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {List<String>? optionalModules}) async {
  final packagePath = Directory(await getPackagePath('opencv_dart'));
  final logger = Logger('')
    ..level = Level.ALL
    ..onRecord.listen((record) => print(record.message));

  final builder = CMakeBuilder.create(
    name: input.packageName,
    sourceDir: packagePath.uri.resolve("src"),
    targets: ['install'],
    // Waiting for the support of user-defined variables,
    // which can be used to choose the components
    defines: {
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install/').toFilePath(),
    },
  );
  await builder.run(input: input, output: output, logger: logger);

  await output.findAndAddCodeAssets(
    input,
    outDir: input.outputDirectory.resolve('install/'),
    names: {'dartcv': 'dartcv.dart'},
  );
}
