import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('Point', () {
    final point = cv.Point(1, 2);
    expect((point.x, point.y), (1, 2));
    point.x = 3;
    point.y = 4;
    expect(point.toString(), "Point(3, 4)");

    {
      final p = cv.Point.fromNative(point.ref);
      expect(p, cv.Point(3, 4));
      expect(p.ref.x, 3);
    }

    final point1 = cv.Point2f(1.50, 2.3);
    closeTo(point1.x, 1.50);
    closeTo(point1.y, 2.3);
    point1.x = 3.0;
    point1.y = 4.0;
    expect(point1.toString(), "Point2f(3.000, 4.000)");
    {
      final p = cv.Point2f.fromNative(point1.ref);
      expect(p, cv.Point2f(3.0, 4.0));
      expect(p.ref.x, 3.0);
    }

    final point2 = cv.Point3f(1.50, 2.3, 3.4);
    closeTo(point2.x, 1.50);
    closeTo(point2.y, 2.3);
    closeTo(point2.z, 3.4);
    point2.x = 3.0;
    point2.y = 4.0;
    point2.z = 5.0;
    expect(point2.toString(), "Point3f(3.000, 4.000, 5.000)");
    {
      final p = cv.Point3f.fromNative(point2.ref);
      expect(p, cv.Point3f(3.000, 4.000, 5.000));
      expect(p.ref.x, 3.0);
    }
    point2.dispose();

    final point3 = cv.Point3i(1, 2, 3);
    closeTo(point3.x, 1);
    closeTo(point3.y, 2);
    closeTo(point3.z, 3);
    point3.x = 3;
    point3.y = 4;
    point3.z = 5;
    expect(point3.toString(), "Point3i(3, 4, 5)");
    {
      final p = cv.Point3i.fromNative(point3.ref);
      expect(p, cv.Point3i(3, 4, 5));
      expect(p.ref.x, 3);
    }
    point3.dispose();
  });

  test('VecPoint', () {
    final vec0 = cv.VecPoint(10);
    expect(vec0.length, 10);

    final vec = <cv.Point>[].cvd;
    expect(vec.length, 0);

    final points = [cv.Point(1, 2), cv.Point(3, 4), cv.Point(5, 6), cv.Point(7, 8)];
    final vec1 = points.cvd;
    expect(vec1.length, 4);
    expect(vec1.first, cv.Point(1, 2));
    expect(vec1.last, cv.Point(7, 8));

    // get the reference
    final pt = vec1[1];
    expect(pt, cv.Point(3, 4));
    // change the reference will affect the original value
    pt.x = 100;
    expect(pt, cv.Point(100, 4));
    // change the value
    vec1[1] = cv.Point(100, 100);
    expect(vec1[1], cv.Point(100, 100));

    final vec2 = vec1.clone();
    vec2.add(cv.Point(10, 10));
    expect(vec2.length, points.length + 1);
    expect(vec2[vec2.length - 1], cv.Point(10, 10));

    final vec3 = cv.VecPoint.generate(vec2.length, (i) => vec2[i]);
    vec2.extend(vec3);
    expect(vec2.length, vec3.length * 2);

    vec3.reserve(21);
    vec3.resize(21);
    expect(vec3.length, 21);
    expect(vec3.size(), 21);
    vec3.clear();
    vec3.shrinkToFit();
    expect(vec3.length, 0);

    vec.dispose();
  });

  test('VecPoint.fromMat', () {
    final points = [cv.Point(1, 2), cv.Point(3, 4), cv.Point(5, 6), cv.Point(7, 8)];
    final mat = cv.Mat.fromVec(points.cvd);

    final vec = cv.VecPoint.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    vec.dispose();
  });

  test('VecPoint2f', () {
    final vec = <cv.Point2f>[].cvd;
    expect(vec.length, 0);

    final points = [cv.Point2f(1, 2), cv.Point2f(3, 4), cv.Point2f(5, 6), cv.Point2f(7, 8)];
    final vec1 = points.cvd;
    expect(vec1.length, 4);
    expect(vec1.first, points.first);
    expect(vec1.last, points.last);

    // get the reference
    final pt = vec1[1];
    expect(pt, cv.Point2f(3, 4));
    // change the reference will affect the original value
    pt.x = 100;
    expect(pt, cv.Point2f(100, 4));
    // change the value
    vec1[1] = cv.Point2f(100, 100);
    expect(vec1[1], cv.Point2f(100, 100));

    final points1 = cv.VecPoint2f(10, 1, 1);
    expect(points1.length, 10);
    expect(points1.first, cv.Point2f(1, 1));

    final points2 = cv.VecPoint2f();
    expect(points2.length, 0);
    expect(points2.firstOrNull, null);

    final vec2 = vec1.clone();
    vec2.add(cv.Point2f(10, 10));
    expect(vec2.length, points.length + 1);
    expect(vec2[vec2.length - 1], cv.Point2f(10, 10));

    final vec3 = cv.VecPoint2f.generate(vec2.length, (i) => vec2[i]);
    vec2.extend(vec3);
    expect(vec2.length, vec3.length * 2);

    vec3.reserve(21);
    vec3.resize(21);
    expect(vec3.length, 21);
    expect(vec3.size(), 21);
    vec3.clear();
    vec3.shrinkToFit();
    expect(vec3.length, 0);

    vec.dispose();
  });

  test('VecPoint2f.fromMat', () {
    final points = [cv.Point2f(1, 2), cv.Point2f(3, 4), cv.Point2f(5, 6), cv.Point2f(7, 8)];
    final mat = cv.Mat.fromVec(points.cvd);

    final vec = cv.VecPoint2f.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecPoint3f', () {
    final vec = <cv.Point3f>[].cvd;
    expect(vec.length, 0);

    final points = [cv.Point3f(1, 2, 1), cv.Point3f(3, 4, 3), cv.Point3f(5, 6, 5), cv.Point3f(7, 8, 7)];
    final vec1 = points.cvd;
    expect(vec1.length, 4);
    expect(vec1.first, points.first);
    expect(vec1.last, points.last);

    // get the reference
    final pt = vec1[1];
    expect(pt, cv.Point3f(3, 4, 3));
    // change the reference will affect the original value
    pt.x = 100;
    expect(pt, cv.Point3f(100, 4, 3));
    // change the value
    vec1[1] = cv.Point3f(3, 4, 100);
    expect(vec1[1], cv.Point3f(3, 4, 100));

    final vec2 = vec1.clone();
    vec2.add(cv.Point3f(10, 10, 10));
    expect(vec2.length, points.length + 1);
    expect(vec2[vec2.length - 1], cv.Point3f(10, 10, 10));

    final vec3 = cv.VecPoint3f.generate(vec2.length, (i) => vec2[i]);
    vec2.extend(vec3);
    expect(vec2.length, vec3.length * 2);

    vec3.reserve(21);
    vec3.resize(21);
    expect(vec3.length, 21);
    expect(vec3.size(), 21);
    vec3.clear();
    vec3.shrinkToFit();
    expect(vec3.length, 0);

    vec.dispose();
  });

  test('VecPoint3f.fromMat', () {
    final points = [cv.Point3f(1, 2, 1), cv.Point3f(3, 4, 3), cv.Point3f(5, 6, 5), cv.Point3f(7, 8, 7)];
    final mat = cv.Mat.fromVec(points.cvd);

    final vec = cv.VecPoint3f.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecPoint3i', () {
    final vec = <cv.Point3i>[].cvd;
    expect(vec.length, 0);

    final points = [cv.Point3i(1, 2, 1), cv.Point3i(3, 4, 3), cv.Point3i(5, 6, 5), cv.Point3i(7, 8, 7)];
    final vec1 = points.cvd;
    expect(vec1.length, 4);
    expect(vec1.first, points.first);
    expect(vec1.last, points.last);

    // get the reference
    final pt = vec1[1];
    expect(pt, cv.Point3i(3, 4, 3));
    // change the reference will affect the original value
    pt.x = 100;
    expect(pt, cv.Point3i(100, 4, 3));
    // change the value
    vec1[1] = cv.Point3i(3, 4, 100);
    expect(vec1[1], cv.Point3i(3, 4, 100));

    final vec0 = cv.VecPoint3i(10);
    expect(vec0.length, 10);
    expect(vec0.first, cv.Point3i(0, 0, 0));

    final vec2 = vec1.clone();
    vec2.add(cv.Point3i(10, 10, 10));
    expect(vec2.length, points.length + 1);
    expect(vec2[vec2.length - 1], cv.Point3i(10, 10, 10));

    final vec3 = cv.VecPoint3i.generate(vec2.length, (i) => vec2[i]);
    vec2.extend(vec3);
    expect(vec2.length, vec3.length * 2);

    vec3.reserve(21);
    vec3.resize(21);
    expect(vec3.length, 21);
    expect(vec3.size(), 21);
    vec3.clear();
    vec3.shrinkToFit();
    expect(vec3.length, 0);

    vec.dispose();
  });

  test('VecPoint3i.fromMat', () {
    final points = [cv.Point3i(1, 2, 1), cv.Point3i(3, 4, 3), cv.Point3i(5, 6, 5), cv.Point3i(7, 8, 7)];
    final mat = cv.Mat.fromVec(points.cvd);

    final vec = cv.VecPoint3i.fromMat(mat);
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
  });

  test('VecVecPoint', () {
    final points = [
      [cv.Point(1, 1), cv.Point(2, 2), cv.Point(3, 3), cv.Point(4, 4)],
      [cv.Point(5, 5), cv.Point(6, 6), cv.Point(7, 7), cv.Point(8, 8)],
      [cv.Point(9, 9), cv.Point(0, 0), cv.Point(1, 6), cv.Point(2, 8)],
    ];
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);

    final elem = vec[0];
    expect(elem[0], points[0][0]);
    elem[0] = cv.Point(-1, -1);
    expect(elem[0], cv.Point(-1, -1));

    final list = vec.copyToList();
    expect(list[0][0], vec[0][0]);

    vec.dispose();
  });

  test('VecVecPoint2f', () {
    final points = [
      [cv.Point2f(1, 1), cv.Point2f(2, 2), cv.Point2f(3, 3), cv.Point2f(4, 4)],
      [cv.Point2f(5, 5), cv.Point2f(6, 6), cv.Point2f(7, 7), cv.Point2f(8, 8)],
      [cv.Point2f(9, 9), cv.Point2f(0, 0), cv.Point2f(1, 6), cv.Point2f(2, 8)],
    ];
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);

    final list = vec.copyToList();
    expect(list[0][0], vec[0][0]);

    vec.dispose();
  });

  test('VecVecPoint3f', () {
    final points = [
      [cv.Point3f(1, 2, 1), cv.Point3f(2, 3, 2), cv.Point3f(3, 4, 3), cv.Point3f(4, 5, 4)],
      [cv.Point3f(5, 5, 6), cv.Point3f(6, 6, 6), cv.Point3f(7, 7, 8), cv.Point3f(8, 8, 8)],
      [cv.Point3f(9, 9, 8), cv.Point3f(0, 0, 8), cv.Point3f(1, 6, 5), cv.Point3f(2, 8, 6)],
    ];
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first.length, points.first.length);
    expect(vec.first.first, points.first.first);
    expect(vec.last.last, points.last.last);

    final list = vec.copyToList();
    expect(list[0][0], vec[0][0]);

    vec.dispose();
  });
}
