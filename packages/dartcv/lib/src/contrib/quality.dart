// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.contrib;

import '../bindings/contrib.dart' as ccontrib;
import '../bindings/contrib.dart' as cvg;
import '../core/base.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';

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
    // The paths are raw `calloc` blocks that only this method frees, so release them on the error
    // path too: a create that cannot load the model throws, and that used to leak both strings.
    final arena = Arena();
    try {
      return QualityBRISQUE.fromPointer(
        cvCreate(
          calloc<cvg.QualityBRISQUE>(),
          (p) => ccontrib.cv_quality_QualityBRISQUE_create(
            modelFile.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
            rangeFile.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
            p,
            ffi.nullptr,
          ),
        ),
      );
    } finally {
      arena.releaseAll();
    }
  }

  /// Computes BRISQUE quality score for input image.
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a011769e13ad8537dcec8f698a298ab1b
  Scalar compute(Mat img) {
    return Scalar.fromPointer(
      cvCreate(
        calloc<cvg.Scalar>(),
        (p) => ccontrib.cv_quality_QualityBRISQUE_compute(ref, img.ref, p, ffi.nullptr),
      ),
    );
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat img, {Duration? timeout}) async {
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityBRISQUE_compute(ref, img.ref, p, callback),
      (
        c,
      ) {
        return c.complete(Scalar.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a65b0526a369edf57c03cd1f816083b44
  static Scalar compute1(String modelFile, String rangeFile, Mat img) {
    return using((arena) {
      final p = calloc<cvg.Scalar>();
      final cm = modelFile.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      final cr = rangeFile.toNativeUtf8(allocator: arena).cast<ffi.Char>();
      cvRun(() => ccontrib.cv_quality_QualityBRISQUE_compute_static(img.ref, cm, cr, p, ffi.nullptr));
      return Scalar.fromPointer(p);
    });
  }

  /// async version of [compute1]
  static Future<Scalar> compute1Async(
    String modelFile,
    String rangeFile,
    Mat img, {
    Duration? timeout,
  }) {
    final arena = Arena();
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityBRISQUE_compute_static(
        img.ref,
        modelFile.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        rangeFile.toNativeUtf8(allocator: arena).cast<ffi.Char>(),
        p,
        callback,
      ),
      (c) => c.complete(Scalar.fromPointer(p)),
      timeout: timeout,
      release: arena.releaseAll,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing image features used by the BRISQUE algorithm
  ///
  /// https://docs.opencv.org/4.x/d8/d99/classcv_1_1quality_1_1QualityBRISQUE.html#a71931f138fa9b2db5109e2b50f3a8a74
  static Mat computeFeatures(Mat img, {Mat? features}) {
    features ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_quality_QualityBRISQUE_computeFeatures_static(img.ref, features!.ref, ffi.nullptr),
    );
    return features;
  }

  /// async version of [computeFeatures]
  static Future<Mat> computeFeaturesAsync(Mat img, {Mat? features}) => cvRunAsync0<Mat>(
    (callback) {
      features ??= Mat.empty();
      return ccontrib.cv_quality_QualityBRISQUE_computeFeatures_static(img.ref, features!.ref, callback);
    },
    (c) => c.complete(features),
  );

  static final finalizer = OcvFinalizer<cvg.QualityBRISQUEPtr>(
    ccontrib.addresses.cv_quality_QualityBRISQUE_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_quality_QualityBRISQUE_close(ptr);
  }

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
  factory QualityGMSD.create(Mat img) {
    return QualityGMSD.fromPointer(
      cvCreate(calloc<cvg.QualityGMSD>(), (p) => ccontrib.cv_quality_QualityGMSD_create(img.ref, p)),
    );
  }

  /// Compute GMSD.
  ///
  /// https://docs.opencv.org/4.x/d8/d81/classcv_1_1quality_1_1QualityGMSD.html#a4fbafa647a6fea744a1f5b632fc12c46
  Scalar compute(Mat cmp) {
    return Scalar.fromPointer(
      cvCreate(
        calloc<cvg.Scalar>(),
        (p) => ccontrib.cv_quality_QualityGMSD_compute(ref, cmp.ref, p, ffi.nullptr),
      ),
    );
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp, {Duration? timeout}) async {
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityGMSD_compute(ref, cmp.ref, p, callback),
      (c) {
        return c.complete(Scalar.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d81/classcv_1_1quality_1_1QualityGMSD.html#aa856e2c46c35bbe28fafc76e82e3cda6
  static (Scalar, Mat) compute1(Mat img, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_quality_QualityGMSD_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, ffi.nullptr),
    );
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat img,
    Mat cmp, {
    Mat? qualityMap,
    Duration? timeout,
  }) async {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_quality_QualityGMSD_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, callback),
      (c) {
        return c.complete((Scalar.fromPointer(p), qualityMap!));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static final finalizer = OcvFinalizer<cvg.QualityGMSDPtr>(ccontrib.addresses.cv_quality_QualityGMSD_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_quality_QualityGMSD_close(ptr);
  }

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
  factory QualityMSE.create(Mat img) {
    return QualityMSE.fromPointer(
      cvCreate(
        calloc<cvg.QualityMSE>(),
        (p) => ccontrib.cv_quality_QualityMSE_create(img.ref, p, ffi.nullptr),
      ),
    );
  }

  /// Computes MSE for reference images supplied in class constructor and provided comparison images.
  ///
  /// https://docs.opencv.org/4.x/d7/d80/classcv_1_1quality_1_1QualityMSE.html#a82ba740a06f48562a08517079712218c
  Scalar compute(Mat cmpImgs) {
    return Scalar.fromPointer(
      cvCreate(
        calloc<cvg.Scalar>(),
        (p) => ccontrib.cv_quality_QualityMSE_compute(ref, cmpImgs.ref, p, ffi.nullptr),
      ),
    );
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmpImgs, {Duration? timeout}) async {
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityMSE_compute(ref, cmpImgs.ref, p, callback),
      (
        c,
      ) {
        return c.complete(Scalar.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d7/d80/classcv_1_1quality_1_1QualityMSE.html#a74f0f81437ca1fbb1c058d4fd85454d3
  static (Scalar, Mat qualityMap) compute1(Mat img, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_quality_QualityMSE_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, ffi.nullptr),
    );
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat img,
    Mat cmp, {
    Mat? qualityMap,
    Duration? timeout,
  }) async {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_quality_QualityMSE_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, callback),
      (c) {
        return c.complete((Scalar.fromPointer(p), qualityMap!));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static final finalizer = OcvFinalizer<cvg.QualityMSEPtr>(ccontrib.addresses.cv_quality_QualityMSE_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_quality_QualityMSE_close(ptr);
  }

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
  factory QualityPSNR.create(Mat img, {double maxPixelValue = 255}) {
    return QualityPSNR.fromPointer(
      cvCreate(
        calloc<cvg.QualityPSNR>(),
        (p) => ccontrib.cv_quality_QualityPSNR_create(img.ref, maxPixelValue, p, ffi.nullptr),
      ),
    );
  }

  /// Compute the PSNR.
  ///
  /// https://docs.opencv.org/4.x/d8/d0c/classcv_1_1quality_1_1QualityPSNR.html#a4c08dcc4944fa7ae2bd9dc00607c3f1a
  Scalar compute(Mat cmp) {
    return Scalar.fromPointer(
      cvCreate(
        calloc<cvg.Scalar>(),
        (p) => ccontrib.cv_quality_QualityPSNR_compute(ref, cmp.ref, p, ffi.nullptr),
      ),
    );
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp, {Duration? timeout}) async {
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityPSNR_compute(ref, cmp.ref, p, callback),
      (c) {
        return c.complete(Scalar.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d8/d0c/classcv_1_1quality_1_1QualityPSNR.html#ab9616d5da0df37b5753b99ae6d36ba69
  static (Scalar, Mat qualityMap) compute1(Mat img, Mat cmp, {Mat? qualityMap, double maxPixelValue = 255}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_quality_QualityPSNR_compute_static(
        img.ref,
        cmp.ref,
        maxPixelValue,
        qualityMap!.ref,
        p,
        ffi.nullptr,
      ),
    );
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat img,
    Mat cmp, {
    Mat? qualityMap,
    double maxPixelValue = 255,
    Duration? timeout,
  }) async {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualityPSNR_compute_static(
        img.ref,
        cmp.ref,
        maxPixelValue,
        qualityMap!.ref,
        p,
        callback,
      ),
      (c) {
        return c.complete((Scalar.fromPointer(p), qualityMap!));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  double get maxPixelValue => ccontrib.cv_quality_QualityPSNR_getMaxPixelValue(ref);

  set maxPixelValue(double value) => ccontrib.cv_quality_QualityPSNR_setMaxPixelValue(ref, value);

  static final finalizer = OcvFinalizer<cvg.QualityPSNRPtr>(ccontrib.addresses.cv_quality_QualityPSNR_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_quality_QualityPSNR_close(ptr);
  }

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
  factory QualitySSIM.create(Mat img) {
    return QualitySSIM.fromPointer(
      cvCreate(
        calloc<cvg.QualitySSIM>(),
        (p) => ccontrib.cv_quality_QualitySSIM_create(img.ref, p, ffi.nullptr),
      ),
    );
  }

  /// Computes SSIM.
  ///
  /// https://docs.opencv.org/4.x/d9/db5/classcv_1_1quality_1_1QualitySSIM.html#a49d5ecc72e83b8876c8293244c3667e4
  Scalar compute(Mat cmp) {
    return Scalar.fromPointer(
      cvCreate(
        calloc<cvg.Scalar>(),
        (p) => ccontrib.cv_quality_QualitySSIM_compute(ref, cmp.ref, p, ffi.nullptr),
      ),
    );
  }

  /// async version of [compute]
  Future<Scalar> computeAsync(Mat cmp, {Duration? timeout}) async {
    final p = calloc<cvg.Scalar>();
    return cvRunAsync0(
      (callback) => ccontrib.cv_quality_QualitySSIM_compute(ref, cmp.ref, p, callback),
      (c) {
        return c.complete(Scalar.fromPointer(p));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  /// static method for computing quality
  ///
  /// https://docs.opencv.org/4.x/d9/db5/classcv_1_1quality_1_1QualitySSIM.html#a7f1967a8334e28d8bef80fbe2f340f8c
  static (Scalar, Mat qualityMap) compute1(Mat img, Mat cmp, {Mat? qualityMap}) {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_quality_QualitySSIM_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, ffi.nullptr),
    );
    return (Scalar.fromPointer(p), qualityMap);
  }

  /// async version of [compute1]
  static Future<(Scalar, Mat qualityMap)> compute1Async(
    Mat img,
    Mat cmp, {
    Mat? qualityMap,
    Duration? timeout,
  }) async {
    final p = calloc<cvg.Scalar>();
    qualityMap ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          ccontrib.cv_quality_QualitySSIM_compute_static(img.ref, cmp.ref, qualityMap!.ref, p, callback),
      (c) {
        return c.complete((Scalar.fromPointer(p), qualityMap!));
      },
      timeout: timeout,
      releaseOnFailure: () => calloc.free(p),
    );
  }

  static final finalizer = OcvFinalizer<cvg.QualitySSIMPtr>(ccontrib.addresses.cv_quality_QualitySSIM_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_quality_QualitySSIM_close(ptr);
  }

  @override
  cvg.QualitySSIM get ref => ptr.ref;
}
