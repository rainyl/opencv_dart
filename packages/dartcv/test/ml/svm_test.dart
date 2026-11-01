import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

cv.SVM trainedSvm() {
  final svm = cv.SVM.create()
    ..type = cv.SVM.C_SVC
    ..kernelType = cv.SVM.LINEAR;
  expect(svm.train(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
  return svm;
}

void main() {
  test('cv.SVM parameters', () {
    final svm = cv.SVM.create();
    expect(svm.isTrained, false);
    expect(svm.defaultName, 'opencv_ml_svm');

    svm
      ..type = cv.SVM.NU_SVC
      ..kernelType = cv.SVM.RBF
      ..gamma = 0.5
      ..coef0 = 0.25
      ..degree = 3
      ..C = 2
      ..nu = 0.3
      ..p = 0.1;
    expect(svm.type, cv.SVM.NU_SVC);
    expect(svm.kernelType, cv.SVM.RBF);
    expect(svm.gamma, closeTo(0.5, 1e-9));
    expect(svm.coef0, closeTo(0.25, 1e-9));
    expect(svm.degree, closeTo(3, 1e-9));
    expect(svm.C, closeTo(2, 1e-9));
    expect(svm.nu, closeTo(0.3, 1e-9));
    expect(svm.p, closeTo(0.1, 1e-9));

    svm.termCriteria = cv.TermCriteria(cv.TERM_COUNT, 50, 0.01);
    final tc = svm.termCriteria;
    expect(tc.type, cv.TERM_COUNT);
    expect(tc.maxCount, 50);
    expect(tc.eps, closeTo(0.01, 1e-9));

    svm.classWeights = cv.Mat.fromList(1, 2, cv.MatType.CV_64FC1, <double>[1, 3]);
    expect(svm.classWeights.total, 2);
    svm.dispose();
  });

  test('cv.SVM train and predict', () {
    final svm = trainedSvm();
    expect(svm.isTrained, true);
    expect(svm.isClassifier, true);
    expect(svm.varCount, 2);
    expect(svm.supportVectors.isEmpty, false);
    expect(svm.uncompressedSupportVectors.isEmpty, false);

    expect(labelsOf(svm.predict(queryPoints())), [0, 1]);

    final (rho, alpha, svidx) = svm.getDecisionFunction(0);
    expect(rho.isFinite, true);
    expect(alpha.isEmpty, false);
    expect(svidx.isEmpty, false);

    // the decision function has opposite signs on the two sides of the margin
    final raw = svm.predict(queryPoints(), flags: cv.StatModel.RAW_OUTPUT);
    expect(raw.at<double>(0, 0) * raw.at<double>(1, 0), lessThan(0));
  });

  test('cv.SVM trainWithData, calcError and trainAuto', () {
    final data = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32())
      ..setTrainTestSplitRatio(0.6);
    final svm = cv.SVM.create()..kernelType = cv.SVM.LINEAR;
    expect(svm.trainWithData(data), true);
    final (err, resp) = svm.calcError(data, true);
    expect(err, 0);
    expect(resp.rows, data.nTestSamples);

    final auto = cv.SVM.create()..kernelType = cv.SVM.LINEAR;
    expect(auto.trainAuto(data, kFold: 2), true);
    expect(labelsOf(auto.predict(queryPoints())), [0, 1]);

    final grid = cv.SVM.getDefaultGrid(cv.SVM.PARAM_C);
    expect(grid.minVal, lessThan(grid.maxVal));
    expect(grid.logStep, greaterThan(1));
    expect(
      auto.trainAuto(data, kFold: 2, Cgrid: const cv.ParamGrid(0.1, 10, 10)),
      true,
    );
  });

  test('cv.SVM save, load and loadFromString', () {
    final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final path = '${dir.path}/svm.yml';
    final svm = trainedSvm()..save(path);

    final loaded = cv.SVM.load(path);
    expect(loaded.isTrained, true);
    expect(labelsOf(loaded.predict(queryPoints())), [0, 1]);

    final fromString = cv.SVM.loadFromString(File(path).readAsStringSync());
    const flags = cv.StatModel.RAW_OUTPUT;
    expect(
      fromString.predict(queryPoints(), flags: flags).at<double>(1, 0),
      closeTo(svm.predict(queryPoints(), flags: flags).at<double>(1, 0), 1e-6),
    );
  });

  test('cv.SVM errors', () {
    final svm = cv.SVM.create();
    expect(() => svm.predict(queryPoints()), throwsA(isA<cv.CvException>()));
    expect(() => cv.SVM.load('/nonexistent/svm.yml'), throwsA(isA<cv.CvException>()));
    expect(() => cv.SVM.loadFromString('not a model'), throwsA(isA<cv.CvException>()));
    expect(() => trainedSvm().save('/nonexistent/dir/svm.yml'), throwsA(isA<cv.CvException>()));

    final samples64 = cv.Mat.fromList(10, 2, cv.MatType.CV_64FC1, clusterPoints);
    expect(
      () => svm.train(samples64, cv.ROW_SAMPLE, clusterResponsesI32()),
      throwsA(isA<cv.CvException>()),
    );
  });
}
