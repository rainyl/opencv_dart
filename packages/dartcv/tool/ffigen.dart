// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

// Regenerates all OpenCV FFI bindings through the ffigen Dart API.
//
// ffigen's per-module settings stay in `ffigen/*.yaml` (the source of truth);
// this script loads each config via `YamlConfig`, rebuilds the `FfiGenerator`
// copying every field, and overrides two things the YAML format cannot express:
//   * `Functions.recordUse: (_) => true` - emits `@RecordUse()` on every
//     `@ffi.Native` function (the compiler records which native symbols the
//     final program uses, feeding the `dartcv_keep.txt` tree-shaking keep-list),
//   * `Output.recordUseMapping` - ffigen writes the
//     `<module>.record_use_mapping.g.dart` name-to-symbol tables directly
//     (read by `hook/link.dart`).
//
// Usage (from packages/dartcv):
//   dart tool/ffigen.dart

import 'dart:io';

import 'package:ffigen/ffigen.dart' as ffigen;
import 'package:logging/logging.dart';
import 'package:package_config/package_config.dart';

const _modules = <String, String>{
  'types': 'types',
  'constants': 'const',
  'core': 'core',
  'calib3d': 'calib3d',
  'contrib': 'contrib',
  'dnn': 'dnn',
  'features2d': 'features2d',
  'gapi': 'gapi',
  'highgui': 'highgui',
  'imgcodecs': 'imgcodecs',
  'imgproc': 'imgproc',
  'objdetect': 'objdetect',
  'photo': 'photo',
  'stitching': 'stitching',
  'video': 'video',
  'videoio': 'videoio',
};

/// Rebuilds [y] (the YAML-derived config) with `@RecordUse()` enabled and the
/// record-use mapping output set.
ffigen.FfiGenerator _withRecordUse(ffigen.FfiGenerator y, Directory outDir) {
  final fns = y.functions;
  final baseName = y.output.dartFile.pathSegments.last.replaceAll('.g.dart', '');
  return ffigen.FfiGenerator(
    output: ffigen.Output(
      dartFile: y.output.dartFile,
      objectiveCFile: y.output.objectiveCFile,
      cppFile: y.output.cppFile,
      symbolFile: y.output.symbolFile,
      recordUseMapping: File(
        '${outDir.path}/$baseName.record_use_mapping.g.dart',
      ).absolute.uri,
      commentType: y.output.commentType,
      preamble: y.output.preamble,
      format: y.output.format,
      style: y.output.style,
    ),
    headers: y.headers,
    functions: ffigen.Functions(
      include: fns.include,
      includeSymbolAddress: fns.includeSymbolAddress,
      rename: fns.rename,
      renameMember: fns.renameMember,
      includeTypedef: fns.includeTypedef,
      isLeaf: fns.isLeaf,
      recordUse: (_) => true,
      varArgs: fns.varArgs,
    ),
    structs: y.structs,
    unions: y.unions,
    enums: y.enums,
    macros: y.macros,
    globals: y.globals,
    typedefs: y.typedefs,
    integers: y.integers,
    unnamedEnums: y.unnamedEnums,
    cpp: y.cpp,
    objectiveC: y.objectiveC,
    // ignore: deprecated_member_use
    libraryImports: y.libraryImports,
    // ignore: deprecated_member_use
    importedTypesByUsr: y.importedTypesByUsr,
    // ignore: deprecated_member_use
    libclangDylib: y.libclangDylib,
  );
}

Future<void> main(List<String> args) async {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.INFO;

  final packageConfig = await findPackageConfig(Directory.current);
  final outDir = Directory('lib/src/g');

  for (final entry in _modules.entries) {
    final name = entry.key;
    final logger = Logger('ffigen.$name');
    final config = ffigen.YamlConfig.fromFile(
      File('ffigen/ffigen_${entry.value}.yaml'),
      logger,
      packageConfig: packageConfig,
    );
    final gen = _withRecordUse(config.configAdapter(), outDir);
    gen.generate(logger: logger);
    print('generated ${outDir.path}/$name.g.dart');
  }
}
