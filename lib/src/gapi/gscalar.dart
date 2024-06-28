library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

// import '../constants.g.dart';
import '../core/base.dart';
// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
// import '../core/mat.dart';
import '../core/scalar.dart';
// import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class GScalar extends CvStruct<cvg.GScalar> {
  GScalar.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GScalar.empty() {
    final p = calloc<cvg.GScalar>();
    cvRun(() => CFFI.gapi_GScalar_New_Empty(p));
    return GScalar.fromPointer(p);
  }

  factory GScalar.fromScalar(Scalar s) {
    final p = calloc<cvg.GScalar>();
    cvRun(() => CFFI.gapi_GScalar_New_FromScalar(s.ref, p));
    return GScalar.fromPointer(p);
  }

  factory GScalar(double value) {
    final p = calloc<cvg.GScalar>();
    cvRun(() => CFFI.gapi_GScalar_New_FromDouble(value, p));
    return GScalar.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GScalarPtr>(CFFI.addresses.gapi_GScalar_Close);
  void dispose() {
    finalizer.detach(this);
    CFFI.gapi_GScalar_Close(ptr);
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
