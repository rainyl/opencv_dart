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
    cvRun(() => ccontrib.ArucoDetector_New(p));
    return ArucoDetector._(p);
  }

  factory ArucoDetector.create(
    ArucoDictionary dictionary,
    ArucoDetectorParameters parameters,
  ) {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(
      () => ccontrib.ArucoDetector_NewWithParams(dictionary.ref, parameters.ref, p),
    );
    return ArucoDetector._(p);
  }

  @override
  cvg.ArucoDetector get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDetectorPtr>(ccontrib.addresses.ArucoDetector_Close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.ArucoDetector_Close(ptr);
  }

  /// DetectMarkers does basic marker detection.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d6a/group__aruco.html#ga3bc50d61fe4db7bce8d26d56b5a6428a
  (VecVecPoint2f corners, VecI32 ids, VecVecPoint2f rejectedImgPoints) detectMarkers(InputArray image) {
    return using<(VecVecPoint2f, VecI32, VecVecPoint2f)>((arena) {
      final pCorners = calloc<cvg.VecVecPoint2f>();
      final pRejected = calloc<cvg.VecVecPoint2f>();
      final pIds = calloc<cvg.VecI32>();
      cvRun(
        () => ccontrib.ArucoDetector_DetectMarkers(
          ref,
          image.ref,
          pCorners,
          pIds,
          pRejected,
        ),
      );
      return (
        VecVecPoint2f.fromPointer(pCorners),
        VecI32.fromPointer(pIds),
        VecVecPoint2f.fromPointer(pRejected)
      );
    });
  }
}

