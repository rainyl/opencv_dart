import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

class Scalar extends CvStruct<cvg.Scalar> {
  Scalar._(ffi.Pointer<cvg.Scalar> ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  factory Scalar(double val1, double val2, double val3, double val4) {
    final p = calloc<cvg.Scalar>()
      ..ref.val1 = val1
      ..ref.val2 = val2
      ..ref.val3 = val3
      ..ref.val4 = val4;
    return Scalar._(p);
  }
  factory Scalar.fromNative(cvg.Scalar s) => Scalar(s.val1, s.val2, s.val3, s.val4);
  factory Scalar.all(double val) => Scalar(val, val, val, val);
  factory Scalar.default_() => Scalar(0.0, 0.0, 0.0, 0.0);
  factory Scalar.fromRgb(int r, int g, int b) {
    return Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
  }

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);
  double get val1 => ptr.ref.val1;
  double get val2 => ptr.ref.val2;
  double get val3 => ptr.ref.val3;
  double get val4 => ptr.ref.val4;

  @override
  cvg.Scalar get ref => ptr.ref;
  @override
  List<Object?> get props => [val1, val2, val3, val4];
  @override
  String toString() {
    return "Scalar($val1, $val2, $val3, $val4)";
  }

  static final Scalar red = Scalar.fromRgb(255, 0, 0);
  static final Scalar green = Scalar.fromRgb(0, 255, 0);
  static final Scalar blue = Scalar.fromRgb(0, 0, 255);
  static final Scalar black = Scalar.fromRgb(0, 0, 0);
  static final Scalar white = Scalar.fromRgb(255, 255, 255);
  static final Scalar zeros = Scalar.fromRgb(0, 0, 0);
  static final Scalar max =
      Scalar(double.maxFinite, double.maxFinite, double.maxFinite, double.maxFinite);
}

extension RecordScalarExtension on (double val1, double val2, double val3, double val4) {
  ffi.Pointer<cvg.Scalar> toScalar(Arena arena) {
    final scalar = arena<cvg.Scalar>()
      ..ref.val1 = this.$1
      ..ref.val2 = this.$2
      ..ref.val3 = this.$3
      ..ref.val4 = this.$4;
    return scalar;
  }
}
