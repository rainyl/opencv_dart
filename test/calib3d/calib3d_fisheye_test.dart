import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

cv.Mat generate3DPoints() {
  final pts = [
    [0.5, 0.5, -0.5],
    [0.5, 0.5, 0.5],
    [-0.5, 0.5, 0.5],
    [-0.5, 0.5, -0.5],
    [0.5, -0.5, -0.5],
    [-0.5, -0.5, -0.5],
    [-0.5, -0.5, 0.5],
  ];
  final points = cv.Mat.zeros(7, 3, cv.MatType.CV_32FC1);
  points.forEachPixel((i, j, v) {
    v[0] = pts[i][j];
  });
  return points;
}

cv.Mat create3DChessboardCorners(cv.Size boardSize, double squareSize) {
  final vec = cv.VecPoint3f(boardSize.height * boardSize.width);
  for (var y = 0; y < boardSize.height; y++) {
    for (var x = 0; x < boardSize.width; x++) {
      vec[y * boardSize.width + x] = cv.Point3f(x * squareSize, y * squareSize, 0.0);
    }
  }
  return cv.Mat.fromVec(vec);
}

void main() async {
  // https://github.com/shimat/opencvsharp/blob/4a082880c7174d997a0dd35696103efdbfcb9293/test/OpenCvSharp.Tests/calib3d/Calib3dTest.cs#L156
  test('cv.Fisheye.calibrate', () async {
    final patternSize = cv.Size(10, 7);
    final image = cv.imread("test/images/calibration_00.jpg");
    final (found, corners) = cv.findChessboardCorners(image, (10, 7));
    expect(found, true);

    final objectPoints = cv.VecMat();
    objectPoints.add(create3DChessboardCorners(patternSize, 1.0));
    expect(objectPoints.length, 1);

    final imagePoints = cv.VecMat();
    imagePoints.add(cv.Mat.fromVec(corners));
    expect(imagePoints.length, 1);

    final cameraMatrix = cv.Mat.eye(3, 3, cv.MatType.CV_64FC1);
    final distCoeffs = cv.Mat.empty();

    {
      final (rval, rotationVectors, translationVectors) =
          cv.Fisheye.calibrate(objectPoints, imagePoints, patternSize, cameraMatrix, distCoeffs);

      expect(rval, greaterThan(10));
      expect(rotationVectors.isEmpty, false);
      expect(distCoeffs.isEmpty, false);
      expect(translationVectors.isEmpty, false);

      final (map1, map2) = cv.Fisheye.initUndistortRectifyMap(
        cameraMatrix,
        distCoeffs,
        cv.Mat.eye(3, 3, cv.MatType.CV_64FC1),
        cameraMatrix,
        cv.Size(image.width, image.height),
        cv.MatType.CV_16SC2.value,
      );
      expect(map1.isEmpty, false);
      expect(map2.isEmpty, false);
    }

    {
      final (rval, rotationVectors, translationVectors) =
          await cv.Fisheye.calibrateAsync(objectPoints, imagePoints, patternSize, cameraMatrix, distCoeffs);

      expect(rval, greaterThan(10));
      expect(rotationVectors.isEmpty, false);
      expect(distCoeffs.isEmpty, false);
      expect(translationVectors.isEmpty, false);

      final (map1, map2) = await cv.Fisheye.initUndistortRectifyMapAsync(
        cameraMatrix,
        distCoeffs,
        cv.Mat.eye(3, 3, cv.MatType.CV_64FC1),
        cameraMatrix,
        cv.Size(image.width, image.height),
        cv.MatType.CV_16SC2.value,
      );
      expect(map1.isEmpty, false);
      expect(map2.isEmpty, false);
    }
  });

  test('cv.Fisheye.projectPoints', () async {
    final objectPoints = generate3DPoints().reshape(3);
    final intrisicMat = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    intrisicMat.set<double>(0, 0, 1.6415318549788924e+003);
    intrisicMat.set<double>(1, 1, 1.7067753507885654e+003);
    intrisicMat.set<double>(0, 2, 5.3262822453148601e+002);
    intrisicMat.set<double>(1, 2, 3.8095355839052968e+002);
    intrisicMat.set<double>(2, 2, 1);

    final rvec = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC1);
    rvec.set<double>(0, 0, -3.9277902400761393e-002);
    rvec.set<double>(1, 0, 3.7803824407602084e-002);
    rvec.set<double>(2, 0, 2.6445674487856268e-002);

    final tvec = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC1);
    tvec.set<double>(0, 0, 2.1158489381208221e+000);
    tvec.set<double>(1, 0, -7.6847683212704716e+000);
    tvec.set<double>(2, 0, 2.6169795190294256e+001);

    final distCoeffs = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC1);

    {
      final (imagePoints, jacobian) =
          cv.Fisheye.projectPoints(objectPoints, rvec, tvec, intrisicMat, distCoeffs);

      expect(imagePoints.isEmpty, false);
      expect(jacobian.isEmpty, false);

      final (rval, rv, tv) =
          cv.Fisheye.solvePnP(objectPoints, imagePoints, cv.Mat.eye(3, 3, cv.MatType.CV_64FC1), distCoeffs);
      expect(rval, true);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);
    }

    {
      final (imagePoints, jacobian) =
          await cv.Fisheye.projectPointsAsync(objectPoints, rvec, tvec, intrisicMat, distCoeffs);

      expect(imagePoints.isEmpty, false);
      expect(jacobian.isEmpty, false);

      final (rval, rv, tv) = await cv.Fisheye.solvePnPAsync(
          objectPoints, imagePoints, cv.Mat.eye(3, 3, cv.MatType.CV_64FC1), distCoeffs);
      expect(rval, true);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);
    }
  });

  test('cv.Fisheye.undistortImage', () async {
    final img = cv.imread("test/images/fisheye_sample.jpg", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 689.21);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 1295.56);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 690.48);
    k.set<double>(1, 2, 942.17);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);

    {
      final dst = cv.Fisheye.undistortImage(img, k, d);
      expect(dst.isEmpty, false);
    }
    {
      final dst = await cv.Fisheye.undistortImageAsync(img, k, d);
      expect(dst.isEmpty, false);
    }
  });

  test('cv.Fisheye.undistortPoints', () async {
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 1094.7249578198823);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 959.4907612030962);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 1094.9945708128778);
    k.set<double>(1, 2, 536.4566143451868);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    d.set<double>(0, 0, -0.05207412392075069);
    d.set<double>(0, 1, -0.089168300192224);
    d.set<double>(0, 2, 0.10465607695792184);
    d.set<double>(0, 3, -0.045693446831115585);

    final r = cv.Mat.empty();
    final src = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC2);
    final dst = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC2);

    src.set<double>(0, 0, 480.0);
    src.set<double>(0, 1, 270.0);

    src.set<double>(1, 0, 960.0);
    src.set<double>(1, 1, 540.0);

    src.set<double>(2, 0, 1440.0);
    src.set<double>(2, 1, 810.0);

    final knew = k.clone();
    knew.set<double>(0, 0, 0.4 * k.at<double>(0, 0));
    knew.set<double>(1, 1, 0.4 * k.at<double>(1, 1));

    {
      cv.Fisheye.estimateNewCameraMatrixForUndistortRectify(
        k,
        d,
        (1920, 1080),
        r,
        P: knew,
        balance: 1,
        newSize: (1920, 1080),
      );

      cv.Fisheye.undistortPoints(src, k, d);
      cv.Fisheye.undistortPoints(src, k, d, undistorted: dst, R: r, P: k);
      expect(dst.isEmpty, false);
      expect(dst.at<double>(0, 0) != 0, true);

      final dst1 = cv.Fisheye.distortPoints(dst, k, d);
      expect(dst1.isEmpty, false);

      cv.Fisheye.distortPoints(dst, k, d, Kundistorted: knew, distorted: dst1);
      expect(dst1.isEmpty, false);
    }
    {
      await cv.Fisheye.estimateNewCameraMatrixForUndistortRectifyAsync(
        k,
        d,
        (1920, 1080),
        r,
        balance: 1,
        newSize: (1920, 1080),
      );

      await cv.Fisheye.undistortPointsAsync(src, k, d);
      await cv.Fisheye.undistortPointsAsync(src, k, d, R: r, P: k);
      expect(dst.isEmpty, false);
      expect(dst.at<double>(0, 0) != 0, true);

      final dst1 = await cv.Fisheye.distortPointsAsync(dst, k, d);
      expect(dst1.isEmpty, false);

      await cv.Fisheye.distortPointsAsync(dst, k, d, Kundistorted: knew, distorted: dst1);
      expect(dst1.isEmpty, false);
    }
  });
}
