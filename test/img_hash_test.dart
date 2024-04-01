import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;


const testImage  = "test/images/space_shuttle.jpg";
const testImage2 = "test/images/toy.jpg";


cv.Mat computeHash(String imagePath, cv.ImgHashBase hashAlgorithm) {
  final img = cv.imread(imagePath, flags: cv.IMREAD_COLOR);
  expect(img.isEmpty, false);

  cv.Mat dst = cv.Mat.empty();
  hashAlgorithm.compute(img, dst);
  expect(dst.isEmpty, false);

  return dst;
}

void testHash( cv.ImgHashBase hashAlgorithm) {
  final hash1 = computeHash(testImage, hashAlgorithm);
  expect(hash1.isEmpty, false);

  final hash2 = computeHash(testImage2, hashAlgorithm);
  expect(hash2.isEmpty, false);

  // The range and meaning of this value varies between algorithms, and
	// there doesn't seem to be a well defined set of default thresholds, so
	// "anything but zero" is the minimum smoke test.
  final similarity = hashAlgorithm.compare(hash1, hash2);
  expect(similarity, isNot(equals(0)));
}


void main() async {
  test('cv.PHash', () { testHash(cv.PHash()); });
  test('cv.AverageHash', () { testHash(cv.AverageHash()); });
  test('cv.BlockMeanHash', () { testHash(cv.BlockMeanHash()); });
  test('cv.ColorMomentHash', () { testHash(cv.ColorMomentHash()); });
  test('cv.NewMarrHildrethHash', () { testHash(cv.NewMarrHildrethHash()); });
  test('cv.NewRadialVarianceHash', () { testHash(cv.NewRadialVarianceHash()); });
}
