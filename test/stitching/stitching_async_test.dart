import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.StitcherAsync', () async {
    final stitcher = await cv.StitcherAsync.createAsync(mode: cv.StitcherMode.PANORAMA);
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
    final stitcher = await cv.StitcherAsync.createAsync(mode: cv.StitcherMode.PANORAMA);
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

  test('cv.StitcherAsync getter/setter', () async {
    final stitcher = await cv.StitcherAsync.createAsync(mode: cv.StitcherMode.PANORAMA);
    await stitcher.setRegistrationResolAsync(3.14159);
    expect(await stitcher.getRegistrationResolAsync(), 3.14159);

    await stitcher.setSeamEstimationResolAsync(3.14159);
    expect(await stitcher.getSeamEstimationResolAsync(), 3.14159);

    await stitcher.setPanoConfidenceThreshAsync(3.14159);
    expect(await stitcher.getPanoConfidenceThreshAsync(), 3.14159);

    await stitcher.setCompositingResolAsync(3.14159);
    expect(await stitcher.getCompositingResolAsync(), 3.14159);

    await stitcher.setWaveCorrectionAsync(true);
    expect(await stitcher.getWaveCorrectionAsync(), true);

    await stitcher.setWaveCorrectKindAsync(cv.WaveCorrectKind.HORIZONTAL.index);
    expect(await stitcher.getWaveCorrectKindAsync(), cv.WaveCorrectKind.HORIZONTAL.index);

    await stitcher.setInterpolationFlagsAsync(cv.INTER_LINEAR);
    expect(await stitcher.getInterpolationFlagsAsync(), cv.INTER_LINEAR);

    expect((await stitcher.getComponentAsync()).length, greaterThanOrEqualTo(0));
  });

  test('Issue 48', () async {
    final images = [
      await cv.imreadAsync("test/images/barcode1.png", flags: cv.IMREAD_COLOR),
      await cv.imreadAsync("test/images/barcode2.png", flags: cv.IMREAD_COLOR),
    ];

    final stitcher = await cv.StitcherAsync.createAsync();
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
