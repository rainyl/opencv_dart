import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.RTrees trainedForest() {
  final forest = cv.RTrees.create()
    ..maxDepth = 4
    ..minSampleCount = 1
    ..calculateVarImportance = true
    ..termCriteria = cv.TermCriteria(cv.TERM_COUNT, 10, 0);
  expect(forest.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
  return forest;
}

void main() {
  test('cv.RTrees parameters', () {
    final forest = cv.RTrees.create();
    expect(forest.defaultName, 'opencv_ml_rtrees');
    forest
      ..activeVarCount = 1
      ..calculateVarImportance = true
      ..maxDepth = 3
      ..termCriteria = cv.TermCriteria(cv.TERM_COUNT, 20, 0);
    expect(forest.activeVarCount, 1);
    expect(forest.calculateVarImportance, true);
    expect(forest.maxDepth, 3);
    expect(forest.termCriteria.maxCount, 20);
    expect(() => forest.regressionAccuracy = -1, throwsA(isA<cv.CvException>()));
  });

  test('cv.RTrees train, predict, votes, save and load', () async {
    final forest = trainedForest();
    expect(labelsOf(forest.predict(queryPoints())), [0, 1]);
    expect(labelsOf(await forest.predictAsync(queryPoints())), [0, 1]);
    expect(forest.varImportance.total, 2);
    expect(forest.oobError, greaterThanOrEqualTo(0));

    // first row: the class labels, then one row of votes per sample
    final votes = forest.getVotes(queryPoints());
    expect(votes.rows, 3);
    expect(votes.cols, 2);

    final path = '${tempDir()}/forest.yml';
    forest.save(path);
    expect(labelsOf(cv.RTrees.load(path).predict(queryPoints())), [0, 1]);
  });

  test('cv.RTrees errors', () {
    expect(() => cv.RTrees.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
