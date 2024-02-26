library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/scalar.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/keypoint.dart';
import '../core/dmatch.dart';
import '../constants.g.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

/// AKAZE is a wrapper around the cv::AKAZE algorithm.
class AKAZE implements ffi.Finalizable {
  AKAZE._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new AKAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory AKAZE.empty() {
    final ptr_ = _bindings.AKAZE_Create();
    return AKAZE._(ptr_);
  }

  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.AKAZE_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (List<KeyPoint>, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret =
        _bindings.AKAZE_DetectAndCompute(_ptr, src.ptr, mask.ptr, desc.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return (points, desc);
  }

  cvg.AKAZE _ptr;
  cvg.AKAZE get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.AKAZE_Close);
}

/// AgastFeatureDetector is a wrapper around the cv::AgastFeatureDetector.
class AgastFeatureDetector implements ffi.Finalizable {
  AgastFeatureDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new AgastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/d19/classcv_1_1AgastFeatureDetector.html
  factory AgastFeatureDetector.empty() {
    final ptr_ = _bindings.AgastFeatureDetector_Create();
    return AgastFeatureDetector._(ptr_);
  }

  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.AgastFeatureDetector_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  cvg.AgastFeatureDetector _ptr;
  cvg.AgastFeatureDetector get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.AgastFeatureDetector_Close);
}

/// BRISK is a wrapper around the cv::BRISK algorithm.
class BRISK implements ffi.Finalizable {
  BRISK._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new BRISK algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  factory BRISK.empty() {
    final ptr_ = _bindings.BRISK_Create();
    return BRISK._(ptr_);
  }

  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.BRISK_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (List<KeyPoint>, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret =
        _bindings.BRISK_DetectAndCompute(_ptr, src.ptr, mask.ptr, desc.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return (points, desc);
  }

  cvg.BRISK _ptr;
  cvg.BRISK get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.BRISK_Close);
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
class FastFeatureDetector implements ffi.Finalizable {
  FastFeatureDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new FastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html
  factory FastFeatureDetector.empty() {
    final ptr_ = _bindings.FastFeatureDetector_Create();
    return FastFeatureDetector._(ptr_);
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
    final _ptr = _bindings.FastFeatureDetector_CreateWithParams(
        threshold, nonmaxSuppression, type.value);
    return FastFeatureDetector._(_ptr);
  }

  /// Detect keypoints in an image using FastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.FastFeatureDetector_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  cvg.FastFeatureDetector _ptr;
  cvg.FastFeatureDetector get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.FastFeatureDetector_Close);
}

/// GFTTDetector is a wrapper around the cv::GFTTDetector.
class GFTTDetector implements ffi.Finalizable {
  GFTTDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new GFTTDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d21/classcv_1_1GFTTDetector.html
  factory GFTTDetector.empty() {
    final ptr_ = _bindings.GFTTDetector_Create();
    return GFTTDetector._(ptr_);
  }

  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.GFTTDetector_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  cvg.GFTTDetector _ptr;
  cvg.GFTTDetector get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.GFTTDetector_Close);
}

/// KAZE is a wrapper around the cv::KAZE.
class KAZE implements ffi.Finalizable {
  KAZE._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new KAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory KAZE.empty() {
    final ptr_ = _bindings.KAZE_Create();
    return KAZE._(ptr_);
  }

  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.KAZE_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (List<KeyPoint>, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret =
        _bindings.KAZE_DetectAndCompute(_ptr, src.ptr, mask.ptr, desc.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return (points, desc);
  }

  cvg.KAZE _ptr;
  cvg.KAZE get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.KAZE_Close);
}

/// MSER is a wrapper around the cv::MSER.
class MSER implements ffi.Finalizable {
  MSER._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new MSER algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory MSER.empty() {
    final ptr_ = _bindings.MSER_Create();
    return MSER._(ptr_);
  }

  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.MSER_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  cvg.MSER _ptr;
  cvg.MSER get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.MSER_Close);
}

enum ORBScoreType {
  HARRIS_SCORE(0),
  FAST_SCORE(1);

  const ORBScoreType(this.value);
  final int value;
}

