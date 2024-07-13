import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

import 'vec_matcher.dart';

void main() {
  test('cv.Scalar', () {
    final s = cv.Scalar(0, 0, 0, 0);
    final s1 = cv.Scalar();
    final s2 = cv.Scalar.zeros;
    expect(s, s1);
    expect(s, s2);

    final s3 = cv.Scalar.all(double.maxFinite);
    final s4 = cv.Scalar.max;
    expect(s3, s4);

    final s5 = (255.0, 0.0, 0.0, 0.0).asScalar;
    expect(s5, cv.Scalar.blue);

    s5.val = [2, 5, 4, 1];
    expect(s5.val, [2, 5, 4, 1]);

    s5.dispose();
  });

  test('cv.Scalar operations', () {
    final s = cv.Scalar(1, 2, 3, 4);
    final s1 = cv.Scalar(2, 4, 6, 8);
    final s3 = cv.Scalar(1, 4, 9, 16);

    expect(s + s1, cv.Scalar(3, 6, 9, 12));
    expect(s - s1, cv.Scalar(-1, -2, -3, -4));
    expect(s * s1, cv.Scalar(2, 8, 18, 32));
    expect(s / s1, cv.Scalar(0.5, 0.5, 0.5, 0.5));
    expect(s3.sqrt(), cv.Scalar(1, 2, 3, 4));
    expect(s.pow(2), cv.Scalar(1, 4, 9, 16));
  });

  test('cv.Vec2*', () {
    {
      final vec = cv.Vec2b(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2b.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2b(1, 2)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
    {
      final vec = cv.Vec2w(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2w(1, 2)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
    {
      final vec = cv.Vec2s(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2s(1, 2)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
    {
      final vec = cv.Vec2i(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2i(1, 2)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
    {
      final vec = cv.Vec2f(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2f(1.000, 2.000)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
    {
      final vec = cv.Vec2d(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2d(1.000, 2.000)");

      vec.val = [3, 4];
      expect(vec.val, [3, 4]);

      vec.dispose();
    }
  });

  test('cv.Vec3*', () {
    {
      final vec = cv.Vec3b(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3b.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3b(1, 2, 3)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
    {
      final vec = cv.Vec3w(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3w(1, 2, 3)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
    {
      final vec = cv.Vec3s(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3s(1, 2, 3)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
    {
      final vec = cv.Vec3i(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3i(1, 2, 3)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
    {
      final vec = cv.Vec3f(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3f(1.000, 2.000, 3.000)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
    {
      final vec = cv.Vec3d(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3d(1.000, 2.000, 3.000)");

      vec.val = [3, 4, 5];
      expect(vec.val, [3, 4, 5]);

      vec.dispose();
    }
  });

  test('cv.Vec4*', () {
    {
      final vec = cv.Vec4b(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4b.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4b(1, 2, 3, 4)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
    {
      final vec = cv.Vec4w(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4w(1, 2, 3, 4)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
    {
      final vec = cv.Vec4s(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4s(1, 2, 3, 4)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
    {
      final vec = cv.Vec4i(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4i(1, 2, 3, 4)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
    {
      final vec = cv.Vec4f(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4f(1.000, 2.000, 3.000, 4.000)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
    {
      final vec = cv.Vec4d(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4d(1.000, 2.000, 3.000, 4.000)");

      vec.val = [3, 4, 5, 6];
      expect(vec.val, [3, 4, 5, 6]);

      vec.dispose();
    }
  });

  test('cv.Vec6*', () {
    {
      final vec = cv.Vec6i(1, 2, 3, 4, 5, 6);
      expect(vec.val, [1, 2, 3, 4, 5, 6]);
      final vec1 = cv.Vec6i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec6i(1, 2, 3, 4, 5, 6)");

      vec.val = [3, 4, 5, 6, 7, 8];
      expect(vec.val, [3, 4, 5, 6, 7, 8]);

      vec.dispose();
    }
    {
      final vec = cv.Vec6f(1, 2, 3, 4, 5, 6);
      expect(vec.val, [1, 2, 3, 4, 5, 6]);
      final vec1 = cv.Vec6f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec6f(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");

      vec.val = [3, 4, 5, 6, 7, 8];
      expect(vec.val, [3, 4, 5, 6, 7, 8]);

      vec.dispose();
    }
    {
      final vec = cv.Vec6d(1, 2, 3, 4, 5, 6);
      expect(vec.val, [1, 2, 3, 4, 5, 6]);
      final vec1 = cv.Vec6d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec6d(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");

      vec.val = [3, 4, 5, 6, 7, 8];
      expect(vec.val, [3, 4, 5, 6, 7, 8]);

      vec.dispose();
    }
  });

  test('cv.Vec8i', () {
    final vec = cv.Vec8i(1, 2, 3, 4, 5, 6, 7, 8);
    expect(vec.val, [1, 2, 3, 4, 5, 6, 7, 8]);
    final vec1 = cv.Vec8i.fromNative(vec.ref);
    expect(vec1.val, vec.val);
    expect(vec1, vec);
    expect(vec.toString(), "Vec8i(1, 2, 3, 4, 5, 6, 7, 8)");

    vec.val = [3, 4, 5, 6, 7, 8, 9, 10];
    expect(vec.val, [3, 4, 5, 6, 7, 8, 9, 10]);

    vec.dispose();
  });

  test('cv.VecVec4i', () {
    final v = [
      cv.Vec4i(1, 2, 3, 4),
      cv.Vec4i(5, 6, 7, 8),
      cv.Vec4i(9, 10, 11, 12),
      cv.Vec4i(13, 14, 15, 16),
    ];
    final vv = v.cvd;
    expect(vv.length, v.length);
    expect(vv.first, cv.Vec4i(1, 2, 3, 4));
    expect(vv.last, cv.Vec4i(13, 14, 15, 16));

    // get the reference
    final vec = vv[1];
    expect(vec, cv.Vec4i(5, 6, 7, 8));
    // change the reference will affect the original value
    vec.val = [2, 5, 4, 1];
    expect(vec, cv.Vec4i(2, 5, 4, 1));
    // change the value
    vv[1] = cv.Vec4i(5, 2, 4, 1);
    expect(vv[1], cv.Vec4i(5, 2, 4, 1));

    final vv_ = vv.clone();
    expect(vv_, vecElementEquals(vv));

    vv.dispose();
  });

  test('cv.VecVec4f', () {
    final v = [
      cv.Vec4f(1, 2, 3, 4),
      cv.Vec4f(5, 6, 7, 8),
      cv.Vec4f(9, 10, 11, 12),
      cv.Vec4f(13, 14, 15, 16),
    ];
    final vv = v.cvd;
    expect(vv.length, v.length);
    expect(vv.first, cv.Vec4f(1, 2, 3, 4));
    expect(vv.last, cv.Vec4f(13, 14, 15, 16));

    // get the reference
    final vec = vv[1];
    expect(vec, cv.Vec4f(5, 6, 7, 8));
    // change the reference will affect the original value
    vec.val = [2, 5, 4, 1];
    expect(vec, cv.Vec4f(2, 5, 4, 1));
    // change the value
    vv[1] = cv.Vec4f(5, 2, 4, 1);
    expect(vv[1], cv.Vec4f(5, 2, 4, 1));

    final vv_ = vv.clone();
    expect(vv_, vecElementEquals(vv));

    vv.dispose();
  });

  test('cv.VecVec6f', () {
    final v = [
      cv.Vec6f(1, 2, 3, 4, 5, 6),
      cv.Vec6f(5, 6, 7, 8, 9, 10),
      cv.Vec6f(9, 10, 11, 12, 13, 14),
      cv.Vec6f(13, 14, 15, 16, 17, 18),
    ];
    final vv = v.cvd;
    expect(vv.length, v.length);
    expect(vv.first, cv.Vec6f(1, 2, 3, 4, 5, 6));
    expect(vv.last, cv.Vec6f(13, 14, 15, 16, 17, 18));

    // get the reference
    final vec = vv[1];
    expect(vec, cv.Vec6f(5, 6, 7, 8, 9, 10));
    // change the reference will affect the original value
    vec.val = [5, 2, 5, 4, 1, 0];
    expect(vec, cv.Vec6f(5, 2, 5, 4, 1, 0));
    // change the value
    vv[1] = cv.Vec6f(50, 20, 50, 40, 10, 0);
    expect(vv[1], cv.Vec6f(50, 20, 50, 40, 10, 0));

    final vv_ = vv.clone();
    expect(vv_, vecElementEquals(vv));

    vv.dispose();
  });

  test('cv.Size', () {
    const sz = (241, 241);
    final cvSize = sz.cvd;
    final cvSize1 = cv.Size.fromRecord(sz);
    expect(cvSize1, cvSize);

    cvSize1.dispose();
  });

  test('cv.Size2f', () {
    const sz0 = (241, 241);
    const sz = (241.0, 241.0);
    final cvSize = sz.cvd;
    final cvSize1 = cv.Size2f.fromRecord(sz);
    final cvSize2 = cv.Size2f.fromSize(sz0.cvd);
    expect(cvSize1, cvSize);
    expect(cvSize2.width, closeTo(sz0.$1, 1e-6));

    cvSize2.dispose();
  });

  test('cv.TermCriteria', () {
    const tc = (cv.TERM_COUNT, 10, 0.01);
    final cvTc = tc.cvd;
    expect(cvTc.type, tc.$1);
    expect(cvTc.maxCount, tc.$2);
    expect(cvTc.eps, closeTo(tc.$3, 1e-6));

    cvTc.dispose();
  });
}
