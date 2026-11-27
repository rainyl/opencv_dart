// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv;

import 'dart:async';

import '../bindings/core.dart' as ccore;
import '../bindings/types.dart' as cvg;
import '../ffi.dart' as ffi;
import '../package_ffi.dart';
import "exception.dart" show AsyncTimeoutException, CvException, CvdException;

/* fundamental constants */
const double CV_PI = 3.1415926535897932384626433832795;
const double CV_2PI = 6.283185307179586476925286766559;
const double CV_LOG2 = 0.69314718055994530941723212145818;
const int CV_MAX_DIM = 32;
const int CV_CN_MAX = 512;
const int CV_CN_SHIFT = 3;
const int CV_DEPTH_MAX = 1 << CV_CN_SHIFT;
const int CV_MAT_CN_MASK = (CV_CN_MAX - 1) << CV_CN_SHIFT;
// const int  CV_MAT_CN(flags)       =  ((((flags) & CV_MAT_CN_MASK) >> CV_CN_SHIFT) + 1);
const int CV_MAT_TYPE_MASK = CV_DEPTH_MAX * CV_CN_MAX - 1;
// const int  CV_MAT_TYPE(flags)     =  ((flags) & CV_MAT_TYPE_MASK);
const int CV_MAT_CONT_FLAG_SHIFT = 14;
const int CV_MAT_CONT_FLAG = 1 << CV_MAT_CONT_FLAG_SHIFT;
// const int  CV_IS_MAT_CONT(flags)  =  ((flags) & CV_MAT_CONT_FLAG);
// const int CV_IS_CONT_MAT = CV_IS_MAT_CONT;
const int CV_SUBMAT_FLAG_SHIFT = 15;
const int CV_SUBMAT_FLAG = 1 << CV_SUBMAT_FLAG_SHIFT;
// const int  CV_IS_SUBMAT(flags)    =  ((flags) & CV_MAT_SUBMAT_FLAG);

int CV_MAT_CN(int flags) => ((flags & CV_MAT_CN_MASK) >> CV_CN_SHIFT) + 1;
int CV_MAT_TYPE(int flags) => flags & CV_MAT_TYPE_MASK;
bool CV_IS_MAT_CONT(int flags) => (flags & CV_MAT_CONT_FLAG) != 0;
bool CV_IS_SUBMAT(int flags) => (flags & CV_SUBMAT_FLAG) != 0;

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
abstract class CvObject<T extends ffi.NativeType> implements ffi.Finalizable {
  /// Whether this object has been disposed. After [dispose] the underlying
  /// native memory is freed and the object must not be used any more.
  bool _disposed = false;

  /// Whether this object has been disposed.
  bool get isDisposed => _disposed;

  /// Releases the underlying native resources. **Idempotent**: calling it more
  /// than once is safe, but the object must not be used after [dispose].
  void dispose() {
    if (_disposed) return;
    _disposed = true;
    freeNative();
  }

  /// Frees the native resources owned by this object. Subclasses implement the
  /// concrete free logic here; callers must use [dispose] instead.
  void freeNative();
}

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

  /// A **view** of the native memory behind [ptr], not a copy.
  ///
  /// Never call this on a temporary wrapper (`(w, h).cvd.ref`,
  /// `toPoint().ref`): nothing keeps the wrapper alive, so its `NativeFinalizer`
  /// may free the memory before the FFI trampoline copies the struct (#464).
  /// Pass the Dart-heap struct instead: `(w, h).cvdRef`, `(x, y).pointRef`,
  /// `(type, count, eps).cvdRef`, or keep the wrapper in a named local.
  T get ref;

  @override
  List<Object?> get props => [ptr.address];
}

abstract class CvStruct<T extends ffi.Struct> extends ICvStruct<T> {
  CvStruct.fromPointer(super.ptr) : super.fromPointer();
}

// error handler
void throwIfFailed(ffi.Pointer<cvg.CvStatus> s) {
  final code = s.ref.code;
  if (code == 0) {
    ccore.CvStatus_close(s);
    return;
  }
  // String err = s.ref.err.cast<Utf8>().toDartString();
  final msg = s.ref.msg.cast<Utf8>().toDartString();
  final file = s.ref.file.cast<Utf8>().toDartString();
  final funcName = s.ref.func.cast<Utf8>().toDartString();
  final line = s.ref.line;
  ccore.CvStatus_close(s);
  throw CvException(code, msg: msg, file: file, func: funcName, line: line);
}

