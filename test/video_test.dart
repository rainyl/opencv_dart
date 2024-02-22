import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async{
  test('cv.VideoWriter.empty', () {
    final writer = cv.VideoWriter.empty();
    expect(writer.isOpened, equals(false));
  });

  test('cv.VideoWriter.open', () {
    final writer = cv.VideoWriter.open("test/images/small.mp4", "MJPG", 60, (width: 400, height: 300));
  });

  test('cv.VideoCapture.empty', () {
    final vc = cv.VideoCapture.empty();
    expect(vc.isOpened, false);
  });

  // test('cv.VideoCapture.create', () {
  //   final vc = cv.VideoCapture.create(r"C:\DEV\flutter\opencv_dart\test\images\small.mp4");
  //   expect(vc.isOpened, true);
  // });

  // test('cv.VideoCapture.fromFile', () {
  //   final vc = cv.VideoCapture.empty();
  //   final success = vc.open("test/images/small.mp4", apiPreference: cv.CAP_ANY);
  //   expect(success, true);
  //   expect(vc.isOpened, true);
  //   final frame = cv.Mat.empty();
  //   final success1 = vc.read(frame);
  //   expect(success1, true);
  //   cv.imwrite("cv.VideoCapture.fromFile.png", frame);
  // });

  test('cv.VideoCapture.fromDevice', () {
    final vc = cv.VideoCapture.fromDevice(0);
    expect(vc.isOpened, true);
    final frame = cv.Mat.empty();
    final res = vc.read(frame);
    expect(res, true);
    // cv.imwrite("cv.VideoCapture.fromDevice_1.png", frame);
  });
}
