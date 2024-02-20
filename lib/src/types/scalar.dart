import 'dart:ffi' as ffi;
import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'types.dart';

class Scalar extends CvObject<cvg.Scalar> with EquatableMixin {
  Scalar._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }

  factory Scalar(double val1, double val2, double val3, double val4) {
    final _ptr = calloc<cvg.Scalar>()
      ..ref.val1 = val1
      ..ref.val2 = val2
      ..ref.val3 = val3
      ..ref.val4 = val4;
    return Scalar._(_ptr);
  }
  factory Scalar.fromNative(cvg.Scalar s) =>
      Scalar(s.val1, s.val2, s.val3, s.val4);
  factory Scalar.all(double val) => Scalar(val, val, val, val);
  factory Scalar.default_() => Scalar(
      double.maxFinite, double.maxFinite, double.maxFinite, double.maxFinite);
  factory Scalar.fromRgb(int r, int g, int b) {
    return Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
  }

  static final _finalizer =
      Finalizer<ffi.Pointer<cvg.Scalar>>((p0) => calloc.free(p0));
  double get val1 => _ptr.ref.val1;
  double get val2 => _ptr.ref.val2;
  double get val3 => _ptr.ref.val3;
  double get val4 => _ptr.ref.val4;

  ffi.Pointer<cvg.Scalar> _ptr;

  @override
  cvg.Scalar get ref => _ptr.ref;
  @override
  cvg.Scalar toNative() => _ptr.ref;
  @override
  List<Object?> get props => [val1, val2, val3, val4];

  static final Scalar red = Scalar.fromRgb(255, 0, 0);
  static final Scalar green = Scalar.fromRgb(0, 255, 0);
  static final Scalar blue = Scalar.fromRgb(0, 0, 255);
  static final Scalar black = Scalar.fromRgb(0, 0, 0);
  static final Scalar white = Scalar.fromRgb(255, 255, 255);
}
