import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/src/core/point.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

extension ListIntExtension on List<int> {
  ffi.Pointer<cvg.IntVector> toNativeVector(Arena arena) {
    final intArray = arena<ffi.Int>(length);
    for (var i = 0; i < this.length; i++) {
      intArray[i] = this[i];
    }
    final vec = arena<cvg.IntVector>()
      ..ref.val = intArray
      ..ref.length = length;
    return vec;
  }
}

extension ListDoubleExtension on List<double> {
  ffi.Pointer<cvg.FloatVector> toNativeVector(Arena arena) {
    final array = arena<ffi.Float>(length);
    for (var i = 0; i < this.length; i++) {
      array[i] = this[i];
    }
    final vec = arena<cvg.FloatVector>()
      ..ref.val = array
      ..ref.length = length;
    return vec;
  }
}

extension RecordScalarExtension on ({double val0, double val1, double val2, double val3}) {
  ffi.Pointer<cvg.Scalar> toScalar(Arena arena) {
    final scalar = arena<cvg.Scalar>()
      ..ref.val1 = this.val0
      ..ref.val2 = this.val1
      ..ref.val3 = this.val2
      ..ref.val4 = this.val3;
    return scalar;
  }
}

extension RecordSizeExtension on ({int width, int height}) {
  ffi.Pointer<cvg.Size> toSize(Arena arena) {
    final size = arena<cvg.Size>()
      ..ref.width = this.width
      ..ref.height = this.height;
    return size;
  }
}

extension RecordSizeExtension1 on Size {
  ffi.Pointer<cvg.Size> toSize(Arena arena) {
    final size = arena<cvg.Size>()
      ..ref.width = this.$1
      ..ref.height = this.$2;
    return size;
  }
}

extension RecordPointExtension on ({int x, int y}) {
  ffi.Pointer<cvg.Point> toPoint(Arena arena) {
    final point = arena<cvg.Point>()
      ..ref.x = this.x
      ..ref.y = this.y;
    return point;
  }
}
