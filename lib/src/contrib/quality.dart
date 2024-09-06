// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../g/contrib.g.dart' as cvg;
import '../native_lib.dart' show ccontrib;

class QualityBRISQUE extends CvStruct<cvg.QualityBRISQUE> {
  QualityBRISQUE.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  /// Create an object which calculates quality.
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#aadc3f7629e5552d1bb6f41bd1963cbe0
  factory QualityBRISQUE.create(String modelFile, String rangeFile) {
    final p = calloc<cvg.QualityBRISQUE>();
    final cm = modelFile.toNativeUtf8().cast<ffi.Char>();
    final cr = rangeFile.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.QualityBRISQUE_create(cm, cr, p));
    calloc.free(cm);
    calloc.free(cr);
    return QualityBRISQUE.fromPointer(p, false);
  }

  /// Computes BRISQUE quality score for input image.
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a011769e13ad8537dcec8f698a298ab1b
  Scalar compute(Mat img) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => ccontrib.QualityBRISQUE_compute(ref, img.ref, p));
    return Scalar.fromPointer(p);
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat img) => cvRunAsync<Scalar>(
        (callback) => ccontrib.QualityBRISQUE_compute_async(ref, img.ref, callback),
        scalarCompleter,
      );

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a65b0526a369edf57c03cd1f816083b44
  static Scalar compute1(String modelFile, String rangeFile, Mat img) {
    final p = calloc<cvg.Scalar>();
    final cm = modelFile.toNativeUtf8().cast<ffi.Char>();
    final cr = rangeFile.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.QualityBRISQUE_compute_static(img.ref, cm, cr, p));
    calloc.free(cm);
    calloc.free(cr);
    return Scalar.fromPointer(p);
  }

  /// async version of [compute1]
  static Future<Scalar> compute1Async(String modelFile, String rangeFile, Mat img) => cvRunAsync<Scalar>(
        (callback) {
          final cm = modelFile.toNativeUtf8().cast<ffi.Char>();
          final cr = rangeFile.toNativeUtf8().cast<ffi.Char>();
          final status = ccontrib.QualityBRISQUE_compute_static_async(img.ref, cm, cr, callback);
          calloc.free(cm);
          calloc.free(cr);
          return status;
        },
        scalarCompleter,
      );

  /// static method for computing image features used by the BRISQUE algorithm
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a71931f138fa9b2db5109e2b50f3a8a74
  static Mat computeFeatures(Mat img, {Mat? features}) {
    features ??= Mat.empty();
    cvRun(() => ccontrib.QualityBRISQUE_computeFeatures_static(img.ref, features!.ref));
    return features;
  }

  /// async version of [computeFeatures]
  static Future<Mat> computeFeaturesAsync(Mat img, {Mat? features}) => cvRunAsync0<Mat>(
        (callback) {
          features ??= Mat.empty();
          final status =
              ccontrib.QualityBRISQUE_computeFeatures_static_async(img.ref, features!.ref, callback);
          return status;
        },
        (c) => c.complete(features),
      );

  static final finalizer = OcvFinalizer<cvg.QualityBRISQUEPtr>(ccontrib.addresses.QualityBRISQUE_close);
  @override
  cvg.QualityBRISQUE get ref => ptr.ref;
}

class QualityGMSD extends CvStruct<cvg.QualityGMSD> {
  QualityGMSD.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  /// Create an object which calculates quality.
  ///
  /// https://docs.opencv.org/4.x/d8/d81/classcv_1_1quality_1_1QualityGMSD.html#af1c9e3cdf594358f47504a8b6b42f583
  factory QualityGMSD.create(Mat ref) {
    final p = calloc<cvg.QualityGMSD>();
    cvRun(() => ccontrib.QualityGMSD_create(ref.ref, p));
    return QualityGMSD.fromPointer(p, false);
  }

