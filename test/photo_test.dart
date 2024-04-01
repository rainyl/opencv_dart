@Tags(["not-finished"])
import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.colorChange', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();

    final dst = cv.colorChange(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.seamlessClone', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = src.clone();
    final p = cv.Point(dst.cols ~/ 2, dst.rows ~/ 2);
    final blend = cv.seamlessClone(src, dst, mask, p, cv.NORMAL_CLONE);
    expect(blend.isEmpty, false);
    expect((blend.rows, blend.cols), (dst.rows, dst.cols));
  });

  test('cv.illuminationChange', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = cv.illuminationChange(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.textureFlattening', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = cv.textureFlattening(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.fastNlMeansDenoising', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.fastNlMeansDenoising(img);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  test('cv.fastNlMeansDenoisingColoredMulti', () {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];

    final dst = cv.fastNlMeansDenoisingColoredMulti(src.ocv, 1, 1);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src[0].rows, src[0].cols));
  });

  test('cv.fastNlMeansDenoisingColored', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = cv.fastNlMeansDenoisingColored(img);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  test('cv.detailEnhance', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = cv.detailEnhance(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.edgePreservingFilter', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = cv.edgePreservingFilter(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.pencilSketch', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final (dst1, dst2) = cv.pencilSketch(src);
    expect(dst1.isEmpty, false);
    expect((dst1.rows, dst1.cols), (src.rows, src.cols));
    expect(dst2.isEmpty, false);
    expect((dst2.rows, dst2.cols), (src.rows, src.cols));
  });

  test('cv.stylization', () {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = cv.stylization(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.inpaint', () {
    final src = cv.imread("test/images/inpaint-src.jpg", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final mask = cv.imread("test/images/inpaint-mask.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(mask.isEmpty, false);
    final dst = cv.inpaint(src, mask, 10, cv.INPAINT_TELEA);
    expect(dst.channels, greaterThan(1));
    final sum = dst.sum();
    expect(sum == cv.Scalar.all(0), false);
  });

  test('cv.MergeMertens', () {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];
    final mertens = cv.MergeMertens.empty();
    final dst = mertens.process(src.ocv);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src[0].rows, src[0].cols));

    final mertens1 = cv.MergeMertens.create();
    final dst1 = mertens1.process(src.ocv);
    expect(dst1.isEmpty, false);
    expect((dst1.rows, dst1.cols), (src[0].rows, src[0].cols));
  });

  test('cv.AlignMTB', () {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];

    final alignwtb = cv.AlignMTB.empty();
    final dst = alignwtb.process(src.ocv);
    expect(dst.length, greaterThan(0));

    final alignwtb1 = cv.AlignMTB.create();
    final dst1 = alignwtb1.process(src.ocv);
    expect(dst1.length, greaterThan(0));
  });
}
