// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv.features2d;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/dmatch.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/constants.g.dart';
import '../g/features2d.g.dart' as cvg;
import '../native_lib.dart' show cfeatures2d;

/// AKAZE is a wrapper around the cv::AKAZE algorithm.
class AKAZE extends CvStruct<cvg.AKAZE> {
  AKAZE._(cvg.AKAZEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory AKAZE.fromPointer(cvg.AKAZEPtr ptr, [bool attach = true]) => AKAZE._(ptr, attach);

  /// returns a new AKAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory AKAZE.empty() {
    final p = calloc<cvg.AKAZE>();
    cvRun(() => cfeatures2d.cv_AKAZE_create(p));
    return AKAZE._(p);
  }

  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_AKAZE_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint ret, Mat desc) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.cv_AKAZE_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret, ffi.nullptr),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cvg.AKAZEPtr>(cfeatures2d.addresses.cv_AKAZE_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_AKAZE_close(ptr);
  }

  @override
  cvg.AKAZE get ref => ptr.ref;
}

/// AgastFeatureDetector is a wrapper around the cv::AgastFeatureDetector.
class AgastFeatureDetector extends CvStruct<cvg.AgastFeatureDetector> {
  AgastFeatureDetector._(cvg.AgastFeatureDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory AgastFeatureDetector.fromPointer(cvg.AgastFeatureDetectorPtr ptr, [bool attach = true]) =>
      AgastFeatureDetector._(ptr, attach);

  /// returns a new AgastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/d19/classcv_1_1AgastFeatureDetector.html
  factory AgastFeatureDetector.empty() {
    final p = calloc<cvg.AgastFeatureDetector>();
    cvRun(() => cfeatures2d.cv_AgastFeatureDetector_create(p));
    return AgastFeatureDetector._(p);
  }

  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_AgastFeatureDetector_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.AgastFeatureDetectorPtr>(
    cfeatures2d.addresses.cv_AgastFeatureDetector_close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_AgastFeatureDetector_close(ptr);
  }

  @override
  cvg.AgastFeatureDetector get ref => ptr.ref;
}

/// BRISK is a wrapper around the cv::BRISK algorithm.
class BRISK extends CvStruct<cvg.BRISK> {
  BRISK._(cvg.BRISKPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BRISK.fromPointer(cvg.BRISKPtr ptr, [bool attach = true]) => BRISK._(ptr, attach);

  /// returns a new BRISK algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory BRISK.empty() {
    final p = calloc<cvg.BRISK>();
    cvRun(() => cfeatures2d.cv_BRISK_create(p));
    return BRISK._(p);
  }

  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_BRISK_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.cv_BRISK_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret, ffi.nullptr),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cvg.BRISKPtr>(cfeatures2d.addresses.cv_BRISK_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_BRISK_close(ptr);
  }

  @override
  cvg.BRISK get ref => ptr.ref;
}

enum FastFeatureDetectorType {
  /// FastFeatureDetector::TYPE_5_8
  TYPE_5_8(0),

  /// FastFeatureDetector::TYPE_7_12
  TYPE_7_12(1),

  /// FastFeatureDetector::TYPE_9_16
  TYPE_9_16(2);

  const FastFeatureDetectorType(this.value);
  final int value;
}

