import 'dart:math' as math;

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

void main() async {
  test('cv.undistortPoints', () async {
    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 1094.7249578198823);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 1094.7249578198823);

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

    // This camera matrix is 1920x1080. Points where x < 960 and y < 540 should move toward the top left (x and y get smaller)
    // The centre point should be mostly unchanged
    // Points where x > 960 and y > 540 should move toward the bottom right (x and y get bigger)

    // The index being used for col here is actually the channel (i.e. the point's x/y dimensions)
    // (since there's only 1 column so the formula: (colNumber * numChannels + channelNumber) reduces to
    // (0 * 2) + channelNumber
    // so col = 0 is the x coordinate and col = 1 is the y coordinate

    src.set<double>(0, 0, 480.0);
    src.set<double>(0, 1, 270.0);

    src.set<double>(1, 0, 960.0);
    src.set<double>(1, 1, 540.0);

    src.set<double>(2, 0, 1920.0);
    src.set<double>(2, 1, 1080.0);

    {
      cv.undistortPoints(src, k, d);
      final dst = cv.undistortPoints(src, k, d, R: r, P: k);
      expect(dst.isEmpty, false);
      expect(dst.at<double>(0, 0), lessThan(480));
      expect(dst.at<double>(0, 1), lessThan(270));
    }
    {
      await cv.undistortPointsAsync(src, k, d);
      final dst = await cv.undistortPointsAsync(src, k, d, R: r, P: k);
      expect(dst.isEmpty, false);
      expect(dst.at<double>(0, 0), lessThan(480));
      expect(dst.at<double>(0, 1), lessThan(270));
    }
  });

  test('cv.calibrateCamera', () async {
    final img = cv.imread("test/images/chessboard_4x6_distort.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    const patternSize = (4, 6);
    final (found, corners) = cv.findChessboardCorners(img, patternSize, flags: 0);
    expect(found, true);
    expect(corners.isEmpty, false);

    final pts = <cv.Point3f>[];
    for (var j = 0; j < patternSize.$2; j++) {
      for (var i = 0; i < patternSize.$1; i++) {
        pts.add(cv.Point3f(i.toDouble(), j.toDouble(), 0));
      }
    }
    final objectPointsVector = cv.Contours3f.fromList([pts]);
    final imagePointsVector = cv.Contours2f.fromList([corners.toList()]);

    {
      final cameraMatrix = cv.Mat.empty();
      final distCoeffs = cv.Mat.empty();
      final (rmsErr, mtx, dist, rvecs, tvecs) = cv.calibrateCamera(
        objectPointsVector,
        imagePointsVector,
        (img.cols, img.rows),
        cameraMatrix,
        distCoeffs,
      );
      expect(rmsErr, greaterThan(0));
      expect(mtx.isEmpty || dist.isEmpty || rvecs.isEmpty || tvecs.isEmpty, false);

      final dst = cv.undistort(img, cameraMatrix, distCoeffs);
      final target = cv.imread("test/images/chessboard_4x6_distort_correct.png", flags: cv.IMREAD_GRAYSCALE);
      final xor = cv.bitwiseXOR(dst, target);
      final sum = xor.sum();
      expect(sum.val1, lessThan(img.rows * img.cols * 0.005));
    }
    {
      final cameraMatrix = cv.Mat.empty();
      final distCoeffs = cv.Mat.empty();
      final (rmsErr, mtx, dist, rvecs, tvecs) = await cv.calibrateCameraAsync(
        objectPointsVector,
        imagePointsVector,
        (img.cols, img.rows),
        cameraMatrix,
        distCoeffs,
      );
      expect(rmsErr, greaterThan(0));
      expect(mtx.isEmpty || dist.isEmpty || rvecs.isEmpty || tvecs.isEmpty, false);

      final dst = await cv.undistortAsync(img, cameraMatrix, distCoeffs);
      final target = cv.imread("test/images/chessboard_4x6_distort_correct.png", flags: cv.IMREAD_GRAYSCALE);
      final xor = cv.bitwiseXOR(dst, target);
      final sum = xor.sum();
      expect(sum.val1, lessThan(img.rows * img.cols * 0.005));
    }
  });

  test('cv.checkChessboard', () {
    final patternSize = (4, 6).toSize();
    final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_GRAYSCALE);
    final img1 = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(cv.checkChessboard(img, patternSize), true);
    expect(cv.checkChessboard(img1, patternSize), false);
  });

  test('cv.findChessboardCorners, cv.drawChessboardCorners', () async {
    final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    {
      final (found, corners) = cv.findChessboardCorners(img, (4, 6), flags: 0);
      expect(found, true);
      expect(corners.isEmpty, false);

      final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
      cv.drawChessboardCorners(img2, (4, 6), corners, true);
      expect(img2.isEmpty, false);
    }
    {
      final (found, corners) = await cv.findChessboardCornersAsync(img, (4, 6));
      expect(found, true);
      expect(corners.isEmpty, false);

      // final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
      // await cv.drawChessboardCornersAsync(img2, (4, 6), corners, true);
      // expect(img2.isEmpty, false);
    }
  });

  test(
    'cv.findChessboardCornersSB',
    // onPlatform: {
    //   "mac-os": const Skip("https://github.com/opencv/opencv/issues/20202"),
    // },
    () async {
      final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_COLOR);
      expect(img.isEmpty, false);

      {
        final (found, corners) = cv.findChessboardCornersSB(img, (3, 3), flags: 0);
        expect(found, true);
        expect(corners.isEmpty, false);

        final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
        cv.drawChessboardCorners(img2, (4, 6), corners, true);
        expect(img2.isEmpty, false);
      }
      {
        final (found, corners) = await cv.findChessboardCornersSBAsync(img, (4, 6), 0);
        expect(found, true);
        expect(corners.isEmpty, false);

        final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
        await cv.drawChessboardCornersAsync(img2, (4, 6), corners, true);
        expect(img2.isEmpty, false);
      }
    },
  );

  test(
    'cv.findChessboardCornersSBWithMeta',
    // onPlatform: {
    //   "mac-os": const Skip("https://github.com/opencv/opencv/issues/20202"),
    // },
    () async {
      final img = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_COLOR);
      expect(img.isEmpty, false);

      {
        final (found, corners, meta) = cv.findChessboardCornersSBWithMeta(img, (4, 6), 0);
        expect(found, true);
        expect(corners.isEmpty, false);
        expect(meta.isEmpty, false);

        final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
        cv.drawChessboardCorners(img2, (4, 6), corners, true);
        expect(img2.isEmpty, false);
      }
      {
        final (found, corners, meta) = await cv.findChessboardCornersSBWithMetaAsync(img, (4, 6), 0);
        expect(found, true);
        expect(corners.isEmpty, false);
        expect(meta.isEmpty, false);

        final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
        await cv.drawChessboardCornersAsync(img2, (4, 6), corners, true);
        expect(img2.isEmpty, false);
      }
    },
  );

  test('cv.estimateAffinePartial2D', () async {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
      cv.Point2f(5, 10),
    ].cvd;
    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
      cv.Point2f(0, 10),
    ].cvd;
    {
      final (m, inliers) = cv.estimateAffinePartial2D(
        src,
        dst,
      );
      expect(inliers.isEmpty, false);
      expect(m.isEmpty, false);
      expect((m.rows, m.cols), (2, 3));
    }
    {
      final (m, inliers) = await cv.estimateAffinePartial2DAsync(src, dst);
      expect(inliers.isEmpty, false);
      expect(m.isEmpty, false);
      expect((m.rows, m.cols), (2, 3));
    }
  });

  test('cv.estimateAffine2D', () async {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
      cv.Point2f(5, 10),
    ].cvd;
    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
      cv.Point2f(0, 10),
    ].cvd;
    {
      final (m, inliers) = cv.estimateAffine2D(
        src,
        dst,
      );
      expect(inliers.isEmpty, false);
      expect(m.isEmpty, false);
      expect((m.rows, m.cols), (2, 3));
    }
    {
      final (m, inliers) = await cv.estimateAffine2DAsync(
        src,
        dst,
      );
      expect(inliers.isEmpty, false);
      expect(m.isEmpty, false);
      expect((m.rows, m.cols), (2, 3));
    }
  });

  // findHomography
  test('cv.findHomography', () async {
    final src = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC2);
    final dst = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC2);
    final srcPts = [
      cv.Point2f(193, 932),
      cv.Point2f(191, 378),
      cv.Point2f(1497, 183),
      cv.Point2f(1889, 681),
    ];
    final dstPts = [
      cv.Point2f(51.51206544281359, -0.10425475260813055),
      cv.Point2f(51.51211051314331, -0.10437947532732306),
      cv.Point2f(51.512222354139325, -0.10437679311830816),
      cv.Point2f(51.51214828037607, -0.1042212249954444),
    ];
    for (var i = 0; i < srcPts.length; i++) {
      src.set<double>(i, 0, srcPts[i].x);
      src.set<double>(i, 1, srcPts[i].y);
    }
    for (var i = 0; i < dstPts.length; i++) {
      dst.set<double>(i, 0, dstPts[i].x);
      dst.set<double>(i, 1, dstPts[i].y);
    }

    {
      final mask = cv.Mat.empty();
      final m = cv.findHomography(
        src,
        dst,
        method: cv.HOMOGRAPY_ALL_POINTS,
        ransacReprojThreshold: 3,
        mask: mask,
      );
      expect(m.isEmpty, false);
    }

    {
      final (m, _) = await cv.findHomographyAsync(
        src,
        dst,
        method: cv.HOMOGRAPY_ALL_POINTS,
        ransacReprojThreshold: 3,
      );
      expect(m.isEmpty, false);
    }
  });

  test('cv.findHomographyUsac', () async {
    final points1 = cv.VecPoint2f.generate(5, (i) => cv.Point2f(i * 10, i * 20));
    final points2 = points1.map((p) => cv.Point2f(p.x + p.x / 10, p.y + p.y / 10)).toList(growable: false);

    final m1 = cv.Mat.fromVec(points1);
    final m2 = cv.Mat.fromVec(points2.asVec());
    {
      final mask = cv.Mat.empty();
      final _ = cv.findHomographyUsac(
        m1,
        m2,
        cv.UsacParams(),
        mask: mask,
      );
      // expect(m.isEmpty, false);
    }
  });

  test('cv.findFundamentalMat', () {
    final imgPt1 = cv.Mat.from2DList(
      [
        <double>[1017.0883, 848.23529],
        <double>[1637, 848.23529],
        <double>[1637, 1648.7059],
        <double>[1017.0883, 1648.7059],
        <double>[2282.2144, 772],
        <double>[3034.9644, 772],
        <double>[3034.9644, 1744],
        <double>[2282.2144, 1744],
      ],
      cv.MatType.CV_64FC1,
    );

    final imgPt2 = cv.Mat.from2DList(
      [
        <double>[414.88824, 848.23529],
        <double>[1034.8, 848.23529],
        <double>[1034.8, 1648.7059],
        <double>[414.88824, 1648.7059],
        <double>[1550.9714, 772],
        <double>[2303.7214, 772],
        <double>[2303.7214, 1744],
        <double>[1550.9714, 1744],
      ],
      cv.MatType.CV_64FC1,
    );

    final m = cv.findFundamentalMat(imgPt1, imgPt2, method: cv.FM_8POINT);
    expect(m.isEmpty, true); // TODO
  });

  test('cv.initUndistortRectifyMap', () async {
    final img = cv.imread("test/images/distortion.jpg", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);

    final k = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    k.set<double>(0, 0, 842.0261028);
    k.set<double>(0, 1, 0.0);
    k.set<double>(0, 2, 667.7569792);

    k.set<double>(1, 0, 0.0);
    k.set<double>(1, 1, 707.3668897);
    k.set<double>(1, 2, 385.56476464);

    k.set<double>(2, 0, 0.0);
    k.set<double>(2, 1, 0.0);
    k.set<double>(2, 2, 1.0);

    final d = cv.Mat.zeros(1, 5, cv.MatType.CV_64FC1);
    d.set<double>(0, 0, -3.65584802e-01);
    d.set<double>(0, 1, 1.41555815e-01);
    d.set<double>(0, 2, -2.62985819e-03);
    d.set<double>(0, 3, 2.05841873e-04);
    d.set<double>(0, 4, -2.35021914e-02);

    {
      final (newC, roi) = cv.getOptimalNewCameraMatrix(k, d, (img.cols, img.rows), 1);
      expect(newC.isEmpty, false);
      expect(roi.width, greaterThan(0));

      final r = cv.Mat.empty();
      final (map1, map2) = cv.initUndistortRectifyMap(k, d, r, newC, (img.cols, img.rows), 5);
      final dst = cv.remap(img, map1, map2, cv.INTER_LINEAR);
      expect(dst.isEmpty, false);
      final success = cv.imwrite("test/images/distortion-correct.png", dst);
      expect(success, true);
    }
    {
      final (newC, roi) = await cv.getOptimalNewCameraMatrixAsync(k, d, (img.cols, img.rows), 1);
      expect(newC.isEmpty, false);
      expect(roi.width, greaterThan(0));

      final r = cv.Mat.empty();
      final (map1, map2) = await cv.initUndistortRectifyMapAsync(k, d, r, newC, (img.cols, img.rows), 5);
      final dst = cv.remap(img, map1, map2, cv.INTER_LINEAR);
      expect(dst.isEmpty, false);
      final success = cv.imwrite("test/images/distortion-correct.png", dst);
      expect(success, true);
    }
  });

  // from https://github.com/shimat/opencvsharp/blob/main/test/OpenCvSharp.Tests/calib3d/Calib3dTest.cs
  test('cv.projectPoints', () async {
    final objectPoints = generate3DPoints();
    final intrinsicMat = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    intrinsicMat.set<double>(0, 0, 1.6415318549788924e+003);
    intrinsicMat.set<double>(1, 0, 0);
    intrinsicMat.set<double>(2, 0, 0);
    intrinsicMat.set<double>(0, 1, 0);
    intrinsicMat.set<double>(1, 1, 1.7067753507885654e+003);
    intrinsicMat.set<double>(2, 1, 0);
    intrinsicMat.set<double>(0, 2, 5.3262822453148601e+002);
    intrinsicMat.set<double>(1, 2, 3.8095355839052968e+002);
    intrinsicMat.set<double>(2, 2, 1);

    final rVec = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC1);
    rVec.set<double>(0, 0, -3.9277902400761393e-002);
    rVec.set<double>(1, 0, 3.7803824407602084e-002);
    rVec.set<double>(2, 0, 2.6445674487856268e-002);

    final tVec = cv.Mat.zeros(3, 1, cv.MatType.CV_64FC1);
    tVec.set<double>(0, 0, 2.1158489381208221e+000);
    tVec.set<double>(1, 0, -7.6847683212704716e+000);
    tVec.set<double>(2, 0, 2.6169795190294256e+001);

    final distCoeffs = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC1);
    distCoeffs.set<double>(0, 0, 0);
    distCoeffs.set<double>(1, 0, 0);
    distCoeffs.set<double>(2, 0, 0);
    distCoeffs.set<double>(3, 0, 0);

    {
      final (imagePoints, jacobian) = cv.projectPoints(objectPoints, rVec, tVec, intrinsicMat, distCoeffs);
      expect(imagePoints.isEmpty, false);
      expect(jacobian.isEmpty, false);
    }

    {
      final (imagePoints, jacobian) =
          await cv.projectPointsAsync(objectPoints, rVec, tVec, intrinsicMat, distCoeffs);
      expect(imagePoints.isEmpty, false);
      expect(jacobian.isEmpty, false);
    }
  });

  test('cv.recoverPose', () {
    final essential = cv.Mat.from2DList(
      [
        [1.503247056657373e-16, -7.074103796034695e-16, -7.781514175638166e-16],
        [6.720398606232961e-16, -6.189840821530359e-17, -0.7071067811865476],
        [7.781514175638166e-16, 0.7071067811865475, -2.033804841359975e-16],
      ],
      cv.MatType.CV_64FC1,
    );

    final p1 = cv.Mat.from2DList(
      [
        <double>[1017.0883, 848.23529],
        <double>[1637, 848.23529],
        <double>[1637, 1648.7059],
        <double>[1017.0883, 1648.7059],
        <double>[2282.2144, 772],
        <double>[3034.9644, 772],
        <double>[3034.9644, 1744],
        <double>[2282.2144, 1744],
      ],
      cv.MatType.CV_64FC1,
    );

    final p2 = cv.Mat.from2DList(
      [
        <double>[414.88824, 848.23529],
        <double>[1034.8, 848.23529],
        <double>[1034.8, 1648.7059],
        <double>[414.88824, 1648.7059],
        <double>[1550.9714, 772],
        <double>[2303.7214, 772],
        <double>[2303.7214, 1744],
        <double>[1550.9714, 1744],
      ],
      cv.MatType.CV_64FC1,
    );

    final k = cv.Mat.from2DList(
      [
        <double>[3011, 0, 1637],
        <double>[0, 3024, 1204],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );

    final (rval, r, t, _) = cv.recoverPoseWithCameraMatrix(essential, p1, p2, k);
    expect(rval, 0);
    expect(r.isEmpty, false);
    expect(t.isEmpty, false);
  });

  test('cv.Rodrigues', () {
    const double angle = 45;
    final cos = math.cos(angle * math.pi / 180);
    final sin = math.sin(angle * math.pi / 180);
    final matrix = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    matrix.set<double>(0, 0, cos);
    matrix.set<double>(0, 1, -sin);
    matrix.set<double>(1, 0, sin);
    matrix.set<double>(1, 1, cos);
    matrix.set<double>(2, 2, 1.0);
    final jacobian = cv.Mat.empty();
    final vector = cv.Rodrigues(matrix, jacobian: jacobian);
    expect(vector.isEmpty, false);
    expect(vector.total, 3);
    expect(vector.rows, 3);
    expect(vector.cols, 1);
    expect(vector.atNum(0, 0), closeTo(0, 1e-3));
    expect(vector.atNum(1, 0), closeTo(0, 1e-3));
    expect(vector.atNum(2, 0), closeTo(0.785, 1e-3));

    expect(jacobian.isEmpty, false);
    expect(jacobian.rows, 9);
    expect(jacobian.cols, 3);
  });

  test('cv.solvePnP', () async {
    final rvec = cv.Mat.fromList(3, 1, cv.MatType.CV_32FC1, <double>[0, 0, 0]);
    final tvec = cv.Mat.fromList(3, 1, cv.MatType.CV_32FC1, <double>[0, 0, 0]);
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[1, 0, 0],
        <double>[0, 1, 0],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_32FC1,
    );
    final dist = cv.Mat.fromList(5, 1, cv.MatType.CV_32FC1, <double>[0, 0, 0, 0, 0]);
    final objPts = cv.Mat.from2DList(
      [
        <double>[0, 0, 1],
        <double>[1, 0, 1],
        <double>[0, 1, 1],
        <double>[1, 1, 1],
        <double>[1, 0, 2],
        <double>[0, 1, 2],
      ],
      cv.MatType.CV_32FC1,
    );
    final (imgPts, jacobian) = cv.projectPoints(objPts, rvec, tvec, cameraMatrix, dist);
    expect(imgPts.isEmpty, false);
    expect(jacobian.isEmpty, false);

    final (rval, rv, tv) = cv.solvePnP(objPts, imgPts, cameraMatrix, dist);
    expect(rval, true);
    expect(rv.isEmpty, false);
    expect(tv.isEmpty, false);
  });
}
