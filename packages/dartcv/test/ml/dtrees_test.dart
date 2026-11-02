import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.DTrees trainedTree() {
  final tree = cv.DTrees.create()
    ..cvFolds = 0
    ..maxDepth = 4
    ..minSampleCount = 1;
  expect(tree.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
  return tree;
}

void main() {
  test('cv.DTrees parameters', () {
    final tree = cv.DTrees.create();
    expect(tree.defaultName, 'opencv_ml_dtree');
    tree
      ..maxCategories = 5
      ..maxDepth = 7
      ..minSampleCount = 3
      ..cvFolds = 0
      ..useSurrogates = true
      ..use1SERule = false
      ..truncatePrunedTree = false
      ..regressionAccuracy = 0.5
      ..priors = cv.Mat.fromList(1, 2, cv.MatType.CV_32FC1, <double>[1, 2]);
    expect(tree.maxCategories, 5);
    expect(tree.maxDepth, 7);
    expect(tree.minSampleCount, 3);
    expect(tree.cvFolds, 0);
    expect(tree.useSurrogates, true);
    expect(tree.use1SERule, false);
    expect(tree.truncatePrunedTree, false);
    expect(tree.regressionAccuracy, closeTo(0.5, 1e-6));
    expect(tree.priors.total, 2);
    // OpenCV rejects out-of-range values
    expect(() => tree.maxCategories = 1, throwsA(isA<cv.CvException>()));
    expect(() => tree.maxDepth = -1, throwsA(isA<cv.CvException>()));
    // OpenCV clamps the depth and the categories, and does not implement CV pruning
    tree
      ..maxDepth = 30
      ..maxCategories = 20
      ..cvFolds = 1;
    expect(tree.maxDepth, 25);
    expect(tree.maxCategories, 15);
    expect(tree.cvFolds, 0);
    expect(() => tree.cvFolds = 5, throwsA(isA<cv.CvException>()));
  });

  test('cv.DTrees train, predict, save and load', () async {
    final tree = trainedTree();
    expect(tree.isTrained, true);
    expect(tree.isClassifier, true);
    expect(labelsOf(tree.predict(queryPoints())), [0, 1]);
    expect(labelsOf(await tree.predictAsync(queryPoints())), [0, 1]);

    final path = '${tempDir()}/tree.yml';
    tree.save(path);
    expect(labelsOf(cv.DTrees.load(path).predict(queryPoints())), [0, 1]);

    final other = cv.DTrees.create()
      ..cvFolds = 0
      ..maxDepth = 4
      ..minSampleCount = 1;
    expect(await other.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
    expect(labelsOf(other.predict(queryPoints())), [0, 1]);
  });

  test('cv.DTrees tree structure', () {
    final tree = trainedTree();
    final roots = tree.roots;
    final nodes = tree.nodes;
    final splits = tree.splits;
    expect(roots, hasLength(1));
    expect(nodes[roots.first].parent, -1);

    final leaves = nodes.where((n) => n.left < 0 && n.right < 0).toList();
    final inner = nodes.where((n) => n.left >= 0 || n.right >= 0).toList();
    expect(inner, isNotEmpty);
    // the two separable clusters end in leaves of both classes
    expect(leaves.map((n) => n.value.round()).toSet(), {0, 1});
    for (final n in leaves) {
      expect(n.split, -1);
    }
    for (final n in inner) {
      expect(nodes[n.left].parent, nodes.indexOf(n));
      expect(nodes[n.right].parent, nodes.indexOf(n));
      expect(splits[n.split].varIdx, anyOf(0, 1));
      expect(splits[n.split].quality, greaterThan(0));
    }
    // no categorical variables, so no subsets
    expect(tree.subsets, isEmpty);
    expect(cv.DTrees.create().nodes, isEmpty);
  });

  test('cv.DTrees surrogate splits are not implemented', () {
    final tree = cv.DTrees.create()
      ..cvFolds = 0
      ..maxDepth = 4
      ..minSampleCount = 1
      ..useSurrogates = true;
    expect(
      () => tree.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()),
      throwsA(isA<cv.CvException>()),
    );
  });

  test('cv.DTrees errors', () {
    expect(() => cv.DTrees.create().predict(queryPoints()), throwsA(isA<cv.CvException>()));
    expect(() => cv.DTrees.load('/nonexistent/tree.yml'), throwsA(isA<cv.CvException>()));
  });
}
