import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test("cv.RNG", () async {
    final rng = cv.Rng();
    final v = await rng.uniform(0, 241, maxCount: 100000).take(10000).toList();
    expect(v, everyElement(greaterThanOrEqualTo(0)));
    final v1 = await rng.uniform(2.41, 241.0).take(100000).toList();
    expect(v1, everyElement(greaterThanOrEqualTo(2.41)));

    rng.dispose();
  });

  test("cv.RNG.fromSeed", () async {
    final rng = cv.Rng.fromSeed(241);
    final v = await rng.gaussian(2.41).take(100000).toList();
    expect(v.length, equals(100000));

    final v1 = await rng.next().first;
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
