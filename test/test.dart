import 'dart:io';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  cv.registerErrorCallback();
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      cv.imread("test/images/boat1.jpg", flags: cv.IMREAD_COLOR),
      cv.imread("test/images/boat2.jpg", flags: cv.IMREAD_COLOR),
    ];

    final masks = [
      images[0].region(cv.Rect(0, 0, 2000, 2000)).convertTo(cv.MatType.CV_8UC1),
      images[0].region(cv.Rect(1000, 0, 2000, 2000)).convertTo(cv.MatType.CV_8UC1),
    ];
    final (status, pano) = stitcher.stitch(images, masks: masks);
}
