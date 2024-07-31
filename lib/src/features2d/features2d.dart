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
import '../g/features2d.g.dart' as cfeatures2d;

/// AKAZE is a wrapper around the cv::AKAZE algorithm.
class AKAZE extends CvStruct<cfeatures2d.AKAZE> {
  AKAZE._(cfeatures2d.AKAZEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory AKAZE.fromPointer(cfeatures2d.AKAZEPtr ptr, [bool attach = true]) => AKAZE._(ptr, attach);

  /// returns a new AKAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory AKAZE.empty() {
    final p = calloc<cfeatures2d.AKAZE>();
    cvRun(() => cfeatures2d.AKAZE_Create(p));
    return AKAZE._(p);
  }

  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.AKAZE_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint ret, Mat desc) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.AKAZE_DetectAndCompute(ptr.ref, src.ref, mask.ref, desc.ref, ret),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.AKAZEPtr>(cfeatures2d.addresses.AKAZE_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.AKAZE_Close(ptr);
  }

  @override
  cfeatures2d.AKAZE get ref => ptr.ref;
}

/// AgastFeatureDetector is a wrapper around the cv::AgastFeatureDetector.
class AgastFeatureDetector extends CvStruct<cfeatures2d.AgastFeatureDetector> {
  AgastFeatureDetector._(cfeatures2d.AgastFeatureDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory AgastFeatureDetector.fromPointer(cfeatures2d.AgastFeatureDetectorPtr ptr, [bool attach = true]) =>
      AgastFeatureDetector._(ptr, attach);

  /// returns a new AgastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/d19/classcv_1_1AgastFeatureDetector.html
  factory AgastFeatureDetector.empty() {
    final p = calloc<cfeatures2d.AgastFeatureDetector>();
    cvRun(() => cfeatures2d.AgastFeatureDetector_Create(p));
    return AgastFeatureDetector._(p);
  }

  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.AgastFeatureDetector_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.AgastFeatureDetectorPtr>(
    cfeatures2d.addresses.AgastFeatureDetector_Close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.AgastFeatureDetector_Close(ptr);
  }

  @override
  cfeatures2d.AgastFeatureDetector get ref => ptr.ref;
}

/// BRISK is a wrapper around the cv::BRISK algorithm.
class BRISK extends CvStruct<cfeatures2d.BRISK> {
  BRISK._(cfeatures2d.BRISKPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BRISK.fromPointer(cfeatures2d.BRISKPtr ptr, [bool attach = true]) => BRISK._(ptr, attach);

  /// returns a new BRISK algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory BRISK.empty() {
    final p = calloc<cfeatures2d.BRISK>();
    cvRun(() => cfeatures2d.BRISK_Create(p));
    return BRISK._(p);
  }

  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.BRISK_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.BRISK_DetectAndCompute(ptr.ref, src.ref, mask.ref, desc.ref, ret),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.BRISKPtr>(cfeatures2d.addresses.BRISK_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.BRISK_Close(ptr);
  }

