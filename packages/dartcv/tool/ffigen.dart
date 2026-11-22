// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print

// Regenerates all OpenCV FFI bindings through the ffigen Dart API.
//
// ffigen's per-module settings stay in `ffigen/*.yaml` (the source of truth); this script loads
// each config via `YamlConfig`, which turns it into an `FfiGenerator`, and adds the two things the
// YAML format cannot express:
//   * a `Visitor` setting `Func.recordUse` on every function, which emits `@RecordUse()` on the
//     generated `@ffi.Native` declarations (the compiler then records which native symbols the
//     final program uses, feeding the `dartcv_keep.txt` tree-shaking keep-list),
//   * `Output.recordUseMapping`, which makes ffigen write the
//     `<module>.record_use_mapping.g.dart` name-to-symbol tables directly (read by
//     `hook/link.dart`).
//
// The web mirror in `lib/src/web/g` is regenerated at the end by `tool/web/gen_web_bindings.dart`
// (a separate library, also runnable on its own), so one command refreshes both:
//
// Usage (from packages/dartcv):
//   dart tool/ffigen.dart              # every module, in dependency order, then lib/src/web/g
//   dart tool/ffigen.dart types ml     # just these (regenerate the module list order yourself)
//   dart tool/ffigen.dart --no-web     # native bindings only

import 'dart:io';

import 'package:ffigen/ffigen.dart' as ffigen;
import 'package:logging/logging.dart';
import 'package:package_config/package_config.dart';

import 'web/gen_web_bindings.dart' as web;

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

/// Modules whose bindings are plain Dart, so the web build uses the same file instead of a mirror
/// (see `tool/web/gen_web_bindings.dart`). ffigen still writes an `import 'dart:ffi' as ffi;` that
/// nothing in the file uses, and `dart:ffi` cannot be imported on the web, so it is dropped.
const _platformIndependent = {'constants'};

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
  // tool/ffigen.dart -> packages/dartcv
  final packageDir = File.fromUri(Platform.script).parent.parent;

  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.INFO;

  final flags = args.where((a) => a.startsWith('-')).toSet();
  final requested = args.where((a) => !a.startsWith('-')).toList();
  if (requested.isEmpty) requested.addAll(_modules.keys);
  final unknown = requested.where((name) => !_modules.containsKey(name)).toList();
  if (unknown.isNotEmpty) {
    throw ArgumentError.value(unknown.join(', '), 'module', 'known: ${_modules.keys.join(', ')}');
  }

  final packageConfig = await findPackageConfig(Directory.current);
  final outDir = Directory('lib/src/g');

  for (final name in requested) {
    final logger = Logger('ffigen.$name');
    final config = ffigen.YamlConfig.fromFile(
      File('ffigen/ffigen_${_modules[name]}.yaml'),
      logger,
      packageConfig: packageConfig,
    );
    final gen = _withRecordUse(config.configAdapter(), outDir);
    await gen.generate(logger: logger);
    if (_platformIndependent.contains(name)) {
      _dropUnusedFfiImport(File('${outDir.path}/$name.g.dart'));
    }
    print('generated ${outDir.path}/$name.g.dart');
  }

  if (!flags.contains('--no-web')) {
    web.generateWebBindings(packageDir: packageDir);
  }
}

/// Removes the `import 'dart:ffi' as ffi;` ffigen writes into a file that has no FFI
/// declarations, so that such a file also compiles on the web.
///
/// Fails loudly when the import survives in another shape: this file has no web mirror, so a
/// leftover `dart:ffi` import would break the web build with an error far from its cause.
void _dropUnusedFfiImport(File file) {
  final src = file.readAsStringSync();
  final stripped = src.replaceFirst(
    RegExp(r"^import 'dart:ffi' as ffi;\n\n+", multiLine: true),
    '',
  );
  final leftover = stripped.contains("import 'dart:ffi'");
  if (leftover) {
    throw StateError(
      '${file.path} still imports dart:ffi, but it is shared with the web build; '
      'update _dropUnusedFfiImport() in tool/ffigen.dart',
    );
  }
  if (stripped != src) file.writeAsStringSync(stripped);
}
