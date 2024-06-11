import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.WeChatQRCode.empty', () {
    final qr = cv.WeChatQRCode.empty();
    expect(qr.ptr, isNotNull);
    final (res, points) = qr.detectAndDecode(cv.imread("test/images/qrcode.png"));
    expect(res.length, 1);
    expect(res.first, "Hello World!");
    expect(points.length, 1);

    qr.dispose();
  });

  test('cv.WeChatQRCode', tags: ["no-local-files"], () {
    final qr = cv.WeChatQRCode(
      "test/models/detect.prototxt",
      "test/models/detect.caffemodel",
      "test/models/sr.prototxt",
      "test/models/sr.caffemodel",
    );
    expect(qr.ptr, isNotNull);
    final (res, points) = qr.detectAndDecode(cv.imread("test/images/multi_qrcodes.png"));
    expect(res.length, 2);
    expect(points.length, 2);
    expect(res, ["bar", "foo"]);

    expect(qr.scaleFactor, closeTo(-1.0, 1e-3));
    qr.scaleFactor = 0.5;
    expect(qr.scaleFactor, closeTo(0.5, 1e-3));
    qr.scaleFactor = 1.5;
    expect(qr.scaleFactor, closeTo(-1.0, 1e-3));
  });
}
