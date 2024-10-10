// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'mat.dart';

class Rng extends CvStruct<cvg.RNG> {
  Rng._(cvg.RNGPtr ptr, {bool attach = true}) : super.fromPointer(ptr) {
    if (attach) finalizer.attach(this, ptr.cast(), detach: this);
  }

  factory Rng() {
    final p = calloc<cvg.RNG>();
    cvRun(() => ccore.Rng_New(p));
    final rng = Rng._(p);
    return rng;
  }

  factory Rng.fromTheRng(cvg.RNGPtr p) => Rng._(p);

  factory Rng.fromSeed(int seed) {
    final p = calloc<cvg.RNG>();
    cvRun(() => ccore.Rng_NewWithState(seed, p));
    final rng = Rng._(p);
    return rng;
  }

  static final finalizer = OcvFinalizer<cvg.RNGPtr>(ccore.addresses.Rng_Close);

  void dispose() {
    finalizer.detach(this);
    ccore.Rng_Close(ptr);
  }

  /// Fills arrays with random numbers.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad26f2b09d9868cf108e84c9814aa682d
  Mat fill(
    Mat mat,
    int distType,
    double a,
    double b, {
    bool saturateRange = false,
    bool inplace = false,
  }) {
    if (inplace) {
      cvRun(() => ccore.RNG_Fill(ref, mat.ref, distType, a, b, saturateRange));
      return mat;
    } else {
      final m = mat.clone();
      cvRun(() => ccore.RNG_Fill(ref, m.ref, distType, a, b, saturateRange));
      return m;
    }
  }

  /// The method transforms the state using the MWC algorithm and returns
  /// the next random number from the Gaussian distribution N(0,sigma) .
  /// That is, the mean value of the returned random numbers is zero and
  /// the standard deviation is the specified sigma .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8df8ce4dc7d15916cee743e5a884639d
  Stream<double> gaussian(double sigma, {int? maxCount}) async* {
    int count = 0;
    final p = calloc<ffi.Double>();
    try {
      while (true) {
        cvRun(() => ccore.RNG_Gaussian(ref, sigma, p));
        yield p.value;

        count++;
        if (maxCount != null && ++count >= maxCount) break;
      }
    } finally {
      calloc.free(p);
    }
  }

  /// The method updates the state using the MWC algorithm and returns the next 32-bit random number.
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#ad8d035897a5e31e7fc3e1e6c378c32f5
  Stream<int> next({int? maxCount}) async* {
    int count = 0;
    final p = calloc<ffi.Uint32>();
    try {
      while (true) {
        cvRun(() => ccore.RNG_Next(ref, p));
        yield p.value;

        count++;
        if (maxCount != null && ++count >= maxCount) break;
      }
    } finally {
      calloc.free(p);
    }
  }

  /// returns uniformly distributed integer random number from [a,b) range
  /// The methods transform the state using the MWC algorithm and return the next
  /// uniformly-distributed random number of the specified type, deduced from
  /// the input parameter type, from the range [a, b) .
  /// https://docs.opencv.org/4.x/d1/dd6/classcv_1_1RNG.html#a8325cc562269b47bcac2343639b6fafc
  Stream<num> uniform(num a, num b, {int? maxCount}) async* {
    int count = 0;

    if (a is int && b is int) {
      final p = calloc<ffi.Int>();
      try {
        while (true) {
          cvRun(() => ccore.RNG_Uniform(ref, a, b, p));
          yield p.value;

          count++;
          if (maxCount != null && ++count >= maxCount) break;
        }
      } finally {
        calloc.free(p);
      }
    } else {
      final p = calloc<ffi.Double>();
      try {
        while (true) {
          cvRun(() => ccore.RNG_UniformDouble(ref, a.toDouble(), b.toDouble(), p));
          yield p.value;

          count++;
          if (maxCount != null && ++count >= maxCount) break;
        }
      } finally {
        calloc.free(p);
      }
    }
  }

  @override
  cvg.RNG get ref => ptr.ref;
}
