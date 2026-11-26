// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Sync vs async: what the worker thread costs and what it buys.
//
//   dart run benchmark/async_vs_sync.dart
//
// Both sides run the same OpenCV call on the same preallocated destination, so the difference is the
// call machinery and nothing else. The async side awaits every call, which is what a loop that needs
// the result does, and what keeps the single worker in order.
// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:math' as math;

import 'package:dartcv4/dartcv.dart' as cv;

const rounds = 5;

/// Median of [rounds] measurements of `iterations * body` calls, in microseconds per call.
Future<double> perCall(int iterations, Future<void> Function() body) async {
  final samples = <double>[];
  for (var r = 0; r < rounds; r++) {
    final watch = Stopwatch()..start();
    await body();
    samples.add(watch.elapsedMicroseconds / iterations);
  }
  samples.sort();
  return samples[samples.length ~/ 2];
}

String fmt(double us) => us >= 1000 ? '${(us / 1000).toStringAsFixed(2)} ms' : '${us.toStringAsFixed(1)} µs';

void main() async {
  print(
    'dartcv4 ${const String.fromEnvironment('version', defaultValue: '')}'
    'async threads: ${cv.getAsyncThreads()}\n',
  );

  // ---- 1. per-call overhead, tiny to heavy work ------------------------------------------------
  print('1) same call, same destination: sync (blocks) vs async (awaited)');
  print('${'work'.padRight(22)}${'sync'.padLeft(12)}${'async'.padLeft(12)}${'delta'.padLeft(12)}');
  for (final (label, size, kernel, iterations) in [
    ('8x8 k3 (pure overhead)', 8, 3, 2000),
    ('64x64 k3', 64, 3, 500),
    ('512x512 k31', 512, 31, 50),
    ('2000x2000 k31', 2000, 31, 5),
  ]) {
    final src = cv.Mat.fromScalar(size, size, cv.MatType.CV_8UC3, cv.Scalar.all(255));
    final dst = cv.Mat.empty();
    // warm up both paths (JIT, lazy statics, allocator)
    for (var i = 0; i < math.min(iterations, 100); i++) {
      cv.gaussianBlur(src, (kernel, kernel), 0, dst: dst);
      await cv.gaussianBlurAsync(src, (kernel, kernel), 0, dst: dst);
    }
    final sync = await perCall(iterations, () async {
      for (var i = 0; i < iterations; i++) {
        cv.gaussianBlur(src, (kernel, kernel), 0, dst: dst);
      }
    });
    final async = await perCall(iterations, () async {
      for (var i = 0; i < iterations; i++) {
        await cv.gaussianBlurAsync(src, (kernel, kernel), 0, dst: dst);
      }
    });
    print(
      '${label.padRight(22)}${fmt(sync).padLeft(12)}${fmt(async).padLeft(12)}'
      '${fmt(async - sync).padLeft(12)}',
    );
    src.dispose();
    dst.dispose();
  }

  // ---- 2. does the caller stay free? ----------------------------------------------------------
  print('\n2) caller blocking time for one 2000x2000 k31 call (the work takes ~10-30 ms)');
  {
    final src = cv.Mat.fromScalar(2000, 2000, cv.MatType.CV_8UC3, cv.Scalar.all(255));
    final dst = cv.Mat.empty();
    await cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst); // warm up

    var ticks = 0;
    final timer = Timer.periodic(const Duration(milliseconds: 1), (_) => ticks++);
    final watch = Stopwatch()..start();
    cv.gaussianBlur(src, (31, 31), 0, dst: dst);
    final syncBlocked = watch.elapsedMicroseconds;
    final syncTicks = ticks;
    ticks = 0;
    watch.reset();
    final pending = cv.gaussianBlurAsync(src, (31, 31), 0, dst: dst);
    final asyncReturned = watch.elapsedMicroseconds;
    final ticksWhileReturning = ticks;
    await pending;
    timer.cancel();
    print('  sync : caller blocked ${fmt(syncBlocked.toDouble())}, event-loop ticks meanwhile $syncTicks');
    print(
      '  async: caller blocked ${fmt(asyncReturned.toDouble())} (ticks $ticksWhileReturning), '
      'Future completed after ${fmt(watch.elapsedMicroseconds.toDouble())} with $ticks ticks',
    );
    src.dispose();
    dst.dispose();
  }

  // ---- 3. four independent calls: one worker vs four -------------------------------------------
  print('\n3) four independent 512x512 k31 calls (OpenCV already uses every core inside one call)');
  {
    final srcs = List.generate(4, (_) => cv.Mat.fromScalar(512, 512, cv.MatType.CV_8UC3, cv.Scalar.all(9)));
    final dsts = List.generate(4, (_) => cv.Mat.empty());
    Future<void> runAsync() async {
      await Future.wait([
        for (var i = 0; i < 4; i++) cv.gaussianBlurAsync(srcs[i], (31, 31), 0, dst: dsts[i]),
      ]);
    }

    for (var i = 0; i < 4; i++) {
      await cv.gaussianBlurAsync(srcs[i], (31, 31), 0, dst: dsts[i]);
    }
    final syncSeq = await perCall(1, () async {
      for (var i = 0; i < 4; i++) {
        cv.gaussianBlur(srcs[i], (31, 31), 0, dst: dsts[i]);
      }
    });
    final async1 = <double>[];
    for (var r = 0; r < rounds; r++) {
      final watch = Stopwatch()..start();
      await runAsync();
      async1.add(watch.elapsedMicroseconds.toDouble());
    }
    cv.setAsyncThreads(4);
    final async4 = <double>[];
    for (var r = 0; r < rounds; r++) {
      final watch = Stopwatch()..start();
      await runAsync();
      async4.add(watch.elapsedMicroseconds.toDouble());
    }
    cv.setAsyncThreads(1);
    async1.sort();
    async4.sort();
    print('  sync  x4 sequential : ${fmt(syncSeq)} total');
    print('  async x4 (1 worker): ${fmt(async1[async1.length ~/ 2])} total');
    print('  async x4 (4 workers): ${fmt(async4[async4.length ~/ 2])} total');
    for (final m in [...srcs, ...dsts]) {
      m.dispose();
    }
  }

  // ---- 4. batching: the roundtrip is paid per *await*, not per call ---------------------------
  print('\n4) 200 tiny calls (8x8 k3): the roundtrip is per await, not per call');
  {
    final src = cv.Mat.fromScalar(8, 8, cv.MatType.CV_8UC3, cv.Scalar.all(255));
    final dsts = List.generate(200, (_) => cv.Mat.empty());
    for (var i = 0; i < 200; i++) {
      await cv.gaussianBlurAsync(src, (3, 3), 0, dst: dsts[i]);
    }

    final sync = await perCall(200, () async {
      for (var i = 0; i < 200; i++) {
        cv.gaussianBlur(src, (3, 3), 0, dst: dsts[i]);
      }
    });
    final awaitEach = await perCall(200, () async {
      for (var i = 0; i < 200; i++) {
        await cv.gaussianBlurAsync(src, (3, 3), 0, dst: dsts[i]);
      }
    });
    final fireThenAwait = await perCall(200, () async {
      await Future.wait([
        for (var i = 0; i < 200; i++) cv.gaussianBlurAsync(src, (3, 3), 0, dst: dsts[i]),
      ]);
    });
    print('  sync loop                 : ${fmt(sync)}/call');
    print('  async, await each         : ${fmt(awaitEach)}/call');
    print('  async, fire then await all: ${fmt(fireThenAwait)}/call');
    src.dispose();
    for (final m in dsts) {
      m.dispose();
    }
  }

  cv.asyncDrain();
}