// sync runner
void cvRun(ffi.Pointer<cvg.CvStatus> Function() func) => throwIfFailed(func());

/// Runs a native `*_create` that fills [p], and returns [p].
ffi.Pointer<T> cvCreate<T extends ffi.NativeType>(
  ffi.Pointer<T> p,
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<T> out) create,
) {
  try {
    cvRun(() => create(p));
  } catch (_) {
    calloc.free(p);
    rethrow;
  }
  return p;
}

/// Runs a native call that writes one value into the fresh out-parameter block [p], hands that block
/// to [read], and frees it whichever way the call went.
R cvOut<T extends ffi.NativeType, R>(
  ffi.Pointer<T> p,
  ffi.Pointer<cvg.CvStatus> Function(ffi.Pointer<T> out) run,
  R Function(ffi.Pointer<T> out) read,
) {
  try {
    cvRun(() => run(p));
    return read(p);
  } finally {
    calloc.free(p);
  }
}

// async runner
typedef VoidPtr = ffi.Pointer<ffi.Void>;

/// Wraps a native `*Async` entry point into a [Future].
///
/// The work runs on a worker thread inside the library and reports through [func]'s callback, which
/// arrives on this isolate's event loop; [onComplete] turns the wrapper's output into the value. The
/// callback carries the status of the work, so an error that happens after the C entry point returned
/// still surfaces as a failed [Future].
///
/// [timeout] abandons the wait, not the work: OpenCV has no cancellation point, so the job runs to
/// completion and still writes the output arguments it was given. It throws an
/// [AsyncTimeoutException], whose `completion` resolves when that has happened - the moment those
/// arguments stop changing. The handles it was given are held by the job, so abandoning is safe.
///
/// [release] frees what [func] was handed (a `calloc` block, a `toNativeUtf8` path, an `Arena`) once
/// the job can no longer touch it - on success, on failure and when the call is rejected, but not on a
/// timeout, which only abandons the wait. Freeing it earlier leaks when the job fails or races the
/// worker, which reads those arguments after this call returns.
///
/// A call the native entry point rejects is reported through the returned [Future], never thrown
/// synchronously, so an `*Async` wrapper can be a plain `return cvRunAsync*(...)` without `async`.
///
/// [releaseOnFailure] frees what only a *successful* job hands over: an out-parameter block that
/// [onComplete] passes to a wrapper (`Mat.fromPointer(p)`) is owned by that wrapper once it exists, so
/// it cannot be in [release] (that would free it twice), and a job that fails never reaches
/// [onComplete], which used to leak that block. It runs only on the error paths, exactly once.
Future<T> cvRunAsync0<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_0 callback) func,
  void Function(Completer<T> completer) onComplete, {
  Duration? timeout,
  void Function()? release,
  void Function()? releaseOnFailure,
}) {
  final completer = Completer<T>();
  // Resolves when the native job is done with the objects it was given, whether or not anyone is
  // still waiting for the result; it is what `AsyncTimeoutException.completion` hands back.
  final completion = Completer<void>();
  late final ffi.NativeCallable<cvg.CvCallback_0Function> ccallback;
  var closed = false;
  var released = false;
  var releasedOnFailure = false;
  void releaseFailed() {
    if (releasedOnFailure) return;
    releasedOnFailure = true;
    releaseOnFailure?.call();
  }

  void close() {
    if (!closed) {
      closed = true;
      ccallback.close();
    }
    if (!completion.isCompleted) completion.complete();
    // Every path reaches here only after the native side is done with the arguments it was given.
    if (!released) {
      released = true;
      release?.call();
    }
  }

  void onResponse(ffi.Pointer<cvg.CvStatus> status) {
    try {
      throwIfFailed(status);
    } catch (e, s) {
      if (!completer.isCompleted) completer.completeError(e, s);
      releaseFailed();
      close();
      return;
    }
    try {
      // Run it even when the wait was abandoned (a timeout): the closure takes ownership of whatever
      // the job produced, so the finalizer reclaims it instead of it being leaked. On that path
      // completing twice throws, which the catch below ignores because the future is already done.
      onComplete(completer);
    } catch (e, s) {
      if (!completer.isCompleted) completer.completeError(e, s);
    } finally {
      // Only here is it safe to release the callback: the native side must never invoke it after
      // close(), which is also why a timeout must not close it early.
      close();
    }
  }

  ccallback = ffi.NativeCallable<cvg.CvCallback_0Function>.listener(onResponse);
  try {
    throwIfFailed(func(ccallback.nativeFunction));
  } catch (e, s) {
    // The work never started, so nothing took the output over either. Reported as a failed future
    // rather than rethrown: an `*Async` call never throws synchronously, which is what lets its
    // wrapper be a plain `return cvRunAsync*(...)` instead of an `async` function.
    releaseFailed();
    close();
    return Future<T>.error(e, s);
  }
  if (timeout != null) {
    final watch = Stopwatch()..start();
    final timer = Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(AsyncTimeoutException(watch.elapsed, completion.future));
      }
    });
    return completer.future.whenComplete(timer.cancel);
  }
  return completer.future;
}

