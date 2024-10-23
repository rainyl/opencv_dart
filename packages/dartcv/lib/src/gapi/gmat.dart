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
import '../core/mat.dart';
// import '../core/scalar.dart';
// import '../core/vec.dart';
import '../g/gapi.g.dart' as cvg;
import '../native_lib.dart' show cgapi;

class GMat extends CvStruct<cvg.GMat> {
  GMat.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GMat.empty() {
    final p = calloc<cvg.GMat>();
    cvRun(() => cgapi.gapi_GMat_New_Empty(p));
    return GMat.fromPointer(p);
  }

  factory GMat.fromMat(Mat mat) {
    final p = calloc<cvg.GMat>();
    cvRun(() => cgapi.gapi_GMat_New_FromMat(mat.ref, p));
    return GMat.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GMatPtr>(cgapi.addresses.gapi_GMat_Close);
  void dispose() {
    finalizer.detach(this);
    cgapi.gapi_GMat_Close(ptr);
  }

  @override
  List<Object?> get props => [ptr.address];

  @override
  cvg.GMat get ref => ptr.ref;

  @override
  String toString() {
    return "GMat(address=${ptr.address.toRadixString(16)}))";
  }
}
