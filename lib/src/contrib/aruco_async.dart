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
import 'aruco.dart';

extension ArucoDetectorAsync on ArucoDetector {
  static Future<ArucoDetector> emptyAsync() async {
    final rval = await cvRunAsync<ArucoDetector>(CFFI.ArucoDetector_New_Async, (c, p) {
      return c.complete(ArucoDetector.fromPointer(p.cast<cvg.ArucoDetector>()));
    });
    return rval;
  }

  static Future<ArucoDetector> createAsync(
      ArucoDictionary dictionary, ArucoDetectorParameters parameters) async {
    final rval = await cvRunAsync<ArucoDetector>(
        (callback) => CFFI.ArucoDetector_NewWithParams_Async(dictionary.ref, parameters.ref, callback),
        (c, p) {
      return c.complete(ArucoDetector.fromPointer(p.cast<cvg.ArucoDetector>()));
    });
    return rval;
  }

  Future<(VecVecPoint2f, VecInt, VecVecPoint2f)> detectMarkersAsync(InputArray image) async {
    final rval = await cvRunAsync3<(VecVecPoint2f, VecInt, VecVecPoint2f)>(
        (callback) => CFFI.ArucoDetector_DetectMarkers_Async(ref, image.ref, callback), (c, p, p2, p3) {
      final corners = VecVecPoint2f.fromPointer(p.cast<cvg.VecVecPoint2f>());
      final ids = VecInt.fromPointer(p2.cast<cvg.VecInt>());
      final rejected = VecVecPoint2f.fromPointer(p3.cast<cvg.VecVecPoint2f>());
      return c.complete((corners, ids, rejected));
    });
    return rval;
  }
}

Future<void> arucoDrawDetectedMarkersAsync(
    Mat img, VecVecPoint2f markerCorners, VecInt markerIds, Scalar borderColor) async {
  await cvRunAsync0<void>(
      (callback) => CFFI.ArucoDrawDetectedMarkers_Async(
          img.ref, markerCorners.ref, markerIds.ref, borderColor.ref, callback),
      (c) => c.complete());
}

Future<void> arucoGenerateImageMarkerAsync(
    PredefinedDictionaryType dictionaryId, int id, int sidePixels, Mat img, int borderBits) async {
  await cvRunAsync0<void>(
      (callback) => CFFI.ArucoGenerateImageMarker_Async(
          dictionaryId.value, id, sidePixels, img.ref, borderBits, callback),
      (c) => c.complete());
}

extension ArucoDetectorParametersAsync on ArucoDetectorParameters {
  static Future<ArucoDetectorParameters> emptyAsync() async {
    final rval = await cvRunAsync<ArucoDetectorParameters>(CFFI.ArucoDetectorParameters_Create_Async, (c, p) {
      return c.complete(ArucoDetectorParameters.fromPointer(p.cast<cvg.ArucoDetectorParameters>()));
    });
    return rval;
  }

  Future<int> get adaptiveThreshWinSizeMinAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAdaptiveThreshWinSizeMinAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get adaptiveThreshWinSizeMaxAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAdaptiveThreshWinSizeMaxAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get adaptiveThreshWinSizeStepAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAdaptiveThreshWinSizeStepAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get adaptiveThreshConstantAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetAdaptiveThreshConstant_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAdaptiveThreshConstantAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAdaptiveThreshConstant_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get minMarkerPerimeterRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMinMarkerPerimeterRate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMinMarkerPerimeterRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMinMarkerPerimeterRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get maxMarkerPerimeterRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMaxMarkerPerimeterRate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMaxMarkerPerimeterRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMaxMarkerPerimeterRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get polygonalApproxAccuracyRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetPolygonalApproxAccuracyRate_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setPolygonalApproxAccuracyRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetPolygonalApproxAccuracyRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get minCornerDistanceRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMinCornerDistanceRate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMinCornerDistanceRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMinCornerDistanceRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get minDistanceToBorderAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetMinDistanceToBorder_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMinDistanceToBorderAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMinDistanceToBorder_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get minMarkerDistanceRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMinMarkerDistanceRate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMinMarkerDistanceRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMinMarkerDistanceRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get cornerRefinementMethodAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetCornerRefinementMethod_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setCornerRefinementMethodAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetCornerRefinementMethod_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get cornerRefinementWinSizeAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetCornerRefinementWinSize_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setCornerRefinementWinSizeAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetCornerRefinementWinSize_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get cornerRefinementMaxIterationsAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetCornerRefinementMaxIterations_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setCornerRefinementMaxIterationsAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) =>
            CFFI.ArucoDetectorParameters_SetCornerRefinementMaxIterations_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get cornerRefinementMinAccuracyAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetCornerRefinementMinAccuracy_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setCornerRefinementMinAccuracyAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetCornerRefinementMinAccuracy_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get markerBorderBitsAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetMarkerBorderBits_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMarkerBorderBitsAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMarkerBorderBits_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get perspectiveRemovePixelPerCellAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setPerspectiveRemovePixelPerCellAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) =>
            CFFI.ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get perspectiveRemoveIgnoredMarginPerCellAsync async {
    final rval = await cvRunAsync<double>(
        (callback) =>
            CFFI.ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setPerspectiveRemoveIgnoredMarginPerCellAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) =>
            CFFI.ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get maxErroneousBitsInBorderRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate_Async(ref, callback),
        (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMaxErroneousBitsInBorderRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) =>
            CFFI.ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get minOtsuStdDevAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetMinOtsuStdDev_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setMinOtsuStdDevAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetMinOtsuStdDev_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get errorCorrectionRateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetErrorCorrectionRate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Double>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setErrorCorrectionRateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetErrorCorrectionRate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get aprilTagQuadDecimateAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagQuadDecimate_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagQuadDecimateAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagQuadDecimate_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get aprilTagQuadSigmaAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagQuadSigma_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagQuadSigmaAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagQuadSigma_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get aprilTagMinClusterPixelsAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagMinClusterPixels_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagMinClusterPixelsAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagMinClusterPixels_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get aprilTagMaxNmaximaAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagMaxNmaxima_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagMaxNmaximaAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagMaxNmaxima_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get aprilTagCriticalRadAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagCriticalRad_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagCriticalRadAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagCriticalRad_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<double> get aprilTagMaxLineFitMseAsync async {
    final rval = await cvRunAsync<double>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagMaxLineFitMse_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Float>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagMaxLineFitMseAsync(double value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagMaxLineFitMse_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get aprilTagMinWhiteBlackDiffAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagMinWhiteBlackDiffAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<int> get aprilTagDeglitchAsync async {
    final rval = await cvRunAsync<int>(
        (callback) => CFFI.ArucoDetectorParameters_GetAprilTagDeglitch_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Int>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setAprilTagDeglitchAsync(int value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetAprilTagDeglitch_Async(ref, value, callback),
        (c) => c.complete());
  }

  Future<bool> get detectInvertedMarkerAsync async {
    final rval = await cvRunAsync<bool>(
        (callback) => CFFI.ArucoDetectorParameters_GetDetectInvertedMarker_Async(ref, callback), (c, p) {
      final rval = p.cast<ffi.Bool>().value;
      calloc.free(p);
      return c.complete(rval);
    });
    return rval;
  }

  Future<void> setDetectInvertedMarkerAsync(bool value) async {
    await cvRunAsync0<void>(
        (callback) => CFFI.ArucoDetectorParameters_SetDetectInvertedMarker_Async(ref, value, callback),
        (c) => c.complete());
  }
}
