import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/opencv_dart.dart';

import '../opencv.g.dart' as cvg;
import 'base.dart';

class Size extends CvStruct<cvg.Size> {
  Size.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Size(int width, int height) {
    final p = calloc<cvg.Size>()
      ..ref.height = height
      ..ref.width = width;
    return Size.fromPointer(p);
  }

  factory Size.fromRecord((int, int) record) {
    final p = calloc<cvg.Size>()
      ..ref.height = record.$2
      ..ref.width = record.$1;
    return Size.fromPointer(p);
  }

  int get width => ref.width;
  int get height => ref.height;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<Object?> get props => [width, height];

  @override
  cvg.Size get ref => ptr.ref;
}

class Size2f extends CvStruct<cvg.Size2f> {
  Size2f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory Size2f(double width, double height) {
    final p = calloc<cvg.Size2f>()
      ..ref.height = height
      ..ref.width = width;
    return Size2f.fromPointer(p);
  }

  factory Size2f.fromRecord((double, double) record) {
    final p = calloc<cvg.Size2f>()
      ..ref.height = record.$2
      ..ref.width = record.$1;
    return Size2f.fromPointer(p);
  }

  factory Size2f.fromSize(Size size) {
    final p = calloc<cvg.Size2f>()
      ..ref.height = size.height.toDouble()
      ..ref.width = size.width.toDouble();
    return Size2f.fromPointer(p);
  }

  double get width => ref.width;
  double get height => ref.height;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<Object?> get props => [width, height];

  @override
  cvg.Size2f get ref => ptr.ref;
}

extension RecordSizeExtension1 on (int, int) {
  Size toSize() => Size(this.$1, this.$2);
  Size get cvd => Size(this.$1, this.$2);
}

extension RecordSize2fExtension1 on (double, double) {
  Size2f toSize2f() => Size2f(this.$1, this.$2);
  Size2f get cvd => Size2f(this.$1, this.$2);
}
