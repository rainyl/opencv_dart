import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/src/core/termcriteria.dart';
import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.Scalar', () {
    final s = cv.Scalar(0, 0, 0, 0);
    final s1 = cv.Scalar.default_();
    final s2 = cv.Scalar.zeros;
    expect(s, s1);
    expect(s, s2);

    final s3 = cv.Scalar.all(double.maxFinite);
    final s4 = cv.Scalar.max;
    expect(s3, s4);

    final s5 = using<cv.Scalar>((p0) {
      final p = (255.0, 0.0, 0.0, 0.0).toScalar(p0);
      return cv.Scalar.fromNative(p.ref);
    });
    expect(s5, cv.Scalar.blue);

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

      vec.dispose();
    }
    {
      final vec = cv.Vec2w(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2w(1, 2)");

      vec.dispose();
    }
    {
      final vec = cv.Vec2s(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2s(1, 2)");

      vec.dispose();
    }
    {
      final vec = cv.Vec2i(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2i(1, 2)");

      vec.dispose();
    }
    {
      final vec = cv.Vec2f(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2f(1.000, 2.000)");

      vec.dispose();
    }
    {
      final vec = cv.Vec2d(1, 2);
      expect(vec.val, [1, 2]);
      final vec1 = cv.Vec2d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec2d(1.000, 2.000)");

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

      vec.dispose();
    }
    {
      final vec = cv.Vec3w(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3w(1, 2, 3)");

      vec.dispose();
    }
    {
      final vec = cv.Vec3s(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3s(1, 2, 3)");

      vec.dispose();
    }
    {
      final vec = cv.Vec3i(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3i(1, 2, 3)");

      vec.dispose();
    }
    {
      final vec = cv.Vec3f(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3f(1.000, 2.000, 3.000)");

      vec.dispose();
    }
    {
      final vec = cv.Vec3d(1, 2, 3);
      expect(vec.val, [1, 2, 3]);
      final vec1 = cv.Vec3d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec3d(1.000, 2.000, 3.000)");

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

      vec.dispose();
    }
    {
      final vec = cv.Vec4w(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4w.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4w(1, 2, 3, 4)");

      vec.dispose();
    }
    {
      final vec = cv.Vec4s(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4s.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4s(1, 2, 3, 4)");

      vec.dispose();
    }
    {
      final vec = cv.Vec4i(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4i.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4i(1, 2, 3, 4)");

      vec.dispose();
    }
    {
      final vec = cv.Vec4f(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4f(1.000, 2.000, 3.000, 4.000)");

      vec.dispose();
    }
    {
      final vec = cv.Vec4d(1, 2, 3, 4);
      expect(vec.val, [1, 2, 3, 4]);
      final vec1 = cv.Vec4d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec4d(1.000, 2.000, 3.000, 4.000)");

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

      vec.dispose();
    }
    {
      final vec = cv.Vec6f(1, 2, 3, 4, 5, 6);
      expect(vec.val, [1, 2, 3, 4, 5, 6]);
      final vec1 = cv.Vec6f.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec6f(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");

      vec.dispose();
    }
    {
      final vec = cv.Vec6d(1, 2, 3, 4, 5, 6);
      expect(vec.val, [1, 2, 3, 4, 5, 6]);
      final vec1 = cv.Vec6d.fromNative(vec.ref);
      expect(vec1.val, vec.val);
      expect(vec1, vec);
      expect(vec.toString(), "Vec6d(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");

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

    vec.dispose();
  });

  test('cv.TermCriteria', () {
    final arena = Arena();
    const tc = (cv.TERM_COUNT, 10, 0.1);
    final tcNative = tc.toNativePtr(arena);
    final tc1 = tcNative.ref.toDart();
    expect(tc1, tc);
    expect(tc.type, cv.TERM_COUNT);
    expect(tc.count, 10);
    expect(tc.eps, closeTo(0.1, 1e-6));
    arena.releaseAll();
  });
}