/// FastFeatureDetector is a wrapper around the cv::FastFeatureDetector.
class FastFeatureDetector extends CvStruct<cvg.FastFeatureDetector> {
  FastFeatureDetector._(cvg.FastFeatureDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FastFeatureDetector.fromPointer(cvg.FastFeatureDetectorPtr ptr, [bool attach = true]) =>
      FastFeatureDetector._(ptr, attach);

  /// returns a new FastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html
  factory FastFeatureDetector.empty() {
    final p = calloc<cvg.FastFeatureDetector>();
    cvRun(() => cfeatures2d.cv_FastFeatureDetector_create(p));
    return FastFeatureDetector._(p);
  }

  /// returns a new FastFeatureDetector algorithm with parameters
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html#ab986f2ff8f8778aab1707e2642bc7f8e
  factory FastFeatureDetector.create({
    int threshold = 10,
    bool nonmaxSuppression = true,
    FastFeatureDetectorType type = FastFeatureDetectorType.TYPE_9_16,
  }) {
    final p = calloc<cvg.FastFeatureDetector>();
    cvRun(
      () => cfeatures2d.cv_FastFeatureDetector_create_1(
        threshold,
        nonmaxSuppression,
        type.value,
        p,
      ),
    );
    return FastFeatureDetector._(p);
  }

  /// Detect keypoints in an image using FastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_FastFeatureDetector_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.FastFeatureDetectorPtr>(
    cfeatures2d.addresses.cv_FastFeatureDetector_close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_FastFeatureDetector_close(ptr);
  }

  @override
  cvg.FastFeatureDetector get ref => ptr.ref;
}

/// GFTTDetector is a wrapper around the cv::GFTTDetector.
class GFTTDetector extends CvStruct<cvg.GFTTDetector> {
  GFTTDetector._(cvg.GFTTDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory GFTTDetector.fromPointer(cvg.GFTTDetectorPtr ptr, [bool attach = true]) =>
      GFTTDetector._(ptr, attach);

  /// returns a new GFTTDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d21/classcv_1_1GFTTDetector.html
  factory GFTTDetector.empty() {
    final p = calloc<cvg.GFTTDetector>();
    cvRun(() => cfeatures2d.cv_GFTTDetector_create(p));
    return GFTTDetector._(p);
  }

  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_GFTTDetector_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.GFTTDetectorPtr>(cfeatures2d.addresses.cv_GFTTDetector_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_GFTTDetector_close(ptr);
  }

  @override
  cvg.GFTTDetector get ref => ptr.ref;
}

/// KAZE is a wrapper around the cv::KAZE.
class KAZE extends CvStruct<cvg.KAZE> {
  KAZE._(cvg.KAZEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory KAZE.fromPointer(cvg.KAZEPtr ptr, [bool attach = true]) => KAZE._(ptr, attach);

  /// returns a new KAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory KAZE.empty() {
    final p = calloc<cvg.KAZE>();
    cvRun(() => cfeatures2d.cv_KAZE_create(p));
    return KAZE._(p);
  }

  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_KAZE_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.cv_KAZE_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret, ffi.nullptr),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cvg.KAZEPtr>(cfeatures2d.addresses.cv_KAZE_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_KAZE_close(ptr);
  }

  @override
  cvg.KAZE get ref => ptr.ref;
}

/// MSER is a wrapper around the cv::MSER.
class MSER extends CvStruct<cvg.MSER> {
  MSER._(cvg.MSERPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory MSER.fromPointer(cvg.MSERPtr ptr, [bool attach = true]) => MSER._(ptr, attach);

  /// returns a new MSER algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory MSER.empty() {
    final p = calloc<cvg.MSER>();
    cvRun(() => cfeatures2d.cv_MSER_create(p));
    return MSER._(p);
  }

  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_MSER_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.MSERPtr>(cfeatures2d.addresses.cv_MSER_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_MSER_close(ptr);
  }

  @override
  cvg.MSER get ref => ptr.ref;
}

enum ORBScoreType {
  HARRIS_SCORE(0),
  FAST_SCORE(1);

  const ORBScoreType(this.value);
  final int value;
}

