// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
// ignore_for_file: constant_identifier_names, camel_case_types

library cv.contrib.xobjdetect;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as cvg;
import '../native_lib.dart' show ccontrib;

/// WaldBoost detector.
class WBDetector extends CvStruct<cvg.PtrWBDetector> {
  WBDetector.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  /// Create instance of WBDetector.
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#a58377ae61694aac08ad842ac830972d9
  factory WBDetector.create() {
    final ptr = calloc<cvg.PtrWBDetector>();
    cvRun(() => ccontrib.cv_xobjdetect_WBDetector_create(ptr));
    return WBDetector.fromPointer(ptr);
  }

  static final finalizer = OcvFinalizer<cvg.PtrWBDetectorPtr>(
    ccontrib.addresses.cv_xobjdetect_WBDetector_close,
  );

  void dispose() {
    finalizer.detach(this);
    ccontrib.cv_xobjdetect_WBDetector_close(ptr);
  }

  /// Detect objects on image using WaldBoost detector.
  ///
  /// [img]	Input image for detection
  ///
  /// return:
  ///
  /// bboxes	Bounding boxes coordinates output vector
  ///
  /// confidences	Confidence values for bounding boxes output vector
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#ad19680e6545f49a9ca42dfc3457319e2
  (VecRect bboxes, VecF64 confidences) detect(Mat img) {
    final bboxes = VecRect();
    final confidences = VecF64();
    cvRun(() => ccontrib.cv_xobjdetect_WBDetector_detect(ref, img.ref, bboxes.ptr, confidences.ptr));
    return (bboxes, confidences);
  }

  /// Train WaldBoost detector.
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#a3720fb425a2d16f6cd0625a2d8bc563e
  void train(String posSamples, String negImgs) {
    final cp = posSamples.toNativeUtf8().cast<ffi.Char>();
    final cn = negImgs.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.cv_xobjdetect_WBDetector_train(ref, cp, cn));
    calloc.free(cp);
    calloc.free(cn);
  }

  /// Read detector
  void read(String filename) {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.cv_xobjdetect_WBDetector_read(ref, cp));
    calloc.free(cp);
  }

  /// Write detector
  void write(String filename) {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.cv_xobjdetect_WBDetector_write(ref, cp));
    calloc.free(cp);
  }

  @override
  cvg.PtrWBDetector get ref => ptr.ref;
}