/// ORB is a wrapper around the cv::ORB.
class ORB implements ffi.Finalizable {
  ORB._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new ORB algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory ORB.empty() {
    final ptr_ = _bindings.ORB_Create();
    return ORB._(ptr_);
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
    final ptr_ = _bindings.ORB_CreateWithParams(
      nFeatures,
      scaleFactor,
      nLevels,
      edgeThreshold,
      firstLevel,
      WTA_K,
      scoreType.value,
      patchSize,
      fastThreshold,
    );
    return ORB._(ptr_);
  }

  /// Detect keypoints in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.ORB_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (List<KeyPoint>, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret =
        _bindings.ORB_DetectAndCompute(_ptr, src.ptr, mask.ptr, desc.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return (points, desc);
  }

  cvg.ORB _ptr;
  cvg.ORB get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.ORB_Close);
}

class SimpleBlobDetectorParams implements ffi.Finalizable {
  SimpleBlobDetectorParams._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory SimpleBlobDetectorParams.empty() {
    final _ptr = calloc<cvg.SimpleBlobDetectorParams>();
    _ptr.ref = _bindings.SimpleBlobDetectorParams_Create();
    return SimpleBlobDetectorParams._(_ptr);
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
    final _ptr = calloc<cvg.SimpleBlobDetectorParams>();
    if (blobColor != null) _ptr.ref.blobColor = blobColor;
    if (filterByArea != null) _ptr.ref.filterByArea = filterByArea;
    if (filterByCircularity != null)
      _ptr.ref.filterByCircularity = filterByCircularity;
    if (filterByColor != null) _ptr.ref.filterByColor = filterByColor;
    if (filterByConvexity != null)
      _ptr.ref.filterByConvexity = filterByConvexity;
    if (filterByInertia != null) _ptr.ref.filterByInertia = filterByInertia;
    if (maxArea != null) _ptr.ref.maxArea = maxArea;
    if (maxCircularity != null) _ptr.ref.maxCircularity = maxCircularity;
    if (maxConvexity != null) _ptr.ref.maxConvexity = maxConvexity;
    if (maxInertiaRatio != null) _ptr.ref.maxInertiaRatio = maxInertiaRatio;
    if (maxThreshold != null) _ptr.ref.maxThreshold = maxThreshold;
    if (minArea != null) _ptr.ref.minArea = minArea;
    if (minCircularity != null) _ptr.ref.minCircularity = minCircularity;
    if (minConvexity != null) _ptr.ref.minConvexity = minConvexity;
    if (minDistBetweenBlobs != null)
      _ptr.ref.minDistBetweenBlobs = minDistBetweenBlobs;
    if (minInertiaRatio != null) _ptr.ref.minInertiaRatio = minInertiaRatio;
    if (minRepeatability != null) _ptr.ref.minRepeatability = minRepeatability;
    if (minThreshold != null) _ptr.ref.minThreshold = minThreshold;
    if (thresholdStep != null) _ptr.ref.thresholdStep = thresholdStep;

    return SimpleBlobDetectorParams._(_ptr);
  }

  factory SimpleBlobDetectorParams.fromNative(cvg.SimpleBlobDetectorParams r) =>
      SimpleBlobDetectorParams(
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
          ffi.Pointer<cvg.SimpleBlobDetectorParams> p) =>
      SimpleBlobDetectorParams._(p);

  ffi.Pointer<cvg.SimpleBlobDetectorParams> _ptr;
  ffi.Pointer<cvg.SimpleBlobDetectorParams> get ptr => _ptr;
  cvg.SimpleBlobDetectorParams get ref => _ptr.ref;

  static final finalizer =
      Finalizer<ffi.Pointer<cvg.SimpleBlobDetectorParams>>((p0) {
    calloc.free(p0);
  });

