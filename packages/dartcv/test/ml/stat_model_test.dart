// The models share the cv::ml::StatModel API but no Dart supertype, so this table-driven test
// calls the shared synchronous members dynamically; async extension methods and static factories
// are passed as typed closures.
// ignore_for_file: avoid_dynamic_calls

import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

typedef ModelCase = ({
  String name,
  dynamic Function() create,
  cv.Mat Function() responses,
  Future<bool> Function(dynamic model, cv.TrainData data) trainWithDataAsync,
  Future<(double, cv.Mat)> Function(dynamic model, cv.TrainData data) calcErrorAsync,
  dynamic Function(String content) loadFromString,
  bool classifier,
  int varCount,
  bool clearUntrains,
});

cv.Mat oneHot() => cv.Mat.fromList(10, 2, cv.MatType.CV_32FC1, [
  for (final l in clusterLabels) ...(l == 0 ? <double>[1, 0] : <double>[0, 1]),
]);

cv.Mat signResponses() =>
    cv.Mat.fromList(10, 1, cv.MatType.CV_32FC1, clusterLabels.map((e) => e == 0 ? -1.0 : 1.0).toList());

final cases = <ModelCase>[
  (
    name: 'SVM',
    create: () => cv.SVM.create()..kernelType = cv.SVM.LINEAR,
    responses: clusterResponsesI32,
    trainWithDataAsync: (m, d) => (m as cv.SVM).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.SVM).calcErrorAsync(d, false),
    loadFromString: cv.SVM.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: true,
  ),
  (
    name: 'KNearest',
    create: cv.KNearest.create,
    responses: clusterResponsesF32,
    trainWithDataAsync: (m, d) => (m as cv.KNearest).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.KNearest).calcErrorAsync(d, false),
    loadFromString: cv.KNearest.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: false,
  ),
  (
    name: 'ANN_MLP',
    create: () => cv.ANN_MLP.create()
      ..layerSizes = cv.Mat.fromList(1, 3, cv.MatType.CV_32SC1, <int>[2, 6, 2])
      ..setActivationFunction(cv.ANN_MLP.SIGMOID_SYM),
    responses: oneHot,
    trainWithDataAsync: (m, d) => (m as cv.ANN_MLP).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.ANN_MLP).calcErrorAsync(d, false),
    loadFromString: cv.ANN_MLP.loadFromString,
    classifier: false,
    varCount: 2,
    clearUntrains: true,
  ),
  (
    name: 'DTrees',
    create: () => cv.DTrees.create()
      ..cvFolds = 0
      ..maxDepth = 4
      ..minSampleCount = 1,
    responses: clusterResponsesI32,
    trainWithDataAsync: (m, d) => (m as cv.DTrees).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.DTrees).calcErrorAsync(d, false),
    loadFromString: cv.DTrees.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: true,
  ),
  (
    name: 'RTrees',
    create: () => cv.RTrees.create()
      ..maxDepth = 4
      ..minSampleCount = 1
      ..termCriteria = cv.TermCriteria(cv.TERM_COUNT, 10, 0),
    responses: clusterResponsesI32,
    trainWithDataAsync: (m, d) => (m as cv.RTrees).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.RTrees).calcErrorAsync(d, false),
    loadFromString: cv.RTrees.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: false,
  ),
  (
    name: 'Boost',
    create: () => cv.Boost.create()
      ..weakCount = 10
      ..maxDepth = 1
      ..minSampleCount = 1,
    responses: clusterResponsesI32,
    trainWithDataAsync: (m, d) => (m as cv.Boost).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.Boost).calcErrorAsync(d, false),
    loadFromString: cv.Boost.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: false,
  ),
  (
    name: 'LogisticRegression',
    create: () => cv.LogisticRegression.create()
      ..learningRate = 0.1
      ..iterations = 500,
    responses: clusterResponsesF32,
    trainWithDataAsync: (m, d) => (m as cv.LogisticRegression).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.LogisticRegression).calcErrorAsync(d, false),
    loadFromString: cv.LogisticRegression.loadFromString,
    classifier: true,
    varCount: 3,
    clearUntrains: true,
  ),
  (
    name: 'NormalBayesClassifier',
    create: cv.NormalBayesClassifier.create,
    responses: clusterResponsesI32,
    trainWithDataAsync: (m, d) => (m as cv.NormalBayesClassifier).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.NormalBayesClassifier).calcErrorAsync(d, false),
    loadFromString: cv.NormalBayesClassifier.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: true,
  ),
  (
    name: 'SVMSGD',
    create: () => cv.SVMSGD.create()..setOptimalParameters(),
    responses: signResponses,
    trainWithDataAsync: (m, d) => (m as cv.SVMSGD).trainWithDataAsync(d),
    calcErrorAsync: (m, d) => (m as cv.SVMSGD).calcErrorAsync(d, false),
    loadFromString: cv.SVMSGD.loadFromString,
    classifier: true,
    varCount: 2,
    clearUntrains: true,
  ),
];

