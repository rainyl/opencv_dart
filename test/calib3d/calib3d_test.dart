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

  test('cv.computeCorrespondEpilines', () async {
    final points1 = cv.VecPoint2f.fromList([
      cv.Point2f(330, 123),
      cv.Point2f(330, 240),
      cv.Point2f(260, 223),
      cv.Point2f(202, 109),
      cv.Point2f(204, 207),
      cv.Point2f(118, 104),
      cv.Point2f(41, 174),
      cv.Point2f(205, 209),
    ]);
    final points2 = cv.VecPoint2f.fromList([
      cv.Point2f(268, 89),
      cv.Point2f(268, 207),
      cv.Point2f(212, 191),
      cv.Point2f(164, 82),
      cv.Point2f(168, 176),
      cv.Point2f(116, 74),
      cv.Point2f(29, 143),
      cv.Point2f(167, 178),
    ]);
    final mat1 = cv.Mat.fromVec(points1);
    final mat2 = cv.Mat.fromVec(points2);
    {
      final fundamentalMat = cv.findFundamentalMat(mat1, mat2, method: cv.FM_8POINT);
      final dst = cv.computeCorrespondEpilines(mat1, 1, fundamentalMat);
      expect(dst.isEmpty, false);
      expect(dst.rows, 8);
      expect(dst.cols, 1);
      expect(dst.channels, 3);
    }

    {
      final fundamentalMat = await cv.findFundamentalMatAsync(mat1, mat2, method: cv.FM_8POINT);
      final dst = await cv.computeCorrespondEpilinesAsync(mat1, 1, fundamentalMat);
      expect(dst.isEmpty, false);
      expect(dst.rows, 8);
      expect(dst.cols, 1);
      expect(dst.channels, 3);
    }
  });

  test('cv.convertPointsFromHomogeneous', () async {
    final homogeneous = cv.Mat.fromList(1, 4, cv.MatType.CV_32FC1, <double>[1, 2, 4, 2]);
    {
      final euclidean = cv.convertPointsFromHomogeneous(homogeneous);
      expect(euclidean.isEmpty, false);
      expect(euclidean.rows, 1);
      expect(euclidean.atNum(0, 0), closeTo(0.5, 1e-3));
      expect(euclidean.atNum(0, 1), closeTo(1.0, 1e-3));
      expect(euclidean.atNum(0, 2), closeTo(2.0, 1e-3));

      final homogeneous1 = cv.convertPointsToHomogeneous(euclidean);
      expect(homogeneous1.atNum(0, 0), closeTo(0.5, 1e-3));
      expect(homogeneous1.atNum(0, 1), closeTo(1, 1e-3));
      expect(homogeneous1.atNum(0, 2), closeTo(2, 1e-3));
      expect(homogeneous1.atNum(0, 3), closeTo(1, 1e-3));
    }

    {
      final euclidean = await cv.convertPointsFromHomogeneousAsync(homogeneous);
      expect(euclidean.isEmpty, false);
      expect(euclidean.rows, 1);
      expect(euclidean.atNum(0, 0), closeTo(0.5, 1e-3));
      expect(euclidean.atNum(0, 1), closeTo(1.0, 1e-3));
      expect(euclidean.atNum(0, 2), closeTo(2.0, 1e-3));

      final homogeneous1 = await cv.convertPointsToHomogeneousAsync(euclidean);
      expect(homogeneous1.atNum(0, 0), closeTo(0.5, 1e-3));
      expect(homogeneous1.atNum(0, 1), closeTo(1, 1e-3));
      expect(homogeneous1.atNum(0, 2), closeTo(2, 1e-3));
      expect(homogeneous1.atNum(0, 3), closeTo(1, 1e-3));
    }
  });

  test('cv.correctMatches', () async {
    final mat = cv.Mat.from2DList(
      [
        [133.28685454, 201.58760058, 126.28483141],
        [218.85759196, 214.70814757, 21.50269382],
        [151.29091759, 190.73174272, 38.21554576],
      ],
      cv.MatType.CV_32FC1,
    );
    final points3 = cv.Mat.from2DList(
      [
        [190.85422998, 55.05627181],
        [240.19097166, 206.9696157],
        [186.65860323, 123.41471593],
      ],
      cv.MatType.CV_32FC1,
    ).reshape(2, 1);
    final points2 = cv.Mat.from2DList(
      [
        [115.73466756, 63.21138927],
        [84.3030183, 225.45245352],
        [34.09884804, 98.12981797],
      ],
      cv.MatType.CV_32FC1,
    ).reshape(2, 1);

    {
      final (newPoints1, newPoints2) = cv.correctMatches(mat, points2, points3);
      expect(newPoints1.isEmpty, false);
      expect(newPoints2.isEmpty, false);
    }

    {
      final (newPoints1, newPoints2) = await cv.correctMatchesAsync(mat, points2, points3);
      expect(newPoints1.isEmpty, false);
      expect(newPoints2.isEmpty, false);
    }
  });

  test('cv.decomposeEssentialMat', () async {
    final E = cv.Mat.from2DList(
      [
        [0.0, -1.0, 0.0],
        [1.0, 0.0, -1.0],
        [0.0, 1.0, 0.0],
      ],
      cv.MatType.CV_64FC1,
    );
    {
      final (r1, r2, t) = cv.decomposeEssentialMat(E);
      expect(r1.isEmpty, false);
      expect(r2.isEmpty, false);
      expect(t.isEmpty, false);
    }

    {
      final (r1, r2, t) = await cv.decomposeEssentialMatAsync(E);
      expect(r1.isEmpty, false);
      expect(r2.isEmpty, false);
      expect(t.isEmpty, false);
    }
  });

  test('cv.decomposeHomographyMat', () async {
    final H = cv.Mat.from2DList(
      [
        [1.0, 0.2, 100.0],
        [0.1, 1.0, 200.0],
        [0.001, 0.002, 1.0],
      ],
      cv.MatType.CV_64FC1,
    );
    final K = cv.Mat.from2DList(
      [
        <double>[1000, 0, 320],
        <double>[0, 1000, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );

    {
      final (numSolutions, rotations, translations, normals) = cv.decomposeHomographyMat(H, K);
      expect(numSolutions, greaterThan(0));
      expect(rotations.isEmpty, false);
      expect(translations.isEmpty, false);
      expect(normals.isEmpty, false);
    }

    {
      final (numSolutions, rotations, translations, normals) = await cv.decomposeHomographyMatAsync(H, K);
      expect(numSolutions, greaterThan(0));
      expect(rotations.isEmpty, false);
      expect(translations.isEmpty, false);
      expect(normals.isEmpty, false);
    }
  });

  test('cv.decomposeProjectionMatrix', () async {
    final P = cv.Mat.from2DList(
      [
        <double>[500, 0, 320, 0],
        <double>[0, 500, 240, 0],
        <double>[0, 0, 1, 0],
      ],
      cv.MatType.CV_64FC1,
    );
    {
      final (cameraMatrix, rotMatrix, transVec) = cv.decomposeProjectionMatrix(P);
      expect(cameraMatrix.isEmpty, false);
      expect(rotMatrix.isEmpty, false);
      expect(transVec.isEmpty, false);
    }

    {
      final (cameraMatrix, rotMatrix, transVec) = await cv.decomposeProjectionMatrixAsync(P);
      expect(cameraMatrix.isEmpty, false);
      expect(rotMatrix.isEmpty, false);
      expect(transVec.isEmpty, false);
    }
  });

  test('cv.drawFrameAxes', () async {
    final image = cv.imread("test/images/lenna.png");
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final distCoeffs = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC1);
    final rvec = cv.Mat.from2DList(
      [
        [0.1],
        [0.2],
        [0.3],
      ],
      cv.MatType.CV_64FC1,
    );
    final tvec = cv.Mat.from2DList(
      [
        [0.0],
        [0.0],
        [5.0],
      ],
      cv.MatType.CV_64FC1,
    );
    {
      cv.drawFrameAxes(image, cameraMatrix, distCoeffs, rvec, tvec, 3.0);
      // cv.imwrite("a.png", image);
    }

    {
      await cv.drawFrameAxesAsync(image, cameraMatrix, distCoeffs, rvec, tvec, 3.0);
    }
  });

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

  test('cv.estimateAffine3D', () async {
    final src = cv.Mat.from2DList(
      [
        <double>[10, 10, 10],
        <double>[10, 10, 20],
        <double>[10, 20, 10],
        <double>[10, 20, 20],
      ],
      cv.MatType.CV_32FC1,
    );

    final dst = cv.Mat.from2DList(
      [
        <double>[-20, 20, 20],
        <double>[-20, 20, 40],
        <double>[20, 40, 20],
        <double>[20, 40, 40],
      ],
      cv.MatType.CV_32FC1,
    );

    {
      final (rval, rt, inliers) = cv.estimateAffine3D(src, dst);
      expect(rval, 1);
      expect(rt.isEmpty, false);
      expect(inliers.isEmpty, false);
    }

    {
      final (rval, rt, inliers) = await cv.estimateAffine3DAsync(src, dst);
      expect(rval, 1);
      expect(rt.isEmpty, false);
      expect(inliers.isEmpty, false);
    }
  });

  test('cv.estimateTranslation3D', () async {
    final src = cv.Mat.from3DList(
      [
        [
          [0.0, 0.0, 0.0],
        ],
        [
          [1.0, 0.0, 0.0],
        ],
        [
          [0.0, 1.0, 0.0],
        ],
        [
          [0.0, 0.0, 1.0],
        ]
      ],
      cv.MatType.CV_32FC3,
    );
    final dst = cv.Mat.from3DList(
      [
        [
          [1.0, 1.0, 1.0],
        ],
        [
          [2.0, 1.0, 1.0],
        ],
        [
          [1.0, 2.0, 1.0],
        ],
        [
          [1.0, 1.0, 2.0],
        ]
      ],
      cv.MatType.CV_32FC3,
    );
    {
      final (ret, translation, inliers) = cv.estimateTranslation3D(src, dst);
      expect(ret, 1);
      expect(translation.isEmpty, false);
      expect(inliers.isEmpty, false);
    }

    {
      final (ret, translation, inliers) = await cv.estimateTranslation3DAsync(src, dst);
      expect(ret, 1);
      expect(translation.isEmpty, false);
      expect(inliers.isEmpty, false);
    }
  });

  test('cv.estimateChessboardSharpness', () async {
    final img = cv.imread("test/images/chessboard_4x6_distort.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final (ret, corners) = cv.findChessboardCorners(img, (4, 6));
    expect(ret, true);
    expect(corners.isEmpty, false);
    {
      final rval = cv.estimateChessboardSharpness(img, (4, 6), cv.Mat.fromVec(corners));
      expect(rval.val1, closeTo(2.148, 1e-3));
    }

    {
      final rval = await cv.estimateChessboardSharpnessAsync(img, (4, 6), cv.Mat.fromVec(corners));
      expect(rval.val1, closeTo(2.148, 1e-3));
    }
  });

  test('cv.filterHomographyDecompByVisibleRefpoints', () async {
    final H = cv.Mat.from2DList(
      [
        [1.0, 0.2, 100.0],
        [0.1, 1.0, 200.0],
        [0.001, 0.002, 1.0],
      ],
      cv.MatType.CV_64FC1,
    );
    final K = cv.Mat.from2DList(
      [
        <double>[1000, 0, 320],
        <double>[0, 1000, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final refPoints = cv.Mat.from3DList(
      [
        [
          <double>[100, 100],
        ],
        [
          <double>[200, 100],
        ],
        [
          <double>[200, 200],
        ],
        [
          <double>[100, 200],
        ],
      ],
      cv.MatType.CV_32FC2,
    );

    {
      final (numSolutions, rotations, translations, normals) = cv.decomposeHomographyMat(H, K);
      final projPoints = cv.perspectiveTransform(refPoints, H);
      expect(projPoints.isEmpty, false);
      final goodIndices =
          cv.filterHomographyDecompByVisibleRefpoints(rotations, normals, refPoints, projPoints);
      expect(goodIndices.isEmpty, false);
    }

    {
      final (numSolutions, rotations, translations, normals) = await cv.decomposeHomographyMatAsync(H, K);
      final projPoints = await cv.perspectiveTransformAsync(refPoints, H);
      expect(projPoints.isEmpty, false);
      final goodIndices =
          await cv.filterHomographyDecompByVisibleRefpointsAsync(rotations, normals, refPoints, projPoints);
      expect(goodIndices.isEmpty, false);
    }
  });

  test('cv.filterSpeckles', () async {
    final image = cv.Mat.randu(480, 640, cv.MatType.CV_8UC1, low: cv.Scalar.black, high: cv.Scalar.white);
    {
      cv.filterSpeckles(image, 0, 50, 16);
    }

    {
      await cv.filterSpecklesAsync(image, 0, 50, 16);
    }
  });

  test('cv.find4QuadCornerSubpix', () async {
    final image = cv.imread("test/images/chessboard_4x6.png", flags: cv.IMREAD_GRAYSCALE);
    final (ret, corners) = cv.findChessboardCorners(image, (4, 6));
    expect(ret, true);

    final _corners = cv.Mat.fromVec(corners);
    {
      final refinedCorners = cv.find4QuadCornerSubpix(image, _corners, (5, 5));
      expect(refinedCorners, true);
      expect(_corners.isEmpty, false);
    }

    {
      final refinedCorners = await cv.find4QuadCornerSubpixAsync(image, _corners, (5, 5));
      expect(refinedCorners, true);
      expect(_corners.isEmpty, false);
    }
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

      final img2 = cv.Mat.zeros(150, 150, cv.MatType.CV_8UC1);
      await cv.drawChessboardCornersAsync(img2, (4, 6), corners, true);
      expect(img2.isEmpty, false);
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

  test('cv.findCirclesGrid', () async {
    final image = cv.imread("test/images/circles_grid.jpg", flags: cv.IMREAD_GRAYSCALE);
    {
      final (found, centers) = cv.findCirclesGrid(image, cv.Size(8, 12));
      expect(found, true);
      expect(centers.isEmpty, false);
      expect(centers.total, 8 * 12);
    }

    {
      final (found, centers) = await cv.findCirclesGridAsync(image, cv.Size(8, 12));
      expect(found, true);
      expect(centers.isEmpty, false);
      expect(centers.total, 8 * 12);
    }
  });

  test('cv.findEssentialMat', () async {
    final points1 = cv.Mat.from2DList(
      [
        <double>[150, 200],
        <double>[130, 210],
        <double>[120, 230],
        <double>[110, 250],
        <double>[100, 270],
      ],
      cv.MatType.CV_32FC1,
    );
    final points2 = cv.Mat.from2DList(
      [
        <double>[152, 202],
        <double>[132, 212],
        <double>[122, 232],
        <double>[112, 252],
        <double>[102, 272],
      ],
      cv.MatType.CV_32FC1,
    );
    final K = cv.Mat.from2DList(
      [
        <double>[1000, 0, 320],
        <double>[0, 1000, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_32FC1,
    );
    {
      final E = cv.findEssentialMatCameraMatrix(points1, points2, K);
      expect(E.isEmpty, false);
    }

    {
      final E = await cv.findEssentialMatCameraMatrixAsync(points1, points2, K);
      expect(E.isEmpty, false);
    }

    {
      final E = cv.findEssentialMat(points1, points2);
      expect(E.isEmpty, false);
    }

    {
      final E = await cv.findEssentialMatAsync(points1, points2);
      expect(E.isEmpty, false);
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
    final points1 = cv.Mat.from3DList(
      [
        [
          <double>[150, 200],
        ],
        [
          <double>[130, 210],
        ],
        [
          <double>[120, 230],
        ],
        [
          <double>[110, 250],
        ],
        [
          <double>[200, 100],
        ],
        [
          <double>[210, 120],
        ],
        [
          <double>[230, 140],
        ],
        [
          <double>[250, 160],
        ],
      ],
      cv.MatType.CV_32FC2,
    );

    final points2 = cv.Mat.from3DList(
      [
        [
          <double>[152, 202],
        ],
        [
          <double>[132, 212],
        ],
        [
          <double>[122, 232],
        ],
        [
          <double>[112, 252],
        ],
        [
          <double>[202, 102],
        ],
        [
          <double>[212, 122],
        ],
        [
          <double>[232, 142],
        ],
        [
          <double>[252, 162],
        ],
      ],
      cv.MatType.CV_32FC2,
    );
    final mask = cv.Mat.empty();

    {
      final m = cv.findHomographyUsac(
        points1,
        points2,
        cv.UsacParams(confidence: 0.99, maxIterations: 1000, threshold: 0.5, sampler: cv.SAMPLING_UNIFORM),
        mask: mask,
      );
      expect(m.isEmpty, false);
    }

    {
      final m = await cv.findHomographyUsacAsync(
        points1,
        points2,
        cv.UsacParams(confidence: 0.99, maxIterations: 1000, threshold: 0.5, sampler: cv.SAMPLING_UNIFORM),
        mask: mask,
      );
      expect(m.isEmpty, false);
    }
  });

  test('cv.findFundamentalMat', () async {
    final imgPt1 = cv.Mat.from2DList(
      [
        <double>[150, 200],
        <double>[130, 210],
        <double>[120, 230],
        <double>[110, 250],
        <double>[200, 100],
        <double>[210, 120],
        <double>[230, 140],
        <double>[250, 160],
      ],
      cv.MatType.CV_32FC1,
    );

    final imgPt2 = cv.Mat.from2DList(
      [
        <double>[152, 202],
        <double>[132, 212],
        <double>[122, 232],
        <double>[112, 252],
        <double>[202, 102],
        <double>[212, 122],
        <double>[232, 142],
        <double>[252, 162],
      ],
      cv.MatType.CV_32FC1,
    );

    {
      final m = cv.findFundamentalMat(imgPt1, imgPt2, method: cv.FM_RANSAC);
      expect(m.isEmpty, false);
    }

    {
      final m = await cv.findFundamentalMatAsync(imgPt1, imgPt2, method: cv.FM_RANSAC);
      expect(m.isEmpty, false);
    }

    {
      final m = cv.findFundamentalMatUsac(
        imgPt1,
        imgPt2,
        cv.UsacParams(confidence: 0.999, maxIterations: 2000, threshold: 1.0),
      );
      expect(m.isEmpty, false);
    }

    {
      final m = await cv.findFundamentalMatUsacAsync(
        imgPt1,
        imgPt2,
        cv.UsacParams(confidence: 0.999, maxIterations: 2000, threshold: 1.0),
      );
      expect(m.isEmpty, false);
    }
  });

  test('cv.getDefaultNewCameraMatrix', () async {
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_32FC1,
    );
    final distCoeffs = cv.Mat.from2DList(
      [
        <double>[-0.1, 0.1, 0, 0],
      ],
      cv.MatType.CV_32FC1,
    );
    {
      final newCameraMatrix =
          cv.getDefaultNewCameraMatrix(cameraMatrix, imgsize: cv.Size(640, 480), centerPrincipalPoint: true);
      expect(newCameraMatrix.isEmpty, false);
      expect(newCameraMatrix.rows, 3);
      expect(newCameraMatrix.cols, 3);

      final (_, map1, map2) = cv.initWideAngleProjMap(
          cameraMatrix, distCoeffs, cv.Size(640, 480), 480, cv.MatType.CV_32FC1.value);
      expect(map1.isEmpty, false);
      expect(map2.isEmpty, false);
    }

    {
      final newCameraMatrix = await cv.getDefaultNewCameraMatrixAsync(cameraMatrix,
          imgsize: cv.Size(640, 480), centerPrincipalPoint: true);
      expect(newCameraMatrix.isEmpty, false);
      expect(newCameraMatrix.rows, 3);
      expect(newCameraMatrix.cols, 3);

      final (_, map1, map2) = await cv.initWideAngleProjMapAsync(
          cameraMatrix, distCoeffs, cv.Size(640, 480), 480, cv.MatType.CV_32FC1.value);
      expect(map1.isEmpty, false);
      expect(map2.isEmpty, false);
    }
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

  test('cv.matMulDeriv', () async {
    final A = cv.Mat.fromList(2, 2, cv.MatType.CV_32FC1, <double>[1, 2, 3, 4]);
    final B = cv.Mat.fromList(2, 2, cv.MatType.CV_32FC1, <double>[5, 6, 7, 8]);
    {
      final (dABdA, dABdB) = cv.matMulDeriv(A, B);
      expect(dABdA.isEmpty, false);
      expect(dABdB.isEmpty, false);
    }

    {
      final (dABdA, dABdB) = await cv.matMulDerivAsync(A, B);
      expect(dABdA.isEmpty, false);
      expect(dABdB.isEmpty, false);
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

  test('cv.recoverPoseCameraMatrix', () async {
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

    {
      final (rval, r, t, _) = cv.recoverPoseCameraMatrix(essential, p1, p2, k);
      expect(rval, 0);
      expect(r.isEmpty, false);
      expect(t.isEmpty, false);
    }

    {
      final (rval, r, t, _) = await cv.recoverPoseCameraMatrixAsync(essential, p1, p2, k);
      expect(rval, 0);
      expect(r.isEmpty, false);
      expect(t.isEmpty, false);
    }
  });

  test('cv.recoverPose', () async {
    final points1 = cv.Mat.from2DList(
      [
        <double>[150, 200],
        <double>[130, 210],
        <double>[120, 230],
        <double>[110, 250],
        <double>[200, 100],
        <double>[210, 120],
        <double>[230, 140],
        <double>[250, 160],
      ],
      cv.MatType.CV_64FC1,
    );

    final points2 = cv.Mat.from2DList(
      [
        <double>[152, 202],
        <double>[132, 212],
        <double>[122, 232],
        <double>[112, 252],
        <double>[202, 102],
        <double>[212, 122],
        <double>[232, 142],
        <double>[252, 162],
      ],
      cv.MatType.CV_64FC1,
    );

    final K = cv.Mat.from2DList(
      [
        <double>[1000, 0, 320],
        <double>[0, 1000, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );

    {
      final E = cv.findEssentialMatCameraMatrix(points1, points2, K, method: cv.FM_RANSAC);
      final (rval, r, t) = cv.recoverPose(E, points1, points2);
      expect(rval, isA<int>());
      expect(r.isEmpty, false);
      expect(t.isEmpty, false);
    }

    {
      final E = await cv.findEssentialMatCameraMatrixAsync(points1, points2, K, method: cv.FM_RANSAC);
      final (rval, r, t) = await cv.recoverPoseAsync(E, points1, points2);
      expect(rval, isA<int>());
      expect(r.isEmpty, false);
      expect(t.isEmpty, false);
    }
  });

  test('cv.RQDecomp3x3', () async {
    final K = cv.Mat.from2DList(
      [
        <double>[1000, 0, 320],
        <double>[0, 1000, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    {
      final (rval, R, Q) = cv.RQDecomp3x3(K);
      expect(rval, cv.Vec3d(0, 0, 0));
      expect(R.isEmpty, false);
      expect(Q.isEmpty, false);
    }

    {
      final (rval, R, Q) = await cv.RQDecomp3x3Async(K);
      expect(rval, cv.Vec3d(0, 0, 0));
      expect(R.isEmpty, false);
      expect(Q.isEmpty, false);
    }
  });

  test('cv.Rodrigues', () async {
    const double angle = 45;
    final cos = math.cos(angle * math.pi / 180);
    final sin = math.sin(angle * math.pi / 180);
    final matrix = cv.Mat.zeros(3, 3, cv.MatType.CV_64FC1);
    matrix.set<double>(0, 0, cos);
    matrix.set<double>(0, 1, -sin);
    matrix.set<double>(1, 0, sin);
    matrix.set<double>(1, 1, cos);
    matrix.set<double>(2, 2, 1.0);
    {
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
    }

    {
      final jacobian = cv.Mat.empty();
      final vector = await cv.RodriguesAsync(matrix, jacobian: jacobian);
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
    }
  });

  test('cv.sampsonDistance', () {
    final points1 = cv.Mat.from2DList(
      [
        <double>[150, 200, 1],
        <double>[130, 210, 1],
        <double>[120, 230, 1],
        <double>[110, 250, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final points2 = cv.Mat.from2DList(
      [
        <double>[152, 202, 1],
        <double>[132, 212, 1],
        <double>[122, 232, 1],
        <double>[112, 252, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final F = cv.Mat.from2DList(
      [
        <double>[1.292e-6, 3.303e-5, -0.004],
        <double>[-3.299e-5, 1.120e-6, 0.017],
        <double>[0.004, -0.017, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final sampsonDistances = cv.sampsonDistance(points1, points2, F);
    expect(sampsonDistances, closeTo(4034.6767, 1e-3));
  });

  test('cv.solveP3P', () async {
    final objectPoints = cv.Mat.from2DList(
      [
        <double>[0, 0, 0],
        <double>[1, 0, 0],
        <double>[0, 1, 0],
      ],
      cv.MatType.CV_64FC1,
    );
    final imagePoints = cv.Mat.from2DList(
      [
        <double>[320, 240],
        <double>[400, 240],
        <double>[320, 320],
      ],
      cv.MatType.CV_64FC1,
    );
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final distCoeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    {
      final (ret, rvecs, tvecs) =
          cv.solveP3P(objectPoints, imagePoints, cameraMatrix, distCoeffs, cv.SOLVEPNP_P3P);
      expect(ret, 2);
      expect(rvecs.isEmpty, false);
      expect(tvecs.isEmpty, false);
    }

    {
      final (ret, rvecs, tvecs) =
          await cv.solveP3PAsync(objectPoints, imagePoints, cameraMatrix, distCoeffs, cv.SOLVEPNP_P3P);
      expect(ret, 2);
      expect(rvecs.isEmpty, false);
      expect(tvecs.isEmpty, false);
    }
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
    {
      final (imgPts, jacobian) = cv.projectPoints(objPts, rvec, tvec, cameraMatrix, dist);
      expect(imgPts.isEmpty, false);
      expect(jacobian.isEmpty, false);

      final (rval, rv, tv) = cv.solvePnP(objPts, imgPts, cameraMatrix, dist);
      expect(rval, true);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);

      cv.solvePnPRefineLM(objPts, imgPts, cameraMatrix, dist, rv, tv);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);
    }

    {
      final (imgPts, jacobian) = await cv.projectPointsAsync(objPts, rvec, tvec, cameraMatrix, dist);
      expect(imgPts.isEmpty, false);
      expect(jacobian.isEmpty, false);

      final (rval, rv, tv) = await cv.solvePnPAsync(objPts, imgPts, cameraMatrix, dist);
      expect(rval, true);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);

      await cv.solvePnPRefineLMAsync(objPts, imgPts, cameraMatrix, dist, rv, tv);
      expect(rv.isEmpty, false);
      expect(tv.isEmpty, false);
    }
  });

  test('cv.solvePnPGeneric', () async {
    final objectPoints = cv.Mat.from2DList(
      [
        <double>[0, 0, 0],
        <double>[1, 0, 0],
        <double>[0, 1, 0],
        <double>[1, 1, 0],
        <double>[0.5, 0.5, 1],
        <double>[0, 0.5, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final imagePoints = cv.Mat.from2DList(
      [
        <double>[320, 240],
        <double>[400, 240],
        <double>[320, 320],
        <double>[400, 320],
        <double>[360, 270],
        <double>[300, 250],
      ],
      cv.MatType.CV_64FC1,
    );
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final distCoeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    {
      final (ret, rvecs, tvecs, err) =
          cv.solvePnPGeneric(objectPoints, imagePoints, cameraMatrix, distCoeffs);
      expect(ret, 1);
      expect(rvecs.length, 1);
      expect(tvecs.length, 1);
      expect(err.isEmpty, false);
    }

    {
      final (ret, rvecs, tvecs, err) =
          await cv.solvePnPGenericAsync(objectPoints, imagePoints, cameraMatrix, distCoeffs);
      expect(ret, 1);
      expect(rvecs.length, 1);
      expect(tvecs.length, 1);
      expect(err.isEmpty, false);
    }
  });

  test('cv.solvePnPRansac', () async {
    final objectPoints = cv.Mat.from2DList(
      [
        <double>[0, 0, 0],
        <double>[1, 0, 0],
        <double>[0, 1, 0],
        <double>[1, 1, 0],
        <double>[0.5, 0.5, 1],
        <double>[0, 0.5, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final imagePoints = cv.Mat.from2DList(
      [
        <double>[320, 240],
        <double>[400, 240],
        <double>[320, 320],
        <double>[400, 320],
        <double>[360, 270],
        <double>[300, 250],
      ],
      cv.MatType.CV_64FC1,
    );
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final distCoeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_64FC1);
    {
      final (ret, rvec, tvec, inliers) =
          cv.solvePnPRansac(objectPoints, imagePoints, cameraMatrix, distCoeffs);
      expect(ret, true);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
      expect(inliers.isEmpty, false);

      cv.solvePnPRefineVVS(objectPoints, imagePoints, cameraMatrix, distCoeffs, rvec, tvec);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
    }

    {
      final (ret, rvec, tvec, inliers) =
          await cv.solvePnPRansacAsync(objectPoints, imagePoints, cameraMatrix, distCoeffs);
      expect(ret, true);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
      expect(inliers.isEmpty, false);

      await cv.solvePnPRefineVVSAsync(objectPoints, imagePoints, cameraMatrix, distCoeffs, rvec, tvec);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
    }

    {
      final usac = cv.UsacParams(
        confidence: 0.99,
        maxIterations: 1000,
        threshold: 0.5,
        loMethod: cv.LOCAL_OPTIM_NULL,
        sampler: cv.SAMPLING_UNIFORM,
      );
      final (ret, rvec, tvec, inliers) =
          cv.solvePnPRansacUsac(objectPoints, imagePoints, cameraMatrix, distCoeffs, params: usac);
      expect(ret, true);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
      expect(inliers.isEmpty, false);
    }

    {
      final usac = cv.UsacParams(
        confidence: 0.99,
        maxIterations: 1000,
        threshold: 0.5,
        loMethod: cv.LOCAL_OPTIM_NULL,
        sampler: cv.SAMPLING_UNIFORM,
      );
      final (ret, rvec, tvec, inliers) =
          await cv.solvePnPRansacUsacAsync(objectPoints, imagePoints, cameraMatrix, distCoeffs, params: usac);
      expect(ret, true);
      expect(rvec.isEmpty, false);
      expect(tvec.isEmpty, false);
      expect(inliers.isEmpty, false);
    }
  });

  test('cv.triangulatePoints', () async {
    final projMat1 = cv.Mat.zeros(3, 4, cv.MatType.CV_64FC1);
    final projMat2 = cv.Mat.zeros(3, 4, cv.MatType.CV_64FC1);

    final projPoints1 = cv.Mat.from3DList(
      [
        [
          [1.0, 2.0],
        ],
      ],
      cv.MatType.CV_64FC2,
    );
    final projPoints2 = cv.Mat.from3DList(
      [
        [
          [3.0, 4.0],
        ],
      ],
      cv.MatType.CV_64FC2,
    );
    {
      final homogeneous = cv.triangulatePoints(projMat1, projMat2, projPoints1, projPoints2);
      expect(homogeneous.isEmpty, false);
    }

    {
      final homogeneous = await cv.triangulatePointsAsync(projMat1, projMat2, projPoints1, projPoints2);
      expect(homogeneous.isEmpty, false);
    }
  });

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

  test('cv.undistortImagePoints', () async {
    final cameraMatrix = cv.Mat.from2DList(
      [
        <double>[800, 0, 320],
        <double>[0, 800, 240],
        <double>[0, 0, 1],
      ],
      cv.MatType.CV_64FC1,
    );
    final distCoeffs = cv.Mat.fromList(1, 4, cv.MatType.CV_64FC1, [-0.2, 0.1, 0.0, 0.0]);
    final distortedPoints = cv.Mat.from3DList(
      [
        [
          <double>[320, 240],
          <double>[400, 240],
          <double>[320, 320],
          <double>[400, 320],
        ]
      ],
      cv.MatType.CV_64FC2,
    );
    {
      final undistorted = cv.undistortImagePoints(distortedPoints, cameraMatrix, distCoeffs);
      expect(undistorted.isEmpty, false);
    }

    {
      final undistorted = await cv.undistortImagePointsAsync(distortedPoints, cameraMatrix, distCoeffs);
      expect(undistorted.isEmpty, false);
    }
  });
}
