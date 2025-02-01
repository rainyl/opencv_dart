// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:ffi';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../g/gapi.g.dart' as cvg;
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
    cvRun(() => cvg.gapi_GComputation_New(inMat.ref, outMat.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.miso(GMat inMat, GScalar outScalar) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => cvg.gapi_GComputation_New_1(inMat.ref, outScalar.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.mimimo(GMat in1, GMat in2, GMat out) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => cvg.gapi_GComputation_New_2(in1.ref, in2.ref, out.ref, p));
    return GComputation.fromPointer(p);
  }

  factory GComputation.mimiso(GMat in1, GMat in2, GScalar out) {
    final p = calloc<cvg.GComputation>();
    cvRun(() => cvg.gapi_GComputation_New_3(in1.ref, in2.ref, out.ref, p));
    return GComputation.fromPointer(p);
  }

  Future<Mat> apply(Mat inMat) async =>
      cvRunAsync1((callback) => cvg.gapi_GComputation_apply(ref, inMat.ref, callback), (c, p) {
        c.complete(Mat.fromPointer(p.cast()));
      });

  // Mat applyMIMO(Mat inMat) => apply(inMat);

  Scalar applyMISO(Mat inMat) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => cvg.gapi_GComputation_apply_1(ref, inMat.ref, p));
    return Scalar.fromPointer(p);
  }

  Mat applyMIMIMO(Mat in1, Mat in2) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.gapi_GComputation_apply_2(ref, in1.ref, in2.ref, p));
    return Mat.fromPointer(p);
  }

  Scalar applyMIMISO(Mat in1, Mat in2) {
    final p = calloc<cvg.Scalar>();
    cvRun(() => cvg.gapi_GComputation_apply_3(ref, in1.ref, in2.ref, p));
    return Scalar.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GComputationPtr>(cvg.addresses.gapi_GComputation_Close);
  void dispose() {
    finalizer.detach(this);
    cvg.gapi_GComputation_Close(ptr);
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
