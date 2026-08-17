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
import '../g/contrib.g.dart' as cvg;
import 'aruco.dart';
import 'charuco_board.dart';

class ArucoRefineParameters extends CvStruct<cvg.ArucoRefineParams> {
  ArucoRefineParameters._(cvg.ArucoRefineParamsPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory ArucoRefineParameters.fromPointer(cvg.ArucoRefineParamsPtr ptr, [bool attach = true]) =>
      ArucoRefineParameters._(ptr, attach);

  factory ArucoRefineParameters.empty() {
    final p = calloc<cvg.ArucoRefineParams>();
    cvRun(() => ccontrib.cv_aruco_refineParameters_create(p));
    return ArucoRefineParameters._(p);
  }

  factory ArucoRefineParameters.create({
    double minRepDistance = 10.0,
    double errorCorrectionRate = 3.0,
    bool checkAllOrders = true,
  }) {
    final p = calloc<cvg.ArucoRefineParams>();
    cvRun(
      () =>
          ccontrib.cv_aruco_refineParameters_create_1(minRepDistance, errorCorrectionRate, checkAllOrders, p),
    );
    return ArucoRefineParameters._(p);
  }

  @override
  cvg.ArucoRefineParams get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoRefineParamsPtr>(
    ccontrib.addresses.cv_aruco_refineParameters_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_aruco_refineParameters_close(ptr);
  }

  double get minRepDistance => ccontrib.cv_aruco_refineParameters_get_minRepDistance(ref);

  set minRepDistance(double value) => ccontrib.cv_aruco_refineParameters_set_minRepDistance(ref, value);

  double get errorCorrectionRate => ccontrib.cv_aruco_refineParameters_get_errorCorrectionRate(ref);

  set errorCorrectionRate(double value) =>
      ccontrib.cv_aruco_refineParameters_set_errorCorrectionRate(ref, value);

  bool get checkAllOrders => ccontrib.cv_aruco_refineParameters_get_checkAllOrders(ref);

  set checkAllOrders(bool value) => ccontrib.cv_aruco_refineParameters_set_checkAllOrders(ref, value);
}

class CharucoDetectorParameters extends CvStruct<cvg.CharucoDetectorParams> {
  CharucoDetectorParameters._(cvg.CharucoDetectorParamsPtr ptr, [bool attach = true])
    : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory CharucoDetectorParameters.fromPointer(cvg.CharucoDetectorParamsPtr ptr, [bool attach = true]) =>
      CharucoDetectorParameters._(ptr, attach);

  factory CharucoDetectorParameters.empty() {
    final p = calloc<cvg.CharucoDetectorParams>();
    cvRun(() => ccontrib.cv_aruco_charucoDetectorParameters_create(p));
    return CharucoDetectorParameters._(p);
  }

  @override
  cvg.CharucoDetectorParams get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CharucoDetectorParamsPtr>(
    ccontrib.addresses.cv_aruco_charucoDetectorParameters_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_aruco_charucoDetectorParameters_close(ptr);
  }

  Mat get cameraMatrix {
    final out = Mat.empty();
    cvRun(() => ccontrib.cv_aruco_charucoDetectorParameters_get_cameraMatrix(ref, out.ptr));
    return out;
  }

  set cameraMatrix(Mat value) =>
      cvRun(() => ccontrib.cv_aruco_charucoDetectorParameters_set_cameraMatrix(ref, value.ref));

  Mat get distCoeffs {
    final out = Mat.empty();
    cvRun(() => ccontrib.cv_aruco_charucoDetectorParameters_get_distCoeffs(ref, out.ptr));
    return out;
  }

  set distCoeffs(Mat value) =>
      cvRun(() => ccontrib.cv_aruco_charucoDetectorParameters_set_distCoeffs(ref, value.ref));

  int get minMarkers => ccontrib.cv_aruco_charucoDetectorParameters_get_minMarkers(ref);

