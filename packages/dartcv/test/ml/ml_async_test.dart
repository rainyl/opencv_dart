import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

void main() {
  test('cv.TrainData.loadFromCSVAsync', () async {
    final path = '${tempDir()}/data.csv';
    writeAsString(path, '1,2,0\n3,4,1\n5,6,0\n');
    final data = await cv.TrainDataAsync.loadFromCSVAsync(path, 0, varTypeSpec: 'ord[0-1]cat[2]');
    expect(data.nSamples, 3);
    expect(data.nVars, 2);
    await expectLater(
      cv.TrainDataAsync.loadFromCSVAsync('/nonexistent/dartcv.csv', 0),
      throwsA(isA<cv.CvException>()),
    );
  });

  test('the async ml calls take a timeout', () async {
    // Every other `*Async` module accepts `timeout:`; these used to be the exception, because their
    // helpers freed the out-parameter after `await` and a timeout would have freed it under the job.
    const generous = Duration(seconds: 60);
    final knn = cv.KNearest.create();
    expect(
      await knn.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesF32(), timeout: generous),
      true,
    );
    final (results, _, _) = await knn.findNearestAsync(queryPoints(), 3, timeout: generous);
    expect(labelsOf(results), [0, 1]);

    // A timeout abandons the wait, not the job: the block it was given is freed once the job reports.
    final em = cv.EM.create();
    try {
      await em.trainEMAsync(clusterSamples(), timeout: const Duration(microseconds: 1));
      // On the web the work runs inline, so a job this short can finish before the timer fires.
    } on cv.AsyncTimeoutException catch (e) {
      await e.completion;
    } on cv.CvException {
      // The job failed before the timer fired; the API still accepted the parameter.
    }
    cv.asyncDrain();
    expect(
      await cv.EM.create().trainEMAsync(clusterSamples(), timeout: generous),
      isA<(bool, cv.Mat, cv.Mat, cv.Mat)>(),
    );
  });

  test('cv.SVM async', () async {
    final svm = cv.SVM.create()..kernelType = cv.SVM.LINEAR;
    expect(await svm.trainAsync(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32()), true);
    final raw = await svm.predictAsync(queryPoints(), flags: cv.StatModel.RAW_OUTPUT);
    final rawSync = svm.predict(queryPoints(), flags: cv.StatModel.RAW_OUTPUT);
    expect(raw.at<double>(0, 0), closeTo(rawSync.at<double>(0, 0), 1e-6));
    expect(labelsOf(await svm.predictAsync(queryPoints())), [0, 1]);

    final (rho, alpha, svidx) = await svm.getDecisionFunctionAsync(0);
    final (rhoSync, alphaSync, _) = svm.getDecisionFunction(0);
    expect(rho, rhoSync);
    expect(alpha.total, alphaSync.total);
    expect(svidx.total, alphaSync.total);
    await expectLater(svm.getDecisionFunctionAsync(5), throwsA(isA<cv.CvException>()));

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
