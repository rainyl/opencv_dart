library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'aruco_dict.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class ArucoDetector extends CvStruct<cvg.ArucoDetector> {
  ArucoDetector._(cvg.ArucoDetectorPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory ArucoDetector.empty() {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(() => cvg.ArucoDetector_New(p));
    return ArucoDetector._(p);
  }

  factory ArucoDetector.create(ArucoDictionary dictionary, ArucoDetectorParameters parameters) {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(() => cvg.ArucoDetector_NewWithParams(dictionary.ref, parameters.ref, p));
    return ArucoDetector._(p);
  }

  @override
  cvg.ArucoDetector get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDetectorPtr>(ffi.Native.addressOf(cvg.ArucoDetector_Close));

  /// DetectMarkers does basic marker detection.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d6a/group__aruco.html#ga3bc50d61fe4db7bce8d26d56b5a6428a
  (VecVecPoint2f corners, VecInt ids, VecVecPoint2f rejectedImgPoints) detectMarkers(
      InputArray image) {
    return using<(VecVecPoint2f, VecInt, VecVecPoint2f)>((arena) {
      final pCorners = calloc<cvg.VecVecPoint2f>();
      final pRejected = calloc<cvg.VecVecPoint2f>();
      final pIds = calloc<cvg.VecInt>();
      cvRun(() => cvg.ArucoDetector_DetectMarkers(ref, image.ref, pCorners, pIds, pRejected));
      return (
        VecVecPoint2f.fromVec(pCorners.ref),
        VecInt.fromVec(pIds.ref),
        VecVecPoint2f.fromVec(pRejected.ref)
      );
    });
  }

  @override
  List<int> get props => [ptr.address];
}

void arucoDrawDetectedMarkers(
    Mat img, VecVecPoint2f markerCorners, VecInt markerIds, Scalar borderColor) {
  cvRun(() =>
      cvg.ArucoDrawDetectedMarkers(img.ref, markerCorners.ref, markerIds.ref, borderColor.ref));
}

void arucoGenerateImageMarker(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  Mat img,
  int borderBits,
) {
  cvRun(
      () => cvg.ArucoGenerateImageMarker(dictionaryId.value, id, sidePixels, img.ref, borderBits));
}

