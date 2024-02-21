import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'base.dart';

class Moments extends CvObject {
  Moments._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  // Moments.fromList();
  factory Moments.fromNative(cvg.Moment m) {
    final _ptr = calloc<cvg.Moment>()
      ..ref.m00 = m.m00
      ..ref.m10 = m.m10
      ..ref.m01 = m.m01
      ..ref.m20 = m.m20
      ..ref.m11 = m.m11
      ..ref.m02 = m.m02
      ..ref.m30 = m.m30
      ..ref.m21 = m.m21
      ..ref.m12 = m.m12
      ..ref.m03 = m.m03
      ..ref.mu20 = m.mu20
      ..ref.mu11 = m.mu11
      ..ref.mu02 = m.mu02
      ..ref.mu30 = m.mu30
      ..ref.mu21 = m.mu21
      ..ref.mu12 = m.mu12
      ..ref.mu03 = m.mu03
      ..ref.nu20 = m.nu20
      ..ref.nu11 = m.nu11
      ..ref.nu02 = m.nu02
      ..ref.nu30 = m.nu30
      ..ref.nu21 = m.nu21
      ..ref.nu12 = m.nu12
      ..ref.nu03 = m.nu03;
    return Moments._(_ptr);
  }

  double get m00 => _ptr.ref.m00;
  double get m10 => _ptr.ref.m10;
  double get m01 => _ptr.ref.m01;
  double get m20 => _ptr.ref.m20;
  double get m11 => _ptr.ref.m11;
  double get m02 => _ptr.ref.m02;
  double get m30 => _ptr.ref.m30;
  double get m21 => _ptr.ref.m21;
  double get m12 => _ptr.ref.m12;
  double get m03 => _ptr.ref.m03;
  double get mu20 => _ptr.ref.mu20;
  double get mu11 => _ptr.ref.mu11;
  double get mu02 => _ptr.ref.mu02;
  double get mu30 => _ptr.ref.mu30;
  double get mu21 => _ptr.ref.mu21;
  double get mu12 => _ptr.ref.mu12;
  double get mu03 => _ptr.ref.mu03;
  double get nu20 => _ptr.ref.nu20;
  double get nu11 => _ptr.ref.nu11;
  double get nu02 => _ptr.ref.nu02;
  double get nu30 => _ptr.ref.nu30;
  double get nu21 => _ptr.ref.nu21;
  double get nu12 => _ptr.ref.nu12;
  double get nu03 => _ptr.ref.nu03;

  static final _finalizer = Finalizer<ffi.Pointer<cvg.Moment>>((p0) {
    calloc.free(p0);
  });

  ffi.Pointer<cvg.Moment> _ptr;
  @override
  ffi.Pointer<cvg.Moment> get ptr => _ptr;

  @override
  cvg.Moment get ref => _ptr.ref;
  @override
  cvg.Moment toNative() => _ptr.ref;
}
