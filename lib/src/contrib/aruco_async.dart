library cv.contrib;

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as ccontrib;
import 'aruco.dart';
import 'aruco_dict.dart';

extension ArucoDetectorAsync on ArucoDetector {
  static Future<ArucoDetector> emptyAsync() async => cvRunAsync<ArucoDetector>(
        ccontrib.ArucoDetector_New_Async,
        (c, p) => c.complete(ArucoDetector.fromPointer(p.cast<ccontrib.ArucoDetector>())),
      );

  static Future<ArucoDetector> createAsync(
    ArucoDictionary dictionary,
    ArucoDetectorParameters parameters,
  ) async =>
      cvRunAsync<ArucoDetector>(
        (callback) => ccontrib.ArucoDetector_NewWithParams_Async(
          dictionary.ref,
          parameters.ref,
          callback,
        ),
        (c, p) => c.complete(ArucoDetector.fromPointer(p.cast<ccontrib.ArucoDetector>())),
      );

  Future<(VecVecPoint2f, VecI32, VecVecPoint2f)> detectMarkersAsync(
    InputArray image,
  ) async =>
      cvRunAsync3<(VecVecPoint2f, VecI32, VecVecPoint2f)>(
          (callback) => ccontrib.ArucoDetector_DetectMarkers_Async(ref, image.ref, callback), (c, p, p2, p3) {
        final corners = VecVecPoint2f.fromPointer(p.cast<ccontrib.VecVecPoint2f>());
        final ids = VecI32.fromPointer(p2.cast<ccontrib.VecI32>());
        final rejected = VecVecPoint2f.fromPointer(p3.cast<ccontrib.VecVecPoint2f>());
        return c.complete((corners, ids, rejected));
      });
}

Future<void> arucoDrawDetectedMarkersAsync(
  Mat img,
  VecVecPoint2f markerCorners,
  VecI32 markerIds,
  Scalar borderColor,
) async =>
    cvRunAsync0<void>(
      (callback) => ccontrib.ArucoDrawDetectedMarkers_Async(
        img.ref,
        markerCorners.ref,
        markerIds.ref,
        borderColor.ref,
        callback,
      ),
      (c) => c.complete(),
    );

Future<Mat> arucoGenerateImageMarkerAsync(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  int borderBits,
) async =>
    cvRunAsync<Mat>(
      (callback) => ccontrib.ArucoGenerateImageMarker_Async(
        dictionaryId.value,
        id,
        sidePixels,
        borderBits,
        callback,
      ),
      matCompleter,
    );
