import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.NormalBayesClassifier trainedBayes() {
  final bayes = cv.NormalBayesClassifier.create();
  expect(bayes.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
  return bayes;
}

void main() {
  test('cv.NormalBayesClassifier train, predict and predictProb', () async {
    final bayes = trainedBayes();
    expect(bayes.defaultName, 'opencv_ml_nbayes');
    expect(bayes.isClassifier, true);
    expect(labelsOf(bayes.predict(queryPoints())), [0, 1]);

    final (outputs, probs) = bayes.predictProb(queryPoints());
    expect(labelsOf(outputs), [0, 1]);
    expect(probs.shape, [2, 2, 1]);
    expect(probs.atNum(0, 0), greaterThan(probs.atNum(0, 1)));
    expect(probs.atNum(1, 1), greaterThan(probs.atNum(1, 0)));

    final (asyncOutputs, asyncProbs) = await bayes.predictProbAsync(queryPoints());
    expect(labelsOf(asyncOutputs), [0, 1]);
    expect(asyncProbs.atNum(0, 0), probs.atNum(0, 0));
  });

  test('cv.NormalBayesClassifier save and load', () {
    final path = '${tempDir()}/bayes.yml';
    trainedBayes().save(path);
    expect(labelsOf(cv.NormalBayesClassifier.load(path).predict(queryPoints())), [0, 1]);
  });

  test('cv.NormalBayesClassifier errors', () {
    expect(() => cv.NormalBayesClassifier.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
  });
}
