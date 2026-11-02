// Digit recognition with the ml module.
//
// Renders the digits 0-9 with OpenCV's Hershey fonts at several scales, offsets and rotations,
// trains KNearest and SVM classifiers on the raw pixels, and evaluates them on renderings that
// were not used for training. No dataset download is needed.
//
// Run from example/dart_cli (the `ml` module is enabled in its pubspec.yaml):
//   dart run bin/ml_digits.dart

import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;

/// Side of the square digit images fed to the classifiers.
const side = 20;

const fonts = [
  cv.FONT_HERSHEY_SIMPLEX,
  cv.FONT_HERSHEY_DUPLEX,
  cv.FONT_HERSHEY_COMPLEX,
  cv.FONT_HERSHEY_TRIPLEX,
  cv.FONT_HERSHEY_PLAIN,
];

/// Renders [digit] on a 28x28 canvas, rotated by [angle] degrees and shifted by ([dx], [dy]),
/// then shrinks it to [side] x [side] and returns its pixels scaled to 0..1.
List<double> renderDigit(int digit, int font, double angle, int dx, int dy) {
  final canvas = cv.Mat.zeros(28, 28, cv.MatType.CV_8UC1);
  final scale = font == cv.FONT_HERSHEY_PLAIN ? 1.6 : 0.8;
  cv.putText(canvas, '$digit', cv.Point(7 + dx, 21 + dy), font, scale, cv.Scalar.all(255), thickness: 2);
  final rotation = cv.getRotationMatrix2D(cv.Point2f(14, 14), angle, 1);
  final rotated = cv.warpAffine(canvas, rotation, (28, 28));
  final small = cv.resize(rotated, (side, side), interpolation: cv.INTER_AREA);
  return [for (final v in small.data) v / 255.0];
}

/// A dataset of every digit rendered with each font and each (angle, dx, dy) variation.
(cv.Mat samples, cv.Mat responses) makeDataset(List<(double, int, int)> variations) {
  final pixels = <double>[];
  final labels = <int>[];
  for (final font in fonts) {
    for (final (angle, dx, dy) in variations) {
      for (var digit = 0; digit < 10; digit++) {
        pixels.addAll(renderDigit(digit, font, angle, dx, dy));
        labels.add(digit);
      }
    }
  }
  final samples = cv.Mat.fromList(labels.length, side * side, cv.MatType.CV_32FC1, pixels);
  final responses = cv.Mat.fromList(labels.length, 1, cv.MatType.CV_32SC1, labels);
  return (samples, responses);
}

/// Percentage of rows of [predicted] equal to [expected].
double accuracy(cv.Mat predicted, cv.Mat expected) {
  var correct = 0;
  for (var i = 0; i < expected.rows; i++) {
    if (predicted.atNum(i, 0).round() == expected.atNum(i, 0)) correct++;
  }
  return 100 * correct / expected.rows;
}

void main() {
  // train on small rotations and shifts, test on the in-between ones
  final train = [
    for (final angle in [-10.0, 0.0, 10.0])
      for (final (dx, dy) in [(0, 0), (-2, 0), (2, 0), (0, -2), (0, 2)]) (angle, dx, dy),
  ];
  final test = [
    for (final angle in [-5.0, 5.0])
      for (final (dx, dy) in [(-1, 1), (1, -1)]) (angle, dx, dy),
  ];
  final (trainSamples, trainLabels) = makeDataset(train);
  final (testSamples, testLabels) = makeDataset(test);
  print('train: ${trainSamples.rows} digits, test: ${testSamples.rows} digits, ${side * side} pixels each');

  // KNearest needs float responses
  final knn = cv.KNearest.create()..defaultK = 3;
  knn.train(trainSamples, cv.ROW_SAMPLE, trainLabels.convertTo(cv.MatType.CV_32FC1));
  final (knnPredicted, _, _) = knn.findNearest(testSamples, 3);
  print('KNearest (k=3) accuracy: ${accuracy(knnPredicted, testLabels).toStringAsFixed(1)}%');

  final svm = cv.SVM.create()
    ..type = cv.SVM.C_SVC
    ..kernelType = cv.SVM.RBF
    ..gamma = 0.05
    ..C = 10;
  svm.train(trainSamples, cv.ROW_SAMPLE, trainLabels);
  final svmPredicted = svm.predict(testSamples);
  print('SVM (RBF) accuracy: ${accuracy(svmPredicted, testLabels).toStringAsFixed(1)}%');

  // a trained model is saved once and loaded later, e.g. from a Flutter asset with loadFromString
  final path = '${Directory.systemTemp.path}/dartcv_digits_svm.yml';
  svm.save(path);
  final loaded = cv.SVM.load(path);
  final seven = cv.Mat.fromList(1, side * side, cv.MatType.CV_32FC1, renderDigit(7, fonts.first, 3, 1, 0));
  print('loaded SVM reads a rendered 7 as: ${loaded.predict(seven).atNum(0, 0).round()}');
  print('model saved to $path (${(File(path).lengthSync() / 1024).toStringAsFixed(0)} KiB)');
}
