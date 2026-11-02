// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// Spike: js_interop view of the Emscripten build of the dartcv C wrapper
// (tool/web/build_wasm.sh). Every pointer is a wasm32 address held in a Dart int.
//
// wasm32 C ABI notes that decide the Dart signatures here:
// - single-field structs passed by value (Mat, VecUChar, ...) are lowered to that field, so
//   `Mat self` arrives as the `cv::Mat*` it wraps (an i32);
// - multi-field structs passed by value (CvSize, CvRect, Scalar, ...) are passed indirectly,
//   as a pointer to a caller-owned copy in linear memory;
// - callbacks are function-table indices; 0 means "no callback" (sync call).

import 'dart:js_interop';

@JS()
extension type DartcvModule._(JSObject _) implements JSObject {
  @JS('_malloc')
  external int malloc(int size);
  @JS('_free')
  external void free(int ptr);

  // Views over linear memory. Re-read after every call that may grow memory:
  // ALLOW_MEMORY_GROWTH replaces the underlying ArrayBuffer and detaches old views.
  @JS('HEAPU8')
  external JSUint8Array get heapU8;
  @JS('HEAP32')
  external JSInt32Array get heap32;
  @JS('UTF8ToString')
  external String utf8ToString(int ptr);

  // core
  @JS('_CvStatus_close')
  external void cvStatusClose(int status);
  @JS('_cv_Mat_create')
  external int cvMatCreate(int rval);
  @JS('_cv_Mat_create_6')
  external int cvMatCreate6(int rows, int cols, int type, int buf, int rval, int callback);
  @JS('_cv_Mat_close')
  external void cvMatClose(int matPtr);
  @JS('_cv_Mat_rows')
  external int cvMatRows(int mat);
  @JS('_cv_Mat_cols')
  external int cvMatCols(int mat);
  @JS('_cv_Mat_type')
  external int cvMatType(int mat);
  @JS('_cv_Mat_channels')
  external int cvMatChannels(int mat);
  @JS('_cv_Mat_total')
  external int cvMatTotal(int mat);
  @JS('_cv_Mat_elemSize')
  external int cvMatElemSize(int mat);
  @JS('_cv_Mat_empty')
  external bool cvMatEmpty(int mat);
  @JS('_cv_Mat_data')
  external int cvMatData(int mat);
  @JS('_std_VecUChar_new_2')
  external int stdVecUCharNew2(int length, int data);
  @JS('_std_VecUChar_free')
  external void stdVecUCharFree(int vecPtr);
  @JS('_std_VecUChar_data')
  external int stdVecUCharData(int vecPtr);
  @JS('_std_VecUChar_length')
  external int stdVecUCharLength(int vecPtr);
  @JS('_std_VecUChar_new')
  external int stdVecUCharNew(int length);

  // imgproc
  @JS('_cv_cvtColor')
  external int cvCvtColor(int src, int dst, int code, int callback);
  @JS('_cv_GaussianBlur')
  external int cvGaussianBlur(
    int src,
    int dst,
    int ksizePtr,
    double sigmaX,
    double sigmaY,
    int borderType,
    int callback,
  );

  // imgcodecs
  @JS('_cv_imdecode')
  external int cvImdecode(int buf, int flags, int rval, int callback);
  @JS('_cv_imencode')
  external int cvImencode(int ext, int img, int successPtr, int rvalVecPtr, int callback);
  @JS('stringToNewUTF8')
  external int stringToNewUtf8(String s);
}

@JS('createDartcvModule')
external JSPromise<DartcvModule> _createDartcvModule();

DartcvModule? _module;

/// The loaded wasm module. Throws if [initDartcv] has not completed.
DartcvModule get dartcv =>
    _module ?? (throw StateError('call `await initDartcv()` before using dartcv on web'));

/// Instantiates the wasm module. Web-only: native builds load the library lazily via
/// `@ffi.Native`, but instantiating wasm is asynchronous, so web needs one awaited call
/// before the first OpenCV call.
Future<void> initDartcv() async {
  _module ??= await _createDartcvModule().toDart;
}
