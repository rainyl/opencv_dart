// Copyright (c) 2025, Rainyl. All rights reserved. Use of this source code is governed by a
// Apache 2.0 license that can be found in the LICENSE file.

// Tests for the *reference view* returned by `VecVecPoint*/[i]`.
//
// Design: `std_VecVecPoint*_get_p` aliases the inner vector of the parent
// container (mutations propagate to the parent), and the returned wrapper is a
// GC-managed view whose `dispose()` is a safe no-op. The wrapper struct is
// calloc'd so the GC can free it without touching the aliased vector.
// See also the C++ `std_VecVecPoint*_get_p` implementations in stdvec.cpp.

import 'package:dartcv4/core.dart' as cv;
import 'package:test/test.dart';

void main() {
  group('VecVecPoint reference view', () {
    test('mutations through the view are synced to the parent', () {
      final vvp = cv.VecVecPoint.fromList([
        [cv.Point(1, 2), cv.Point(3, 4)],
        [cv.Point(5, 6)],
      ]);
      final v0 = vvp[0];
      expect(v0.length, 2);

      v0[0] = cv.Point(10, 20);
      expect(vvp[0][0].x, 10);
      expect(vvp[0][0].y, 20);

      v0.add(cv.Point(7, 8));
      expect(v0.length, 3);
      expect(vvp[0].length, 3);
      vvp.dispose();
    });

    test('dispose() on the view is a safe no-op', () {
      final vvp = cv.VecVecPoint.fromList([
        [cv.Point(1, 2), cv.Point(3, 4)],
        [cv.Point(5, 6)],
      ]);
      final v1 = vvp[1];
      v1.dispose();
      // parent is unaffected and the view handle stays usable
      expect(vvp[1].length, 1);
      expect(v1.length, 1);
      vvp.dispose();
    });

    test('disposing the parent with outstanding views is safe', () {
      final vvp = cv.VecVecPoint.fromList([
        [cv.Point(1, 2), cv.Point(3, 4)],
        [cv.Point(5, 6)],
      ]);
      final v = vvp[0];
      v.add(cv.Point(9, 9));
      vvp.dispose();
    });

    test('Point2f reference view', () {
      final vvp = cv.VecVecPoint2f.fromList([
        [cv.Point2f(1.5, 2.5)],
      ]);
      final v = vvp[0];
      v[0] = cv.Point2f(9.5, 8.5);
      expect(vvp[0][0].x, 9.5);
      expect(vvp[0][0].y, 8.5);
      v.add(cv.Point2f(3.5, 4.5));
      expect(vvp[0].length, 2);
      v.dispose();
      expect(vvp[0].length, 2);
      vvp.dispose();
    });

    test('Point3f reference view', () {
      final vvp = cv.VecVecPoint3f.fromList([
        [cv.Point3f(1, 2, 3)],
      ]);
      final v = vvp[0];
      v[0] = cv.Point3f(7, 8, 9);
      expect(vvp[0][0].x, 7);
      expect(vvp[0][0].y, 8);
      expect(vvp[0][0].z, 9);
      v.dispose();
      expect(vvp[0].length, 1);
      vvp.dispose();
    });
  });
}
