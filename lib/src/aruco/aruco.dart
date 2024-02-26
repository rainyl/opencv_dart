library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'aruco_dict.dart';
import '../core/extensions.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class ArucoDetector implements ffi.Finalizable {
  ArucoDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory ArucoDetector.empty() {
    final _ptr = _bindings.ArucoDetector_New();
    return ArucoDetector._(_ptr);
  }

  factory ArucoDetector.create(ArucoDictionary dictionary, ArucoDetectorParameters parameters) {
    final _ptr = _bindings.ArucoDetector_NewWithParams(dictionary.ptr, parameters.ptr);
    return ArucoDetector._(_ptr);
  }

  cvg.ArucoDetector _ptr;
  cvg.ArucoDetector get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.ArucoDetector_Close);

  /// DetectMarkers does basic marker detection.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d6a/group__aruco.html#ga3bc50d61fe4db7bce8d26d56b5a6428a
  (List<List<Point2f>> corners, List<int> ids, List<List<Point2f>> rejectedImgPoints) detectMarkers(
    InputArray image,
  ) {
    return using<(List<List<Point2f>>, List<int>, List<List<Point2f>>)>((arena) {
      final pvsCorners = _bindings.Points2fVector_New();
      final pvsRejected = _bindings.Points2fVector_New();
      final cmarkerIds = arena<cvg.IntVector>();
      _bindings.ArucoDetector_DetectMarkers(_ptr, image.ptr, pvsCorners, cmarkerIds, pvsRejected);

      final _corners = List.generate(_bindings.Points2fVector_Size(pvsCorners), (i) {
        final _tmpvec = _bindings.Points2fVector_At(pvsCorners, i);
        return List.generate(
          _bindings.Point2fVector_Size(_tmpvec),
          (j) => Point2f.fromNative(
            _bindings.Point2fVector_At(_tmpvec, j),
          ),
        );
      });

      final _rejected = List.generate(_bindings.Points2fVector_Size(pvsRejected), (i) {
        final _tmpvec = _bindings.Points2fVector_At(pvsRejected, i);
        return List.generate(
          _bindings.Point2fVector_Size(_tmpvec),
          (j) => Point2f.fromNative(
            _bindings.Point2fVector_At(_tmpvec, j),
          ),
        );
      });

      final _ids = List.generate(
        cmarkerIds.ref.length,
        (i) => cmarkerIds.ref.val[i],
      );

      _bindings.Points2fVector_Close(pvsCorners);
      _bindings.Points2fVector_Close(pvsRejected);

      return (_corners, _ids, _rejected);
    });
  }
}

void arucoDrawDetectedMarkers(
  Mat img,
  List<List<Point2f>> markerCorners,
  List<int> markerIds,
  Scalar borderColor,
) {
  using((arena) {
    final cCorners = _bindings.Points2fVector_New();
    for (var vec in markerCorners) {
      final tmpvec = _bindings.Point2fVector_New();
      for (var p in vec) {
        _bindings.Point2fVector_Append(tmpvec, p.ref);
      }
      _bindings.Points2fVector_Append(cCorners, tmpvec);
    }
    _bindings.ArucoDrawDetectedMarkers(
      img.ptr,
      cCorners,
      markerIds.toNativeVector(arena).ref,
      borderColor.ref,
    );
    _bindings.Points2fVector_Close(cCorners);
  });
}

void arucoGenerateImageMarker(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  Mat img,
  int borderBits,
) {
  _bindings.ArucoGenerateImageMarker(
    dictionaryId.value,
    id,
    sidePixels,
    img.ptr,
    borderBits,
  );
}

class ArucoDetectorParameters implements ffi.Finalizable {
  ArucoDetectorParameters._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory ArucoDetectorParameters.empty() {
    final _ptr = _bindings.ArucoDetectorParameters_Create();
    return ArucoDetectorParameters._(_ptr);
  }

