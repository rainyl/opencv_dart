// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Link hook: writes a keep-list of the native symbols actually used by the
// Dart code into `dartcv_keep.txt`. `hook/build.dart` (run_build.dart) passes
// that file to CMake as `DARTCV_KEEP_FILE`, which restricts the dartcv library
// exports to these symbols and garbage-collects everything unreachable from
// them (`DARTCV_TREESHAKE`).
//
// The keep-list is the union of:
//  1. the `@ffi.Native` functions recorded as called by the frontend
//     (`input.recordedUses`, only available during AOT builds), and
//  2. the finalizer-registered symbols from the ffigen `_SymbolAddresses`
//     (`*_close` / `*_free` / `*_delete`), because the compiler does NOT record
//     usages made through `ffi.Native.addressOf` (NativeFinalizer) - without
//     them the runtime fails to resolve the finalizer symbols.
//
// ffigen keeps the Dart external function names identical to the C symbols, so
// the names can be used directly as the keep-list. Because the build hook runs
// before this hook, the keep-list produced here only affects a subsequent
// build / re-link pass.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:dartcv4/src/hook_helpers/user_defines.dart';
import 'package:hooks/hooks.dart';

/// Maps a dartcv module to the ffigen binding file that declares it.
const _moduleGfile = <String, String>{
  'imgcodecs': 'imgcodecs.g.dart',
  'imgproc': 'imgproc.g.dart',
  'calib3d': 'calib3d.g.dart',
  'dnn': 'dnn.g.dart',
  'features2d': 'features2d.g.dart',
  'video': 'video.g.dart',
  'videoio': 'videoio.g.dart',
  'photo': 'photo.g.dart',
  'stitching': 'stitching.g.dart',
  'objdetect': 'objdetect.g.dart',
  'highgui': 'highgui.g.dart',
  'gapi': 'gapi.g.dart',
  'freetype': 'contrib.g.dart',
  'aruco': 'contrib.g.dart',
  'img_hash': 'contrib.g.dart',
  'quality': 'contrib.g.dart',
  'wechat_qrcode': 'contrib.g.dart',
  'ximgproc': 'contrib.g.dart',
  'xobjdetect': 'contrib.g.dart',
};

/// Reads the ffigen `_SymbolAddresses` class names (the finalizer-registered
/// `*_close` / `*_free` / `*_delete` symbols) from the binding files of the
/// built modules. The compiler does NOT record `@ffi.Native` usages made via
/// `ffi.Native.addressOf` (NativeFinalizer), so without these the runtime
/// cannot resolve the finalizer symbols.
Future<Set<String>> _finalizerSymbols(Uri gDir, Set<String> modules) async {
  final files = <String>{'core.g.dart'};
  for (final m in modules) {
    final f = _moduleGfile[m];
    if (f != null) files.add(f);
  }
  final getter = RegExp(r'^\s*ffi\.Pointer<.*>\s+get\s+(\w+)\s*=>');
  final result = <String>{};
  for (final name in files) {
    final f = File.fromUri(gDir.resolve(name));
    if (!f.existsSync()) continue;
    var addresses = false;
    for (final line in f.readAsStringSync().split('\n')) {
      if (line.trim() == 'class _SymbolAddresses {') {
        addresses = true;
        continue;
      }
      if (addresses) {
        if (line.startsWith('}')) break;
        final m = getter.firstMatch(line);
        if (m != null) result.add(m.group(1)!);
      }
    }
  }
  return result;
}

/// Loads the `recordUseMapping` name-to-symbol tables from the generated
/// `lib/src/g/<module>.record_use_mapping.g.dart` files for the built modules.
Map<String, String> _recordUseMapping(Uri gDir, Set<String> modules) {
  final result = <String, String>{};
  final files = <String>{'core'};
  for (final m in modules) {
    files.add(_moduleGfile[m]?.replaceAll('.g.dart', '') ?? '');
  }
  for (final name in files) {
    if (name.isEmpty) continue;
    final f = File.fromUri(gDir.resolve('$name.record_use_mapping.g.dart'));
    if (!f.existsSync()) continue;
    for (final line in f.readAsStringSync().split('\n')) {
      final m = RegExp("'([^']+)': '([^']+)'").firstMatch(line);
      if (m != null) result[m.group(1)!] = m.group(2)!;
    }
  }
  return result;
}

void main(List<String> args) async {
  await link(args, (input, output) async {
    final recorded = input.recordedUses;
    final modules = UserDefineArgsParser(
      input.userDefines,
      targetOS: input.config.buildCodeAssets ? input.config.code.targetOS : null,
    ).modules;
    final gDir = input.packageRoot.resolve('lib/src/g/');
    final mapping = _recordUseMapping(gDir, modules);
    final finalizerSymbols = await _finalizerSymbols(gDir, modules);
    final symbols = <String>{
      if (recorded != null)
        for (final d in recorded.calls.keys) mapping[d.name] ?? d.name,
      ...finalizerSymbols,
    };

    // Shared, checksum-independent location (also used by the build hook in
    // run_build.dart) so the keep-list persists across build passes.
    final sharedDir = input.outputDirectory.resolve('../../');
    final diag = sharedDir.resolve('dartcv_link_diag.txt');
    final db = StringBuffer();
    db.writeln('recorded == null: ${recorded == null}');
    db.writeln('calls count: ${recorded?.calls.length ?? 0}');
    if (recorded != null) {
      db.writeln('sample keys: ${recorded.calls.keys.take(10).map((d) => d.name).toList()}');
    }
    db.writeln('finalizer symbols: ${finalizerSymbols.length}');
    db.writeln('total keep symbols: ${symbols.length}');
    File.fromUri(diag).writeAsStringSync(db.toString());

    // Only (re)write the keep-list on AOT builds (`recordedUses` is present).
    // On JIT builds (`dart run` / `dart test`) `recordedUses` is null, so the
    // list would contain only the finalizer symbols and clobber the good
    // AOT-derived list, breaking the next build's exports.
    if (recorded != null) {
      final keepFile = sharedDir.resolve('dartcv_keep.txt');
      File.fromUri(keepFile).createSync(recursive: true);
      File.fromUri(keepFile).writeAsStringSync(symbols.join('\n'));
    }

    if (recorded != null) {
      stdout.writeln(
        '[dartcv4] link: wrote ${symbols.length} native symbols '
        '(${recorded.calls.length} recorded + ${finalizerSymbols.length} finalizer) to ${sharedDir.toFilePath()}dartcv_keep.txt',
      );
    } else {
      stdout.writeln(
        '[dartcv4] link: no recorded uses (JIT build), keep-list left untouched',
      );
    }
  });
}
