import 'dart:ffi' as ffi;
import 'dart:io';

import 'package:ffi/ffi.dart';

import 'error_code.dart';
import 'base.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class CvException implements ffi.Finalizable {
  CvException._(this.ptr) {
    finalizer.attach(this, ptr);
  }

  cvg.CvException ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.CvException_Close);

  int get code => _bindings.CvException_GetCode(ptr);
  String get err => _bindings.CvException_GetErr(ptr).cast<Utf8>().toDartString();
  String get file => _bindings.CvException_GetFile(ptr).cast<Utf8>().toDartString();
  String get func => _bindings.CvException_GetFunc(ptr).cast<Utf8>().toDartString();
  int get line => _bindings.CvException_GetLine(ptr);

  @override
  String toString() {
    return "CvException(code: $code, err: $err) in $func of file $file:$line";
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
  _bindings.registerErrorCallback(fp.nativeFunction);
}

class OpenCvException implements Exception {
  /// The numeric code for error status
  ErrorCode status;

  /// The source func name where error is encountered
  String funcName;

  /// A description of the error
  String message;

  /// The source file name where error is encountered
  String fileName;

  /// The line number in the source where error is encountered
  int line;

  OpenCvException(
    this.status,
    this.funcName,
    this.message,
    this.fileName,
    this.line,
  ) : super();

  OpenCvException.empty() : this(ErrorCode.StsOk, "", "", "", 0);
  OpenCvException.message(ErrorCode code, message) : this(code, "", message, "", 0);

  String toString() {
    if (message.isEmpty) return "OpenCvException";
    return "OpenCvException: $message";
  }
}

class OpenCvDartException implements Exception {
  final String message;
  OpenCvDartException(this.message);

  @override
  String toString() {
    return "OpenCvDartException: $message";
  }
}
