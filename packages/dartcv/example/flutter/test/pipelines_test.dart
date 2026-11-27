// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Every filter the image lab offers, on both code paths. This is the test that was missing when CLAHE
// was handed a three-channel image and OpenCV rejected it at runtime.
import 'package:dartcv4/dartcv.dart' as cv;
import 'package:dartcv_example/src/core/imaging.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  /// A small image with structure, so contrast/threshold/edge filters have something to find.
  cv.Mat sample() {
    final src = cv.Mat.fromScalar(180, 240, cv.MatType.CV_8UC3, cv.Scalar.fromRgb(30, 60, 120));
    final centre = cv.Point(120, 90);
    final light = cv.Scalar.fromRgb(240, 220, 200);
    final box = cv.Rect(10, 10, 80, 60);
    final dark = cv.Scalar.fromRgb(220, 30, 30);
    try {
      cv.circle(src, centre, 50, light, thickness: -1, lineType: cv.LINE_AA);
      cv.rectangle(src, box, dark, thickness: 2);
      return src;
    } finally {
      centre.dispose();
      light.dispose();
      box.dispose();
      dark.dispose();
    }
  }

  test('every pipeline produces a non-empty image, synchronously and on the worker thread', () async {
    final src = sample();
    addTearDown(src.dispose);

    for (final filter in LabFilter.values) {
      final sync = applyFilterSync(src, filter, amount: 0.5);
      expect(sync.isEmpty, isFalse, reason: '${filter.label} (${filter.api}) returned an empty Mat');
      // The filters that keep the pixel layout (CLAHE goes through LAB and back) must keep the size.
      expect((sync.cols, sync.rows), (src.cols, src.rows), reason: '${filter.label} changed the size');
      sync.dispose();

      final async = await applyFilterAsync(src, filter, amount: 0.5);
      expect(async.isEmpty, isFalse, reason: '${filter.label} async returned an empty Mat');
      expect(
        (async.cols, async.rows),
        (src.cols, src.rows),
        reason: '${filter.label} async changed the size',
      );
      async.dispose();
    }
  });

  test('the pipelines do not leak the handles they create', () async {
    final src = sample();
    addTearDown(src.dispose);
    // Warm up: the first call of each filter allocates lazily.
    for (final filter in LabFilter.values) {
      applyFilterSync(src, filter, amount: 0.5).dispose();
    }
    cv.asyncDrain();

    final before = cv.liveObjectCount();
    for (final filter in LabFilter.values) {
      for (var i = 0; i < 5; i++) {
        applyFilterSync(src, filter, amount: 0.5).dispose();
        (await applyFilterAsync(src, filter, amount: 0.5)).dispose();
      }
    }
    cv.asyncDrain();
    final grown = cv.liveObjectCount() - before;
    expect(
      grown,
      lessThan(LabFilter.values.length * 2),
      reason: 'a filter keeps its intermediate Mats alive: live now ${cv.liveObjectCount()}',
    );
  });
}
