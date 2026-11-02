import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

/// SVMSGD needs centered data and -1 / 1 responses.
cv.Mat centeredSamples() =>
    cv.Mat.fromList(10, 2, cv.MatType.CV_32FC1, clusterPoints.map((e) => e - 5).toList());
cv.Mat signResponses() =>
    cv.Mat.fromList(10, 1, cv.MatType.CV_32FC1, clusterLabels.map((e) => e == 0 ? -1.0 : 1.0).toList());
cv.Mat centeredQuery() => cv.Mat.fromList(2, 2, cv.MatType.CV_32FC1, <double>[-3.8, -3.7, 3.7, 3.1]);

cv.SVMSGD trainedSgd() {
  final sgd = cv.SVMSGD.create()
    ..setOptimalParameters(svmsgdType: cv.SVMSGD.ASGD, marginType: cv.SVMSGD.SOFT_MARGIN);
  expect(sgd.train(centeredSamples(), cv.ROW_SAMPLE, signResponses()), true);
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
  });

  test('cv.SVMSGD train, predict, save and load', () async {
    final sgd = trainedSgd();
    expect(sgd.weights.total, 2);
    expect(sgd.shift.isFinite, true);
    expect(labelsOf(sgd.predict(centeredQuery())), [-1, 1]);
    expect(labelsOf(await sgd.predictAsync(centeredQuery())), [-1, 1]);

    final path = '${tempDir()}/sgd.yml';
    sgd.save(path);
    expect(labelsOf(cv.SVMSGD.load(path).predict(centeredQuery())), [-1, 1]);
  });

  test('cv.SVMSGD errors', () {
    expect(() => cv.SVMSGD.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
