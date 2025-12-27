import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  // videoio
  test('cv.VideoWriterAsync.empty', () async {
    final writer = cv.VideoWriter.empty();
    expect(writer.isOpened, equals(false));
    await writer.openAsync("test/images/small2.mp4", "mp4v", 60, (400, 300));
    writer.release();

    expect(cv.VideoWriter.fourcc("MJPG"), closeTo(1196444237, 1e-3));

    writer.dispose();
  });

  test('cv.VideoWriterAsync.openAsync', () async {
    final writer = await cv.VideoWriterAsync.fromFileAsync(
      "test/images/small2.avi",
      "MJPG",
      60,
      (
        400,
        300,
      ),
      apiPreference: cv.CAP_ANY,
    );
    final frame = cv.Mat.ones(300, 400, cv.MatType.CV_8UC3);
    await writer.writeAsync(frame);
    writer.release();

    final capture = await cv.VideoCaptureAsync.fromFileAsync(
      "test/images/small2.avi",
      apiPreference: cv.CAP_ANY,
    );
    expect(capture.isOpened, true);
    final (success, frame1) = await capture.readAsync();
    expect(success, true);
    expect(frame1.isEmpty, false);
    expect(frame1.shape, frame.shape);
  });

  test('cv.VideoCaptureAsync.empty', () async {
    final vc = cv.VideoCapture.empty();
    expect(vc.isOpened, false);
    final success = await vc.openAsync("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    expect(success, true);
    vc.release();

    vc.dispose();
  });

  test('cv.VideoCaptureAsync.fromFileAsync', () async {
    final vc = await cv.VideoCaptureAsync.fromFileAsync("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    final (success, frame) = await vc.readAsync();
    expect(success, true);
    expect(frame.isEmpty, false);
    expect(vc.codec, isA<String>());

    await vc.grabAsync();

    expect(cv.VideoCapture.toCodec("h264"), closeTo(875967080, 1e-3));
    // cv.imwrite("cv.VideoCapture.fromFile.png", frame);
  });

  // Disable for github
  test('cv.VideoCaptureAsync.fromDeviceAsync', skip: true, () async {
    final vc = await cv.VideoCaptureAsync.fromDeviceAsync(0);
    expect(vc.isOpened, true);
    final (res, frame) = await vc.readAsync();
    expect(res, true);
    expect(frame.isEmpty, false);
    // cv.imwrite("cv.VideoCapture.fromDevice_1.png", frame);
  });
}
