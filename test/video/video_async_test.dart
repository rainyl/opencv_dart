import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

void main() async {
  // video
  test('cv.BackgroundSubtractorMOG2Async', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = await cv.BackgroundSubtractorMOG2Async.emptyAsync();
    final dst = await bgSubtractor.applyAsync(img);
    expect(dst.isEmpty, false);

    final bgSub1 = await cv.BackgroundSubtractorMOG2Async.createAsync(
      history: 250,
      varThreshold: 8,
      detectShadows: false,
    );
    final dst1 = await bgSub1.applyAsync(img);
    expect(dst1.isEmpty, false);

    bgSub1.dispose();
  });

  test('cv.BackgroundSubtractorKNNAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = await cv.BackgroundSubtractorKNNAsync.emptyAsync();
    final dst = await bgSubtractor.applyAsync(img);
    expect(dst.isEmpty, false);

    final bgSub1 = await cv.BackgroundSubtractorKNNAsync.createAsync(
      history: 250,
      varThreshold: 8,
      detectShadows: false,
    );
    final dst1 = await bgSub1.applyAsync(img);
    expect(dst1.isEmpty, false);

    bgSubtractor.dispose();
  });

  test('cv.calcOpticalFlowFarnebackAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final next = img.clone();
    final flow = cv.Mat.empty();
    await cv.calcOpticalFlowFarnebackAsync(img, next, flow, 0.4, 1, 12, 2, 8, 1.2, 0);
    expect(flow.isEmpty, false);
    expect((flow.rows, flow.cols), (img.rows, img.cols));
  });

  test('cv.calcOpticalFlowPyrLKAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final img2 = img.clone();
    final corners = await cv.goodFeaturesToTrackAsync(img, 10, 0.01, 10);
    const tc = (cv.TERM_COUNT + cv.TERM_EPS, 40, 0.03);
    await cv.cornerSubPixAsync(img, corners, (5, 5), (-1, -1), tc);
    final (next, status, error) = await cv.calcOpticalFlowPyrLKAsync(img, img2, corners, cv.VecPoint2f());
    expect(next.isNotEmpty, true);
    expect(status.isEmpty, false);
    expect(error.isEmpty, false);
  });

  test('cv.findTransformECCAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final testImg = await cv.resizeAsync(img, (216, 216));
    final translationGround = cv.Mat.eye(2, 3, cv.MatType.CV_32FC1);
    translationGround.set<double>(0, 2, 11.4159);
    translationGround.set<double>(1, 2, 17.1828);

    final wrappedImage = await cv.warpAffineAsync(
      testImg,
      translationGround,
      (200, 200),
      flags: cv.INTER_LINEAR + cv.WARP_INVERSE_MAP,
      borderMode: cv.BORDER_CONSTANT,
      borderValue: cv.Scalar(),
    );

    final mapTranslation = cv.Mat.eye(2, 3, cv.MatType.CV_32FC1);
    const criteria = (cv.TERM_COUNT + cv.TERM_EPS, 50, 0.01);
    final inputMask = cv.Mat.empty();
    await cv.findTransformECCAsync(
      wrappedImage,
      testImg,
      mapTranslation,
      cv.MOTION_TRANSLATION,
      criteria,
      inputMask,
      5,
    );

    expect(
      (mapTranslation.rows, mapTranslation.cols),
      (translationGround.rows, translationGround.cols),
    );
  });

  test('cv.TrackerMILAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final rect = cv.Rect(100, 150, 200, 241);
    final tracker = await cv.TrackerMILAsync.createAsync();
    await tracker.initAsync(img, rect);
    final (ok, _) = await tracker.updateAsync(img);
    expect(ok, true);

    rect.dispose();
    tracker.dispose();
  });

  test('cv.KalmanFilterAsync', () async {
    final kf = await cv.KalmanFilterAsync.createAsync(2, 1, controlParams: 1);
    await kf.initAsync(2, 1, controlParams: 1);
    final measurement = cv.Mat.zeros(1, 1, cv.MatType.CV_32FC1);
    final prediction = await kf.predictAsync();
    expect(prediction.isEmpty, false);
    final statePos = await kf.correctAsync(measurement);
    expect(statePos.isEmpty, false);

    // getters and setters
    final statePost = await kf.getStatePost();
    expect(statePost.isEmpty, false);
    await kf.setStatePost(statePost);

    final statePre = await kf.getStatePre();
    expect(statePre.isEmpty, false);
    await kf.setStatePre(statePre);

    final transitionMatrix = await kf.getTransitionMatrix();
    expect(transitionMatrix.isEmpty, false);
    await kf.setTransitionMatrix(transitionMatrix);

    final temp1 = await kf.getTemp1();
    expect(temp1.isEmpty, false);
    final temp2 = await kf.getTemp2();
    expect(temp2.isEmpty, false);
    final temp3 = await kf.getTemp3();
    expect(temp3.isEmpty, false);
    final temp4 = await kf.getTemp4();
    expect(temp4.isEmpty, false);
    final temp5 = await kf.getTemp5();
    expect(temp5.isEmpty, false);

    final processNoiseCov = await kf.getProcessNoiseCov();
    expect(processNoiseCov.isEmpty, false);
    await kf.setProcessNoiseCov(processNoiseCov);

    final measurementNoiseCov = await kf.getMeasurementNoiseCov();
    expect(measurementNoiseCov.isEmpty, false);
    await kf.setMeasurementNoiseCov(measurementNoiseCov);

    final measurementMatrix = await kf.getMeasurementMatrix();
    expect(measurementMatrix.isEmpty, false);
    await kf.setMeasurementMatrix(measurementMatrix);

    final gain = await kf.getGain();
    expect(gain.isEmpty, false);
    await kf.setGain(gain);

    final errorCovPost = await kf.getErrorCovPost();
    expect(errorCovPost.isEmpty, false);
    await kf.setErrorCovPost(errorCovPost);

    final errorCovPre = await kf.getErrorCovPre();
    expect(errorCovPre.isEmpty, false);
    await kf.setErrorCovPre(errorCovPre);

    final controlMatrix = await kf.getControlMatrix();
    expect(controlMatrix.isEmpty, false);
    await kf.setControlMatrix(controlMatrix);

    kf.dispose();
  });

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
