import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  // video
  test('cv.BackgroundSubtractorMOG2', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = cv.BackgroundSubtractorMOG2.empty();
    final dst = bgSubtractor.apply(img);
    expect(dst.isEmpty, false);

    final bgSub1 = cv.BackgroundSubtractorMOG2.create(history: 250, varThreshold: 8, detectShadows: false);
    final dst1 = bgSub1.apply(img);
    expect(dst1.isEmpty, false);

    bgSub1.dispose();
  });

  test('cv.BackgroundSubtractorKNN', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final bgSubtractor = cv.BackgroundSubtractorKNN.empty();
    final dst = bgSubtractor.apply(img);
    expect(dst.isEmpty, false);

    final bgSub1 = cv.BackgroundSubtractorKNN.create(history: 250, varThreshold: 8, detectShadows: false);
    final dst1 = bgSub1.apply(img);
    expect(dst1.isEmpty, false);

    bgSubtractor.dispose();
  });

  test('cv.calcOpticalFlowFarneback', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final next = img.clone();
    final flow = cv.Mat.empty();
    cv.calcOpticalFlowFarneback(img, next, flow, 0.4, 1, 12, 2, 8, 1.2, 0);
    expect(flow.isEmpty, false);
    expect((flow.rows, flow.cols), (img.rows, img.cols));
  });

  test('cv.calcOpticalFlowPyrLK', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final img2 = img.clone();
    final corners = cv.goodFeaturesToTrack(img, 10, 0.01, 10);
    const tc = (cv.TERM_COUNT + cv.TERM_EPS, 40, 0.03);
    cv.cornerSubPix(img, corners, (5, 5), (-1, -1), tc);
    final (next, status, error) = cv.calcOpticalFlowPyrLK(img, img2, corners, cv.VecPoint2f());
    expect(next.isNotEmpty, true);
    expect(status?.isEmpty, false);
    expect(error?.isEmpty, false);
  });

  test('cv.findTransformECC', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final testImg = cv.resize(img, (216, 216));
    final translationGround = cv.Mat.eye(2, 3, cv.MatType.CV_32FC1);
    translationGround.set<double>(0, 2, 11.4159);
    translationGround.set<double>(1, 2, 17.1828);

    final wrappedImage = cv.warpAffine(
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
    cv.findTransformECC(wrappedImage, testImg, mapTranslation, cv.MOTION_TRANSLATION, criteria, inputMask, 5);

    expect((mapTranslation.rows, mapTranslation.cols), (translationGround.rows, translationGround.cols));
  });

  test('cv.TrackerMIL', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final rect = cv.Rect(100, 150, 200, 241);
    final tracker = cv.TrackerMIL.create();
    tracker.init(img, rect);
    final (ok, _) = tracker.update(img);
    expect(ok, true);

    rect.dispose();
    tracker.dispose();
  });

  test('cv.KalmanFilter', () {
    final kf = cv.KalmanFilter.create(2, 1, controlParams: 1);
    kf.init(2, 1, controlParams: 1);
    final measurement = cv.Mat.zeros(1, 1, cv.MatType.CV_32FC1);
    final prediction = kf.predict();
    expect(prediction.isEmpty, false);
    final statePos = kf.correct(measurement);
    expect(statePos.isEmpty, false);

    // getters and setters
    final statePost = kf.statePost;
    expect(statePost.isEmpty, false);
    kf.statePost = statePost;

    final statePre = kf.statePre;
    expect(statePre.isEmpty, false);
    kf.statePre = statePre;

    final transitionMatrix = kf.transitionMatrix;
    expect(transitionMatrix.isEmpty, false);
    kf.transitionMatrix = transitionMatrix;

    final temp1 = kf.temp1;
    expect(temp1.isEmpty, false);
    final temp2 = kf.temp2;
    expect(temp2.isEmpty, false);
    final temp3 = kf.temp3;
    expect(temp3.isEmpty, false);
    final temp4 = kf.temp4;
    expect(temp4.isEmpty, false);
    final temp5 = kf.temp5;
    expect(temp5.isEmpty, false);

    final processNoiseCov = kf.processNoiseCov;
    expect(processNoiseCov.isEmpty, false);
    kf.processNoiseCov = processNoiseCov;

    final measurementNoiseCov = kf.measurementNoiseCov;
    expect(measurementNoiseCov.isEmpty, false);
    kf.measurementNoiseCov = measurementNoiseCov;

    final measurementMatrix = kf.measurementMatrix;
    expect(measurementMatrix.isEmpty, false);
    kf.measurementMatrix = measurementMatrix;

    final gain = kf.gain;
    expect(gain.isEmpty, false);
    kf.gain = gain;

    final errorCovPost = kf.errorCovPost;
    expect(errorCovPost.isEmpty, false);
    kf.errorCovPost = errorCovPost;

    final errorCovPre = kf.errorCovPre;
    expect(errorCovPre.isEmpty, false);
    kf.errorCovPre = errorCovPre;

    final controlMatrix = kf.controlMatrix;
    expect(controlMatrix.isEmpty, false);
    kf.controlMatrix = controlMatrix;

    kf.dispose();
  });
}
