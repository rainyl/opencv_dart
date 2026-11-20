import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.KNearest trainedKnn() {
  final knn = cv.KNearest.create();
  expect(knn.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32()), true);
  return knn;
}

void main() {
  test('cv.KNearest parameters', () {
    final knn = cv.KNearest.create();
    expect(knn.defaultName, 'opencv_ml_knn');
    expect(knn.defaultK, 10);
    expect(knn.isClassifier, true);
    expect(knn.algorithmType, cv.KNearest.BRUTE_FORCE);
    knn
      ..defaultK = 3
      ..isClassifier = false
      ..emax = 5
      ..algorithmType = cv.KNearest.KDTREE;
    expect(knn.defaultK, 3);
    expect(knn.isClassifier, false);
    expect(knn.emax, 5);
    expect(knn.algorithmType, cv.KNearest.KDTREE);
    expect(knn.defaultName, 'opencv_ml_knn_kd');
  });

  test('cv.KNearest findNearest and predict', () {
    final knn = trainedKnn();
    expect(knn.isTrained, true);
    expect(knn.varCount, 2);

    final (results, neighbors, dist) = knn.findNearest(queryPoints(), 3);
    expect(labelsOf(results), [0, 1]);
    expect(neighbors.shape, [2, 3, 1]);
    expect(dist.shape, [2, 3, 1]);
    expect(dist.at<double>(0, 0), lessThan(1));

    knn.defaultK = 3;
    expect(labelsOf(knn.predict(queryPoints())), [0, 1]);
  });

  test('cv.KNearest save and load', () {
    final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/knn.yml';
    trainedKnn()
      ..defaultK = 3
      ..save(path);
    final loaded = cv.KNearest.load(path);
    expect(loaded.defaultK, 3);
    expect(labelsOf(loaded.predict(queryPoints())), [0, 1]);
  });

  test('cv.KNearest errors', () {
    final knn = cv.KNearest.create();
    expect(() => knn.findNearest(queryPoints(), 3), throwsA(isA<cv.CvException>()));
    expect(() => cv.KNearest.loadFromString('%YAML:1.0\nfoo: 1\n'), throwsA(isA<cv.CvException>()));
    expect(() => trainedKnn().save('/nonexistent/dir/knn.yml'), throwsA(isA<cv.CvException>()));
  });
}
