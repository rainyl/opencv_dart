import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.StereoBM props', () {
    final bm = cv.StereoBM.create();

    bm.preFilterCap = 1;
    expect(bm.preFilterCap, 1);

    bm.preFilterSize = 2;
    expect(bm.preFilterSize, 2);

    bm.preFilterType = cv.StereoBM.PREFILTER_XSOBEL;
    expect(bm.preFilterType, cv.StereoBM.PREFILTER_XSOBEL);

    bm.ROI1 = cv.Rect(0, 0, 1, 1);
    expect(bm.ROI1, cv.Rect(0, 0, 1, 1));

    bm.ROI2 = cv.Rect(0, 0, 1, 1);
    expect(bm.ROI2, cv.Rect(0, 0, 1, 1));

    bm.smallerBlockSize = 3;
    // TODO: do nothing
    // https://github.com/opencv/opencv/blob/75d9ac39643f8e08edf3299e47ffd1468e0c5196/modules/calib3d/src/stereobm.cpp#L1335
    expect(bm.smallerBlockSize, 0);

    bm.textureThreshold = 4;
    expect(bm.textureThreshold, 4);

    bm.uniquenessRatio = 5;
    expect(bm.uniquenessRatio, 5);

    bm.blockSize = 6;
    expect(bm.blockSize, 6);

    bm.disp12MaxDiff = 7;
    expect(bm.disp12MaxDiff, 7);

    bm.minDisparity = 8;
    expect(bm.minDisparity, 8);

    bm.numDisparities = 9;
    expect(bm.numDisparities, 9);

    bm.speckleRange = 10;
    expect(bm.speckleRange, 10);

    bm.speckleWindowSize = 11;
    expect(bm.speckleWindowSize, 11);

    expect(bm.toString(), startsWith("StereoBM(address=0x"));
  });

  test('cv.StereoBM', () {
    // from OpenCVSharp tests
    // https://github.com/shimat/opencvsharp/blob/7e984253fecfc0652232cb0726503bf0f3cce568/test/OpenCvSharp.Tests/calib3d/StereoBMTest.cs#L6
    final bm = cv.StereoBM.create();
    final left = cv.imread("test/images/tsukuba_left.png", flags: cv.IMREAD_GRAYSCALE);
    final right = cv.imread("test/images/tsukuba_right.png", flags: cv.IMREAD_GRAYSCALE);

    expect(left.isEmpty, false);
    expect(right.isEmpty, false);

    final disparity = bm.compute(left, right);
    expect(disparity.isEmpty, false);
    expect(disparity.type, cv.MatType.CV_16SC1);

    // cv.imwrite("test/images_out/StereoBM_disparity.png", disparity);
  });

  test('cv.StereoSGBM props', () {
    final sgbm = cv.StereoSGBM.create();

    sgbm.preFilterCap = 1;
    expect(sgbm.preFilterCap, 1);

    sgbm.mode = cv.StereoSGBM.MODE_SGBM;
    expect(sgbm.mode, cv.StereoSGBM.MODE_SGBM);

    sgbm.P1 = 2;
    expect(sgbm.P1, 2);

    sgbm.P2 = 3;
    expect(sgbm.P2, 3);

    sgbm.uniquenessRatio = 4;
    expect(sgbm.uniquenessRatio, 4);

    sgbm.blockSize = 5;
    expect(sgbm.blockSize, 5);

    sgbm.speckleRange = 6;
    expect(sgbm.speckleRange, 6);

    sgbm.speckleWindowSize = 7;
    expect(sgbm.speckleWindowSize, 7);

    sgbm.disp12MaxDiff = 8;
    expect(sgbm.disp12MaxDiff, 8);

    sgbm.minDisparity = 9;
    expect(sgbm.minDisparity, 9);

    sgbm.numDisparities = 10;
    expect(sgbm.numDisparities, 10);

    expect(sgbm.toString(), startsWith('StereoSGBM(address=0x'));
  });

  test('cv.StereoSGBM', () {
    // from OpenCVSharp tests
    // https://github.com/shimat/opencvsharp/blob/7e984253fecfc0652232cb0726503bf0f3cce568/test/OpenCvSharp.Tests/calib3d/StereoSGBMTest.cs
    final sgbm = cv.StereoSGBM.create(minDisparity: 0, numDisparities: 32, blockSize: 5);
    final left = cv.imread("test/images/tsukuba_left.png", flags: cv.IMREAD_GRAYSCALE);
    final right = cv.imread("test/images/tsukuba_right.png", flags: cv.IMREAD_GRAYSCALE);

    expect(left.isEmpty, false);
    expect(right.isEmpty, false);

    final disparity = sgbm.compute(left, right);
    expect(disparity.isEmpty, false);
    expect(disparity.type, cv.MatType.CV_16SC1);

    // cv.imwrite("test/images_out/StereoSGBM_disparity.png", disparity);
  });
}
