import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'mat.dart';
import '../opencv.g.dart' as cvg;

class Rng extends CvStruct<cvg.RNG> {
  Rng._(cvg.RNGPtr ptr, {bool attach = true}) : super.fromPointer(ptr) {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory Rng() {
    final p = calloc<cvg.RNG>();
    cvRun(() => cvg.Rng_New(p));
    final rng = Rng._(p);
    return rng;
  }

  factory Rng.fromTheRng(cvg.RNGPtr p) => Rng._(p);

  factory Rng.fromSeed(int seed) {
    final p = calloc<cvg.RNG>();
    cvRun(() => cvg.Rng_NewWithState(seed, p));
    final rng = Rng._(p);
    return rng;
  }

  static final finalizer = OcvFinalizer<cvg.RNGPtr>(ffi.Native.addressOf(cvg.Rng_Close));

  void dispose() {
    finalizer.detach(this);
    cvg.Rng_Close(ptr);
  }

  /// Fills arrays with random numbers.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad26f2b09d9868cf108e84c9814aa682d
  Mat fill(Mat mat, int distType, double a, double b,
      {bool saturateRange = false, bool inplace = false}) {
    if (inplace) {
      cvRun(() => cvg.RNG_Fill(ref, mat.ref, distType, a, b, saturateRange));
      return mat;
    } else {
      final m = mat.clone();
      cvRun(() => cvg.RNG_Fill(ref, m.ref, distType, a, b, saturateRange));
      return m;
    }
  }

  /// The method transforms the state using the MWC algorithm and returns
  /// the next random number from the Gaussian distribution N(0,sigma) .
  /// That is, the mean value of the returned random numbers is zero and
  /// the standard deviation is the specified sigma .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8df8ce4dc7d15916cee743e5a884639d
  double gaussian(double sigma) {
    return cvRunArena((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => cvg.RNG_Gaussian(ref, sigma, p));
      return p.value;
    });
  }

  /// The method updates the state using the MWC algorithm and returns the next 32-bit random number.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad8d035897a5e31e7fc3e1e6c378c32f5
  int next() {
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Uint32>();
      cvRun(() => cvg.RNG_Next(ref, p));
      return p.value;
    });
  }

  /// returns uniformly distributed integer random number from [a,b) range
  /// The methods transform the state using the MWC algorithm and return the next
  /// uniformly-distributed random number of the specified type, deduced from
  /// the input parameter type, from the range [a, b) .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8325cc562269b47bcac2343639b6fafc
  T uniform<T>(T a, T b) {
    return cvRunArena<T>((arena) {
      if (T == int) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.RNG_Uniform(ref, a as int, b as int, p));
        return p.value as T;
      } else if (T == double) {
        final p = arena<ffi.Double>();
        cvRun(() => cvg.RNG_UniformDouble(ref, a as double, b as double, p));
        return p.value as T;
      } else {
        throw UnsupportedError("Unsupported type $T");
      }
    });
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.RNG get ref => ptr.ref;
}
