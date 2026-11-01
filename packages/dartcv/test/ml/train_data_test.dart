import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

import 'ml_test_data.dart';

void main() {
  test('cv.TrainData.create', () {
    final data = cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, clusterResponsesI32());
    expect(data.layout, cv.ROW_SAMPLE);
    expect(data.nSamples, 10);
    expect(data.nVars, 2);
    expect(data.nAllVars, 2);
    expect(data.samples.shape, [10, 2, 1]);
    expect(data.responses.shape, [10, 1, 1]);
    expect(data.classLabels.isEmpty, false);

    data.setTrainTestSplitRatio(0.8, shuffle: false);
    expect(data.nTrainSamples, 8);
    expect(data.nTestSamples, 2);
    expect(data.getTrainSamples().rows, 8);
    expect(data.testSamples.rows, 2);
    expect(data.trainSampleIdx.total, 8);
    expect(data.testSampleIdx.total, 2);

    data.setTrainTestSplit(5, shuffle: false);
    expect(data.nTrainSamples, 5);
    data.shuffleTrainTest();
    expect(data.nTrainSamples, 5);
    data.dispose();
  });

  test('cv.TrainData.create with sample weights', () {
    final weights = cv.Mat.fromList(10, 1, cv.MatType.CV_32FC1, List.filled(10, 2.0));
    final data = cv.TrainData.create(
      clusterSamples(),
      cv.ROW_SAMPLE,
      clusterResponsesI32(),
      sampleWeights: weights,
    );
    expect(data.sampleWeights.at<double>(0, 0), 2.0);
  });

  test('cv.TrainData.loadFromCSV', () {
    final dir = Directory.systemTemp.createTempSync('dartcv_ml_test_');
    addTearDown(() => dir.deleteSync(recursive: true));
    final csv = File('${dir.path}/data.csv');
    // two ordered features, a categorical feature with 3 values and a categorical response
    const colors = ['red', 'green', 'blue'];
    final rows = [
      for (var i = 0; i < 10; i++)
        '${clusterPoints[i * 2]},${clusterPoints[i * 2 + 1]},${colors[i % 3]},${clusterLabels[i] == 0 ? 'a' : 'b'}',
    ];
    csv.writeAsStringSync('x,y,color,label\n${rows.join('\n')}\n');

    final data = cv.TrainData.loadFromCSV(
      csv.path,
      1,
      responseStartIdx: 3,
      responseEndIdx: 4,
      varTypeSpec: 'ord[0-1]cat[2-3]',
    );
    expect(data.nSamples, 10);
    expect(data.nVars, 3);
    expect(data.responseType, cv.VAR_CATEGORICAL);
    expect(data.getCatCount(2), 3);
    expect(() => data.getCatCount(99), throwsA(isA<cv.CvException>()));
    expect(data.classLabels.total, 2);
    expect(data.varType.total, 4);
    // the symbolic values seen in categorical columns
    expect(data.names, containsAll(['red', 'green', 'blue', 'a', 'b']));
  });

  test('cv.TrainData.loadFromCSV rejects a missing file and bad characters', () {
    expect(() => cv.TrainData.loadFromCSV('/nonexistent/dartcv.csv', 0), throwsA(isA<cv.CvException>()));
    expect(() => cv.TrainData.loadFromCSV('x.csv', 0, delimiter: ';;'), throwsArgumentError);
  });

  test('cv.TrainData statics', () {
    expect(cv.TrainData.missingValue, isNonZero);
    final vec = cv.Mat.fromList(1, 5, cv.MatType.CV_32FC1, <double>[0, 1, 2, 3, 4]);
    final idx = cv.Mat.fromList(1, 2, cv.MatType.CV_32SC1, <int>[1, 3]);
    final sub = cv.TrainData.getSubVector(vec, idx);
    expect(sub.total, 2);
    expect(sub.at<double>(0, 0), 1);
    expect(sub.at<double>(0, 1), 3);

    final m = cv.Mat.eye(3, 3, cv.MatType.CV_32FC1);
    final rowIdx = cv.Mat.fromList(1, 2, cv.MatType.CV_32SC1, <int>[0, 2]);
    expect(cv.TrainData.getSubMatrix(m, rowIdx, cv.ROW_SAMPLE).shape, [2, 3, 1]);
    expect(cv.TrainData.getSubMatrix(m, rowIdx, cv.COL_SAMPLE).shape, [3, 2, 1]);
  });

  test('cv.TrainData.create rejects mismatched responses', () {
    final responses = cv.Mat.fromList(3, 1, cv.MatType.CV_32SC1, <int>[0, 1, 0]);
    expect(
      () => cv.TrainData.create(clusterSamples(), cv.ROW_SAMPLE, responses),
      throwsA(isA<cv.CvException>()),
    );
  });
}
