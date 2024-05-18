import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test("cv.CLAHE", () {
    final mat = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final clahe = cv.CLAHE();
    final dst = clahe.apply(mat);
    expect(dst.isEmpty, false);
  });
}
