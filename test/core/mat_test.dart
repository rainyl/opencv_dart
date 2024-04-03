import 'dart:typed_data';

import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test('Mat Creation', () {
    final mat0 = cv.Mat.empty();
    expect(mat0.isEmpty, true);

    final mat1 = cv.Mat.create(cols: 100, rows: 100, r: 255, g: 255, b: 255);
    expect(mat1.isEmpty, equals(false));
    expect((mat1.width, mat1.height), (100, 100));
    expect(mat1.channels, equals(3));
    expect(mat1.type, cv.MatType.CV_8UC3);
    expect(mat1.total, equals(100 * 100));
    expect(mat1.isContinus, equals(true));
    expect(mat1.step, equals(100 * 3));
    expect(mat1.elemSize, equals(3));
    expect(mat1.at<int>(0, 0, 0), 255);

    final mat2 = cv.Mat.zeros(100, 100, cv.MatType.CV_8UC1);
    expect((mat2.width, mat2.height, mat2.channels), (100, 100, 1));
    expect(mat2.countNoneZero, equals(0));

    final mat3 = cv.Mat.eye(100, 100, cv.MatType.CV_8UC3);
    expect((mat3.width, mat3.height, mat3.channels), (100, 100, 3));

    final mat4 = cv.Mat.ones(100, 100, cv.MatType.CV_8UC3);
    expect((mat4.width, mat4.height, mat4.channels), (100, 100, 3));

    final mat5 = mat4.convertTo(cv.MatType.CV_8UC1);
    mat5.setTo(cv.Scalar.all(255));
    expect(mat5.at<int>(0, 0), equals(255));
  });

  test('Mat.fromBytes', () {
    int rows = 3, cols = 3;

    final data = Uint8List.fromList(List.generate(rows * cols * 3, (i) => i));
    for (var i = 0; i < 100; i++) {
      final mat = cv.Mat.fromBytes(rows, cols, cv.MatType.CV_8UC3, data);
      expect(mat.isEmpty, false);
      print(mat.toList(1));
      print(mat.vptr?.toList());
      // expect(mat.shape, [rows, cols, 1]);
      //  print(mat.toList(1));
      //  print(mat.toList(2));
      //  print("===========");
      // print(mat.pdata?.toList());
      // cv.imwrite('test.png', mat);
      // expect(mat.at<int>(0, 0, 0), 1);
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
    final mat0 = cv.Mat.ones(200, 100, cv.MatType.CV_8UC3);
    expect(mat0.props, equals([mat0.ptr.address]));
    final data = mat0.data;
    expect(data.length, greaterThan(0));

    final mean_ = mat0.mean();
    expect(mean_.val1, equals(1));

    final sum_ = mat0.sum();
    expect(sum_.val1, equals(200 * 100));

    final mat1 = mat0.convertTo(cv.MatType.CV_32FC3);
    expect(mat1.at<double>(0, 0), 1);
    final sqrt_ = mat1.sqrt();
    expect(sqrt_.at<double>(0, 0), equals(1.0));
  });
}