void main() {
  for (final c in cases) {
    test('${c.name} shares the StatModel API', () async {
      final data = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, c.responses());

      final model = c.create();
      expect(model.isTrained, false);
      expect(model.isEmpty, true);
      expect(model.trainWithData(data), true);
      expect(model.isTrained, true);
      expect(model.isEmpty, false);
      expect(model.isClassifier, c.classifier);
      expect(model.varCount, c.varCount);
      expect((model.predict(queryPoints()) as cv.Mat).rows, 2);

      final (err, resp) = model.calcError(data, false) as (double, cv.Mat);
      expect(err.isFinite, true);
      expect(resp.rows, 10);
      expect((await c.calcErrorAsync(model, data)).$1, err);

      final other = c.create();
      expect(await c.trainWithDataAsync(other, data), true);
      expect(other.isTrained, true);

      // a saved model can be loaded back from its content
      final path = '${tempDir()}/model.yml';
      model.save(path);
      final loaded = c.loadFromString(File(path).readAsStringSync());
      expect(loaded.defaultName, model.defaultName);
      expect((loaded.predict(queryPoints()) as cv.Mat).rows, 2);

      // OpenCV's clear does not reset KNearest, RTrees and Boost
      model.clear();
      expect(model.isTrained, !c.clearUntrains);
      if (c.clearUntrains) {
        expect(() => model.predict(queryPoints()), throwsA(isA<cv.CvException>()));
      }
    });
  }

  test('EM shares the StatModel API', () async {
    // unsupervised (OpenCV still reports isClassifier): calcError is not meaningful and train ignores
    // the responses
    final data = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32());
    final em = cv.EM.create()..clustersNumber = 2;
    expect(em.isTrained, false);
    expect(em.trainWithData(data), true);
    expect(em.isTrained, true);
    expect(em.isEmpty, false);
    expect(em.isClassifier, true);
    expect(em.varCount, 2);
    final other = cv.EM.create()..clustersNumber = 2;
    expect(await other.trainWithDataAsync(data), true);

    final path = '${tempDir()}/em.yml';
    em.save(path);
    expect(cv.EM.loadFromString(File(path).readAsStringSync()).means.rows, 2);
    em.clear();
    expect(em.isTrained, false);
  });

  // the tree parameters are inherited from DTrees by RTrees and Boost
  for (final (name, create) in <(String, dynamic Function())>[
    ('RTrees', cv.RTrees.create),
    ('Boost', cv.Boost.create),
  ]) {
    test('$name tree parameters', () {
      final model = create()
        ..maxCategories = 5
        ..maxDepth = 7
        ..minSampleCount = 3
        ..cvFolds = 0
        ..useSurrogates = false
        ..use1SERule = false
        ..truncatePrunedTree = false
        ..regressionAccuracy = 0.5
        ..priors = cv.Mat.fromList(1, 2, cv.MatType.CV_32FC1, <double>[1, 2]);
      expect(model.maxCategories, 5);
      expect(model.maxDepth, 7);
      expect(model.minSampleCount, 3);
      expect(model.cvFolds, 0);
      expect(model.useSurrogates, false);
      expect(model.use1SERule, false);
      expect(model.truncatePrunedTree, false);
      expect(model.regressionAccuracy, closeTo(0.5, 1e-6));
      expect((model.priors as cv.Mat).total, 2);
      expect(() => model.maxCategories = 1, throwsA(isA<cv.CvException>()));
    });
  }
}
