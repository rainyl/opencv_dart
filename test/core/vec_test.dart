import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('VecInt', () {
    final points = List.generate(100, (index) => index);
    final vec = points.i32;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecInt.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecUChar', () {
    final points = List.generate(100, (index) => index);
    final vec = points.u8;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecUChar.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecChar', () {
    final points = List.generate(100, (index) => index);
    final vec = points.i8;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecChar.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecVecChar', () {
    final points = List.generate(100, (index) => List.generate(100, (index) => index));
    final vec = points.i8;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecVecChar.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecFloat', () {
    final points = List.generate(100, (index) => index.toDouble());
    final vec = points.f32;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecFloat.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecDouble', () {
    final points = List.generate(100, (index) => index.toDouble());
    final vec = points.f64;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecDouble.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecRect', () {
    final points = List.generate(100, (index) => cv.Rect(index, index, index + 10, index + 20));
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "Rect(0, 0, 10, 20)");

    final vec1 = cv.VecRect.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('RotatedRect', () {
    final rect = cv.RotatedRect(cv.Point2f(1, 1), (10, 10), 60);
    expect(rect.points.length, greaterThan(0));
    expect(rect.boundingRect, cv.Rect(-6, -6, 15, 15));
    expect(rect.center, cv.Point2f(1, 1));
    expect(rect.size, (10, 10));
    expect(rect.angle, 60);
    expect(rect.toString(), 'RotatedRect(Point2f(1.000, 1.000), (10.0, 10.0), 60.000)');

    final rect2 = cv.RotatedRect.fromNative(rect.ref);
    expect(rect2, rect);
  });
  test('VecDMatch', () {
    final points = List.generate(100, (index) => cv.DMatch(index, index, index, index.toDouble()));
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "DMatch(0, 0, 0, 0.000)");

    final vec1 = cv.VecDMatch.fromPointer(vec.ref);
    expect(vec1, vec);
  });

  test('VecVecDMatch', () {
    final points = List.generate(
        10, (index) => List.generate(10, (index) => cv.DMatch(index, index, index, index.toDouble())));
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);

    final vec1 = cv.VecVecDMatch.fromPointer(vec.ref);
    expect(vec1, vec);
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
    final vec = points.ocv;
    expect(vec.length, points.length);
    expect(vec.first, points.first);
    expect(vec.last, points.last);
    expect(vec.first.toString(), "KeyPoint(0.000, 0.000, 0.000, 0.000, 0.000, 0, 0)");

    final vec1 = cv.VecKeyPoint.fromPointer(vec.ref);
    expect(vec1, vec);
  });
}