class ArucoDetectorParameters extends CvStruct<cvg.ArucoDetectorParameters> {
  ArucoDetectorParameters._(cvg.ArucoDetectorParametersPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory ArucoDetectorParameters.empty() {
    final p = calloc<cvg.ArucoDetectorParameters>();
    cvRun(() => cvg.ArucoDetectorParameters_Create(p));
    return ArucoDetectorParameters._(p);
  }

  @override
  cvg.ArucoDetectorParameters get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.ArucoDetectorParametersPtr>(ffi.Native.addressOf(cvg.ArucoDetectorParameters_Close));

  int get adaptiveThreshWinSizeMin {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(ref, p));
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMin(int value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(ref, value));

  int get adaptiveThreshWinSizeMax {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(ref, p));
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMax(int value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(ref, value));

  int get adaptiveThreshWinSizeStep {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(ref, p));
      return p.value;
    });
  }

  set adaptiveThreshWinSizeStep(int value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(ref, value));

  double get adaptiveThreshConstant {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAdaptiveThreshConstant(ref, p));
      return p.value;
    });
  }

  set adaptiveThreshConstant(double value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAdaptiveThreshConstant(ref, value));

  double get minMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMinMarkerPerimeterRate(ref, p));
      return p.value;
    });
  }

  set minMarkerPerimeterRate(double value) =>
      cvg.ArucoDetectorParameters_SetMinMarkerPerimeterRate(ref, value);

  double get maxMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMaxMarkerPerimeterRate(ref, p));
      return p.value;
    });
  }

  set maxMarkerPerimeterRate(double value) =>
      cvg.ArucoDetectorParameters_SetMaxMarkerPerimeterRate(ref, value);

  double get polygonalApproxAccuracyRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(ref, p));
      return p.value;
    });
  }

  set polygonalApproxAccuracyRate(double value) =>
      cvg.ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(ref, value);

  double get minCornerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMinCornerDistanceRate(ref, p));
      return p.value;
    });
  }

  set minCornerDistanceRate(double value) =>
      cvg.ArucoDetectorParameters_SetMinCornerDistanceRate(ref, value);

  int get minDistanceToBorder {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMinDistanceToBorder(ref, p));
      return p.value;
    });
  }

  set minDistanceToBorder(int value) =>
      cvg.ArucoDetectorParameters_SetMinDistanceToBorder(ref, value);

  double get minMarkerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMinMarkerDistanceRate(ref, p));
      return p.value;
    });
  }

  set minMarkerDistanceRate(double value) =>
      cvg.ArucoDetectorParameters_SetMinMarkerDistanceRate(ref, value);

  int get cornerRefinementMethod {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetCornerRefinementMethod(ref, p));
      return p.value;
    });
  }

  set cornerRefinementMethod(int value) =>
      cvg.ArucoDetectorParameters_SetCornerRefinementMethod(ref, value);

  int get cornerRefinementWinSize {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetCornerRefinementWinSize(ref, p));
      return p.value;
    });
  }

  set cornerRefinementWinSize(int value) =>
      cvg.ArucoDetectorParameters_SetCornerRefinementWinSize(ref, value);

  int get cornerRefinementMaxIterations {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetCornerRefinementMaxIterations(ref, p));
      return p.value;
    });
  }

  set cornerRefinementMaxIterations(int value) =>
      cvg.ArucoDetectorParameters_SetCornerRefinementMaxIterations(ref, value);

  double get cornerRefinementMinAccuracy {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetCornerRefinementMinAccuracy(ref, p));
      return p.value;
    });
  }

  set cornerRefinementMinAccuracy(double value) =>
      cvg.ArucoDetectorParameters_SetCornerRefinementMinAccuracy(ref, value);

  int get markerBorderBits {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMarkerBorderBits(ref, p));
      return p.value;
    });
  }

  set markerBorderBits(int value) => cvg.ArucoDetectorParameters_SetMarkerBorderBits(ref, value);

  int get perspectiveRemovePixelPerCell {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(ref, p));
      return p.value;
    });
  }

  set perspectiveRemovePixelPerCell(int value) =>
      cvg.ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(ref, value);

  double get perspectiveRemoveIgnoredMarginPerCell {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(ref, p));
      return p.value;
    });
  }

  set perspectiveRemoveIgnoredMarginPerCell(double value) =>
      cvg.ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(ref, value);

  double get maxErroneousBitsInBorderRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(ref, p));
      return p.value;
    });
  }

  set maxErroneousBitsInBorderRate(double value) =>
      cvg.ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(ref, value);

  double get minOtsuStdDev {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetMinOtsuStdDev(ref, p));
      return p.value;
    });
  }

  set minOtsuStdDev(double value) => cvg.ArucoDetectorParameters_SetMinOtsuStdDev(ref, value);

  double get errorCorrectionRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.ArucoDetectorParameters_GetErrorCorrectionRate(ref, p));
      return p.value;
    });
  }

  set errorCorrectionRate(double value) =>
      cvg.ArucoDetectorParameters_SetErrorCorrectionRate(ref, value);

  double get aprilTagQuadDecimate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagQuadDecimate(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadDecimate(double value) =>
      cvg.ArucoDetectorParameters_SetAprilTagQuadDecimate(ref, value);

  double get aprilTagQuadSigma {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagQuadSigma(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadSigma(double value) =>
      cvg.ArucoDetectorParameters_SetAprilTagQuadSigma(ref, value);

  int get aprilTagMinClusterPixels {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagMinClusterPixels(ref, p));
      return p.value;
    });
  }

  set aprilTagMinClusterPixels(int value) =>
      cvg.ArucoDetectorParameters_SetAprilTagMinClusterPixels(ref, value);

  int get aprilTagMaxNmaxima {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagMaxNmaxima(ref, p));
      return p.value;
    });
  }

  set aprilTagMaxNmaxima(int value) =>
      cvg.ArucoDetectorParameters_SetAprilTagMaxNmaxima(ref, value);

  double get aprilTagCriticalRad {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagCriticalRad(ref, p));
      return p.value;
    });
  }

  set aprilTagCriticalRad(double value) =>
      cvg.ArucoDetectorParameters_SetAprilTagCriticalRad(ref, value);

  double get aprilTagMaxLineFitMse {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagMaxLineFitMse(ref, p));
      return p.value;
    });
  }

  set aprilTagMaxLineFitMse(double value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAprilTagMaxLineFitMse(ref, value));

  int get aprilTagMinWhiteBlackDiff {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(ref, p));
      return p.value;
    });
  }

  set aprilTagMinWhiteBlackDiff(int value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(ref, value));

  int get aprilTagDeglitch {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => cvg.ArucoDetectorParameters_GetAprilTagDeglitch(ref, p));
      return p.value;
    });
  }

  set aprilTagDeglitch(int value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetAprilTagDeglitch(ref, value));

  bool get detectInvertedMarker {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => cvg.ArucoDetectorParameters_GetDetectInvertedMarker(ref, p));
      return p.value;
    });
  }

  set detectInvertedMarker(bool value) =>
      cvRun(() => cvg.ArucoDetectorParameters_SetDetectInvertedMarker(ref, value));

  @override
  List<int> get props => [ptr.address];
}
