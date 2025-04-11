import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

void main() async {
  test("cv.approxPolyDPAsync, cv.arcLengthAsync", () async {
    final img = cv.Mat.create(cols: 100, rows: 200, type: cv.MatType.CV_8UC1);
    final color = cv.Scalar.all(255);
    cv.line(img, cv.Point(25, 25), cv.Point(25, 75), color);
    cv.line(img, cv.Point(25, 75), cv.Point(75, 50), color);
    cv.line(img, cv.Point(75, 50), cv.Point(25, 25), color);
    await cv.rectangleAsync(img, cv.Rect(125, 25, 175, 75), color);

    final (contours, _) = await cv.findContoursAsync(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    final length = await cv.arcLengthAsync(contours.first, true);
    final triangleContour = await cv.approxPolyDPAsync(contours.first, 0.04 * length, true);
    final expected = <cv.Point>[cv.Point(25, 25), cv.Point(25, 75), cv.Point(75, 50)];
    expect(triangleContour.length, equals(expected.length));
    expect(triangleContour.toList(), expected);
  });

  test('cv.convexHullAsync, cv.convexityDefectsAsync', () async {
    final img = await cv.imreadAsync("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final (contours, hierarchy) = await cv.findContoursAsync(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    expect(contours.length, greaterThan(0));
    expect(hierarchy.isEmpty, false);

    final area = await cv.contourAreaAsync(contours.first);
    expect(area, closeTo(127280.0, 1e-4));

    final hull = await cv.convexHullAsync(contours.first, clockwise: true, returnPoints: false);
    expect(hull.isEmpty, false);

    final defects = await cv.convexityDefectsAsync(contours.first, hull);
    expect(defects.isEmpty, false);
  });

  test('cv.calcBackProjectAsync', () async {
    final img = await cv.imreadAsync("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final mask = cv.Mat.empty();
    final hist = await cv.calcHistAsync([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final backProject = await cv.calcBackProjectAsync([img].cvd, [0].i32, hist, [0.0, 256.0].f32);
    expect(backProject.isEmpty, false);
  });

  test('cv.compareHistAsync', () async {
    final img = await cv.imreadAsync("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final mask = cv.Mat.empty();
    final hist1 = await cv.calcHistAsync([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final hist2 = await cv.calcHistAsync([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final dist = await cv.compareHistAsync(hist1, hist2, method: cv.HISTCMP_CORREL);
    expect(dist, closeTo(1.0, 1e-4));
  });

  test('cv.clipLineAsync', () async {
    final (result, _, _) = await cv.clipLineAsync(cv.Rect(0, 0, 100, 100), cv.Point(5, 5), cv.Point(5, 5));
    expect(result, true);
  });

  test('cv.bilateralFilterAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = await cv.bilateralFilterAsync(img, 1, 2.0, 3.0);
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.blurAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = await cv.blurAsync(img, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.boxFilterAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = await cv.boxFilterAsync(img, -1, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.sqrBoxFilterAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = await cv.sqrBoxFilterAsync(img, -1, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test("cv.findContoursAsync, cv.drawContoursAsync", () async {
    final src = await cv.imreadAsync("test/images/markers_6x6_250.png", flags: cv.IMREAD_GRAYSCALE);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    cv.bitwiseNOT(src, dst: src);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    final (contours, hierarchy) = await cv.findContoursAsync(src, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    expect(contours.length, greaterThan(0));
    expect(hierarchy.isEmpty, equals(false));
    expect(
      List.generate(
        contours.length,
        (index) => contours.elementAt(index).length,
      ).every((element) => element == 4),
      equals(true),
    );

    // draw
    final canvas = await cv.cvtColorAsync(src, cv.COLOR_GRAY2BGR);
    await cv.drawContoursAsync(canvas, contours, -1, cv.Scalar.red, thickness: 2);
    final success = await cv.imwriteAsync("test/images_out/markers_6x6_250_contours.png", canvas);
    expect(success, equals(true));

    // trigger GC
    // contours = null;
    // int size = 100000;
    // List<String> list = [];
    // for (int i = 0; i < size; i++) {
    //   list.add("AAAAAAAAA_" + i.toString());
    // }
  });

  test("cv.cvtColorAsync", () async {
    final cvImage = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    final gray = await cv.cvtColorAsync(cvImage, cv.COLOR_BGR2GRAY);
    expect((gray.width, gray.height, gray.channels), (512, 512, 1));
    expect(await cv.imwriteAsync("test/images_out/test_cvtcolor.png", gray), true);
  });

  test("cv.equalizeHistAsync", () async {
    final cvImage = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect((cvImage.width, cvImage.height), (512, 512));
    final imgNew = await cv.equalizeHistAsync(cvImage);
    expect((cvImage.width, cvImage.height, cvImage.channels), (imgNew.width, imgNew.height, imgNew.channels));
    expect(await cv.imwriteAsync("test/images_out/circles_equalized.jpg", imgNew), equals(true));
  });

  test("cv.calcHistAsync", () async {
    final src = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final mask = cv.Mat.empty();
    final hist = await cv.calcHistAsync([src].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    expect(hist.height == 256 && hist.width == 1 && !hist.isEmpty, equals(true));
  });

  test('cv.erodeAsync', () async {
    final src = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final kernel = await cv.getStructuringElementAsync(cv.MORPH_RECT, (3, 3));
    final dst = await cv.erodeAsync(src, kernel);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  test('cv.dilateAsync', () async {
    final src = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final kernel = await cv.getStructuringElementAsync(cv.MORPH_RECT, (3, 3));
    final dst = await cv.dilateAsync(src, kernel);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  // cv.contourAreaAsync
  test('cv.contourAreaAsync', () async {
    final contour = <cv.Point>[cv.Point(0, 0), cv.Point(100, 0), cv.Point(100, 100), cv.Point(0, 100)].cvd;
    expect(await cv.contourAreaAsync(contour), equals(10000));
  });

  test('cv.getStructuringElementAsync', () async {
    final kernel = await cv.getStructuringElementAsync(cv.MORPH_RECT, (3, 3));
    expect(kernel.height == 3 && kernel.width == 3 && !kernel.isEmpty, equals(true));
  });

  test('basic drawings Async', () async {
    final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_8UC3);
    cv.line(src, cv.Point(10, 10), cv.Point(90, 90), cv.Scalar.red, thickness: 2, lineType: cv.LINE_AA);
    await cv.ellipseAsync(src, cv.Point(50, 50), cv.Point(10, 20), 30.0, 0, 360, cv.Scalar.green);
    await cv.rectangleAsync(src, cv.Rect(20, 20, 30, 50), cv.Scalar.blue);
    final pts = [(10, 5), (20, 30), (70, 20), (50, 10)].map((e) => cv.Point(e.$1, e.$2)).toList();
    await cv.polylinesAsync(src, [pts].cvd, false, cv.Scalar.white, thickness: 2, lineType: cv.LINE_AA);
    await cv.putTextAsync(src, "OpenCv-Dart", cv.Point(1, 90), cv.FONT_HERSHEY_SIMPLEX, 0.4, cv.Scalar.white);
    await cv.arrowedLineAsync(src, cv.Point(5, 0), cv.Point(5, 10), cv.Scalar.blue);
    await cv.circleAsync(src, cv.Point(50, 50), 10, cv.Scalar.red);
    expect((src.width, src.height, src.channels), (100, 100, 3));

    await cv.fillPolyAsync(
      src,
      [
        [cv.Point(10, 10), cv.Point(10, 30), cv.Point(30, 30)],
      ].cvd,
      cv.Scalar.green,
    );

    await cv.imwriteAsync("test/images_out/basic_drawings.png", src);
  });

  test('cv.thresholdAsync', () async {
    final src = await cv.imreadAsync("test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    final (_, dst) = await cv.thresholdAsync(src, 100, 255, cv.THRESH_BINARY);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  test('cv.distanceTransformAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gray = await cv.cvtColorAsync(img, cv.COLOR_BGR2GRAY);

    final (_, thres) = await cv.thresholdAsync(gray, 25, 255, cv.THRESH_BINARY);

    final (dest, labels) = await cv.distanceTransformAsync(
      thres,
      cv.DIST_L2,
      cv.DIST_MASK_3,
      cv.DIST_LABEL_CCOMP,
    );
    expect(dest.isEmpty || dest.rows != img.rows || dest.cols != img.cols, false);
    expect(labels.isEmpty, false);
  });

  test('cv.floodFillAsync', () async {
    final img = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC3);
    expect(img.isEmpty, false);
    await cv.rectangleAsync(img, cv.Rect(0, 0, 255, 255), cv.Scalar.red, thickness: cv.FILLED);
    await cv.rectangleAsync(img, cv.Rect(0, 0, 255, 255), cv.Scalar.black, thickness: 15);
    await cv.rectangleAsync(img, cv.Rect(30, 40, 100, 100), cv.Scalar.blue, thickness: cv.FILLED);
    await cv.rectangleAsync(img, cv.Rect(150, 160, 75, 75), cv.Scalar(0, 255, 255), thickness: cv.FILLED);

    final point = cv.Point(200, 100);
    await cv.floodFillAsync(img, point, cv.Scalar(0, 255, 0));
    // cv.imwrite("floodFillNoMask.png", img);

    var mask = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC1);
    mask.forEachPixel((row, col, pix) {
      if (col <= 128) {
        pix[0] = 255;
      }
    });
    mask = await cv.copyMakeBorderAsync(mask, 1, 1, 1, 1, cv.BORDER_REPLICATE);
    // cv.imwrite("mask.png", mask);

    await cv.floodFillAsync(img, point, cv.Scalar.white, mask: mask);
    // cv.imwrite("floodFillMask.png", img);
  });

  test('cv.boundingRectAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (contours, _) = await cv.findContoursAsync(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    final r = await cv.boundingRectAsync(contours.first);
    expect(r.width > 0 && r.height > 0, true);
  });

  test('cv.boxPointsAsync, cv.minAreaRectAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (_, thresImg) = await cv.thresholdAsync(img, 25, 255, cv.THRESH_BINARY);
    final (contours, _) = await cv.findContoursAsync(thresImg, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);

    final rect = await cv.minAreaRectAsync(contours.first);
    expect(rect.size.width > 0 && rect.points.isNotEmpty, true);

    final pts = await cv.boxPointsAsync(rect);
    expect(pts.isEmpty, false);
  });

  // fitEllipse
  test('cv.fitEllipseAsync', () async {
    final pv = [
      cv.Point(1, 1),
      cv.Point(0, 1),
      cv.Point(0, 2),
      cv.Point(1, 3),
      cv.Point(2, 3),
      cv.Point(4, 2),
      cv.Point(4, 1),
      cv.Point(0, 3),
      cv.Point(0, 2),
    ].cvd;
    final rect = await cv.fitEllipseAsync(pv);
    expect(rect.center.x, closeTo(1.92, 0.1));
    expect(rect.center.y, closeTo(1.78, 0.1));
    expect(rect.angle, closeTo(78.60807800292969, 1e-4));
  });

  // minEnclosingCircle
  test('cv.minEnclosingCircleAsync', () async {
    final pts = [cv.Point(0, 2), cv.Point(2, 0), cv.Point(0, -2), cv.Point(-2, 0), cv.Point(1, -1)].cvd;

    final (center, radius) = await cv.minEnclosingCircleAsync(pts);
    expect(radius, closeTo(2.0, 1e-3));
    expect(center.x, closeTo(0.0, 1e-3));
    expect(center.y, closeTo(0.0, 1e-3));
  });

  // pointPolygonTest
  test('cv.pointPolygonTestAsync', () async {
    final tests = [
      ("Inside the polygon - measure=false", 1, cv.Point2f(20, 30), 1.0, false),
      ("Outside the polygon - measure=false", 1, cv.Point2f(5, 15), -1.0, false),
      ("On the polygon - measure=false", 1, cv.Point2f(10, 10), 0.0, false),
      ("Inside the polygon - measure=true", 1, cv.Point2f(20, 20), 10.0, true),
      ("Outside the polygon - measure=true", 1, cv.Point2f(5, 15), -5.0, true),
      ("On the polygon - measure=true", 1, cv.Point2f(10, 10), 0.0, true),
    ];
    final pts = [cv.Point(10, 10), cv.Point(10, 80), cv.Point(80, 80), cv.Point(80, 10)];
    for (final t in tests) {
      final r = await cv.pointPolygonTestAsync(pts.cvd, t.$3, t.$5);
      expect(r, closeTo(t.$4, 1e-3));
    }
  });

  // connectedComponents
  test('cv.connectedComponentsAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.Mat.empty();
    final res = await cv.connectedComponentsAsync(src, dst, 8, cv.MatType.CV_32SC1.value, cv.CCL_DEFAULT);
    expect(dst.isEmpty, false);
    expect(res, greaterThan(1));
  });

  // connectedComponentsWithStats
  test('cv.connectedComponentsWithStatsAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.Mat.empty();
    final stats = cv.Mat.empty();
    final centroids = cv.Mat.empty();
    final res = await cv.connectedComponentsWithStatsAsync(
      src,
      dst,
      stats,
      centroids,
      8,
      cv.MatType.CV_32SC1.value,
      cv.CCL_DEFAULT,
    );
    expect(dst.isEmpty || stats.isEmpty || centroids.isEmpty, false);
    expect(res, greaterThan(1));
  });

  // matchTemplate
  test('cv.matchTemplateAsync', () async {
    final imgScene = await cv.imreadAsync("test/images/face.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(imgScene.isEmpty, false);

    final imgTemplate = await cv.imreadAsync("test/images/toy.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(imgTemplate.isEmpty, false);

    final result = await cv.matchTemplateAsync(imgScene, imgTemplate, cv.TM_CCOEFF_NORMED);
    final (_, maxConfidence, _, _) = cv.minMaxLoc(result);
    expect(maxConfidence, greaterThan(0.95));
  });

  // moments
  test('cv.momentsAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final m = await cv.momentsAsync(img);
    expect(m.m00, greaterThan(0));
    final m1 = await cv.momentsAsync(img);
    expect(m, m1);

    m1.dispose();
  });

  // test pyrDown
  test('cv.pyrDownAsync, cv.pyrUpAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = await cv.pyrDownAsync(img, borderType: cv.BORDER_DEFAULT);
    expect(dst.isEmpty, false);

    final dst1 = await cv.pyrUpAsync(dst, borderType: cv.BORDER_DEFAULT);
    expect(dst1.isEmpty, false);
  });

  test('cv.morphologyDefaultBorderValueAsync', () async {
    final value = await cv.morphologyDefaultBorderValueAsync();
    expect(value.val.length, 4);
  });

  // morphologyEx
  test('cv.morphologyExAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final kernel = await cv.getStructuringElementAsync(cv.MORPH_RECT, (1, 1));
    final dst = await cv.morphologyExAsync(img, cv.MORPH_OPEN, kernel);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // gaussianBlur
  test('cv.gaussianBlurAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = await cv.gaussianBlurAsync(img, (23, 23), 30, sigmaY: 30, borderType: cv.BORDER_CONSTANT);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // getGaussianKernel
  test('cv.getGaussianKernelAsync', () async {
    final ketnel = await cv.getGaussianKernelAsync(1, 0.5);
    expect(ketnel.isEmpty, false);
  });

  // sobel
  test('cv.sobelAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = await cv.sobelAsync(img, cv.MatType.CV_16S, 0, 1, borderType: cv.BORDER_DEFAULT);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // spatialGradient
  test('cv.spatialGradientAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (dx, dy) = await cv.spatialGradientAsync(img, borderType: cv.BORDER_DEFAULT);
    expect(
      dx.isEmpty ||
          dy.isEmpty ||
          img.rows != dx.rows ||
          img.cols != dx.cols ||
          img.rows != dy.rows ||
          img.cols != dy.cols,
      false,
    );
  });

  // Laplacian
  test('cv.LaplacianAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = await cv.laplacianAsync(img, cv.MatType.CV_16S);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // Scharr
  test('cv.scharrAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = await cv.scharrAsync(img, cv.MatType.CV_16S, 1, 0);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // medianBlur
  test('cv.medianBlurAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = await cv.medianBlurAsync(img, 3);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // Canny
  test('cv.cannyAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final dst = await cv.cannyAsync(img, 50, 150);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // cornerSubPix
  test('cv.goodFeaturesToTrackAsync, cv.cornerSubPixAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final corners = await cv.goodFeaturesToTrackAsync(img, 500, 0.01, 10);
    expect(corners.isEmpty, false);
    expect(corners.length, 500);

    const tc = (cv.TERM_COUNT | cv.TERM_EPS, 20, 0.03);
    final corners1 = await cv.cornerSubPixAsync(img, corners, (10, 10), (-1, -1), tc);

    expect(corners1.isEmpty, false);
    expect(corners1.length, greaterThan(0));
  });

  // grabCut
  test('cv.grabCutAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    expect(img.type, cv.MatType.CV_8UC3);

    final mask = cv.Mat.zeros(img.rows, img.cols, cv.MatType.CV_8UC1);
    final bgdModel = cv.Mat.empty();
    final fgdModel = cv.Mat.empty();
    final r = cv.Rect(0, 0, 50, 50);
    await cv.grabCutAsync(img, mask, r, bgdModel, fgdModel, 1);
    expect(bgdModel.isEmpty, false);
    expect(fgdModel.isEmpty, false);
  });

  // HoughCircles
  test('cv.HoughCirclesAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = await cv.HoughCirclesAsync(img, cv.HOUGH_GRADIENT, 5.0, 5.0);
    expect(circles.isEmpty, false);
    expect((circles.rows, circles.cols), (1, 815));
  });

  // HoughLines
  test('cv.HoughLinesAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = await cv.HoughLinesAsync(img, 1, cv.CV_PI / 180, 50);
    expect(circles.isEmpty, false);
  });

  // HoughLinesP
  test('cv.HoughLinesPAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = await cv.HoughLinesPAsync(img, 1, cv.CV_PI / 180, 50);
    expect(circles.isEmpty, false);
  });

  // HoughLinesPointSet

  // integral
  test('cv.integralAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final (sum, sqSum, tilted) = await cv.integralAsync(img);
    expect(sum.isEmpty || sqSum.isEmpty || tilted.isEmpty, false);
  });

  // adaptiveThreshold
  test('cv.adaptiveThresholdAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = await cv.adaptiveThresholdAsync(img, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY, 11, 2);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // getTextSize
  test('cv.getTextSizeAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (textSize, baseline) = await cv.getTextSizeAsync("Hello World", cv.FONT_HERSHEY_PLAIN, 1.0, 1);
    expect((textSize.width, textSize.height, baseline), (91, 10, 6));
  });

  // resize
  test('cv.resizeAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = await cv.resizeAsync(img, (100, 100));
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (100, 100));
  });

  // getRectSubPix
  test('cv.getRectSubPixAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = await cv.getRectSubPixAsync(img, (100, 100), cv.Point2f(200, 200));
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (100, 100));
  });

  // warpAffine
  test('cv.getRotationMatrix2DAsync, cv.warpAffineAsync', () async {
    final src = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC1);
    final rot = await cv.getRotationMatrix2DAsync(cv.Point2f(0, 0), 1.0, 1.0);
    final dst = await cv.warpAffineAsync(src, rot, (256, 256));
    final res = cv.norm(dst, normType: cv.NORM_L2);
    expect(res, closeTo(0.0, 1e-4));
  });

  // warpPerspective
  test('cv.warpPerspectiveAsync', () async {
    final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);
    final pvs = [cv.Point(0, 0), cv.Point(10, 5), cv.Point(10, 10), cv.Point(5, 10)];

    final pvd = [cv.Point(0, 0), cv.Point(10, 0), cv.Point(10, 10), cv.Point(0, 10)];

    final m = await cv.getPerspectiveTransformAsync(pvs.cvd, pvd.cvd);
    final dst = await cv.warpPerspectiveAsync(img, m, (img.width, img.height));
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  // watershed
  test('cv.watershedAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);

    final gray = await cv.cvtColorAsync(src, cv.COLOR_BGR2GRAY);
    expect(gray.isEmpty, false);

    final (_, imgThresh) = await cv.thresholdAsync(gray, 5, 50, cv.THRESH_OTSU + cv.THRESH_BINARY);
    final markers = cv.Mat.empty();
    final _ = await cv.connectedComponentsAsync(
      imgThresh,
      markers,
      8,
      cv.MatType.CV_32SC1.value,
      cv.CCL_DEFAULT,
    );
    await cv.watershedAsync(src, markers);
    expect(markers.isEmpty, false);
    expect((markers.rows, markers.cols), (src.rows, src.cols));
  });

  // applyColorMap
  test('cv.applyColorMapAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    final dst = await cv.applyColorMapAsync(src, cv.COLORMAP_AUTUMN);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  // applyCustomColorMap
  test('cv.applyCustomColorMapAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final cmap = cv.Mat.zeros(256, 1, cv.MatType.CV_8UC1);
    final dst = await cv.applyCustomColorMapAsync(src, cmap);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  // getPerspectiveTransform
  test('cv.getPerspectiveTransformAsync', () async {
    final src = [cv.Point(0, 0), cv.Point(10, 5), cv.Point(10, 10), cv.Point(5, 10)];
    final dst = [cv.Point(0, 0), cv.Point(10, 0), cv.Point(10, 10), cv.Point(0, 10)];
    final m = await cv.getPerspectiveTransformAsync(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (3, 3));
  });

  // getPerspectiveTransform2f
  test('cv.getPerspectiveTransform2fAsync', () async {
    final src = [cv.Point2f(0, 0), cv.Point2f(10, 5), cv.Point2f(10, 10), cv.Point2f(5, 10)];
    final dst = [cv.Point2f(0, 0), cv.Point2f(10, 0), cv.Point2f(10, 10), cv.Point2f(0, 10)];
    final m = await cv.getPerspectiveTransform2fAsync(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (3, 3));
  });

  // getAffineTransform
  test('cv.getAffineTransformAsync', () async {
    final src = [cv.Point(0, 0), cv.Point(10, 5), cv.Point(10, 10)];

    final dst = [cv.Point(0, 0), cv.Point(10, 0), cv.Point(10, 10)];
    final m = await cv.getAffineTransformAsync(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (2, 3));
  });

  // getAffineTransform2f
  test('cv.getAffineTransform2fAsync', () async {
    final src = [cv.Point2f(0, 0), cv.Point2f(10, 5), cv.Point2f(10, 10)];

    final dst = [cv.Point2f(0, 0), cv.Point2f(10, 0), cv.Point2f(10, 10)];
    final m = await cv.getAffineTransform2fAsync(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (2, 3));
  });

  // remap
  test('cv.remapAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final mapX = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_32FC1);
    final mapY = mapX.clone();

    // flip horizontally
    for (var i = 0; i < mapX.rows; i++) {
      for (var j = 0; j < mapX.cols; j++) {
        mapX.set<double>(i, j, (mapX.cols - j).toDouble());
        mapY.set<double>(i, j, i.toDouble());
      }
    }
    final dst = await cv.remapAsync(src, mapX, mapY, cv.INTER_LINEAR, borderValue: cv.Scalar.black);
    expect(dst.isEmpty, false);
  });

  // filter2D
  test('cv.filter2DAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final kernel = await cv.getStructuringElementAsync(cv.MORPH_RECT, (1, 1));
    final dst = await cv.filter2DAsync(src, -1, kernel);
    expect(dst.isEmpty, false);
  });

  // sepFilter2D
  test('cv.sepFilter2DAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final kernelX = await cv.getStructuringElementAsync(cv.MORPH_RECT, (1, 1));
    final kernelY = await cv.getStructuringElementAsync(cv.MORPH_RECT, (1, 1));
    final dst = await cv.sepFilter2DAsync(src, -1, kernelX, kernelY, anchor: cv.Point(-1, -1), delta: 0);
    expect(dst.isEmpty, false);
  });

  // logPolar
  test('cv.logPolarAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final dst = await cv.logPolarAsync(src, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
    expect(dst.isEmpty, false);
  });

  // linearPolar
  test('cv.linearPolarAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final dst = await cv.linearPolarAsync(src, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
    expect(dst.isEmpty, false);
  });

  // fitLine
  test('cv.fitLineAsync', () async {
    final pts = [cv.Point(125, 24), cv.Point(124, 75), cv.Point(175, 76), cv.Point(176, 25)];
    final dst = await cv.fitLineAsync(pts.cvd, cv.DIST_L2, 0, 0.01, 0.01);
    expect(dst.isEmpty, false);
  });

  // matchShapes
  test('cv.matchShapesAsync', () async {
    final pts1 = [cv.Point(0, 0), cv.Point(1, 0), cv.Point(2, 2), cv.Point(3, 3), cv.Point(3, 4)];
    final pts2 = [cv.Point(0, 0), cv.Point(1, 0), cv.Point(2, 3), cv.Point(3, 3), cv.Point(3, 5)];
    final similarity = await cv.matchShapesAsync(pts1.cvd, pts2.cvd, cv.CONTOURS_MATCH_I2, 0);
    expect(2.0 <= similarity && similarity <= 3.0, true);
  });

  test('cv.invertAffineTransformAsync', () async {
    final src = [cv.Point(0, 0), cv.Point(10, 5), cv.Point(10, 10)];

    final dst = [cv.Point(0, 0), cv.Point(10, 0), cv.Point(10, 10)];
    final m = await cv.getAffineTransformAsync(src.cvd, dst.cvd);
    final inv = await cv.invertAffineTransformAsync(m);
    expect(inv.isEmpty, false);
    expect((inv.rows, inv.cols), (2, 3));
  });

  test('cv.phaseCorrelateAsync', () async {
    final template = await cv.imreadAsync("test/images/simple.jpg", flags: cv.IMREAD_GRAYSCALE);
    final matched = await cv.imreadAsync("test/images/simple-translated.jpg", flags: cv.IMREAD_GRAYSCALE);
    final notMatchedOrig = await cv.imreadAsync("test/images/space_shuttle.jpg", flags: cv.IMREAD_GRAYSCALE);

    final notMatched = await cv.resizeAsync(notMatchedOrig, (matched.size[1], matched.size[0]));

    final template32F = template.convertTo(cv.MatType.CV_32FC1);
    final matched32F = matched.convertTo(cv.MatType.CV_32FC1);
    final notMatched32F = notMatched.convertTo(cv.MatType.CV_32FC1);

    final (shiftTranslated, responseTranslated) = await cv.phaseCorrelateAsync(template32F, matched32F);
    final (_, responseDiff) = await cv.phaseCorrelateAsync(template32F, notMatched32F);
    expect(shiftTranslated.x, isA<double>());
    expect(shiftTranslated.y, isA<double>());

    expect(responseTranslated, greaterThan(0.85));
    expect(responseDiff, lessThan(0.05));
  });

  // accumulate
  test('cv.accumulateAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    await cv.accumulateAsync(src, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateSquare
  test('cv.accumulateSquareAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    await cv.accumulateSquareAsync(src, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateProduct
  test('cv.accumulateProductAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final src2 = src.clone();
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    await cv.accumulateProductAsync(src, src2, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateWeighted
  test('cv.accumulateWeightedAsync', () async {
    final src = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    await cv.accumulateWeightedAsync(src, dst, 0.1, mask: mask);
    expect(dst.isEmpty, false);
  });

  test("Issue 8 Async", () async {
    final cv.Mat mask = cv.Mat.ones(512, 512, cv.MatType.CV_32FC1);

    final List<cv.Point2f> faceTemplate = [
      cv.Point2f(192.98138, 239.94708),
      cv.Point2f(318.90277, 240.1936),
      cv.Point2f(256.63416, 314.01935),
      cv.Point2f(201.26117, 371.41043),
      cv.Point2f(314.08905, 371.15118),
    ];

    final List<cv.Point2f> landmarks = [
      cv.Point2f(916.1744018554688, 436.8168579101563),
      cv.Point2f(1179.1181030273438, 448.0384765625),
      cv.Point2f(1039.171106147766, 604.8748825073242),
      cv.Point2f(908.7911743164062, 683.4760314941407),
      cv.Point2f(1167.2201416015625, 693.495068359375),
    ];

    final (affineMatrix, _) = await cv.estimateAffinePartial2DAsync(
      landmarks.cvd,
      faceTemplate.cvd,
      method: cv.LMEDS,
    );

    final invMask = await cv.warpAffineAsync(mask, affineMatrix, (2048, 2048));
    invMask.convertTo(cv.MatType.CV_8UC1, inplace: true);
    invMask.forEachPixel((r, c, p) {
      expect(p[0], isIn([0, 1]));
    });
  });

  test('cv.intersectConvexConvexAsync', () async {
    // helper functions
    cv.VecPoint makeRectangle(cv.Point topLeft, cv.Point bottomRiht) =>
        [topLeft, cv.Point(bottomRiht.x, topLeft.y), bottomRiht, cv.Point(topLeft.x, bottomRiht.y)].asVec();

    Future<double> drawIntersection(
      cv.Mat image,
      cv.VecPoint p1,
      cv.VecPoint p2, {
      bool handleNested = true,
    }) async {
      final (intersectArea, intersectionPolygon) = await cv.intersectConvexConvexAsync(
        p1,
        p2,
        handleNested: handleNested,
      );
      if (intersectArea > 0) {
        final fillColor =
            !cv.isContourConvex(p1) || !cv.isContourConvex(p2) ? cv.Scalar(0, 0, 255) : cv.Scalar.all(200);
        await cv.fillPolyAsync(image, cv.VecVecPoint.fromVecPoint(intersectionPolygon), fillColor);
      }
      await cv.polylinesAsync(image, cv.VecVecPoint.fromVecPoint(intersectionPolygon), true, cv.Scalar.black);
      return intersectArea;
    }

    Future<void> drawDescription(
      cv.Mat image,
      int intersectionArea,
      String description,
      cv.Point origin,
    ) async {
      final caption = "Intersection area: $intersectionArea$description";
      await cv.putTextAsync(image, caption, origin, cv.FONT_HERSHEY_SIMPLEX, 0.6, cv.Scalar.black);
    }

    // start testing
    final image = cv.Mat.fromScalar(610, 550, cv.MatType.CV_8UC3, cv.Scalar.white);
    double intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 10), cv.Point(50, 50)),
      makeRectangle(cv.Point(20, 20), cv.Point(60, 60)),
    );
    await drawDescription(image, intersectionArea.toInt(), "", cv.Point(70, 40));

    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 70), cv.Point(35, 95)),
      makeRectangle(cv.Point(35, 95), cv.Point(60, 120)),
    );
    await drawDescription(image, intersectionArea.toInt(), "", cv.Point(70, 100));

    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 130), cv.Point(60, 180)),
      makeRectangle(cv.Point(20, 140), cv.Point(50, 170)),
      handleNested: true,
    );
    await drawDescription(image, intersectionArea.toInt(), " (handleNested true)", cv.Point(70, 160));

    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 250), cv.Point(60, 300)),
      makeRectangle(cv.Point(20, 250), cv.Point(50, 290)),
      handleNested: true,
    );

    await drawDescription(image, intersectionArea.toInt(), " (handleNested true)", cv.Point(70, 280));

    // These rectangles share an edge so handleNested can be false and an intersection is still found
    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 310), cv.Point(60, 360)),
      makeRectangle(cv.Point(20, 310), cv.Point(50, 350)),
      handleNested: false,
    );

    await drawDescription(image, intersectionArea.toInt(), " (handleNested false)", cv.Point(70, 340));

    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 370), cv.Point(60, 420)),
      makeRectangle(cv.Point(20, 371), cv.Point(50, 410)),
      handleNested: false,
    );

    await drawDescription(image, intersectionArea.toInt(), " (handleNested false)", cv.Point(70, 400));

    // A vertex of the triangle lies on an edge of the rectangle so handleNested can be false and an intersection is still found
    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 430), cv.Point(60, 480)),
      [cv.Point(35, 430), cv.Point(20, 470), cv.Point(50, 470)].asVec(),
      handleNested: false,
    );

    await drawDescription(image, intersectionArea.toInt(), " (handleNested false)", cv.Point(70, 460));

    // Show intersection of overlapping rectangle and triangle
    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 490), cv.Point(40, 540)),
      [cv.Point(25, 500), cv.Point(25, 530), cv.Point(60, 515)].asVec(),
      handleNested: false,
    );

    await drawDescription(image, intersectionArea.toInt(), "", cv.Point(70, 520));

    // This concave polygon is invalid input to intersectConvexConvex so it returns an invalid intersection
    final cv.VecPoint notConvex = [
      cv.Point(25, 560),
      cv.Point(25, 590),
      cv.Point(45, 580),
      cv.Point(60, 600),
      cv.Point(60, 550),
      cv.Point(45, 570),
    ].asVec();
    intersectionArea = await drawIntersection(
      image,
      makeRectangle(cv.Point(10, 550), cv.Point(50, 600)),
      notConvex,
      handleNested: false,
    );

    await drawDescription(image, intersectionArea.toInt(), " (invalid input: not convex)", cv.Point(70, 580));

    // await cv.imwriteAsync("test/images_out/intersections.png", image);
  });
}
