// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Link hook: links the final `dartcv` library with only the native symbols the
// Dart code of *this* build actually uses (tree-shaking).
//
// The link hook is the only hook that sees `input.recordedUses` (the
// `@ffi.Native` functions the compiler recorded as called), so it is also the
// only place where the keep-list can be computed.
//
// `hook/build.dart` therefore never restricts the exports: in a tree-shaking
// build it hands the unrestricted library over (routed to this hook), and
// `CMakeBuilder.runLink` builds the `dartcv_treeshake` target of the build
// hook's CMake tree with the keep-list below (see `cmake/treeshake.cmake` of
// package:native_toolchain_cmake).
//
// The keep-list is the union of:
//  1. the `@ffi.Native` functions recorded as called by the frontend, and
//  2. the finalizer-registered symbols from the ffigen `_SymbolAddresses`
//     (`*_close` / `*_free` / `*_delete`), because the compiler does NOT record
//     usages made through `ffi.Native.addressOf` (NativeFinalizer) - without
//     them the runtime fails to resolve the finalizer symbols.

import 'dart:io';

import 'package:code_assets/code_assets.dart';
import 'package:dartcv4/src/hook_helpers/library_names.dart';
import 'package:dartcv4/src/hook_helpers/user_defines.dart';
import 'package:hooks/hooks.dart';
import 'package:native_toolchain_cmake/native_toolchain_cmake.dart';

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
  'ml': 'ml.g.dart',
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

/// Hands the unrestricted library the build hook produced to the application.
void _passThrough(LinkOutputBuilder output, String packageName, Uri library, String reason) {
  stdout.writeln('[dartcv4] link: keeping all exports ($reason)');
  output.assets.code.add(
    CodeAsset(
      package: packageName,
      name: dartcvAssetName,
      file: library,
      linkMode: DynamicLoadingBundled(),
    ),
    routing: const ToAppBundle(),
  );
}

void main(List<String> args) async {
  await link(args, (input, output) async {
    // Web (data assets only) builds have no code config: accessing
    // `input.config.code` would throw.
    if (!input.config.buildCodeAssets) return;
    final targetOS = input.config.code.targetOS;
    final userArgs = UserDefineArgsParser(input.userDefines, targetOS: targetOS);

    final library = input.assets.code
        .where((asset) => asset.id.endsWith('/$dartcvAssetName'))
        .firstOrNull
        ?.file;
    if (library == null) {
      // `hook/build.dart` only hands the library over for an AOT tree-shaking
      // build; otherwise it bundles it directly and there is nothing to do.
      return;
    }

    final diagFile = File.fromUri(input.outputDirectory.resolve('dartcv_link_diag.txt'));
    final recorded = input.recordedUses;
    if (recorded == null) {
      // An SDK without the `record-use` experiment: nothing to link with, and
      // the `.g.dart` files do not need to be scanned for it.
      diagFile.writeAsStringSync('recorded uses: none\nlibrary: $library\n');
      _passThrough(output, input.packageName, library, 'the build recorded no native usages');
      return;
    }

    final gDir = input.packageRoot.resolve('lib/src/g/');
    final mapping = _recordUseMapping(gDir, userArgs.modules);
    final finalizerSymbols = await _finalizerSymbols(gDir, userArgs.modules);
    final recordedSymbols = symbolsFromRecordedUses(input, mapping: mapping);
    final symbols = {...recordedSymbols, ...finalizerSymbols};

    final diag = StringBuffer()
      ..writeln('recorded symbols: ${recordedSymbols.length}')
      ..writeln('finalizer symbols: ${finalizerSymbols.length}')
      ..writeln('total keep symbols: ${symbols.length}')
      ..writeln('treeshake: ${userArgs.treeshake}')
      ..writeln('library: $library');
    diagFile.writeAsStringSync(diag.toString());

    if (recordedSymbols.isEmpty) {
      _passThrough(output, input.packageName, library, 'the build recorded no native usages');
      return;
    }

    try {
      final linked = await CMakeBuilder.forLink(name: dartcvLibraryName).runLink(
        input: input,
        output: output,
        assetName: dartcvAssetName,
        symbolsToKeep: symbols,
        libraryName: dartcvLibraryName,
      );
      if (!linked) {
        _passThrough(output, input.packageName, library, 'the tree-shaken link was not possible');
        return;
      }
      diagFile.writeAsStringSync('$diag\nlinked: true\n');
      stdout.writeln(
        '[dartcv4] link: tree-shaken library with ${symbols.length} symbols '
        '(${recordedSymbols.length} recorded + ${finalizerSymbols.length} finalizer)',
      );
    } on Exception catch (e) {
      // Shipping the unrestricted library is always correct, only bigger, so
      // never fail the build over the tree-shaken link.
      final reason = e.toString().split('\n').first;
      diagFile.writeAsStringSync('$diag\nlink failed: $e\n');
      _passThrough(output, input.packageName, library, 'the tree-shaken link failed: $reason');
    }
  });
}
