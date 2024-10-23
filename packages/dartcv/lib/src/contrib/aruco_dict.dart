// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../g/contrib.g.dart' as cvg;
import '../native_lib.dart' show ccontrib;

enum PredefinedDictionaryType {
  ///< 4x4 bits, minimum hamming distance between any two codes = 4, 50 codes
  DICT_4X4_50(0),

  ///< 4x4 bits, minimum hamming distance between any two codes = 3, 100 codes
  DICT_4X4_100(1),

  ///< 4x4 bits, minimum hamming distance between any two codes = 3, 250 codes
  DICT_4X4_250(2),

  ///< 4x4 bits, minimum hamming distance between any two codes = 2, 1000 codes
  DICT_4X4_1000(3),

  ///< 5x5 bits, minimum hamming distance between any two codes = 8, 50 codes
  DICT_5X5_50(4),

  ///< 5x5 bits, minimum hamming distance between any two codes = 7, 100 codes
  DICT_5X5_100(5),

  ///< 5x5 bits, minimum hamming distance between any two codes = 6, 250 codes
  DICT_5X5_250(6),

  ///< 5x5 bits, minimum hamming distance between any two codes = 5, 1000 codes
  DICT_5X5_1000(7),

  ///< 6x6 bits, minimum hamming distance between any two codes = 13, 50 codes
  DICT_6X6_50(8),

  ///< 6x6 bits, minimum hamming distance between any two codes = 12, 100 codes
  DICT_6X6_100(9),

  ///< 6x6 bits, minimum hamming distance between any two codes = 11, 250 codes
  DICT_6X6_250(10),

  ///< 6x6 bits, minimum hamming distance between any two codes = 9, 1000 codes
  DICT_6X6_1000(11),

  ///< 7x7 bits, minimum hamming distance between any two codes = 19, 50 codes
  DICT_7X7_50(12),

  ///< 7x7 bits, minimum hamming distance between any two codes = 18, 100 codes
  DICT_7X7_100(13),

  ///< 7x7 bits, minimum hamming distance between any two codes = 17, 250 codes
  DICT_7X7_250(14),

  ///< 7x7 bits, minimum hamming distance between any two codes = 14, 1000 codes
  DICT_7X7_1000(15),

  ///< 6x6 bits, minimum hamming distance between any two codes = 3, 1024 codes
  DICT_ARUCO_ORIGINAL(16),

  ///< 4x4 bits, minimum hamming distance between any two codes = 5, 30 codes
  DICT_APRILTAG_16h5(17),

  ///< 5x5 bits, minimum hamming distance between any two codes = 9, 35 codes
  DICT_APRILTAG_25h9(18),

  ///< 6x6 bits, minimum hamming distance between any two codes = 10, 2320 codes
  DICT_APRILTAG_36h10(19),

  ///< 6x6 bits, minimum hamming distance between any two codes = 11, 587 codes
  DICT_APRILTAG_36h11(20),

  ///< 6x6 bits, minimum hamming distance between any two codes = 12, 250 codes
  DICT_ARUCO_MIP_36h12(21);

  const PredefinedDictionaryType(this.value);
  final int value;
}

class ArucoDictionary extends CvStruct<cvg.ArucoDictionary> {
  ArucoDictionary._(cvg.ArucoDictionaryPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory ArucoDictionary.empty() {
    final p = calloc<cvg.ArucoDictionary>();
    cvRun(() => ccontrib.cv_aruco_Dictionary_create(p));
    return ArucoDictionary._(p);
  }

  factory ArucoDictionary.fromBytesList(Mat bytesList, int markerSize, {int maxCorr = 0}) {
    final p = calloc<cvg.ArucoDictionary>();
    cvRun(() => ccontrib.cv_aruco_Dictionary_create_1(bytesList.ref, markerSize, maxCorr, p));
    return ArucoDictionary._(p);
  }

  factory ArucoDictionary.predefined(PredefinedDictionaryType type) {
    final p = calloc<cvg.ArucoDictionary>();
    cvRun(() => ccontrib.cv_aruco_getPredefinedDictionary(type.value, p));
    return ArucoDictionary._(p);
  }

  Mat generateImageMarker(int id, int sidePixels, {OutputArray? dst, int borderBits = 1}) {
    dst ??= Mat.empty();
    cvRun(() => ccontrib.cv_aruco_Dictionary_generateImageMarker(ref, id, sidePixels, dst!.ref, borderBits));
    return dst;
  }

  int getDistanceToId(InputArray bits, int id, {bool allRotations = true}) =>
      ccontrib.cv_aruco_Dictionary_getDistanceToId(ref, bits.ref, id, allRotations);

  (bool rval, int idx, int rotation) identify(InputArray onlyBits, double maxCorrectionRate) {
    final pIdx = calloc<ffi.Int>();
    final pRotation = calloc<ffi.Int>();
    final rval = ccontrib.cv_aruco_Dictionary_identify(ref, onlyBits.ref, pIdx, pRotation, maxCorrectionRate);
    final ret = (rval, pIdx.value, pRotation.value);
    calloc.free(pIdx);
    calloc.free(pRotation);
    return ret;
  }

  Mat get bytesList {
    final dst = Mat.empty();
    cvRun(() => ccontrib.cv_aruco_Dictionary_get_bytesList(ref, dst.ptr));
    return dst;
  }

  set bytesList(Mat value) => ccontrib.cv_aruco_Dictionary_set_bytesList(ref, value.ref);

  int get markerSize => ccontrib.cv_aruco_Dictionary_get_markerSize(ref);

  set markerSize(int value) => ccontrib.cv_aruco_Dictionary_set_markerSize(ref, value);

  int get maxCorrectionBits => ccontrib.cv_aruco_Dictionary_get_maxCorrectionBits(ref);

  set maxCorrectionBits(int value) => ccontrib.cv_aruco_Dictionary_set_maxCorrectionBits(ref, value);

  @override
  cvg.ArucoDictionary get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDictionaryPtr>(ccontrib.addresses.cv_aruco_Dictionary_close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_aruco_Dictionary_close(ptr);
  }
}
