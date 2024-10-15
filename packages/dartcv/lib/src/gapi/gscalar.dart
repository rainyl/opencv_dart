// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

// import '../g/constants.g.dart';
import '../core/base.dart';
// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
// import '../core/mat.dart';
import '../core/scalar.dart';
// import '../core/vec.dart';
import '../g/gapi.g.dart' as cvg;
import '../native_lib.dart' show cgapi;

class GScalar extends CvStruct<cvg.GScalar> {
  GScalar.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GScalar.empty() {
    final p = calloc<cvg.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_Empty(p));
    return GScalar.fromPointer(p);
  }

  factory GScalar.fromScalar(Scalar s) {
    final p = calloc<cvg.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_FromScalar(s.ref, p));
    return GScalar.fromPointer(p);
  }

  factory GScalar(double value) {
    final p = calloc<cvg.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_FromDouble(value, p));
    return GScalar.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GScalarPtr>(cgapi.addresses.gapi_GScalar_Close);
  void dispose() {
    finalizer.detach(this);
    cgapi.gapi_GScalar_Close(ptr);
  }

  @override
  List<Object?> get props => [ptr.address];

  @override
  cvg.GScalar get ref => ptr.ref;

  @override
  String toString() {
    return "GScalar(address=${ptr.address.toRadixString(16)}))";
  }
}
