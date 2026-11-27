// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Refcount regressions in the handle wrappers: a handle that is created, used and released must not
// leave the C++ object alive (that is what a leak in `CVD_SET`/`CVD_FREE` or a stray `shared_ptr`
// copy looks like), and a handle that is still referenced must keep it alive.
//
// `liveObjectCount()` counts objects in the whole process, and `dart test` runs suites in parallel
// isolates, so the assertions here are deltas over a long loop (a leak would grow with the loop, a
// concurrently created object in another suite would not) rather than absolute zero.
import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  const iterations = 2000;

  int count() => cv.liveObjectCount();

  /// Runs [body] [iterations] times and returns the growth of the live-object count.
  int growthOver(void Function() body) {
    for (var i = 0; i < 200; i++) {
      body(); // warm up: lazy statics, allocator pools, finalizers
    }
    final before = count();
    for (var i = 0; i < iterations; i++) {
      body();
    }
    return count() - before;
  }

  test('disposing a Mat releases its native object', () {
    final grown = growthOver(() {
      final mat = cv.Mat.zeros(64, 64, cv.MatType.CV_8UC3);
      mat.dispose();
    });
    expect(
      grown.abs(),
      lessThan(iterations ~/ 4),
      reason:
          'live objects grew by $grown over $iterations create/dispose pairs; '
          'live now:\n${cv.liveObjectStats()}',
    );
  });

  test('an out-parameter handed a new value releases the old one', () {
    // `liveObjectStats()` fills a freshly created VecChar through CVD_SET, so a CVD_SET that did not
    // release the previous handle would grow by one vector per call.
    final grown = growthOver(() {
      expect(cv.liveObjectStats(), isNotEmpty);
    });
    expect(grown.abs(), lessThan(iterations ~/ 4), reason: 'live now:\n${cv.liveObjectStats()}');
  });

  test('vectors and their views release what they own', () {
    final outer = cv.VecVecPoint.fromList([
      [cv.Point(1, 2)],
      [cv.Point(3, 4)],
    ]);
    final grown = growthOver(() {
      final view = outer[0];
      expect(view.length, 1);
      view.dispose();
      final v = cv.VecPoint.fromList([cv.Point(7, 8)]);
      v.dispose();
    });
    outer.dispose();
    expect(grown.abs(), lessThan(iterations ~/ 4), reason: 'live now:\n${cv.liveObjectStats()}');
  });

  test('a view keeps its parent container alive', () {
    // The view shares the parent's control block, so dropping the parent while the view is held must
    // keep the inner vector usable.
    final outer = cv.VecVecPoint.fromList([
      [cv.Point(1, 2), cv.Point(3, 4)],
    ]);
    final view = outer[0];
    outer.dispose();
    expect(view.length, 2);
    expect((view[1].x, view[1].y), (3, 4));
    view.dispose();
  });

  test('a handle that is still referenced keeps its object counted', () {
    final mat = cv.Mat.zeros(8, 8, cv.MatType.CV_8UC1);
    final before = count();
    final copies = List.generate(200, (_) => mat.clone());
    // 200 objects, so a handful of concurrently finalized objects in another suite cannot hide them.
    expect(
      count() - before,
      greaterThan(100),
      reason: 'the copies should be alive; live now:\n${cv.liveObjectStats()}',
    );
    // each copy owns its own object, so they survive the original being released
    mat.dispose();
    for (final copy in copies) {
      expect(copy.at<int>(0, 0), 0);
      copy.dispose();
    }
  });
}
