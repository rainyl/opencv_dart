import 'dart:async';

import 'package:opencv_dart/opencv_dart.dart';

extension MatAsync on Mat {
  static Future<Mat> emptyAsync() async => cvRunAsync(CFFI.Mat_New_Async, matCompleter);

  static Future<Mat> fromScalarAsync(int rows, int cols, MatType type, Scalar s) async => cvRunAsync(
        (callback) => CFFI.Mat_NewFromScalar_Async(s.ref, rows, cols, type.toInt32(), callback),
        matCompleter,
      );

  static Future<Mat> fromVecAsync(Vec vec) async {
    if (vec is VecPoint) {
      return cvRunAsync((callback) => CFFI.Mat_NewFromVecPoint_Async(vec.ref, callback), matCompleter);
    } else if (vec is VecPoint2f) {
      return cvRunAsync((callback) => CFFI.Mat_NewFromVecPoint2f_Async(vec.ref, callback), matCompleter);
    } else if (vec is VecPoint3f) {
      return cvRunAsync((callback) => CFFI.Mat_NewFromVecPoint3f_Async(vec.ref, callback), matCompleter);
    } else {
      throw UnsupportedError("Unsupported Vec type ${vec.runtimeType}");
    }
  }

  static Future<Mat> createAsync({
    int rows = 0,
    int cols = 0,
    int r = 0,
    int g = 0,
    int b = 0,
    MatType? type,
  }) async =>
      Mat.fromScalar(
        rows,
        cols,
        type ?? MatType.CV_8UC3,
        Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0),
      );

  static Future<Mat> eyeAsync(int rows, int cols, MatType type) async =>
      cvRunAsync((callback) => CFFI.Mat_Eye_Async(rows, cols, type.toInt32(), callback), matCompleter);

  static Future<Mat> zerosAsync(int rows, int cols, MatType type) async =>
      cvRunAsync((callback) => CFFI.Mat_Zeros_Async(rows, cols, type.toInt32(), callback), matCompleter);

  static Future<Mat> onesAsync(int rows, int cols, MatType type) async =>
      cvRunAsync((callback) => CFFI.Mat_Ones_Async(rows, cols, type.toInt32(), callback), matCompleter);

  Future<Mat> cloneAsync() async =>
      cvRunAsync((callback) => CFFI.Mat_Clone_Async(ref, callback), matCompleter);

  Future<void> copyToAsync(Mat dst, {Mat? mask}) async => cvRunAsync0(
        (callback) => mask == null
            ? CFFI.Mat_CopyTo_Async(ref, dst.ref, callback)
            : CFFI.Mat_CopyToWithMask_Async(ref, dst.ref, mask.ref, callback),
        voidCompleter,
      );

  Future<Mat> convertToAsync(MatType type, {double alpha = 1, double beta = 0}) async => cvRunAsync(
        (callback) => CFFI.Mat_ConvertToWithParams_Async(ref, type.toInt32(), alpha, beta, callback),
        matCompleter,
      );

  Future<Mat> regionAsync(Rect rect) async => cvRunAsync(
        (callback) => CFFI.Mat_Region_Async(ref, rect.ref, callback),
        matCompleter,
      );

  Future<Mat> reshapeAsync(int cn, int rows) async => cvRunAsync(
        (callback) => CFFI.Mat_Reshape_Async(ref, cn, rows, callback),
        matCompleter,
      );

  Future<Mat> rotateAsync(int rotationCode, {bool inplace = false}) async => cvRunAsync<Mat>(
        (callback) => CFFI.core_Rotate_Async(ref, rotationCode, callback),
        matCompleter,
      );

  Future<Mat> rowRangeAsync(int start, int end) async => cvRunAsync<Mat>(
        (callback) => CFFI.core_rowRange_Async(ref, start, end, callback),
        matCompleter,
      );

  Future<Mat> colRangeAsync(int start, int end) async => cvRunAsync<Mat>(
        (callback) => CFFI.core_colRange_Async(ref, start, end, callback),
        matCompleter,
      );

  Future<Scalar> meanAsync({Mat? mask}) async => cvRunAsync(
        (callback) => mask == null
            ? CFFI.core_Mean_Async(ref, callback)
            : CFFI.core_MeanWithMask_Async(ref, mask.ref, callback),
        scalarCompleter,
      );

  /// Calculates a square root of array elements.
  Future<Mat> sqrtAsync() async =>
      cvRunAsync((callback) => CFFI.core_Sqrt_Async(ref, callback), matCompleter);

  /// Sum calculates the per-channel pixel sum of an image.
  Future<Scalar> sumAsync() async =>
      cvRunAsync((callback) => CFFI.core_Sum_Async(ref, callback), scalarCompleter);

  /// PatchNaNs converts NaN's to zeros.
  Future<void> patchNaNsAsync({double val = 0.0}) async =>
      cvRunAsync0((callback) => CFFI.core_PatchNaNs_Async(ref, val, callback), voidCompleter);
}
