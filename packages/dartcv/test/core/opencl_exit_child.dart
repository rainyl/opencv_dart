// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// ignore_for_file: avoid_print
// ignore_for_file: avoid_private_typedef_functions

// Child fixture for `opencl_exit_test.dart`.
//
// Loads the already-built dartcv library directly (no native-assets hooks /
// rebuild), exercises the OpenCV OpenCL path a few times, then returns normally.
//
// Known hang-at-exit: if the OpenCV OpenCL runtime has been initialized, the
// process may not terminate after `main` returns (racily). It hangs during
// normal VM/process teardown; `dart:io` `exit(0)` (TerminateProcess) skips the
// teardown and exits cleanly. The parent test asserts this child exits within a
// timeout as a regression check.
//
// Usage:
//   dart test/core/opencl_exit_child.dart [iterations]

import 'dart:ffi' as ffi;
import 'dart:io';

typedef _HaveOpenCL = ffi.Bool Function();
typedef _HaveOpenCLDart = bool Function();
typedef _UseOpenCL = ffi.Bool Function();
typedef _UseOpenCLDart = bool Function();
typedef _SetUseOpenCL = ffi.Void Function(ffi.Bool);
typedef _SetUseOpenCLDart = void Function(bool);

void main(List<String> args) {
  final iterations = args.isNotEmpty ? int.parse(args[0]) : 50;

  final dllName = switch (Platform.operatingSystem) {
    'windows' => 'dartcv.dll',
    'macos' => 'libdartcv.dylib',
    _ => 'libdartcv.so',
  };
  final dllUri = Platform.script.resolve('../../.dart_tool/lib/$dllName');
  final lib = ffi.DynamicLibrary.open(dllUri.toFilePath());

  final haveOpenCL = lib.lookupFunction<_HaveOpenCL, _HaveOpenCLDart>('cv_ocl_haveOpenCL');
  final useOpenCL = lib.lookupFunction<_UseOpenCL, _UseOpenCLDart>('cv_ocl_useOpenCL');
  final setUseOpenCL = lib.lookupFunction<_SetUseOpenCL, _SetUseOpenCLDart>('cv_ocl_setUseOpenCL');

  final enabled = haveOpenCL();
  for (var i = 0; i < iterations; i++) {
    setUseOpenCL(enabled);
    useOpenCL();
  }
  stdout.writeln('child done: iterations=$iterations haveOpenCL=$enabled useOpenCL=${useOpenCL()}');
}
