// coverage:ignore-file
// ignore_for_file: constant_identifier_names, camel_case_types

library cv.contrib.xobjdetect;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/rect.dart';
import '../core/vec.dart';
import '../g/contrib.g.dart' as ccontrib;

/// WaldBoost detector.
class WBDetector extends CvStruct<ccontrib.PtrWBDetector> {
  WBDetector.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  /// Create instance of WBDetector.
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#a58377ae61694aac08ad842ac830972d9
  factory WBDetector.create() {
    final ptr = calloc<ccontrib.PtrWBDetector>();
    cvRun(() => ccontrib.WBDetector_Create(ptr));
    return WBDetector.fromPointer(ptr);
  }

  static final finalizer = OcvFinalizer<ccontrib.PtrWBDetectorPtr>(ccontrib.addresses.WBDetector_Close);

  void dispose() {
    finalizer.detach(this);
    ccontrib.WBDetector_Close(ptr);
  }

  /// Detect objects on image using WaldBoost detector.
  ///
  /// [img]	Input image for detection
  ///
  /// return:
  ///
  /// [bboxes]	Bounding boxes coordinates output vector
  ///
  /// [confidences]	Confidence values for bounding boxes output vector
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#ad19680e6545f49a9ca42dfc3457319e2
  (VecRect bboxes, VecF64 confidences) detect(Mat img) {
    final bboxesPtr = calloc<ccontrib.VecRect>();
    final confidencesPtr = calloc<ccontrib.VecF64>();
    cvRun(() => ccontrib.WBDetector_Detect(ptr, img.ref, bboxesPtr, confidencesPtr));
    return (VecRect.fromPointer(bboxesPtr), VecF64.fromPointer(confidencesPtr));
  }

  /// Train WaldBoost detector.
  ///
  /// https://docs.opencv.org/4.x/de/d0e/classcv_1_1xobjdetect_1_1WBDetector.html#a3720fb425a2d16f6cd0625a2d8bc563e
  void train(String posSamples, String negImgs) {
    final cp = posSamples.toNativeUtf8().cast<ffi.Char>();
    final cn = negImgs.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.WBDetector_Train(ptr, cp, cn));
    calloc.free(cp);
    calloc.free(cn);
  }

  /// Read detector
  void read(String filename) {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.WBDetector_Read(ptr, cp));
    calloc.free(cp);
  }

  /// Write detector
  void write(String filename) {
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => ccontrib.WBDetector_Write(ptr, cp));
    calloc.free(cp);
  }

  @override
  ccontrib.PtrWBDetector get ref => ptr.ref;
}
