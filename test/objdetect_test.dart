@Tags(["not-finished"])
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

    final res = cv.groupRectangles(rects, 1, 0.2);
    expect(res.length, 1);
    expect(res.first, cv.Rect(10, 10, 32, 32));
  });

  test('cv.QRCodeDetector', () {
    final img = cv.imread("test/images/qrcode.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final detector = cv.QRCodeDetector.empty();
    final bbox = cv.Mat.empty();
    final qr = cv.Mat.empty();
    final res = detector.detect(img, bbox);
    expect(res, true);

    final res2 = detector.decode(img, bbox, straight_code: qr);
    final res2_1 = detector.decode(img, bbox);
    final res3 = detector.detectAndDecode(img, bbox, straight_code: qr);
    final res3_1 = detector.detectAndDecode(img, bbox);
    expect(res2_1, equals(res2));
    expect(res2, equals(res3));
    expect(res3_1, equals(res3));

    final img2 = cv.imread("test/images/multi_qrcodes.png", flags: cv.IMREAD_COLOR);
    expect(img2.isEmpty, false);

    final multiBox = cv.Mat.empty();
    final res4 = detector.detectMulti(img2, multiBox);
    expect(res4, true);
    expect(multiBox.rows, 2);

    // final multiBox2 = cv.Mat.empty();
  });
}