void arucoDrawDetectedMarkers(
  Mat img,
  VecVecPoint2f markerCorners,
  VecI32 markerIds,
  Scalar borderColor,
) {
  cvRun(
    () => ccontrib.ArucoDrawDetectedMarkers(
      img.ref,
      markerCorners.ref,
      markerIds.ref,
      borderColor.ref,
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
  final p = outImg?.ptr ?? calloc<cvg.Mat>();
  cvRun(
    () => ccontrib.ArucoGenerateImageMarker(
      dictionaryId.value,
      id,
      sidePixels,
      borderBits,
      p,
    ),
  );
  return outImg ?? Mat.fromPointer(p);
}

class ArucoDetectorParameters extends CvStruct<cvg.ArucoDetectorParameters> {
  ArucoDetectorParameters._(
    cvg.ArucoDetectorParametersPtr ptr, [
    bool attach = true,
  ]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory ArucoDetectorParameters.fromPointer(
    cvg.ArucoDetectorParametersPtr ptr, [
    bool attach = true,
  ]) =>
      ArucoDetectorParameters._(ptr, attach);

  factory ArucoDetectorParameters.empty() {
    final p = calloc<cvg.ArucoDetectorParameters>();
    cvRun(() => ccontrib.ArucoDetectorParameters_Create(p));
    return ArucoDetectorParameters._(p);
  }

  @override
  cvg.ArucoDetectorParameters get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDetectorParametersPtr>(
    ccontrib.addresses.ArucoDetectorParameters_Close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.ArucoDetectorParameters_Close(ptr);
  }

  int get adaptiveThreshWinSizeMin {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(ref, p),
      );
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMin(int value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(ref, value),
      );

  int get adaptiveThreshWinSizeMax {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(ref, p),
      );
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMax(int value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(ref, value),
      );

  int get adaptiveThreshWinSizeStep {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(ref, p),
      );
      return p.value;
    });
  }

  set adaptiveThreshWinSizeStep(int value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(ref, value),
      );

  double get adaptiveThreshConstant {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAdaptiveThreshConstant(ref, p),
      );
      return p.value;
    });
  }

  set adaptiveThreshConstant(double value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAdaptiveThreshConstant(ref, value),
      );

  double get minMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetMinMarkerPerimeterRate(ref, p),
      );
      return p.value;
    });
  }

  set minMarkerPerimeterRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetMinMarkerPerimeterRate(ref, value);

  double get maxMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetMaxMarkerPerimeterRate(ref, p),
      );
      return p.value;
    });
  }

  set maxMarkerPerimeterRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetMaxMarkerPerimeterRate(ref, value);

  double get polygonalApproxAccuracyRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(ref, p),
      );
      return p.value;
    });
  }

  set polygonalApproxAccuracyRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(ref, value);

  double get minCornerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetMinCornerDistanceRate(ref, p),
      );
      return p.value;
    });
  }

  set minCornerDistanceRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetMinCornerDistanceRate(ref, value);

  int get minDistanceToBorder {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetMinDistanceToBorder(ref, p));
      return p.value;
    });
  }

  set minDistanceToBorder(int value) => ccontrib.ArucoDetectorParameters_SetMinDistanceToBorder(ref, value);

  double get minMarkerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetMinMarkerDistanceRate(ref, p),
      );
      return p.value;
    });
  }

  set minMarkerDistanceRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetMinMarkerDistanceRate(ref, value);

  int get cornerRefinementMethod {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetCornerRefinementMethod(ref, p),
      );
      return p.value;
    });
  }

  set cornerRefinementMethod(int value) =>
      ccontrib.ArucoDetectorParameters_SetCornerRefinementMethod(ref, value);

  int get cornerRefinementWinSize {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetCornerRefinementWinSize(ref, p),
      );
      return p.value;
    });
  }

  set cornerRefinementWinSize(int value) =>
      ccontrib.ArucoDetectorParameters_SetCornerRefinementWinSize(ref, value);

  int get cornerRefinementMaxIterations {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetCornerRefinementMaxIterations(
          ref,
          p,
        ),
      );
      return p.value;
    });
  }

  set cornerRefinementMaxIterations(int value) =>
      ccontrib.ArucoDetectorParameters_SetCornerRefinementMaxIterations(ref, value);

  double get cornerRefinementMinAccuracy {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetCornerRefinementMinAccuracy(ref, p),
      );
      return p.value;
    });
  }

  set cornerRefinementMinAccuracy(double value) =>
      ccontrib.ArucoDetectorParameters_SetCornerRefinementMinAccuracy(ref, value);

  int get markerBorderBits {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetMarkerBorderBits(ref, p));
      return p.value;
    });
  }

  set markerBorderBits(int value) => ccontrib.ArucoDetectorParameters_SetMarkerBorderBits(ref, value);

  int get perspectiveRemovePixelPerCell {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(
          ref,
          p,
        ),
      );
      return p.value;
    });
  }

  set perspectiveRemovePixelPerCell(int value) =>
      ccontrib.ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(ref, value);

  double get perspectiveRemoveIgnoredMarginPerCell {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(
          ref,
          p,
        ),
      );
      return p.value;
    });
  }

  set perspectiveRemoveIgnoredMarginPerCell(double value) =>
      ccontrib.ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(
        ref,
        value,
      );

  double get maxErroneousBitsInBorderRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(ref, p),
      );
      return p.value;
    });
  }

  set maxErroneousBitsInBorderRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(ref, value);

  double get minOtsuStdDev {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetMinOtsuStdDev(ref, p));
      return p.value;
    });
  }

  set minOtsuStdDev(double value) => ccontrib.ArucoDetectorParameters_SetMinOtsuStdDev(ref, value);

  double get errorCorrectionRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetErrorCorrectionRate(ref, p));
      return p.value;
    });
  }

  set errorCorrectionRate(double value) =>
      ccontrib.ArucoDetectorParameters_SetErrorCorrectionRate(ref, value);

  double get aprilTagQuadDecimate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetAprilTagQuadDecimate(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadDecimate(double value) =>
      ccontrib.ArucoDetectorParameters_SetAprilTagQuadDecimate(ref, value);

  double get aprilTagQuadSigma {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetAprilTagQuadSigma(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadSigma(double value) => ccontrib.ArucoDetectorParameters_SetAprilTagQuadSigma(ref, value);

  int get aprilTagMinClusterPixels {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAprilTagMinClusterPixels(ref, p),
      );
      return p.value;
    });
  }

  set aprilTagMinClusterPixels(int value) =>
      ccontrib.ArucoDetectorParameters_SetAprilTagMinClusterPixels(ref, value);

  int get aprilTagMaxNmaxima {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetAprilTagMaxNmaxima(ref, p));
      return p.value;
    });
  }

  set aprilTagMaxNmaxima(int value) => ccontrib.ArucoDetectorParameters_SetAprilTagMaxNmaxima(ref, value);

  double get aprilTagCriticalRad {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetAprilTagCriticalRad(ref, p));
      return p.value;
    });
  }

  set aprilTagCriticalRad(double value) =>
      ccontrib.ArucoDetectorParameters_SetAprilTagCriticalRad(ref, value);

  double get aprilTagMaxLineFitMse {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAprilTagMaxLineFitMse(ref, p),
      );
      return p.value;
    });
  }

  set aprilTagMaxLineFitMse(double value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAprilTagMaxLineFitMse(ref, value),
      );

  int get aprilTagMinWhiteBlackDiff {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
        () => ccontrib.ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(ref, p),
      );
      return p.value;
    });
  }

  set aprilTagMinWhiteBlackDiff(int value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(ref, value),
      );

  int get aprilTagDeglitch {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetAprilTagDeglitch(ref, p));
      return p.value;
    });
  }

  set aprilTagDeglitch(int value) =>
      cvRun(() => ccontrib.ArucoDetectorParameters_SetAprilTagDeglitch(ref, value));

  bool get detectInvertedMarker {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => ccontrib.ArucoDetectorParameters_GetDetectInvertedMarker(ref, p));
      return p.value;
    });
  }

  set detectInvertedMarker(bool value) => cvRun(
        () => ccontrib.ArucoDetectorParameters_SetDetectInvertedMarker(ref, value),
      );
}
