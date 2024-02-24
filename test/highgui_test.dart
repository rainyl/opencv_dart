import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test('cv.Window', () {
    final win = cv.Window("Test");
    expect(win.name, "Test");

    win.setWindowTitle("NewName");

    final val = win.waitKey(1);
    expect(val, -1);
    expect(win.isOpen, true);

    win.setWindowProperty(cv.WindowPropertyFlags.WND_PROP_FULLSCREEN, cv.WindowFlag.WINDOW_FULLSCREEN.value);
    expect(win.getWindowProperty(cv.WindowPropertyFlags.WND_PROP_FULLSCREEN), cv.WindowFlag.WINDOW_FULLSCREEN.value);
    win.moveWindow(100, 100);
    win.resizeWindow(100, 100);

    win.close();
    expect(win.isOpen, false);
  });

  test('cv.Window().imshow', () {
    final win = cv.Window("imshow");
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    win.imshow(img);
    final val = win.waitKey(1);
    expect(val, -1);
    win.close();
    expect(win.isOpen, false);
  });

  test('cv.Window().selectROI', () {
    final win = cv.Window("selectROI");
    expect(win.name, "selectROI");
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    // final rect = win.selectROI(img);
    // expect(rect.width, greaterThan(0));
    // expect(rect.height, greaterThan(0));

    win.close();
  });

  test('cv.Trackbar', () {
    final win = cv.Window("TrackbarWin");
    final trackbar = cv.Trackbar("Trackbar", win, 10, value: 1);
    trackbar.pos = 3;
    expect(trackbar.pos, 3);

    trackbar.minPos = 5;
    trackbar.maxPos = 15;

    // win.waitKey(1000);
    
    win.close();
  });
}
