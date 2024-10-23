@Tags(['skip-workflow'])
import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

const String winName = "Test";

void main() async {
  test('cv.highgui', () {
    cv.namedWindow(winName);

    cv.setWindowTitle(winName, "NewName");

    final val = cv.waitKey(1);
    expect(val, -1);
    expect(cv.isWindowOpen(winName), true);

    cv.setWindowProperty(
      winName,
      cv.WindowPropertyFlags.WND_PROP_FULLSCREEN,
      cv.WindowFlag.WINDOW_FULLSCREEN.value,
    );
    expect(
      cv.getWindowProperty(winName, cv.WindowPropertyFlags.WND_PROP_FULLSCREEN),
      cv.WindowFlag.WINDOW_FULLSCREEN.value,
    );
    cv.moveWindow(winName, 100, 100);
    cv.resizeWindow(winName, 100, 100);

    cv.destroyWindow(winName);
  });

  test('cv.imshow', () {
    cv.namedWindow("imshow");
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    cv.imshow("imshow", img);
    final val = cv.waitKey(1);
    expect(val, -1);
    cv.destroyWindow("imshow");
  });

  test('cv.selectROI', () {
    cv.namedWindow(winName);
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    // final rect = cv.selectROI(winName, img);
    // expect(rect.width, greaterThan(0));
    // expect(rect.height, greaterThan(0));

    cv.destroyAllWindows();
  });

  test('cv.Trackbar', () {
    const winName = "TrackbarWin";
    const trackbarName = "Trackbar";
    cv.namedWindow(winName);
    cv.createTrackbar(trackbarName, winName, 10);
    cv.setTrackbarPos(trackbarName, winName, 3);
    expect(cv.getTrackbarPos(trackbarName, winName), 3);
    cv.setTrackbarMin(trackbarName, winName, 5);
    cv.setTrackbarMax(trackbarName, winName, 15);
    // cv.waitKey(1000);

    cv.destroyAllWindows();
  });
}
