library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

// import '../constants.g.dart';
import '../core/base.dart';
// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
import '../core/mat.dart';
// import '../core/scalar.dart';
// import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class GMat extends CvStruct<cvg.GMat> {
  GMat.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast());
    }
  }

  factory GMat.empty() {
    final p = calloc<cvg.GMat>();
    cvRun(() => CFFI.gapi_GMat_New_Empty(p));
    return GMat.fromPointer(p);
  }

  factory GMat.fromMat(Mat mat) {
    final p = calloc<cvg.GMat>();
    cvRun(() => CFFI.gapi_GMat_New_FromMat(mat.ref, p));
    return GMat.fromPointer(p);
  }

  static final finalizer = OcvFinalizer<cvg.GMatPtr>(CFFI.addresses.gapi_GMat_Close);
  void dispose() {
    finalizer.detach(this);
    CFFI.gapi_GMat_Close(ptr);
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
