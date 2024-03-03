import 'dart:io';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  cv.registerErrorCallback();
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    final model = cv.Net.fromTorch("test/models/openface.nn4.small2.v1.t7");

    final blob = cv.blobFromImage(
      img,
      scalefactor: 1.0,
      size: (224, 224),
      mean: cv.Scalar.all(0),
      swapRB: false,
      crop: false,
    );

    model.setInput(blob);
    fi
}
