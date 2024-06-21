import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.ximgproc.anisotropicDiffusion', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = cv.ximgproc.anisotropicDiffusion(src, 0.5, 0.5, 100);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.edgePreservingFilter', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC3);
    final dst = cv.ximgproc.edgePreservingFilter(src, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.findEllipses', () {
    final src = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.ximgproc.findEllipses(src);
    expect(dst.isEmpty, false);
  });

  test('cv.ximgproc.niBlackThreshold', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.niBlackThreshold(src, 127.0, cv.THRESH_BINARY, 3, 0.5);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });

  test('cv.ximgproc.PeiLinNormalization', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.PeiLinNormalization(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, [2, 3, 1]);
  });

  test('cv.ximgproc.thinning', () {
    final src = cv.Mat.zeros(200, 200, cv.MatType.CV_8UC1);
    final dst = cv.ximgproc.thinning(src);
    expect(dst.isEmpty, false);
    expect(dst.shape, src.shape);
  });
}
