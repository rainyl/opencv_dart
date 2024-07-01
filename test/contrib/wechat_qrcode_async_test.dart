import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.WeChatQRCode.empty', () async {
    final qr = await cv.WeChatQRCodeAsync.emptyAsync();
    expect(qr.ptr, isNotNull);
    final (res, points) =
        await qr.detectAndDecodeAsync(cv.imread("test/images/qrcode.png"));
    expect(res.length, 1);
    expect(res.first, "Hello World!");
    expect(points.length, 1);

    qr.dispose();
  });

  test('cv.WeChatQRCode', tags: ["no-local-files"], () async {
    final qr = await cv.WeChatQRCodeAsync.createAsync(
      "test/models/detect.prototxt",
      "test/models/detect.caffemodel",
      "test/models/sr.prototxt",
      "test/models/sr.caffemodel",
    );
    expect(qr.ptr, isNotNull);
    final (res, points) = await qr
        .detectAndDecodeAsync(cv.imread("test/images/multi_qrcodes.png"));
    expect(res.length, 2);
    expect(points.length, 2);
    expect(res, ["bar", "foo"]);

    expect(await qr.scaleFactorAsync, closeTo(-1.0, 1e-3));
    await qr.setScaleFactorAsync(0.5);
    expect(await qr.scaleFactorAsync, closeTo(0.5, 1e-3));
    await qr.setScaleFactorAsync(1.5);
    expect(await qr.scaleFactorAsync, closeTo(-1.0, 1e-3));
  });
}
