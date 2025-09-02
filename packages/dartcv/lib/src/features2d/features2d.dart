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
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/constants.g.dart';
import '../g/features2d.g.dart' as cvg;
import '../native_lib.dart' show cfeatures2d;
import 'features2d_base.dart';
import 'features2d_enum.dart';

/// AKAZE is a wrapper around the cv::AKAZE algorithm.
class AKAZE extends Feature2D<cvg.AKAZE> {
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

  /// The AKAZE constructor.
  ///
  /// https://docs.opencv.org/4.x/d8/d30/classcv_1_1AKAZE.html#ac5d847ee303373416c7ad1950ea046ed
  factory AKAZE.create({
    AKAZEDescriptorType descriptorType = AKAZEDescriptorType.DESCRIPTOR_MLDB,
    int descriptorSize = 0,
    int descriptorChannels = 3,
    double threshold = 0.001,
    int nOctaves = 4,
    int nOctaveLayers = 4,
    KAZEDiffusivityType diffusivity = KAZEDiffusivityType.DIFF_PM_G2,
    int maxPoints = -1,
  }) {
    final p = calloc<cvg.AKAZE>();
    cvRun(
      () => cfeatures2d.cv_AKAZE_create_1(
        descriptorType.value,
        descriptorSize,
        descriptorChannels,
        threshold,
        nOctaves,
        nOctaveLayers,
        diffusivity.value,
        maxPoints,
        p,
      ),
    );
    return AKAZE._(p);
  }

  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_AKAZE_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  @override
  (VecKeyPoint ret, Mat desc) detectAndCompute(
    Mat src,
    Mat mask, {
    Mat? descriptors,
    VecKeyPoint? keypoints,
    bool useProvidedKeypoints = false,
  }) {
    descriptors ??= Mat.empty();
    keypoints ??= VecKeyPoint();
    cvRun(
      () => cfeatures2d.cv_AKAZE_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        descriptors!.ref,
        keypoints!.ptr,
        useProvidedKeypoints,
        ffi.nullptr,
      ),
    );
    return (keypoints, descriptors);
  }

  static final finalizer = OcvFinalizer<cvg.AKAZEPtr>(cfeatures2d.addresses.cv_AKAZE_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_AKAZE_close(ptr);
  }

  @override
  cvg.AKAZE get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.AKAZE";

  @override
  bool get isEmpty => cfeatures2d.cv_AKAZE_empty(ref);

  AKAZEDescriptorType get descriptorType =>
      AKAZEDescriptorType.fromValue(cfeatures2d.cv_AKAZE_getDescriptorType(ref));
  set descriptorType(AKAZEDescriptorType value) => cfeatures2d.cv_AKAZE_setDescriptorType(ref, value.value);

  int get descriptorSize => cfeatures2d.cv_AKAZE_getDescriptorSize(ref);
  set descriptorSize(int value) => cfeatures2d.cv_AKAZE_setDescriptorSize(ref, value);

  int get descriptorChannels => cfeatures2d.cv_AKAZE_getDescriptorChannels(ref);
  set descriptorChannels(int value) => cfeatures2d.cv_AKAZE_setDescriptorChannels(ref, value);

  double get threshold => cfeatures2d.cv_AKAZE_getThreshold(ref);
  set threshold(double value) => cfeatures2d.cv_AKAZE_setThreshold(ref, value);

  int get nOctaves => cfeatures2d.cv_AKAZE_getNOctaves(ref);
  set nOctaves(int value) => cfeatures2d.cv_AKAZE_setNOctaves(ref, value);

  int get nOctaveLayers => cfeatures2d.cv_AKAZE_getNOctaveLayers(ref);
  set nOctaveLayers(int value) => cfeatures2d.cv_AKAZE_setNOctaveLayers(ref, value);

  KAZEDiffusivityType get diffusivity =>
      KAZEDiffusivityType.fromValue(cfeatures2d.cv_AKAZE_getDiffusivity(ref));
  set diffusivity(KAZEDiffusivityType value) => cfeatures2d.cv_AKAZE_setDiffusivity(ref, value.value);

  int get maxPoints => cfeatures2d.cv_AKAZE_getMaxPoints(ref);
  set maxPoints(int value) => cfeatures2d.cv_AKAZE_setMaxPoints(ref, value);

  @override
  String toString() {
    return "AKAZE(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// AgastFeatureDetector is a wrapper around the cv::AgastFeatureDetector.
class AgastFeatureDetector extends Feature2D<cvg.AgastFeatureDetector> {
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

  /// create (int threshold=10, bool nonmaxSuppression=true, AgastFeatureDetector::DetectorType type=AgastFeatureDetector::OAST_9_16)
  ///
  /// https://docs.opencv.org/4.x/d7/d19/classcv_1_1AgastFeatureDetector.html#ae1987fb24e86701236773dfa7f6dabee
  factory AgastFeatureDetector.create({
    int threshold = 10,
    bool nonmaxSuppression = true,
    AgastDetectorType type = AgastDetectorType.OAST_9_16,
  }) {
    final p = calloc<cvg.AgastFeatureDetector>();
    cvRun(() => cfeatures2d.cv_AgastFeatureDetector_create_1(threshold, nonmaxSuppression, type.value, p));
    return AgastFeatureDetector._(p);
  }

  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(
      () => cfeatures2d.cv_AgastFeatureDetector_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr),
    );
    return keypoints;
  }

  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    throw UnsupportedError("This function is not supported by AgastFeatureDetector");
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

  @override
  String get defaultName => "${super.defaultName}.AgastFeatureDetector";

  @override
  bool get isEmpty => cfeatures2d.cv_AgastFeatureDetector_empty(ref);

  int get threshold => cfeatures2d.cv_AgastFeatureDetector_getThreshold(ref);
  set threshold(int value) => cfeatures2d.cv_AgastFeatureDetector_setThreshold(ref, value);

  bool get nonmaxSuppression => cfeatures2d.cv_AgastFeatureDetector_getNonmaxSuppression(ref);
  set nonmaxSuppression(bool value) => cfeatures2d.cv_AgastFeatureDetector_setNonmaxSuppression(ref, value);

  AgastDetectorType get type => AgastDetectorType.fromValue(cfeatures2d.cv_AgastFeatureDetector_getType(ref));
  set type(AgastDetectorType value) => cfeatures2d.cv_AgastFeatureDetector_setType(ref, value.value);

  @override
  String toString() {
    return "AgastFeatureDetector(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// BRISK is a wrapper around the cv::BRISK algorithm.
class BRISK extends Feature2D<cvg.BRISK> {
  BRISK._(cvg.BRISKPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory BRISK.fromPointer(cvg.BRISKPtr ptr, [bool attach = true]) => BRISK._(ptr, attach);

  /// returns a new BRISK algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/de/dbf/classcv_1_1BRISK.html
  factory BRISK.empty() {
    final p = calloc<cvg.BRISK>();
    cvRun(() => cfeatures2d.cv_BRISK_create(p));
    return BRISK._(p);
  }

  /// The BRISK constructor
  ///
  /// [thresh] AGAST detection threshold score.
  /// [octaves] detection octaves. Use 0 to do single scale.
  /// [patternScale] apply this scale to the pattern used for sampling the neighbourhood of a keypoint.
  ///
  ///```c++
  /// CV_WRAP static Ptr<BRISK> create(int thresh=30, int octaves=3, float patternScale=1.0f);
  ///```
  /// https://docs.opencv.org/4.x/de/dbf/classcv_1_1BRISK.html#ad3b513ded80119670e5efa90a31705ac
  factory BRISK.create({int thresh = 30, int octaves = 3, double patternScale = 1.0}) {
    final p = calloc<cvg.BRISK>();
    cvRun(() => cfeatures2d.cv_BRISK_create_3(thresh, octaves, patternScale, p));
    return BRISK._(p);
  }

  /// The BRISK constructor for a custom pattern
  ///
  /// [radiusList] defines the radii (in pixels) where the samples around a keypoint are taken (for keypoint scale 1).
  /// [numberList] defines the number of sampling points on the sampling circle. Must be the same size as radiusList..
  /// [dMax] threshold for the short pairings used for descriptor formation (in pixels for keypoint scale 1).
  /// [dMin] threshold for the long pairings used for orientation determination (in pixels for keypoint scale 1).
  /// [indexChange] index remapping of the bits.
  ///
  /// ```c++
  /// CV_WRAP static Ptr<BRISK> create(const std::vector<float> &radiusList, const std::vector<int> &numberList,
  ///     float dMax=5.85f, float dMin=8.2f, const std::vector<int>& indexChange=std::vector<int>());
  /// ```
  ///
  /// https://docs.opencv.org/4.x/de/dbf/classcv_1_1BRISK.html#ad3b513ded80119670e5efa90a31705ac
  factory BRISK.create1({
    required List<double> radiusList,
    required List<int> numberList,
    double dMax = 5.85,
    double dMin = 8.2,
    List<int>? indexChange,
  }) {
    final p = calloc<cvg.BRISK>();
    final radiusList_ = radiusList.f32;
    final numberList_ = numberList.i32;
    final indexChange_ = indexChange?.i32 ?? VecI32();
    cvRun(
      () => cfeatures2d.cv_BRISK_create_1(radiusList_.ref, numberList_.ref, dMax, dMin, indexChange_.ref, p),
    );
    radiusList_.dispose();
    numberList_.dispose();
    indexChange_.dispose();
    return BRISK._(p);
  }

  /// The BRISK constructor for a custom pattern, detection threshold and octaves
  ///
  /// [thresh] AGAST detection threshold score.
  /// [octaves] detection octaves. Use 0 to do single scale.
  /// [radiusList] defines the radii (in pixels) where the samples around a keypoint are taken (for keypoint scale 1).
  /// [numberList] defines the number of sampling points on the sampling circle. Must be the same size as radiusList..
  /// [dMax] threshold for the short pairings used for descriptor formation (in pixels for keypoint scale 1).
  /// [dMin] threshold for the long pairings used for orientation determination (in pixels for keypoint scale 1).
  /// [indexChange] index remapping of the bits.
  ///
  /// ```c++
  /// CV_WRAP static Ptr<BRISK> create(int thresh, int octaves, const std::vector<float> &radiusList,
  ///     const std::vector<int> &numberList, float dMax=5.85f, float dMin=8.2f,
  ///     const std::vector<int>& indexChange=std::vector<int>());
  ///```
  /// https://docs.opencv.org/4.x/de/dbf/classcv_1_1BRISK.html#a4204a459edce314ace1c2bd783e2b185
  factory BRISK.create2({
    required int thresh,
    required int octaves,
    required List<double> radiusList,
    required List<int> numberList,
    double dMax = 5.85,
    double dMin = 8.2,
    List<int>? indexChange,
  }) {
    final p = calloc<cvg.BRISK>();
    final radiusList_ = radiusList.f32;
    final numberList_ = numberList.i32;
    final indexChange_ = indexChange?.i32 ?? VecI32();
    cvRun(
      () => cfeatures2d.cv_BRISK_create_2(
        thresh,
        octaves,
        radiusList_.ref,
        numberList_.ref,
        dMax,
        dMin,
        indexChange_.ref,
        p,
      ),
    );
    radiusList_.dispose();
    numberList_.dispose();
    indexChange_.dispose();
    return BRISK._(p);
  }

  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_BRISK_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    descriptors ??= Mat.empty();
    keypoints ??= VecKeyPoint();
    cvRun(
      () => cfeatures2d.cv_BRISK_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        descriptors!.ref,
        keypoints!.ptr,
        useProvidedKeypoints,
        ffi.nullptr,
      ),
    );
    return (keypoints, descriptors);
  }

  static final finalizer = OcvFinalizer<cvg.BRISKPtr>(cfeatures2d.addresses.cv_BRISK_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_BRISK_close(ptr);
  }

  @override
  cvg.BRISK get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.BRISK";

  @override
  bool get isEmpty => cfeatures2d.cv_BRISK_empty(ref);

  int get threshold => cfeatures2d.cv_BRISK_getThreshold(ref);
  set threshold(int value) => cfeatures2d.cv_BRISK_setThreshold(ref, value);

  /// Set detection octaves.
  ///  [octaves] detection octaves. Use 0 to do single scale.
  int get octaves => cfeatures2d.cv_BRISK_getOctaves(ref);
  set octaves(int value) => cfeatures2d.cv_BRISK_setOctaves(ref, value);

  /// Set detection patternScale.
  ///  [patternScale] apply this scale to the pattern used for sampling the neighbourhood of a keypoint.
  double get patternScale => cfeatures2d.cv_BRISK_getPatternScale(ref);
  set patternScale(double value) => cfeatures2d.cv_BRISK_setPatternScale(ref, value);

  @override
  String toString() {
    return "BRISK(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// FastFeatureDetector is a wrapper around the cv::FastFeatureDetector.
class FastFeatureDetector extends Feature2D<cvg.FastFeatureDetector> {
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
    cvRun(() => cfeatures2d.cv_FastFeatureDetector_create_1(threshold, nonmaxSuppression, type.value, p));
    return FastFeatureDetector._(p);
  }

  /// Detect keypoints in an image using FastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(
      () => cfeatures2d.cv_FastFeatureDetector_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr),
    );
    return keypoints;
  }

  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    throw UnsupportedError("This function/feature is not supported.");
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

  @override
  String get defaultName => "${super.defaultName}.FastFeatureDetector";

  @override
  bool get isEmpty => cfeatures2d.cv_FastFeatureDetector_empty(ref);

  int get threshold => cfeatures2d.cv_FastFeatureDetector_getThreshold(ref);
  set threshold(int value) => cfeatures2d.cv_FastFeatureDetector_setThreshold(ref, value);

  bool get nonmaxSuppression => cfeatures2d.cv_FastFeatureDetector_getNonmaxSuppression(ref);
  set nonmaxSuppression(bool value) => cfeatures2d.cv_FastFeatureDetector_setNonmaxSuppression(ref, value);

  FastFeatureDetectorType get type =>
      FastFeatureDetectorType.fromValue(cfeatures2d.cv_FastFeatureDetector_getType(ref));
  set type(FastFeatureDetectorType value) => cfeatures2d.cv_FastFeatureDetector_setType(ref, value.value);

  @override
  String toString() {
    return "FastFeatureDetector(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// GFTTDetector is a wrapper around the cv::GFTTDetector.
class GFTTDetector extends Feature2D<cvg.GFTTDetector> {
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

  /// ```c++
  /// CV_WRAP static Ptr<GFTTDetector> create( int maxCorners=1000, double qualityLevel=0.01, double minDistance=1,
  /// int blockSize=3, bool useHarrisDetector=false, double k=0.04 );
  /// ```
  factory GFTTDetector.create({
    int maxFeatures = 1000,
    double qualityLevel = 0.01,
    double minDistance = 1,
    int blockSize = 3,
    bool useHarrisDetector = false,
    double k = 0.04,
  }) {
    final p = calloc<cvg.GFTTDetector>();
    cvRun(
      () => cfeatures2d.cv_GFTTDetector_create_2(
        maxFeatures,
        qualityLevel,
        minDistance,
        blockSize,
        useHarrisDetector,
        k,
        p,
      ),
    );
    return GFTTDetector._(p);
  }

  /// ```c++
  /// CV_WRAP static Ptr<GFTTDetector> create( int maxCorners, double qualityLevel, double minDistance,
  /// int blockSize, int gradiantSize, bool useHarrisDetector=false, double k=0.04 );
  /// ```
  factory GFTTDetector.create1({
    int maxCorners = 1000,
    double qualityLevel = 0.01,
    double minDistance = 1,
    int blockSize = 3,
    int gradiantSize = 3,
    bool useHarrisDetector = false,
    double k = 0.04,
  }) {
    final p = calloc<cvg.GFTTDetector>();
    cvRun(
      () => cfeatures2d.cv_GFTTDetector_create_1(
        maxCorners,
        qualityLevel,
        minDistance,
        blockSize,
        gradiantSize,
        useHarrisDetector,
        k,
        p,
      ),
    );
    return GFTTDetector._(p);
  }

  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_GFTTDetector_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    throw UnsupportedError("This function/feature is not supported.");
  }

  static final finalizer = OcvFinalizer<cvg.GFTTDetectorPtr>(cfeatures2d.addresses.cv_GFTTDetector_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_GFTTDetector_close(ptr);
  }

  @override
  cvg.GFTTDetector get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.GFTTDetector";

  @override
  bool get isEmpty => cfeatures2d.cv_GFTTDetector_empty(ref);

  int get maxFeatures => cfeatures2d.cv_GFTTDetector_getMaxFeatures(ref);
  set maxFeatures(int value) => cfeatures2d.cv_GFTTDetector_setMaxFeatures(ref, value);

  double get qualityLevel => cfeatures2d.cv_GFTTDetector_getQualityLevel(ref);
  set qualityLevel(double value) => cfeatures2d.cv_GFTTDetector_setQualityLevel(ref, value);

  double get minDistance => cfeatures2d.cv_GFTTDetector_getMinDistance(ref);
  set minDistance(double value) => cfeatures2d.cv_GFTTDetector_setMinDistance(ref, value);

  int get blockSize => cfeatures2d.cv_GFTTDetector_getBlockSize(ref);
  set blockSize(int value) => cfeatures2d.cv_GFTTDetector_setBlockSize(ref, value);

  int get gradientSize => cfeatures2d.cv_GFTTDetector_getGradientSize(ref);
  set gradientSize(int value) => cfeatures2d.cv_GFTTDetector_setGradientSize(ref, value);

  bool get harrisDetector => cfeatures2d.cv_GFTTDetector_getHarrisDetector(ref);
  set harrisDetector(bool value) => cfeatures2d.cv_GFTTDetector_setHarrisDetector(ref, value);

  double get k => cfeatures2d.cv_GFTTDetector_getK(ref);
  set k(double value) => cfeatures2d.cv_GFTTDetector_setK(ref, value);

  @override
  String toString() {
    return "GFTTDetector(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// KAZE is a wrapper around the cv::KAZE.
class KAZE extends Feature2D<cvg.KAZE> {
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

  //// The KAZE constructor
  ///
  /// [extended] Set to enable extraction of extended (128-byte) descriptor.
  /// [upright] Set to enable use of upright descriptors (non rotation-invariant).
  /// [threshold] Detector response threshold to accept point
  /// [nOctaves] Maximum octave evolution of the image
  /// [nOctaveLayers] Default number of sublevels per scale level
  /// [diffusivity] Diffusivity type. DIFF_PM_G1, DIFF_PM_G2, DIFF_WEICKERT or DIFF_CHARBONNIER
  /// ```c++
  /// CV_WRAP static Ptr<KAZE> create(bool extended=false, bool upright=false,
  ///  float threshold = 0.001f,
  ///  int nOctaves = 4, int nOctaveLayers = 4,
  ///  KAZE::DiffusivityType diffusivity = KAZE::DIFF_PM_G2);
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d3/d61/classcv_1_1KAZE.html#a2fdb3848a465a55bc39941f5af99f7e3
  factory KAZE.create({
    bool extended = false,
    bool upright = false,
    double threshold = 0.001,
    int nOctaves = 4,
    int nOctaveLayers = 4,
    KAZEDiffusivityType diffusivity = KAZEDiffusivityType.DIFF_PM_G2,
  }) {
    final p = calloc<cvg.KAZE>();
    cvRun(
      () => cfeatures2d.cv_KAZE_create_1(
        extended,
        upright,
        threshold,
        nOctaves,
        nOctaveLayers,
        diffusivity.value,
        p,
      ),
    );
    return KAZE._(p);
  }

  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_KAZE_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    descriptors ??= Mat.empty();
    keypoints ??= VecKeyPoint();
    cvRun(
      () => cfeatures2d.cv_KAZE_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        descriptors!.ref,
        keypoints!.ptr,
        useProvidedKeypoints,
        ffi.nullptr,
      ),
    );
    return (keypoints, descriptors);
  }

  static final finalizer = OcvFinalizer<cvg.KAZEPtr>(cfeatures2d.addresses.cv_KAZE_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_KAZE_close(ptr);
  }

  @override
  cvg.KAZE get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.KAZE";

  @override
  bool get isEmpty => cfeatures2d.cv_KAZE_empty(ref);

  set extended(bool extended) => cfeatures2d.cv_KAZE_setExtended(ref, extended);
  bool get extended => cfeatures2d.cv_KAZE_getExtended(ref);

  set upright(bool upright) => cfeatures2d.cv_KAZE_setUpright(ref, upright);
  bool get upright => cfeatures2d.cv_KAZE_getUpright(ref);

  set threshold(double threshold) => cfeatures2d.cv_KAZE_setThreshold(ref, threshold);
  double get threshold => cfeatures2d.cv_KAZE_getThreshold(ref);

  set octaves(int octaves) => cfeatures2d.cv_KAZE_setNOctaves(ref, octaves);
  int get octaves => cfeatures2d.cv_KAZE_getNOctaves(ref);

  set nOctaveLayers(int octaveLayers) => cfeatures2d.cv_KAZE_setNOctaveLayers(ref, octaveLayers);
  int get nOctaveLayers => cfeatures2d.cv_KAZE_getNOctaveLayers(ref);

  set diffusivity(KAZEDiffusivityType diff) => cfeatures2d.cv_KAZE_setDiffusivity(ref, diff.value);
  KAZEDiffusivityType get diffusivity =>
      KAZEDiffusivityType.fromValue(cfeatures2d.cv_KAZE_getDiffusivity(ref));

  @override
  String toString() {
    return "KAZE(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// MSER is a wrapper around the cv::MSER.
class MSER extends Feature2D<cvg.MSER> {
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

  /// Full constructor for %MSER detector
  ///
  /// delta it compares \f$(size_{i}-size_{i-delta})/size_{i-delta}\f$
  /// min_area prune the area which smaller than minArea
  /// max_area prune the area which bigger than maxArea
  /// max_variation prune the area have similar size to its children
  /// min_diversity for color image, trace back to cut off mser with diversity less than min_diversity
  /// max_evolution  for color image, the evolution steps
  /// area_threshold for color image, the area threshold to cause re-initialize
  /// min_margin for color image, ignore too small margin
  /// edge_blur_size for color image, the aperture size for edge blur
  /// ```c++
  ///CV_WRAP static Ptr<MSER> create( int delta=5, int min_area=60, int max_area=14400,
  ///      double max_variation=0.25, double min_diversity=.2,
  ///      int max_evolution=200, double area_threshold=1.01,
  ///      double min_margin=0.003, int edge_blur_size=5 );
  /// ```
  ///
  factory MSER.create({
    int delta = 5,
    int minArea = 60,
    int maxArea = 14400,
    double maxVariation = 0.25,
    double minDiversity = 0.2,
    int maxEvolution = 200,
    double areaThreshold = 1.01,
    double minMargin = 0.003,
    int edgeBlurSize = 5,
  }) {
    final p = calloc<cvg.MSER>();
    cvRun(
      () => cfeatures2d.cv_MSER_create_1(
        delta,
        minArea,
        maxArea,
        maxVariation,
        minDiversity,
        maxEvolution,
        areaThreshold,
        minMargin,
        edgeBlurSize,
        p,
      ),
    );
    return MSER._(p);
  }

  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_MSER_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    throw UnsupportedError("This fuction/feature is not supported.");
  }

  static final finalizer = OcvFinalizer<cvg.MSERPtr>(cfeatures2d.addresses.cv_MSER_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_MSER_close(ptr);
  }

  @override
  cvg.MSER get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.MSER";

  @override
  bool get isEmpty => cfeatures2d.cv_MSER_empty(ref);

  set delta(int delta) => cfeatures2d.cv_MSER_setDelta(ref, delta);
  int get delta => cfeatures2d.cv_MSER_getDelta(ref);

  set minArea(int minArea) => cfeatures2d.cv_MSER_setMinArea(ref, minArea);
  int get minArea => cfeatures2d.cv_MSER_getMinArea(ref);

  set maxArea(int maxArea) => cfeatures2d.cv_MSER_setMaxArea(ref, maxArea);
  int get maxArea => cfeatures2d.cv_MSER_getMaxArea(ref);

  set maxVariation(double maxVariation) => cfeatures2d.cv_MSER_setMaxVariation(ref, maxVariation);
  double get maxVariation => cfeatures2d.cv_MSER_getMaxVariation(ref);

  set minDiversity(double minDiversity) => cfeatures2d.cv_MSER_setMinDiversity(ref, minDiversity);
  double get minDiversity => cfeatures2d.cv_MSER_getMinDiversity(ref);

  set maxEvolution(int maxEvolution) => cfeatures2d.cv_MSER_setMaxEvolution(ref, maxEvolution);
  int get maxEvolution => cfeatures2d.cv_MSER_getMaxEvolution(ref);

  set areaThreshold(double areaThreshold) => cfeatures2d.cv_MSER_setAreaThreshold(ref, areaThreshold);
  double get areaThreshold => cfeatures2d.cv_MSER_getAreaThreshold(ref);

  set minMargin(double minMargin) => cfeatures2d.cv_MSER_setMinMargin(ref, minMargin);
  double get minMargin => cfeatures2d.cv_MSER_getMinMargin(ref);

  set edgeBlurSize(int edgeBlurSize) => cfeatures2d.cv_MSER_setEdgeBlurSize(ref, edgeBlurSize);
  int get edgeBlurSize => cfeatures2d.cv_MSER_getEdgeBlurSize(ref);

  set pass2Only(bool pass2Only) => cfeatures2d.cv_MSER_setPass2Only(ref, pass2Only);
  bool get pass2Only => cfeatures2d.cv_MSER_getPass2Only(ref);

  @override
  String toString() {
    return "MSER(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// ORB is a wrapper around the cv::ORB.
class ORB extends Feature2D<cvg.ORB> {
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
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_ORB_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    keypoints ??= VecKeyPoint();
    descriptors ??= Mat.empty();
    cvRun(
      () => cfeatures2d.cv_ORB_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        descriptors!.ref,
        keypoints!.ptr,
        useProvidedKeypoints,
        ffi.nullptr,
      ),
    );
    return (keypoints, descriptors);
  }

  static final finalizer = OcvFinalizer<cvg.ORBPtr>(cfeatures2d.addresses.cv_ORB_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_ORB_close(ptr);
  }

  @override
  cvg.ORB get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.ORB";

  @override
  bool get isEmpty => cfeatures2d.cv_ORB_empty(ref);

  int get maxFeatures => cfeatures2d.cv_ORB_getMaxFeatures(ref);
  set maxFeatures(int value) => cfeatures2d.cv_ORB_setMaxFeatures(ref, value);

  double get scaleFactor => cfeatures2d.cv_ORB_getScaleFactor(ref);
  set scaleFactor(double value) => cfeatures2d.cv_ORB_setScaleFactor(ref, value);

  int get nLevels => cfeatures2d.cv_ORB_getNLevels(ref);
  set nLevels(int value) => cfeatures2d.cv_ORB_setNLevels(ref, value);

  int get edgeThreshold => cfeatures2d.cv_ORB_getEdgeThreshold(ref);
  set edgeThreshold(int value) => cfeatures2d.cv_ORB_setEdgeThreshold(ref, value);

  int get firstLevel => cfeatures2d.cv_ORB_getFirstLevel(ref);
  set firstLevel(int value) => cfeatures2d.cv_ORB_setFirstLevel(ref, value);

  int get WTA_K => cfeatures2d.cv_ORB_getWTA_K(ref);
  set WTA_K(int value) => cfeatures2d.cv_ORB_setWTA_K(ref, value);

  ORBScoreType get scoreType => ORBScoreType.fromValue(cfeatures2d.cv_ORB_getScoreType(ref));
  set scoreType(ORBScoreType value) => cfeatures2d.cv_ORB_setScoreType(ref, value.value);

  int get patchSize => cfeatures2d.cv_ORB_getPatchSize(ref);
  set patchSize(int value) => cfeatures2d.cv_ORB_setPatchSize(ref, value);

  int get fastThreshold => cfeatures2d.cv_ORB_getFastThreshold(ref);
  set fastThreshold(int value) => cfeatures2d.cv_ORB_setFastThreshold(ref, value);

  @override
  String toString() {
    return "ORB(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// SimpleBlobDetector is a wrapper around the cv::SimpleBlobDetector.
class SimpleBlobDetector extends Feature2D<cvg.SimpleBlobDetector> {
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
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(
      () => cfeatures2d.cv_SimpleBlobDetector_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr),
    );
    return keypoints;
  }

  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  }) {
    throw UnsupportedError("This fuction/feature is not supported.");
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

  @override
  String get defaultName => "${super.defaultName}.SimpleBlobDetector";

  @override
  bool get isEmpty => cfeatures2d.cv_SimpleBlobDetector_empty(ref);

  set params(SimpleBlobDetectorParams params) => cfeatures2d.cv_SimpleBlobDetector_setParams(ref, params.ref);
  SimpleBlobDetectorParams get params =>
      SimpleBlobDetectorParams.fromPointer(cfeatures2d.cv_SimpleBlobDetector_getParams(ref));

  VecVecPoint getBlobContours() =>
      VecVecPoint.fromPointer(cfeatures2d.cv_SimpleBlobDetector_getBlobContours(ref));

  @override
  String toString() {
    return "SimpleBlobDetector(addr=0x${ptr.address.toRadixString(16)})";
  }
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
  /// https://docs.opencv.org/4.x/d3/da1/classcv_1_1BFMatcher.html
  factory BFMatcher.empty() {
    final p = calloc<cvg.BFMatcher>();
    cvRun(() => cfeatures2d.cv_BFMatcher_create(p));
    return BFMatcher._(p);
  }

  /// Brute-force matcher create method.
  ///
  /// https://docs.opencv.org/4.x/d3/da1/classcv_1_1BFMatcher.html#a02ef4d594b33d091767cbfe442aefb8a
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
    final ret = VecDMatch();
    cvRun(() => cfeatures2d.cv_BFMatcher_match(ref, query.ref, train.ref, ret.ptr, ffi.nullptr));
    return ret;
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = VecVecDMatch();
    cvRun(() => cfeatures2d.cv_BFMatcher_knnMatch(ref, query.ref, train.ref, k, ret.ptr, ffi.nullptr));
    return ret;
  }

  static final finalizer = OcvFinalizer<cvg.BFMatcherPtr>(cfeatures2d.addresses.cv_BFMatcher_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_BFMatcher_close(ptr);
  }

  @override
  cvg.BFMatcher get ref => ptr.ref;

  @override
  String toString() {
    return "BFMatcher(addr=0x${ptr.address.toRadixString(16)})";
  }
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
  /// https://docs.opencv.org/4.x/dc/de2/classcv_1_1FlannBasedMatcher.html
  factory FlannBasedMatcher.empty() {
    final p = calloc<cvg.FlannBasedMatcher>();
    cvRun(() => cfeatures2d.cv_FlannBasedMatcher_create(p));
    return FlannBasedMatcher._(p);
  }

  /// https://docs.opencv.org/4.x/dc/de2/classcv_1_1FlannBasedMatcher.html#ab9114a6471e364ad221f89068ca21382
  factory FlannBasedMatcher.create({FlannIndexParams? indexParams, FlannSearchParams? searchParams}) {
    if (indexParams == null && searchParams == null) {
      return FlannBasedMatcher.empty();
    }

    indexParams = indexParams ?? FlannKDTreeIndexParams();
    searchParams = searchParams ?? FlannSearchParams();

    final p = calloc<cvg.FlannBasedMatcher>();
    cvRun(() => cfeatures2d.cv_FlannBasedMatcher_create_1(p, indexParams!.ref, searchParams!.ref));
    return FlannBasedMatcher._(p);
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  VecVecDMatch knnMatch(Mat query, Mat train, int k) {
    final ret = VecVecDMatch();
    cvRun(
      () => cfeatures2d.cv_FlannBasedMatcher_knnMatch(ref, query.ref, train.ref, k, ret.ptr, ffi.nullptr),
    );
    return ret;
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

  @override
  String toString() {
    return "FlannBasedMatcher(addr=0x${ptr.address.toRadixString(16)})";
  }
}

/// SIFT is a wrapper around the cv::SIFT.
class SIFT extends Feature2D<cvg.SIFT> {
  SIFT._(cvg.SIFTPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory SIFT.fromPointer(cvg.SIFTPtr ptr, [bool attach = true]) => SIFT._(ptr, attach);

  /// returns a new SIFT algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/d7/d60/classcv_1_1SIFT.html
  factory SIFT.empty() {
    final p = calloc<cvg.SIFT>();
    cvRun(() => cfeatures2d.cv_SIFT_create(p));
    return SIFT._(p);
  }

  /// Create SIFT with specified descriptorType.
  ///
  /// [nfeatures] The number of best features to retain. The features are ranked by their scores
  /// (measured in SIFT algorithm as the local contrast)
  ///
  /// [nOctaveLayers] The number of layers in each octave. 3 is the value used in D. Lowe paper. The
  /// number of octaves is computed automatically from the image resolution.
  ///
  /// [contrastThreshold] The contrast threshold used to filter out weak features in semi-uniform
  /// (low-contrast) regions. The larger the threshold, the less features are produced by the detector.
  /// Note: The contrast threshold will be divided by nOctaveLayers when the filtering is applied. When
  /// [nOctaveLayers] is set to default and if you want to use the value used in D. Lowe paper, 0.03, set
  /// this argument to 0.09.
  ///
  /// [edgeThreshold] The threshold used to filter out edge-like features. Note that the its meaning
  /// is different from the contrastThreshold, i.e. the larger the edgeThreshold, the less features are
  /// filtered out (more features are retained).
  ///
  /// [sigma] The sigma of the Gaussian applied to the input image at the octave \#0. If your image
  /// is captured with a weak camera with soft lenses, you might want to reduce the number.
  ///
  /// [descriptorType] The type of descriptors. Only CV_32F and CV_8U are supported.
  ///
  /// [enable_precise_upscale] Whether to enable precise upscaling in the scale pyramid, which maps
  /// index $\texttt{x}$ to $\texttt{2x}$. This prevents localization bias. The option
  /// is disabled by default.
  ///
  /// ```c++
  /// CV_WRAP static Ptr<SIFT> create(int nfeatures, int nOctaveLayers,
  ///     double contrastThreshold, double edgeThreshold,
  ///     double sigma, int descriptorType, bool enable_precise_upscale = false);
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d60/classcv_1_1SIFT.html#a4264f700a8133074fb477e30d9beb331
  factory SIFT.create({
    int nfeatures = 0,
    int nOctaveLayers = 3,
    double contrastThreshold = 0.04,
    double edgeThreshold = 10,
    double sigma = 1.6,
    int? descriptorType,
    bool enable_precise_upscale = false,
  }) {
    final p = calloc<cvg.SIFT>();
    cvRun(
      () => descriptorType == null
          ? cfeatures2d.cv_SIFT_create_2(
              nfeatures,
              nOctaveLayers,
              contrastThreshold,
              edgeThreshold,
              sigma,
              enable_precise_upscale,
              p,
            )
          : cfeatures2d.cv_SIFT_create_1(
              nfeatures,
              nOctaveLayers,
              contrastThreshold,
              edgeThreshold,
              sigma,
              descriptorType,
              enable_precise_upscale,
              p,
            ),
    );
    return SIFT._(p);
  }

  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  @override
  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask}) {
    keypoints ??= VecKeyPoint();
    mask ??= Mat.empty();
    cvRun(() => cfeatures2d.cv_SIFT_detect(ref, src.ref, keypoints!.ptr, mask!.ref, ffi.nullptr));
    return keypoints;
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  @override
  (VecKeyPoint, Mat) detectAndCompute(
    Mat src,
    Mat mask, {
    Mat? descriptors,
    VecKeyPoint? keypoints,
    bool useProvidedKeypoints = false,
  }) {
    descriptors ??= Mat.empty();
    keypoints ??= VecKeyPoint();
    cvRun(
      () => cfeatures2d.cv_SIFT_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        descriptors!.ref,
        keypoints!.ptr,
        useProvidedKeypoints,
        ffi.nullptr,
      ),
    );
    return (keypoints, descriptors);
  }

  static final finalizer = OcvFinalizer<cvg.SIFTPtr>(cfeatures2d.addresses.cv_SIFT_close);

  void dispose() {
    finalizer.detach(this);
    cfeatures2d.cv_SIFT_close(ptr);
  }

  @override
  cvg.SIFT get ref => ptr.ref;

  @override
  String get defaultName => "${super.defaultName}.SIFT";

  @override
  bool get isEmpty => cfeatures2d.cv_SIFT_empty(ref);

  set NFeatures(int maxFeatures) => cfeatures2d.cv_SIFT_setNFeatures(ref, maxFeatures);
  int get NFeatures => cfeatures2d.cv_SIFT_getNFeatures(ref);

  set nOctaveLayers(int nOctaveLayers) => cfeatures2d.cv_SIFT_setNOctaveLayers(ref, nOctaveLayers);
  int get nOctaveLayers => cfeatures2d.cv_SIFT_getNOctaveLayers(ref);

  set contrastThreshold(double contrastThreshold) =>
      cfeatures2d.cv_SIFT_setContrastThreshold(ref, contrastThreshold);
  double get contrastThreshold => cfeatures2d.cv_SIFT_getContrastThreshold(ref);

  set edgeThreshold(double edgeThreshold) => cfeatures2d.cv_SIFT_setEdgeThreshold(ref, edgeThreshold);
  double get edgeThreshold => cfeatures2d.cv_SIFT_getEdgeThreshold(ref);

  set sigma(double sigma) => cfeatures2d.cv_SIFT_setSigma(ref, sigma);
  double get sigma => cfeatures2d.cv_SIFT_getSigma(ref);

  @override
  String toString() {
    return "SIFT(addr=0x${ptr.address.toRadixString(16)})";
  }
}

void drawKeyPoints(Mat src, VecKeyPoint keypoints, Mat dst, Scalar color, DrawMatchesFlag flag) {
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
