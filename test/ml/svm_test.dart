import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.SVM', () {
    final model = cv.SVM.create();
    expect(model.getC(), closeTo(1.0, 1e-6));

    model.setC(2.0);
    expect(model.getC(), closeTo(2.0, 1e-6));

    // model.save("svm.xml");
  });
}
