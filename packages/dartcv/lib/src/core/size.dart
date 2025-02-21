// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';

class Size extends CvStruct<cvg.CvSize> {
  Size.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvSize>());
    }
  }

  factory Size(int width, int height) {
    final p = calloc<cvg.CvSize>()
      ..ref.height = height
      ..ref.width = width;
    return Size.fromPointer(p);
  }

  factory Size.fromNative(cvg.CvSize sz) => Size(sz.width, sz.height);

  factory Size.fromRecord((int, int) record) {
    final p = calloc<cvg.CvSize>()
      ..ref.height = record.$2
      ..ref.width = record.$1;
    return Size.fromPointer(p);
  }

  int get width => ref.width;
  set width(int value) => ref.width = value;

  int get height => ref.height;
  set height(int value) => ref.height = value;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<Object?> get props => [width, height];

  @override
  cvg.CvSize get ref => ptr.ref;

  @override
  String toString() {
    return "Size($width, $height)";
  }
}

class Size2f extends CvStruct<cvg.CvSize2f> {
  Size2f.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: ffi.sizeOf<cvg.CvSize2f>());
    }
  }

  factory Size2f(double width, double height) {
    final p = calloc<cvg.CvSize2f>()
      ..ref.height = height
      ..ref.width = width;
    return Size2f.fromPointer(p);
  }

  factory Size2f.fromNative(cvg.CvSize2f sz) => Size2f(sz.width, sz.height);

  factory Size2f.fromRecord((double, double) record) {
    final p = calloc<cvg.CvSize2f>()
      ..ref.height = record.$2
      ..ref.width = record.$1;
    return Size2f.fromPointer(p);
  }

  factory Size2f.fromSize(Size size) {
    final p = calloc<cvg.CvSize2f>()
      ..ref.height = size.height.toDouble()
      ..ref.width = size.width.toDouble();
    return Size2f.fromPointer(p);
  }

  double get width => ref.width;
  set width(double value) => ref.width = value;

  double get height => ref.height;
  set height(double value) => ref.height = value;

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  @override
  List<double> get props => [width, height];

  @override
  cvg.CvSize2f get ref => ptr.ref;

  @override
  String toString() {
    return "Size2f(${width.toStringAsFixed(3)}, ${height.toStringAsFixed(3)})";
  }
}

extension RecordSizeExtension1 on (int, int) {
  Size get cvd => toSize();
  Size toSize() => Size.fromRecord(this);
}

extension RecordSize2fExtension1 on (double, double) {
  Size2f get cvd => toSize2f();
  Size2f toSize2f() => Size2f.fromRecord(this);
}
