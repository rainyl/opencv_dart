import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

void main() {
  test('cv.TrainData.loadFromCSVAsync', () async {
    final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final csv = File('${dir.path}/data.csv')..writeAsStringSync('1,2,0\n3,4,1\n5,6,0\n');
    final data = await cv.TrainDataAsync.loadFromCSVAsync(csv.path, 0, varTypeSpec: 'ord[0-1]cat[2]');
    expect(data.nSamples, 3);
    expect(data.nVars, 2);
    await expectLater(
      cv.TrainDataAsync.loadFromCSVAsync('/nonexistent/dartcv.csv', 0),
      throwsA(isA<cv.CvException>()),
    );
  });

  test('cv.SVM async', () async {
    final svm = cv.SVM.create()..kernelType = cv.SVM.LINEAR;
    expect(await svm.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
    final raw = await svm.predictAsync(queryPoints(), flags: cv.StatModel.RAW_OUTPUT);
    final rawSync = svm.predict(queryPoints(), flags: cv.StatModel.RAW_OUTPUT);
    expect(raw.at<double>(0, 0), closeTo(rawSync.at<double>(0, 0), 1e-6));
    expect(labelsOf(await svm.predictAsync(queryPoints())), [0, 1]);

    final data = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32())
      ..setTrainTestSplitRatio(0.6);
    final other = cv.SVM.create()..kernelType = cv.SVM.LINEAR;
    expect(await other.trainWithDataAsync(data), true);
    final (err, _) = await other.calcErrorAsync(data, true);
    expect(err, other.calcError(data, true).$1);
    final full = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32());
    expect(await other.trainAutoAsync(full, kFold: 2, balanced: true), true);

    await expectLater(cv.SVM.create().predictAsync(queryPoints()), throwsA(isA<cv.CvException>()));
  });

  test('cv.ANN_MLP async', () async {
    final mlp = cv.ANN_MLP.create()
      ..layerSizes = cv.Mat.fromList(1, 3, cv.MatType.CV_32SC1, <int>[2, 6, 1])
      ..setActivationFunction(cv.ANN_MLP.SIGMOID_SYM);
    expect(await mlp.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32()), true);
    final out = await mlp.predictAsync(queryPoints());
    expect(out.at<double>(0, 0), closeTo(mlp.predict(queryPoints()).at<double>(0, 0), 1e-6));
  });

  test('cv.KNearest async', () async {
    final knn = cv.KNearest.create();
    expect(await knn.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32()), true);
    final (results, neighbors, dist) = await knn.findNearestAsync(queryPoints(), 3);
    expect(labelsOf(results), [0, 1]);
    expect(neighbors.shape, [2, 3, 1]);
    expect(dist.shape, [2, 3, 1]);
    knn.defaultK = 3;
    expect(labelsOf(await knn.predictAsync(queryPoints())), [0, 1]);
  });
}