/// ORB is a wrapper around the cv::ORB.
class ORB extends CvStruct<cvg.ORB> {
  ORB._(cvg.ORBPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
    }
  }
  factory ORB.fromPointer(cvg.ORBPtr ptr, [bool attach = true]) => ORB._(ptr, attach);

  /// returns a new ORB algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory ORB.empty() {
    final p = calloc<cvg.ORB>();
    cvRun(() => cfeatures2d.cv_ORB_create(p));
    return ORB._(p);
  }

  /// returns a new ORB algorithm with parameters
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d95/classcv_1_1ORB.html#aeff0cbe668659b7ca14bb85ff1c4073b
  factory ORB.create({
    int nFeatures = 500,
    double scaleFactor = 1.2,
    int nLevels = 8,
    int edgeThreshold = 31,
    int firstLevel = 0,
    int WTA_K = 2,
    ORBScoreType scoreType = ORBScoreType.HARRIS_SCORE,
    int patchSize = 31,
    int fastThreshold = 20,
  }) {
    final p = calloc<cvg.ORB>();
    cvRun(
      () => cfeatures2d.cv_ORB_create_1(
        nFeatures,
        scaleFactor,
        nLevels,
        edgeThreshold,
        firstLevel,
        WTA_K,
        scoreType.value,
        patchSize,
        fastThreshold,
        p,
      ),
    );
    return ORB._(p);
  }

  /// Detect keypoints in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_ORB_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final pdesc = calloc<cvg.Mat>();
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_ORB_detectAndCompute(ref, src.ref, mask.ref, pdesc, ret, ffi.nullptr));
    return (VecKeyPoint.fromPointer(ret), Mat.fromPointer(pdesc));
  }

  static final finalizer = OcvFinalizer<cvg.ORBPtr>(cfeatures2d.addresses.cv_ORB_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_ORB_close(ptr);
  }

  @override
  cvg.ORB get ref => ptr.ref;
}

