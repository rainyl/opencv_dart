import 'dart:io';

import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test("cv2.imread, cv2.imwrite", () {
    final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    expect(cv.imwrite("test/images_out/test_imwrite.png", cvImage), true);
  });

  test("cv2.imencode, cv2.imdecode", () async {
    final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    final buf = cv.imencode(".png", cvImage);
    expect(buf.length, greaterThan(0));
    await File("test/images_out/test_imencode.png").writeAsBytes(buf);

    final cvimgDecode = cv.imdecode(buf, cv.IMREAD_COLOR);
    expect(cvimgDecode.height, equals(cvImage.height));
    expect(cvimgDecode.width, equals(cvImage.width));
    expect(cvimgDecode.channels, equals(cvImage.channels));

    final dst = cv.Mat.empty();
    cv.imdecode(buf, cv.IMREAD_COLOR, dst: dst);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols, dst.channels), (cvImage.rows, cvImage.cols, cvImage.channels));
  });
}
