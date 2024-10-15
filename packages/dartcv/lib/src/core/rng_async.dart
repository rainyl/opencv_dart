// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import '../native_lib.dart' show ccore;
import 'base.dart';
import 'mat.dart';
import 'mat_async.dart';
import 'rng.dart';

extension RngAsync on Rng {
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
        (callback) => ccore.RNG_Fill_Async(ref, mat.ref, distType, a, b, saturateRange, callback),
        (c) => c.complete(mat),
      );
    } else {
      final m = await mat.cloneAsync();
      return cvRunAsync0<Mat>(
        (callback) => ccore.RNG_Fill_Async(ref, m.ref, distType, a, b, saturateRange, callback),
        (c) => c.complete(m),
      );
    }
  }
}