class SimpleBlobDetectorParams extends CvStruct<cvg.SimpleBlobDetectorParams> {
  SimpleBlobDetectorParams._(
    ffi.Pointer<cvg.SimpleBlobDetectorParams> ptr, [
    bool attach = true,
  ]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SimpleBlobDetectorParams.empty() {
    final p = calloc<cvg.SimpleBlobDetectorParams>();
    cvRun(() => cfeatures2d.cv_SimpleBlobDetectorParams_create(p));
    return SimpleBlobDetectorParams._(p);
  }

  factory SimpleBlobDetectorParams({
    int? blobColor,
    bool? filterByArea,
    bool? filterByCircularity,
    bool? filterByColor,
    bool? filterByConvexity,
    bool? filterByInertia,
    double? maxArea,
    double? maxCircularity,
    double? maxConvexity,
    double? maxInertiaRatio,
    double? maxThreshold,
    double? minArea,
    double? minCircularity,
    double? minConvexity,
    double? minDistBetweenBlobs,
    double? minInertiaRatio,
    int? minRepeatability,
    double? minThreshold,
    double? thresholdStep,
  }) {
    final p = calloc<cvg.SimpleBlobDetectorParams>();
    if (blobColor != null) p.ref.blobColor = blobColor;
    if (filterByArea != null) p.ref.filterByArea = filterByArea;
    if (filterByCircularity != null) {
      p.ref.filterByCircularity = filterByCircularity;
    }
    if (filterByColor != null) p.ref.filterByColor = filterByColor;
    if (filterByConvexity != null) p.ref.filterByConvexity = filterByConvexity;
    if (filterByInertia != null) p.ref.filterByInertia = filterByInertia;
    if (maxArea != null) p.ref.maxArea = maxArea;
    if (maxCircularity != null) p.ref.maxCircularity = maxCircularity;
    if (maxConvexity != null) p.ref.maxConvexity = maxConvexity;
    if (maxInertiaRatio != null) p.ref.maxInertiaRatio = maxInertiaRatio;
    if (maxThreshold != null) p.ref.maxThreshold = maxThreshold;
    if (minArea != null) p.ref.minArea = minArea;
    if (minCircularity != null) p.ref.minCircularity = minCircularity;
    if (minConvexity != null) p.ref.minConvexity = minConvexity;
    if (minDistBetweenBlobs != null) {
      p.ref.minDistBetweenBlobs = minDistBetweenBlobs;
    }
    if (minInertiaRatio != null) p.ref.minInertiaRatio = minInertiaRatio;
    if (minRepeatability != null) p.ref.minRepeatability = minRepeatability;
    if (minThreshold != null) p.ref.minThreshold = minThreshold;
    if (thresholdStep != null) p.ref.thresholdStep = thresholdStep;

    return SimpleBlobDetectorParams._(p);
  }

  factory SimpleBlobDetectorParams.fromNative(cvg.SimpleBlobDetectorParams r) => SimpleBlobDetectorParams(
        blobColor: r.blobColor,
        filterByArea: r.filterByArea,
        filterByCircularity: r.filterByCircularity,
        filterByColor: r.filterByColor,
        filterByConvexity: r.filterByConvexity,
        filterByInertia: r.filterByInertia,
        maxArea: r.maxArea,
        maxCircularity: r.maxCircularity,
        maxConvexity: r.maxConvexity,
        maxInertiaRatio: r.maxInertiaRatio,
        maxThreshold: r.maxThreshold,
        minArea: r.minArea,
        minCircularity: r.minCircularity,
        minConvexity: r.minConvexity,
        minDistBetweenBlobs: r.minDistBetweenBlobs,
        minInertiaRatio: r.minInertiaRatio,
        minRepeatability: r.minRepeatability,
        minThreshold: r.minThreshold,
        thresholdStep: r.thresholdStep,
      );
  factory SimpleBlobDetectorParams.fromPointer(
    ffi.Pointer<cvg.SimpleBlobDetectorParams> p, [
    bool attach = true,
  ]) =>
      SimpleBlobDetectorParams._(p, attach);

  @override
  cvg.SimpleBlobDetectorParams get ref => ptr.ref;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get blobColor => ref.blobColor;
  set blobColor(int value) => ref.blobColor = value;

  bool get filterByArea => ref.filterByArea;
  set filterByArea(bool value) => ref.filterByArea = value;

  bool get filterByCircularity => ref.filterByCircularity;
  set filterByCircularity(bool value) => ref.filterByCircularity = value;

  bool get filterByColor => ref.filterByColor;
  set filterByColor(bool value) => ref.filterByColor = value;

  bool get filterByConvexity => ref.filterByConvexity;
  set filterByConvexity(bool value) => ref.filterByConvexity = value;

  bool get filterByInertia => ref.filterByInertia;
  set filterByInertia(bool value) => ref.filterByInertia = value;

  double get maxArea => ref.maxArea;
  set maxArea(double v) => ref.maxArea = v;

  double get maxCircularity => ref.maxCircularity;
  set maxCircularity(double v) => ref.maxCircularity = v;

  double get maxConvexity => ref.maxConvexity;
  set maxConvexity(double v) => ref.maxConvexity = v;

  double get maxInertiaRatio => ref.maxInertiaRatio;
  set maxInertiaRatio(double v) => ref.maxInertiaRatio = v;

  double get maxThreshold => ref.maxThreshold;
  set maxThreshold(double v) => ref.maxThreshold = v;

  double get minArea => ref.minArea;
  set minArea(double v) => ref.minArea = v;

  double get minCircularity => ref.minCircularity;
  set minCircularity(double v) => ref.minCircularity = v;

  double get minConvexity => ref.minConvexity;
  set minConvexity(double v) => ref.minConvexity = v;

  double get minDistBetweenBlobs => ref.minDistBetweenBlobs;
  set minDistBetweenBlobs(double v) => ref.minDistBetweenBlobs = v;

  double get minInertiaRatio => ref.minInertiaRatio;
  set minInertiaRatio(double v) => ref.minInertiaRatio = v;

  int get minRepeatability => ref.minRepeatability;
  set minRepeatability(int v) => ref.minRepeatability = v;

  double get minThreshold => ref.minThreshold;
  set minThreshold(double v) => ref.minThreshold = v;

  double get thresholdStep => ref.thresholdStep;
  set thresholdStep(double v) => ref.thresholdStep = v;

  @override
  List<num> get props => [
        maxArea,
        minArea,
        minConvexity,
        maxConvexity,
        minInertiaRatio,
        maxInertiaRatio,
        minThreshold,
        maxThreshold,
        thresholdStep,
        minDistBetweenBlobs,
        minRepeatability,
        minThreshold,
        thresholdStep,
        minDistBetweenBlobs,
      ];
}

/// SimpleBlobDetector is a wrapper around the cv::SimpleBlobDetector.
class SimpleBlobDetector extends CvStruct<cvg.SimpleBlobDetector> {
  SimpleBlobDetector._(cvg.SimpleBlobDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SimpleBlobDetector.fromPointer(cvg.SimpleBlobDetectorPtr ptr, [bool attach = true]) =>
      SimpleBlobDetector._(ptr, attach);

  /// returns a new SimpleBlobDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory SimpleBlobDetector.empty() {
    final p = calloc<cvg.SimpleBlobDetector>();
    cvRun(() => cfeatures2d.cv_SimpleBlobDetector_create(p));
    return SimpleBlobDetector._(p);
  }

