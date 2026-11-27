// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

// import '../core/scalar.dart';
// import '../core/vec.dart';
import '../bindings/gapi.dart' as cvg;
// import '../g/constants.g.dart';
import '../core/base.dart';
// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
import '../core/mat.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';

class GMat extends CvStruct<cvg.GMat> {
  GMat.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      // `detach: this` is what `freeNative` detaches: without it `dispose()` frees the native
      // object and the finalizer frees it a second time when the wrapper is collected.
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory GMat.empty() {
    return GMat.fromPointer(cvCreate(calloc<cvg.GMat>(), cvg.gapi_GMat_New_Empty));
  }

  factory GMat.fromMat(Mat mat) {
    return GMat.fromPointer(cvCreate(calloc<cvg.GMat>(), (p) => cvg.gapi_GMat_New_FromMat(mat.ref, p)));
  }

  static final finalizer = OcvFinalizer<cvg.GMatPtr>(cvg.addresses.gapi_GMat_Close);
  @override
  void freeNative() {
    finalizer.detach(this);
    cvg.gapi_GMat_Close(ptr);
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