  int get blobColor => _ptr.ref.blobColor;
  bool get filterByArea => _ptr.ref.filterByArea;
  bool get filterByCircularity => _ptr.ref.filterByCircularity;
  bool get filterByColor => _ptr.ref.filterByColor;
  bool get filterByConvexity => _ptr.ref.filterByConvexity;
  bool get filterByInertia => _ptr.ref.filterByInertia;
  double get maxArea => _ptr.ref.maxArea;
  double get maxCircularity => _ptr.ref.maxCircularity;
  double get maxConvexity => _ptr.ref.maxConvexity;
  double get maxInertiaRatio => _ptr.ref.maxInertiaRatio;
  double get maxThreshold => _ptr.ref.maxThreshold;
  double get minArea => _ptr.ref.minArea;
  double get minCircularity => _ptr.ref.minCircularity;
  double get minConvexity => _ptr.ref.minConvexity;
  double get minDistBetweenBlobs => _ptr.ref.minDistBetweenBlobs;
  double get minInertiaRatio => _ptr.ref.minInertiaRatio;
  int get minRepeatability => _ptr.ref.minRepeatability;
  double get minThreshold => _ptr.ref.minThreshold;
  double get thresholdStep => _ptr.ref.thresholdStep;

  void set blobColor(int v) {
    _ptr.ref.blobColor = v;
  }

  void set filterByArea(bool v) {
    _ptr.ref.filterByArea = v;
  }

  void set filterByCircularity(bool v) {
    _ptr.ref.filterByCircularity = v;
  }

  void set filterByColor(bool v) {
    _ptr.ref.filterByColor = v;
  }

  void set filterByConvexity(bool v) {
    _ptr.ref.filterByConvexity = v;
  }

  void set filterByInertia(bool v) {
    _ptr.ref.filterByInertia = v;
  }

  void set maxArea(double v) {
    _ptr.ref.maxArea = v;
  }

  void set maxCircularity(double v) {
    _ptr.ref.maxCircularity = v;
  }

  void set maxConvexity(double v) {
    _ptr.ref.maxConvexity = v;
  }

  void set maxInertiaRatio(double v) {
    _ptr.ref.maxInertiaRatio = v;
  }

  void set maxThreshold(double v) {
    _ptr.ref.maxThreshold = v;
  }

  void set minArea(double v) {
    _ptr.ref.minArea = v;
  }

  void set minCircularity(double v) {
    _ptr.ref.minCircularity = v;
  }

  void set minConvexity(double v) {
    _ptr.ref.minConvexity = v;
  }

  void set minDistBetweenBlobs(double v) {
    _ptr.ref.minDistBetweenBlobs = v;
  }

  void set minInertiaRatio(double v) {
    _ptr.ref.minInertiaRatio = v;
  }

  void set minRepeatability(int v) {
    _ptr.ref.minRepeatability = v;
  }

  void set minThreshold(double v) {
    _ptr.ref.minThreshold = v;
  }

  void set thresholdStep(double v) {
    _ptr.ref.thresholdStep = v;
  }
}

/// SimpleBlobDetector is a wrapper around the cv::SimpleBlobDetector.
class SimpleBlobDetector implements ffi.Finalizable {
  SimpleBlobDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new SimpleBlobDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory SimpleBlobDetector.empty() {
    final ptr_ = _bindings.SimpleBlobDetector_Create();
    return SimpleBlobDetector._(ptr_);
  }

  factory SimpleBlobDetector.create(SimpleBlobDetectorParams params) {
    final ptr_ = _bindings.SimpleBlobDetector_Create_WithParams(params.ref);
    return SimpleBlobDetector._(ptr_);
  }

  /// Detect keypoints in an image using SimpleBlobDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.SimpleBlobDetector_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  cvg.SimpleBlobDetector _ptr;
  cvg.SimpleBlobDetector get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.SimpleBlobDetector_Close);
}

/// BFMatcher is a wrapper around the cv::BFMatcher.
class BFMatcher implements ffi.Finalizable {
  BFMatcher._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new BFMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory BFMatcher.empty() {
    final ptr_ = _bindings.BFMatcher_Create();
    return BFMatcher._(ptr_);
  }

  factory BFMatcher.create({int type = NORM_L2, bool crossCheck = false}) {
    final ptr_ = _bindings.BFMatcher_CreateWithParams(type, crossCheck);
    return BFMatcher._(ptr_);
  }

