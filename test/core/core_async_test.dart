// ignore_for_file: avoid_print

import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {

  test('cv.absDiffAsync', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = await cv.absDiffAsync(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(1));
  });

  test('cv.addAsync', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = await cv.addAsync(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(1));
  });

  test('cv.addWeightedAsync', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = await cv.addWeightedAsync(mat0, 0.5, mat1, 0.5, 1);
    expect(dst.at<int>(0, 0, 0), equals(75 + 1));
  });

  test('cv.bitwise_and async', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = await cv.bitwiseANDAsync(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 & 50));
  });

  test('cv.bitwise_not async', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final dst = await cv.bitwiseNOTAsync(mat0);
    expect(dst.at<int>(0, 0, 0), equals(155));
  });

  test('cv.bitwise_or async', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = await cv.bitwiseORAsync(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 | 50));
  });

  test('cv.bitwise_xor async', () async {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = await cv.bitwiseXORAsync(mat0, mat1);
    expect(dst.at<int>(0, 0, 0), equals(100 ^ 50));
  });

  test('cv.batchDistance async', () async {
    final mat0 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mask = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final (dist, _) = await cv.batchDistanceAsync(mat0, mat1, -1, K: 15, mask: mask);
    expect(dist.isEmpty, equals(false));
  });

  test('cv.borderInterpolate async', () async {
    final n = await cv.borderInterpolateAsync(1, 5, cv.BORDER_DEFAULT);
    expect(n != 0, equals(true));
  });

  test('cv.calcCovarMatrix async', () async {
    final samples = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final mean = cv.Mat.empty();
    final (covar, _) = await cv.calcCovarMatrixAsync(samples, mean, cv.COVAR_ROWS);
    expect(covar.isEmpty, equals(false));
  });

  test('cv.cartToPolar async', () async {
    final x = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final y = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final (magnitude, angle) = await cv.cartToPolarAsync(x, y, angleInDegrees: false);
    expect(magnitude.isEmpty || angle.isEmpty, equals(false));
  });

  test('cv.checkRange async', () async {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final (success, pos) = await cv.checkRangeAsync(mat1);
    expect(success, equals(true));
    expect(pos, equals(cv.Point(0, 0)));
  });

  test('cv.compare async', () async {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final mat2 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final dst = await cv.compareAsync(mat1, mat2, cv.CMP_EQ);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.countNonZero async', () async {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_8UC1);
    final n = await cv.countNonZeroAsync(mat1);
    expect(n, equals(101 * 102));
  });

  test('cv.completeSymm async', () async {
    final mat1 = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    await cv.completeSymmAsync(mat1);
    expect(mat1.at<double>(99, 0), equals(mat1.at<double>(0, 99)));
  });

  test("cv.convertScaleAbs async", () async {
    final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_32FC1);
    final dst = await cv.convertScaleAbsAsync(src, alpha: 1, beta: 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.copyMakeBorder async', () async {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = await cv.copyMakeBorderAsync(src, 10, 10, 10, 10, cv.BORDER_REFLECT, value: cv.Scalar.all(0));
    expect(dst.isEmpty, equals(false));
  });

  test('cv.dct async', () async {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = await cv.dctAsync(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.determinant async', () async {
    final src = cv.Mat.zeros(101, 101, cv.MatType.CV_32FC1);
    final ret = await cv.determinantAsync(src);
    expect(ret, equals(0));
  });

  test('cv.dft async', () async {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_32FC1);
    final m = await cv.getOptimalDFTSizeAsync(101);
    final n = await cv.getOptimalDFTSizeAsync(102);
    expect(m, equals(108));
    expect(n, equals(108));
    final dst = await cv.dftAsync(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.divide async', () async {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final mat2 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final dst = await cv.divideAsync(mat1, mat2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.eigen async', () async {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final (_, eigenValues, eigenVectors) = await cv.eigenAsync(src);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.eigenNonSymmetric async', () async {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final (eigenValues, eigenVectors) = await cv.eigenNonSymmetricAsync(src);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.PCACompute async', () async {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final mean = cv.Mat.empty();
    final (_, eigenvectors, eigenvalues) = await cv.PCAComputeAsync(
      src,
      mean,
      maxComponents: 2,
    );
    expect(mean.isEmpty || eigenvectors.isEmpty || eigenvalues.isEmpty, equals(false));
    expect(eigenvectors.rows, equals(2));
  });

  test('cv.exp async', () async {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = await cv.expAsync(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.at<double>(0, 0), equals(1));
  });

  test('cv.extractChannel async', () async {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC3);
    final dst = await cv.extractChannelAsync(src, 2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.findNonZero async', () async {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = await cv.findNonZeroAsync(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.flip async', () async {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = await cv.flipAsync(src, 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.gemm async', () async {
    final src1 = cv.Mat.randu(3, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final src3 = cv.Mat.empty();
    final dst = await cv.gemmAsync(src1, src2, 1, src3, 0);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src1.rows));
  });

  test('cv.hconcat async', () async {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = await cv.hconcatAsync(src, src);
    expect(dst.isEmpty, equals(false));
    expect(dst.cols, equals(src.cols * 2));
  });

  test('cv.vconcat async', () async {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = await cv.vconcatAsync(src, src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows * 2));
  });

  test('cv.rotate async', () async {
    final src = cv.Mat.zeros(10, 20, cv.MatType.CV_8UC1);
    final dst = await cv.rotateAsync(src, cv.ROTATE_90_CLOCKWISE);
    expect(dst.isEmpty, equals(false));
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.idct async', () async {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = await cv.idctAsync(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.idft async', () async {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = await cv.idftAsync(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.inRange async', () async {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC1, cv.Scalar(20, 100, 100, 0));
    final ub = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC1, cv.Scalar(20, 100, 100, 0));
    final dst = await cv.inRangeAsync(mat1, lb, ub);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.inRangebyScalar async', () async {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Scalar(20, 100, 100, 0);
    final ub = cv.Scalar(20, 100, 100, 0);
    final dst = await cv.inRangebyScalarAsync(mat1, lb, ub);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.insertChannel async', () async {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_8UC1);
    final dst = cv.Mat.randu(4, 4, cv.MatType.CV_8UC3);
    await cv.insertChannelAsync(src, dst, 1);
    expect(dst.channels, equals(3));
  });

  test('cv.invert async', () async {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final (_, dst) = await cv.invertAsync(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.kmeans async', () async {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final bestLabels = cv.Mat.empty();
    const criteria = (cv.TERM_COUNT, 10, 1.0);
    final (_, _, centers) = await cv.kmeansAsync(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS);
    expect(centers.isEmpty, equals(false));
  });

  test('cv.kmeansByPoints async', () async {
    final src = <cv.Point2f>[cv.Point2f(0, 0), cv.Point2f(1, 1)].cvd;
    final bestLabels = cv.Mat.empty();
    const criteria = (cv.TERM_COUNT, 10, 1.0);
    final (_, _, centers) =
        await cv.kmeansByPointsAsync(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS);
    expect(centers.isEmpty, equals(false));
  });

  test('cv.log async', () async {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final dst = await cv.logAsync(src);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.LUT async', () async {
    Future<void> testOneLUT(cv.Mat src, cv.Mat lut) async {
      expect(lut.channels == src.channels || lut.channels == 1, true);
      expect(lut.isContinus, true);
      final sw = Stopwatch();
      sw.start();
      final dst = await cv.LUTAsync(src, lut);
      sw.stop();
      // print('${src.type} -> ${lut.type}(${src.rows}x${src.cols}): ${sw.elapsedMilliseconds}ms');
      expect(dst.isEmpty, false);
      expect(src.shape, dst.shape);
    }

    final depthSrc = [cv.MatType.CV_8U, cv.MatType.CV_8S, cv.MatType.CV_16U, cv.MatType.CV_16S];
    final depthLut = [
      cv.MatType.CV_8U,
      cv.MatType.CV_8S,
      cv.MatType.CV_16U,
      cv.MatType.CV_16S,
      cv.MatType.CV_32S,
      cv.MatType.CV_32F,
      cv.MatType.CV_64F,
    ];
    for (final int channel in [1, 2, 3, 4]) {
      for (final depth in depthSrc) {
        final srcType = cv.MatType.makeType(depth, channel);
        final src = cv.Mat.randu(3, 3, srcType, low: cv.Scalar.all(0), high: cv.Scalar.all(255));
        final lutSize = switch (depth) {
          cv.MatType.CV_8U || cv.MatType.CV_8S => 256,
          cv.MatType.CV_16U || cv.MatType.CV_16S => 65536,
          _ => throw Exception("Unsupported type"),
        };
        for (final lutDepth in depthLut) {
          final lutType = cv.MatType.makeType(lutDepth, channel);
          // 0-1: 65536-1-0 2-3: 65536-1-1 3-4: 65536-1-2
          final lutData = switch (lutDepth) {
            cv.MatType.CV_32F ||
            cv.MatType.CV_64F =>
              List.generate(lutSize * lutType.channels, (i) => (lutSize - (i ~/ channel) - 1).toDouble()),
            _ => List.generate(lutSize * lutType.channels, (i) => lutSize - (i ~/ channel) - 1),
          };
          final lutInverse = cv.Mat.fromList(1, lutSize, lutType, lutData);
          await testOneLUT(src, lutInverse);
        }
      }
    }
  });

  test('cv.LUT 1 async', () async {
    final mat = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final src = mat.convertTo(cv.MatType.CV_16UC3, alpha: 65536.0 / 255.0);
    final lutData = List.generate(65536 * 3, (i) => 65536 - (i ~/ 3) - 1);
    final lut = cv.Mat.fromList(1, 65536, cv.MatType.CV_16UC3, lutData);
    final dst = await cv.LUTAsync(src, lut);
    expect(dst.isEmpty, equals(false));
    expect(dst.shape, src.shape);
    // cv.imwrite("lut.png", dst.convertTo(cv.MatType.CV_8UC3, alpha: 255.0/65536.0));
  });

  test('cv.magnitude async', () async {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = await cv.magnitudeAsync(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.max async', () async {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = await cv.maxAsync(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.min async', () async {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = await cv.minAsync(src1, src2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.meanStdDev async', () async {
    final src = cv.Mat.randu(101, 102, cv.MatType.CV_8UC3);
    final (mean, stdDev) = await cv.meanStdDevAsync(src);
    expect(mean.val, isNotEmpty);
    expect(stdDev.val, isNotEmpty);
  });

  test('cv.merge async', () async {
    final src = [
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
    ].cvd;
    final dst = await cv.mergeAsync(src);
    expect(dst.isEmpty, equals(false));
    expect(dst.channels, equals(3));
  });

  test('cv.minMaxIdx async', () async {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minIdx, maxIdx) = await cv.minMaxIdxAsync(src);
    expect(minIdx, greaterThanOrEqualTo(0));
    expect(maxIdx, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  test('cv.minMaxLoc async', () async {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minLoc, maxLoc) = await cv.minMaxLocAsync(src);
    expect(minLoc.x, greaterThanOrEqualTo(0));
    expect(maxLoc.x, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  test('cv.mixChannels async', () async {
    final bgra = cv.Mat.fromScalar(100, 100, cv.MatType.CV_8UC4, cv.Scalar(255, 0, 0, 255));
    final bgr = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC3);
    final alpha = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC1);
    final out = [bgr, alpha].cvd;
    final fromTo = [0, 2, 1, 1, 2, 0, 3, 3].i32;
    final dst = await cv.mixChannelsAsync([bgra].cvd, out, fromTo);
    expect(dst.isEmpty, false);
  });

  test('cv.mulSpectrums async', () async {
    final a = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);

    final dst = await cv.mulSpectrumsAsync(a, b, 0);
    expect(dst.isEmpty, false);

    final dst1 = await cv.mulSpectrumsAsync(a, b, cv.DFT_ROWS);
    expect(dst1.isEmpty, false);
  });

  test('cv.multiply async', () async {
    final mat1 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat2 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat3 = await cv.multiplyAsync(mat1, mat2);
    expect(mat3.isEmpty, equals(false));
    expect(mat3.at<double>(0, 0), equals(mat1.at<double>(0, 0) * mat2.at<double>(0, 0)));
  });

  test('cv.normalize async', () async {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    await cv.normalizeAsync(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.norm async', () async {
    final src1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n = await cv.normAsync(src1);
    expect(n, equals(0));

    final src2 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n1 = await cv.norm1Async(src1, src2);
    expect(n1, equals(0));
  });

  test('cv.perspectiveTransform async', () async {
    final src = cv.Mat.zeros(100, 1, cv.MatType.CV_32FC2);
    final tm = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    final dst = await cv.perspectiveTransformAsync(src, tm);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.solve async', () async {
    final a = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(3, 1, cv.MatType.CV_32FC1);
    final testPoints = [
      (1.0, 1.0, 1.0, 0.0),
      (0.0, 0.0, 1.0, 2.0),
      (9.0, 3.0, 1.0, 2.0),
    ];
    for (var i = 0; i < testPoints.length; i++) {
      a.set<double>(i, 0, testPoints[i].$1);
      a.set<double>(i, 1, testPoints[i].$2);
      a.set<double>(i, 2, testPoints[i].$3);
      b.set<double>(i, 0, testPoints[i].$4);
    }
    final (solved, solve) = await cv.solveAsync(a, b, flags: cv.DECOMP_LU);
    expect(solved, equals(true));
    expect((solve.at<double>(0, 0), solve.at<double>(1, 0), solve.at<double>(2, 0)), (1, -3, 2));
  });

  test('cv.solveCubic async', () async {
    final coeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_32FC1);
    coeffs.set<double>(0, 0, 2.0);
    coeffs.set<double>(0, 1, 3.0);
    coeffs.set<double>(0, 2, -11.0);
    coeffs.set<double>(0, 3, -6.0);

    final (rootsCount, roots) = await cv.solveCubicAsync(coeffs);
    expect(rootsCount, equals(3));
    expect((roots.at<double>(0, 0), roots.at<double>(0, 1), roots.at<double>(0, 2)), (-3.0, 2.0, -0.5));
  });

  test('cv.solvePoly async', () async {
    final coeffs = cv.Mat.zeros(1, 3, cv.MatType.CV_32FC1);
    coeffs.set<double>(0, 0, 49.0);
    coeffs.set<double>(0, 1, -14.0);
    coeffs.set<double>(0, 2, 1.0);

    final (diffError, roots) = await cv.solvePolyAsync(coeffs);
    expect(diffError, lessThan(1.0e-61));
    expect(roots.at<double>(0, 0), equals(7.0));
  });

  test('cv.reduce async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = await cv.reduceAsync(src, 0, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst.rows, dst.cols), equals((1, 3)));
    expect((dst.at<double>(0, 0), dst.at<double>(0, 1), dst.at<double>(0, 2)), (2, 4, 6));

    final dst1 = await cv.reduceAsync(src, 1, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst1.rows, dst1.cols), equals((2, 1)));
    expect((dst1.at<double>(0, 0), dst1.at<double>(1, 0)), (6, 6));
  });

  test('cv.reduceArgMax async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = await cv.reduceArgMaxAsync(src, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (2, 2));
  });

  test('cv.reduceArgMin async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j + 1);
      }
    }
    final dst = await cv.reduceArgMinAsync(src, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (0, 0));
  });

  test('cv.repeat async', () async {
    final src = cv.Mat.randu(1, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = await cv.repeatAsync(src, 3, 1);
    expect((dst.rows, dst.cols), equals((3, 3)));
  });

  test('cv.scaleAdd async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final src2 = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final dst = await cv.scaleAddAsync(src, 0.6, src2);
    expect(dst.at<double>(0, 0), closeTo(src.at<double>(0, 0) * 0.6 + src2.at<double>(0, 0), 1e-4));
  });

  test('cv.setIdentity async', () async {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_64FC1);
    await cv.setIdentityAsync(src, s: cv.Scalar.all(2.5));
    expect(src.isEmpty, false);
    expect((src.at<double>(0, 0), src.at<double>(1, 1), src.at<double>(2, 2)), (2.5, 2.5, 2.5));
  });

  test('cv.sort async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = await cv.sortAsync(src, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);
    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.sortIdx async', () async {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.set<int>(i, j, j);
      }
    }
    final dst = await cv.sortIdxAsync(src, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);

    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.split async', () async {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final chans = cv.split(src);
    expect(chans.length, equals(src.channels));

    final dst = await cv.mergeAsync(chans);
    expect(dst.isEmpty, false);

    final diff = await cv.absDiffAsync(src, dst);
    expect(diff.isEmpty, false);

    final sum = diff.sum();
    expect(sum, equals(cv.Scalar.black));
  });

  test('cv.subtract async', () async {
    final src1 = cv.Mat.zeros(10, 10, cv.MatType.CV_8UC3);
    final src2 = cv.Mat.ones(10, 10, cv.MatType.CV_8UC3);
    final dst = await cv.subtractAsync(src2, src1);
    expect(dst.isEmpty, false);
    expect(dst.at<int>(0, 0), equals(1));
  });

  test('cv.trace async', () async {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC1);
    for (var row = 0; row < src.rows; row++) {
      for (var col = 0; col < src.cols; col++) {
        if (row == col) {
          src.set<int>(row, col, 1);
        }
      }
    }

    final trace = await cv.traceAsync(src);
    expect(trace, equals(cv.Scalar(3, 0, 0, 0)));
  });

  test('cv.transform async', () async {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC3);
    final tm = cv.Mat.zeros(4, 4, cv.MatType.CV_8UC4);
    final dst = await cv.transformAsync(src, tm);
    expect(dst.isEmpty, false);
  });

  test('cv.transpose async', () async {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final dst = await cv.transposeAsync(src);
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.pow async', () async {
    final src = cv.Mat.fromScalar(512, 512, cv.MatType.CV_8UC3, cv.Scalar.all(2));
    final dst = await cv.powAsync(src, 3);
    expect(dst.at<int>(0, 0), 8);
  });

  test('cv.polarToCart async', () async {
    final magnitude = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final angle = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final (x, y) = await cv.polarToCartAsync(magnitude, angle);
    expect(x.isEmpty || y.isEmpty, false);
  });

  test('cv.phase async', () async {
    final x = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC1, cv.Scalar(1.1, 2.2, 3.3, 4.4));
    final y = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC1, cv.Scalar(5.5, 6.6, 7.7, 8.8));
    final angle = await cv.phaseAsync(x, y);
    expect(angle.isEmpty, false);
    expect(angle.rows, equals(x.rows));
  });

  test('cv.randn async', () async {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    await cv.randnAsync(dst, cv.Scalar.all(10), cv.Scalar.all(1));
    expect(dst.isEmpty, false);
  });

  test('cv.randu async', () async {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    await cv.randuAsync(dst, cv.Scalar.all(10), cv.Scalar.all(100));
    expect(dst.isEmpty, false);
  });

  test('cv.randShuffle async', () async {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    await cv.randShuffleAsync(dst);
    expect(dst.isEmpty, false);
  });
}
