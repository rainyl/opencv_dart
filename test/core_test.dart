import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test("cv.convertScaleAbs", () {
    final src =
        cv.Mat.create(width: 100, height: 100, type: cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.convertScaleAbs(src, dst, alpha: 1, beta: 0);
    expect(dst.isEmpty, equals(false));
  });
}
