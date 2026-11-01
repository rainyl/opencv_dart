import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

/// One-hot targets of the clusters, CV_32F as ANN_MLP requires.
cv.Mat oneHot() => cv.Mat.fromList(
  10,
  2,
  cv.MatType.CV_32FC1,
  [
    for (final l in clusterLabels) ...(l == 0 ? <double>[1, 0] : <double>[0, 1]),
  ],
);

List<int> argmaxRows(cv.Mat m) =>
    List.generate(m.rows, (i) => m.at<double>(i, 0) > m.at<double>(i, 1) ? 0 : 1);

cv.ANN_MLP trainedMlp() {
  final mlp = cv.ANN_MLP.create()
    ..layerSizes = cv.Mat.fromList(1, 3, cv.MatType.CV_32SC1, <int>[2, 6, 2])
    ..setActivationFunction(cv.ANN_MLP.SIGMOID_SYM)
    ..termCriteria = cv.TermCriteria(cv.TERM_COUNT + cv.TERM_EPS, 1000, 1e-6);
  expect(mlp.train(clusterSamples(), cv.ROW_SAMPLE, oneHot()), true);
  return mlp;
}

void main() {
  test('cv.ANN_MLP parameters', () {
    final mlp = cv.ANN_MLP.create();
    expect(mlp.trainMethod, cv.ANN_MLP.RPROP);
    mlp.setTrainMethod(cv.ANN_MLP.BACKPROP, param1: 0.1, param2: 0.1);
    expect(mlp.trainMethod, cv.ANN_MLP.BACKPROP);
    expect(mlp.backpropWeightScale, closeTo(0.1, 1e-9));
    expect(mlp.backpropMomentumScale, closeTo(0.1, 1e-9));

    mlp
      ..backpropWeightScale = 0.2
      ..backpropMomentumScale = 0.3
      ..rpropDW0 = 0.4
      ..rpropDWPlus = 1.5
      ..rpropDWMinus = 0.6
      ..rpropDWMin = 0.01
      ..rpropDWMax = 40
      ..annealInitialT = 11
      ..annealFinalT = 0.2
      ..annealCoolingRatio = 0.9
      ..annealItePerStep = 7;
    expect(mlp.backpropWeightScale, closeTo(0.2, 1e-9));
    expect(mlp.backpropMomentumScale, closeTo(0.3, 1e-9));
    expect(mlp.rpropDW0, closeTo(0.4, 1e-9));
    expect(mlp.rpropDWPlus, closeTo(1.5, 1e-9));
    expect(mlp.rpropDWMinus, closeTo(0.6, 1e-9));
    expect(mlp.rpropDWMin, closeTo(0.01, 1e-9));
    expect(mlp.rpropDWMax, closeTo(40, 1e-9));
    expect(mlp.annealInitialT, closeTo(11, 1e-9));
    expect(mlp.annealFinalT, closeTo(0.2, 1e-9));
    expect(mlp.annealCoolingRatio, closeTo(0.9, 1e-9));
    expect(mlp.annealItePerStep, 7);

    mlp.layerSizes = cv.Mat.fromList(1, 3, cv.MatType.CV_32SC1, <int>[4, 5, 3]);
    final sizes = mlp.layerSizes;
    expect([for (var i = 0; i < sizes.total; i++) sizes.atNum(i ~/ sizes.cols, i % sizes.cols)], [4, 5, 3]);
    expect(mlp.defaultName, 'opencv_ml_ann_mlp');
  });

  test('cv.ANN_MLP train and predict', () {
    final mlp = trainedMlp();
    expect(mlp.isTrained, true);
    expect(mlp.varCount, 2);
    expect(mlp.getWeights(1).isEmpty, false);
    final out = mlp.predict(queryPoints());
    expect(out.shape, [2, 2, 1]);
    expect(argmaxRows(out), [0, 1]);
  });

  test('cv.ANN_MLP save and load', () {
    final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/mlp.xml';
    final mlp = trainedMlp()..save(path);
    final expected = mlp.predict(queryPoints());

    for (final loaded in [cv.ANN_MLP.load(path), cv.ANN_MLP.loadFromString(File(path).readAsStringSync())]) {
      final out = loaded.predict(queryPoints());
      expect(out.at<double>(0, 0), closeTo(expected.at<double>(0, 0), 1e-5));
      expect(out.at<double>(1, 1), closeTo(expected.at<double>(1, 1), 1e-5));
    }
  });

  test('cv.ANN_MLP errors', () {
    final mlp = cv.ANN_MLP.create();
    expect(() => mlp.predict(queryPoints()), throwsA(isA<cv.CvException>()));
    expect(() => cv.ANN_MLP.load('/nonexistent/mlp.xml'), throwsA(isA<cv.CvException>()));
    expect(() => trainedMlp().save('/nonexistent/dir/mlp.xml'), throwsA(isA<cv.CvException>()));
    // the responses must have one column per output neuron
    mlp.layerSizes = cv.Mat.fromList(1, 3, cv.MatType.CV_32SC1, <int>[2, 6, 2]);
    final threeColumns = cv.Mat.zeros(10, 3, cv.MatType.CV_32FC1);
    expect(
      () => mlp.train(clusterSamples(), cv.ROW_SAMPLE, threeColumns),
      throwsA(isA<cv.CvException>()),
    );
  });
}
