import 'package:dartcv/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  // videoio
  test('cv.VideoWriterAsync.emptyAsync', () async {
    final writer = await cv.VideoWriterAsync.emptyAsync();
    expect(writer.isOpened, equals(false));
    await writer.openAsync("test/images/small2.mp4", "mp4v", 60, (400, 300));
    await writer.releaseAsync();

    expect(await cv.VideoWriterAsync.fourccAsync("MJPG"), closeTo(1196444237, 1e-3));

    writer.dispose();
  });

  test('cv.VideoWriterAsync.openAsync', () async {
    final writer = await cv.VideoWriterAsync.fromFileAsync("test/images/small2.mp4", "mp4v", 60, (400, 300));
    final frame = cv.Mat.ones(400, 300, cv.MatType.CV_8UC3);
    await writer.writeAsync(frame);
    await writer.releaseAsync();
  });

  test('cv.VideoCaptureAsync.emptyAsync', () async {
    final vc = await cv.VideoCaptureAsync.emptyAsync();
    expect(vc.isOpened, false);
    final success = await vc.openAsync("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    expect(success, true);
    await vc.releaseAsync();

    vc.dispose();
  });

  test('cv.VideoCaptureAsync.fromFileAsync', () async {
    final vc = await cv.VideoCaptureAsync.fromFileAsync("test/images/small.mp4", apiPreference: cv.CAP_ANY);
    final (success, frame) = await vc.readAsync();
    expect(success, true);
    expect(frame.isEmpty, false);
    expect(vc.codec, "h264");

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
