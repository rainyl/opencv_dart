// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/core.g.dart' as ccore;
import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'mat.dart';
import 'mat_type.dart';
import 'rect.dart';
import 'scalar.dart';

extension MatAsync on Mat {
  static Future<Mat> emptyAsync() async => Mat.empty();

  static Future<Mat> fromScalarAsync(int rows, int cols, MatType type, Scalar s) async {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0(
      (callback) => ccore.cv_Mat_create_5(s.ref, rows, cols, type.value, p, callback),
      (c) => c.complete(Mat.fromPointer(p, externalSize: rows * cols * type.elemSize)),
    );
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

  static Future<Mat> eyeAsync(int rows, int cols, MatType type) async {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_eye(rows, cols, type.value, p, callback),
      (c) => c.complete(Mat.fromPointer(p, externalSize: rows * cols * type.elemSize)),
    );
  }

  static Future<Mat> zerosAsync(int rows, int cols, MatType type) async {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_zeros(rows, cols, type.value, p, callback),
      (c) => c.complete(Mat.fromPointer(p, externalSize: rows * cols * type.elemSize)),
    );
  }

  static Future<Mat> onesAsync(int rows, int cols, MatType type) async {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_ones(rows, cols, type.value, p, callback),
      (c) => c.complete(Mat.fromPointer(p, externalSize: rows * cols * type.elemSize)),
    );
  }

  Future<Mat> cloneAsync() async {
    final dst = Mat.empty();
    return cvRunAsync0((callback) => ccore.cv_Mat_clone(ref, dst.ptr, callback), (c) => c.complete(dst));
  }

  Future<void> copyToAsync(Mat dst, {Mat? mask}) async => cvRunAsync0(
        (callback) => mask == null
            ? ccore.cv_Mat_copyTo(ref, dst.ref, callback)
            : ccore.cv_Mat_copyTo_1(ref, dst.ref, mask.ref, callback),
        (c) => c.complete(),
      );

  Future<Mat> convertToAsync(MatType type, {double alpha = 1, double beta = 0}) async {
    final dst = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_convertTo_1(ref, dst.ref, type.value, alpha, beta, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Mat> regionAsync(Rect rect) async {
    final dst = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_region(ref, rect.ref, dst.ptr, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Mat> reshapeAsync(int cn, [int rows = 0]) async {
    final dst = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_Mat_reshape(ref, cn, rows, dst.ptr, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Mat> rotateAsync(int rotationCode, {bool inplace = false}) async {
    final dst = inplace ? this : clone();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_rotate(ref, dst.ref, rotationCode, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Mat> rowRangeAsync(int start, int end) async {
    final dst = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_rowRange(ref, start, end, dst.ptr, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Mat> colRangeAsync(int start, int end) async {
    final dst = Mat.empty();
    return cvRunAsync0<Mat>(
      (callback) => ccore.cv_colRange(ref, start, end, dst.ptr, callback),
      (c) => c.complete(dst),
    );
  }

  Future<Scalar> meanAsync({Mat? mask}) async {
    final s = calloc<cvg.Scalar>();
    return cvRunAsync0<Scalar>(
      (callback) {
        return mask == null
            ? ccore.cv_Mat_mean(ref, s, callback)
            : ccore.cv_Mat_mean_1(ref, mask.ref, s, callback);
      },
      (c) => c.complete(Scalar.fromPointer(s)),
    );
  }

  /// Calculates a square root of array elements.
  Future<Mat> sqrtAsync() async {
    cvAssert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F);
    final dst = Mat.empty();
    return cvRunAsync0<Mat>((callback) => ccore.cv_Mat_sqrt(ref, dst.ref, callback), (c) => c.complete(dst));
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Future<Scalar> sumAsync() async {
    final s = calloc<cvg.Scalar>();
    return cvRunAsync0<Scalar>(
      (callback) => ccore.cv_sum(ref, s, callback),
      (c) => c.complete(Scalar.fromPointer(s)),
    );
  }

  /// PatchNaNs converts NaN's to zeros.
  Future<void> patchNaNsAsync({double val = 0.0}) async =>
      cvRunAsync0<void>((callback) => ccore.cv_Mat_patchNaNs(ref, val, callback), (c) => c.complete());
}
