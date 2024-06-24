library cv;

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../opencv.g.dart' as cvg;
import 'gmat.dart';
import 'gscalar.dart';

class GComputation extends CvStruct<cvg.GComputation> {
  GComputation.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GComputation.mimo(GMat inMat, GMat outMat) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => CFFI.gapi_GComputation_New(inMat.ref, outMat.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.miso(GMat inMat, GScalar outScalar) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => CFFI.gapi_GComputation_New_1(inMat.ref, outScalar.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.mimimo(GMat in1, GMat in2, GMat out) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => CFFI.gapi_GComputation_New_2(in1.ref, in2.ref, out.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.mimiso(GMat in1, GMat in2, GScalar out) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => CFFI.gapi_GComputation_New_3(in1.ref, in2.ref, out.ref, p));
    return GComputation.fromPointer(p);
  }

  Future<Mat> apply(Mat inMat) async =>
      cvRunAsync((callback) => CFFI.gapi_GComputation_apply(ref, inMat.ref, callback), matCompleter);

  // Mat applyMIMO(Mat inMat) => apply(inMat);

  Scalar applyMISO(Mat inMat) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => CFFI.gapi_GComputation_apply_1(ref, inMat.ref, p));
    return Scalar.fromPointer(p);
  }

  Mat applyMIMIMO(Mat in1, Mat in2) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.gapi_GComputation_apply_2(ref, in1.ref, in2.ref, p));
    return Mat.fromPointer(p);
  }

  Scalar applyMIMISO(Mat in1, Mat in2) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => CFFI.gapi_GComputation_apply_3(ref, in1.ref, in2.ref, p));
    return Scalar.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GComputationPtr>(CFFI.addresses.gapi_GComputation_Close);
  void dispose() {
    finalizer.detach(this);
    CFFI.gapi_GComputation_Close(ptr);
  }

  @override
  List<Object?> get props => [ptr.address];

  @override
  cvg.GComputation get ref => ptr.ref;

  @override
  String toString() {
    return "GComputation(address=${ptr.address.toRadixString(16)}))";
  }
}
