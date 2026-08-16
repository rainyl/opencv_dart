// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Regression check for the hang-at-exit after OpenCV OpenCL usage.
//
// Diagnosis (2026-08-15, Windows x64, dartcv 4.13, OpenCV built with OpenCL ON):
//   * After OpenCV's OpenCL runtime has been initialized (useOpenCL() defaults to
//     true in this build), the process can fail to terminate after `main` returns.
//     It hangs during normal VM/process teardown (Windows DLL teardown race with
//     the OpenCL runtime threads). `dart:io` `exit(0)` (TerminateProcess) skips
//     that teardown and exits cleanly.
//   * The hang is RACY: even a single `cv::ocl::setUseOpenCL(true)` +
//     `cv::ocl::useOpenCL()` call can trigger it; unrelated FFI loops do not.
//   * It affects `dart test` runs that exercise the OpenCL path (e.g. core_test's
//     cv.useOpenCL/cv.setUseOpenCL), making the suite appear to "hang after all
//     tests passed".
//
// This test runs a child process that initializes OpenCL and then returns, and
// asserts the child terminates within a timeout. Because the hang is racy and
// spawns a process, it is skipped by default; run it manually with:
//   dart test --run-skipped -t repro test/core/opencl_exit_test.dart

// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:test/test.dart';

void main() {
  test(
    'process exits cleanly after OpenCL usage',
    () async {
      final child = File('test/core/opencl_exit_child.dart');
      final process = await Process.start(
        Platform.resolvedExecutable,
        [child.path, '50'],
        workingDirectory: Directory.current.path,
      );
      final timer = Timer(const Duration(seconds: 30), process.kill);
      final out = await process.stdout.transform(utf8.decoder).join();
      final err = await process.stderr.transform(utf8.decoder).join();
      final code = await process.exitCode;
      timer.cancel();
      expect(
        code,
        0,
        reason: 'child must terminate within timeout after OpenCL usage; '
            'stdout=$out stderr=$err',
      );
    },
    skip: 'Racy pre-existing OpenCV OpenCL hang-at-exit; run manually via '
        '`dart test --run-skipped -t repro test/core/opencl_exit_test.dart`. '
        'See file header for the diagnosis.',
    tags: 'repro',
  );
}