  factory SimpleBlobDetector.create(SimpleBlobDetectorParams params) {
    final p = calloc<cvg.SimpleBlobDetector>();
    cvRun(() => cfeatures2d.cv_SimpleBlobDetector_create_1(params.ref, p));
    return SimpleBlobDetector._(p);
  }

  /// Detect keypoints in an image using SimpleBlobDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_SimpleBlobDetector_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.SimpleBlobDetectorPtr>(
    cfeatures2d.addresses.cv_SimpleBlobDetector_close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_SimpleBlobDetector_close(ptr);
  }

  @override
  cvg.SimpleBlobDetector get ref => ptr.ref;
}

/// BFMatcher is a wrapper around the cv::BFMatcher.
class BFMatcher extends CvStruct<cvg.BFMatcher> {
  BFMatcher._(cvg.BFMatcherPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BFMatcher.fromPointer(cvg.BFMatcherPtr ptr, [bool attach = true]) => BFMatcher._(ptr, attach);

  /// returns a new BFMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory BFMatcher.empty() {
    final p = calloc<cvg.BFMatcher>();
    cvRun(() => cfeatures2d.cv_BFMatcher_create(p));
    return BFMatcher._(p);
  }

  factory BFMatcher.create({int type = NORM_L2, bool crossCheck = false}) {
    final p = calloc<cvg.BFMatcher>();
    cvRun(() => cfeatures2d.cv_BFMatcher_create_1(type, crossCheck, p));
    return BFMatcher._(p);
  }

  /// Match Finds the best match for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d39/classcv_1_1DescriptorMatcher.html#a0f046f47b68ec7074391e1e85c750cba
  VecDMatch match(Mat query, Mat train) {
    final ret = calloc<cvg.VecDMatch>();
    cvRun(() => cfeatures2d.cv_BFMatcher_match(ref, query.ref, train.ref, ret, ffi.nullptr));
    return VecDMatch.fromPointer(ret);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = calloc<cvg.VecVecDMatch>();
    cvRun(() => cfeatures2d.cv_BFMatcher_knnMatch(ref, query.ref, train.ref, k, ret, ffi.nullptr));
    return VecVecDMatch.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.BFMatcherPtr>(cfeatures2d.addresses.cv_BFMatcher_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_BFMatcher_close(ptr);
  }

  @override
  cvg.BFMatcher get ref => ptr.ref;
}

/// FlannBasedMatcher is a wrapper around the cv::FlannBasedMatcher.
class FlannBasedMatcher extends CvStruct<cvg.FlannBasedMatcher> {
  FlannBasedMatcher._(cvg.FlannBasedMatcherPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FlannBasedMatcher.fromPointer(cvg.FlannBasedMatcherPtr ptr, [bool attach = true]) =>
      FlannBasedMatcher._(ptr, attach);

  /// returns a new FlannBasedMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory FlannBasedMatcher.empty() {
    final p = calloc<cvg.FlannBasedMatcher>();
    cvRun(() => cfeatures2d.cv_FlannBasedMatcher_create(p));
    return FlannBasedMatcher._(p);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = calloc<cvg.VecVecDMatch>();
    cvRun(
      () => cfeatures2d.cv_FlannBasedMatcher_knnMatch(ref, query.ref, train.ref, k, ret, ffi.nullptr),
    );
    return VecVecDMatch.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cvg.FlannBasedMatcherPtr>(
    cfeatures2d.addresses.cv_FlannBasedMatcher_close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_FlannBasedMatcher_close(ptr);
  }

  @override
  cvg.FlannBasedMatcher get ref => ptr.ref;
}

enum DrawMatchesFlag {
  /// DEFAULT creates new image and for each keypoint only the center point will be drawn
  DEFAULT(0),

