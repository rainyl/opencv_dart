import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.LogisticRegression trainedLr() {
  final lr = cv.LogisticRegression.create()
    ..learningRate = 0.1
    ..iterations = 500
    ..regularization = cv.LogisticRegression.REG_L2
    ..trainMethod = cv.LogisticRegression.BATCH;
  expect(lr.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32()), true);
  return lr;
}

void main() {
  test('cv.LogisticRegression parameters', () {
    final lr = cv.LogisticRegression.create();
    expect(lr.defaultName, 'opencv_ml_lr');
    lr
      ..learningRate = 0.05
      ..iterations = 42
      ..regularization = cv.LogisticRegression.REG_L1
      ..trainMethod = cv.LogisticRegression.MINI_BATCH
      ..miniBatchSize = 4
      ..termCriteria = cv.TermCriteria(cv.TERM_COUNT, 42, 0);
    expect(lr.learningRate, closeTo(0.05, 1e-9));
    expect(lr.iterations, 42);
    expect(lr.regularization, cv.LogisticRegression.REG_L1);
    expect(lr.trainMethod, cv.LogisticRegression.MINI_BATCH);
    expect(lr.miniBatchSize, 4);
    expect(lr.termCriteria.maxCount, 42);
  });

  test('cv.LogisticRegression train, predict, save and load', () async {
    final lr = trainedLr();
    expect(labelsOf(lr.predict(queryPoints())), [0, 1]);
    expect(labelsOf(await lr.predictAsync(queryPoints())), [0, 1]);
    // one row of thetas for a two-class problem: bias + one weight per variable
    expect(lr.learntThetas.shape, [1, 3, 1]);

    final path = '${tempDir()}/lr.yml';
    lr.save(path);
    expect(labelsOf(cv.LogisticRegression.load(path).predict(queryPoints())), [0, 1]);
  });

  test('cv.LogisticRegression errors', () {
    expect(() => cv.LogisticRegression.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
