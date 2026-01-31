// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv.features2d;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../g/features2d.g.dart' as cvg;
import '../g/features2d.g.dart' as cfeatures2d;

abstract class Feature2D<T extends ffi.Struct> extends CvStruct<T> {
  Feature2D.fromPointer(super.ptr) : super.fromPointer();

  VecKeyPoint detect(Mat src, {VecKeyPoint? keypoints, Mat? mask});
  (VecKeyPoint ret, Mat desc) detectAndCompute(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? descriptors,
    bool useProvidedKeypoints = false,
  });

  String get defaultName => 'Feature2D';

  bool get isEmpty;
}

class FlannIndexParams extends CvStruct<cvg.FlannIndexParams> {
  FlannIndexParams.fromPointer(cvg.FlannIndexParamsPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory FlannIndexParams.empty() {
    final p = calloc<cvg.FlannIndexParams>();
    cvRun(() => cfeatures2d.cv_flann_IndexParams_create(p));
    return FlannIndexParams.fromPointer(p);
  }

  factory FlannIndexParams.fromMap(Map<String, dynamic> map) {
    final params = FlannIndexParams.empty();
    for (final entry in map.entries) {
      switch (entry.value) {
        case int():
          params.set<int>(entry.key, entry.value as int);
        case double():
          params.set<double>(entry.key, entry.value as double);
        case String():
          params.set<String>(entry.key, entry.value as String);
        case bool():
          params.set<bool>(entry.key, entry.value as bool);
        case cvg.FlannAlgorithm():
          params.set<cvg.FlannAlgorithm>(entry.key, entry.value as cvg.FlannAlgorithm);
        default:
          throw ArgumentError('Value type ${entry.value.runtimeType} is not supported for FlannIndexParams');
      }
    }
    return params;
  }

  static final finalizer = OcvFinalizer<cvg.FlannIndexParamsPtr>(
    cfeatures2d.addresses.cv_flann_IndexParams_close,
  );

  @override
  cvg.FlannIndexParams get ref => ptr.ref;

  String getString(String key, [String defaultValue = ""]) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    final cdefault = defaultValue.toNativeUtf8().cast<ffi.Char>();
    final crval = calloc<ffi.Pointer<ffi.Char>>();
    cfeatures2d.cv_flann_IndexParams_getString(ref, ckey, cdefault, crval);
    calloc.free(ckey);
    calloc.free(cdefault);

    final rval = crval.value.cast<ffi.Char>().toDartString();
    calloc.free(crval);
    return rval;
  }

  int getInt(String key, [int defaultValue = -1]) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    final crval = calloc<ffi.Int>();
    cfeatures2d.cv_flann_IndexParams_getInt(ref, ckey, defaultValue, crval);
    calloc.free(ckey);
    final rval = crval.value;
    calloc.free(crval);
    return rval;
  }

  double getDouble(String key, [double defaultValue = -1]) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    final crval = calloc<ffi.Double>();
    cfeatures2d.cv_flann_IndexParams_getDouble(ref, ckey, defaultValue, crval);
    calloc.free(ckey);
    final rval = crval.value;
    calloc.free(crval);
    return rval;
  }

  // bool getBool(String key, [bool defaultValue = false]) {
  //   final ckey = key.toNativeUtf8().cast<ffi.Char>();
  //   final crval = calloc<ffi.Bool>();
  //   cfeatures2d.cv_flann_IndexParams_getBool(ref, ckey, defaultValue, crval);
  //   calloc.free(ckey);
  //   final rval = crval.value;
  //   calloc.free(crval);
  //   return rval;
  // }

  Map<String, dynamic> getAll() {
    final names = VecVecChar();
    final types = VecI32();
    final strValues = VecVecChar();
    final numValues = VecF64();

    cfeatures2d.cv_flann_IndexParams_getAll(ref, names.ptr, types.ptr, strValues.ptr, numValues.ptr);

    final rval = <String, dynamic>{};
    final names1 = names.asStringList();
    for (var i = 0; i < names1.length; i++) {
      final name = names1[i];
      final type = types[i];
      rval[name] = switch (cvg.FlannIndexType.fromValue(type)) {
        cvg.FlannIndexType.FLANN_INDEX_TYPE_8U ||
        cvg.FlannIndexType.FLANN_INDEX_TYPE_8S ||
        cvg.FlannIndexType.FLANN_INDEX_TYPE_16U ||
        cvg.FlannIndexType.FLANN_INDEX_TYPE_16S ||
        cvg.FlannIndexType.FLANN_INDEX_TYPE_32S => numValues[i].toInt(),
        cvg.FlannIndexType.FLANN_INDEX_TYPE_32F || cvg.FlannIndexType.FLANN_INDEX_TYPE_64F => numValues[i],
        cvg.FlannIndexType.FLANN_INDEX_TYPE_BOOL => numValues[i].toInt() != 0,
        cvg.FlannIndexType.FLANN_INDEX_TYPE_STRING => names1[i],
        cvg.FlannIndexType.FLANN_INDEX_TYPE_ALGORITHM => cvg.FlannAlgorithm.fromValue(numValues[i].toInt()),
      };
    }

    return rval;
  }

  void setString(String key, String value) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    final cvalue = value.toNativeUtf8().cast<ffi.Char>();
    cfeatures2d.cv_flann_IndexParams_setString(ref, ckey, cvalue);
    calloc.free(ckey);
    calloc.free(cvalue);
  }

  void setInt(String key, int value) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    cfeatures2d.cv_flann_IndexParams_setInt(ref, ckey, value);
    calloc.free(ckey);
  }

  void setDouble(String key, double value) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    cfeatures2d.cv_flann_IndexParams_setDouble(ref, ckey, value);
    calloc.free(ckey);
  }

  void setBool(String key, bool value) {
    final ckey = key.toNativeUtf8().cast<ffi.Char>();
    cfeatures2d.cv_flann_IndexParams_setBool(ref, ckey, value);
    calloc.free(ckey);
  }

  void setAlgorithm(cvg.FlannAlgorithm value) {
    cfeatures2d.cv_flann_IndexParams_setAlgorithm(ref, value.value);
  }

  T get<T>(String key, [T? defaultValue]) {
    if (T == int) {
      return getInt(key, defaultValue as int? ?? -1) as T;
    } else if (T == double) {
      return getDouble(key, defaultValue as double? ?? -1.0) as T;
    } else if (T == String) {
      return getString(key, defaultValue as String? ?? "") as T;
    } else {
      throw ArgumentError("Unsupported type: ${T.runtimeType}");
    }
  }

  void set<T>(String key, T value) {
    switch (value) {
      case int():
        setInt(key, value);
      case double():
        setDouble(key, value);
      case String():
        setString(key, value);
      case bool():
        setBool(key, value);
      case cvg.FlannAlgorithm():
        setAlgorithm(value);
      default:
        throw ArgumentError("Unsupported type: ${value.runtimeType}");
    }
  }

  @override
  String toString() {
    return "FlannIndexParams(address=0x${ptr.address.toRadixString(16)})";
  }
}

