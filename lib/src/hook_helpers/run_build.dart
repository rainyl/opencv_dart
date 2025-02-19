// Copyright (c) 2025, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'package:logging/logging.dart';
import 'package:native_assets_cli/code_assets_builder.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

Future<void> runBuild(BuildInput input, BuildOutputBuilder output, {List<String>? optionalModules}) async {
  final builder = CMakeBuilder.create(
    name: input.packageName,
    sourceDir: input.packageRoot.resolve('src').toFilePath(),
    targets: ['install'],
    // Waiting for the support of user-defined variables,
    // which can be used to choose the components
    defines: {
      'CMAKE_INSTALL_PREFIX': input.outputDirectory.resolve('install').toFilePath(),
    },
  );
  await builder.run(
    input: input,
    output: output,
    logger: Logger('')
      ..level = Level.ALL
      ..onRecord.listen((record) => print(record.message)),
  );

  final tgtName = input.config.code.targetOS.dylibFileName(input.packageName);

  output.assets.code.addAll(
    [
      CodeAsset(
        package: input.packageName,
        name: "${input.packageName}.dart",
        file: Uri.parse('${input.outputDirectory.resolve('install/$tgtName')}'),
        linkMode: DynamicLoadingBundled(),
        os: input.config.code.targetOS,
        architecture: input.config.code.targetArchitecture,
      ),
    ],
  );
}
