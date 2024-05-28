import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.ANN_MLP', () {
    final model = cv.ANN_MLP.create();
    expect(model.getTrainMethod(), cv.ANN_MLP.TRAIN_METHODS_RPROP);
    model.setTrainMethod(cv.ANN_MLP.TRAIN_METHODS_BACKPROP);
    expect(model.getTrainMethod(), cv.ANN_MLP.TRAIN_METHODS_BACKPROP);
  });
}
