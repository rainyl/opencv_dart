// ignore_for_file: avoid_print

import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'error_code.dart';
import '../opencv.g.dart' as cvg;

class CvException implements Exception {
  CvException(
    int code, {
    this.msg = "",
    this.err = "",
    this.file = "",
    this.func = "",
    this.line = -1,
  }) : code = ErrorCode(code);

  ErrorCode code;
  String err, msg, file, func;
  int line;

  @override
  String toString() {
    return "CvException(code: $code, err: $err, msg:$msg) in $func of file $file:$line";
  }
}

void defaultCvErrorCallback(
  int code,
  ffi.Pointer<ffi.Char> funcName,
  ffi.Pointer<ffi.Char> errMsg,
  ffi.Pointer<ffi.Char> fileName,
  int line,
  ffi.Pointer<ffi.Void> userdata,
) {
  final err = errMsg.cast<Utf8>();
  final func = funcName.cast<Utf8>();
  final file = fileName.cast<Utf8>();
  final msg = "OpenCV Native Error Occurred ("
      "code: $code, "
      "err: ${err.toDartString()}) "
      "func: ${func.toDartString()} "
      "file: ${file.toDartString()}:$line";
  print(msg);
  calloc.free(err);
  calloc.free(func);
  calloc.free(file);
  exit(code);
}

void registerErrorCallback({cvg.DartErrorCallbackFunction? callback}) {
  callback ??= defaultCvErrorCallback;
  // final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.listener(callback);
  final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.isolateLocal(callback);
  cvg.registerErrorCallback(fp.nativeFunction);
}

class CvdException implements Exception {
  final String message;
  CvdException(this.message);

  @override
  String toString() {
    return "OpenCvDartException: $message";
  }
}
