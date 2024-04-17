import 'dart:ffi';

import 'package:ffi/ffi.dart';
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
  });

  test('cv.Vec6i', () {
    final vec = cv.Vec6i(1, 2, 3, 4, 5, 6);
    expect(vec.val, [1, 2, 3, 4, 5, 6]);
    final vec1 = cv.Vec6i.fromNative(vec.ref);
    expect(vec1.val, vec.val);
    expect(vec.toString(), "Vec6i(1, 2, 3, 4, 5, 6)");
  });

  test('cv.Vec6f', () {
    final vec = cv.Vec6f(1, 2, 3, 4, 5, 6);
    expect(vec.val, [1, 2, 3, 4, 5, 6]);
    final vec1 = cv.Vec6f.fromNative(vec.ref);
    expect(vec1.val, vec.val);
    expect(vec.toString(), "Vec6f(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");
  });

  test('cv.Vec6d', () {
    final vec = cv.Vec6d(1, 2, 3, 4, 5, 6);
    expect(vec.val, [1, 2, 3, 4, 5, 6]);
    final vec1 = cv.Vec6d.fromNative(vec.ref);
    expect(vec1.val, vec.val);
    expect(vec.toString(), "Vec6d(1.000, 2.000, 3.000, 4.000, 5.000, 6.000)");
  });

  test('cv.Vec8i', () {
    final vec = cv.Vec8i(1, 2, 3, 4, 5, 6, 7, 8);
    expect(vec.val, [1, 2, 3, 4, 5, 6, 7, 8]);
    final vec1 = cv.Vec8i.fromNative(vec.ref);
    expect(vec1.val, vec.val);
    expect(vec.toString(), "Vec8i(1, 2, 3, 4, 5, 6, 7, 8)");
  });
}