  /// Compute GMSD.
  ///
  /// https://docs.opencv.org/4.x/d8/d81/classcv_1_1quality_1_1QualityGMSD.html#a4fbafa647a6fea744a1f5b632fc12c46
  Scalar compute(Mat cmp) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => ccontrib.QualityGMSD_compute(ref, cmp.ref, p));
    return Scalar.fromPointer(p);
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp) => cvRunAsync<Scalar>(
        (callback) => ccontrib.QualityGMSD_compute_async(ref, cmp.ref, callback),
        scalarCompleter,
      );

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d81/classcv_1_1quality_1_1QualityGMSD.html#aa856e2c46c35bbe28fafc76e82e3cda6
  static (Scalar, Mat) compute1(Mat ref, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(() => ccontrib.QualityGMSD_compute_static(ref.ref, cmp.ref, qualityMap!.ref, p));
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(Mat ref, Mat cmp, {Mat? qualityMap}) =>
      cvRunAsync1<(Scalar, Mat)>(
        (callback) {
          qualityMap ??= Mat.empty();
          final status =
              ccontrib.QualityGMSD_compute_static_async(ref.ref, cmp.ref, qualityMap!.ref, callback);
          return status;
        },
        (c, p) => c.complete((Scalar.fromPointer(p.cast<cvg.Scalar>()), qualityMap!)),
      );

  static final finalizer = OcvFinalizer<cvg.QualityGMSDPtr>(ccontrib.addresses.QualityGMSD_close);
  @override
  cvg.QualityGMSD get ref => ptr.ref;
}

class QualityMSE extends CvStruct<cvg.QualityMSE> {
  QualityMSE.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  /// Create an object which calculates quality.
  ///
  /// https://docs.opencv.org/4.x/d7/d80/classcv_1_1quality_1_1QualityMSE.html#a74f0f81437ca1fbb1c058d4fd85454d3
  factory QualityMSE.create(Mat ref) {
    final p = calloc<cvg.QualityMSE>();
    cvRun(() => ccontrib.QualityMSE_create(ref.ref, p));
    return QualityMSE.fromPointer(p, false);
  }

  /// Computes MSE for reference images supplied in class constructor and provided comparison images.
  ///
  /// https://docs.opencv.org/4.x/d7/d80/classcv_1_1quality_1_1QualityMSE.html#a82ba740a06f48562a08517079712218c
  Scalar compute(Mat cmpImgs) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => ccontrib.QualityMSE_compute(ref, cmpImgs.ref, p));
    return Scalar.fromPointer(p);
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmpImgs) => cvRunAsync<Scalar>(
        (callback) => ccontrib.QualityMSE_compute_async(ref, cmpImgs.ref, callback),
        (c, p) => c.complete(Scalar.fromPointer(p.cast<cvg.Scalar>())),
      );

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d7/d80/classcv_1_1quality_1_1QualityMSE.html#a74f0f81437ca1fbb1c058d4fd85454d3
  static (Scalar, Mat qualityMap) compute1(Mat ref, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(() => ccontrib.QualityMSE_compute_static(ref.ref, cmp.ref, qualityMap!.ref, p));
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(Mat ref, Mat cmp, {Mat? qualityMap}) =>
      cvRunAsync1<(Scalar, Mat)>(
        (callback) {
          qualityMap ??= Mat.empty();
          final status =
              ccontrib.QualityMSE_compute_static_async(ref.ref, cmp.ref, qualityMap!.ref, callback);
          return status;
        },
        (c, p) => c.complete((Scalar.fromPointer(p.cast<cvg.Scalar>()), qualityMap!)),
      );

  static final finalizer = OcvFinalizer<cvg.QualityMSEPtr>(ccontrib.addresses.QualityMSE_close);
  @override
  cvg.QualityMSE get ref => ptr.ref;
}

class QualityPSNR extends CvStruct<cvg.QualityPSNR> {
  QualityPSNR.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  /// Create an object which calculates quality.
  ///
  /// https://docs.opencv.org/4.x/d8/d0c/classcv_1_1quality_1_1QualityPSNR.html#a458e57903165a07be261e8ab7cf121d3
  factory QualityPSNR.create(Mat ref, {double maxPixelValue = 255}) {
    final p = calloc<cvg.QualityPSNR>();
    cvRun(() => ccontrib.QualityPSNR_create(ref.ref, maxPixelValue, p));
    return QualityPSNR.fromPointer(p, false);
  }

