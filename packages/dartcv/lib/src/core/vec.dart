// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:collection';
import 'dart:convert';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../g/core.g.dart' as ccore;
import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'float16.dart';

abstract class Vec<N extends ffi.Struct, T> with IterableMixin<T> implements ffi.Finalizable {
  Vec.fromPointer(this.ptr);

  ffi.Pointer<N> ptr;
  N get ref;

  @override
  int get length;

  T operator [](int idx);
  void operator []=(int idx, T value);

  void dispose();
  Vec clone();
  int size();
  void add(T element);
  void resize(int newSize);
  void reserve(int newCapacity);
  void clear();
  void shrinkToFit();
  void extend(Vec other);

  ffi.Pointer<ffi.Void> asVoid();

  @override
  bool operator ==(Object other) {
    if (other is! Vec) return false;
    if (identical(this, other)) return true;
    if (length != other.length) return false;
    return hashCode == other.hashCode;
  }

  @override
  int get hashCode => ref.hashCode;
}

abstract class VecIterator<T> implements Iterator<T> {
  int currentIndex = -1;
  int get length;
  T operator [](int idx);

  @override
  T get current {
    if (currentIndex >= 0 && currentIndex < length) {
      return this[currentIndex];
    }
    throw IndexError.withLength(currentIndex, length);
  }

  @override
  bool moveNext() {
    if (currentIndex < length - 1) {
      currentIndex++;
      return true;
    }
    return false;
  }
}

abstract class VecUnmodifible<N extends ffi.Struct, T> extends Vec<N, T> {
  VecUnmodifible.fromPointer(super.ptr) : super.fromPointer();

  @override
  void operator []=(int idx, T value) => throw UnsupportedError("Unmodifiable Vec");

  @override
  void add(T element) => throw UnsupportedError("Unmodifiable Vec");
  @override
  void resize(int newSize) => throw UnsupportedError("Unmodifiable Vec");
  @override
  void reserve(int newCapacity) => throw UnsupportedError("Unmodifiable Vec");
  @override
  void clear() => throw UnsupportedError("Unmodifiable Vec");
  @override
  void shrinkToFit() => throw UnsupportedError("Unmodifiable Vec");
  @override
  void extend(Vec other) => throw UnsupportedError("Unmodifiable Vec");
}

class VecUChar extends Vec<cvg.VecUChar, int> {
  VecUChar.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.UnsignedChar>(),
      );
    }
  }

  factory VecUChar([int length = 0, int value = 0]) =>
      VecUChar.fromPointer(ccore.std_VecUChar_new_1(length, value), length: length);

  factory VecUChar.fromList(List<int> pts) {
    final length = pts.length;
    final p = ccore.std_VecUChar_new(length);
    final pdata = ccore.std_VecUChar_data(p);
    pdata.cast<U8>().asTypedList(length).setAll(0, pts);
    return VecUChar.fromPointer(p, length: pts.length);
  }

  factory VecUChar.generate(int length, int Function(int i) generator) {
    final p = ccore.std_VecUChar_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecUChar_set(p, i, generator(i));
    }
    return VecUChar.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecUCharPtr>(ccore.addresses.std_VecUChar_free);

  @override
  int get length => ccore.std_VecUChar_length(ptr);

  ffi.Pointer<ffi.UnsignedChar> get dataPtr => ccore.std_VecUChar_data(ptr);

  /// Returns a view of native pointer
  Uint8List get data => dataPtr.cast<ffi.Uint8>().asTypedList(length);
  Uint8List get dataView => dataPtr.cast<ffi.Uint8>().asTypedList(length);

  /// ~~alias of data~~
  ///
  /// This method will return a full copy of [data]
  ///
  /// https://github.com/rainyl/opencv_dart/issues/85
  Uint8List toU8List() => Uint8List.fromList(data);

  @override
  VecUChar clone() => VecUChar.fromPointer(ccore.std_VecUChar_clone(ptr));

  @override
  Iterator<int> get iterator => VecUCharIterator(dataView);

  @override
  cvg.VecUChar get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecUChar_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, int value) => ccore.std_VecUChar_set(ptr, idx, value);

  @override
  int operator [](int idx) => ccore.std_VecUChar_get(ptr, idx);

  @override
  void add(int element) => ccore.std_VecUChar_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecUChar_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecUChar_extend(ptr, (other as VecUChar).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecUChar_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecUChar_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecUChar_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecUChar_length(ptr);
}