  /// DRAW_OVER_OUTIMG draws matches on existing content of image
  DRAW_OVER_OUTIMG(1),

  /// NOT_DRAW_SINGLE_POINTS will not draw single points
  NOT_DRAW_SINGLE_POINTS(2),

  /// DRAW_RICH_KEYPOINTS draws the circle around each keypoint with keypoint size and orientation
  DRAW_RICH_KEYPOINTS(4);

  const DrawMatchesFlag(this.value);
  final int value;
}

/// SIFT is a wrapper around the cv::SIFT.
class SIFT extends CvStruct<cvg.SIFT> {
  SIFT._(cvg.SIFTPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory SIFT.fromPointer(cvg.SIFTPtr ptr, [bool attach = true]) => SIFT._(ptr, attach);

  /// returns a new SIFT algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d3c/classcv_1_1xfeatures2d_1_1SIFT.html
  factory SIFT.empty() {
    final p = calloc<cvg.SIFT>();
    cvRun(() => cfeatures2d.cv_SIFT_create(p));
    return SIFT._(p);
  }

  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(() => cfeatures2d.cv_SIFT_detect(ref, src.ref, ret, ffi.nullptr));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cvg.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.cv_SIFT_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret, ffi.nullptr),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cvg.SIFTPtr>(cfeatures2d.addresses.cv_SIFT_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_SIFT_close(ptr);
  }

  @override
  cvg.SIFT get ref => ptr.ref;
}

void drawKeyPoints(
  Mat src,
  VecKeyPoint keypoints,
  Mat dst,
  Scalar color,
  DrawMatchesFlag flag,
) {
  cvRun(
    () => cfeatures2d.cv_drawKeyPoints(
      src.ref,
      keypoints.ref,
      dst.ref,
      color.ref,
      flag.value,
      ffi.nullptr,
    ),
  );
}

/// DrawMatches draws matches on combined train and querry images.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d4/d5d/group__features2d__draw.html#gad8f463ccaf0dc6f61083abd8717c261a
void drawMatches(
  InputArray img1,
  VecKeyPoint keypoints1,
  InputArray img2,
  VecKeyPoint keypoints2,
  VecDMatch matches1to2,
  InputOutputArray outImg, {
  Scalar? matchColor,
  Scalar? singlePointColor,
  VecChar? matchesMask,
  DrawMatchesFlag flags = DrawMatchesFlag.DEFAULT,
}) {
  matchColor ??= Scalar.all(-1);
  singlePointColor ??= Scalar.all(-1);
  matchesMask ??= VecChar.fromList([]);
  cvRun(
    () => cfeatures2d.cv_drawMatches(
      img1.ref,
      keypoints1.ref,
      img2.ref,
      keypoints2.ref,
      matches1to2.ref,
      outImg.ref,
      matchColor!.ref,
      singlePointColor!.ref,
      matchesMask!.ref,
      flags.value,
      ffi.nullptr,
    ),
  );
}
