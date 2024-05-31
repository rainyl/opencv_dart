import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test("cv.RNG", () {
    final rng = cv.Rng();
    final v = List.generate(100000, (index) => rng.uniform(0, 241));
    expect(v, everyElement(greaterThanOrEqualTo(0)));
    final v1 = List.generate(100000, (index) => rng.uniform<double>(2.41, 241.0));
    expect(v1, everyElement(greaterThanOrEqualTo(2.41)));

    rng.dispose();
  });

  test("cv.RNG.fromSeed", () {
    final rng = cv.Rng.fromSeed(241);
    final v = List.generate(100000, (index) => rng.gaussian(2.41));
    expect(v.length, equals(100000));

    final v1 = rng.next();
    expect(v1, isA<int>());

    final rng1 = cv.Rng.fromSeed(241);
    expect(rng == rng1, false);
  });

  test("cv.RNG.fill", () {
    final rng = cv.Rng.fromSeed(241);
    final mat = cv.Mat.zeros(241, 241, cv.MatType.CV_32FC3);
    rng.fill(mat, cv.RNG_DIST_NORMAL, 0, 10, inplace: true);
    expect(mat.at<double>(0, 0) != 0, true);
  });
}
