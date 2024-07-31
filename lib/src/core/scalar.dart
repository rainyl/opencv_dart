import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:math' as math;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';

class Scalar extends CvStruct<cvg.Scalar> {
  Scalar._(ffi.Pointer<cvg.Scalar> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Scalar([double val1 = 0.0, double val2 = 0.0, double val3 = 0.0, double val4 = 0.0]) {
    final p = calloc<cvg.Scalar>()
      ..ref.val1 = val1
      ..ref.val2 = val2
      ..ref.val3 = val3
      ..ref.val4 = val4;
    return Scalar._(p);
  }
  factory Scalar.fromNative(cvg.Scalar s) => Scalar(s.val1, s.val2, s.val3, s.val4);
  factory Scalar.fromPointer(ffi.Pointer<cvg.Scalar> ptr, [bool attach = true]) => Scalar._(ptr, attach);
  factory Scalar.all(double val) => Scalar(val, val, val, val);
  factory Scalar.fromRgb(int r, int g, int b) => Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);

  Scalar operator +(Scalar other) {
    return Scalar(val1 + other.val1, val2 + other.val2, val3 + other.val3, val4 + other.val4);
  }

  Scalar operator -(Scalar other) {
    return Scalar(val1 - other.val1, val2 - other.val2, val3 - other.val3, val4 - other.val4);
  }

  Scalar operator *(Scalar other) {
    return Scalar(val1 * other.val1, val2 * other.val2, val3 * other.val3, val4 * other.val4);
  }

  Scalar operator /(Scalar other) {
    return Scalar(val1 / other.val1, val2 / other.val2, val3 / other.val3, val4 / other.val4);
  }

  Scalar sqrt() {
    return Scalar(math.sqrt(val1), math.sqrt(val2), math.sqrt(val3), math.sqrt(val4));
  }

  Scalar pow(int n) {
    return Scalar(
      math.pow(val1, n) as double,
      math.pow(val2, n) as double,
      math.pow(val3, n) as double,
      math.pow(val4, n) as double,
    );
  }

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get val1 => ref.val1;
  set val1(double value) => ref.val1 = value;

  double get val2 => ref.val2;
  set val2(double value) => ref.val2 = value;

  double get val3 => ref.val3;
  set val3(double value) => ref.val3 = value;

  double get val4 => ref.val4;
  set val4(double value) => ref.val4 = value;

  List<double> get val => [val1, val2, val3, val4];
  set val(List<double> value) {
    val1 = value[0];
    val2 = value[1];
    val3 = value[2];
    val4 = value[3];
  }

  @override
  cvg.Scalar get ref => ptr.ref;
  @override
  List<double> get props => [val1, val2, val3, val4];
  @override
  String toString() =>
      "Scalar(${val1.toStringAsFixed(3)}, ${val2.toStringAsFixed(3)}, ${val3.toStringAsFixed(3)}, ${val4.toStringAsFixed(3)})";

  static final Scalar red = Scalar.fromRgb(255, 0, 0);
  static final Scalar green = Scalar.fromRgb(0, 255, 0);
  static final Scalar blue = Scalar.fromRgb(0, 0, 255);
  static final Scalar black = Scalar.fromRgb(0, 0, 0);
  static final Scalar white = Scalar.fromRgb(255, 255, 255);
  static final Scalar zeros = Scalar.fromRgb(0, 0, 0);
  static final Scalar max = Scalar(double.maxFinite, double.maxFinite, double.maxFinite, double.maxFinite);
}

extension RecordScalarExtension on (double val1, double val2, double val3, double val4) {
  Scalar get asScalar => Scalar(this.$1, this.$2, this.$3, this.$4);
}

// async completer
void scalarCompleter(Completer<Scalar> completer, VoidPtr p) {
  completer.complete(Scalar.fromPointer(p.cast<cvg.Scalar>()));
}
