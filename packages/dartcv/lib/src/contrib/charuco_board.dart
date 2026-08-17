// Copyright (c) 2024, pariterre, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as ccontrib;
import '../g/contrib.g.dart' as cvg;
import 'aruco_dict.dart';

class CharucoBoard extends CvStruct<cvg.CharucoBoard> {
  CharucoBoard._(cvg.CharucoBoardPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory CharucoBoard.fromPointer(cvg.CharucoBoardPtr ptr, [bool attach = true]) =>
      CharucoBoard._(ptr, attach);

  factory CharucoBoard.empty() {
    final p = calloc<cvg.CharucoBoard>();
    cvRun(() => ccontrib.cv_aruco_charucoBoard_create(p));
    return CharucoBoard._(p);
  }

  factory CharucoBoard.create(
    (int, int) size,
    double squareLength,
    double markerLength,
    ArucoDictionary dictionary, {
    VecI32? ids,
  }) {
    final p = calloc<cvg.CharucoBoard>();
    final sz = size.cvd;
    cvRun(
      () => ids == null
          ? ccontrib.cv_aruco_charucoBoard_create_1(sz.ref, squareLength, markerLength, dictionary.ref, p)
          : ccontrib.cv_aruco_charucoBoard_create_2(
              sz.ref,
              squareLength,
              markerLength,
              dictionary.ref,
              ids.ref,
              p,
            ),
    );
    sz.dispose();
    return CharucoBoard._(p);
  }

  @override
  cvg.CharucoBoard get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CharucoBoardPtr>(ccontrib.addresses.cv_aruco_charucoBoard_close);

  @override
  void freeNative() {
    finalizer.detach(this);
    ccontrib.cv_aruco_charucoBoard_close(ptr);
  }

  bool checkCharucoCornersCollinear(VecI32 charucoIds) =>
      ccontrib.cv_aruco_charucoBoard_checkCharucoCornersCollinear(ref, charucoIds.ref);

  Mat generateImage((int, int) outSize, {OutputArray? img, int marginSize = 0, int borderBits = 1}) {
    img ??= Mat.empty();
    final size = outSize.cvd;
    cvRun(
      () => ccontrib.cv_aruco_charucoBoard_generateImage(
        ref,
        size.ref,
        img!.ref,
        marginSize,
        borderBits,
        ffi.nullptr,
      ),
    );
    size.dispose();
    return img;
  }

  VecPoint3f get chessboardCorners {
    final corners = VecPoint3f();
    cvRun(
      () => ccontrib.cv_aruco_charucoBoard_getChessboardCorners(ref, corners.ptr),
    );
    return corners;
  }

  Size get chessboardSize => Size.fromNative(ccontrib.cv_aruco_charucoBoard_getChessboardSize(ref));

  double get markerLength => ccontrib.cv_aruco_charucoBoard_getMarkerLength(ref);

  double get squareLength => ccontrib.cv_aruco_charucoBoard_getSquareLength(ref);

  bool get legacyPattern => ccontrib.cv_aruco_charucoBoard_getLegacyPattern(ref);

  set legacyPattern(bool value) => ccontrib.cv_aruco_charucoBoard_setLegacyPattern(ref, value);

  VecI32 get ids {
    final out = VecI32();
    cvRun(() => ccontrib.cv_aruco_charucoBoard_getIds(ref, out.ptr));
    return out;
  }

  VecVecPoint3f get objPoints {
    final out = VecVecPoint3f();
    cvRun(() => ccontrib.cv_aruco_charucoBoard_getObjPoints(ref, out.ptr));
    return out;
  }

  (Mat objPoints, Mat imgPoints) matchImagePoints(
    VecPoint2f detectedCharuco,
    VecI32 detectedIds, {
    Mat? objPoints,
    Mat? imgPoints,
  }) {
    objPoints ??= Mat.empty();
    imgPoints ??= Mat.empty();
    cvRun(
      () => ccontrib.cv_aruco_charucoBoard_matchImagePoints(
        ref,
        detectedCharuco.ref,
        detectedIds.ref,
        objPoints!.ref,
        imgPoints!.ref,
        ffi.nullptr,
      ),
    );
    return (objPoints, imgPoints);
  }
}
