// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

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
  Future<(VecVecPoint2f, VecI32, VecVecPoint2f)> detectMarkersAsync(InputArray image) async {
    final corners = VecVecPoint2f();
    final rejected = VecVecPoint2f();
    final ids = VecI32();
    return cvRunAsync0(
        (callback) => ccontrib.cv_aruco_arucoDetector_detectMarkers(
              ref,
              image.ref,
              corners.ptr,
              ids.ptr,
              rejected.ptr,
              callback,
            ), (c) {
      return c.complete((corners, ids, rejected));
    });
  }
}

Future<void> arucoDrawDetectedMarkersAsync(
  Mat img,
  VecVecPoint2f markerCorners,
  VecI32 markerIds,
  Scalar borderColor,
) async {
  return cvRunAsync0(
    (callback) => ccontrib.cv_aruco_drawDetectedMarkers(
      img.ref,
      markerCorners.ref,
      markerIds.ref,
      borderColor.ref,
      callback,
    ),
    (c) => c.complete(),
  );
}

Future<Mat> arucoGenerateImageMarkerAsync(
  PredefinedDictionaryType dictionaryId,
  int id,
  int sidePixels,
  int borderBits, [
  Mat? outImg,
]) async {
  outImg ??= Mat.empty();
  return cvRunAsync0(
      (callback) => ccontrib.cv_aruco_generateImageMarker(
            dictionaryId.value,
            id,
            sidePixels,
            borderBits,
            outImg!.ref,
            callback,
          ), (c) {
    c.complete(outImg);
  });
}
