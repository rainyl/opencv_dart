// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as cvg;
import '../native_lib.dart' show ccontrib;
import 'aruco_dict.dart';

class ArucoDetector extends CvStruct<cvg.ArucoDetector> {
  ArucoDetector._(cvg.ArucoDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory ArucoDetector.fromPointer(
    cvg.ArucoDetectorPtr ptr, [
    bool attach = true,
  ]) =>
      ArucoDetector._(ptr, attach);

  factory ArucoDetector.empty() {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(() => ccontrib.cv_aruco_arucoDetector_create(p));
    return ArucoDetector._(p);
  }

  factory ArucoDetector.create(ArucoDictionary dictionary, ArucoDetectorParameters parameters) {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(
      () => ccontrib.cv_aruco_arucoDetector_create_1(
        dictionary.ref,
        parameters.ref,
        p,
      ),
    );
    return ArucoDetector.fromPointer(p);
  }

  @override
  cvg.ArucoDetector get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.ArucoDetectorPtr>(ccontrib.addresses.cv_aruco_arucoDetector_close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_aruco_arucoDetector_close(ptr);
  }

  /// DetectMarkers does basic marker detection.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d6a/group__aruco.html#ga3bc50d61fe4db7bce8d26d56b5a6428a
  (VecVecPoint2f corners, VecI32 ids, VecVecPoint2f rejectedImgPoints) detectMarkers(InputArray image) {
    final corners = VecVecPoint2f();
    final rejected = VecVecPoint2f();
    final ids = VecI32();
    cvRun(
      () => ccontrib.cv_aruco_arucoDetector_detectMarkers(
        ref,
        image.ref,
        corners.ptr,
        ids.ptr,
        rejected.ptr,
        ffi.nullptr,
      ),
    );
    return (corners, ids, rejected);
  }
}

void arucoDrawDetectedMarkers(
  Mat img,
  VecVecPoint2f markerCorners,
  VecI32 markerIds,
  Scalar borderColor,
) {
  cvRun(
    () => ccontrib.cv_aruco_drawDetectedMarkers(
      img.ref,
      markerCorners.ref,
      markerIds.ref,
      borderColor.ref,
      ffi.nullptr,
    ),
  );
}

Mat arucoGenerateImageMarker(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  int borderBits, [
  Mat? outImg,
]) {
  outImg ??= Mat.empty();
  cvRun(
    () => ccontrib.cv_aruco_generateImageMarker(
      dictionaryId.value,
      id,
      sidePixels,
      borderBits,
      outImg!.ref,
      ffi.nullptr,
    ),
  );
  return outImg;
}

class ArucoDetectorParameters extends CvStruct<cvg.ArucoDetectorParams> {
  ArucoDetectorParameters._(
    cvg.ArucoDetectorParamsPtr ptr, [
    bool attach = true,
  ]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory ArucoDetectorParameters.fromPointer(
    cvg.ArucoDetectorParamsPtr ptr, [
    bool attach = true,
  ]) =>
      ArucoDetectorParameters._(ptr, attach);

  factory ArucoDetectorParameters.empty() {
    final p = calloc<cvg.ArucoDetectorParams>();
    cvRun(() => ccontrib.cv_aruco_detectorParameters_create(p));
    return ArucoDetectorParameters._(p);
  }

  @override
  cvg.ArucoDetectorParams get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDetectorParamsPtr>(
    ccontrib.addresses.cv_aruco_detectorParameters_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_aruco_detectorParameters_close(ptr);
  }

  int get adaptiveThreshWinSizeMin => ccontrib.cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMin(ref);

  set adaptiveThreshWinSizeMin(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMin(ref, value);

  int get adaptiveThreshWinSizeMax => ccontrib.cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMax(ref);

  set adaptiveThreshWinSizeMax(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMax(ref, value);

  int get adaptiveThreshWinSizeStep =>
      ccontrib.cv_aruco_detectorParameters_get_adaptiveThreshWinSizeStep(ref);

  set adaptiveThreshWinSizeStep(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_adaptiveThreshWinSizeStep(ref, value);

  double get adaptiveThreshConstant => ccontrib.cv_aruco_detectorParameters_get_adaptiveThreshConstant(ref);

  set adaptiveThreshConstant(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_adaptiveThreshConstant(ref, value);

  double get minMarkerPerimeterRate => ccontrib.cv_aruco_detectorParameters_get_minMarkerPerimeterRate(ref);

  set minMarkerPerimeterRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_minMarkerPerimeterRate(ref, value);

  double get maxMarkerPerimeterRate => ccontrib.cv_aruco_detectorParameters_get_maxMarkerPerimeterRate(ref);

  set maxMarkerPerimeterRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_maxMarkerPerimeterRate(ref, value);

  double get polygonalApproxAccuracyRate =>
      ccontrib.cv_aruco_detectorParameters_get_polygonalApproxAccuracyRate(ref);

  set polygonalApproxAccuracyRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_polygonalApproxAccuracyRate(ref, value);

  double get minCornerDistanceRate => ccontrib.cv_aruco_detectorParameters_get_minCornerDistanceRate(ref);

  set minCornerDistanceRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_minCornerDistanceRate(ref, value);

  int get minDistanceToBorder => ccontrib.cv_aruco_detectorParameters_get_minDistanceToBorder(ref);

  set minDistanceToBorder(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_minDistanceToBorder(ref, value);

  double get minMarkerDistanceRate => ccontrib.cv_aruco_detectorParameters_get_minMarkerDistanceRate(ref);

  set minMarkerDistanceRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_minMarkerDistanceRate(ref, value);

  int get cornerRefinementMethod => ccontrib.cv_aruco_detectorParameters_get_cornerRefinementMethod(ref);

  set cornerRefinementMethod(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_cornerRefinementMethod(ref, value);

  int get cornerRefinementWinSize => ccontrib.cv_aruco_detectorParameters_get_cornerRefinementWinSize(ref);

  set cornerRefinementWinSize(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_cornerRefinementWinSize(ref, value);

  int get cornerRefinementMaxIterations =>
      ccontrib.cv_aruco_detectorParameters_get_cornerRefinementMaxIterations(ref);

  set cornerRefinementMaxIterations(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_cornerRefinementMaxIterations(ref, value);

  double get cornerRefinementMinAccuracy =>
      ccontrib.cv_aruco_detectorParameters_get_cornerRefinementMinAccuracy(ref);

  set cornerRefinementMinAccuracy(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_cornerRefinementMinAccuracy(ref, value);

  int get markerBorderBits => ccontrib.cv_aruco_detectorParameters_get_markerBorderBits(ref);

  set markerBorderBits(int value) => ccontrib.cv_aruco_detectorParameters_set_markerBorderBits(ref, value);

  int get perspectiveRemovePixelPerCell =>
      ccontrib.cv_aruco_detectorParameters_get_perspectiveRemovePixelPerCell(ref);

  set perspectiveRemovePixelPerCell(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_perspectiveRemovePixelPerCell(ref, value);

  double get perspectiveRemoveIgnoredMarginPerCell =>
      ccontrib.cv_aruco_detectorParameters_get_perspectiveRemoveIgnoredMarginPerCell(ref);

  set perspectiveRemoveIgnoredMarginPerCell(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_perspectiveRemoveIgnoredMarginPerCell(ref, value);

  double get maxErroneousBitsInBorderRate =>
      ccontrib.cv_aruco_detectorParameters_get_maxErroneousBitsInBorderRate(ref);

  set maxErroneousBitsInBorderRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_maxErroneousBitsInBorderRate(ref, value);

  double get minOtsuStdDev => ccontrib.cv_aruco_detectorParameters_get_minOtsuStdDev(ref);

  set minOtsuStdDev(double value) => ccontrib.cv_aruco_detectorParameters_set_minOtsuStdDev(ref, value);

  double get errorCorrectionRate => ccontrib.cv_aruco_detectorParameters_get_errorCorrectionRate(ref);

  set errorCorrectionRate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_errorCorrectionRate(ref, value);

  double get aprilTagQuadDecimate => ccontrib.cv_aruco_detectorParameters_get_aprilTagQuadDecimate(ref);

  set aprilTagQuadDecimate(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagQuadDecimate(ref, value);

  double get aprilTagQuadSigma => ccontrib.cv_aruco_detectorParameters_get_aprilTagQuadSigma(ref);

  set aprilTagQuadSigma(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagQuadSigma(ref, value);

  int get aprilTagMinClusterPixels => ccontrib.cv_aruco_detectorParameters_get_aprilTagMinClusterPixels(ref);

  set aprilTagMinClusterPixels(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagMinClusterPixels(ref, value);

  int get aprilTagMaxNmaxima => ccontrib.cv_aruco_detectorParameters_get_aprilTagMaxNmaxima(ref);

  set aprilTagMaxNmaxima(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagMaxNmaxima(ref, value);

  double get aprilTagCriticalRad => ccontrib.cv_aruco_detectorParameters_get_aprilTagCriticalRad(ref);

  set aprilTagCriticalRad(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagCriticalRad(ref, value);

  double get aprilTagMaxLineFitMse => ccontrib.cv_aruco_detectorParameters_get_aprilTagMaxLineFitMse(ref);

  set aprilTagMaxLineFitMse(double value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagMaxLineFitMse(ref, value);

  int get aprilTagMinWhiteBlackDiff =>
      ccontrib.cv_aruco_detectorParameters_get_aprilTagMinWhiteBlackDiff(ref);

  set aprilTagMinWhiteBlackDiff(int value) =>
      ccontrib.cv_aruco_detectorParameters_set_aprilTagMinWhiteBlackDiff(ref, value);

  int get aprilTagDeglitch => ccontrib.cv_aruco_detectorParameters_get_aprilTagDeglitch(ref);

  set aprilTagDeglitch(int value) => ccontrib.cv_aruco_detectorParameters_set_aprilTagDeglitch(ref, value);

  bool get detectInvertedMarker => ccontrib.cv_aruco_detectorParameters_get_detectInvertedMarker(ref);

  set detectInvertedMarker(bool value) =>
      ccontrib.cv_aruco_detectorParameters_set_detectInvertedMarker(ref, value);
}
