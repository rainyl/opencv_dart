import 'dart:ffi';

import 'package:ffi/ffi.dart';
import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:opencv_dart/src/opencv.g.dart' as cvg;

void main() {
  test('Point', () {
    final point = cv.Point(1, 2);
    expect((point.x, point.y), (1, 2));
    expect(point.toString(), "Point(1, 2)");
    using((arena) {
      final cPoint = arena<cvg.Point>()
        ..ref.x = 1
        ..ref.y = 2;
      final p = cv.Point.fromNative(cPoint.ref);
      expect(p, cv.Point(1, 2));
      expect(p.ref.x, 1);
    });

    final point1 = cv.Point2f(1.50, 2.3);
    closeTo(point1.x, 1.50);
    closeTo(point1.y, 2.3);
    expect(point1.toString(), "Point2f(1.500, 2.300)");
    using((arena) {
      final cPoint = arena<cvg.Point2f>()
        ..ref.x = 1
        ..ref.y = 2;
      final p = cv.Point2f.fromNative(cPoint.ref);
      expect(p, cv.Point2f(1, 2));
      expect(p.ref.x, 1);
    });

    final point2 = cv.Point3f(1.50, 2.3, 3.4);
    closeTo(point2.x, 1.50);
    closeTo(point2.y, 2.3);
    closeTo(point2.z, 3.4);
    expect(point2.toString(), "Point3f(1.500, 2.300, 3.400)");
    using((arena) {
      final cPoint = arena<cvg.Point3f>()
        ..ref.x = 1
        ..ref.y = 2
        ..ref.z = 3;
      final p = cv.Point3f.fromNative(cPoint.ref);
      expect(p, cv.Point3f(1, 2, 3));
      expect(p.ref.x, 1);
    });
  });

  test('VecPoint', () {
    final vec = <cv.Point>[].ocv;
    expect(vec.length, 0);

    final points = [cv.Point(1, 2), cv.Point(3, 4), cv.Point(5, 6), cv.Point(7, 8)];
    final vec1 = points.ocv;
    expect(vec1.length, 4);
    expect(vec1.first, cv.Point(1, 2));
    expect(vec1.last, cv.Point(7, 8));
  });

  test('VecPoint.fromMat', () {
    final points = [cv.Point(1, 2), cv.Point(3, 4), cv.Point(5, 6), cv.Point(7, 8)];
    final mat = cv.Mat.fromVec(points.ocv);

    final vec = cv.VecPoint.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecPoint2f', () {
    final vec = <cv.Point2f>[].ocv;
    expect(vec.length, 0);

    final points = [cv.Point2f(1, 2), cv.Point2f(3, 4), cv.Point2f(5, 6), cv.Point2f(7, 8)];
    final vec1 = points.ocv;
    expect(vec1.length, 4);
    expect(vec1.first, points.first);
    expect(vec1.last, points.last);

    final points1 = cv.VecPoint2f(10, 1, 1);
    expect(points1.length, 10);
    expect(points1.first, cv.Point2f(1, 1));

    final points2 = cv.VecPoint2f();
    expect(points2.length, 0);
    expect(points2.firstOrNull, null);
  });

  test('VecPoint2f.fromMat', () {
    final points = [cv.Point2f(1, 2), cv.Point2f(3, 4), cv.Point2f(5, 6), cv.Point2f(7, 8)];
    final mat = cv.Mat.fromVec(points.ocv);

    final vec = cv.VecPoint2f.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecPoint3f', () {
    final vec = <cv.Point3f>[].ocv;
    expect(vec.length, 0);

    final points = [cv.Point3f(1, 2, 1), cv.Point3f(3, 4, 3), cv.Point3f(5, 6, 5), cv.Point3f(7, 8, 7)];
    final vec1 = points.ocv;
    expect(vec1.length, 4);
    expect(vec1.first, points.first);
    expect(vec1.last, points.last);
  });

  test('VecPoint3f.fromMat', () {
    final points = [cv.Point3f(1, 2, 1), cv.Point3f(3, 4, 3), cv.Point3f(5, 6, 5), cv.Point3f(7, 8, 7)];
    final mat = cv.Mat.fromVec(points.ocv);

    final vec = cv.VecPoint3f.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecVecPoint', () {
    final points = [
      [cv.Point(1, 1), cv.Point(2, 2), cv.Point(3, 3), cv.Point(4, 4)],
      [cv.Point(5, 5), cv.Point(6, 6), cv.Point(7, 7), cv.Point(8, 8)],
      [cv.Point(9, 9), cv.Point(0, 0), cv.Point(1, 6), cv.Point(2, 8)]
    ];
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);
  });

  test('VecVecPoint2f', () {
    final points = [
      [cv.Point2f(1, 1), cv.Point2f(2, 2), cv.Point2f(3, 3), cv.Point2f(4, 4)],
      [cv.Point2f(5, 5), cv.Point2f(6, 6), cv.Point2f(7, 7), cv.Point2f(8, 8)],
      [cv.Point2f(9, 9), cv.Point2f(0, 0), cv.Point2f(1, 6), cv.Point2f(2, 8)]
    ];
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);
  });

  test('VecVecPoint3f', () {
    final points = [
      [cv.Point3f(1, 2, 1), cv.Point3f(2, 3, 2), cv.Point3f(3, 4, 3), cv.Point3f(4, 5, 4)],
      [cv.Point3f(5, 5, 6), cv.Point3f(6, 6, 6), cv.Point3f(7, 7, 8), cv.Point3f(8, 8, 8)],
      [cv.Point3f(9, 9, 8), cv.Point3f(0, 0, 8), cv.Point3f(1, 6, 5), cv.Point3f(2, 8, 6)]
    ];
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);
  });
}
