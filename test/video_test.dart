import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async{
  test('cv.VideoWriter.empty', () {
    final writer = cv.VideoWriter.empty();
    expect(writer.isOpened, equals(false));
    writer.release();
  });

  test('cv.VideoWriter.open', () {
    final writer = cv.VideoWriter.open("test/images/small.mp4", "mp4v", 60, (400, 300));
    writer.release();
  });

  test('cv.VideoCapture.empty', () {
    final vc = cv.VideoCapture.empty();
    expect(vc.isOpened, false);
    vc.release();
  });

  // test('cv.VideoCapture.create', () {
  //   final vc = cv.VideoCapture.empty();
  //   vc.setProp(cv.CAP_PROP_FOURCC, vc.toCodec("mp4v"));
  //   final success = vc.open("test/images/small.mp4");
  //   expect(success, true);
  //   expect(vc.isOpened, true);
  //   vc.release();
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
