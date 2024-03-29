import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

class Rng extends CvPtrVoid<cvg.RNG> {
  Rng._(cvg.RNG ptr, {bool attach = true}) : super.fromPointer(ptr) {
    if (attach) finalizer.attach(this, ptr);
  }

  factory Rng() {
    final p = calloc<cvg.RNG>();
    cvRun(() => CFFI.Rng_New(p));
    final rng = Rng._(p.value);
    calloc.free(p);
    return rng;
  }

  // cv::theRNG() is thread safe and will be automatically freed
  // so, don't attach again or will be double freed
  factory Rng.fromTheRng(cvg.RNG p) => Rng._(p, attach: false);

  factory Rng.fromSeed(int seed) {
    final p = calloc<cvg.RNG>();
    cvRun(() => CFFI.Rng_NewWithState(seed, p));
    final rng = Rng._(p.value);
    calloc.free(p);
    return rng;
  }

  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.Rng_Close);

  Mat fill(Mat mat, int distType, double a, double b, bool saturateRange, {bool inplace = false}) {
    if (inplace) {
      cvRun(() => CFFI.RNG_Fill(ptr, mat.ptr, distType, a, b, saturateRange));
      return mat;
    } else {
      final m = mat.clone();
      cvRun(() => CFFI.RNG_Fill(ptr, m.ptr, distType, a, b, saturateRange));
      return m;
    }
  }

  double gaussian(double sigma) {
    return cvRunArena((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.RNG_Gaussian(ptr, sigma, p));
      return p.value;
    });
  }

  int next() {
    return cvRunArena((arena) {
      final p = arena<ffi.Uint32>();
      cvRun(() => CFFI.RNG_Next(ptr, p));
      return p.value;
    });
  }

  T uniform<T>(T a, T b) {
    return cvRunArena<T>((arena) {
      if (T is int) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.RNG_Uniform(ptr, a as int, b as int, p));
        return p.value as T;
      } else if (T is double) {
        final p = arena<ffi.Double>();
        cvRun(() => CFFI.RNG_UniformDouble(ptr, a as double, b as double, p));
        return p.value as T;
      } else {
        throw UnsupportedError("Unsupported type $T");
      }
    });
  }

  @Deprecated("Use [uniform<T>] instead, will be removed in v1.0.0")
  double uniformDouble(double a, double b) {
    return cvRunArena<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.RNG_UniformDouble(ptr, a, b, p));
      return p.value;
    });
  }

  @override
  List<int> get props => [ptr.address];
}
