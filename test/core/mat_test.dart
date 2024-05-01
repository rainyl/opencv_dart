import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test('Mat Creation', () {
    final mat0 = cv.Mat.empty();
    expect(mat0.isEmpty, true);

    final mat1 = cv.Mat.create(cols: 100, rows: 100, r: 255, g: 255, b: 255);
    expect(mat1.isEmpty, equals(false));
    expect((mat1.width, mat1.height, mat1.channels), (100, 100, 3));
    expect(mat1.type, cv.MatType.CV_8UC3);
    expect(mat1.total, equals(100 * 100));
    expect(mat1.isContinus, equals(true));
    expect(mat1.step, equals(100 * 3));
    expect(mat1.elemSize, equals(3));
    expect(mat1.at<int>(0, 0, 0), 255);

    final mat2 = cv.Mat.zeros(3, 3, cv.MatType.CV_8UC1);
    expect((mat2.width, mat2.height, mat2.channels), (3, 3, 1));
    expect(mat2.countNoneZero, equals(0));
    mat2.set<int>(0, 0, 241);
    expect(mat2.toList()[0][0], 241);

    final mat3 = cv.Mat.eye(3, 3, cv.MatType.CV_8UC3);
    expect((mat3.width, mat3.height, mat3.channels), (3, 3, 3));
    final expected3 = List.generate(
        mat3.rows,
        (row) => List.generate(
            mat3.cols, (col) => List.generate(mat3.channels, (c) => row == col && c == 0 ? 1 : 0)));
    expect(mat3.toList3D<cv.Vec3b, int>(), expected3);

    final mat4 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    expect((mat4.width, mat4.height, mat4.channels), (100, 100, 3));

    final mat5 = mat4.convertTo(cv.MatType.CV_8UC1);
    mat5.setTo(cv.Scalar.all(255));
    expect(mat5.at<int>(0, 0), equals(255));
  });

  test('Mat.fromBytes', () {
    int rows = 3, cols = 3, channels = 3;

    final data = List.generate(rows * cols * channels, (i) => i);
    for (var i = 0; i < 100; i++) {
      final mat = cv.Mat.fromList(rows, cols, cv.MatType.CV_8UC(channels), data);
      expect(mat.isEmpty, false);
      expect(mat.shape, [rows, cols, channels]);
      expect(mat.at<cv.Vec3b>(0, 0), cv.Vec3b(0, 1, 2));
    }
  });

  test('Mat operations Add', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).multiplyU8(128);
    final mat1 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(127));

    // Mat
    final mat2 = mat1.add<cv.Mat>(mat0);
    expect((mat2.width, mat2.height, mat2.channels), (100, 100, 3));
    expect(mat2.at<int>(0, 0), equals(255));
    expect(() => mat2.add<double>(0.1), throwsUnsupportedError);
    expect(() => mat2.add<cv.MatType>(cv.MatType.CV_16SC1), throwsUnsupportedError);
    final mat2_1 = mat1.clone();
    mat2_1.add<cv.Mat>(mat0, inplace: true);
    expect(mat2_1.at<int>(0, 0), equals(255));

    // int
    final mat3 = mat1.add<int>(3);
    expect((mat3.width, mat3.height, mat3.channels), (100, 100, 3));
    expect(mat3.at<int>(0, 0), equals(130));
    mat3.add<int>(1, inplace: true);
    expect(mat3.at<int>(0, 0), equals(131));

    final mat4 = mat1.convertTo(cv.MatType.CV_32SC3).add<int>(54);
    expect(mat4.at<int>(0, 0), equals(181));
    mat4.add<int>(1, inplace: true);
    expect(mat4.at<int>(0, 0), equals(182));

    // float
    final mat5 = mat1.convertTo(cv.MatType.CV_32FC3).add<double>(54.5);
    expect(mat5.at<double>(0, 0), closeTo(181.5, 0.001));
    mat5.add<double>(1, inplace: true);
    expect(mat5.at<double>(0, 0), closeTo(182.5, 0.001));

    final mat6 = mat1.convertTo(cv.MatType.CV_64FC3).add<double>(54.5);
    expect(mat6.at<double>(0, 0), closeTo(181.5, 0.001));
    mat6.add<double>(1, inplace: true);
    expect(mat6.at<double>(0, 0), closeTo(182.5, 0.001));
  });

  test('Mat operations Subtract', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).multiplyU8(255);
    final mat1 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(127));

    // Mat
    final mat2 = mat0.subtract<cv.Mat>(mat1);
    expect((mat2.width, mat2.height, mat2.channels), (100, 100, 3));
    expect(mat2.at<int>(0, 0), equals(128));
    expect(() => mat2.subtract<double>(0.1), throwsUnsupportedError);
    expect(() => mat2.subtract<cv.MatType>(cv.MatType.CV_16SC1), throwsUnsupportedError);
    final mat2_1 = mat0.clone();
    mat2_1.subtract<cv.Mat>(mat1, inplace: true);
    expect(mat2_1.at<int>(0, 0), equals(128));

    // int
    final mat3 = mat0.subtract<int>(13);
    expect((mat3.width, mat3.height, mat3.channels), (100, 100, 3));
    expect(mat3.at<int>(0, 0), equals(242));
    mat3.subtract<int>(1, inplace: true);
    expect(mat3.at<int>(0, 0), equals(241));

    final mat4 = mat0.convertTo(cv.MatType.CV_32SC3).subtract<int>(14);
    expect(mat4.at<int>(0, 0), equals(241));
    mat4.subtract<int>(1, inplace: true);
    expect(mat4.at<int>(0, 0), equals(240));

    // float
    final mat5 = mat0.convertTo(cv.MatType.CV_32FC3).subtract<double>(54.5);
    expect(mat5.at<double>(0, 0), closeTo(200.5, 0.001));
    mat5.subtract<double>(1, inplace: true);
    expect(mat5.at<double>(0, 0), closeTo(199.5, 0.001));

    final mat6 = mat0.convertTo(cv.MatType.CV_64FC3).subtract<double>(54.5);
    expect(mat6.at<double>(0, 0), closeTo(200.5, 0.001));
    mat6.subtract<double>(1, inplace: true);
    expect(mat6.at<double>(0, 0), closeTo(199.5, 0.001));
  });

  test('Mat operations Multiply', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).multiplyU8(100);
    final mat1 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(2));

    // Mat
    final mat2 = mat0.multiply<cv.Mat>(mat1);
    expect((mat2.width, mat2.height, mat2.channels), (100, 100, 3));
    expect(mat2.at<int>(0, 0), equals(200));
    expect(() => mat2.multiply<double>(0.1), throwsUnsupportedError);
    expect(() => mat2.multiply<cv.MatType>(cv.MatType.CV_16SC1), throwsUnsupportedError);
    final mat2_1 = mat1.clone();
    mat2_1.multiply<cv.Mat>(mat0, inplace: true);
    expect(mat2_1.at<int>(0, 0), equals(200));

    // int
    final mat3 = mat0.multiply<int>(2);
    expect((mat3.width, mat3.height, mat3.channels), (100, 100, 3));
    expect(mat3.at<int>(0, 0), equals(200));
    mat3.multiply<int>(1, inplace: true);
    expect(mat3.at<int>(0, 0), equals(200));

    final mat4 = mat0.convertTo(cv.MatType.CV_32SC3).multiply<int>(2);
    expect(mat4.at<int>(0, 0), equals(200));
    mat4.multiply<int>(1, inplace: true);
    expect(mat4.at<int>(0, 0), equals(200));

    // float
    final mat5 = mat0.convertTo(cv.MatType.CV_32FC3).multiply<double>(1.5);
    expect(mat5.at<double>(0, 0), closeTo(150.0, 0.001));
    mat5.multiply<double>(1, inplace: true);
    expect(mat5.at<double>(0, 0), closeTo(150.0, 0.001));

    final mat6 = mat0.convertTo(cv.MatType.CV_64FC3).multiply<double>(2.2);
    expect(mat6.at<double>(0, 0), closeTo(220.0, 0.001));
    mat6.multiply<double>(2, inplace: true);
    expect(mat6.at<double>(0, 0), closeTo(440.0, 0.001));
  });

  test('Mat operations Divide', () {
    final mat0 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).multiplyU8(200);
    final mat1 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3).setTo(cv.Scalar.all(2));

    // Mat
    final mat2 = mat0.divide<cv.Mat>(mat1);
    expect((mat2.width, mat2.height, mat2.channels), (100, 100, 3));
    expect(mat2.at<int>(0, 0), equals(100));
    expect(() => mat2.divide<double>(0.1), throwsUnsupportedError);
    expect(() => mat2.divide<cv.MatType>(cv.MatType.CV_16SC1), throwsUnsupportedError);
    final mat2_1 = mat0.clone();
    mat2_1.divide<cv.Mat>(mat1, inplace: true);
    expect(mat2_1.at<int>(0, 0), equals(100));

    // int
    final mat3 = mat0.divide<int>(2);
    expect((mat3.width, mat3.height, mat3.channels), (100, 100, 3));
    expect(mat3.at<int>(0, 0), equals(100));
    mat3.divide<int>(2, inplace: true);
    expect(mat3.at<int>(0, 0), equals(50));

    final mat4 = mat0.convertTo(cv.MatType.CV_32SC3).divide<int>(2);
    expect(mat4.at<int>(0, 0), equals(100));
    mat4.divide<int>(2, inplace: true);
    expect(mat4.at<int>(0, 0), equals(50));

    // float
    final mat5 = mat0.convertTo(cv.MatType.CV_32FC3).divide<double>(5.0);
    expect(mat5.at<double>(0, 0), closeTo(40.0, 0.001));
    mat5.divide<double>(2, inplace: true);
    expect(mat5.at<double>(0, 0), closeTo(20.0, 0.001));

    final mat6 = mat0.convertTo(cv.MatType.CV_64FC3).divide<double>(4.0);
    expect(mat6.at<double>(0, 0), closeTo(50.0, 0.001));
    mat6.divide<double>(2, inplace: true);
    expect(mat6.at<double>(0, 0), closeTo(25.0, 0.001));
  });

  test('Mat Transpose', () {
    final mat0 = cv.Mat.ones(200, 100, cv.MatType.CV_8UC3);
    final mat1 = mat0.transpose();
    expect((mat1.height, mat1.width, mat1.channels), (100, 200, 3));
  });

  test('Mat CopyTo', () {
    final mat0 = cv.Mat.ones(200, 100, cv.MatType.CV_8UC3);
    final mat1 = cv.Mat.zeros(200, 100, cv.MatType.CV_8UC3);
    final mat2 = cv.Mat.zeros(200, 100, cv.MatType.CV_8UC3);
    mat0.copyTo(mat1);
    expect(mat1.at<int>(0, 0), 1);
    mat0.copyToWithMask(mat2, mat0);
    expect(mat1.at<int>(0, 0), 1);
  });

  test('Mat Resize', () {
    final mat0 = cv.Mat.ones(200, 100, cv.MatType.CV_8UC3);
    final mat1 = mat0.reshape(1, 200);
    expect((mat1.height, mat1.width, mat1.channels), (200, 100 * 3, 1));
  });

  test('Mat Region', () {
    final mat0 = cv.Mat.ones(200, 110, cv.MatType.CV_8UC3);
    final mat1 = mat0.region(cv.Rect(10, 10, 100, 100));
    expect((mat1.width, mat1.height, mat1.channels), (100, 100, 3));
    expect(mat1.at<int>(0, 0, 0), equals(mat0.at<int>(10, 10, 0)));
  });

  test('Mat Rotate', () {
    final mat0 = cv.Mat.ones(200, 100, cv.MatType.CV_8UC3);
    final mat1 = mat0.rotate(cv.ROTATE_90_CLOCKWISE);
    expect((mat1.height, mat1.width, mat1.channels), (100, 200, 3));

    mat1.rotate(cv.ROTATE_90_CLOCKWISE, inplace: true);
    expect((mat1.height, mat1.width, mat1.channels), (200, 100, 3));
  });

  test('Mat test others', () {
    final mat0 = cv.Mat.fromScalar(200, 100, cv.MatType.CV_8UC3, cv.Scalar(1, 1, 1, 1));
    expect(mat0.props, equals([mat0.ptr.address]));
    final data = mat0.data;
    expect(data.length, greaterThan(0));

    final mean_ = mat0.mean();
    expect(mean_.val1, equals(1));

    final sum_ = mat0.sum();
    expect(sum_.val1, equals(200 * 100));

    final sd = mat0.stdDev();
    expect(sd, cv.Scalar(0, 0, 0, 0));

    final variance = mat0.variance();
    expect(variance, cv.Scalar(0, 0, 0, 0));

    final mat1 = mat0.convertTo(cv.MatType.CV_32FC3);
    expect(mat1.at<double>(0, 0), 1);
    final sqrt_ = mat1.sqrt();
    expect(sqrt_.at<double>(0, 0), equals(1.0));

    final matB = cv.extractChannel(mat0, 0);
    final meanB = matB.mean();
    expect(meanB.val1, equals(1));
    final sumB = matB.sum();
    expect(sumB.val1, equals(200 * 100));

    final matG = cv.extractChannel(mat0, 1);
    final meanG = matG.mean();
    expect(meanG.val1, equals(1));
  });

  test('Mat At Set Vec*b(uchar)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec2b>(0, 0), cv.Vec2b(2, 4));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec2b>(0, 0, cv.Vec2b(99, 99));
    expect(mat.at<cv.Vec2b>(0, 0), cv.Vec2b(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec3b>(0, 0), cv.Vec3b(2, 4, 1));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec3b>(0, 0, cv.Vec3b(99, 99, 99));
    expect(mat.at<cv.Vec3b>(0, 0), cv.Vec3b(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_8UC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec4b>(0, 0), cv.Vec4b(2, 4, 1, 0));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec4b>(0, 0, cv.Vec4b(99, 99, 99, 99));
    expect(mat.at<cv.Vec4b>(0, 0), cv.Vec4b(99, 99, 99, 99));
  });

  test('Mat At Set Vec*w(ushort)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16UC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec2w>(0, 0), cv.Vec2w(2, 4));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec2w>(0, 0, cv.Vec2w(99, 99));
    expect(mat.at<cv.Vec2w>(0, 0), cv.Vec2w(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16UC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec3w>(0, 0), cv.Vec3w(2, 4, 1));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec3w>(0, 0, cv.Vec3w(99, 99, 99));
    expect(mat.at<cv.Vec3w>(0, 0), cv.Vec3w(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16UC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec4w>(0, 0), cv.Vec4w(2, 4, 1, 0));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec4w>(0, 0, cv.Vec4w(99, 99, 99, 99));
    expect(mat.at<cv.Vec4w>(0, 0), cv.Vec4w(99, 99, 99, 99));
  });

  test('Mat At Set Vec*s(short)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16SC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec2s>(0, 0), cv.Vec2s(2, 4));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec2s>(0, 0, cv.Vec2s(99, 99));
    expect(mat.at<cv.Vec2s>(0, 0), cv.Vec2s(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16SC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec3s>(0, 0), cv.Vec3s(2, 4, 1));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec3s>(0, 0, cv.Vec3s(99, 99, 99));
    expect(mat.at<cv.Vec3s>(0, 0), cv.Vec3s(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_16SC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec4s>(0, 0), cv.Vec4s(2, 4, 1, 0));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec4s>(0, 0, cv.Vec4s(99, 99, 99, 99));
    expect(mat.at<cv.Vec4s>(0, 0), cv.Vec4s(99, 99, 99, 99));
  });

  test('Mat At Set Vec*i(int)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32SC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec2i>(0, 0), cv.Vec2i(2, 4));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec2i>(0, 0, cv.Vec2i(99, 99));
    expect(mat.at<cv.Vec2i>(0, 0), cv.Vec2i(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32SC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec3i>(0, 0), cv.Vec3i(2, 4, 1));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec3i>(0, 0, cv.Vec3i(99, 99, 99));
    expect(mat.at<cv.Vec3i>(0, 0), cv.Vec3i(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32SC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<int>(0, 0), 2);
    expect(mat.at<cv.Vec4i>(0, 0), cv.Vec4i(2, 4, 1, 0));

    mat.set<int>(0, 0, 99);
    expect(mat.at<int>(0, 0), 99);

    mat.set<cv.Vec4i>(0, 0, cv.Vec4i(99, 99, 99, 99));
    expect(mat.at<cv.Vec4i>(0, 0), cv.Vec4i(99, 99, 99, 99));
  });

  test('Mat At Set Vec*f(float)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec2f>(0, 0), cv.Vec2f(2, 4));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec2f>(0, 0, cv.Vec2f(99, 99));
    expect(mat.at<cv.Vec2f>(0, 0), cv.Vec2f(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec3f>(0, 0), cv.Vec3f(2, 4, 1));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec3f>(0, 0, cv.Vec3f(99, 99, 99));
    expect(mat.at<cv.Vec3f>(0, 0), cv.Vec3f(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_32FC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec4f>(0, 0), cv.Vec4f(2, 4, 1, 0));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec4f>(0, 0, cv.Vec4f(99, 99, 99, 99));
    expect(mat.at<cv.Vec4f>(0, 0), cv.Vec4f(99, 99, 99, 99));
  });

  test('Mat At Set Vec*d(double)', () {
    var mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_64FC2, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec2d>(0, 0), cv.Vec2d(2, 4));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec2d>(0, 0, cv.Vec2d(99, 99));
    expect(mat.at<cv.Vec2d>(0, 0), cv.Vec2d(99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_64FC3, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec3d>(0, 0), cv.Vec3d(2, 4, 1));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec3d>(0, 0, cv.Vec3d(99, 99, 99));
    expect(mat.at<cv.Vec3d>(0, 0), cv.Vec3d(99, 99, 99));

    mat = cv.Mat.fromScalar(1, 1, cv.MatType.CV_64FC4, cv.Scalar(2, 4, 1, 0));
    expect(mat.at<double>(0, 0), closeTo(2, 1e-3));
    expect(mat.at<cv.Vec4d>(0, 0), cv.Vec4d(2, 4, 1, 0));

    mat.set<double>(0, 0, 99);
    expect(mat.at<double>(0, 0), 99);

    mat.set<cv.Vec4d>(0, 0, cv.Vec4d(99, 99, 99, 99));
    expect(mat.at<cv.Vec4d>(0, 0), cv.Vec4d(99, 99, 99, 99));
  });
}
