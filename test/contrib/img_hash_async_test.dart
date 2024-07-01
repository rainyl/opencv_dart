import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

const testImage = "test/images/space_shuttle.jpg";
const testImage2 = "test/images/toy.jpg";

Future<cv.Mat> computeHashAsync(String imagePath, cv.ImgHashBase hashAlgorithm) async {
  final img = cv.imread(imagePath, flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  final cv.Mat dst = cv.Mat.empty();
  await hashAlgorithm.computeAsync(img, dst);
  expect(dst.isEmpty, false);

  return dst;
}

Future<void> testHashAsync(cv.ImgHashBase hashAlgorithm) async {
  final hash1 = await computeHashAsync(testImage, hashAlgorithm);
  expect(hash1.isEmpty, false);

  final hash2 = await computeHashAsync(testImage2, hashAlgorithm);
  expect(hash2.isEmpty, false);

  // The range and meaning of this value varies between algorithms, and
  // there doesn't seem to be a well defined set of default thresholds, so
  // "anything but zero" is the minimum smoke test.
  final similarity = await hashAlgorithm.compareAsync(hash1, hash2);
  expect(similarity, isNot(equals(0)));
}

void main() async {
  test('cv.PHash', () async => await testHashAsync(cv.PHash()));
  test('cv.AverageHash', () async => await testHashAsync(cv.AverageHash()));
  test('cv.BlockMeanHash', () async => await testHashAsync(cv.BlockMeanHash()));
  test('cv.ColorMomentHash', () async => await testHashAsync(cv.ColorMomentHash()));
  test('cv.NewMarrHildrethHash', () async => await testHashAsync(cv.NewMarrHildrethHash()));
  test('cv.NewRadialVarianceHash', () async => await testHashAsync(cv.NewRadialVarianceHash()));

  test("cv.BlockMeanHash more", () async {
    final bmh = cv.BlockMeanHash();
    final hash = cv.Mat.empty();
    final img = cv.Mat.ones(256, 256, cv.MatType.CV_8UC1);
    for (var i = 0; i < img.rows; i++) {
      for (var j = 0; j < img.cols; j++) {
        img.set<cv.U8>(i, j, i + j);
      }
    }
    await bmh.computeAsync(img, hash);
    final expectedHash = [
      0,
      255,
      128,
      127,
      192,
      63,
      224,
      31,
      240,
      15,
      248,
      7,
      252,
      3,
      254,
      1,
      255,
      0,
      127,
      128,
      63,
      192,
      31,
      224,
      15,
      240,
      7,
      248,
      3,
      252,
      1,
      254,
    ];
    expect(hash.toList()[0], expectedHash);
    final mean = await bmh.getMeanAsync();
    bmh.mode = cv.BLOCK_MEAN_HASH_MODE_1;
    expect(mean.length, greaterThan(0));

    bmh.dispose();
  });
}
