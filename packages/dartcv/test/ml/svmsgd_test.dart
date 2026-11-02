import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

/// The negative class must be < 0.
cv.Mat signResponses() =>
    cv.Mat.fromList(10, 1, cv.MatType.CV_32FC1, clusterLabels.map((e) => e == 0 ? -1.0 : 1.0).toList());

cv.SVMSGD trainedSgd() {
  final sgd = cv.SVMSGD.create()
    ..setOptimalParameters(svmsgdType: cv.SVMSGD.ASGD, marginType: cv.SVMSGD.SOFT_MARGIN);
  expect(sgd.train(clusterSamples(), cv.ROW_SAMPLE, signResponses()), true);
  return sgd;
}

void main() {
  test('cv.SVMSGD parameters', () {
    final sgd = cv.SVMSGD.create();
    expect(sgd.defaultName, 'opencv_ml_svmsgd');
    sgd
      ..svmsgdType = cv.SVMSGD.SGD
      ..marginType = cv.SVMSGD.HARD_MARGIN
      ..marginRegularization = 0.01
      ..initialStepSize = 0.5
      ..stepDecreasingPower = 0.75;
    expect(sgd.svmsgdType, cv.SVMSGD.SGD);
    expect(sgd.marginType, cv.SVMSGD.HARD_MARGIN);
    expect(sgd.marginRegularization, closeTo(0.01, 1e-6));
    expect(sgd.initialStepSize, closeTo(0.5, 1e-6));
    expect(sgd.stepDecreasingPower, closeTo(0.75, 1e-6));

    sgd.setOptimalParameters();
    expect(sgd.svmsgdType, cv.SVMSGD.ASGD);
    expect(sgd.marginType, cv.SVMSGD.SOFT_MARGIN);
    expect(() => sgd.setOptimalParameters(svmsgdType: 7), throwsA(isA<cv.CvException>()));
  });

  test('cv.SVMSGD train, predict, save and load', () async {
    final sgd = trainedSgd();
    expect(sgd.weights.total, 2);
    // predict is the sign of the decision function weights * x + shift
    final w = sgd.weights;
    double decision(double x, double y) => w.atNum(0, 0) * x + w.atNum(0, 1) * y + sgd.shift;
    expect(decision(1.2, 1.3), lessThan(0));
    expect(decision(8.7, 8.1), greaterThan(0));
    expect(labelsOf(sgd.predict(queryPoints())), [-1, 1]);
    expect(labelsOf(await sgd.predictAsync(queryPoints())), [-1, 1]);

    final path = '${tempDir()}/sgd.yml';
    sgd.save(path);
    expect(labelsOf(cv.SVMSGD.load(path).predict(queryPoints())), [-1, 1]);
  });

  test('cv.SVMSGD without negative responses trains a constant model', () {
    final sgd = cv.SVMSGD.create()..setOptimalParameters();
    expect(sgd.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32()), true);
    expect(sgd.weights.atNum(0, 0), 0);
    expect(labelsOf(sgd.predict(queryPoints())), [1, 1]);
  });

  test('cv.SVMSGD errors', () {
    expect(() => cv.SVMSGD.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