class FlannSearchParams extends FlannIndexParams {
  FlannSearchParams.fromPointer(
    super.ptr,
    int checks,
    double eps,
    bool sorted,
    bool exploreAllTrees, [
    super.attach = true,
  ]) : _checks = checks,
       _eps = eps,
       _sorted = sorted,
       _exploreAllTrees = exploreAllTrees,
       super.fromPointer();

  factory FlannSearchParams({
    int checks = 32,
    double eps = 0.0,
    bool sorted = true,
    bool exploreAllTrees = false,
  }) {
    final p = calloc<cvg.FlannIndexParams>();
    cvRun(() => cfeatures2d.cv_flann_IndexParams_create(p));
    final params = FlannSearchParams.fromPointer(p, checks, eps, sorted, exploreAllTrees);

    params.setInt('checks', checks);
    params.setDouble('eps', eps);

    params.setInt('sorted', sorted ? 1 : 0);
    params.setInt('explore_all_trees', exploreAllTrees ? 1 : 0);

    return params;
  }

  int _checks;
  double _eps;
  bool _sorted;
  bool _exploreAllTrees;

  int get checks => _checks;
  double get eps => _eps;
  bool get sorted => _sorted;
  bool get exploreAllTrees => _exploreAllTrees;

  set checks(int value) {
    _checks = value;
    setInt("checks", value);
  }

  set eps(double value) {
    _eps = value;
    setDouble("eps", value);
  }

  set sorted(bool value) {
    _sorted = value;
    setInt("sorted", value ? 1 : 0);
  }

  set exploreAllTrees(bool value) {
    _exploreAllTrees = value;
    setInt("explore_all_trees", value ? 1 : 0);
  }

  @override
  String toString() {
    return "FlannSearchParams("
        "address=0x${ptr.address.toRadixString(16)}, "
        "checks=$checks, "
        "eps=$eps, "
        "sorted=$sorted, "
        "exploreAllTrees=$exploreAllTrees)";
  }
}

class FlannKDTreeIndexParams extends FlannIndexParams {
  FlannKDTreeIndexParams.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory FlannKDTreeIndexParams({int trees = 4}) {
    final p = calloc<cvg.FlannIndexParams>();
    cvRun(() => cfeatures2d.cv_flann_IndexParams_create(p));
    final params = FlannKDTreeIndexParams.fromPointer(p);

    params.setAlgorithm(cvg.FlannAlgorithm.FLANN_INDEX_KDTREE);
    params.setInt('trees', trees);

    return params;
  }

  int get trees => getInt("trees");
  set trees(int value) => setInt("trees", value);

  @override
  String toString() {
    return 'FlannKDTreeIndexParams(address=0x${ptr.address.toRadixString(16)}, trees=$trees)';
  }
}

class SimpleBlobDetectorParams extends CvStruct<cvg.SimpleBlobDetectorParams> {
  SimpleBlobDetectorParams._(ffi.Pointer<cvg.SimpleBlobDetectorParams> ptr, [bool attach = true])
    : super.fromPointer(ptr) {
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
  ]) => SimpleBlobDetectorParams._(p, attach);

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
