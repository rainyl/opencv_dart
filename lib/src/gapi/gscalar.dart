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
import '../g/gapi.g.dart' as cgapi;

class GScalar extends CvStruct<cgapi.GScalar> {
  GScalar.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GScalar.empty() {
    final p = calloc<cgapi.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_Empty(p));
    return GScalar.fromPointer(p);
  }

  factory GScalar.fromScalar(Scalar s) {
    final p = calloc<cgapi.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_FromScalar(s.ref, p));
    return GScalar.fromPointer(p);
  }

  factory GScalar(double value) {
    final p = calloc<cgapi.GScalar>();
    cvRun(() => cgapi.gapi_GScalar_New_FromDouble(value, p));
    return GScalar.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cgapi.GScalarPtr>(cgapi.addresses.gapi_GScalar_Close);
  void dispose() {
    finalizer.detach(this);
    cgapi.gapi_GScalar_Close(ptr);
  }

  @override
  List<Object?> get props => [ptr.address];

  @override
  cgapi.GScalar get ref => ptr.ref;

  @override
  String toString() {
    return "GScalar(address=${ptr.address.toRadixString(16)}))";
  }
}
