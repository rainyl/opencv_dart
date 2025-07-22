import 'dart:io';

import 'package:code_assets/code_assets.dart';

/// Set RPATH for a shared library using patchelf
///
/// [path] The path to the shared library
/// [name] The RPATH value to set, defaults to '$ORIGIN'
Future<void> setRPath(Uri path, {String name = r'$ORIGIN'}) async {
  final result = await Process.run('patchelf', ['--set-rpath', name, path.toFilePath()]);

  if (result.exitCode != 0) {
    throw Exception('Failed to set RPATH: ${result.stderr}');
  }
}

extension RPathExtension on CodeAsset {
  Future<void> changeRPath({String name = r'$ORIGIN'}) async {
    if (file != null) {
      await setRPath(file!, name: name);
    }
  }
}