  set minMarkers(int value) => ccontrib.cv_aruco_charucoDetectorParameters_set_minMarkers(ref, value);

  bool get tryRefineMarkers => ccontrib.cv_aruco_charucoDetectorParameters_get_tryRefineMarkers(ref);

  set tryRefineMarkers(bool value) =>
      ccontrib.cv_aruco_charucoDetectorParameters_set_tryRefineMarkers(ref, value);

  bool get checkMarkers => ccontrib.cv_aruco_charucoDetectorParameters_get_checkMarkers(ref);

  set checkMarkers(bool value) => ccontrib.cv_aruco_charucoDetectorParameters_set_checkMarkers(ref, value);
}

class CharucoDetector extends CvStruct<cvg.CharucoDetector> {
  CharucoDetector._(cvg.CharucoDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory CharucoDetector.fromPointer(cvg.CharucoDetectorPtr ptr, [bool attach = true]) =>
      CharucoDetector._(ptr, attach);

  factory CharucoDetector.fromBoard(CharucoBoard board) {
    final p = calloc<cvg.CharucoDetector>();
    cvRun(() => ccontrib.cv_aruco_charucoDetector_create_1(board.ref, p));
    return CharucoDetector._(p);
  }

  factory CharucoDetector.create(
    CharucoBoard board,
    CharucoDetectorParameters? charucoParameters, {
    ArucoDetectorParameters? detectorParameters,
    ArucoRefineParameters? refineParameters,
  }) {
    final p = calloc<cvg.CharucoDetector>();
    final ownedCharucoParameters = charucoParameters == null ? CharucoDetectorParameters.empty() : null;
    final ownedDetectorParameters = refineParameters != null && detectorParameters == null
        ? ArucoDetectorParameters.empty()
        : null;
    final charucoParams = charucoParameters ?? ownedCharucoParameters!;
    final detectorParams = detectorParameters ?? ownedDetectorParameters;
    try {
      cvRun(() {
        if (refineParameters != null) {
          return ccontrib.cv_aruco_charucoDetector_create_4(
            board.ref,
            charucoParams.ref,
            detectorParams!.ref,
            refineParameters.ref,
            p,
          );
        }
        if (detectorParams != null) {
          return ccontrib.cv_aruco_charucoDetector_create_3(
            board.ref,
            charucoParams.ref,
            detectorParams.ref,
            p,
          );
        }
        if (charucoParameters != null) {
          return ccontrib.cv_aruco_charucoDetector_create_2(
            board.ref,
            charucoParams.ref,
            p,
          );
        }
        return ccontrib.cv_aruco_charucoDetector_create_1(board.ref, p);
      });
    } finally {
      ownedDetectorParameters?.dispose();
      ownedCharucoParameters?.dispose();
    }
    return CharucoDetector._(p);
  }

  @override
  cvg.CharucoDetector get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CharucoDetectorPtr>(
    ccontrib.addresses.cv_aruco_charucoDetector_close,
  );

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_aruco_charucoDetector_close(ptr);
  }

  (VecPoint2f charucoCorners, VecI32 charucoIds, VecVecPoint2f markerCorners, VecI32 markerIds) detectBoard(
    InputArray image, {
    VecVecPoint2f? markerCorners,
    VecI32? markerIds,
  }) {
    final charucoCorners = VecPoint2f();
    final charucoIds = VecI32();
    markerCorners ??= VecVecPoint2f();
    markerIds ??= VecI32();
    cvRun(
      () => ccontrib.cv_aruco_charucoDetector_detectBoard(
        ref,
        image.ref,
        charucoCorners.ptr,
        charucoIds.ptr,
        markerCorners!.ptr,
        markerIds!.ptr,
        ffi.nullptr,
      ),
    );
    return (charucoCorners, charucoIds, markerCorners, markerIds);
  }

