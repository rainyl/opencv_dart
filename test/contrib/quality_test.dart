import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() {
  final refImg = cv.imread("test/images/lenna.png");
  final target = cv.gaussianBlur(refImg, (5, 5), 15);

  // https://github.com/shimat/opencvsharp/blob/main/test/OpenCvSharp.Tests/quality/QualityBRISQUETest.cs
  test("cv.quality.QualityBRISQUE", () {
    const modelPath = "test/data/brisque_model_live.yml";
    const rangePath = "test/data/brisque_range_live.yml";

    {
      final qualifier = cv.QualityBRISQUE.create(modelPath, rangePath);
      var value = qualifier.compute(refImg);
      expect(value, cv.Scalar(0, 0, 0));

      value = qualifier.compute(target);
      expect(value.val1, closeTo(57.261, 1e-3));
      expect(value.val2, closeTo(0, 1e-6));
      expect(value.val3, closeTo(0, 1e-6));
    }

    {
      var value = cv.QualityBRISQUE.compute1(modelPath, rangePath, refImg);
      expect(value, cv.Scalar(0, 0, 0));

      value = cv.QualityBRISQUE.compute1(modelPath, rangePath, target);
      expect(value.val1, closeTo(57.261, 1e-3));
      expect(value.val2, closeTo(0, 1e-6));
      expect(value.val3, closeTo(0, 1e-6));

      final features = cv.QualityBRISQUE.computeFeatures(refImg);
      expect(features.isEmpty, false);
    }
  });

  test("cv.quality.QualityGMSD", () {
    {
      final qualifier = cv.QualityGMSD.create(refImg);
      final value = qualifier.compute(target);
      expect(value.val1, closeTo(0.0616, 1e-3));
      expect(value.val2, closeTo(0.0711, 1e-3));
      expect(value.val3, closeTo(0.05983, 1e-3));
    }
    {
      final (value, qualityMap) = cv.QualityGMSD.compute1(refImg, target);
      expect(value.val1, closeTo(0.0616, 1e-3));
      expect(value.val2, closeTo(0.0711, 1e-3));
      expect(value.val3, closeTo(0.05983, 1e-3));

      expect(qualityMap.isEmpty, false);
    }
  });

  test("cv.quality.QualityMSE", () {
    {
      final qualifier = cv.QualityMSE.create(refImg);
      final value = qualifier.compute(target);
      expect(value.val[0], closeTo(83.89224, 1e-6));
      expect(value.val[1], closeTo(96.848604, 1e-6));
      expect(value.val[2], closeTo(50.611845, 1e-6));
    }
    {
      final (value, qualityMap) = cv.QualityMSE.compute1(refImg, target);
      expect(value.val[0], closeTo(83.89224, 1e-6));
      expect(value.val[1], closeTo(96.848604, 1e-6));
      expect(value.val[2], closeTo(50.611845, 1e-6));

      expect(qualityMap.isEmpty, false);
    }
  });

  test("cv.quality.QualityPSNR", () {
    {
      final qualifier = cv.QualityPSNR.create(refImg);
      final value = qualifier.compute(target);
      expect(value.val1, closeTo(28.893586, 1e-6));
      expect(value.val2, closeTo(28.26987, 1e-6));
      expect(value.val3, closeTo(31.088282, 1e-6));

      qualifier.maxPixelValue = 241;
      expect(qualifier.maxPixelValue, 241);
    }
    {
      final (value, qualityMap) = cv.QualityPSNR.compute1(refImg, target);
      expect(value.val1, closeTo(28.893586, 1e-6));
      expect(value.val2, closeTo(28.26987, 1e-6));
      expect(value.val3, closeTo(31.088282, 1e-6));

      expect(qualityMap.isEmpty, false);
    }
  });

  test("cv.quality.QualitySSIM", () {
    {
      final qualifier = cv.QualitySSIM.create(refImg);
      final value = qualifier.compute(target);
      expect(value.val[0], closeTo(0.72, 1e-3));
      expect(value.val[1], closeTo(0.793, 1e-3));
      expect(value.val[2], closeTo(0.863, 1e-3));
    }

    {
      final (value, qualityMap) = cv.QualitySSIM.compute1(refImg, target);
      expect(value.val[0], closeTo(0.72, 1e-3));
      expect(value.val[1], closeTo(0.793, 1e-3));
      expect(value.val[2], closeTo(0.863, 1e-3));

      expect(qualityMap.isEmpty, false);
    }
  });
}
