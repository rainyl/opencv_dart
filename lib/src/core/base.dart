// coverage:ignore-file
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv;

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import "../g/types.g.dart" as cvg;
import '../native_lib.dart' show ccore;
import "exception.dart" show CvException;

/* fundamental constants */
const double CV_PI = 3.1415926535897932384626433832795;
const double CV_2PI = 6.283185307179586476925286766559;
const double CV_LOG2 = 0.69314718055994530941723212145818;

const int CV_U8_MAX = 255; // uchar
const int CV_U8_MIN = 0;
const int CV_I8_MAX = 127; // schar
const int CV_I8_MIN = -128;
const int CV_U16_MAX = 65535; // ushort
const int CV_U16_MIN = 0;
const int CV_I16_MAX = 32767; // short
const int CV_I16_MIN = -32768;
const int CV_U32_MAX = 4294967295;
const int CV_U32_MIN = 0;
const int CV_I32_MAX = 2147483647; // int
const int CV_I32_MIN = -2147483648;
const double CV_F32_MAX = 3.4028234663852886e+38;
const double CV_F64_MAX = 1.7976931348623157e+308;

// base structures
abstract class CvObject<T extends ffi.NativeType> implements ffi.Finalizable {}

mixin ComparableMixin {
  List<Object?> get props;

  @override
  // ignore: hash_and_equals
  bool operator ==(Object other) {
    if (other is! ComparableMixin) return false;
    if (props.length != other.props.length) return false;
    return props.indexed.every((e) => other.props[e.$1] == e.$2);
  }
}

abstract class ICvStruct<T extends ffi.Struct> extends CvObject<T> with ComparableMixin {
  ICvStruct.fromPointer(this.ptr);

  ffi.Pointer<T> ptr;
  T get ref;
}

abstract class CvStruct<T extends ffi.Struct> extends ICvStruct<T> {
  CvStruct.fromPointer(super.ptr) : super.fromPointer();
}

// error handler
void throwIfFailed(ffi.Pointer<cvg.CvStatus> s) {
  final code = s.ref.code;
  // String err = s.ref.err.cast<Utf8>().toDartString();
  final msg = s.ref.msg.cast<Utf8>().toDartString();
  final file = s.ref.file.cast<Utf8>().toDartString();
  final funcName = s.ref.func.cast<Utf8>().toDartString();
  final line = s.ref.line;
  ccore.CvStatus_Close(s);
  if (code != 0) {
    throw CvException(code, msg: msg, file: file, func: funcName, line: line);
  }
}

// sync runner
void cvRun(ffi.Pointer<cvg.CvStatus> Function() func) => throwIfFailed(func());

// async runner
typedef VoidPtr = ffi.Pointer<ffi.Void>;
Future<T> cvRunAsync0<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_0 callback) func,
  void Function(Completer<T> completer) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_0Function> ccallback;
  void onResponse() {
    onComplete(completer);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

Future<T> cvRunAsync<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_1 callback) func,
  void Function(Completer<T> completer, VoidPtr p) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_1Function> ccallback;
  void onResponse(VoidPtr p) {
    onComplete(completer, p);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

const cvRunAsync1 = cvRunAsync;

Future<T> cvRunAsync2<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_2 callback) func,
  void Function(Completer<T> completer, VoidPtr p, VoidPtr p1) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_2Function> ccallback;
  void onResponse(VoidPtr p, VoidPtr p1) {
    onComplete(completer, p, p1);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

Future<T> cvRunAsync3<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_3 callback) func,
  void Function(Completer<T> completer, VoidPtr p, VoidPtr p1, VoidPtr p2) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_3Function> ccallback;
  void onResponse(VoidPtr p, VoidPtr p1, VoidPtr p2) {
    onComplete(completer, p, p1, p2);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

Future<T> cvRunAsync4<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_4 callback) func,
  void Function(
    Completer<T> completer,
    VoidPtr p,
    VoidPtr p1,
    VoidPtr p2,
    VoidPtr p3,
  ) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_4Function> ccallback;
  void onResponse(VoidPtr p, VoidPtr p1, VoidPtr p2, VoidPtr p3) {
    onComplete(completer, p, p1, p2, p3);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

Future<T> cvRunAsync5<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_5 callback) func,
  void Function(
    Completer<T> completer,
    VoidPtr p,
    VoidPtr p1,
    VoidPtr p2,
    VoidPtr p3,
    VoidPtr p4,
  ) onComplete,
) {
  final completer = Completer<T>();
  late final ffi.NativeCallable<cvg.CvCallback_5Function> ccallback;
  void onResponse(VoidPtr p, VoidPtr p1, VoidPtr p2, VoidPtr p3, VoidPtr p4) {
    onComplete(completer, p, p1, p2, p3, p4);
    ccallback.close();
  }

  ccallback = ffi.NativeCallable.listener(onResponse);
  throwIfFailed(func(ccallback.nativeFunction));
  return completer.future;
}

// async completers
void voidCompleter(Completer<void> completer) => completer.complete();

void boolCompleter(Completer<bool> completer, VoidPtr p) {
  final value = p.cast<ffi.Bool>().value;
  calloc.free(p);
  completer.complete(value);
}

void intCompleter(Completer<int> completer, VoidPtr p) {
  final value = p.cast<ffi.Int>().value;
  calloc.free(p);
  completer.complete(value);
}

void doubleCompleter(Completer<double> completer, VoidPtr p) {
  final value = p.cast<ffi.Double>().value;
  calloc.free(p);
  completer.complete(value);
}

void floatCompleter(Completer<double> completer, VoidPtr p) {
  final value = p.cast<ffi.Float>().value;
  calloc.free(p);
  completer.complete(value);
}

// Arena wrapper
R cvRunArena<R>(
  R Function(Arena arena) computation, [
  ffi.Allocator wrappedAllocator = calloc,
  bool keep = false,
]) {
  final arena = Arena(wrappedAllocator);
  bool isAsync = false;
  try {
    final result = computation(arena);
    if (result is Future) {
      isAsync = true;
      return result.whenComplete(arena.releaseAll) as R;
    }
    return result;
  } finally {
    if (!isAsync && !keep) {
      arena.releaseAll();
    }
  }
}

// finalizers
typedef NativeFinalizerFunctionT<T extends ffi.NativeType>
    = ffi.Pointer<ffi.NativeFunction<ffi.Void Function(T token)>>;

ffi.NativeFinalizer OcvFinalizer<T extends ffi.NativeType>(
  NativeFinalizerFunctionT<T> func,
) =>
    ffi.NativeFinalizer(func.cast<ffi.NativeFinalizerFunction>());

// native types
typedef U8 = ffi.UnsignedChar;
typedef I8 = ffi.Char;
typedef U16 = ffi.UnsignedShort;
typedef I16 = ffi.Short;
// typedef U32 = ffi.UnsignedInt;
typedef I32 = ffi.Int;
typedef F32 = ffi.Float;
typedef F64 = ffi.Double;

// others
extension PointerCharExtension on ffi.Pointer<ffi.Char> {
  String toDartString() => cast<Utf8>().toDartString();
}
