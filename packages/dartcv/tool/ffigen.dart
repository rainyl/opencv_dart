// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

// Regenerates all OpenCV FFI bindings through the ffigen Dart API.
//
// ffigen's per-module settings stay in `ffigen/*.yaml` (the source of truth);
// this script loads each config via `YamlConfig`, rebuilds the `FfiGenerator`
// copying every field, and overrides two things the YAML format cannot express:
//   * a `Visitor` setting `Func.recordUse` on every function - emits
//     `@RecordUse()` on each `@ffi.Native` declaration (the compiler records
//     which native symbols the final program uses, feeding the tree-shaking
//     keep-list `hook/link.dart` links with),
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
  'ml': 'ml',
  'objdetect': 'objdetect',
  'photo': 'photo',
  'stitching': 'stitching',
  'video': 'video',
  'videoio': 'videoio',
};

/// Emits `@RecordUse()` on every generated function; the compiler then records the native symbols
/// the final program reaches, which is what the tree-shaking keep-list is built from.
final ffigen.Visitor _recordUseVisitor = ffigen.Visitor(func: (node) => node.recordUse = true);

/// Rebuilds [y] (the YAML-derived generator) with [_recordUseVisitor] appended and the record-use
/// mapping output set. `FfiGenerator` has no `copyWith`, so every field is carried over by hand.
ffigen.FfiGenerator _withRecordUse(ffigen.FfiGenerator y, Directory outDir) {
  final baseName = y.output.dart.path.pathSegments.last.replaceAll('.g.dart', '');
  return ffigen.FfiGenerator(
    input: y.input,
    // ignore: experimental_member_use
    cpp: y.cpp,
    objectiveC: y.objectiveC,
    output: ffigen.Output(
      dart: y.output.dart,
      objectiveCFile: y.output.objectiveCFile,
      cppFile: y.output.cppFile,
      symbolFile: y.output.symbolFile,
      commentType: y.output.commentType,
      preamble: y.output.preamble,
      format: y.output.format,
      style: y.output.style,
      recordUseMapping: File(
        '${outDir.path}/$baseName.record_use_mapping.g.dart',
      ).absolute.uri,
    ),
    // The YAML config's own visitors (include filters, renames, leaf, ...) must keep running, in
    // order; ffigen applies them sequentially.
    visitors: [...y.visitors, _recordUseVisitor],
    importType: y.importType,
    // `libclangDylib` is deliberately not copied over: it is deprecated, only there for YAML
    // plumbing, and no `ffigen/*.yaml` sets `llvm-path`; `generate` finds libclang itself.
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
    await gen.generate(logger: logger);
    print('generated ${outDir.path}/$name.g.dart');
  }
}
