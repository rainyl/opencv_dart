import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

import 'vec_matcher.dart';

void main() {
  test('VecI32', () {
    final points = List.generate(100, (index) => index);
    final vec = points.i32;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    final vec2 = cv.VecI32(100, 10);
    expect(vec2.toList(), List.generate(100, (index) => 10));

    vec1.dispose();
  });

  test('VecUChar', () {
    final points = List.generate(1000, (index) => index % 256);
    final vec = points.vecUChar;
    final u8List = vec.toU8List();
    expect(u8List.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    final u8 = vec.data;
    expect(u8.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec.dispose();
  });

  test('VecChar', () {
    final points = List.generate(100, (index) => index);
    final vec = points.vecChar;

    final data = vec.data;
    expect(data.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    final vec2 = cv.VecChar.fromList([65, 65, 65, 65, 228, 189, 160, 229, 165, 189]);
    expect(vec2.asString(), "AAAA你好");

    vec1.dispose();
  });

  test('VecI8', () {
    final points = List.generate(100, (index) => index);
    final vec = points.vecChar;

    final data = vec.data;
    expect(data.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    final vec2 = cv.VecChar.fromList([65, 65, 65, 65, 228, 189, 160, 229, 165, 189]);
    expect(vec2.asString(), "AAAA你好");

    vec1.dispose();
  });

  test('VecVecChar', () {
    final points = List.generate(100, (index) => List.generate(100, (index) => index));
    final vec = points.vecVecChar;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1.length, vec.length);
    expect(vec1.first, vecElementEquals(vec.first));
    expect(vec1.last, vecElementEquals(vec.last));

    vec1.dispose();
  });

  test('VecF32', () {
    final points = List.generate(100, (index) => index.toDouble());
    final vec = points.f32;

    final vec_ = List.generate(100, (index) => index).f32;
    expect(vec_ == vec, false);

    final data = vec.data;
    expect(data.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec1.dispose();
  });

  test('VecF64', () {
    final points = List.generate(100, (index) => index.toDouble());
    final vec = points.f64;

    final data = vec.data;
    expect(data.indexed.map((e) => e.$2 == points[e.$1]).every((e) => e), true);

    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec1.dispose();
  });

  test('VecRect', () {
    final points = List.generate(100, (index) => cv.Rect(index, index, index + 10, index + 20));
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "Rect(0, 0, 10, 20)");

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec1.dispose();
  });

  test('RotatedRect', () {
    final rect = cv.RotatedRect(cv.Point2f(1, 1), (10, 10), 60);
    expect(rect.points.length, greaterThan(0));
    expect(rect.boundingRect, cv.Rect(-6, -6, 15, 15));
    expect(rect.center, cv.Point2f(1, 1));
    expect(rect.size, cv.Size2f(10, 10));
    expect(rect.angle, 60);
    expect(rect.toString(), 'RotatedRect(Point2f(1.000, 1.000), Size2f(10.000, 10.000), 60.000)');

    final rect2 = cv.RotatedRect.fromNative(rect.ref);
    expect(rect2, rect);

    rect2.dispose();
  });
  test('VecDMatch', () {
    final points = List.generate(100, (index) => cv.DMatch(index, index, index, index.toDouble()));
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "DMatch(0, 0, 0, 0.000)");

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec1.dispose();
  });

  test('VecVecDMatch', () {
    final points = List.generate(
      10,
      (index) => List.generate(10, (index) => cv.DMatch(index, index, index, index.toDouble())),
    );
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = vec.clone();
    expect(vec1.length, vec.length);
    expect(vec1.first, vecElementEquals(vec.first));
    expect(vec1.last, vecElementEquals(vec.last));

    vec1.dispose();
  });

  test('VecKeyPoint', () {
    final points = List.generate(
      100,
      (index) => cv.KeyPoint(
        index.toDouble(),
        index.toDouble(),
        index.toDouble(),
        index.toDouble(),
        index.toDouble(),
        index,
        index,
      ),
    );
    final vec = points.cvd;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "KeyPoint(0.000, 0.000, 0.000, 0.000, 0.000, 0, 0)");

    final vec1 = vec.clone();
    expect(vec1, vecElementEquals(vec));

    vec1.dispose();
  });
}
