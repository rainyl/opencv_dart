import 'dart:async';

import '../g/core.g.dart' as ccore;
import 'base.dart';
import 'mat.dart';
import 'mat_type.dart';
import 'point.dart';
import 'rect.dart';
import 'scalar.dart';
import 'vec.dart';

extension MatAsync on Mat {
  static Future<Mat> emptyAsync() async => cvRunAsync(ccore.Mat_New_Async, matCompleter);

  static Future<Mat> fromScalarAsync(int rows, int cols, MatType type, Scalar s) async => cvRunAsync(
        (callback) => ccore.Mat_NewFromScalar_Async(s.ref, rows, cols, type.value, callback),
        matCompleter,
      );

  static Future<Mat> fromVecAsync(Vec vec) async {
    if (vec is VecPoint) {
      return cvRunAsync((callback) => ccore.Mat_NewFromVecPoint_Async(vec.ref, callback), matCompleter);
    } else if (vec is VecPoint2f) {
      return cvRunAsync((callback) => ccore.Mat_NewFromVecPoint2f_Async(vec.ref, callback), matCompleter);
    } else if (vec is VecPoint3f) {
      return cvRunAsync((callback) => ccore.Mat_NewFromVecPoint3f_Async(vec.ref, callback), matCompleter);
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
      cvRunAsync((callback) => ccore.Mat_Eye_Async(rows, cols, type.value, callback), matCompleter);

  static Future<Mat> zerosAsync(int rows, int cols, MatType type) async =>
      cvRunAsync((callback) => ccore.Mat_Zeros_Async(rows, cols, type.value, callback), matCompleter);

  static Future<Mat> onesAsync(int rows, int cols, MatType type) async =>
      cvRunAsync((callback) => ccore.Mat_Ones_Async(rows, cols, type.value, callback), matCompleter);

  Future<Mat> cloneAsync() async =>
      cvRunAsync((callback) => ccore.Mat_Clone_Async(ref, callback), matCompleter);

  Future<void> copyToAsync(Mat dst, {Mat? mask}) async => cvRunAsync0(
        (callback) => mask == null
            ? ccore.Mat_CopyTo_Async(ref, dst.ref, callback)
            : ccore.Mat_CopyToWithMask_Async(ref, dst.ref, mask.ref, callback),
        voidCompleter,
      );

  Future<Mat> convertToAsync(MatType type, {double alpha = 1, double beta = 0}) async => cvRunAsync(
        (callback) => ccore.Mat_ConvertToWithParams_Async(ref, type.value, alpha, beta, callback),
        matCompleter,
      );

  Future<Mat> regionAsync(Rect rect) async => cvRunAsync(
        (callback) => ccore.Mat_Region_Async(ref, rect.ref, callback),
        matCompleter,
      );

  Future<Mat> reshapeAsync(int cn, int rows) async => cvRunAsync(
        (callback) => ccore.Mat_Reshape_Async(ref, cn, rows, callback),
        matCompleter,
      );

  Future<Mat> rotateAsync(int rotationCode) async => cvRunAsync<Mat>(
        (callback) => ccore.core_Rotate_Async(ref, rotationCode, callback),
        matCompleter,
      );

  Future<Mat> rowRangeAsync(int start, int end) async => cvRunAsync<Mat>(
        (callback) => ccore.core_rowRange_Async(ref, start, end, callback),
        matCompleter,
      );

  Future<Mat> colRangeAsync(int start, int end) async => cvRunAsync<Mat>(
        (callback) => ccore.core_colRange_Async(ref, start, end, callback),
        matCompleter,
      );

  Future<Scalar> meanAsync({Mat? mask}) async => cvRunAsync(
        (callback) => mask == null
            ? ccore.core_Mean_Async(ref, callback)
            : ccore.core_MeanWithMask_Async(ref, mask.ref, callback),
        scalarCompleter,
      );

  /// Calculates a square root of array elements.
  Future<Mat> sqrtAsync() async =>
      cvRunAsync((callback) => ccore.core_Sqrt_Async(ref, callback), matCompleter);

  /// Sum calculates the per-channel pixel sum of an image.
  Future<Scalar> sumAsync() async =>
      cvRunAsync((callback) => ccore.core_Sum_Async(ref, callback), scalarCompleter);

  /// PatchNaNs converts NaN's to zeros.
  Future<void> patchNaNsAsync({double val = 0.0}) async =>
      cvRunAsync0((callback) => ccore.core_PatchNaNs_Async(ref, val, callback), voidCompleter);
}
