// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Cross-cutting async semantics: the `*Async` APIs must not run on the caller's thread, must report
// their work's status through the Future, and must stay safe when the caller abandons the wait or
// disposes an argument while the job is still running.
import 'dart:async';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  setUpAll(() {
    // One worker keeps the assertions about ordering deterministic.
    cv.setAsyncThreads(1);
  });

  tearDownAll(cv.asyncDrain);

  /// An image big enough that a Gaussian blur takes tens of milliseconds.
  cv.Mat source() => cv.Mat.zeros(1200, 1200, cv.MatType.CV_8UC3);

  /// A small image whose pixels can be compared cheaply.
  cv.Mat small() => cv.Mat.fromScalar(64, 64, cv.MatType.CV_8UC1, cv.Scalar.all(7));

  test('the call returns immediately and the event loop keeps running', () async {
    final src = source();
    final dst = cv.Mat.empty();
    await cv.gaussianBlurAsync(src, (5, 5), 0, dst: dst); // warm up

    var ticks = 0;
    final timer = Timer.periodic(const Duration(milliseconds: 1), (_) => ticks++);
    final watch = Stopwatch()..start();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
    final callCost = watch.elapsed;
    await pending;
    timer.cancel();

    expect(
      callCost.inMilliseconds,
      lessThan(100),
      reason:
          'the work ran on the caller thread (${callCost.inMilliseconds} ms before the Future '
          'was even returned)',
    );
    expect(ticks, greaterThan(0), reason: 'the event loop was blocked for the whole computation');
    expect(cv.asyncPending(), 0);
    src.dispose();
    dst.dispose();
  });

  test('the work produces the same result as the synchronous call', () async {
    final src = small();
    final sync = cv.Mat.empty();
    final async = cv.Mat.empty();
    cv.gaussianBlur(src, (11, 11), 0, dst: sync);
    await cv.gaussianBlurAsync(src, (11, 11), 0, dst: async);
    expect(async.toList(), sync.toList());
    for (final m in [src, sync, async]) {
      m.dispose();
    }
  });

  test('a failure inside the job surfaces through the Future', () async {
    final src = source();
    // An even kernel is rejected by OpenCV inside the job, long after the entry point returned.
    await expectLater(
      cv.gaussianBlurAsync(src, (4, 4), 0),
      throwsA(isA<cv.CvException>()),
    );
    expect(cv.asyncPending(), 0);
    src.dispose();
  });

  test('disposing an argument while the job runs is safe', () async {
    final src = source();
    final dst = cv.Mat.empty();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
    // The job holds a reference to the object, so this must not pull the memory out from under it.
    src.dispose();
    await pending;
    expect(dst.isEmpty, isFalse);
    dst.dispose();
    cv.asyncDrain();
  });

  test('a timeout abandons the wait but not the work', () async {
    final src = source();
    final dst = cv.Mat.empty();
    await expectLater(
      cv.gaussianBlurAsync(src, (61, 61), 0, dst: dst, timeout: const Duration(microseconds: 1)),
      throwsA(isA<TimeoutException>()),
    );
    // The job still runs to completion; draining keeps the test from racing the next one.
    cv.asyncDrain();
    expect(cv.asyncPending(), 0);
    src.dispose();
    dst.dispose();
  });

  test('one worker keeps calls in order', () async {
    final src = small();
    final dsts = List.generate(3, (_) => cv.Mat.empty());
    await Future.wait([
      for (var i = 0; i < 3; i++) cv.gaussianBlurAsync(src, (2 * i + 3, 2 * i + 3), 0, dst: dsts[i]),
    ]);
    // Each result matches its own kernel, i.e. the jobs did not interleave their outputs.
    for (var i = 0; i < 3; i++) {
      final expected = cv.Mat.empty();
      cv.gaussianBlur(src, (2 * i + 3, 2 * i + 3), 0, dst: expected);
      expect(dsts[i].toList(), expected.toList());
      expected.dispose();
      dsts[i].dispose();
    }
    src.dispose();
  });
}
