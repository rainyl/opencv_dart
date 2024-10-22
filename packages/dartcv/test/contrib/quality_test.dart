import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void checkResult(cv.Scalar value, List<double> values, {double eps = 1e-3, cv.Mat? qualityMap}) {
  expect(value.val1, closeTo(values[0], eps));
  expect(value.val2, closeTo(values[1], eps));
  expect(value.val3, closeTo(values[2], eps));

  if (qualityMap != null) {
    expect(qualityMap.isEmpty, false);
  }
}

void main() async {
  final refImg = cv.imread("test/images/lenna.png");
  final target = cv.gaussianBlur(refImg, (5, 5), 15);

  // https://github.com/shimat/opencvsharp/blob/main/test/OpenCvSharp.Tests/quality/QualityBRISQUETest.cs
  test("cv.quality.QualityBRISQUE", () async {
    const modelPath = "test/data/brisque_model_live.yml";
    const rangePath = "test/data/brisque_range_live.yml";

    {
      final qualifier = cv.QualityBRISQUE.create(modelPath, rangePath);
      var value = qualifier.compute(refImg);
      expect(value, cv.Scalar(0, 0, 0));

      value = qualifier.compute(target);
      checkResult(value, [57.261, 0, 0]);

      value = await qualifier.computeAsync(target);
      checkResult(value, [57.261, 0, 0]);
    }

    {
      var value = cv.QualityBRISQUE.compute1(modelPath, rangePath, refImg);
      expect(value, cv.Scalar(0, 0, 0));

      value = cv.QualityBRISQUE.compute1(modelPath, rangePath, target);
      checkResult(value, [57.261, 0, 0]);

      value = await cv.QualityBRISQUE.compute1Async(modelPath, rangePath, target);
      checkResult(value, [57.261, 0, 0]);

      var features = cv.QualityBRISQUE.computeFeatures(refImg);
      expect(features.isEmpty, false);

      features = await cv.QualityBRISQUE.computeFeaturesAsync(refImg);
      expect(features.isEmpty, false);
    }
  });

  test("cv.quality.QualityGMSD", () async {
    // FIXME: wont exit, someting wrong
    {
      final qualifier = cv.QualityGMSD.create(refImg);
      // var value = qualifier.compute(target);
      // checkResult(value, [0.0616, 0.0711, 0.05983]);

      // value = await qualifier.computeAsync(target);
      // checkResult(value, [0.0616, 0.0711, 0.05983]);
    }
    // {
    //   var (value, qualityMap) = cv.QualityGMSD.compute1(refImg, target);
    //   checkResult(value, [0.0616, 0.0711, 0.05983], qualityMap: qualityMap);

    //   (value, qualityMap) = await cv.QualityGMSD.compute1Async(refImg, target);
    //   checkResult(value, [0.0616, 0.0711, 0.05983], qualityMap: qualityMap);
    // }
  });

  test("cv.quality.QualityMSE", () async {
    // FIXME: wont exit, someting wrong
    {
      final qualifier = cv.QualityMSE.create(refImg);
      var value = qualifier.compute(target);
      checkResult(value, [83.89224, 96.848604, 50.611845]);

      value = await qualifier.computeAsync(target);
      checkResult(value, [83.89224, 96.848604, 50.611845]);
    }
    {
      var (value, qualityMap) = cv.QualityMSE.compute1(refImg, target);
      checkResult(value, [83.89224, 96.848604, 50.611845], qualityMap: qualityMap);

      (value, qualityMap) = await cv.QualityMSE.compute1Async(refImg, target);
      checkResult(value, [83.89224, 96.848604, 50.611845], qualityMap: qualityMap);
    }
  });

  test("cv.quality.QualityPSNR", () async {
    // FIXME: wont exit, someting wrong
    {
      final qualifier = cv.QualityPSNR.create(refImg);
      var value = qualifier.compute(target);
      checkResult(value, [28.893586, 28.26987, 31.088282]);

      value = await qualifier.computeAsync(target);
      checkResult(value, [28.893586, 28.26987, 31.088282]);

      qualifier.maxPixelValue = 241;
      expect(qualifier.maxPixelValue, 241);
    }
    {
      var (value, qualityMap) = cv.QualityPSNR.compute1(refImg, target);
      checkResult(value, [28.893586, 28.26987, 31.088282], qualityMap: qualityMap);

      (value, qualityMap) = await cv.QualityPSNR.compute1Async(refImg, target);
      checkResult(value, [28.893586, 28.26987, 31.088282], qualityMap: qualityMap);
    }
  });

  test("cv.quality.QualitySSIM", () async {
    // FIXME: wont exit, someting wrong
    {
      final qualifier = cv.QualitySSIM.create(refImg);
      var value = qualifier.compute(target);
      checkResult(value, [0.72, 0.793, 0.863]);

      value = await qualifier.computeAsync(target);
      checkResult(value, [0.72, 0.793, 0.863]);
    }

    {
      var (value, qualityMap) = cv.QualitySSIM.compute1(refImg, target);
      checkResult(value, [0.72, 0.793, 0.863], qualityMap: qualityMap);

      (value, qualityMap) = await cv.QualitySSIM.compute1Async(refImg, target);
      checkResult(value, [0.72, 0.793, 0.863], qualityMap: qualityMap);
    }
  });
}
