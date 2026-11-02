// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// Spike, path 2: bind the official prebuilt opencv.js (embind API, global `cv`) instead of
// building the dartcv C wrapper. Kept beside the wasm path only to compare the two.

import 'dart:js_interop';
import 'dart:typed_data';

@JS('cv')
external CvJs get cvjs;

extension type CvJs._(JSObject _) implements JSObject {
  external void cvtColor(MatJs src, MatJs dst, int code);
  @JS('GaussianBlur')
  external void gaussianBlur(
    MatJs src,
    MatJs dst,
    SizeJs ksize,
    double sigmaX,
    double sigmaY,
    int borderType,
  );
  external MatJs matFromArray(int rows, int cols, int type, JSArray<JSNumber> data);
  external MatJs matFromImageData(JSObject imageData);
  external String getBuildInformation();
  // opencv.js throws a raw C++ exception pointer (a JS number) on cv::Exception;
  // this turns it into a message.
  external String exceptionFromPtr(int ptr);
}

@JS('cv.Mat')
extension type MatJs._(JSObject _) implements JSObject {
  external MatJs();
  external int get rows;
  external int get cols;
  external int type();
  external int channels();
  external JSUint8Array get data;
  @JS('delete')
  external void delete_();
}

@JS('cv.Size')
extension type SizeJs._(JSObject _) implements JSObject {
  external SizeJs(int width, int height);
}

// Set up by the page (tool/web/demo/index.html): resolves once `cv` is the ready runtime.
// opencv.js exposes `cv` either as a Promise or as a Module with onRuntimeInitialized,
// depending on build and loader.
@JS('cvReady')
external JSPromise<JSAny?> get _cvReady;

Future<void> initOpenCvJs() => _cvReady.toDart;

// opencv.js has no imgcodecs (no imdecode/imencode): decoding has to go through the browser
// (createImageBitmap + canvas), which is async-only and always yields RGBA.
@JS('decodeToImageData')
external JSPromise<JSObject> _decodeToImageData(JSUint8Array bytes);

Future<MatJs> imdecodeOpenCvJs(Uint8List bytes) async {
  final imageData = await _decodeToImageData(bytes.toJS).toDart;
  return cvjs.matFromImageData(imageData);
}

Uint8List matJsData(MatJs m) => m.data.toDart;
