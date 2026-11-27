// Copyright (c) 2026, Rainyl. All rights reserved. Use of this source code is governed by a
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

  /// Waits until no job is queued, running or finishing its bookkeeping.
  ///
  /// `asyncPending()` is decremented by the worker after it calls back, so it can still read 1 for a
  /// moment after the Future has completed; `asyncDrain()` waits for the native side, the loop for
  /// the counter.
  Future<void> waitUntilIdle() async {
    cv.asyncDrain();
    while (cv.asyncPending() > 0) {
      await Future<void>.delayed(Duration.zero);
    }
  }

  /// A small image whose pixels can be compared cheaply.
  cv.Mat small() => cv.Mat.fromScalar(64, 64, cv.MatType.CV_8UC1, cv.Scalar.all(7));

  test('an async call never throws synchronously', () {
    // `cvRunAsync0` runs `func` synchronously to hand the work over; when the native side rejects
    // that call the failure used to be rethrown here, which made `expect(() => xAsync(), throwsA(...))`
    // work on some calls and not others. It now always arrives through the returned future, so an
    // `*Async` wrapper can be a plain `return cvRunAsync*(...)` without `async`.
    late Future<void> pending;
    expect(
      () => pending = cv.cvRunAsync0<void>((cb) => throw StateError('rejected'), (c) => c.complete()),
      returnsNormally,
    );
    return expectLater(pending, throwsA(isA<StateError>()));
  });

  test('the call returns immediately and the event loop keeps running', () async {
    final src = cv.Mat.zeros(2400, 2400, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    await cv.gaussianBlurAsync(src, (11, 11), 0, dst: dst); // warm up
    await waitUntilIdle(); // the counter lags the callback, and it counts the whole process

    var ticks = 0;
    final timer = Timer.periodic(const Duration(milliseconds: 1), (_) => ticks++);
    final watch = Stopwatch()..start();
    final pending = cv.gaussianBlurAsync(src, (51, 51), 0, dst: dst);
    final callCost = watch.elapsed;
    final pendingWhileRunning = cv.asyncPending();
    await pending;
    timer.cancel();

    expect(
      callCost.inMilliseconds,
      lessThan(100),
      reason:
          'the work ran on the caller thread (${callCost.inMilliseconds} ms before the Future '
          'was even returned)',
    );
    // `asyncPending()` is one counter for the whole process and is decremented after the worker calls
    // back, while `dart test` runs suites in parallel isolates: assert that a job is queued, not an
    // exact count (the warm-up's bookkeeping, or a neighbouring suite's job, can still be counted).
    expect(pendingWhileRunning, greaterThanOrEqualTo(1), reason: 'the job was not handed to the pool');
    expect(ticks, greaterThan(0), reason: 'the event loop was blocked for the whole computation');
    await waitUntilIdle();
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
    await waitUntilIdle();
    expect(cv.asyncPending(), 0);
    src.dispose();
  });

  test('a failed job frees the block only a successful one hands over', () async {
    // dnn passes its `Net` out-parameter to a wrapper in the completion callback, so the failure path
    // has to free it itself (`releaseOnFailure`); freeing it from `release` as well would be a double
    // free, which aborts the process rather than failing an expectation.
    await expectLater(
      cv.NetAsync.fromFileAsync('no-such-model.onnx'),
      throwsA(isA<cv.CvException>()),
    );
    await waitUntilIdle();
  });

  test('a job that fails after a timeout is still freed exactly once', () async {
    // A timeout abandons the wait, not the job: nothing may be freed then, and the failure that
    // arrives afterwards has to run `releaseOnFailure` (this API hands its `Scalar` out-parameter to a
    // wrapper only on success). Freeing it twice would abort the process instead of failing here.
    final img = cv.Mat.zeros(16, 16, cv.MatType.CV_8UC1);
    addTearDown(img.dispose);
    // A missing model makes OpenCV log the whole path on every attempt.
    final logLevel = cv.getLogLevel();
    cv.setLogLevel(cv.LogLevel.SILENT);
    addTearDown(() => cv.setLogLevel(logLevel));
    try {
      await cv.QualityBRISQUE.compute1Async(
        'no-model.yml',
        'no-range.yml',
        img,
        timeout: const Duration(microseconds: 1),
      );
      fail('expected a timeout');
    } on cv.AsyncTimeoutException catch (e) {
      await e.completion; // the job has reported by now, and the block was freed once
    } on cv.CvException {
      // The job failed before the timer fired; the failure path is what this test is about anyway.
    }
    // The same call without a timeout still fails cleanly: nothing was double freed or corrupted.
    await expectLater(
      cv.QualityBRISQUE.compute1Async('no-model.yml', 'no-range.yml', img),
      throwsA(isA<cv.CvException>()),
    );
    await waitUntilIdle();
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
      await waitUntilIdle();
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
