// Copyright (c) 2024, pariterre, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/cv_vec.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as ccontrib;
import 'charuco_board.dart';
import 'charuco_detector.dart';

extension CharucoDetectorAsync on CharucoDetector {
  Future<(VecPoint2f charucoCorners, VecI32 charucoIds, VecVecPoint2f markerCorners, VecI32 markerIds)>
  detectBoardAsync(InputArray image, {VecVecPoint2f? markerCorners, VecI32? markerIds}) async {
    final charucoCorners = VecPoint2f();
    final charucoIds = VecI32();
    markerCorners ??= VecVecPoint2f();
    markerIds ??= VecI32();
    return cvRunAsync0(
      (callback) => ccontrib.cv_aruco_charucoDetector_detectBoard(
        ref,
        image.ref,
        charucoCorners.ptr,
        charucoIds.ptr,
        markerCorners!.ptr,
        markerIds!.ptr,
        callback,
      ),
      (c) => c.complete((charucoCorners, charucoIds, markerCorners!, markerIds!)),
    );
  }

  Future<(VecVecPoint2f diamondCorners, VecVec4i diamondIds, VecVecPoint2f markerCorners, VecI32 markerIds)>
  detectDiamondsAsync(InputArray image, {VecVecPoint2f? markerCorners, VecI32? markerIds}) async {
    final diamondCorners = VecVecPoint2f();
    final diamondIds = VecVec4i();
    markerCorners ??= VecVecPoint2f();
    markerIds ??= VecI32();
    return cvRunAsync0(
      (callback) => ccontrib.cv_aruco_charucoDetector_detectDiamonds(
        ref,
        image.ref,
        diamondCorners.ptr,
        diamondIds.ptr,
        markerCorners!.ptr,
        markerIds!.ptr,
        callback,
      ),
      (c) => c.complete((diamondCorners, diamondIds, markerCorners!, markerIds!)),
    );
  }
}

Future<void> drawDetectedCornersCharucoAsync(
  Mat image,
  VecPoint2f charucoCorners, [
  VecI32? charucoIds,
  Scalar? cornerColor,
]) async {
  final ids = charucoIds ?? VecI32();
  final disposeIds = charucoIds == null;
  final color = cornerColor ?? Scalar(255, 0, 0, 0);
  await cvRunAsync0(
    (callback) => ccontrib.cv_aruco_drawDetectedCornersCharuco(
      image.ref,
      charucoCorners.ref,
      ids.ref,
      color.ref,
      callback,
    ),
    (c) => c.complete(),
  );
  if (disposeIds) ids.dispose();
}

Future<(bool rval, Mat rvec, Mat tvec)> estimatePoseCharucoBoardAsync(
  VecPoint2f charucoCorners,
  VecI32 charucoIds,
  CharucoBoard board,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  Mat? rvec,
  Mat? tvec,
  bool useExtrinsicGuess = false,
}) async {
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  final pb = calloc<ffi.Bool>();
  return cvRunAsync0(
    (callback) => ccontrib.cv_aruco_estimatePoseCharucoBoard(
      charucoCorners.ref,
      charucoIds.ref,
      board.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      useExtrinsicGuess,
      pb,
      callback,
    ),
    (c) {
      final rval = pb.value;
      calloc.free(pb);
      c.complete((rval, rvec!, tvec!));
    },
  );
}