  (VecVecPoint2f diamondCorners, VecVec4i diamondIds, VecVecPoint2f markerCorners, VecI32 markerIds)
  detectDiamonds(InputArray image, {VecVecPoint2f? markerCorners, VecI32? markerIds}) {
    final diamondCorners = VecVecPoint2f();
    final diamondIds = VecVec4i();
    markerCorners ??= VecVecPoint2f();
    markerIds ??= VecI32();
    cvRun(
      () => ccontrib.cv_aruco_charucoDetector_detectDiamonds(
        ref,
        image.ref,
        diamondCorners.ptr,
        diamondIds.ptr,
        markerCorners!.ptr,
        markerIds!.ptr,
        ffi.nullptr,
      ),
    );
    return (diamondCorners, diamondIds, markerCorners, markerIds);
  }

  CharucoBoard get board {
    final out = calloc<cvg.CharucoBoard>();
    cvRun(() => ccontrib.cv_aruco_charucoDetector_getBoard(ref, out));
    return CharucoBoard.fromPointer(out);
  }

  set board(CharucoBoard value) => ccontrib.cv_aruco_charucoDetector_setBoard(ref, value.ref);

  CharucoDetectorParameters get charucoParameters {
    final out = calloc<cvg.CharucoDetectorParams>();
    cvRun(() => ccontrib.cv_aruco_charucoDetector_getCharucoParameters(ref, out));
    return CharucoDetectorParameters.fromPointer(out);
  }

  set charucoParameters(CharucoDetectorParameters value) =>
      ccontrib.cv_aruco_charucoDetector_setCharucoParameters(ref, value.ref);

  ArucoDetectorParameters get detectorParameters {
    final out = calloc<cvg.ArucoDetectorParams>();
    cvRun(() => ccontrib.cv_aruco_charucoDetector_getDetectorParameters(ref, out));
    return ArucoDetectorParameters.fromPointer(out);
  }

  set detectorParameters(ArucoDetectorParameters value) =>
      ccontrib.cv_aruco_charucoDetector_setDetectorParameters(ref, value.ref);

  ArucoRefineParameters get refineParameters {
    final out = calloc<cvg.ArucoRefineParams>();
    cvRun(() => ccontrib.cv_aruco_charucoDetector_getRefineParameters(ref, out));
    return ArucoRefineParameters.fromPointer(out);
  }

  set refineParameters(ArucoRefineParameters value) =>
      ccontrib.cv_aruco_charucoDetector_setRefineParameters(ref, value.ref);
}

void drawDetectedCornersCharuco(
  Mat image,
  VecPoint2f charucoCorners, [
  VecI32? charucoIds,
  Scalar? cornerColor,
]) {
  final ids = charucoIds ?? VecI32();
  final disposeIds = charucoIds == null;
  cvRun(
    () => ccontrib.cv_aruco_drawDetectedCornersCharuco(
      image.ref,
      charucoCorners.ref,
      ids.ref,
      (cornerColor ?? Scalar(255, 0, 0, 0)).ref,
      ffi.nullptr,
    ),
  );
  if (disposeIds) ids.dispose();
}

(bool rval, Mat rvec, Mat tvec) estimatePoseCharucoBoard(
  VecPoint2f charucoCorners,
  VecI32 charucoIds,
  CharucoBoard board,
  InputArray cameraMatrix,
  InputArray distCoeffs, {
  Mat? rvec,
  Mat? tvec,
  bool useExtrinsicGuess = false,
}) {
  final pb = calloc<ffi.Bool>();
  rvec ??= Mat.empty();
  tvec ??= Mat.empty();
  cvRun(
    () => ccontrib.cv_aruco_estimatePoseCharucoBoard(
      charucoCorners.ref,
      charucoIds.ref,
      board.ref,
      cameraMatrix.ref,
      distCoeffs.ref,
      rvec!.ref,
      tvec!.ref,
      useExtrinsicGuess,
      pb,
      ffi.nullptr,
    ),
  );
  final rval = pb.value;
  calloc.free(pb);
  return (rval, rvec, tvec);
}