class VecUCharIterator extends VecIterator<int> {
  VecUCharIterator(this.dataView);
  Uint8List dataView;

  @override
  int get length => dataView.length;

  @override
  int operator [](int idx) => dataView[idx];
}

class VecChar extends Vec<cvg.VecChar, int> {
  VecChar.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Char>(),
      );
    }
  }

  factory VecChar([int length = 0, int value = 0]) =>
      VecChar.fromPointer(ccore.std_VecChar_new_1(length, value), length: length);
  factory VecChar.fromList(List<int> pts) {
    final length = pts.length;
    final p = ccore.std_VecChar_new(length);
    final pdata = ccore.std_VecChar_data(p);
    pdata.cast<I8>().asTypedList(length).setAll(0, pts);
    return VecChar.fromPointer(p, length: pts.length);
  }

  factory VecChar.generate(int length, int Function(int i) generator) {
    final p = ccore.std_VecChar_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecChar_set(p, i, generator(i));
    }
    return VecChar.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecCharPtr>(ccore.addresses.std_VecChar_free);

  @override
  int get length => ccore.std_VecChar_length(ptr);

  ffi.Pointer<ffi.Char> get dataPtr => ccore.std_VecChar_data(ptr);

  Uint8List get data => dataPtr.cast<ffi.Uint8>().asTypedList(length);
  Int8List get dataView => dataPtr.cast<ffi.Int8>().asTypedList(length);

  String asString() => utf8.decode(data);

  @override
  VecChar clone() => VecChar.fromPointer(ccore.std_VecChar_clone(ptr));

  @override
  Iterator<int> get iterator => VecCharIterator(dataView);

  @override
  cvg.VecChar get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecChar_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, int value) => ccore.std_VecChar_set(ptr, idx, value);

  @override
  int operator [](int idx) => ccore.std_VecChar_get(ptr, idx);

  @override
  void add(int element) => ccore.std_VecChar_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecChar_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecChar_extend(ptr, (other as VecChar).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecChar_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecChar_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecChar_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecChar_length(ptr);
}

class VecCharIterator extends VecIterator<int> {
  VecCharIterator(this.dataView);
  Int8List dataView;

  @override
  int get length => dataView.length;

  @override
  int operator [](int idx) => dataView[idx];
}

class VecVecChar extends VecUnmodifible<cvg.VecVecChar, VecChar> {
  VecVecChar.fromPointer(super.ptr, {bool attach = true, int? externalSize}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this, externalSize: externalSize);
    }
  }

  factory VecVecChar([int length = 0]) => VecVecChar.fromPointer(ccore.std_VecVecChar_new(length));

  factory VecVecChar.fromList(List<List<int>> pts) => VecVecChar.generate(pts.length, (i) => pts[i]);

  factory VecVecChar.generate(int length, Iterable<int> Function(int i) generator) {
    final p = ccore.std_VecVecChar_new(length);
    int count = 0;
    for (var i = 0; i < length; i++) {
      final pts = generator(i);
      count += pts.length;
      final pp = ccore.std_VecChar_new(pts.length);
      final ppData = ccore.std_VecChar_data(pp);
      ppData.cast<I8>().asTypedList(pts.length).setAll(0, pts);
      ccore.std_VecVecChar_set(p, i, pp);
    }
    return VecVecChar.fromPointer(p, externalSize: count * ffi.sizeOf<ffi.Char>());
  }

  static final finalizer = OcvFinalizer<cvg.VecVecCharPtr>(ccore.addresses.std_VecVecChar_free);

  @override
  int get length => ccore.std_VecVecChar_length(ptr);

  List<String> asStringList() {
    return map(String.fromCharCodes).toList();
  }

  @override
  VecVecChar clone() => VecVecChar.fromPointer(ccore.std_VecVecChar_clone(ptr));

  @override
  Iterator<VecChar> get iterator => VecVecCharIterator(ptr);
  @override
  cvg.VecVecChar get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecVecChar_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => throw UnsupportedError('Not supported');

  /// Returns a **reference**
  ///
  /// Note: the memory of returned [VecChar] is owned by this [VecVecChar],
  /// explicitly call [VecChar.clone] if the parent [VecVecChar] may be disposed.
  @override
  VecChar operator [](int idx) => VecChar.fromPointer(ccore.std_VecVecChar_get(ptr, idx), attach: false);

  @override
  int size() => ccore.std_VecVecChar_length(ptr);
}

