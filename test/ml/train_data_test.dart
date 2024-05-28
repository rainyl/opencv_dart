import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.TrainData static methods', () {
    expect(cv.TrainData.missingValue(), greaterThan(0));
    final mat = cv.Mat.eye(3, 3, cv.MatType.CV_32FC1);
    final idx = cv.Mat.zeros(1, 2, cv.MatType.CV_32SC1);
    expect(cv.TrainData.getSubVector(mat, idx).shape, [2, 3, 1]);
    expect(cv.TrainData.getSubMatrix(mat, idx, cv.COL_SAMPLE).shape, [3, 2, 1]);
  });

  test('cv.TrainData', () {
    final data = cv.TrainData.loadFromCSV(
      "test/data/agaricus-lepiota.data",
      0,
      responseStartIdx: 0,
      responseEndIdx: 1,
      varTypeSpec: "cat[0-22]",
    );
    expect(data.getCatCount(0), 6);
    expect(data.getCatOfs().isEmpty, false);
    expect(data.getClassLabels().isEmpty, false);
    expect(data.getDefaultSubstValues().isEmpty, false);
    expect(data.getLayout(), cv.ROW_SAMPLE);
    expect(data.getMissing().isEmpty, false);
    expect(data.getNAllVars(), 22);
    expect(data.getNames().length, greaterThan(0));
    expect(data.getNormCatResponses().isEmpty, false);
    expect(data.getNSamples(), 8124);

    data.setTrainTestSplit(5410);
    expect(data.getNTestSamples(), 8124 - 5410);
    expect(data.getNTrainSamples(), 5410);

    data.setTrainTestSplitRatio(0.8);
    data.shuffleTrainTest();
    expect(data.getNTestSamples(), 8124 - (8124 * 0.8).toInt());
    expect(data.getNTrainSamples(), (8124 * 0.8).toInt());

    expect(data.getNVars(), 22);
    expect(data.getResponses().isEmpty, false);
    expect(data.getResponseType(), 1);
    // TODO: how to use?
    // expect(data.getSample(cv.Mat.zeros(1, 3, cv.MatType.CV_32SC1), 0), false);
    expect(data.getSamples().isEmpty, false);
    expect(data.getSampleWeights().isEmpty, false);
    expect(data.getTestNormCatResponses().isEmpty, false);
    expect(data.getTestResponses().isEmpty, false);
    expect(data.getTestSampleIdx().isEmpty, false);
    expect(data.getTestSamples().isEmpty, false);
    expect(data.getTestSampleWeights().isEmpty, false);
    expect(data.getTrainNormCatResponses().isEmpty, false);
    expect(data.getTrainResponses().isEmpty, false);
    expect(data.getTrainSampleIdx().isEmpty, false);
    expect(data.getTrainSamples().isEmpty, false);
    expect(data.getTrainSampleWeights().isEmpty, false);
    // TODO: how to use?
    // expect(data.getValues().isEmpty, false);
    expect(data.getVarIdx().isEmpty, true);
    expect(data.getVarSymbolFlags().isEmpty, false);
    expect(data.getVarType().isEmpty, false);
  });
}
