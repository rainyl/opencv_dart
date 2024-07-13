import 'dart:io';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main(List<String> args) {
  // final img = cv.imread("test/images/face.jpg", flags: cv.IMREAD_COLOR);

  // final classifier = cv.CascadeClassifier.empty();
  // final s = classifier.load("test/data/haarcascade_frontalface_default.xml");
  // final rects = classifier.detectMultiScale(img);
  // print(rects);
  // rects.dispose();
  // classifier.dispose();
  // img.dispose();

  final vec = cv.VecKeyPoint.generate(
      100,
      (i) => cv.KeyPoint(
            i.toDouble(),
            i.toDouble(),
            i.toDouble(),
            i.toDouble(),
            i.toDouble(),
            i,
            i,
          ));
  vec.dispose();
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  print(img);
  final ka = cv.ORB.empty();
  final kp = ka.detect(img);
  print(kp);
  print("FINISHED");
}
