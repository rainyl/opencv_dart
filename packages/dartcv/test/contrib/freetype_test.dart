import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  final fontFile = File("test/font/hei.ttf");
  test('cv.FreeType2 creation', () async {
    final ft = cv.FreeType2.create();
    ft.loadFontData("test/font/hei.ttf", 0);
    ft.setSplitNumber(1);

    final buffer = await fontFile.readAsBytes();
    ft.loadFontBuffer(buffer, 0);
  });

  test('cv.FreeType2 creation async', () async {
    final ft = cv.FreeType2.create();
    await ft.loadFontDataAsync("test/font/hei.ttf", 0);
    ft.setSplitNumber(1);

    final buffer = await fontFile.readAsBytes();
    await ft.loadFontBufferAsync(buffer, 0);
  });

  test('cv.FreeType2 putText', () {
    final ft = cv.FreeType2.create(filename: "test/font/hei.ttf");

    final mat = cv.Mat.zeros(100, 300, cv.MatType.CV_8UC3);
    ft.putText(
      mat,
      r"你好Hello123'\+",
      cv.Point(10, 10),
      30,
      cv.Scalar.all(255),
      lineType: cv.LINE_4,
      thickness: cv.FILLED,
    );
    cv.imwrite("test/images_out/hei.png", mat);
  });

  test('cv.FreeType2 putText async', () async {
    final ft = cv.FreeType2.create(filename: "test/font/hei.ttf");

    final mat = cv.Mat.zeros(100, 300, cv.MatType.CV_8UC3);
    await ft.putTextAsync(
      mat,
      r"你好Hello123'\+",
      cv.Point(10, 10),
      30,
      cv.Scalar.all(255),
      lineType: cv.LINE_4,
      thickness: cv.FILLED,
    );
    await cv.imwriteAsync("test/images_out/hei.png", mat);
  });
}
