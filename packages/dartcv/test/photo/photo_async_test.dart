import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.colorChangeAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = await cv.colorChangeAsync(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.seamlessCloneAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = src.clone();
    final p = cv.Point(dst.cols ~/ 2, dst.rows ~/ 2);
    final blend = await cv.seamlessCloneAsync(src, dst, mask, p, cv.NORMAL_CLONE);
    expect(blend.isEmpty, false);
    expect((blend.rows, blend.cols), (dst.rows, dst.cols));
  });

  test('cv.illuminationChangeAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = await cv.illuminationChangeAsync(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.textureFlatteningAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final mask = src.clone();
    final dst = await cv.textureFlatteningAsync(src, mask);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.fastNlMeansDenoisingAsync', () async {
    final img = await cv.imreadAsync(
      "test/images/lenna.png",
      flags: cv.IMREAD_GRAYSCALE,
    );
    expect(img.isEmpty, false);

    final dst = await cv.fastNlMeansDenoisingAsync(img);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  test('cv.fastNlMeansDenoisingColoredMultiAsync', () async {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];

    final dst = await cv.fastNlMeansDenoisingColoredMultiAsync(src.cvd, 1, 1);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src[0].rows, src[0].cols));
  });

  test('cv.fastNlMeansDenoisingColoredAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = await cv.fastNlMeansDenoisingColoredAsync(img);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  test('cv.detailEnhanceAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = await cv.detailEnhanceAsync(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.edgePreservingFilterAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = await cv.edgePreservingFilterAsync(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.pencilSketchAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final (dst1, dst2) = await cv.pencilSketchAsync(src);
    expect(dst1.isEmpty, false);
    expect((dst1.rows, dst1.cols), (src.rows, src.cols));
    expect(dst2.isEmpty, false);
    expect((dst2.rows, dst2.cols), (src.rows, src.cols));
  });

  test('cv.stylizationAsync', () async {
    final src = cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3);
    final dst = await cv.stylizationAsync(src);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  test('cv.inpaintAsync', () async {
    final src = await cv.imreadAsync(
      "test/images/inpaint-src.jpg",
      flags: cv.IMREAD_COLOR,
    );
    expect(src.isEmpty, false);
    final mask = await cv.imreadAsync(
      "test/images/inpaint-mask.jpg",
      flags: cv.IMREAD_GRAYSCALE,
    );
    expect(mask.isEmpty, false);
    final dst = await cv.inpaintAsync(src, mask, 10, cv.INPAINT_TELEA);
    expect(dst.channels, greaterThan(1));
    final sum = dst.sum();
    expect(sum == cv.Scalar.all(0), false);
  });

  test('cv.MergeMertensAsync', () async {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];
    final mertens = await cv.MergeMertensAsync.emptyNewAsync();
    final dst = await mertens.processAsync(src.cvd);
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (src[0].rows, src[0].cols));

    final mertens1 = await cv.MergeMertensAsync.createAsync();
    final dst1 = await mertens1.processAsync(src.cvd);
    expect(dst1.isEmpty, false);
    expect((dst1.rows, dst1.cols), (src[0].rows, src[0].cols));

    mertens1.dispose();
  });

  test('cv.AlignMTBAsync', () async {
    final src = [
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
      cv.Mat.zeros(20, 20, cv.MatType.CV_8UC3),
    ];

    final alignmtb = await cv.AlignMTBAsync.emptyNewAsync();
    final dst = await alignmtb.processAsync(src.cvd);
    expect(dst.length, greaterThan(0));

    final alignmtb1 = await cv.AlignMTBAsync.createAsync();
    final dst1 = await alignmtb1.processAsync(src.cvd);
    expect(dst1.length, greaterThan(0));

    alignmtb1.dispose();
  });
}
