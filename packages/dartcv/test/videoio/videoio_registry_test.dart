import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.getBackends', () {
    final backends = cv.VideoIORegistry.getBackends();
    print(backends);
    expect(backends, isA<List>());
  });

  test('cv.getCameraBackends', () {
    final backends = cv.VideoIORegistry.getCameraBackends();
    print(backends);
    expect(backends, isA<List>());
  });

  test('cv.getStreamBackends', () {
    final backends = cv.VideoIORegistry.getStreamBackends();
    print(backends);
    expect(backends, isA<List>());
  });

  test('cv.getStreamBufferedBackends', () {
    final backends = cv.VideoIORegistry.getStreamBufferedBackends();
    print(backends);
    expect(backends, isA<List>());
  });

  test('cv.getWriterBackends', () {
    final backends = cv.VideoIORegistry.getWriterBackends();
    print(backends);
    expect(backends, isA<List>());
  });

  test('cv.hasBackend', () {
    final hasBackend = cv.VideoIORegistry.hasBackend(cv.VideoCaptureAPIs.CAP_MSMF);
    expect(hasBackend, isA<bool>());
  });

  test('cv.isBackendBuiltIn', () {
    final isBuiltIn = cv.VideoIORegistry.isBackendBuiltIn(cv.VideoCaptureAPIs.CAP_MSMF);
    expect(isBuiltIn, isA<bool>());
  });

  test('cv.enumerateCameras', () {
    final cameras = cv.VideoIORegistry.enumerateCameras(cv.VideoCaptureAPIs.CAP_MSMF);
    print(cameras);
    expect(cameras, isA<List>());
  });
}
