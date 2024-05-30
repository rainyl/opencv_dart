import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test('cv.CascadeClassifier', () {
    final img = cv.imread("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final classifier = cv.CascadeClassifier.empty();
    classifier.load("test/haarcascade_frontalface_default.xml");
    final rects = classifier.detectMultiScale(img);
    expect(rects.length, 1);
  });

  test('cv.HOGDescriptor', () {
    final img = cv.imread("test/images/face.jpg", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final hog = cv.HOGDescriptor.empty();
    hog.setSVMDetector(cv.HOGDescriptor.getDefaultPeopleDetector());
    final rects = hog.detectMultiScale(img);
    expect(rects.length, greaterThanOrEqualTo(0));

    hog.dispose();
  });

  test('cv.groupRectangles', () {
    final rects = [
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 30, 30),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
      cv.Rect(10, 10, 35, 35),
    ];

    final res = cv.groupRectangles(rects.cvd, 1, 0.2);
    expect(res.length, 1);
    expect(res.first, cv.Rect(10, 10, 32, 32));
  });

  test('cv.QRCodeDetector', () {
    final img = cv.imread("test/images/qrcode.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = cv.QRCodeDetector.empty();
    final (res, bbox) = detector.detect(img);
    expect(res, true);
    expect(bbox, isNotNull);

    final (res2, bbox2, codes2) = detector.decode(img);
    final (res2_1, bbox2_1, codes2_1) = detector.decode(img);
    expect(res2_1, equals(res2));
    expect(bbox2_1, bbox2);
    expect(codes2?.shape, codes2_1?.shape);
    final (res3, bbox3, codes3) = detector.detectAndDecode(img);
    final (res3_1, bbox3_1, codes3_1) = detector.detectAndDecode(img);
    expect(bbox3_1, bbox3);
    expect(codes3?.shape, codes3_1?.shape);
    expect(res2, equals(res3));
    expect(res3_1, equals(res3));

    final img2 = cv.imread("test/images/multi_qrcodes.png", flags: cv.IMREAD_COLOR);
    expect(img2.isEmpty, false);

    final (res4, multiBox) = detector.detectMulti(img2);
    expect(res4, true);
    expect(multiBox, isNotNull);
    expect(multiBox?.length, greaterThan(0));

    detector.dispose();
  });
}
