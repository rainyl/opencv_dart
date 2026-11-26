// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Web stand-in for the subset of `package:ffi` that dartcv uses (calloc, malloc, Arena, Utf8).
// ignore_for_file: public_member_api_docs

import 'dart:async';
import 'dart:convert';

import 'ffi.dart';
import 'runtime.dart' as rt;

final class MallocAllocator implements Allocator {
  const MallocAllocator._();

  Pointer<NativeFinalizerFunction> get nativeFree => Pointer.fromAddress(rt.addressOf('free', 'vi'));

  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) =>
      Pointer.fromAddress(rt.malloc(byteCount));

  @override
  void free(Pointer pointer) => rt.free(pointer.address);
}

final class CallocAllocator implements Allocator {
  const CallocAllocator._();

  Pointer<NativeFinalizerFunction> get nativeFree => Pointer.fromAddress(rt.addressOf('free', 'vi'));

  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    final p = rt.malloc(byteCount);
    rt.bytes.fillRange(p, p + byteCount, 0);
    return Pointer.fromAddress(p);
  }

  @override
  void free(Pointer pointer) => rt.free(pointer.address);
}

const MallocAllocator malloc = MallocAllocator._();
const CallocAllocator calloc = CallocAllocator._();

class Arena implements Allocator {
  Arena([Allocator wrappedAllocator = calloc]) : _wrapped = wrappedAllocator;

  final Allocator _wrapped;
  final _allocations = <Pointer>[];
  final _cleanups = <void Function()>[];

  @override
  Pointer<T> allocate<T extends NativeType>(int byteCount, {int? alignment}) {
    final p = _wrapped.allocate<T>(byteCount, alignment: alignment);
    _allocations.add(p);
    return p;
  }

  T using<T>(T resource, void Function(T) releaseCallback) {
    _cleanups.add(() => releaseCallback(resource));
    return resource;
  }

  void onReleaseAll(void Function() releaseResourceCallback) => _cleanups.add(releaseResourceCallback);

  void releaseAll({bool reuse = false}) {
    for (final c in _cleanups.reversed) {
      c();
    }
    _cleanups.clear();
    for (final p in _allocations) {
      _wrapped.free(p);
    }
    _allocations.clear();
  }

  @override
  void free(Pointer pointer) {}
}

R using<R>(R Function(Arena) computation, [Allocator wrappedAllocator = calloc]) {
  final arena = Arena(wrappedAllocator);
  var isAsync = false;
  try {
    final result = computation(arena);
    if (result is Future) {
      isAsync = true;
      return result.whenComplete(arena.releaseAll) as R;
    }
    return result;
  } finally {
    if (!isAsync) arena.releaseAll();
  }
}

final class Utf8 extends Opaque {}

extension Utf8Pointer on Pointer<Utf8> {
  int get length => rt.cStringLength(address);

  String toDartString({int? length}) => rt.readCString(address, length);
}

extension StringUtf8Pointer on String {
  Pointer<Utf8> toNativeUtf8({Allocator allocator = malloc}) {
    final units = utf8.encode(this);
    final p = allocator.allocate<Utf8>(units.length + 1);
    final m = rt.bytes;
    m.setRange(p.address, p.address + units.length, units);
    m[p.address + units.length] = 0;
    return p;
  }
}
