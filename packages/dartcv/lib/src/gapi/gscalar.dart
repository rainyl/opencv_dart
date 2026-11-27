// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

// import '../core/vec.dart';
import '../bindings/gapi.dart' as cvg;
// import '../g/constants.g.dart';
import '../core/base.dart';
// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
// import '../core/mat.dart';
import '../core/scalar.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';

class GScalar extends CvStruct<cvg.GScalar> {
  GScalar.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      // `detach: this` is what `freeNative` detaches: without it `dispose()` frees the native
      // object and the finalizer frees it a second time when the wrapper is collected.
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory GScalar.empty() {
    return GScalar.fromPointer(cvCreate(calloc<cvg.GScalar>(), cvg.gapi_GScalar_New_Empty));
  }

  factory GScalar.fromScalar(Scalar s) {
    return GScalar.fromPointer(
      cvCreate(calloc<cvg.GScalar>(), (p) => cvg.gapi_GScalar_New_FromScalar(s.ref, p)),
    );
  }

  factory GScalar(double value) {
    return GScalar.fromPointer(
      cvCreate(calloc<cvg.GScalar>(), (p) => cvg.gapi_GScalar_New_FromDouble(value, p)),
    );
  }

  static final finalizer = OcvFinalizer<cvg.GScalarPtr>(cvg.addresses.gapi_GScalar_Close);
  @override
  void freeNative() {
    finalizer.detach(this);
    cvg.gapi_GScalar_Close(ptr);
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
