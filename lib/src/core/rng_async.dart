import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'base.dart';
import 'mat.dart';
import 'mat_async.dart';
import 'rng.dart';

extension RngAsync on Rng {
  static Future<Rng> createAsync() async => cvRunAsync(
        CFFI.Rng_New_Async,
        (completer, p) => completer.complete(Rng.fromTheRng(p.cast<cvg.RNG>())),
      );

  static Future<Rng> fromSeedAsync(int seed) async => cvRunAsync(
        (callback) => CFFI.Rng_NewWithState_Async(seed, callback),
        (completer, p) => completer.complete(Rng.fromTheRng(p.cast<cvg.RNG>())),
      );

  /// Fills arrays with random numbers.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad26f2b09d9868cf108e84c9814aa682d
  Future<Mat> fillAsync(
    Mat mat,
    int distType,
    double a,
    double b, {
    bool saturateRange = false,
    bool inplace = false,
  }) async {
    if (inplace) {
      return cvRunAsync0<Mat>(
        (callback) => CFFI.RNG_Fill_Async(ref, mat.ref, distType, a, b, saturateRange, callback),
        (c) => c.complete(mat),
      );
    } else {
      final m = await mat.cloneAsync();
      return cvRunAsync0<Mat>(
        (callback) => CFFI.RNG_Fill_Async(ref, m.ref, distType, a, b, saturateRange, callback),
        (c) => c.complete(m),
      );
    }
  }

  /// The method transforms the state using the MWC algorithm and returns
  /// the next random number from the Gaussian distribution N(0,sigma) .
  /// That is, the mean value of the returned random numbers is zero and
  /// the standard deviation is the specified sigma .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8df8ce4dc7d15916cee743e5a884639d
  Future<double> gaussianAsync(double sigma) async => cvRunAsync(
        (callback) => CFFI.RNG_Gaussian_Async(ref, sigma, callback),
        doubleCompleter,
      );

  /// The method updates the state using the MWC algorithm and returns the next 32-bit random number.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad8d035897a5e31e7fc3e1e6c378c32f5
  Future<int> nextAsync() async => cvRunAsync(
        (callback) => CFFI.RNG_Next_Async(ref, callback),
        (c, p) {
          final rval = p.cast<ffi.Uint32>().value;
          calloc.free(p);
          c.complete(rval);
        },
      );

  /// returns uniformly distributed integer random number from [a,b) range
  /// The methods transform the state using the MWC algorithm and return the next
  /// uniformly-distributed random number of the specified type, deduced from
  /// the input parameter type, from the range [a, b) .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8325cc562269b47bcac2343639b6fafc
  Future<T> uniformAsync<T>(T a, T b) async {
    if (T == int) {
      final rval =
          cvRunAsync((callback) => CFFI.RNG_Uniform_Async(ref, a as int, b as int, callback), intCompleter);
      return rval as Future<T>;
    } else if (T == double) {
      final rval = cvRunAsync(
        (callback) => CFFI.RNG_UniformDouble_Async(ref, a as double, b as double, callback),
        doubleCompleter,
      );
      return rval as Future<T>;
    } else {
      throw UnsupportedError("Unsupported type $T");
    }
  }
}
