import 'dart:ffi' as ffi;

import '../opencv.g.dart' as cvg;
import '../types/types.dart';
import '../types/mat.dart';

final _bindings = cvg.CvNative(loadNativeLibrary());

class Rng extends CvObject {
  Rng._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  factory Rng.fromPtr(cvg.RNG _ptr) {
    return Rng._(_ptr);
  }
  factory Rng.fromSeed(int seed) {
    final _ptr = _bindings.Rng_NewWithState(seed);
    return Rng._(_ptr);
  }

  cvg.RNG _ptr;
  cvg.RNG get ptr => _ptr;
  static final _finalizer = ffi.NativeFinalizer(_bindings.addresses.Rng_Close);

  Mat fill(Mat mat, int distType, double a, double b, bool saturateRange,
      {bool inplace = false}) {
    if (inplace) {
      _bindings.RNG_Fill(_ptr, mat.ptr, distType, a, b, saturateRange);
      return mat;
    } else {
      final m = mat.clone();
      _bindings.RNG_Fill(_ptr, m.ptr, distType, a, b, saturateRange);
      return m;
    }
  }

  double gaussian(double sigma) {
    return _bindings.RNG_Gaussian(_ptr, sigma);
  }

  int next() {
    return _bindings.RNG_Next(_ptr);
  }

  int uniform(int a, int b) {
    return _bindings.RNG_Uniform(_ptr, a, b);
  }

  double uniformDouble(double a, double b) {
    return _bindings.RNG_UniformDouble(_ptr, a, b);
  }

  @override
  ffi.NativeType get ref => throw UnimplementedError();

  @override
  ffi.NativeType toNative() {
    throw UnimplementedError();
  }
}
