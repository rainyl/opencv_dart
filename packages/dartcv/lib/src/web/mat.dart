// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// Spike: web backend for a small slice of the public API (Mat, cvtColor, gaussianBlur,
// imdecode, imencode), with the same names and signatures as lib/src/core/mat.dart,
// lib/src/imgproc/imgproc.dart and lib/src/imgcodecs/imgcodecs.dart, but calling the
// Emscripten build of the same C wrapper instead of dart:ffi.

import 'dart:js_interop';
import 'dart:typed_data';

import '../core/exception.dart' show CvException;
import 'dartcv_module.dart';

export 'dartcv_module.dart' show initDartcv;

// Same layout as `CvStatus` in src/dartcv/core/types.h on wasm32:
// int code; char* msg; char* err; char* func; char* file; int line;
void _throwIfFailed(int s) {
  final m = dartcv;
  final h = m.heap32.toDart;
  final i = s >> 2;
  final code = h[i];
  final msg = m.utf8ToString(h[i + 1]);
  final func = m.utf8ToString(h[i + 3]);
  final file = m.utf8ToString(h[i + 4]);
  final line = h[i + 5];
  m.cvStatusClose(s);
  if (code != 0) {
    throw CvException(code, msg: msg, file: file, func: func, line: line);
  }
}

void cvRun(int Function() func) => _throwIfFailed(func());

/// Async on web is a Future around the sync call: the C wrapper invokes its callback
/// synchronously on the calling thread (native too), so the native "async" API never
/// moved work off the Dart thread. Real off-main-thread work on web needs a Web Worker
/// that owns its own wasm instance, which changes Mat ownership (see docs).
Future<T> cvRunAsync<T>(int Function() func, T Function() onComplete) async {
  cvRun(func);
  return onComplete();
}

// The C side frees the `Mat` struct with `delete` (CVD_FREE), so it must come from the
// module's own malloc, never from a Dart-side allocator.
final Finalizer<int> _matFinalizer = Finalizer<int>((p) => dartcv.cvMatClose(p));

/// Web stand-in for lib/src/core/mat_type.dart, which imports dart:ffi only for
/// `sizeOf<Size>()` in elemSize; a real port would drop that import and share the class.
class MatType {
  const MatType(this.value);
  final int value;
  int get depth => value & 7;
  int get channels => ((value >> 3) & 511) + 1;
  static const CV_8UC1 = MatType(0);
  static const CV_8UC3 = MatType(16);
  static const CV_8UC4 = MatType(24);

  @override
  bool operator ==(Object other) => other is MatType && other.value == value;
  @override
  int get hashCode => value.hashCode;
}

class Mat {
  Mat._(this.ptr, {bool attach = true}) {
    if (attach) _matFinalizer.attach(this, ptr, detach: this);
  }

  factory Mat._create(int Function(int p) create) {
    final p = dartcv.malloc(4);
    dartcv.heap32.toDart[p >> 2] = 0;
    try {
      cvRun(() => create(p));
    } catch (_) {
      dartcv.free(p);
      rethrow;
    }
    return Mat._(p);
  }

  /// Address of the C `Mat` struct (`struct { cv::Mat* ptr; }`) in wasm memory.
  final int ptr;
  bool _disposed = false;
  bool get isDisposed => _disposed;

  /// Value passed for `Mat self` parameters: the wrapped `cv::Mat*` (single-field struct
  /// by value is lowered to its field on wasm32).
  int get ref => dartcv.heap32.toDart[ptr >> 2];

  factory Mat.empty() => Mat._create((p) => dartcv.cvMatCreate(p));

  /// 8-bit depths only in the spike.
  factory Mat.fromList(int rows, int cols, MatType type, List<num> data) {
    if (type.depth > 1) throw UnsupportedError('spike: Mat.fromList supports CV_8U/CV_8S only');
    final m = dartcv;
    final buf = m.malloc(data.length);
    try {
      m.heapU8.toDart.setRange(buf, buf + data.length, data.cast<int>());
      return Mat._create((p) => m.cvMatCreate6(rows, cols, type.value, buf, p, 0));
    } finally {
      m.free(buf);
    }
  }

