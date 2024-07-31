import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('Mat Creation Async', () async {
    final mat0 = await cv.MatAsync.emptyAsync();
    expect(mat0.isEmpty, true);

    final mat1 = await cv.MatAsync.createAsync(cols: 100, rows: 100, r: 255, g: 255, b: 255);
    expect(mat1.isEmpty, equals(false));
    expect((mat1.width, mat1.height, mat1.channels), (100, 100, 3));
    expect(mat1.type, cv.MatType.CV_8UC3);
    expect(mat1.total, equals(100 * 100));
    expect(mat1.isContinus, equals(true));
    expect(mat1.step.$1, equals(100 * 3));
    expect(mat1.elemSize, equals(3));
    expect(mat1.at<int>(0, 0, 0), 255);

    final mat2 = await cv.MatAsync.zerosAsync(3, 3, cv.MatType.CV_8UC1);
    expect((mat2.width, mat2.height, mat2.channels), (3, 3, 1));
    expect(mat2.countNoneZero, equals(0));
    mat2.set(0, 0, 241);
    expect(mat2.toList()[0][0], 241);

    final mat3 = await cv.MatAsync.eyeAsync(3, 3, cv.MatType.CV_8UC3);
    expect((mat3.width, mat3.height, mat3.channels), (3, 3, 3));
    final expected3 = List.generate(
      mat3.rows,
      (row) => List.generate(
        mat3.cols,
        (col) => List.generate(mat3.channels, (c) => row == col && c == 0 ? 1 : 0),
      ),
    );
    expect(mat3.toList3D(), expected3);

    final mat4 = await cv.MatAsync.onesAsync(100, 100, cv.MatType.CV_8UC3);
    expect((mat4.width, mat4.height, mat4.channels), (100, 100, 3));

    final mat5 = await mat4.convertToAsync(cv.MatType.CV_8UC1);
    mat5.setTo(cv.Scalar.all(255));
    expect(mat5.at<int>(0, 0), equals(255));
  });

  test('cv.MatAsync.fromVecAsync', () async {
    final points = [cv.Point(1, 2), cv.Point(3, 4), cv.Point(5, 6), cv.Point(7, 8)];
    final mat = await cv.MatAsync.fromVecAsync(points.cvd);
    expect(mat.rows, equals(4));
    expect(mat.cols, equals(1));
    expect(mat.channels, equals(2));
    expect(mat.at<int>(0, 0), 1);

    final points1 = [cv.Point2f(1, 2), cv.Point2f(3, 4), cv.Point2f(5, 6), cv.Point2f(7, 8)];
    final mat1 = await cv.MatAsync.fromVecAsync(points1.cvd);
    expect(mat1.rows, equals(4));
    expect(mat1.cols, equals(1));
    expect(mat1.channels, equals(2));
    expect(mat1.at<double>(0, 0), 1);

    final points2 = [cv.Point3f(1, 2, 1), cv.Point3f(3, 4, 3), cv.Point3f(5, 6, 5), cv.Point3f(7, 8, 7)];
    final mat2 = await cv.MatAsync.fromVecAsync(points2.cvd);
    expect(mat2.rows, equals(4));
    expect(mat2.cols, equals(1));
    expect(mat2.channels, equals(3));
    expect(mat2.at<double>(0, 0), 1);
  });

  test('cv.MatAsync Operations', () async {
    final mat1 = await cv.MatAsync.fromScalarAsync(3, 3, cv.MatType.CV_16UC3, cv.Scalar.all(999));
    expect(mat1.at<int>(0, 0), equals(999));

    final mat2 = await mat1.cloneAsync();
    expect(mat2.at<int>(0, 0), mat1.at<int>(0, 0));

    final mat3 = await mat2.regionAsync(cv.Rect(0, 0, 2, 2));
    expect(mat3.rows, equals(2));
    expect(mat3.cols, equals(2));
    expect(mat3.at<int>(0, 0), equals(999));

    final mat4 = await cv.MatAsync.emptyAsync();
    await mat1.copyToAsync(mat4);

    final mat5 = await mat1.reshapeAsync(3, 9);
    expect(mat5.rows, equals(9));
    expect(mat5.cols, equals(1));
  });

  test('Mat Rotate async', () async {
    final mat0 = await cv.MatAsync.onesAsync(200, 100, cv.MatType.CV_8UC3);
    final mat1 = await mat0.rotateAsync(cv.ROTATE_90_CLOCKWISE);
    expect((mat1.height, mat1.width, mat1.channels), (100, 200, 3));

    final mat2 = await mat1.rotateAsync(cv.ROTATE_90_CLOCKWISE);
    expect((mat2.height, mat2.width, mat2.channels), (200, 100, 3));
  });

  test('Mat test others Async', () async {
    final mat0 = await cv.MatAsync.fromScalarAsync(200, 100, cv.MatType.CV_8UC3, cv.Scalar.all(1));
    expect(mat0.props, equals([mat0.ptr.address]));
    final data = mat0.data;
    expect(data.length, greaterThan(0));

    final mean_ = await mat0.meanAsync();
    expect(mean_.val1, equals(1));

    final sum_ = await mat0.sumAsync();
    expect(sum_.val1, equals(200 * 100));

    final mat1 = await mat0.convertToAsync(cv.MatType.CV_32FC3);
    expect(mat1.at<double>(0, 0), 1);
    final sqrt_ = await mat1.sqrtAsync();
    expect(sqrt_.at<double>(0, 0), equals(1.0));

    final matB = await cv.extractChannelAsync(mat0, 0);
    final meanB = await matB.meanAsync();
    expect(meanB.val1, equals(1));
    final sumB = await matB.sumAsync();
    expect(sumB.val1, equals(200 * 100));

    final matG = await cv.extractChannelAsync(mat0, 1);
    final meanG = await matG.meanAsync();
    expect(meanG.val1, equals(1));

    await matG.convertTo(cv.MatType.CV_32FC1).patchNaNsAsync(val: 1);
  });
}