class VecVecCharIterator extends VecIterator<VecChar> {
  VecVecCharIterator(this.ptr);
  cvg.VecVecCharPtr ptr;

  @override
  int get length => ccore.std_VecVecChar_length(ptr);

  /// return the reference
  @override
  VecChar operator [](int idx) => VecChar.fromPointer(ccore.std_VecVecChar_get(ptr, idx), attach: false);
}

class VecU16 extends Vec<cvg.VecU16, int> {
  VecU16.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Uint16>(),
      );
    }
  }

  factory VecU16([int length = 0, int value = 0]) =>
      VecU16.fromPointer(ccore.std_VecU16_new_1(length, value), length: length);

  factory VecU16.fromList(List<int> pts) {
    final length = pts.length;
    final p = ccore.std_VecU16_new(length);
    final pdata = ccore.std_VecU16_data(p);
    pdata.asTypedList(length).setAll(0, pts);
    return VecU16.fromPointer(p, length: pts.length);
  }

  factory VecU16.generate(int length, int Function(int i) generator) {
    final p = ccore.std_VecU16_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecU16_set(p, i, generator(i));
    }
    return VecU16.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecU16Ptr>(ccore.addresses.std_VecU16_free);

  @override
  VecU16 clone() => VecU16.fromPointer(ccore.std_VecU16_clone(ptr));

  @override
  int get length => ccore.std_VecU16_length(ptr);

  ffi.Pointer<ffi.Uint16> get dataPtr => ccore.std_VecU16_data(ptr);

  Uint16List get data => dataPtr.cast<ffi.Uint16>().asTypedList(length);

  @override
  Iterator<int> get iterator => VecU16Iterator(data);
  @override
  cvg.VecU16 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecU16_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, int value) => data[idx] = value;

  @override
  int operator [](int idx) => data[idx];

  @override
  void add(int element) => ccore.std_VecU16_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecU16_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecU16_extend(ptr, (other as VecU16).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecU16_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecU16_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecU16_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecU16_length(ptr);
}

class VecU16Iterator extends VecIterator<int> {
  VecU16Iterator(this.data);
  Uint16List data;

  @override
  int get length => data.length;

  @override
  int operator [](int idx) => data[idx];
}

