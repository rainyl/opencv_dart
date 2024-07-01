library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import 'aruco_dict.dart';

class ArucoDetector extends CvStruct<cvg.ArucoDetector> {
  ArucoDetector._(cvg.ArucoDetectorPtr ptr, [bool attach = true])
      : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory ArucoDetector.fromPointer(cvg.ArucoDetectorPtr ptr,
          [bool attach = true,]) =>
      ArucoDetector._(ptr, attach);

  factory ArucoDetector.empty() {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(() => CFFI.ArucoDetector_New(p));
    return ArucoDetector._(p);
  }

  factory ArucoDetector.create(
      ArucoDictionary dictionary, ArucoDetectorParameters parameters,) {
    final p = calloc<cvg.ArucoDetector>();
    cvRun(() =>
        CFFI.ArucoDetector_NewWithParams(dictionary.ref, parameters.ref, p),);
    return ArucoDetector._(p);
  }

  @override
  cvg.ArucoDetector get ref => ptr.ref;
  static final finalizer =
      OcvFinalizer<cvg.ArucoDetectorPtr>(CFFI.addresses.ArucoDetector_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.ArucoDetector_Close(ptr);
  }

  /// DetectMarkers does basic marker detection.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d6a/group__aruco.html#ga3bc50d61fe4db7bce8d26d56b5a6428a
  (VecVecPoint2f corners, VecInt ids, VecVecPoint2f rejectedImgPoints)
      detectMarkers(InputArray image) {
    return using<(VecVecPoint2f, VecInt, VecVecPoint2f)>((arena) {
      final pCorners = calloc<cvg.VecVecPoint2f>();
      final pRejected = calloc<cvg.VecVecPoint2f>();
      final pIds = calloc<cvg.VecInt>();
      cvRun(() => CFFI.ArucoDetector_DetectMarkers(
          ref, image.ref, pCorners, pIds, pRejected,),);
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

void arucoDrawDetectedMarkers(Mat img, VecVecPoint2f markerCorners,
    VecInt markerIds, Scalar borderColor,) {
  cvRun(() => CFFI.ArucoDrawDetectedMarkers(
      img.ref, markerCorners.ref, markerIds.ref, borderColor.ref,),);
}

void arucoGenerateImageMarker(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  Mat img,
  int borderBits,
) {
  cvRun(() => CFFI.ArucoGenerateImageMarker(
      dictionaryId.value, id, sidePixels, img.ref, borderBits,),);
}

class ArucoDetectorParameters extends CvStruct<cvg.ArucoDetectorParameters> {
  ArucoDetectorParameters._(cvg.ArucoDetectorParametersPtr ptr,
      [bool attach = true,])
      : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory ArucoDetectorParameters.fromPointer(
          cvg.ArucoDetectorParametersPtr ptr,
          [bool attach = true,]) =>
      ArucoDetectorParameters._(ptr, attach);

  factory ArucoDetectorParameters.empty() {
    final p = calloc<cvg.ArucoDetectorParameters>();
    cvRun(() => CFFI.ArucoDetectorParameters_Create(p));
    return ArucoDetectorParameters._(p);
  }

  @override
  cvg.ArucoDetectorParameters get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDetectorParametersPtr>(
      CFFI.addresses.ArucoDetectorParameters_Close,);

  void dispose() {
    finalizer.detach(this);
    CFFI.ArucoDetectorParameters_Close(ptr);
  }

  int get adaptiveThreshWinSizeMin {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(ref, p),);
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMin(int value) => cvRun(() =>
      CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(ref, value),);

  int get adaptiveThreshWinSizeMax {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(ref, p),);
      return p.value;
    });
  }

  set adaptiveThreshWinSizeMax(int value) => cvRun(() =>
      CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(ref, value),);

  int get adaptiveThreshWinSizeStep {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(ref, p),);
      return p.value;
    });
  }

  set adaptiveThreshWinSizeStep(int value) => cvRun(() =>
      CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(ref, value),);

  double get adaptiveThreshConstant {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetAdaptiveThreshConstant(ref, p),);
      return p.value;
    });
  }

  set adaptiveThreshConstant(double value) => cvRun(
      () => CFFI.ArucoDetectorParameters_SetAdaptiveThreshConstant(ref, value),);

  double get minMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetMinMarkerPerimeterRate(ref, p),);
      return p.value;
    });
  }

  set minMarkerPerimeterRate(double value) =>
      CFFI.ArucoDetectorParameters_SetMinMarkerPerimeterRate(ref, value);

  double get maxMarkerPerimeterRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetMaxMarkerPerimeterRate(ref, p),);
      return p.value;
    });
  }

  set maxMarkerPerimeterRate(double value) =>
      CFFI.ArucoDetectorParameters_SetMaxMarkerPerimeterRate(ref, value);

  double get polygonalApproxAccuracyRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(ref, p),);
      return p.value;
    });
  }

  set polygonalApproxAccuracyRate(double value) =>
      CFFI.ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(ref, value);

  double get minCornerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetMinCornerDistanceRate(ref, p),);
      return p.value;
    });
  }

  set minCornerDistanceRate(double value) =>
      CFFI.ArucoDetectorParameters_SetMinCornerDistanceRate(ref, value);

  int get minDistanceToBorder {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetMinDistanceToBorder(ref, p));
      return p.value;
    });
  }

  set minDistanceToBorder(int value) =>
      CFFI.ArucoDetectorParameters_SetMinDistanceToBorder(ref, value);

  double get minMarkerDistanceRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetMinMarkerDistanceRate(ref, p),);
      return p.value;
    });
  }

  set minMarkerDistanceRate(double value) =>
      CFFI.ArucoDetectorParameters_SetMinMarkerDistanceRate(ref, value);

  int get cornerRefinementMethod {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetCornerRefinementMethod(ref, p),);
      return p.value;
    });
  }

  set cornerRefinementMethod(int value) =>
      CFFI.ArucoDetectorParameters_SetCornerRefinementMethod(ref, value);

  int get cornerRefinementWinSize {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetCornerRefinementWinSize(ref, p),);
      return p.value;
    });
  }

  set cornerRefinementWinSize(int value) =>
      CFFI.ArucoDetectorParameters_SetCornerRefinementWinSize(ref, value);

  int get cornerRefinementMaxIterations {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetCornerRefinementMaxIterations(
          ref, p,),);
      return p.value;
    });
  }

  set cornerRefinementMaxIterations(int value) =>
      CFFI.ArucoDetectorParameters_SetCornerRefinementMaxIterations(ref, value);

  double get cornerRefinementMinAccuracy {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetCornerRefinementMinAccuracy(ref, p),);
      return p.value;
    });
  }

  set cornerRefinementMinAccuracy(double value) =>
      CFFI.ArucoDetectorParameters_SetCornerRefinementMinAccuracy(ref, value);

  int get markerBorderBits {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetMarkerBorderBits(ref, p));
      return p.value;
    });
  }

  set markerBorderBits(int value) =>
      CFFI.ArucoDetectorParameters_SetMarkerBorderBits(ref, value);

  int get perspectiveRemovePixelPerCell {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(
          ref, p,),);
      return p.value;
    });
  }

  set perspectiveRemovePixelPerCell(int value) =>
      CFFI.ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(ref, value);

  double get perspectiveRemoveIgnoredMarginPerCell {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(
              ref, p,),);
      return p.value;
    });
  }

  set perspectiveRemoveIgnoredMarginPerCell(double value) =>
      CFFI.ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(
          ref, value,);

  double get maxErroneousBitsInBorderRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(ref, p),);
      return p.value;
    });
  }

  set maxErroneousBitsInBorderRate(double value) =>
      CFFI.ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(ref, value);

  double get minOtsuStdDev {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetMinOtsuStdDev(ref, p));
      return p.value;
    });
  }

  set minOtsuStdDev(double value) =>
      CFFI.ArucoDetectorParameters_SetMinOtsuStdDev(ref, value);

  double get errorCorrectionRate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetErrorCorrectionRate(ref, p));
      return p.value;
    });
  }

  set errorCorrectionRate(double value) =>
      CFFI.ArucoDetectorParameters_SetErrorCorrectionRate(ref, value);

  double get aprilTagQuadDecimate {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetAprilTagQuadDecimate(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadDecimate(double value) =>
      CFFI.ArucoDetectorParameters_SetAprilTagQuadDecimate(ref, value);

  double get aprilTagQuadSigma {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetAprilTagQuadSigma(ref, p));
      return p.value;
    });
  }

  set aprilTagQuadSigma(double value) =>
      CFFI.ArucoDetectorParameters_SetAprilTagQuadSigma(ref, value);

  int get aprilTagMinClusterPixels {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetAprilTagMinClusterPixels(ref, p),);
      return p.value;
    });
  }

  set aprilTagMinClusterPixels(int value) =>
      CFFI.ArucoDetectorParameters_SetAprilTagMinClusterPixels(ref, value);

  int get aprilTagMaxNmaxima {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetAprilTagMaxNmaxima(ref, p));
      return p.value;
    });
  }

  set aprilTagMaxNmaxima(int value) =>
      CFFI.ArucoDetectorParameters_SetAprilTagMaxNmaxima(ref, value);

  double get aprilTagCriticalRad {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetAprilTagCriticalRad(ref, p));
      return p.value;
    });
  }

  set aprilTagCriticalRad(double value) =>
      CFFI.ArucoDetectorParameters_SetAprilTagCriticalRad(ref, value);

  double get aprilTagMaxLineFitMse {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(
          () => CFFI.ArucoDetectorParameters_GetAprilTagMaxLineFitMse(ref, p),);
      return p.value;
    });
  }

  set aprilTagMaxLineFitMse(double value) => cvRun(
      () => CFFI.ArucoDetectorParameters_SetAprilTagMaxLineFitMse(ref, value),);

  int get aprilTagMinWhiteBlackDiff {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() =>
          CFFI.ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(ref, p),);
      return p.value;
    });
  }

  set aprilTagMinWhiteBlackDiff(int value) => cvRun(() =>
      CFFI.ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(ref, value),);

  int get aprilTagDeglitch {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetAprilTagDeglitch(ref, p));
      return p.value;
    });
  }

  set aprilTagDeglitch(int value) =>
      cvRun(() => CFFI.ArucoDetectorParameters_SetAprilTagDeglitch(ref, value));

  bool get detectInvertedMarker {
    return cvRunArena<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.ArucoDetectorParameters_GetDetectInvertedMarker(ref, p));
      return p.value;
    });
  }

  set detectInvertedMarker(bool value) => cvRun(
      () => CFFI.ArucoDetectorParameters_SetDetectInvertedMarker(ref, value),);

  @override
  List<int> get props => [ptr.address];
}