  int get rows => dartcv.cvMatRows(ref);
  int get cols => dartcv.cvMatCols(ref);
  MatType get type => MatType(dartcv.cvMatType(ref));
  int get channels => dartcv.cvMatChannels(ref);
  int get total => dartcv.cvMatTotal(ref);
  int get elemSize => dartcv.cvMatElemSize(ref);
  bool get isEmpty => dartcv.cvMatEmpty(ref);

  /// Zero-copy view into wasm memory, like the native `asTypedList` view. Unlike native,
  /// it is invalidated (detached) whenever the wasm memory grows, so copy it if you keep it.
  Uint8List get data {
    final m = dartcv;
    final start = m.cvMatData(ref);
    return m.heapU8.toDart.buffer.asUint8List(start, total * elemSize);
  }

  void dispose() {
    if (_disposed) return;
    _disposed = true;
    _matFinalizer.detach(this);
    dartcv.cvMatClose(ptr);
  }
}

// Writes a CvSize {int width; int height;} into scratch memory: multi-field structs are
// passed by pointer on wasm32.
T _withSize<T>((int, int) size, T Function(int p) f) {
  final m = dartcv;
  final p = m.malloc(8);
  try {
    final h = m.heap32.toDart;
    h[p >> 2] = size.$1;
    h[(p >> 2) + 1] = size.$2;
    return f(p);
  } finally {
    m.free(p);
  }
}

Mat cvtColor(Mat src, int code, {Mat? dst}) {
  dst ??= Mat.empty();
  cvRun(() => dartcv.cvCvtColor(src.ref, dst!.ref, code, 0));
  return dst;
}

Future<Mat> cvtColorAsync(Mat src, int code) async {
  final dst = Mat.empty();
  return cvRunAsync(() => dartcv.cvCvtColor(src.ref, dst.ref, code, 0), () => dst);
}

Mat gaussianBlur(
  Mat src,
  (int, int) ksize,
  double sigmaX, {
  Mat? dst,
  double sigmaY = 0,
  int borderType = 4, // BORDER_DEFAULT
}) {
  dst ??= Mat.empty();
  _withSize(
    ksize,
    (k) => cvRun(() => dartcv.cvGaussianBlur(src.ref, dst!.ref, k, sigmaX, sigmaY, borderType, 0)),
  );
  return dst;
}

Mat imdecode(Uint8List buf, int flags, {Mat? dst}) {
  final m = dartcv;
  // Same as native VecUChar.fromList: allocate the std::vector, then fill its storage.
  final vec = m.stdVecUCharNew(buf.length);
  try {
    final data = m.stdVecUCharData(vec);
    m.heapU8.toDart.setRange(data, data + buf.length, buf);
    dst ??= Mat.empty();
    // `VecUChar buf` by value is lowered to its `std::vector*` field.
    final vecValue = m.heap32.toDart[vec >> 2];
    cvRun(() => m.cvImdecode(vecValue, flags, dst!.ptr, 0));
    return dst;
  } finally {
    m.stdVecUCharFree(vec);
  }
}

(bool, Uint8List) imencode(String ext, Mat img) {
  final m = dartcv;
  final cExt = m.stringToNewUtf8(ext);
  final pSuccess = m.malloc(4);
  final vec = m.stdVecUCharNew(0);
  try {
    cvRun(() => m.cvImencode(cExt, img.ref, pSuccess, vec, 0));
    final success = m.heapU8.toDart[pSuccess] != 0;
    final data = m.stdVecUCharData(vec);
    final len = m.stdVecUCharLength(vec);
    return (success, Uint8List.fromList(m.heapU8.toDart.sublist(data, data + len)));
  } finally {
    m.free(cExt);
    m.free(pSuccess);
    m.stdVecUCharFree(vec);
  }
}
