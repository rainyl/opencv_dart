// Copyright (c) 2025, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.calib3d;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../g/calib3d.g.dart' as cvg;

/// Class for computing stereo correspondence using the block matching algorithm,
/// introduced and contributed to OpenCV by K. Konolige.
///
/// This class implements a block matching algorithm for stereo correspondence,
/// which is used to compute disparity maps from stereo image pairs.
/// It provides methods to fine-tune parameters such as pre-filtering, texture thresholds,
/// uniqueness ratios, and regions of interest (ROIs) to optimize performance and accuracy.
///
/// https://docs.opencv.org/4.x/d9/dba/classcv_1_1StereoBM.html#details
class StereoBM extends CvStruct<cvg.StereoBM> {
  StereoBM._(cvg.StereoBMPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory StereoBM.fromPointer(cvg.StereoBMPtr ptr) => StereoBM._(ptr);

  /// Creates [StereoBM] object.
  ///
  /// https://docs.opencv.org/4.x/d9/dba/classcv_1_1StereoBM.html#a119436b6cb382e0895dd0fa58229ec17
  factory StereoBM.create({int numDisparities = 0, int blockSize = 21}) {
    final p = calloc<cvg.StereoBM>();
    cvRun(() => cvg.cv_StereoBM_create(numDisparities, blockSize, p, ffi.nullptr));
    return StereoBM._(p);
  }

  static final finalizer = OcvFinalizer<cvg.StereoBMPtr>(cvg.addresses.cv_StereoBM_close);

  int get preFilterCap => cvg.cv_StereoBM_getPreFilterCap(ref);
  set preFilterCap(int val) => cvg.cv_StereoBM_setPreFilterCap(ref, val);

  int get preFilterSize => cvg.cv_StereoBM_getPreFilterSize(ref);
  set preFilterSize(int val) => cvg.cv_StereoBM_setPreFilterSize(ref, val);

  int get preFilterType => cvg.cv_StereoBM_getPreFilterType(ref);
  set preFilterType(int val) => cvg.cv_StereoBM_setPreFilterType(ref, val);

  Rect get ROI1 => Rect.fromPointer(cvg.cv_StereoBM_getROI1(ref));
  set ROI1(Rect val) => cvg.cv_StereoBM_setROI1(ref, val.ref);

  Rect get ROI2 => Rect.fromPointer(cvg.cv_StereoBM_getROI2(ref));
  set ROI2(Rect val) => cvg.cv_StereoBM_setROI2(ref, val.ref);

  int get smallerBlockSize => cvg.cv_StereoBM_getSmallerBlockSize(ref);

  /// Warning: do nothing
  ///
  /// https://github.com/opencv/opencv/blob/75d9ac39643f8e08edf3299e47ffd1468e0c5196/modules/calib3d/src/stereobm.cpp#L1335
  set smallerBlockSize(int val) => cvg.cv_StereoBM_setSmallerBlockSize(ref, val);

  int get textureThreshold => cvg.cv_StereoBM_getTextureThreshold(ref);
  set textureThreshold(int val) => cvg.cv_StereoBM_setTextureThreshold(ref, val);

  int get uniquenessRatio => cvg.cv_StereoBM_getUniquenessRatio(ref);
  set uniquenessRatio(int val) => cvg.cv_StereoBM_setUniquenessRatio(ref, val);

  //  Public Member Functions inherited from cv::StereoMatcher

  Mat compute(Mat left, Mat right, {Mat? disparity}) {
    disparity ??= Mat.empty();
    cvRun(() => cvg.cv_StereoBM_compute(ref, left.ref, right.ref, disparity!.ref));
    return disparity;
  }

  int get blockSize => cvg.cv_StereoBM_getBlockSize(ref);
  set blockSize(int val) => cvg.cv_StereoBM_setBlockSize(ref, val);

  int get disp12MaxDiff => cvg.cv_StereoBM_getDisp12MaxDiff(ref);
  set disp12MaxDiff(int val) => cvg.cv_StereoBM_setDisp12MaxDiff(ref, val);

  int get minDisparity => cvg.cv_StereoBM_getMinDisparity(ref);
  set minDisparity(int val) => cvg.cv_StereoBM_setMinDisparity(ref, val);

  // int  getNumDisparities
  int get numDisparities => cvg.cv_StereoBM_getNumDisparities(ref);
  set numDisparities(int val) => cvg.cv_StereoBM_setNumDisparities(ref, val);

  // int  getSpeckleRange
  int get speckleRange => cvg.cv_StereoBM_getSpeckleRange(ref);
  set speckleRange(int val) => cvg.cv_StereoBM_setSpeckleRange(ref, val);

  // int  getSpeckleWindowSize
  int get speckleWindowSize => cvg.cv_StereoBM_getSpeckleWindowSize(ref);
  set speckleWindowSize(int val) => cvg.cv_StereoBM_setSpeckleWindowSize(ref, val);

  void dispose() {
    finalizer.detach(this);
    cvg.cv_StereoBM_close(ptr);
  }

  @override
  cvg.StereoBM get ref => ptr.ref;

  @override
  String toString() {
    return "StereoBM(address=0x${ptr.address.toRadixString(16)})";
  }

  /// Pre-filter types for the stereo matching algorithm.
  /// Uses normalized response for pre-filtering.
  static const int PREFILTER_NORMALIZED_RESPONSE = 0;

  /// Pre-filter types for the stereo matching algorithm.
  /// Uses the X-Sobel operator for pre-filtering.
  static const int PREFILTER_XSOBEL = 1;
}

/// The class implements the modified H. Hirschmuller algorithm [128] that differs from the original one as follows:
///
/// * By default, the algorithm is single-pass, which means that you consider only 5 directions instead of 8. Set mode=StereoSGBM::MODE_HH in createStereoSGBM to run the full variant of the algorithm but beware that it may consume a lot of memory.
/// * The algorithm matches blocks, not individual pixels. Though, setting blockSize=1 reduces the blocks to single pixels.
/// * Mutual information cost function is not implemented. Instead, a simpler Birchfield-Tomasi sub-pixel metric from [29] is used. Though, the color images are supported as well.
/// * Some pre- and post- processing steps from K. Konolige algorithm StereoBM are included, for example: pre-filtering (StereoBM::PREFILTER_XSOBEL type) and post-filtering (uniqueness check, quadratic interpolation and speckle filtering).
///
/// https://docs.opencv.org/4.x/d2/d85/classcv_1_1StereoSGBM.html#details
class StereoSGBM extends CvStruct<cvg.StereoSGBM> {
  StereoSGBM._(cvg.StereoSGBMPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory StereoSGBM.fromPointer(cvg.StereoSGBMPtr ptr) => StereoSGBM._(ptr);

  /// Creates StereoSGBM object.
  ///
  /// https://docs.opencv.org/4.x/d2/d85/classcv_1_1StereoSGBM.html#a177fd40dc0dae3a96059dbb3ad92a019
  factory StereoSGBM.create({
    int minDisparity = 0,
    int numDisparities = 16,
    int blockSize = 3,
    int P1 = 0,
    int P2 = 0,
    int disp12MaxDiff = 0,
    int preFilterCap = 0,
    int uniquenessRatio = 0,
    int speckleWindowSize = 0,
    int speckleRange = 0,
    int mode = MODE_SGBM,
  }) {
    final p = calloc<cvg.StereoSGBM>();
    cvRun(
      () => cvg.cv_StereoSGBM_create(
        minDisparity,
        numDisparities,
        blockSize,
        P1,
        P2,
        disp12MaxDiff,
        preFilterCap,
        uniquenessRatio,
        speckleWindowSize,
        speckleRange,
        mode,
        p,
        ffi.nullptr,
      ),
    );
    return StereoSGBM._(p);
  }

  static final finalizer = OcvFinalizer<cvg.StereoSGBMPtr>(cvg.addresses.cv_StereoSGBM_close);

  int get preFilterCap => cvg.cv_StereoSGBM_getPreFilterCap(ref);
  set preFilterCap(int val) => cvg.cv_StereoSGBM_setPreFilterCap(ref, val);

  int get mode => cvg.cv_StereoSGBM_getMode(ref);
  set mode(int val) => cvg.cv_StereoSGBM_setMode(ref, val);

  int get P1 => cvg.cv_StereoSGBM_getP1(ref);
  set P1(int val) => cvg.cv_StereoSGBM_setP1(ref, val);

  int get P2 => cvg.cv_StereoSGBM_getP2(ref);
  set P2(int val) => cvg.cv_StereoSGBM_setP2(ref, val);

  int get uniquenessRatio => cvg.cv_StereoSGBM_getUniquenessRatio(ref);
  set uniquenessRatio(int val) => cvg.cv_StereoSGBM_setUniquenessRatio(ref, val);

  //  Public Member Functions inherited from cv::StereoMatcher

  Mat compute(Mat left, Mat right, {Mat? disparity}) {
    disparity ??= Mat.empty();
    cvRun(() => cvg.cv_StereoSGBM_compute(ref, left.ref, right.ref, disparity!.ref));
    return disparity;
  }

  int get blockSize => cvg.cv_StereoSGBM_getBlockSize(ref);
  set blockSize(int val) => cvg.cv_StereoSGBM_setBlockSize(ref, val);

  int get disp12MaxDiff => cvg.cv_StereoSGBM_getDisp12MaxDiff(ref);
  set disp12MaxDiff(int val) => cvg.cv_StereoSGBM_setDisp12MaxDiff(ref, val);

  int get minDisparity => cvg.cv_StereoSGBM_getMinDisparity(ref);
  set minDisparity(int val) => cvg.cv_StereoSGBM_setMinDisparity(ref, val);

  // int  getNumDisparities
  int get numDisparities => cvg.cv_StereoSGBM_getNumDisparities(ref);
  set numDisparities(int val) => cvg.cv_StereoSGBM_setNumDisparities(ref, val);

  // int  getSpeckleRange
  int get speckleRange => cvg.cv_StereoSGBM_getSpeckleRange(ref);
  set speckleRange(int val) => cvg.cv_StereoSGBM_setSpeckleRange(ref, val);

  // int  getSpeckleWindowSize
  int get speckleWindowSize => cvg.cv_StereoSGBM_getSpeckleWindowSize(ref);
  set speckleWindowSize(int val) => cvg.cv_StereoSGBM_setSpeckleWindowSize(ref, val);

  void dispose() {
    finalizer.detach(this);
    cvg.cv_StereoSGBM_close(ptr);
  }

  @override
  cvg.StereoSGBM get ref => ptr.ref;

  @override
  String toString() {
    return "StereoSGBM(address=0x${ptr.address.toRadixString(16)})";
  }

  static const int MODE_SGBM = 0;
  static const int MODE_HH = 1;
  static const int MODE_SGBM_3WAY = 2;
  static const int MODE_HH4 = 3;
}