class VecI16 extends Vec<cvg.VecI16, int> {
  VecI16.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Int16>(),
      );
    }
  }

  factory VecI16([int length = 0, int value = 0]) =>
      VecI16.fromPointer(ccore.std_VecI16_new_1(length, value), length: length);

  factory VecI16.fromList(List<int> pts) {
    final length = pts.length;
    final p = ccore.std_VecI16_new(length);
    final pdata = ccore.std_VecI16_data(p);
    pdata.asTypedList(length).setAll(0, pts);
    return VecI16.fromPointer(p, length: pts.length);
  }

  factory VecI16.generate(int length, int Function(int i) generator) {
    final p = ccore.std_VecI16_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecI16_set(p, i, generator(i));
    }
    return VecI16.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecI16Ptr>(ccore.addresses.std_VecI16_free);

  @override
  VecI16 clone() => VecI16.fromPointer(ccore.std_VecI16_clone(ptr));

  @override
  int get length => ccore.std_VecI16_length(ptr);

  ffi.Pointer<ffi.Int16> get dataPtr => ccore.std_VecI16_data(ptr);

  Int16List get data => dataPtr.cast<ffi.Int16>().asTypedList(length);
  @override
  Iterator<int> get iterator => VecI16Iterator(data);
  @override
  cvg.VecI16 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecI16_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, int value) => data[idx] = value;

  @override
  int operator [](int idx) => data[idx];

  @override
  void add(int element) => ccore.std_VecI16_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecI16_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecI16_extend(ptr, (other as VecI16).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecI16_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecI16_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecI16_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecI16_length(ptr);
}

class VecI16Iterator extends VecIterator<int> {
  VecI16Iterator(this.data);
  Int16List data;

  @override
  int get length => data.length;

  @override
  int operator [](int idx) => data[idx];
}

class VecI32 extends Vec<cvg.VecI32, int> {
  VecI32.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Int32>(),
      );
    }
  }

  factory VecI32([int length = 0, int value = 0]) =>
      VecI32.fromPointer(ccore.std_VecI32_new_1(length, value), length: length);

  factory VecI32.fromList(List<int> pts) {
    final length = pts.length;
    final p = ccore.std_VecI32_new(length);
    final pdata = ccore.std_VecI32_data(p);
    pdata.asTypedList(length).setAll(0, pts);
    return VecI32.fromPointer(p, length: pts.length);
  }

  factory VecI32.generate(int length, int Function(int i) generator) {
    final p = ccore.std_VecI32_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecI32_set(p, i, generator(i));
    }
    return VecI32.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecI32Ptr>(ccore.addresses.std_VecI32_free);

  @override
  VecI32 clone() => VecI32.fromPointer(ccore.std_VecI32_clone(ptr));

  @override
  int get length => ccore.std_VecI32_length(ptr);

  ffi.Pointer<ffi.Int32> get dataPtr => ccore.std_VecI32_data(ptr);

  Int32List get data => dataPtr.cast<ffi.Int32>().asTypedList(length);

  @override
  Iterator<int> get iterator => VecI32Iterator(data);

  @override
  cvg.VecI32 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecI32_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, int value) => ccore.std_VecI32_set(ptr, idx, value);

  @override
  int operator [](int idx) => ccore.std_VecI32_get(ptr, idx);

  @override
  void add(int element) => ccore.std_VecI32_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecI32_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecI32_extend(ptr, (other as VecI32).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecI32_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecI32_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecI32_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecI32_length(ptr);
}

class VecI32Iterator extends VecIterator<int> {
  VecI32Iterator(this.data);
  Int32List data;

  @override
  int get length => data.length;

  @override
  int operator [](int idx) => data[idx];
}

class VecF32 extends Vec<cvg.VecF32, double> {
  VecF32.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Float>(),
      );
    }
  }

  factory VecF32([int length = 0, double value = 0.0]) =>
      VecF32.fromPointer(ccore.std_VecF32_new_1(length, value), length: length);
  factory VecF32.fromList(List<double> pts) {
    final length = pts.length;
    final p = ccore.std_VecF32_new(length);
    final pdata = ccore.std_VecF32_data(p);
    pdata.asTypedList(length).setAll(0, pts);
    return VecF32.fromPointer(p, length: pts.length);
  }

  factory VecF32.generate(int length, double Function(int i) generator) {
    final p = ccore.std_VecF32_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecF32_set(p, i, generator(i));
    }
    return VecF32.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecF32Ptr>(ccore.addresses.std_VecF32_free);

  @override
  VecF32 clone() => VecF32.fromPointer(ccore.std_VecF32_clone(ptr));

  @override
  int get length => ccore.std_VecF32_length(ptr);

  ffi.Pointer<ffi.Float> get dataPtr => ccore.std_VecF32_data(ptr);

  Float32List get data => dataPtr.cast<ffi.Float>().asTypedList(length);
  @override
  Iterator<double> get iterator => VecF32Iterator(data);
  @override
  cvg.VecF32 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecF32_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, double value) => ccore.std_VecF32_set(ptr, idx, value);

  @override
  double operator [](int idx) => ccore.std_VecF32_get(ptr, idx);

  @override
  void add(double element) => ccore.std_VecF32_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecF32_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecF32_extend(ptr, (other as VecF32).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecF32_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecF32_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecF32_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecF32_length(ptr);
}

