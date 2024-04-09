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
}