  /// Match Finds the best match for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d39/classcv_1_1DescriptorMatcher.html#a0f046f47b68ec7074391e1e85c750cba
  List<DMatch> match(Mat query, Mat train) {
    final ret = _bindings.BFMatcher_Match(_ptr, query.ptr, train.ptr);
    final matches = DMatches.toList(ret);
    _bindings.DMatches_Close(ret);
    return matches;
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  List<List<DMatch>> knnMatch(Mat query, Mat train, int k) {
    final ret = _bindings.BFMatcher_KnnMatch(_ptr, query.ptr, train.ptr, k);
    final matches = MultiDMatches.toList(ret);
    _bindings.MultiDMatches_Close(ret);
    return matches;
  }

  cvg.BFMatcher _ptr;
  cvg.BFMatcher get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.BFMatcher_Close);
}

/// FlannBasedMatcher is a wrapper around the cv::FlannBasedMatcher.
class FlannBasedMatcher implements ffi.Finalizable {
  FlannBasedMatcher._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new FlannBasedMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  factory FlannBasedMatcher.empty() {
    final ptr_ = _bindings.FlannBasedMatcher_Create();
    return FlannBasedMatcher._(ptr_);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  List<List<DMatch>> knnMatch(Mat query, Mat train, int k) {
    final ret =
        _bindings.FlannBasedMatcher_KnnMatch(_ptr, query.ptr, train.ptr, k);
    final matches = MultiDMatches.toList(ret);
    _bindings.MultiDMatches_Close(ret);
    return matches;
  }

  cvg.FlannBasedMatcher _ptr;
  cvg.FlannBasedMatcher get ptr => _ptr;
  static final finalizer =
      ffi.NativeFinalizer(_bindings.addresses.FlannBasedMatcher_Close);
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

void drawKeyPoints(Mat src, List<KeyPoint> keypoints, Mat dst, Scalar color,
    DrawMatchesFlag flag) {
  using((arena) {
    _bindings.DrawKeyPoints(
        src.ptr, keypoints.toNative(arena).ref, dst.ptr, color.ref, flag.value);
  });
}

/// SIFT is a wrapper around the cv::SIFT.
class SIFT implements ffi.Finalizable {
  SIFT._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  /// returns a new SIFT algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d3c/classcv_1_1xfeatures2d_1_1SIFT.html
  factory SIFT.empty() {
    final ptr_ = _bindings.SIFT_Create();
    return SIFT._(ptr_);
  }

  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  List<KeyPoint> detect(Mat src) {
    final ret = _bindings.SIFT_Detect(_ptr, src.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return points;
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  (List<KeyPoint>, Mat) detectAndCompute(Mat src, Mat mask) {
    final desc = Mat.empty();
    final ret =
        _bindings.SIFT_DetectAndCompute(_ptr, src.ptr, mask.ptr, desc.ptr);
    final points = KeyPoints.toList(ret);
    _bindings.KeyPoints_Close(ret);
    return (points, desc);
  }

  cvg.SIFT _ptr;
  cvg.SIFT get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.SIFT_Close);
}

// DrawMatches draws matches on combined train and querry images.
//
// For further details, please see:
// https://docs.opencv.org/master/d4/d5d/group__features2d__draw.html#gad8f463ccaf0dc6f61083abd8717c261a
void drawMatches(
  InputArray img1,
  List<KeyPoint> keypoints1,
  InputArray img2,
  List<KeyPoint> keypoints2,
  List<DMatch> matches1to2,
  InputOutputArray outImg, {
  Scalar? matchColor,
  Scalar? singlePointColor,
  List<int>? matchesMask,
  DrawMatchesFlag flags = DrawMatchesFlag.DEFAULT,
}) {
  using((arena) {
    matchColor ??= Scalar.all(-1);
    singlePointColor ??= Scalar.all(-1);
    matchesMask ??= [];
    final mask = arena<cvg.ByteArray>()..ref.length = 0;
    if (matchesMask != null) {
      mask.ref.length = matchesMask!.length;
      for (var i = 0; i < matchesMask!.length; i++) {
        mask.ref.data[i] = matchesMask![i];
      }
    }

    _bindings.DrawMatches(
      img1.ptr,
      keypoints1.toNative(arena).ref,
      img2.ptr,
      keypoints2.toNative(arena).ref,
      matches1to2.toNative(arena).ref,
      outImg.ptr,
      matchColor!.ref,
      singlePointColor!.ref,
      mask.ref,
      flags.value,
    );
  });
}