  @override
  cfeatures2d.BRISK get ref => ptr.ref;
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
class FastFeatureDetector extends CvStruct<cfeatures2d.FastFeatureDetector> {
  FastFeatureDetector._(cfeatures2d.FastFeatureDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FastFeatureDetector.fromPointer(cfeatures2d.FastFeatureDetectorPtr ptr, [bool attach = true]) =>
      FastFeatureDetector._(ptr, attach);

  /// returns a new FastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html
  factory FastFeatureDetector.empty() {
    final p = calloc<cfeatures2d.FastFeatureDetector>();
    cvRun(() => cfeatures2d.FastFeatureDetector_Create(p));
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
    final p = calloc<cfeatures2d.FastFeatureDetector>();
    cvRun(
      () => cfeatures2d.FastFeatureDetector_CreateWithParams(
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
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.FastFeatureDetector_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.FastFeatureDetectorPtr>(
    cfeatures2d.addresses.FastFeatureDetector_Close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.FastFeatureDetector_Close(ptr);
  }

  @override
  cfeatures2d.FastFeatureDetector get ref => ptr.ref;
}

/// GFTTDetector is a wrapper around the cv::GFTTDetector.
class GFTTDetector extends CvStruct<cfeatures2d.GFTTDetector> {
  GFTTDetector._(cfeatures2d.GFTTDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory GFTTDetector.fromPointer(cfeatures2d.GFTTDetectorPtr ptr, [bool attach = true]) =>
      GFTTDetector._(ptr, attach);

  /// returns a new GFTTDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d21/classcv_1_1GFTTDetector.html
  factory GFTTDetector.empty() {
    final p = calloc<cfeatures2d.GFTTDetector>();
    cvRun(() => cfeatures2d.GFTTDetector_Create(p));
    return GFTTDetector._(p);
  }

  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.GFTTDetector_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.GFTTDetectorPtr>(cfeatures2d.addresses.GFTTDetector_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.GFTTDetector_Close(ptr);
  }

  @override
  cfeatures2d.GFTTDetector get ref => ptr.ref;
}

/// KAZE is a wrapper around the cv::KAZE.
class KAZE extends CvStruct<cfeatures2d.KAZE> {
  KAZE._(cfeatures2d.KAZEPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory KAZE.fromPointer(cfeatures2d.KAZEPtr ptr, [bool attach = true]) => KAZE._(ptr, attach);

  /// returns a new KAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory KAZE.empty() {
    final p = calloc<cfeatures2d.KAZE>();
    cvRun(() => cfeatures2d.KAZE_Create(p));
    return KAZE._(p);
  }

  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.KAZE_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.KAZE_DetectAndCompute(ptr.ref, src.ref, mask.ref, desc.ref, ret),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.KAZEPtr>(cfeatures2d.addresses.KAZE_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.KAZE_Close(ptr);
  }

  @override
  cfeatures2d.KAZE get ref => ptr.ref;
}

/// MSER is a wrapper around the cv::MSER.
class MSER extends CvStruct<cfeatures2d.MSER> {
  MSER._(cfeatures2d.MSERPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory MSER.fromPointer(cfeatures2d.MSERPtr ptr, [bool attach = true]) => MSER._(ptr, attach);

  /// returns a new MSER algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory MSER.empty() {
    final p = calloc<cfeatures2d.MSER>();
    cvRun(() => cfeatures2d.MSER_Create(p));
    return MSER._(p);
  }

  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.MSER_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.MSERPtr>(cfeatures2d.addresses.MSER_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.MSER_Close(ptr);
  }

  @override
  cfeatures2d.MSER get ref => ptr.ref;
}

enum ORBScoreType {
  HARRIS_SCORE(0),
  FAST_SCORE(1);

  const ORBScoreType(this.value);
  final int value;
}

/// ORB is a wrapper around the cv::ORB.
class ORB extends CvStruct<cfeatures2d.ORB> {
  ORB._(cfeatures2d.ORBPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
    }
  }
  factory ORB.fromPointer(cfeatures2d.ORBPtr ptr, [bool attach = true]) => ORB._(ptr, attach);

  /// returns a new ORB algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory ORB.empty() {
    final p = calloc<cfeatures2d.ORB>();
    cvRun(() => cfeatures2d.ORB_Create(p));
    return ORB._(p);
  }

  /// NewORBWithParams returns a new ORB algorithm with parameters
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
    final p = calloc<cfeatures2d.ORB>();
    cvRun(
      () => cfeatures2d.ORB_CreateWithParams(
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
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.ORB_Detect(ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final pdesc = calloc<cfeatures2d.Mat>();
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.ORB_DetectAndCompute(ref, src.ref, mask.ref, pdesc, ret));
    return (VecKeyPoint.fromPointer(ret), Mat.fromPointer(pdesc));
  }

  static final finalizer = OcvFinalizer<cfeatures2d.ORBPtr>(cfeatures2d.addresses.ORB_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.ORB_Close(ptr);
  }

  @override
  cfeatures2d.ORB get ref => ptr.ref;
}

class SimpleBlobDetectorParams extends CvStruct<cfeatures2d.SimpleBlobDetectorParams> {
  SimpleBlobDetectorParams._(
    ffi.Pointer<cfeatures2d.SimpleBlobDetectorParams> ptr, [
    bool attach = true,
  ]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SimpleBlobDetectorParams.empty() {
    final p = calloc<cfeatures2d.SimpleBlobDetectorParams>();
    cvRun(() => cfeatures2d.SimpleBlobDetectorParams_Create(p));
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
    final p = calloc<cfeatures2d.SimpleBlobDetectorParams>();
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

  factory SimpleBlobDetectorParams.fromNative(cfeatures2d.SimpleBlobDetectorParams r) => SimpleBlobDetectorParams(
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
    ffi.Pointer<cfeatures2d.SimpleBlobDetectorParams> p, [
    bool attach = true,
  ]) =>
      SimpleBlobDetectorParams._(p, attach);

  @override
  cfeatures2d.SimpleBlobDetectorParams get ref => ptr.ref;

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
class SimpleBlobDetector extends CvStruct<cfeatures2d.SimpleBlobDetector> {
  SimpleBlobDetector._(cfeatures2d.SimpleBlobDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory SimpleBlobDetector.fromPointer(cfeatures2d.SimpleBlobDetectorPtr ptr, [bool attach = true]) =>
      SimpleBlobDetector._(ptr, attach);

  /// returns a new SimpleBlobDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory SimpleBlobDetector.empty() {
    final p = calloc<cfeatures2d.SimpleBlobDetector>();
    cvRun(() => cfeatures2d.SimpleBlobDetector_Create(p));
    return SimpleBlobDetector._(p);
  }

  factory SimpleBlobDetector.create(SimpleBlobDetectorParams params) {
    final p = calloc<cfeatures2d.SimpleBlobDetector>();
    cvRun(() => cfeatures2d.SimpleBlobDetector_Create_WithParams(params.ref, p));
    return SimpleBlobDetector._(p);
  }

  /// Detect keypoints in an image using SimpleBlobDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.SimpleBlobDetector_Detect(ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.SimpleBlobDetectorPtr>(
    cfeatures2d.addresses.SimpleBlobDetector_Close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.SimpleBlobDetector_Close(ptr);
  }

  @override
  cfeatures2d.SimpleBlobDetector get ref => ptr.ref;
}

/// BFMatcher is a wrapper around the cv::BFMatcher.
class BFMatcher extends CvStruct<cfeatures2d.BFMatcher> {
  BFMatcher._(cfeatures2d.BFMatcherPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BFMatcher.fromPointer(cfeatures2d.BFMatcherPtr ptr, [bool attach = true]) => BFMatcher._(ptr, attach);

  /// returns a new BFMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory BFMatcher.empty() {
    final p = calloc<cfeatures2d.BFMatcher>();
    cvRun(() => cfeatures2d.BFMatcher_Create(p));
    return BFMatcher._(p);
  }

  factory BFMatcher.create({int type = NORM_L2, bool crossCheck = false}) {
    final p = calloc<cfeatures2d.BFMatcher>();
    cvRun(() => cfeatures2d.BFMatcher_CreateWithParams(type, crossCheck, p));
    return BFMatcher._(p);
  }

  /// Match Finds the best match for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d39/classcv_1_1DescriptorMatcher.html#a0f046f47b68ec7074391e1e85c750cba
  VecDMatch match(Mat query, Mat train) {
    final ret = calloc<cfeatures2d.VecDMatch>();
    cvRun(() => cfeatures2d.BFMatcher_Match(ptr.ref, query.ref, train.ref, ret));
    return VecDMatch.fromPointer(ret);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = calloc<cfeatures2d.VecVecDMatch>();
    cvRun(() => cfeatures2d.BFMatcher_KnnMatch(ptr.ref, query.ref, train.ref, k, ret));
    return VecVecDMatch.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.BFMatcherPtr>(cfeatures2d.addresses.BFMatcher_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.BFMatcher_Close(ptr);
  }

  @override
  cfeatures2d.BFMatcher get ref => ptr.ref;
}

/// FlannBasedMatcher is a wrapper around the cv::FlannBasedMatcher.
class FlannBasedMatcher extends CvStruct<cfeatures2d.FlannBasedMatcher> {
  FlannBasedMatcher._(cfeatures2d.FlannBasedMatcherPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FlannBasedMatcher.fromPointer(cfeatures2d.FlannBasedMatcherPtr ptr, [bool attach = true]) =>
      FlannBasedMatcher._(ptr, attach);

  /// returns a new FlannBasedMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory FlannBasedMatcher.empty() {
    final p = calloc<cfeatures2d.FlannBasedMatcher>();
    cvRun(() => cfeatures2d.FlannBasedMatcher_Create(p));
    return FlannBasedMatcher._(p);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = calloc<cfeatures2d.VecVecDMatch>();
    cvRun(
      () => cfeatures2d.FlannBasedMatcher_KnnMatch(ptr.ref, query.ref, train.ref, k, ret),
    );
    return VecVecDMatch.fromPointer(ret);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.FlannBasedMatcherPtr>(
    cfeatures2d.addresses.FlannBasedMatcher_Close,
  );

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.FlannBasedMatcher_Close(ptr);
  }

  @override
  cfeatures2d.FlannBasedMatcher get ref => ptr.ref;
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

void drawKeyPoints(
  Mat src,
  VecKeyPoint keypoints,
  Mat dst,
  Scalar color,
  DrawMatchesFlag flag,
) {
  cvRun(
    () => cfeatures2d.DrawKeyPoints(
      src.ref,
      keypoints.ref,
      dst.ref,
      color.ref,
      flag.value,
    ),
  );
}

/// SIFT is a wrapper around the cv::SIFT.
class SIFT extends CvStruct<cfeatures2d.SIFT> {
  SIFT._(cfeatures2d.SIFTPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory SIFT.fromPointer(cfeatures2d.SIFTPtr ptr, [bool attach = true]) => SIFT._(ptr, attach);

  /// returns a new SIFT algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d3c/classcv_1_1xfeatures2d_1_1SIFT.html
  factory SIFT.empty() {
    final p = calloc<cfeatures2d.SIFT>();
    cvRun(() => cfeatures2d.SIFT_Create(p));
    return SIFT._(p);
  }

  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  VecKeyPoint detect(Mat src) {
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(() => cfeatures2d.SIFT_Detect(ptr.ref, src.ref, ret));
    return VecKeyPoint.fromPointer(ret);
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (VecKeyPoint, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret = calloc<cfeatures2d.VecKeyPoint>();
    cvRun(
      () => cfeatures2d.SIFT_DetectAndCompute(ptr.ref, src.ref, mask.ref, desc.ref, ret),
    );
    return (VecKeyPoint.fromPointer(ret), desc);
  }

  static final finalizer = OcvFinalizer<cfeatures2d.SIFTPtr>(cfeatures2d.addresses.SIFT_Close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.SIFT_Close(ptr);
  }

  @override
  cfeatures2d.SIFT get ref => ptr.ref;
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
    () => cfeatures2d.DrawMatches(
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
    ),
  );
}
