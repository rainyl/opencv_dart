import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.StitcherAsync', () async {
    // FIXME: wont exit, someting wrong
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      await cv.imreadAsync("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      await cv.imreadAsync("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];
    final (status, pano) = await stitcher.stitchAsync(images.cvd);
    expect(status, cv.StitcherStatus.OK);
    expect(pano.isEmpty, false);
    stitcher.dispose();
  });

  test('cv.StitcherAsync with mask', () async {
    // FIXME: wont exit, someting wrong
    final stitcher = cv.Stitcher.create(mode: cv.StitcherMode.PANORAMA);
    final images = [
      await cv.imreadAsync("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      await cv.imreadAsync("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];

    final masks = [
      await cv.imreadAsync("test/images/barcode_mask1.png", flags: cv.IMREAD_GRAYSCALE),
      await cv.imreadAsync("test/images/barcode_mask2.png", flags: cv.IMREAD_GRAYSCALE),
    ];
    final (status, pano) = await stitcher.stitchAsync(images.cvd, masks: masks.cvd);
    expect(status, cv.StitcherStatus.OK);
    expect(pano.isEmpty, false);
    stitcher.dispose();
  });

  test('Issue 48', () async {
    // FIXME: wont exit, someting wrong
    final images = [
      await cv.imreadAsync("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      await cv.imreadAsync("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];

    final stitcher = cv.Stitcher.create();
    final status = await stitcher.estimateTransformAsync(images.cvd);
    expect(status, cv.StitcherStatus.OK);

    final result = await stitcher.composePanoramaAsync();
    expect(result.$1, cv.StitcherStatus.OK);
    expect(result.$2.isEmpty, false);

    final result1 = await stitcher.composePanoramaAsync(images: images.cvd);
    expect(result1.$1, cv.StitcherStatus.OK);
    expect(result1.$2.isEmpty, false);
  });
}