  cvg.ArucoDetectorParameters _ptr;
  cvg.ArucoDetectorParameters get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.ArucoDetectorParameters_Close);

  int get adaptiveThreshWinSizeMin => _bindings.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(_ptr);
  void set adaptiveThreshWinSizeMin(int value) =>
      _bindings.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(_ptr, value);

  int get adaptiveThreshWinSizeMax => _bindings.ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(_ptr);
  void set adaptiveThreshWinSizeMax(int value) =>
      _bindings.ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(_ptr, value);

  int get adaptiveThreshWinSizeStep => _bindings.ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(_ptr);
  void set adaptiveThreshWinSizeStep(int value) =>
      _bindings.ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(_ptr, value);

  double get adaptiveThreshConstant => _bindings.ArucoDetectorParameters_GetAdaptiveThreshConstant(_ptr);
  void set adaptiveThreshConstant(double value) =>
      _bindings.ArucoDetectorParameters_SetAdaptiveThreshConstant(_ptr, value);

  double get minMarkerPerimeterRate => _bindings.ArucoDetectorParameters_GetMinMarkerPerimeterRate(_ptr);
  void set minMarkerPerimeterRate(double value) =>
      _bindings.ArucoDetectorParameters_SetMinMarkerPerimeterRate(_ptr, value);

  double get maxMarkerPerimeterRate => _bindings.ArucoDetectorParameters_GetMaxMarkerPerimeterRate(_ptr);
  void set maxMarkerPerimeterRate(double value) =>
      _bindings.ArucoDetectorParameters_SetMaxMarkerPerimeterRate(_ptr, value);

  double get polygonalApproxAccuracyRate =>
      _bindings.ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(_ptr);
  void set polygonalApproxAccuracyRate(double value) =>
      _bindings.ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(_ptr, value);

  double get minCornerDistanceRate => _bindings.ArucoDetectorParameters_GetMinCornerDistanceRate(_ptr);
  void set minCornerDistanceRate(double value) =>
      _bindings.ArucoDetectorParameters_SetMinCornerDistanceRate(_ptr, value);

  int get minDistanceToBorder => _bindings.ArucoDetectorParameters_GetMinDistanceToBorder(_ptr);
  void set minDistanceToBorder(int value) =>
      _bindings.ArucoDetectorParameters_SetMinDistanceToBorder(_ptr, value);

  double get minMarkerDistanceRate => _bindings.ArucoDetectorParameters_GetMinMarkerDistanceRate(_ptr);
  void set minMarkerDistanceRate(double value) =>
      _bindings.ArucoDetectorParameters_SetMinMarkerDistanceRate(_ptr, value);

  int get cornerRefinementMethod => _bindings.ArucoDetectorParameters_GetCornerRefinementMethod(_ptr);
  void set cornerRefinementMethod(int value) =>
      _bindings.ArucoDetectorParameters_SetCornerRefinementMethod(_ptr, value);

  int get cornerRefinementWinSize => _bindings.ArucoDetectorParameters_GetCornerRefinementWinSize(_ptr);
  void set cornerRefinementWinSize(int value) =>
      _bindings.ArucoDetectorParameters_SetCornerRefinementWinSize(_ptr, value);

  int get cornerRefinementMaxIterations =>
      _bindings.ArucoDetectorParameters_GetCornerRefinementMaxIterations(_ptr);
  void set cornerRefinementMaxIterations(int value) =>
      _bindings.ArucoDetectorParameters_SetCornerRefinementMaxIterations(_ptr, value);

  double get cornerRefinementMinAccuracy =>
      _bindings.ArucoDetectorParameters_GetCornerRefinementMinAccuracy(_ptr);
  void set cornerRefinementMinAccuracy(double value) =>
      _bindings.ArucoDetectorParameters_SetCornerRefinementMinAccuracy(_ptr, value);

  int get markerBorderBits => _bindings.ArucoDetectorParameters_GetMarkerBorderBits(_ptr);
  void set markerBorderBits(int value) => _bindings.ArucoDetectorParameters_SetMarkerBorderBits(_ptr, value);

  int get perspectiveRemovePixelPerCell =>
      _bindings.ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(_ptr);
  void set perspectiveRemovePixelPerCell(int value) =>
      _bindings.ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(_ptr, value);

  double get perspectiveRemoveIgnoredMarginPerCell =>
      _bindings.ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(_ptr);
  void set perspectiveRemoveIgnoredMarginPerCell(double value) =>
      _bindings.ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(_ptr, value);

  double get maxErroneousBitsInBorderRate =>
      _bindings.ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(_ptr);
  void set maxErroneousBitsInBorderRate(double value) =>
      _bindings.ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(_ptr, value);

  double get minOtsuStdDev => _bindings.ArucoDetectorParameters_GetMinOtsuStdDev(_ptr);
  void set minOtsuStdDev(double value) => _bindings.ArucoDetectorParameters_SetMinOtsuStdDev(_ptr, value);

  double get errorCorrectionRate => _bindings.ArucoDetectorParameters_GetErrorCorrectionRate(_ptr);
  void set errorCorrectionRate(double value) =>
      _bindings.ArucoDetectorParameters_SetErrorCorrectionRate(_ptr, value);

  double get aprilTagQuadDecimate => _bindings.ArucoDetectorParameters_GetAprilTagQuadDecimate(_ptr);
  void set aprilTagQuadDecimate(double value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagQuadDecimate(_ptr, value);

  double get aprilTagQuadSigma => _bindings.ArucoDetectorParameters_GetAprilTagQuadSigma(_ptr);
  void set aprilTagQuadSigma(double value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagQuadSigma(_ptr, value);

  int get aprilTagMinClusterPixels => _bindings.ArucoDetectorParameters_GetAprilTagMinClusterPixels(_ptr);
  void set aprilTagMinClusterPixels(int value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagMinClusterPixels(_ptr, value);

  int get aprilTagMaxNmaxima => _bindings.ArucoDetectorParameters_GetAprilTagMaxNmaxima(_ptr);
  void set aprilTagMaxNmaxima(int value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagMaxNmaxima(_ptr, value);

  double get aprilTagCriticalRad => _bindings.ArucoDetectorParameters_GetAprilTagCriticalRad(_ptr);
  void set aprilTagCriticalRad(double value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagCriticalRad(_ptr, value);

  double get aprilTagMaxLineFitMse => _bindings.ArucoDetectorParameters_GetAprilTagMaxLineFitMse(_ptr);
  void set aprilTagMaxLineFitMse(double value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagMaxLineFitMse(_ptr, value);

  int get aprilTagMinWhiteBlackDiff => _bindings.ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(_ptr);
  void set aprilTagMinWhiteBlackDiff(int value) =>
      _bindings.ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(_ptr, value);

  int get aprilTagDeglitch => _bindings.ArucoDetectorParameters_GetAprilTagDeglitch(_ptr);
  void set aprilTagDeglitch(int value) => _bindings.ArucoDetectorParameters_SetAprilTagDeglitch(_ptr, value);

  bool get detectInvertedMarker => _bindings.ArucoDetectorParameters_GetDetectInvertedMarker(_ptr);
  void set detectInvertedMarker(bool value) =>
      _bindings.ArucoDetectorParameters_SetDetectInvertedMarker(_ptr, value);
}
