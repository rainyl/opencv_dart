import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  // video
  test('cv.BackgroundSubtractorMOG2Async', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = cv.BackgroundSubtractorMOG2.empty();
    final dst = await bgSubtractor.applyAsync(img);
    expect(dst.isEmpty, false);

    final bgSub1 = cv.BackgroundSubtractorMOG2.create(history: 250, varThreshold: 8, detectShadows: false);
    final dst1 = await bgSub1.applyAsync(img);
    expect(dst1.isEmpty, false);

    bgSub1.dispose();
  });

  test('cv.BackgroundSubtractorKNNAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = cv.BackgroundSubtractorKNN.empty();
    final dst = await bgSubtractor.applyAsync(img);
    expect(dst.isEmpty, false);

    final bgSub1 = cv.BackgroundSubtractorKNN.create(history: 250, varThreshold: 8, detectShadows: false);
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

    expect((mapTranslation.rows, mapTranslation.cols), (translationGround.rows, translationGround.cols));
  });

  test('cv.TrackerMILAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final rect = cv.Rect(100, 150, 200, 241);
    final tracker = cv.TrackerMIL.create();
    await tracker.initAsync(img, rect);
    final (ok, _) = await tracker.updateAsync(img);
    expect(ok, true);

    rect.dispose();
    tracker.dispose();
  });

  test('cv.KalmanFilterAsync', () async {
    final kf = cv.KalmanFilter.create(2, 1, controlParams: 1);
    await kf.initAsync(2, 1, controlParams: 1);
    final measurement = cv.Mat.zeros(1, 1, cv.MatType.CV_32FC1);
    final prediction = await kf.predictAsync();
    expect(prediction.isEmpty, false);
    final statePos = await kf.correctAsync(measurement);
    expect(statePos.isEmpty, false);

    kf.dispose();
  });
}