class VecF32Iterator extends VecIterator<double> {
  VecF32Iterator(this.data);
  Float32List data;

  @override
  int get length => data.length;

  @override
  double operator [](int idx) => data[idx];
}

class VecF64 extends Vec<cvg.VecF64, double> {
  VecF64.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Double>(),
      );
    }
  }

  factory VecF64([int length = 0, double value = 0.0]) =>
      VecF64.fromPointer(ccore.std_VecF64_new_1(length, value), length: length);
  factory VecF64.fromList(List<double> pts) {
    final length = pts.length;
    final p = ccore.std_VecF64_new(length);
    final pdata = ccore.std_VecF64_data(p);
    pdata.asTypedList(length).setAll(0, pts);
    return VecF64.fromPointer(p, length: pts.length);
  }

  factory VecF64.generate(int length, double Function(int i) generator) {
    final p = ccore.std_VecF64_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecF64_set(p, i, generator(i));
    }
    return VecF64.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecF64Ptr>(ccore.addresses.std_VecF64_free);

  @override
  VecF64 clone() => VecF64.fromPointer(ccore.std_VecF64_clone(ptr));

  @override
  int get length => ccore.std_VecF64_length(ptr);

  ffi.Pointer<ffi.Double> get dataPtr => ccore.std_VecF64_data(ptr);

  Float64List get data => dataPtr.cast<ffi.Double>().asTypedList(length);

  @override
  Iterator<double> get iterator => VecF64Iterator(data);

  @override
  cvg.VecF64 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecF64_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, double value) => data[idx] = value;

  @override
  double operator [](int idx) => data[idx];

  @override
  void add(double element) => ccore.std_VecF64_push_back(ptr, element);

  @override
  void clear() => ccore.std_VecF64_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecF64_extend(ptr, (other as VecF64).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecF64_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecF64_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecF64_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecF64_length(ptr);
}

class VecF64Iterator extends VecIterator<double> {
  VecF64Iterator(this.data);
  Float64List data;

  @override
  int get length => data.length;

  @override
  double operator [](int idx) => data[idx];
}

class VecF16 extends Vec<cvg.VecF16, double> {
  VecF16.fromPointer(super.ptr, {bool attach = true, int? length}) : super.fromPointer() {
    if (attach) {
      finalizer.attach(
        this,
        ptr.cast<ffi.Void>(),
        detach: this,
        externalSize: length == null ? null : length * ffi.sizeOf<ffi.Uint16>(),
      );
    }
  }

  factory VecF16([int length = 0, double value = 0.0]) => VecF16.generate(length, (i) => value);

  // TODO: use setRange if dart ffi supports float16
  factory VecF16.fromList(List<double> pts) => VecF16.generate(pts.length, (i) => pts[i]);

  factory VecF16.generate(int length, double Function(int i) generator) {
    final p = ccore.std_VecF16_new(length);
    for (var i = 0; i < length; i++) {
      ccore.std_VecF16_set(p, i, generator(i).fp16);
    }
    return VecF16.fromPointer(p, length: length);
  }

  static final finalizer = OcvFinalizer<cvg.VecF16Ptr>(ccore.addresses.std_VecF16_free);

