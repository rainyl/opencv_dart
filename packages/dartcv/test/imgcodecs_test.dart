import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test('cv.haveImageReader, cv.haveImageWriter', () {
    expect(cv.haveImageReader("test/images/circles.jpg"), isA<bool>());
    expect(cv.haveImageReader("test/images/avif_test.avif"), isA<bool>());
    expect(cv.haveImageWriter("test/images/circles.jpg"), isA<bool>());
  });

  test('cv.imcount', () {
    expect(cv.imcount("test/images/circles.jpg"), 1);
  });

  test("cv2.imread, cv2.imwrite", () async {
    {
      final cvImage = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
      expect((cvImage.width, cvImage.height), (512, 512));
      expect(cv.imwrite("test/images_out/test_imwrite.png", cvImage), true);
      final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
      final res = cv.imwrite("test/images_out/test_imwrite.png", cvImage, params: params);
      expect(res, true);
    }
    {
      final cvImage = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
      expect((cvImage.width, cvImage.height), (512, 512));
      expect(await cv.imwriteAsync("test/images_out/test_imwrite.png", cvImage), true);
      final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
      final res = await cv.imwriteAsync("test/images_out/test_imwrite.png", cvImage, params: params);
      expect(res, true);
    }
  });

  test("cv2.imencode, cv2.imdecode", () async {
    final cvImage = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    final (success, buf) = cv.imencode(".png", cvImage);
    expect(success, true);
    expect(buf.length, greaterThan(0));
    await File("test/images_out/test_imencode.png").writeAsBytes(buf);
    final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
    final (success1, buf1) = cv.imencode(".png", cvImage, params: params);
    expect(success1, true);
    expect(buf1.length, greaterThan(0));

    final cvimgDecode = cv.imdecode(buf, cv.IMREAD_COLOR);
    expect(cvimgDecode.height, equals(cvImage.height));
    expect(cvimgDecode.width, equals(cvImage.width));
    expect(cvimgDecode.channels, equals(cvImage.channels));

    final dst = cv.Mat.empty();
    cv.imdecode(buf, cv.IMREAD_COLOR, dst: dst);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols, dst.channels), (cvImage.rows, cvImage.cols, cvImage.channels));
  });

  test("cv2.imencodeVec, cv2.imdecodeVec", () async {
    final cvImage = cv.imread("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    final (success, buf) = cv.imencodeVec(".png", cvImage);
    expect(success, true);
    expect(buf.length, greaterThan(0));
    await File("test/images_out/test_imencode.png").writeAsBytes(buf.data);
    final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
    final (success1, buf1) = cv.imencodeVec(".png", cvImage, params: params);
    expect(success1, true);
    expect(buf1.length, greaterThan(0));

    final cvimgDecode = cv.imdecodeVec(buf, cv.IMREAD_COLOR);
    expect(cvimgDecode.height, equals(cvImage.height));
    expect(cvimgDecode.width, equals(cvImage.width));
    expect(cvimgDecode.channels, equals(cvImage.channels));

    final dst = cv.Mat.empty();
    cv.imdecodeVec(buf, cv.IMREAD_COLOR, dst: dst);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols, dst.channels), (cvImage.rows, cvImage.cols, cvImage.channels));
  });

  test("cv2.imencodeAsync, cv2.imdecodeAsync", () async {
    final cvImage = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    final (success, buf) = await cv.imencodeAsync(".png", cvImage);
    expect(success, true);
    expect(buf.length, greaterThan(0));

    await File("test/images_out/test_imencode.png").writeAsBytes(buf);
    final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
    final (success1, buf1) = await cv.imencodeAsync(".png", cvImage, params: params);
    expect(success1, true);
    expect(buf1.length, greaterThan(0));

    final cvimgDecode = await cv.imdecodeAsync(buf, cv.IMREAD_COLOR);
    expect(cvimgDecode.height, equals(cvImage.height));
    expect(cvimgDecode.width, equals(cvImage.width));
    expect(cvimgDecode.channels, equals(cvImage.channels));
  });

  test("cv2.imencodeVecAsync, cv2.imdecodeVecAsync", () async {
    final cvImage = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    expect((cvImage.width, cvImage.height), (512, 512));
    final (success, buf) = await cv.imencodeVecAsync(".png", cvImage);
    expect(success, true);
    expect(buf.length, greaterThan(0));

    await File("test/images_out/test_imencode.png").writeAsBytes(buf.data);
    final params = [cv.IMWRITE_PNG_COMPRESSION, 9].i32;
    final (success1, buf1) = await cv.imencodeVecAsync(".png", cvImage, params: params);
    expect(success1, true);
    expect(buf1.length, greaterThan(0));

    final cvimgDecode = await cv.imdecodeVecAsync(buf, cv.IMREAD_COLOR);
    expect(cvimgDecode.height, equals(cvImage.height));
    expect(cvimgDecode.width, equals(cvImage.width));
    expect(cvimgDecode.channels, equals(cvImage.channels));
  });
}
