import 'package:test/expect.dart';
import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test('openCvVersion', () {
    final version = cv.openCvVersion();
    print(version);
    expect(version.length, greaterThan(0));
  });

  test('cv.absDiff', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    cv.absDiff(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(1));
  });

  test('cv.Add', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    cv.add(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(1));
  });

  test('cv.addWeighted', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.Mat.empty();
    cv.addWeighted(mat0, 0.5, mat1, 0.5, 1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(75 + 1));
  });

  test('cv.bitwise_and', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.Mat.empty();
    cv.bitwise_and(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(100 & 50));
  });

  test('cv.bitwise_not', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final dst = cv.Mat.empty();
    cv.bitwise_not(mat0, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(155));
  });

  test('cv.bitwise_or', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.Mat.empty();
    cv.bitwise_or(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(100 | 50));
  });

  test('cv.bitwise_xor', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(100));
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(50));
    final dst = cv.Mat.empty();
    cv.bitwise_xor(mat0, mat1, dst);
    expect(dst.at<int>(0, 0, cn: 0), equals(100 ^ 50));
  });

  test('cv.batchDistance', () {
    final mat0 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mat1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final mask = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final dist = cv.Mat.empty();
    final nidx = cv.Mat.empty();
    cv.batchDistance(mat0, mat1, dist, -1, nidx, K: 15, mask: mask);
    expect(dist.isEmpty, equals(false));
  });

  test('cv.borderInterpolate', () {
    final n = cv.borderInterpolate(1, 5, cv.BORDER_DEFAULT);
    expect(n != 0, equals(true));
  });

  test('cv.calcCovarMatrix', () {
    final samples = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final covar = cv.Mat.empty();
    final mean = cv.Mat.empty();
    cv.calcCovarMatrix(samples, covar, mean, cv.COVAR_ROWS);
    expect(covar.isEmpty, equals(false));
  });

  test('cv.cartToPolar', () {
    final x = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final y = cv.Mat.zeros(100, 100, cv.MatType.CV_32FC1);
    final magnitude = cv.Mat.empty();
    final angle = cv.Mat.empty();
    cv.cartToPolar(x, y, magnitude, angle, angleInDegrees: false);
    expect(magnitude.isEmpty || angle.isEmpty, equals(false));
  });

  test('cv.checkRange', () {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final (success, pos) = cv.checkRange(mat1);
    expect(success, equals(true));
    expect(pos, equals(cv.Point(0, 0)));
  });

  test('cv.compare', () {
    final mat1 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final mat2 = cv.Mat.zeros(101, 102, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.compare(mat1, mat2, dst, cv.CMP_EQ);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.countNonZero', () {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_8UC1);
    final n = cv.countNonZero(mat1);
    expect(n, equals(101 * 102));
  });

  test('cv.completeSymm', () {
    final mat1 = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    cv.completeSymm(mat1);
    expect(mat1.at<double>(99, 0), equals(mat1.at<double>(0, 99)));
  });

  test("cv.convertScaleAbs", () {
    final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.convertScaleAbs(src, dst, alpha: 1, beta: 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.copyMakeBorder', () {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.copyMakeBorder(src, dst, 10, 10, 10, 10, cv.BORDER_REFLECT, value: cv.Scalar.all(0));
    expect(dst.isEmpty, equals(false));
  });

  test('cv.dct', () {
    final src = cv.Mat.randn(100, 100, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.dct(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.determinant', () {
    final src = cv.Mat.zeros(101, 101, cv.MatType.CV_32FC1);
    final ret = cv.determinant(src);
    expect(ret, equals(0));
  });

  test('cv.dft', () {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    final m = cv.getOptimalDFTSize(101);
    final n = cv.getOptimalDFTSize(102);
    expect(m, equals(108));
    expect(n, equals(108));
    cv.dft(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.divide', () {
    final mat1 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final mat2 = cv.Mat.ones(101, 102, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.divide(mat1, mat2, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.eigen', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final eigenValues = cv.Mat.empty();
    final eigenVectors = cv.Mat.empty();
    cv.eigen(src, eigenValues, eigenvectors: eigenVectors);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.eigenNonSymmetric', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final eigenValues = cv.Mat.empty();
    final eigenVectors = cv.Mat.empty();
    cv.eigenNonSymmetric(src, eigenValues, eigenVectors);
    expect(eigenValues.isEmpty || eigenVectors.isEmpty, equals(false));
  });

  test('cv.PCACompute', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC1);
    final mean = cv.Mat.empty();
    final eigenvectors = cv.Mat.empty();
    final eigenvalues = cv.Mat.empty();
    cv.PCACompute(src, mean, eigenvectors, eigenvalues, maxComponents: 2);
    expect(mean.isEmpty || eigenvectors.isEmpty || eigenvalues.isEmpty, equals(false));
    expect(eigenvectors.rows, equals(2));
  });

  test('cv.exp', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.exp(src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.at<double>(0, 0), equals(1));
  });

  test('cv.extractChannel', () {
    final src = cv.Mat.randn(10, 10, cv.MatType.CV_32FC3);
    final dst = cv.Mat.empty();
    cv.extractChannel(src, dst, 2);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.findNonZero', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.findNonZero(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.flip', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.flip(src, dst, 0);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.gemm', () {
    final src1 = cv.Mat.randu(3, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final src3 = cv.Mat.empty();
    final dst = cv.Mat.empty();
    cv.gemm(src1, src2, 1, src3, 0, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src1.rows));
  });

  test('cv.hconcat', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.hconcat(src, src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.cols, equals(src.cols * 2));
  });

  test('cv.vconcat', () {
    final src = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.vconcat(src, src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows * 2));
  });

  test('cv.rotate', () {
    final src = cv.Mat.zeros(10, 20, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.rotate(src, dst, cv.ROTATE_90_CLOCKWISE);
    expect(dst.isEmpty, equals(false));
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.idct', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.idct(src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.idft', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.idft(src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.rows, equals(src.rows));
  });

  test('cv.inRange', () {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Mat.fromScalar(cv.Scalar(20, 100, 100, 0), cv.MatType.CV_8UC1);
    final ub = cv.Mat.fromScalar(cv.Scalar(20, 100, 100, 0), cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.inRange(mat1, lb, ub, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.inRangebyScalar', () {
    final mat1 = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final lb = cv.Scalar(20, 100, 100, 0);
    final ub = cv.Scalar(20, 100, 100, 0);
    final dst = cv.Mat.empty();
    cv.inRangebyScalar(mat1, lb, ub, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.insertChannel', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_8UC1);
    final dst = cv.Mat.randu(4, 4, cv.MatType.CV_8UC3);
    cv.insertChannel(src, dst, 1);
    expect(dst.channels, equals(3));
  });

  test('cv.invert', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.invert(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.kmeans', () {
    final src = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final bestLabels = cv.Mat.empty();
    final centers = cv.Mat.empty();
    final criteria = cv.termCriteriaNew(cv.TERM_COUNT, 10, 1.0);
    cv.kmeans(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS, centers);
    expect(bestLabels.isEmpty, equals(false));
  });

  test('cv.kmeansByPoints', () {
    final src = <cv.Point>[cv.Point(0, 0), cv.Point(1, 1)];
    final bestLabels = cv.Mat.empty();
    final centers = cv.Mat.empty();
    final criteria = cv.termCriteriaNew(cv.TERM_COUNT, 10, 1.0);
    cv.kmeansByPoints(src, 2, bestLabels, criteria, 2, cv.KMEANS_RANDOM_CENTERS, centers);
    expect(bestLabels.isEmpty, equals(false));
  });

  test('cv.log', () {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.log(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.magnitude', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.magnitude(src1, src2, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.max', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.max(src1, src2, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.min', () {
    final src1 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final src2 = cv.Mat.randu(4, 4, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();
    cv.min(src1, src2, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.meanStdDev', () {
    final src = cv.Mat.randu(101, 102, cv.MatType.CV_8UC1);
    final mean = cv.Mat.empty();
    final stdDev = cv.Mat.empty();
    cv.meanStdDev(src, mean, stdDev);
    expect(mean.isEmpty, equals(false));
    expect(stdDev.isEmpty, equals(false));
  });

  test('cv.merge', () {
    final src = [
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1),
      cv.Mat.randu(101, 102, cv.MatType.CV_8UC1)
    ];
    final dst = cv.Mat.empty();
    cv.merge(src, dst);
    expect(dst.isEmpty, equals(false));
    expect(dst.channels, equals(3));
  });

  test('cv.minMaxIdx', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minIdx, maxIdx) = cv.minMaxIdx(src);
    expect(minIdx, greaterThanOrEqualTo(0));
    expect(maxIdx, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  test('cv.minMaxLoc', () {
    final src = cv.Mat.randu(10, 10, cv.MatType.CV_32FC1);
    final (min, max, minLoc, maxLoc) = cv.minMaxLoc(src);
    expect(minLoc.x, greaterThanOrEqualTo(0));
    expect(maxLoc.x, greaterThanOrEqualTo(0));
    expect(max > min, equals(true));
  });

  // test('cv.mixChannels', () {
  //   final bgra = cv.Mat.fromScalar(cv.Scalar(255, 0, 0, 255), cv.MatType.CV_8UC4, rows: 10, cols: 10);
  //   final bgr = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC3);
  //   final alpha = cv.Mat.create(cols: bgra.cols, rows: bgra.rows, type: cv.MatType.CV_8UC1);
  //   final fromTo = [0, 2, 1, 1, 2, 0, 3, 3];
  //   final dst = cv.mixChannels([bgra], fromTo);
  // });

  test('cv.mulSpectrums', () {
    final a = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final dst = cv.Mat.empty();

    cv.mulSpectrums(a, b, dst, 0);
    expect(dst.isEmpty, false);

    final dst1 = cv.Mat.empty();

    cv.mulSpectrums(a, b, dst1, cv.DFT_ROWS);
    expect(dst1.isEmpty, false);
  });

  test('cv.multiply', () {
    final mat1 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat2 = cv.Mat.randn(101, 102, cv.MatType.CV_64FC1);
    final mat3 = cv.Mat.empty();
    cv.multiply(mat1, mat2, mat3);
    expect(mat3.isEmpty, equals(false));
    expect(mat3.at<double>(0, 0), equals(mat1.at<double>(0, 0) * mat2.at<double>(0, 0)));
  });

  test('cv.normalize', () {
    final src = cv.Mat.randn(101, 102, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    cv.normalize(src, dst);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.norm', () {
    final src1 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n = cv.norm(src1);
    expect(n, equals(0));

    final src2 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    final n1 = cv.norm1(src1, src2);
    expect(n1, equals(0));
  });

  test('cv.perspectiveTransform', () {
    final src = cv.Mat.zeros(100, 1, cv.MatType.CV_32FC2);
    final dst = cv.Mat.empty();
    final tm = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    cv.perspectiveTransform(src, dst, tm);
    expect(dst.isEmpty, equals(false));
  });

  test('cv.solve', () {
    final a = cv.Mat.zeros(3, 3, cv.MatType.CV_32FC1);
    final b = cv.Mat.zeros(3, 1, cv.MatType.CV_32FC1);
    final solve = cv.Mat.empty();
    final testPoints = [
      (1.0, 1.0, 1.0, 0.0),
      (0.0, 0.0, 1.0, 2.0),
      (9.0, 3.0, 1.0, 2.0),
    ];
    for (var i = 0; i < testPoints.length; i++) {
      a.setValue<double>(i, 0, testPoints[i].$1);
      a.setValue<double>(i, 1, testPoints[i].$2);
      a.setValue<double>(i, 2, testPoints[i].$3);
      b.setValue<double>(i, 0, testPoints[i].$4);
    }
    final solved = cv.solve(a, b, solve, flags: cv.DECOMP_LU);
    expect(solved, equals(true));
    expect((solve.at<double>(0, 0), solve.at<double>(1, 0), solve.at<double>(2, 0)), (1, -3, 2));
  });

  test('cv.solveCubic', () {
    final coeffs = cv.Mat.zeros(1, 4, cv.MatType.CV_32FC1);
    final roots = cv.Mat.empty();
    coeffs.setValue<double>(0, 0, 2.0);
    coeffs.setValue<double>(0, 1, 3.0);
    coeffs.setValue<double>(0, 2, -11.0);
    coeffs.setValue<double>(0, 3, -6.0);

    final rootsCount = cv.solveCubic(coeffs, roots);
    expect(rootsCount, equals(3));
    expect((roots.at<double>(0, 0), roots.at<double>(0, 1), roots.at<double>(0, 2)), (-3.0, 2.0, -0.5));
  });

  test('cv.solvePoly', () {
    final coeffs = cv.Mat.zeros(1, 3, cv.MatType.CV_32FC1);
    final roots = cv.Mat.empty();
    coeffs.setValue<double>(0, 0, 49.0);
    coeffs.setValue<double>(0, 1, -14.0);
    coeffs.setValue<double>(0, 2, 1.0);

    final diffError = cv.solvePoly(coeffs, roots);
    expect(diffError, lessThan(1.0e-61));
    expect(roots.at<double>(0, 0), equals(7.0));
  });

  test('cv.reduce', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j + 1);
      }
    }
    cv.reduce(src, dst, 0, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst.rows, dst.cols), equals((1, 3)));
    expect((dst.at<int>(0, 0), dst.at<int>(0, 1), dst.at<int>(0, 2)), (2, 4, 6));

    cv.reduce(src, dst, 1, cv.REDUCE_SUM, dtype: cv.MatType.CV_32FC1.value);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (6, 6));
  });

  test('cv.reduceArgMax', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j + 1);
      }
    }
    cv.reduceArgMax(src, dst, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (2, 2));
  });

  test('cv.reduceArgMin', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j + 1);
      }
    }
    cv.reduceArgMin(src, dst, 1);
    expect((dst.rows, dst.cols), equals((2, 1)));
    expect((dst.at<int>(0, 0), dst.at<int>(1, 0)), (0, 0));
  });

  test('cv.repeat', () {
    final src = cv.Mat.randu(1, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j);
      }
    }
    cv.repeat(src, 3, 1, dst);
    expect((dst.rows, dst.cols), equals((3, 3)));
  });

  test('cv.scaleAdd', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final src2 = cv.Mat.randu(2, 3, cv.MatType.CV_64FC1);
    final dst = cv.Mat.empty();
    cv.scaleAdd(src, 0.6, src2, dst);
    expect(dst.at<double>(0, 0), closeTo(src.at<double>(0, 0) * 0.6 + src2.at<double>(0, 0), 1e-4));
  });

  test('cv.setIdentity', () {
    final src = cv.Mat.randu(4, 3, cv.MatType.CV_64FC1);
    cv.setIdentity(src, s: 2.5);
    expect(src.isEmpty, false);
    expect((src.at<double>(0, 0), src.at<double>(1, 1), src.at<double>(2, 2)), (2.5, 2.5, 2.5));
  });

  test('cv.sort', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j);
      }
    }
    cv.sort(src, dst, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);

    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.sortIdx', () {
    final src = cv.Mat.randu(2, 3, cv.MatType.CV_8UC1);
    final dst = cv.Mat.empty();
    for (var i = 0; i < src.rows; i++) {
      for (var j = 0; j < src.cols; j++) {
        src.setValue<int>(i, j, j);
      }
    }
    cv.sortIdx(src, dst, cv.SORT_EVERY_ROW + cv.SORT_DESCENDING);
    expect(dst.isEmpty, false);

    expect(dst.at<int>(0, 0), 2);
  });

  test('cv.split', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final chans = cv.split(src);
    expect(chans.length, equals(src.channels));

    final dst = cv.Mat.empty();
    cv.merge(chans, dst);
    expect(dst.isEmpty, false);

    final diff = cv.Mat.empty();
    cv.absDiff(src, dst, diff);
    expect(diff.isEmpty, false);

    final sum = diff.sum();
    expect(sum, equals(cv.Scalar.black));
  });

  test('cv.subtract', () {
    final src1 = cv.Mat.zeros(10, 10, cv.MatType.CV_8UC3);
    final src2 = cv.Mat.ones(10, 10, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    cv.subtract(src2, src1, dst);
    expect(dst.isEmpty, false);
    expect(dst.at<int>(0, 0), equals(1));
  });

  test('cv.trace', () {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC1);
    for (var row = 0; row < src.rows; row++) {
      for (var col = 0; col < src.cols; col++) {
        if (row == col) {
          src.setValue<int>(row, col, 1);
        }
      }
    }

    final trace = cv.trace(src);
    expect(trace, equals(cv.Scalar(3, 0, 0, 0)));
  });

  test('cv.transform', () {
    final src = cv.Mat.randu(3, 3, cv.MatType.CV_8UC3);
    final dst = cv.Mat.empty();
    final tm = cv.Mat.zeros(4, 4, cv.MatType.CV_8UC4);
    cv.transform(src, dst, tm);
    expect(dst.isEmpty, false);
  });

  test('cv.transpose', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final dst = cv.Mat.empty();
    cv.transpose(src, dst);
    expect((dst.rows, dst.cols), (src.cols, src.rows));
  });

  test('cv.pow', () {
    final src = cv.Mat.fromScalar(cv.Scalar.all(2), cv.MatType.CV_8UC3, rows: 512, cols: 512);
    final dst = cv.Mat.empty();
    cv.pow(src, 3, dst);
    expect(dst.at<int>(0, 0), 8);
  });

  test('cv.polarToCart', () {
    final magnitude = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final angle = cv.Mat.zeros(101, 102, cv.MatType.CV_32FC1);
    final x = cv.Mat.empty();
    final y = cv.Mat.empty();
    cv.polarToCart(magnitude, angle, x, y);
    expect(x.isEmpty || y.isEmpty, false);
  });

  test('cv.phase', () {
    final x = cv.Mat.fromScalar(cv.Scalar(1.1, 2.2, 3.3, 4.4), cv.MatType.CV_32FC1);
    final y = cv.Mat.fromScalar(cv.Scalar(5.5, 6.6, 7.7, 8.8), cv.MatType.CV_32FC1);
    final angle = cv.Mat.zeros(4, 5, cv.MatType.CV_32FC1);
    cv.phase(x, y, angle);
    expect(angle.isEmpty, false);
    expect(angle.rows, equals(x.rows));
  });

  test('cv.getTickCount, cv.getTickFrequency', () {
    final freq = cv.getTickFrequency();
    expect(freq, greaterThan(0));
    final count = cv.getTickCount();
    expect(count, greaterThan(0));
  });

  test('cv.theRNG', () {
    final rng = cv.theRNG();
    expect(rng.next(), isA<int>());
  });

  test('cv.randn', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randn(dst, cv.Scalar.all(10), cv.Scalar.all(1));
    expect(dst.isEmpty, false);
  });

  test('cv.randShuffle', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randShuffle(dst);
    expect(dst.isEmpty, false);
  });

  test('cv.randu', () {
    final dst = cv.Mat.zeros(10, 10, cv.MatType.CV_32FC1);
    cv.randu(dst, cv.Scalar.all(10), cv.Scalar.all(100));
    expect(dst.isEmpty, false);
  });

  test('cv.setNumThreads', () {
    cv.setNumThreads(4);
    final n = cv.getNumThreads();
    expect(n, equals(4));
  });

  test('cv.getNumThreads', () {
    final n = cv.getNumThreads();
    expect(n, greaterThan(0));
  });
}