  @override
  VecF16 clone() => VecF16.fromPointer(ccore.std_VecF16_clone(ptr));

  @override
  int get length => ccore.std_VecF16_length(ptr);

  ffi.Pointer<ffi.Uint16> get dataPtr => ccore.std_VecF16_data(ptr);

  Uint16List get data => dataPtr.cast<ffi.Uint16>().asTypedList(length);
  Iterable<double> get dataFp16 => data.map(float16);

  @override
  Iterator<double> get iterator => VecF16Iterator(data);
  @override
  cvg.VecF16 get ref => ptr.ref;

  @override
  void dispose() {
    finalizer.detach(this);
    ccore.std_VecF16_free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => dataPtr.cast<ffi.Void>();

  @override
  void operator []=(int idx, double value) => ccore.std_VecF16_set(ptr, idx, value.fp16);

  @override
  double operator [](int idx) => ccore.std_VecF16_get(ptr, idx).fp16;

  @override
  void add(double element) => ccore.std_VecF16_push_back(ptr, element.fp16);

  @override
  void clear() => ccore.std_VecF16_clear(ptr);

  @override
  void extend(Vec other) => ccore.std_VecF16_extend(ptr, (other as VecF16).ptr);

  @override
  void reserve(int newCapacity) => ccore.std_VecF16_reserve(ptr, newCapacity);

  @override
  void resize(int newSize) => ccore.std_VecF16_resize(ptr, newSize);

  @override
  void shrinkToFit() => ccore.std_VecF16_shrink_to_fit(ptr);

  @override
  int size() => ccore.std_VecF16_length(ptr);
}

class VecF16Iterator extends VecIterator<double> {
  VecF16Iterator(this.data);
  Uint16List data;

  @override
  int get length => data.length;

  @override
  double operator [](int idx) => data[idx].fp16;
}

extension DoubleFp16Extension on double {
  int get fp16 => float16Inv(this);
}

extension IntFp16Extension on int {
  double get fp16 => float16(this);
}

extension StringVecExtension on String {
  VecUChar get u8 {
    return cvRunArena<VecUChar>((arena) {
      final p = toNativeUtf8(allocator: arena);
      final pp = p.cast<ffi.UnsignedChar>();
      final v = VecUChar.fromList(List.generate(p.length, (idx) => pp[idx]));
      return v;
    });
  }

  VecChar get i8 {
    return cvRunArena<VecChar>((arena) {
      final p = toNativeUtf8(allocator: arena);
      final pp = p.cast<ffi.Char>();
      final v = VecChar.fromList(List.generate(p.length, (idx) => pp[idx]));
      return v;
    });
  }
}

typedef VecU8 = VecUChar;
typedef VecI8 = VecChar;

extension ListUCharExtension on List<int> {
  VecUChar get vecUChar => VecUChar.fromList(this);
  VecChar get vecChar => VecChar.fromList(this);
  VecU8 get u8 => VecU8.fromList(this);
  VecI8 get i8 => VecI8.fromList(this);
  VecU16 get u16 => VecU16.fromList(this);
  VecI16 get i16 => VecI16.fromList(this);
  VecI32 get i32 => VecI32.fromList(this);
  VecF32 get f32 => VecF32.fromList(map((e) => e.toDouble()).toList());
  VecF64 get f64 => VecF64.fromList(map((e) => e.toDouble()).toList());
  VecF16 get f16 => VecF16.fromList(map((e) => e.toDouble()).toList());
}

extension ListListCharExtension on List<List<int>> {
  VecVecChar get vecVecChar => VecVecChar.fromList(this);
}

extension ListFloatExtension on List<double> {
  VecF32 get f32 => VecF32.fromList(this);
  VecF64 get f64 => VecF64.fromList(this);
  VecF16 get f16 => VecF16.fromList(this);
}

extension ListStringExtension on List<String> {
  VecVecChar get i8 => VecVecChar.fromList(map((e) => e.i8.toList()).toList());
}
