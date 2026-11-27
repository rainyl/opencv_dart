// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

import 'dart:async';

import '../bindings/gapi.dart' as cvg;
import '../core/base.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../ffi.dart' as ffi;
import '../ffi.dart';
import '../package_ffi.dart';
import 'gmat.dart';
import 'gscalar.dart';

class GComputation extends CvStruct<cvg.GComputation> {
  GComputation.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      // `detach: this` is what `freeNative` detaches: without it `dispose()` frees the native
      // object and the finalizer frees it a second time when the wrapper is collected.
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory GComputation.mimo(GMat inMat, GMat outMat) {
    return GComputation.fromPointer(
      cvCreate(calloc<cvg.GComputation>(), (p) => cvg.gapi_GComputation_New(inMat.ref, outMat.ref, p)),
    );
  }

  factory GComputation.miso(GMat inMat, GScalar outScalar) {
    return GComputation.fromPointer(
      cvCreate(calloc<cvg.GComputation>(), (p) => cvg.gapi_GComputation_New_1(inMat.ref, outScalar.ref, p)),
    );
  }

  factory GComputation.mimimo(GMat in1, GMat in2, GMat out) {
    return GComputation.fromPointer(
      cvCreate(calloc<cvg.GComputation>(), (p) => cvg.gapi_GComputation_New_2(in1.ref, in2.ref, out.ref, p)),
    );
  }

  factory GComputation.mimiso(GMat in1, GMat in2, GScalar out) {
    return GComputation.fromPointer(
      cvCreate(calloc<cvg.GComputation>(), (p) => cvg.gapi_GComputation_New_3(in1.ref, in2.ref, out.ref, p)),
    );
  }

  Future<Mat> apply(Mat inMat) =>
      cvRunAsync1((callback) => cvg.gapi_GComputation_apply(ref, inMat.ref, callback), (c, p) {
        c.complete(Mat.fromPointer(p.cast()));
      });

  // Mat applyMIMO(Mat inMat) => apply(inMat);

  Scalar applyMISO(Mat inMat) {
    return Scalar.fromPointer(
      cvCreate(calloc<cvg.Scalar>(), (p) => cvg.gapi_GComputation_apply_1(ref, inMat.ref, p)),
    );
  }

  Mat applyMIMIMO(Mat in1, Mat in2) {
    return Mat.fromPointer(
      cvCreate(calloc<cvg.Mat>(), (p) => cvg.gapi_GComputation_apply_2(ref, in1.ref, in2.ref, p)),
    );
  }

  Scalar applyMIMISO(Mat in1, Mat in2) {
    return Scalar.fromPointer(
      cvCreate(calloc<cvg.Scalar>(), (p) => cvg.gapi_GComputation_apply_3(ref, in1.ref, in2.ref, p)),
    );
  }

  static final finalizer = OcvFinalizer<cvg.GComputationPtr>(cvg.addresses.gapi_GComputation_Close);
  @override
  void freeNative() {
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
