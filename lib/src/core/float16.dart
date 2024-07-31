import 'dart:collection';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;

extension type Float16P(ffi.Pointer<ffi.Uint16> ptr) {
  double get value => float16(ptr.value);
  set value(double v) => ptr.value = float16Inv(v);

  int get address => ptr.address;

  double operator [](int index) => float16(ptr[index]);
  void operator []=(int index, double v) => ptr[index] = float16Inv(v);

  Float16List asTypedList(int length) => Float16List(this, length);
}

class Float16List with ListMixin<double> {
  final Float16P pointer;
  @override
  final int length;

  Float16List(this.pointer, this.length);

  @override
  double operator [](int index) {
    if (index >= 0 && index < length) {
      return pointer[index];
    }
    throw IndexError.withLength(index, length);
  }

  @override
  void operator []=(int index, double value) {
    if (index >= 0 && index < length) {
      pointer[index] = value;
    } else {
      throw IndexError.withLength(index, length);
    }
  }

  @override
  set length(int newLength) => throw UnsupportedError('Float16List does not support setting length');
}

double float16(int w) {
  final t = calloc<ffi.UnsignedInt>()..value = ((w & 0x7fff) << 13) + 0x38000000;
  final sign = calloc<ffi.UnsignedInt>()..value = (w & 0x8000) << 16;
  final e = calloc<ffi.UnsignedInt>()..value = w & 0x7c00;

  final out = calloc<cvg.Cv32suf_C>()..ref.u = t.value + (1 << 23);
  if (e.value >= 0x7c00) {
    out.ref.u = t.value + 0x38000000;
  } else {
    if (e.value == 0) {
      out.ref.f -= 6.103515625e-05;
    } else {
      out.ref.u = t.value;
    }
  }
  out.ref.u |= sign.value;
  final rval = out.ref.f;
  calloc.free(out);
  calloc.free(t);
  calloc.free(sign);
  calloc.free(e);
  return rval;
}

int float16Inv(double x) {
  final in_ = calloc<cvg.Cv32suf_C>()..ref.f = x;
  final sign = calloc<ffi.UnsignedInt>()..value = in_.ref.u & 0x80000000;
  final w = calloc<ffi.UnsignedInt>();
  in_.ref.u ^= sign.value;
  if (in_.ref.u > 0x47800000) {
    w.value = in_.ref.u > 0x7f800000 ? 0x7e00 : 0x7c00;
  } else {
    if (in_.ref.u < 0x38800000) {
      in_.ref.f += 0.5;
      w.value = in_.ref.u - 0x3f000000;
    } else {
      final t = calloc<ffi.UnsignedInt>()..value = in_.ref.u + 0xc8000fff;
      w.value = (t.value + ((in_.ref.u >> 13) & 1)) >> 13;
      calloc.free(t);
    }
  }
  final rval = w.value | (sign.value >> 16);
  calloc.free(in_);
  calloc.free(sign);
  calloc.free(w);
  return rval;
}

extension PointerUint16Extension on ffi.Pointer<ffi.Uint16> {
  Float16P asFp16() => Float16P(this);
}
