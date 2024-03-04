import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.Stitcher', () {
    cv.registerErrorCallback();
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      cv.Mat.zeros(33, 33, cv.MatType.CV_8UC3),
      cv.Mat.zeros(33, 33, cv.MatType.CV_8UC3).setTo(cv.Scalar(255, 255, 255, 0)),
    ];
    final (status, pano) = stitcher.stitch(images);
    // expect(status, cv.StitcherStatus.OK);
    // expect(pano.isEmpty, false);
    // cv.imwrite('stitcher_test.jpg', pano);
    // expect((pano.rows, pano.cols), (33, 33));
  });
}
