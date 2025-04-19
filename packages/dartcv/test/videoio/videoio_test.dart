import 'dart:io';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

final apiPreference = Platform.isMacOS ? cv.CAP_AVFOUNDATION : cv.CAP_FFMPEG;

void main() async {
  // videoio
  test('cv.VideoWriter.empty', () {
    final writer = cv.VideoWriter.empty();
    expect(writer.isOpened, equals(false));
    expect(cv.VideoWriter.fourcc("MJPG"), closeTo(1196444237, 1e-3));
    writer.open("test/images/small2.avi", "mp4v", 60, (400, 300));
    writer.open("test/images/small2.mp4", "mp4v", 60, (400, 300), apiPreference: cv.CAP_FFMPEG);
    writer.release();

    writer.dispose();
  });

  test('cv.VideoWriter.fromFile', () {
    final writer = cv.VideoWriter.fromFile(
        "test/images/small2.mp4",
        "mp4v",
        60,
        (
          400,
          300,
        ),
        apiPreference: cv.CAP_ANY);
    final frame = cv.Mat.ones(400, 300, cv.MatType.CV_8UC3);
    writer.write(frame);
    writer.release();
    final writer1 = cv.VideoWriter.fromFile(
        "test/images/small2.mp4",
        "mp4v",
        60,
        (
          400,
          300,
        ),
        apiPreference: cv.CAP_ANY);
    expect(writer1.isOpened, true);
  });

  test('cv.VideoCapture.empty', () {
    final vc = cv.VideoCapture.empty();
    expect(vc.isOpened, false);
    final success = vc.open("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    expect(success, true);
    vc.release();

    vc.dispose();
  });

  test('cv.VideoCapture.fromFile', () {
    final vc = cv.VideoCapture.fromFile("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    final (success, frame) = vc.read();
    expect(success, true);
    expect(frame.isEmpty, false);

    vc.grab();

    expect(vc.getBackendName(), isNotEmpty);

    expect(vc.codec, "h264");

    expect(cv.VideoCapture.toCodec("h264"), closeTo(875967080, 1e-3));
    // cv.imwrite("cv.VideoCapture.fromFile.png", frame);
  });

  // Disable for github
  test('cv.VideoCapture.fromDevice', skip: true, () {
    final vc = cv.VideoCapture.fromDevice(0);
    expect(vc.isOpened, true);
    final (res, frame) = vc.read();
    expect(res, true);
    expect(frame.isEmpty, false);
    // cv.imwrite("cv.VideoCapture.fromDevice_1.png", frame);
  });
}
