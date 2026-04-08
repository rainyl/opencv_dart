import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() {
  test('cv.LineSegmentDetector.empty', () {
    final detector = cv.LineSegmentDetector.empty();
    expect(detector.ptr.address, isNonZero);
    detector.dispose();
  });

  test('cv.LineSegmentDetector.create', () {
    final detector = cv.LineSegmentDetector.create(
      refine: cv.LineSegmentDetector.REFINE_NONE,
      scale: 0.8,
      sigmaScale: 0.6,
      quant: 2.0,
      angTh: 22.5,
      logEps: 0,
      densityTh: 0.7,
      nBins: 1024,
    );
    expect(detector.ptr.address, isNonZero);
    detector.dispose();
  });

  test('cv.LineSegmentDetector.detect and draw', () async {
    final matGray = cv.imread("test/images/building.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(matGray.isEmpty, false);

    final detector = cv.LineSegmentDetector.create();

    // detect
    final (lines, width, prec, nfa) = detector.detect(matGray);
    expect(lines.length, greaterThan(0));
    expect(width.length, greaterThan(0));
    expect(prec.length, greaterThan(0));

    // detectAsync
    final (linesAsync, widthAsync, precAsync, nfaAsync) = await detector.detectAsync(matGray);
    expect(linesAsync.length, greaterThan(0));
    expect(widthAsync.length, greaterThan(0));
    expect(precAsync.length, greaterThan(0));

    // drawSegments
    final drawn = matGray.clone();
    detector.drawSegments(drawn, lines);
    expect(drawn.isEmpty, false);
    // cv.imwrite("test/images_out/drawSegments.png", drawn);

    // compareSegments
    final matColor = cv.imread("test/images/building.jpg", flags: cv.IMREAD_COLOR);
    final size = (matGray.width, matGray.height);
    final (rval, imageOut) = detector.compareSegments(matColor, size, lines, linesAsync, imageOut: matColor);
    expect(rval, 0);
    // cv.imwrite("test/images_out/compareSegment.png", imageOut);

    detector.dispose();
  });
}