Future<T> cvRunAsync1<T>(
  ffi.Pointer<cvg.CvStatus> Function(cvg.CvCallback_1 callback) func,
  void Function(Completer<T> completer, VoidPtr p) onComplete, {
  Duration? timeout,
  void Function()? release,
  void Function()? releaseOnFailure,
}) {
  final completer = Completer<T>();
  final completion = Completer<void>();
  late final ffi.NativeCallable<cvg.CvCallback_1Function> ccallback;
  var closed = false;
  var released = false;
  var releasedOnFailure = false;
  void releaseFailed() {
    if (releasedOnFailure) return;
    releasedOnFailure = true;
    releaseOnFailure?.call();
  }

  void close() {
    if (!closed) {
      closed = true;
      ccallback.close();
    }
    if (!completion.isCompleted) completion.complete();
    // see cvRunAsync0: only the end of the job makes the arguments safe to free
    if (!released) {
      released = true;
      release?.call();
    }
  }

  void onResponse(ffi.Pointer<cvg.CvStatus> status, VoidPtr p) {
    try {
      throwIfFailed(status);
    } catch (e, s) {
      if (!completer.isCompleted) completer.completeError(e, s);
      releaseFailed();
      close();
      return;
    }
    try {
      // see cvRunAsync0: run it even when a timeout abandoned the wait
      onComplete(completer, p);
    } catch (e, s) {
      if (!completer.isCompleted) completer.completeError(e, s);
    } finally {
      close();
    }
  }

  ccallback = ffi.NativeCallable<cvg.CvCallback_1Function>.listener(onResponse);
  try {
    throwIfFailed(func(ccallback.nativeFunction));
  } catch (e, s) {
    // see cvRunAsync0: the work never started, and the failure goes through the future
    releaseFailed();
    close();
    return Future<T>.error(e, s);
  }
  if (timeout != null) {
    final watch = Stopwatch()..start();
    final timer = Timer(timeout, () {
      if (!completer.isCompleted) {
        completer.completeError(AsyncTimeoutException(watch.elapsed, completion.future));
      }
    });
    return completer.future.whenComplete(timer.cancel);
  }
  return completer.future;
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

void cvAssert(bool condition, [String? msg]) {
  if (!condition) throw CvdException(msg ?? 'Assertion failed');
}

// finalizers
typedef NativeFinalizerFunctionT<T extends ffi.NativeType> =
    ffi.Pointer<ffi.NativeFunction<ffi.Void Function(T token)>>;

ffi.NativeFinalizer OcvFinalizer<T extends ffi.NativeType>(NativeFinalizerFunctionT<T> func) =>
    ffi.NativeFinalizer(func.cast<ffi.NativeFinalizerFunction>());

// native types
typedef U8 = ffi.Uint8;
typedef I8 = ffi.Int8;
typedef U16 = ffi.Uint16;
typedef I16 = ffi.Int16;
// typedef U32 = ffi.UnsignedInt;
typedef I32 = ffi.Int32;
typedef F32 = ffi.Float;
typedef F64 = ffi.Double;
// typedef F16 = ffi.Uint16;

// others
extension PointerCharExtension on ffi.Pointer<ffi.Char> {
  String toDartString() => cast<Utf8>().toDartString();
}