  /// Compute the PSNR.
  ///
  /// https://docs.opencv.org/4.x/d8/d0c/classcv_1_1quality_1_1QualityPSNR.html#a4c08dcc4944fa7ae2bd9dc00607c3f1a
  Scalar compute(Mat cmp) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => ccontrib.QualityPSNR_compute(ref, cmp.ref, p));
    return Scalar.fromPointer(p);
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp) => cvRunAsync<Scalar>(
        (callback) => ccontrib.QualityPSNR_compute_async(ref, cmp.ref, callback),
        scalarCompleter,
      );

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d0c/classcv_1_1quality_1_1QualityPSNR.html#ab9616d5da0df37b5753b99ae6d36ba69
  static (Scalar, Mat qualityMap) compute1(Mat ref, Mat cmp, {Mat? qualityMap, double maxPixelValue = 255}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(() => ccontrib.QualityPSNR_compute_static(ref.ref, cmp.ref, maxPixelValue, qualityMap!.ref, p));
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat ref,
    Mat cmp, {
    Mat? qualityMap,
    double maxPixelValue = 255,
  }) =>
      cvRunAsync<(Scalar, Mat)>(
        (callback) {
          qualityMap ??= Mat.empty();
          final status = ccontrib.QualityPSNR_compute_static_async(
            ref.ref,
            cmp.ref,
            maxPixelValue,
            qualityMap!.ref,
            callback,
          );
          return status;
        },
        (c, p) => c.complete((Scalar.fromPointer(p.cast<cvg.Scalar>()), qualityMap!)),
      );

  double get maxPixelValue => ccontrib.QualityPSNR_getMaxPixelValue(ref);
  set maxPixelValue(double value) => ccontrib.QualityPSNR_setMaxPixelValue(ref, value);

  static final finalizer = OcvFinalizer<cvg.QualityPSNRPtr>(ccontrib.addresses.QualityPSNR_close);
  @override
  cvg.QualityPSNR get ref => ptr.ref;
}

class QualitySSIM extends CvStruct<cvg.QualitySSIM> {
  QualitySSIM.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  /// Create an object which calculates quality.
  ///
  /// https://docs.opencv.org/4.x/d9/db5/classcv_1_1quality_1_1QualitySSIM.html#a4ec6e4557fd24782e619f00852ea3289
  factory QualitySSIM.create(Mat ref) {
    final p = calloc<cvg.QualitySSIM>();
    cvRun(() => ccontrib.QualitySSIM_create(ref.ref, p));
    return QualitySSIM.fromPointer(p, false);
  }

  /// Computes SSIM.
  ///
  /// https://docs.opencv.org/4.x/d9/db5/classcv_1_1quality_1_1QualitySSIM.html#a49d5ecc72e83b8876c8293244c3667e4
  Scalar compute(Mat cmp) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => ccontrib.QualitySSIM_compute(ref, cmp.ref, p));
    return Scalar.fromPointer(p);
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp) => cvRunAsync<Scalar>(
        (callback) => ccontrib.QualitySSIM_compute_async(ref, cmp.ref, callback),
        scalarCompleter,
      );

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d9/db5/classcv_1_1quality_1_1QualitySSIM.html#a7f1967a8334e28d8bef80fbe2f340f8c
  static (Scalar, Mat qualityMap) compute1(Mat ref, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(() => ccontrib.QualitySSIM_compute_static(ref.ref, cmp.ref, qualityMap!.ref, p));
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat ref,
    Mat cmp, {
    Mat? qualityMap,
  }) =>
      cvRunAsync<(Scalar, Mat)>(
        (callback) {
          qualityMap ??= Mat.empty();
          final status =
              ccontrib.QualitySSIM_compute_static_async(ref.ref, cmp.ref, qualityMap!.ref, callback);
          return status;
        },
        (c, p) => c.complete((Scalar.fromPointer(p.cast<cvg.Scalar>()), qualityMap!)),
      );

  static final finalizer = OcvFinalizer<cvg.QualitySSIMPtr>(ccontrib.addresses.QualitySSIM_close);
  @override
  cvg.QualitySSIM get ref => ptr.ref;
}
