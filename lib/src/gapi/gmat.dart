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
import '../g/gapi.g.dart' as cgapi;

class GMat extends CvStruct<cgapi.GMat> {
  GMat.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GMat.empty() {
    final p = calloc<cgapi.GMat>();
    cvRun(() => cgapi.gapi_GMat_New_Empty(p));
    return GMat.fromPointer(p);
  }

  factory GMat.fromMat(Mat mat) {
    final p = calloc<cgapi.GMat>();
    cvRun(() => cgapi.gapi_GMat_New_FromMat(mat.ref, p));
    return GMat.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cgapi.GMatPtr>(cgapi.addresses.gapi_GMat_Close);
  void dispose() {
    finalizer.detach(this);
    cgapi.gapi_GMat_Close(ptr);
  }

  @override
  List<Object?> get props => [ptr.address];

  @override
  cgapi.GMat get ref => ptr.ref;

  @override
  String toString() {
    return "GMat(address=${ptr.address.toRadixString(16)}))";
  }
}
