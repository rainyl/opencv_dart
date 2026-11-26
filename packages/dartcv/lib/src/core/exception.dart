// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
// ignore_for_file: avoid_print
import 'dart:async';

import 'error_code.dart';

class CvException implements Exception {
  CvException(int code, {this.msg = "", this.err = "", this.file = "", this.func = "", this.line = -1})
    : code = ErrorCode(code);

  ErrorCode code;
  String err;
  String msg;
  String file;
  String func;
  int line;

  @override
  String toString() {
    return "CvException(code: $code, msg:$msg) in $func of file $file:$line";
  }
}

// void defaultCvErrorCallback(
//   int code,
//   ffi.Pointer<ffi.Char> funcName,
//   ffi.Pointer<ffi.Char> errMsg,
//   ffi.Pointer<ffi.Char> fileName,
//   int line,
//   ffi.Pointer<ffi.Void> userdata,
// ) {
//   final err = errMsg.cast<Utf8>();
//   final func = funcName.cast<Utf8>();
//   final file = fileName.cast<Utf8>();
//   final msg = "OpenCV Native Error Occurred ("
//       "code: $code, "
//       "err: ${err.toDartString()}) "
//       "func: ${func.toDartString()} "
//       "file: ${file.toDartString()}:$line";
//   print(msg);
//   calloc.free(err);
//   calloc.free(func);
//   calloc.free(file);
//   exit(code);
// }

// void registerErrorCallback({cvg.DartErrorCallbackFunction? callback}) {
//   callback ??= defaultCvErrorCallback;
//   // final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.listener(callback);
//   final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.isolateLocal(callback);
//   CFFI.registerErrorCallback(fp.nativeFunction);
// }

/// Thrown when an `*Async` call gave up waiting on its `timeout` but the work itself was not - and
/// cannot be - cancelled.
///
/// An OpenCV call has no cancellation point: once it started it runs to completion and still writes
/// the output arguments it was given. [completion] resolves when that has happened, which is the only
/// moment those arguments are safe to use again:
///
/// ```dart
/// try {
///   await cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst, timeout: const Duration(seconds: 2));
/// } on cv.AsyncTimeoutException catch (e) {
///   // either wait for the write to land ...
///   await e.completion;
///   use(dst);
///   // ... or treat the result as lost, knowing dst may change underneath you until then
/// }
/// ```
///
/// A call that passes no output argument (`*Async` creates its own `dst` when it is not given) is
/// unaffected: nothing the caller holds is written, and [completion] is only useful to know when the
/// job released the CPU.
class AsyncTimeoutException implements TimeoutException {
  AsyncTimeoutException(this.elapsed, this.completion)
    : message =
          'the call was not cancelled after $elapsed: OpenCV calls have no cancellation point, so '
          'the work still runs and may still write the output arguments it was given. Await '
          '`completion` (or `cv.asyncDrain()`) before using them.';

  /// How long the call waited before this was thrown.
  final Duration elapsed;

  /// Resolves when the abandoned job released its handles - the point after which the output
  /// arguments it was given are no longer touched.
  final Future<void> completion;

  @override
  final String message;

  @override
  Duration? get duration => elapsed;

  @override
  String toString() => 'AsyncTimeoutException after $elapsed: $message';
}

class CvdException implements Exception {
  final String message;
  CvdException(this.message);

  @override
  String toString() {
    return "CvdException: $message";
  }
}
