import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

/// struct returned by cv::moments
///
/// https://docs.opencv.org/4.x/d8/d23/classcv_1_1Moments.html#details
class Moments extends CvStruct<cvg.Moment> {
  Moments._(ffi.Pointer<cvg.Moment> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Moments.fromPointer(ffi.Pointer<cvg.Moment> ptr, [bool attach = true]) =>
      Moments._(ptr, attach);

  /// spatial moments
  double get m00 => ref.m00;
  double get m01 => ref.m01;
  double get m02 => ref.m02;
  double get m03 => ref.m03;
  double get m10 => ref.m10;
  double get m11 => ref.m11;
  double get m12 => ref.m12;
  double get m20 => ref.m20;
  double get m21 => ref.m21;
  double get m30 => ref.m30;

  /// central moments
  double get mu20 => ref.mu20;
  double get mu11 => ref.mu11;
  double get mu02 => ref.mu02;
  double get mu30 => ref.mu30;
  double get mu21 => ref.mu21;
  double get mu12 => ref.mu12;
  double get mu03 => ref.mu03;

  /// central normalized moments
  double get nu20 => ref.nu20;
  double get nu11 => ref.nu11;
  double get nu02 => ref.nu02;
  double get nu30 => ref.nu30;
  double get nu21 => ref.nu21;
  double get nu12 => ref.nu12;
  double get nu03 => ref.nu03;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  cvg.Moment get ref => ptr.ref;

  @override
  List<double> get props => [
        m00,
        m01,
        m02,
        m03,
        m10,
        m11,
        m12,
        m20,
        m21,
        m30,
        mu20,
        mu11,
        mu02,
        mu30,
        mu21,
        mu12,
        mu03,
        nu20,
        nu11,
        nu02,
        nu30,
        nu21,
        nu12,
        nu03,
      ];
}
