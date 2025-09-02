// ignore_for_file: avoid_print

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.UMat.empty', () {
    final mat = cv.UMat.empty();
    expect(mat.isEmpty, true);
  });

  test('cv.UMat.create', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC3);
    expect(mat.isEmpty, equals(false));
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 3));
    expect(mat.type, cv.MatType.CV_8UC3);
    expect(mat.total, equals(100 * 100));
    expect(mat.isContinuous, equals(true));
    expect(mat.step.$1, equals(100 * 3));
    expect(mat.elemSize, equals(3));
    expect(mat.elemSize1, 1);
    expect(mat.dims, 2);
    expect(mat.flags, isA<int>());
  });

  test('cv.UMat.zeros ones eye diag', () {
    final mat2 = cv.UMat.zeros(rows: 3, cols: 3, type: cv.MatType.CV_8UC1);
    expect((mat2.rows, mat2.cols, mat2.channels), (3, 3, 1));

    final mat21 = cv.UMat.zerosND([3, 3, 100, 100], cv.MatType.CV_32FC4);
    expect(mat21.size, [3, 3, 100, 100]);
    expect(mat21.type, cv.MatType.CV_32FC4);

    final mat3 = cv.UMat.eye(rows: 3, cols: 3, type: cv.MatType.CV_8UC3);
    expect((mat3.rows, mat3.cols, mat3.channels), (3, 3, 3));

    final mat4 = cv.UMat.ones(100, 1, cv.MatType.CV_8UC3);
    expect((mat4.rows, mat4.cols, mat4.channels), (100, 1, 3));

    final mat41 = cv.UMat.onesND([3, 3, 100, 100], cv.MatType.CV_32FC4);
    expect(mat41.size, [3, 3, 100, 100]);
    expect(mat41.type, cv.MatType.CV_32FC4);

    final mat5 = cv.UMat.diag(mat4);
    expect((mat5.rows, mat5.cols, mat5.channels), (100, 100, 3));
  });

  test('cv.UMat.fromSizes', () {
    final mat = cv.UMat.nd([3, 3, 100, 100], cv.MatType.CV_32FC4);
    expect(mat.size, [3, 3, 100, 100]);
    expect(mat.type, cv.MatType.CV_32FC4);
    expect(mat.dims, 4);

    final mat1 = cv.UMat.fromUMat(mat);
    expect(mat1.size, [3, 3, 100, 100]);
    expect(mat1.type, cv.MatType.CV_32FC4);
    expect(mat1.dims, 4);
  });

  test('cv.UMat.fromRange', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC3);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 3));

    final mat1 = cv.UMat.fromRange(mat, rowStart: 10, rowEnd: 90, colStart: 10, colEnd: 90);
    expect((mat1.rows, mat1.cols, mat1.channels), (80, 80, 3));
    expect(mat1.type, cv.MatType.CV_8UC3);

    final mat2 = cv.UMat.fromRect(mat, cv.Rect(10, 10, 80, 80));
    expect((mat2.rows, mat2.cols, mat2.channels), (80, 80, 3));
    expect(mat2.type, cv.MatType.CV_8UC3);
  });

  test('cv.UMat.getMat', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC3);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 3));
    expect(mat.type, cv.MatType.CV_8UC3);

    final mat1 = mat.getMat(cv.AccessFlag.ACCESS_RW);
    expect((mat1.rows, mat1.cols, mat1.channels), (100, 100, 3));
    expect(mat1.type, cv.MatType.CV_8UC3);

    mat1.setTo(cv.Scalar.all(241));
    expect(mat1.at<int>(0, 0), 241);

    mat1.dispose();
  });

  test('cv.UMat.row col rowRange colRange', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC3);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 3));
    expect(mat.type, cv.MatType.CV_8UC3);

    final mat1 = mat.row(0);
    expect((mat1.rows, mat1.cols, mat1.channels), (1, 100, 3));
    expect(mat1.type, cv.MatType.CV_8UC3);

    final mat2 = mat.col(0);
    expect((mat2.rows, mat2.cols, mat2.channels), (100, 1, 3));
    expect(mat2.type, cv.MatType.CV_8UC3);

    final mat3 = mat.rowRange(0, 10);
    expect((mat3.rows, mat3.cols, mat3.channels), (10, 100, 3));
    expect(mat3.type, cv.MatType.CV_8UC3);

    final mat4 = mat.colRange(0, 10);
    expect((mat4.rows, mat4.cols, mat4.channels), (100, 10, 3));
    expect(mat4.type, cv.MatType.CV_8UC3);
  });

  test('cv.UMat.diag clone', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC1);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 1));
    expect(mat.type, cv.MatType.CV_8UC1);

    final mat1 = mat.diag(d: 0);
    expect((mat1.rows, mat1.cols, mat1.channels), (100, 1, 1));
    expect(mat1.type, cv.MatType.CV_8UC1);

    final mat2 = mat.clone();
    expect((mat2.rows, mat2.cols, mat2.channels), (100, 100, 1));
    expect(mat2.type, cv.MatType.CV_8UC1);
  });

  test('cv.UMat copyTo convertTo setTo reshape t inv mul dot', () {
    final mat = cv.UMat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC1);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 1));
    expect(mat.type, cv.MatType.CV_8UC1);

    final dst = cv.UMat.empty();
    mat.copyTo(dst);
    mat.setTo(cv.Scalar.all(241));
    expect((dst.rows, dst.cols, dst.channels), (mat.rows, mat.cols, mat.channels));
    expect(dst.type, cv.MatType.CV_8UC1);

    final mat1 = mat.convertTo(cv.MatType.CV_32FC1);
    expect((mat1.rows, mat1.cols, mat1.channels), (mat.rows, mat.cols, mat.channels));
    expect(mat1.type, cv.MatType.CV_32FC1);

    final mat2 = mat1.inv();
    expect((mat2.rows, mat2.cols, mat2.channels), (mat.rows, mat.cols, mat.channels));
    expect(mat2.type, cv.MatType.CV_32FC1);

    final mat3 = mat2.mul(mat1);
    expect((mat3.rows, mat3.cols, mat3.channels), (mat.rows, mat.cols, mat.channels));
    expect(mat3.type, cv.MatType.CV_32FC1);

    final mat4 = mat3.reshape(10, rows: 10);
    expect((mat4.rows, mat4.cols, mat4.channels), (10, 100, 10));
    expect(mat4.type, const cv.MatType.CV_32FC(10));

    final mat5 = mat4.reshape(1, newSizes: [100, 100]);
    expect(mat5.size, [100, 100]);
    expect(mat5.type, const cv.MatType.CV_32FC(1));

    final mat6 = mat5.t();
    expect((mat6.rows, mat6.cols, mat6.channels), (100, 100, 1));
    expect(mat6.type, const cv.MatType.CV_32FC(1));

    expect(mat6.toString(), startsWith("UMat(addr=0x"));

    mat6.release();
    mat6.dispose();

    final res = mat3.dot(mat2);
    expect(res, isA<double>());
  });

  test('cv.Mat.getUMat', () {
    final mat = cv.Mat.create(rows: 100, cols: 100, type: cv.MatType.CV_8UC3);
    expect((mat.rows, mat.cols, mat.channels), (100, 100, 3));
    expect(mat.type, cv.MatType.CV_8UC3);

    final umat = mat.getUMat(cv.AccessFlag.ACCESS_RW);
    expect((umat.rows, umat.cols, umat.channels), (100, 100, 3));

    umat.addref();
    umat.release();

    umat.dispose();

    mat.dispose();
  });
}
