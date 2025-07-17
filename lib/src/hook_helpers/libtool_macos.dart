// Copyright (c) 2024, the Dart project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed by a
// BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:logging/logging.dart';

Future<Map<Architecture?, List<String>>> getArchitectures(Uri dylib, {Logger? logger}) async {
  final otoolResult = await Process.run(
    'otool',
    [
      '-D',
      dylib.toFilePath(),
    ],
  );
  if (otoolResult.exitCode != 0) {
    throw Exception(
      'Failed to get install name for dylib $dylib: ${otoolResult.stderr}',
    );
  }
  final architectureSections = parseOtoolArchitectureSections(otoolResult.stdout as String, logger: logger);

  return architectureSections;
}

Map<Architecture?, List<String>> parseOtoolArchitectureSections(String output, {Logger? logger}) {
  // The output of `otool -D`, for example, looks like below. For each
  // architecture, there is a separate section.
  //
  // /build/native_assets/ios/buz.framework/buz (architecture x86_64):
  // @rpath/libbuz.dylib
  // /build/native_assets/ios/buz.framework/buz (architecture arm64):
  // @rpath/libbuz.dylib
  //
  // Some versions of `otool` don't print the architecture name if the
  // binary only has one architecture:
  //
  // /build/native_assets/ios/buz.framework/buz:
  // @rpath/libbuz.dylib

  const Map<String, Architecture> outputArchitectures = <String, Architecture>{
    'arm': Architecture.arm,
    'arm64': Architecture.arm64,
    'x86_64': Architecture.x64,
  };
  final RegExp architectureHeaderPattern = RegExp(r'^[^(]+( \(architecture (.+)\))?:$');
  final Iterator<String> lines = output.trim().split('\n').iterator;
  Architecture? currentArchitecture;
  final Map<Architecture?, List<String>> architectureSections = <Architecture?, List<String>>{};

  while (lines.moveNext()) {
    final String line = lines.current;
    final Match? architectureHeader = architectureHeaderPattern.firstMatch(line);
    if (architectureHeader != null) {
      if (architectureSections.containsKey(null)) {
        throw Exception(
          'Expected a single architecture section in otool output: $output',
        );
      }
      final String? architectureString = architectureHeader.group(2);
      if (architectureString != null) {
        currentArchitecture = outputArchitectures[architectureString];
        if (currentArchitecture == null) {
          throw Exception(
            'Unknown architecture in otool output: $architectureString',
          );
        }
      }
      architectureSections[currentArchitecture] = <String>[];
      continue;
    } else {
      architectureSections[currentArchitecture]!.add(line.trim());
    }
  }

  return architectureSections;
}

Future<void> splitDylibArchitectures(Uri dylib, Architecture arch, Uri output) async {
  final libtoolResult = await Process.run(
    'lipo',
    [
      dylib.toFilePath(),
      '-thin',
      arch.name,
      '-output',
      output.toFilePath(),
    ],
  );

  if (libtoolResult.exitCode != 0) {
    throw Exception(
      'Failed to extract $arch architecture from $dylib: ${libtoolResult.stderr}',
    );
  }
}
