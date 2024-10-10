// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.contrib;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
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

  factory ArucoDictionary.predefined(PredefinedDictionaryType type) {
    final p = calloc<cvg.ArucoDictionary>();
    cvRun(() => ccontrib.getPredefinedDictionary(type.value, p));
    return ArucoDictionary._(p);
  }

  @override
  cvg.ArucoDictionary get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.ArucoDictionaryPtr>(ccontrib.addresses.ArucoDictionary_Close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.ArucoDictionary_Close(ptr);
  }
}
