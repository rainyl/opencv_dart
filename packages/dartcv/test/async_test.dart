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

  test('a timeout abandons the wait but not the work, and says so', () async {
    final src = cv.Mat.fromScalar(1200, 1200, cv.MatType.CV_8UC3, cv.Scalar.all(255));
    final dst = cv.Mat.zeros(1200, 1200, cv.MatType.CV_8UC3);
    try {
      await cv.gaussianBlurAsync(
        src,
        (61, 61),
        0,
        dst: dst,
        timeout: const Duration(microseconds: 1),
      );
      fail('expected a timeout');
    } on cv.AsyncTimeoutException catch (e) {
      // The exception says the work continues and hands back the moment it stops writing.
      expect(e.elapsed, greaterThan(Duration.zero));
      expect(e.message, contains('not cancelled'));
      expect(e, isA<TimeoutException>(), reason: 'still catchable as a TimeoutException');
      // While the job runs, the object it writes is not safe to touch...
      await expectLater(Future(() => cv.mean(dst)), throwsA(isA<cv.CvException>()));
      await e.completion; // ...and this is the moment it is.
      expect(cv.mean(dst).val1, closeTo(255, 0.5), reason: 'the abandoned job did write dst');
    }
    src.dispose();
    dst.dispose();
  });

  test('a timeout on a call that owns its output writes nothing the caller holds', () async {
    final src = source();
    try {
      await cv.gaussianBlurAsync(src, (61, 61), 0, timeout: const Duration(microseconds: 1));
      fail('expected a timeout');
    } on cv.AsyncTimeoutException catch (e) {
      await e.completion;
    }
    src.dispose();
  });

  test('disposing arguments mid-flight is safe with several workers too', () async {
    // With more than one worker the deletion of a wrapper cannot simply be queued: another worker
    // could run it while the job still points at the handle. It is handed to the job that drops the
    // last reference instead, which is what this exercises.
    cv.setAsyncThreads(4);
    try {
      for (var round = 0; round < 20; round++) {
        final src = source();
        final dst = cv.Mat.empty();
        final pending = cv.gaussianBlurAsync(src, (21, 21), 0, dst: dst);
        src.dispose();
        dst.dispose();
        await pending;
      }
      cv.asyncDrain();
      expect(cv.asyncPending(), 0);
    } finally {
      cv.setAsyncThreads(1);
    }
  });

  test('a synchronous call on an in-flight object is refused, not raced', () async {
    final src = source();
    final dst = cv.Mat.empty();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
    await expectLater(
      // same dst, while the job is still writing it
      Future(() => cv.gaussianBlur(src, (5, 5), 0, dst: dst)),
      throwsA(isA<cv.CvException>()),
    );
    await pending; // the async call itself is unaffected
    // and synchronous calls work again once the Future is done
    cv.gaussianBlur(src, (5, 5), 0, dst: dst);
    src.dispose();
    dst.dispose();
  });

  test('a wrapper without an async twin is refused on an in-flight object too', () async {
    final src = source();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0);
    await expectLater(Future(src.release), throwsA(isA<cv.CvException>()));
    await pending;
    src.dispose();
  });

  test('an unrelated synchronous call is not refused', () async {
    final src = source();
    final other = cv.Mat.zeros(32, 32, cv.MatType.CV_8UC1);
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0);
    // a different object may be used synchronously while the job runs
    other.dispose();
    await pending;
    src.dispose();
  });

  test('every async twin completes (rowRange/colRange used to never call back)', () async {
    // Regression: these two C wrappers took a callback and never invoked it, so their Futures hung.
    final src = cv.Mat.zeros(64, 64, cv.MatType.CV_8UC1);
    final rows = await src.rowRangeAsync(0, 32).timeout(const Duration(seconds: 10));
    expect((rows.rows, rows.cols), (32, 64));
    final cols = await src.colRangeAsync(0, 32).timeout(const Duration(seconds: 10));
    expect((cols.rows, cols.cols), (64, 32));
    rows.dispose();
    cols.dispose();
    src.dispose();
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
