// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Tests for the struct values that records pass to native functions.
//
// `(w, h).cvd.ref` is a view of the native memory of a temporary `Size`. Nothing
// keeps the wrapper alive, so a GC before the native call copies the struct runs
// its finalizer and the call reads freed memory. `cvdRef`/`pointRef` build the
// struct on the Dart heap instead, which no finalizer can free.

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

/// Allocates enough garbage for several young-generation GCs, and reuses the
/// small native blocks a finalizer may have freed.
void churn() {
  var keep = <List<int>>[];
  for (var i = 0; i < 200000; i++) {
    keep.add(List<int>.filled(16, i));
    if (keep.length > 1000) keep = [];
    cv.Size(1, 2);
  }
}

void main() {
  test('record struct values keep their fields across GCs', () {
    for (var round = 0; round < 20; round++) {
      final size = (600, 400).cvdRef;
      final point = (-1, 7).pointRef;
      final criteria = (cv.TERM_COUNT + cv.TERM_EPS, 30, 1e-4).cvdRef;
      churn();
      expect((size.width, size.height), (600, 400));
      expect((point.x, point.y), (-1, 7));
      expect((criteria.type, criteria.maxCount, criteria.epsilon), (cv.TERM_COUNT + cv.TERM_EPS, 30, 1e-4));
    }
  });

  test('native calls read the sizes they were given', () {
    final src = cv.Mat.zeros(40, 60, cv.MatType.CV_8UC3);
    final m = cv.getRotationMatrix2D(cv.Point2f(30, 20), 10, 1);
    for (var i = 0; i < 2000; i++) {
      final warped = cv.warpAffine(src, m, (61, 41));
      final resized = cv.resize(src, (31, 17));
      expect((warped.cols, warped.rows, resized.cols, resized.rows), (61, 41, 31, 17));
      warped.dispose();
      resized.dispose();
    }
  });
}
