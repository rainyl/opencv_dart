// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
import 'dart:ffi' as ffi;
import 'dart:io';
import 'g/core.g.dart' as core;

const _libraryName = "dartcv_core";

// load native library
ffi.DynamicLibrary loadNativeLibrary() {
  if (Platform.isIOS || Platform.isMacOS) return ffi.DynamicLibrary.process();
  final defaultLibPath = switch (Platform.operatingSystem) {
    "windows" => "$_libraryName.dll",
    "linux" || "android" || "fuchsia" => "lib$_libraryName.so",
    "macos" => "lib$_libraryName.dylib",
    _ => throw UnsupportedError(
        "Platform ${Platform.operatingSystem} not supported",
      )
  };
  final libPath = Platform.environment["dartcv_core_LIB_PATH"] ?? defaultLibPath;
  return ffi.DynamicLibrary.open(libPath);
}

final ccore = core.CvNativeCore(loadNativeLibrary());
