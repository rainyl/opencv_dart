import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.Boost trainedBoost() {
  final boost = cv.Boost.create()
    ..boostType = cv.Boost.REAL
    ..weakCount = 10
    ..maxDepth = 1
    ..minSampleCount = 1;
  expect(boost.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
  return boost;
}

void main() {
  test('cv.Boost parameters', () {
    final boost = cv.Boost.create();
    expect(boost.defaultName, 'opencv_ml_boost');
    boost
      ..boostType = cv.Boost.GENTLE
      ..weakCount = 7
      ..weightTrimRate = 0.9;
    expect(boost.boostType, cv.Boost.GENTLE);
    expect(boost.weakCount, 7);
    expect(boost.weightTrimRate, closeTo(0.9, 1e-9));
    expect(() => boost.maxDepth = -1, throwsA(isA<cv.CvException>()));
  });

  test('cv.Boost train, predict, save and load', () async {
    final boost = trainedBoost();
    expect(labelsOf(boost.predict(queryPoints())), [0, 1]);
    expect(labelsOf(await boost.predictAsync(queryPoints())), [0, 1]);

    // RAW_OUTPUT alone gives the class index, with PREDICT_SUM the sum of the weak responses
    expect(labelsOf(boost.predict(queryPoints(), flags: cv.StatModel.RAW_OUTPUT)), [0, 1]);
    final raw = boost.predict(queryPoints(), flags: cv.StatModel.RAW_OUTPUT | cv.DTrees.PREDICT_SUM);
    expect(raw.atNum(0, 0) * raw.atNum(1, 0), lessThan(0));

    final path = '${tempDir()}/boost.yml';
    boost.save(path);
    expect(labelsOf(cv.Boost.load(path).predict(queryPoints())), [0, 1]);
  });

  test('cv.Boost errors', () {
    expect(() => cv.Boost.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
