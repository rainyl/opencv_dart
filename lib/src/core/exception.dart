import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'base.dart';
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
  ffi.Pointer<ffi.Char> func_name,
  ffi.Pointer<ffi.Char> err_msg,
  ffi.Pointer<ffi.Char> file_name,
  int line,
  ffi.Pointer<ffi.Void> userdata,
) {
  final err = err_msg.cast<Utf8>();
  ;
  final func = func_name.cast<Utf8>();
  final file = file_name.cast<Utf8>();
  print(
      "OpenCV Native Error Occurred (code: $code, err: ${err.toDartString()}) in ${func.toDartString()} of file ${file.toDartString()}:$line");
  calloc.free(err);
  calloc.free(func);
  calloc.free(file);
  exit(code);
}

void registerErrorCallback({cvg.DartErrorCallbackFunction? callback}) {
  callback ??= defaultCvErrorCallback;
  // final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.listener(callback);
  final fp = ffi.NativeCallable<cvg.ErrorCallbackFunction>.isolateLocal(callback);
  CFFI.registerErrorCallback(fp.nativeFunction);
}

class OpenCvDartException implements Exception {
  final String message;
  OpenCvDartException(this.message);

  @override
  String toString() {
    return "OpenCvDartException: $message";
  }
}
