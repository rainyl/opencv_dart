import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  test("cv2.approxPolyDP, cv.arcLength", () {
    final img = cv.Mat.create(cols: 100, rows: 200, type: cv.MatType.CV_8UC1);
    final color = cv.Scalar.all(255);
    cv.line(
      img,
      cv.Point(25, 25),
      cv.Point(25, 75),
      color,
    );
    cv.line(
      img,
      cv.Point(25, 75),
      cv.Point(75, 50),
      color,
    );
    cv.line(
      img,
      cv.Point(75, 50),
      cv.Point(25, 25),
      color,
    );
    cv.rectangle(img, cv.Rect(125, 25, 175, 75), color);

    final (contours, _) = cv.findContours(
      img,
      cv.RETR_EXTERNAL,
      cv.CHAIN_APPROX_SIMPLE,
    );
    final length = cv.arcLength(contours.first, true);
    final triangleContour = cv.approxPolyDP(contours.first, 0.04 * length, true);
    final expected = <cv.Point>[cv.Point(25, 25), cv.Point(25, 75), cv.Point(75, 50)];
    expect(triangleContour.length, equals(expected.length));
    expect(triangleContour.toList(), expected);
  });

  test('cv.convexHull, cv.convexityDefects', () {
    final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final (contours, hierarchy) = cv.findContours(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    expect(contours.length, greaterThan(0));
    expect(hierarchy.isEmpty, false);

    final area = cv.contourArea(contours.first);
    expect(area, closeTo(127280.0, 1e-4));

    final hull = cv.convexHull(contours.first, clockwise: true, returnPoints: false);
    expect(hull.isEmpty, false);

    final defects = cv.convexityDefects(contours.first, hull);
    expect(defects.isEmpty, false);
  });

  test('cv.calcBackProject', () {
    final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final mask = cv.Mat.empty();
    final hist = cv.calcHist([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final backProject =
        cv.calcBackProject([img].cvd, [0].i32, hist, [0.0, 256.0].f32, uniform: false);
    expect(backProject.isEmpty, false);
  });

  test('cv.compareHist', () {
    final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    cv.Mat.empty();
    cv.Mat.empty();
    final mask = cv.Mat.empty();

    final hist1 = cv.calcHist([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final hist2 = cv.calcHist([img].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    final dist = cv.compareHist(hist1, hist2, method: cv.HISTCMP_CORREL);
    expect(dist, closeTo(1.0, 1e-4));
  });

  test('cv.clipLine', () {
    final (result, _, _) = cv.clipLine(cv.Rect(0, 0, 100, 100), cv.Point(5, 5), cv.Point(5, 5));
    expect(result, true);
  });

  test('cv.bilateralFilter', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.bilateralFilter(img, 1, 2.0, 3.0);
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.blur', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.blur(img, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.boxFilter', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.boxFilter(img, -1, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test('cv.sqrBoxFilter', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.sqrBoxFilter(img, -1, (3, 3));
    expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  });

  test("cv2.findContours, cv.drawContours", () {
    final src = cv.imread("test/images/markers_6x6_250.png", flags: cv.IMREAD_GRAYSCALE);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    cv.bitwiseNOT(src, dst: src);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    var (contours, hierarchy) = cv.findContours(
      src,
      cv.RETR_EXTERNAL,
      cv.CHAIN_APPROX_SIMPLE,
    );
    expect(contours.length, greaterThan(0));
    expect(hierarchy.isEmpty, equals(false));
    expect(
      List.generate(contours.length, (index) => contours.elementAt(index).length)
          .every((element) => element == 4),
      equals(true),
    );

    // draw
    final canvas = cv.cvtColor(src, cv.COLOR_GRAY2BGR);
    cv.drawContours(canvas, contours, -1, cv.Scalar.red, thickness: 2);
    final success = cv.imwrite("test/images_out/markers_6x6_250_contours.png", canvas);
    expect(success, equals(true));

    // trigger GC
    // contours = null;
    // int size = 100000;
    // List<String> list = [];
    // for (int i = 0; i < size; i++) {
    //   list.add("AAAAAAAAA_" + i.toString());
    // }
  });

  test("cv2.cvtColor", () {
    final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    final gray = cv.cvtColor(cvImage, cv.COLOR_BGR2GRAY);
    expect((gray.width, gray.height, gray.channels), (512, 512, 1));
    expect(cv.imwrite("test/images_out/test_cvtcolor.png", gray), true);
  });

  test("cv2.equalizeHist", () async {
    final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect((cvImage.width, cvImage.height), (512, 512));
    final imgNew = cv.equalizeHist(cvImage);
    expect((cvImage.width, cvImage.height, cvImage.channels),
        (imgNew.width, imgNew.height, imgNew.channels));
    expect(cv.imwrite("test/images_out/circles_equalized.jpg", imgNew), equals(true));
  });

  test("cv2.calcHist", () async {
    final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final mask = cv.Mat.empty();
    final hist = cv.calcHist([src].cvd, [0].i32, mask, [256].i32, [0.0, 256.0].f32);
    expect(hist.height == 256 && hist.width == 1 && !hist.isEmpty, equals(true));
  });

  test('cv.erode', () {
    final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (3, 3),
    );
    final dst = cv.erode(src, kernel);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  test('cv.dilate', () {
    final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (3, 3),
    );
    final dst = cv.dilate(src, kernel);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  // cv.contourArea
  test('cv.contourArea', () {
    final contour = <cv.Point>[
      cv.Point(0, 0),
      cv.Point(100, 0),
      cv.Point(100, 100),
      cv.Point(0, 100),
    ].cvd;
    expect(cv.contourArea(contour), equals(10000));
  });

  test('cv.getStructuringElement', () {
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (3, 3),
    );
    expect(kernel.height == 3 && kernel.width == 3 && !kernel.isEmpty, equals(true));
  });

  test('basic drawings', () {
    final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_8UC3);
    cv.line(src, cv.Point(10, 10), cv.Point(90, 90), cv.Scalar.red,
        thickness: 2, lineType: cv.LINE_AA);
    cv.ellipse(src, cv.Point(50, 50), cv.Point(10, 20), 30.0, 0, 360, cv.Scalar.green);
    cv.rectangle(src, cv.Rect(20, 20, 30, 50), cv.Scalar.blue);
    final pts = [(10, 5), (20, 30), (70, 20), (50, 10)].map((e) => cv.Point(e.$1, e.$2)).toList();
    cv.polylines(src, [pts].cvd, false, cv.Scalar.white, thickness: 2, lineType: cv.LINE_AA);
    cv.putText(src, "OpenCv-Dart", cv.Point(1, 90), cv.FONT_HERSHEY_SIMPLEX, 0.4, cv.Scalar.white);
    cv.arrowedLine(src, cv.Point(5, 0), cv.Point(5, 10), cv.Scalar.blue);
    cv.circle(src, cv.Point(50, 50), 10, cv.Scalar.red);
    expect((src.width, src.height, src.channels), (100, 100, 3));

    cv.fillPoly(
        src,
        [
          [cv.Point(10, 10), cv.Point(10, 30), cv.Point(30, 30)]
        ].cvd,
        cv.Scalar.green);

    cv.imwrite("test/images_out/basic_drawings.png", src);
  });

  test('cv.threshold', () {
    final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
    final (_, dst) = cv.threshold(src, 100, 255, cv.THRESH_BINARY);
    expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  });

  test('cv.distanceTransform', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);

    final (_, thres) = cv.threshold(gray, 25, 255, cv.THRESH_BINARY);

    final (dest, labels) =
        cv.distanceTransform(thres, cv.DIST_L2, cv.DIST_MASK_3, cv.DIST_LABEL_CCOMP);
    expect(dest.isEmpty || dest.rows != img.rows || dest.cols != img.cols, false);
    expect(labels.isEmpty, false);
  });

  test('cv.boundingRect', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (contours, _) = cv.findContours(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
    final r = cv.boundingRect(contours.first);
    expect(r.width > 0 && r.height > 0, true);
  });

  test('cv.boxPoints, cv.minAreaRect', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (_, thresImg) = cv.threshold(img, 25, 255, cv.THRESH_BINARY);
    final (contours, _) = cv.findContours(thresImg, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);

    final rect = cv.minAreaRect(contours.first);
    expect(rect.size.$1 > 0 && rect.points.isNotEmpty, true);

    final pts = cv.boxPoints(rect);
    expect(pts.isEmpty, false);
  });

  // fitEllipse
  test('cv.fitEllipse', () {
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
    final rect = cv.fitEllipse(pv);
    expect(rect.center.x, closeTo(1.92, 0.1));
    expect(rect.center.y, closeTo(1.78, 0.1));
    expect(rect.angle, closeTo(78.60807800292969, 1e-4));
  });

  // minEnclosingCircle
  test('cv.minEnclosingCircle', () {
    final pts = [
      cv.Point(0, 2),
      cv.Point(2, 0),
      cv.Point(0, -2),
      cv.Point(-2, 0),
      cv.Point(1, -1),
    ].cvd;

    final (center, radius) = cv.minEnclosingCircle(pts);
    expect(radius, closeTo(2.0, 1e-3));
    expect(center.x, closeTo(0.0, 1e-3));
    expect(center.y, closeTo(0.0, 1e-3));
  });

  // pointPolygonTest
  test('cv.pointPolygonTest', () {
    final tests = [
      ("Inside the polygon - measure=false", 1, cv.Point2f(20, 30), 1.0, false),
      ("Outside the polygon - measure=false", 1, cv.Point2f(5, 15), -1.0, false),
      ("On the polygon - measure=false", 1, cv.Point2f(10, 10), 0.0, false),
      ("Inside the polygon - measure=true", 1, cv.Point2f(20, 20), 10.0, true),
      ("Outside the polygon - measure=true", 1, cv.Point2f(5, 15), -5.0, true),
      ("On the polygon - measure=true", 1, cv.Point2f(10, 10), 0.0, true),
    ];
    final pts = [
      cv.Point(10, 10),
      cv.Point(10, 80),
      cv.Point(80, 80),
      cv.Point(80, 10),
    ];
    for (var t in tests) {
      var r = cv.pointPolygonTest(pts.cvd, t.$3, t.$5);
      expect(r, closeTo(t.$4, 1e-3));
    }
  });

  // connectedComponents
  test('cv.connectedComponents', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.Mat.empty();
    final res = cv.connectedComponents(src, dst, 8, cv.MatType.CV_32SC1.value, cv.CCL_DEFAULT);
    expect(dst.isEmpty, false);
    expect(res, greaterThan(1));
  });

  // connectedComponentsWithStats
  test('cv.connectedComponentsWithStats', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final dst = cv.Mat.empty();
    final stats = cv.Mat.empty();
    final centroids = cv.Mat.empty();
    final res = cv.connectedComponentsWithStats(
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
  test('cv.matchTemplate', () {
    final imgScene = cv.imread("test/images/face.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(imgScene.isEmpty, false);

    final imgTemplate = cv.imread("test/images/toy.jpg", flags: cv.IMREAD_GRAYSCALE);
    expect(imgTemplate.isEmpty, false);

    final result = cv.matchTemplate(imgScene, imgTemplate, cv.TM_CCOEFF_NORMED);
    final (_, maxConfidence, _, _) = cv.minMaxLoc(result);
    expect(maxConfidence, greaterThan(0.95));
  });

  // moments
  test('cv.moments', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final m = cv.moments(img);
    expect(m.m00, greaterThan(0));
    final m1 = cv.moments(img);
    expect(m, m1);

    m1.dispose();
  });

  // test pyrDown
  test('cv.pyrDown, cv.pyrUp', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = cv.pyrDown(img, borderType: cv.BORDER_DEFAULT);
    expect(dst.isEmpty, false);

    final dst1 = cv.pyrUp(dst, borderType: cv.BORDER_DEFAULT);
    expect(dst1.isEmpty, false);
  });

  test('cv.morphologyDefaultBorderValue', () {
    final value = cv.morphologyDefaultBorderValue();
    expect(value.val.length, 4);
  });

  // morphologyEx
  test('cv.morphologyEx', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
    final dst = cv.morphologyEx(img, cv.MORPH_OPEN, kernel);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // gaussianBlur
  test('cv.gaussianBlur', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = cv.gaussianBlur(img, (23, 23), 30, sigmaY: 30, borderType: cv.BORDER_CONSTANT);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // getGaussianKernel
  test('cv.getGaussianKernel', () {
    final ketnel = cv.getGaussianKernel(1, 0.5);
    expect(ketnel.isEmpty, false);
  });

  // sobel
  test('cv.sobel', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final dst = cv.sobel(img, cv.MatType.CV_16S, 0, 1, borderType: cv.BORDER_DEFAULT);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // spatialGradient
  test('cv.spatialGradient', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (dx, dy) = cv.spatialGradient(img, borderType: cv.BORDER_DEFAULT);
    expect(
        dx.isEmpty ||
            dy.isEmpty ||
            img.rows != dx.rows ||
            img.cols != dx.cols ||
            img.rows != dy.rows ||
            img.cols != dy.cols,
        false);
  });

  // Laplacian
  test('cv.Laplacian', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = cv.laplacian(img, cv.MatType.CV_16S);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // Scharr
  test('cv.Scharr', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = cv.scharr(img, cv.MatType.CV_16S, 1, 0);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // medianBlur
  test('cv.medianBlur', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = cv.medianBlur(img, 3);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // Canny
  test('cv.Canny', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final dst = cv.canny(img, 50, 150);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // cornerSubPix
  test('cv.goodFeaturesToTrack, cv.cornerSubPix', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);
    final corners = cv.goodFeaturesToTrack(img, 500, 0.01, 10);
    expect(corners.isEmpty, false);
    expect(corners.length, 500);

    const tc = (cv.TERM_COUNT | cv.TERM_EPS, 20, 0.03);
    final corners1 = cv.cornerSubPix(img, corners, (10, 10), (-1, -1), tc);

    expect(corners1.isEmpty, false);
    expect(corners1.length, greaterThan(0));
  });

  // grabCut
  test('cv.grabCut', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    expect(img.type, cv.MatType.CV_8UC3);

    final mask = cv.Mat.zeros(img.rows, img.cols, cv.MatType.CV_8UC1);
    final bgdModel = cv.Mat.empty();
    final fgdModel = cv.Mat.empty();
    final r = cv.Rect(0, 0, 50, 50);
    cv.grabCut(img, mask, r, bgdModel, fgdModel, 1);
    expect(bgdModel.isEmpty, false);
    expect(fgdModel.isEmpty, false);
  });

  // HoughCircles
  test('cv.HoughCircles', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = cv.HoughCircles(img, cv.HOUGH_GRADIENT, 5.0, 5.0);
    expect(circles.isEmpty, false);
    expect((circles.rows, circles.cols), (1, 815));
  });

  // HoughLines
  test('cv.HoughLines', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = cv.HoughLines(img, 1, cv.CV_PI / 180, 50);
    expect(circles.isEmpty, false);
  });

  // HoughLinesP
  test('cv.HoughLinesP', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final circles = cv.HoughLinesP(img, 1, cv.CV_PI / 180, 50);
    expect(circles.isEmpty, false);
  });

  // HoughLinesPointSet

  // integral
  test('cv.integral', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);

    final (sum, sqSum, tilted) = cv.integral(img);
    expect(sum.isEmpty || sqSum.isEmpty || tilted.isEmpty, false);
  });

  // adaptiveThreshold
  test('cv.adaptiveThreshold', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final dst = cv.adaptiveThreshold(img, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY, 11, 2);
    expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  });

  // getTextSize
  test('cv.getTextSize', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    expect(img.isEmpty, false);

    final (textSize, baseline) = cv.getTextSize("Hello World", cv.FONT_HERSHEY_PLAIN, 1.0, 1);
    expect((textSize.$1, textSize.$2, baseline), (91, 10, 6));
  });

  // resize
  test('cv.resize', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = cv.resize(img, (100, 100));
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (100, 100));
  });

  // getRectSubPix
  test('cv.getRectSubPix', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(img.isEmpty, false);
    final dst = cv.getRectSubPix(img, (100, 100), cv.Point2f(200, 200));
    expect(dst.isEmpty, false);
    expect((dst.rows, dst.cols), (100, 100));
  });

  // warpAffine
  test('cv.getRotationMatrix2D, cv.warpAffine', () {
    final src = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC1);
    final rot = cv.getRotationMatrix2D(cv.Point2f(0, 0), 1.0, 1.0);
    final dst = cv.warpAffine(src, rot, (256, 256));
    final res = cv.norm(dst, normType: cv.NORM_L2);
    expect(res, closeTo(0.0, 1e-4));
  });

  // warpPerspective
  test('cv.warpPerspective', () {
    final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(img.isEmpty, false);
    final pvs = [
      cv.Point(0, 0),
      cv.Point(10, 5),
      cv.Point(10, 10),
      cv.Point(5, 10),
    ];

    final pvd = [
      cv.Point(0, 0),
      cv.Point(10, 0),
      cv.Point(10, 10),
      cv.Point(0, 10),
    ];

    final m = cv.getPerspectiveTransform(pvs.cvd, pvd.cvd);
    final dst = cv.warpPerspective(img, m, (img.width, img.height));
    expect((dst.rows, dst.cols), (img.rows, img.cols));
  });

  // watershed
  test('cv.watershed', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);

    final gray = cv.cvtColor(src, cv.COLOR_BGR2GRAY);
    expect(gray.isEmpty, false);

    final (_, imgThresh) = cv.threshold(gray, 5, 50, cv.THRESH_OTSU + cv.THRESH_BINARY);

    final markers = cv.Mat.empty();
    cv.connectedComponents(imgThresh, markers, 8, cv.MatType.CV_32SC1.value, cv.CCL_DEFAULT);
    cv.watershed(src, markers);
    expect(markers.isEmpty, false);
    expect((markers.rows, markers.cols), (src.rows, src.cols));
  });

  // applyColorMap
  test('cv.applyColorMap', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    final dst = cv.applyColorMap(src, cv.COLORMAP_AUTUMN);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  // applyCustomColorMap
  test('cv.applyCustomColorMap', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
    final cmap = cv.Mat.zeros(256, 1, cv.MatType.CV_8UC1);
    final dst = cv.applyCustomColorMap(src, cmap);
    expect((dst.rows, dst.cols), (src.rows, src.cols));
  });

  // getPerspectiveTransform
  test('cv.getPerspectiveTransform', () {
    final src = [
      cv.Point(0, 0),
      cv.Point(10, 5),
      cv.Point(10, 10),
      cv.Point(5, 10),
    ];
    final dst = [
      cv.Point(0, 0),
      cv.Point(10, 0),
      cv.Point(10, 10),
      cv.Point(0, 10),
    ];
    final m = cv.getPerspectiveTransform(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (3, 3));
  });

  // getPerspectiveTransform2f
  test('cv.getPerspectiveTransform2f', () {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
      cv.Point2f(5, 10),
    ];
    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
      cv.Point2f(0, 10),
    ];
    final m = cv.getPerspectiveTransform2f(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (3, 3));
  });

  // getAffineTransform
  test('cv.getAffineTransform', () {
    final src = [
      cv.Point(0, 0),
      cv.Point(10, 5),
      cv.Point(10, 10),
    ];

    final dst = [
      cv.Point(0, 0),
      cv.Point(10, 0),
      cv.Point(10, 10),
    ];
    final m = cv.getAffineTransform(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (2, 3));
  });

  // getAffineTransform2f
  test('cv.getAffineTransform2f', () {
    final src = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 5),
      cv.Point2f(10, 10),
    ];

    final dst = [
      cv.Point2f(0, 0),
      cv.Point2f(10, 0),
      cv.Point2f(10, 10),
    ];
    final m = cv.getAffineTransform2f(src.cvd, dst.cvd);
    expect((m.rows, m.cols), (2, 3));
  });

  // findHomography
  test('cv.findHomography', () {
    final src = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC2);
    final dst = cv.Mat.zeros(4, 1, cv.MatType.CV_64FC2);
    final srcPts = [
      cv.Point2f(193, 932),
      cv.Point2f(191, 378),
      cv.Point2f(1497, 183),
      cv.Point2f(1889, 681),
    ];
    final dstPts = [
      cv.Point2f(51.51206544281359, -0.10425475260813055),
      cv.Point2f(51.51211051314331, -0.10437947532732306),
      cv.Point2f(51.512222354139325, -0.10437679311830816),
      cv.Point2f(51.51214828037607, -0.1042212249954444),
    ];
    for (var i = 0; i < srcPts.length; i++) {
      src.setF64(i, 0, srcPts[i].x);
      src.setF64(i, 1, srcPts[i].y);
    }
    for (var i = 0; i < dstPts.length; i++) {
      dst.setF64(i, 0, dstPts[i].x);
      dst.setF64(i, 1, dstPts[i].y);
    }

    final mask = cv.Mat.empty();
    final m = cv.findHomography(
      src,
      dst,
      method: cv.HOMOGRAPY_ALL_POINTS,
      ransacReprojThreshold: 3,
      mask: mask,
    );
    expect(m.isEmpty, false);
  });

  // remap
  test('cv.remap', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final map1 = cv.Mat.zeros(256, 256, cv.MatType.CV_16SC2);
    map1.set<int>(50, 50, 25);
    final map2 = cv.Mat.empty();
    final dst = cv.remap(src, map1, map2, cv.INTER_LINEAR, borderValue: cv.Scalar.black);
    expect(dst.isEmpty, false);
  });

  // filter2D
  test('cv.filter2D', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
    final dst = cv.filter2D(src, -1, kernel);
    expect(dst.isEmpty, false);
  });

  // sepFilter2D
  test('cv.sepFilter2D', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final kernelX = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
    final kernelY = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
    final dst = cv.sepFilter2D(src, -1, kernelX, kernelY, anchor: cv.Point(-1, -1), delta: 0);
    expect(dst.isEmpty, false);
  });

  // logPolar
  test('cv.logPolar', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final dst = cv.logPolar(src, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
    expect(dst.isEmpty, false);
  });

  // linearPolar
  test('cv.linearPolar', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
    expect(src.isEmpty, false);
    final dst = cv.linearPolar(src, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
    expect(dst.isEmpty, false);
  });

  // fitLine
  test('cv.fitLine', () {
    final pts = [
      cv.Point(125, 24),
      cv.Point(124, 75),
      cv.Point(175, 76),
      cv.Point(176, 25),
    ];
    final dst = cv.fitLine(pts.cvd, cv.DIST_L2, 0, 0.01, 0.01);
    expect(dst.isEmpty, false);
  });

  // matchShapes
  test('cv.matchShapes', () {
    final pts1 = [
      cv.Point(0, 0),
      cv.Point(1, 0),
      cv.Point(2, 2),
      cv.Point(3, 3),
      cv.Point(3, 4),
    ];
    final pts2 = [
      cv.Point(0, 0),
      cv.Point(1, 0),
      cv.Point(2, 3),
      cv.Point(3, 3),
      cv.Point(3, 5),
    ];
    final similarity = cv.matchShapes(pts1.cvd, pts2.cvd, cv.CONTOURS_MATCH_I2, 0);
    expect(2.0 <= similarity && similarity <= 3.0, true);
  });

  test('cv.invertAffineTransform', () {
    final src = [
      cv.Point(0, 0),
      cv.Point(10, 5),
      cv.Point(10, 10),
    ];

    final dst = [
      cv.Point(0, 0),
      cv.Point(10, 0),
      cv.Point(10, 10),
    ];
    final m = cv.getAffineTransform(src.cvd, dst.cvd);
    final inv = cv.invertAffineTransform(m);
    expect(inv.isEmpty, false);
    expect((inv.rows, inv.cols), (2, 3));
  });

  test('cv.phaseCorrelate', () {
    final template = cv.imread("test/images/simple.jpg", flags: cv.IMREAD_GRAYSCALE);
    final matched = cv.imread("test/images/simple-translated.jpg", flags: cv.IMREAD_GRAYSCALE);
    final notMatchedOrig = cv.imread("test/images/space_shuttle.jpg", flags: cv.IMREAD_GRAYSCALE);

    final notMatched = cv.resize(notMatchedOrig, (matched.size[1], matched.size[0]));

    final template32F = template.convertTo(cv.MatType.CV_32FC1);
    final matched32F = matched.convertTo(cv.MatType.CV_32FC1);
    final notMatched32F = notMatched.convertTo(cv.MatType.CV_32FC1);

    final (shiftTranslated, responseTranslated) = cv.phaseCorrelate(template32F, matched32F);
    final (_, responseDiff) = cv.phaseCorrelate(template32F, notMatched32F);
    expect(shiftTranslated.x, isA<double>());
    expect(shiftTranslated.y, isA<double>());

    expect(responseTranslated, greaterThan(0.85));
    expect(responseDiff, lessThan(0.05));
  });

  // accumulate
  test('cv.accumulate', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    cv.accumulate(src, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateSquare
  test('cv.accumulateSquare', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    cv.accumulateSquare(src, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateProduct
  test('cv.accumulateProduct', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final src2 = src.clone();
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    cv.accumulateProduct(src, src2, dst, mask: mask);
    expect(dst.isEmpty, false);
  });

  // accumulateWeighted
  test('cv.accumulateWeighted', () {
    final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
    expect(src.isEmpty, false);
    final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
    final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
    cv.accumulateWeighted(src, dst, 0.1, mask: mask);
    expect(dst.isEmpty, false);
  });

  test("Issue 8", () {
    cv.Mat mask = cv.Mat.ones(512, 512, cv.MatType.CV_32FC1);

    List<cv.Point2f> faceTemplate = [
      cv.Point2f(192.98138, 239.94708),
      cv.Point2f(318.90277, 240.1936),
      cv.Point2f(256.63416, 314.01935),
      cv.Point2f(201.26117, 371.41043),
      cv.Point2f(314.08905, 371.15118)
    ];

    List<cv.Point2f> landmarks = [
      cv.Point2f(916.1744018554688, 436.8168579101563),
      cv.Point2f(1179.1181030273438, 448.0384765625),
      cv.Point2f(1039.171106147766, 604.8748825073242),
      cv.Point2f(908.7911743164062, 683.4760314941407),
      cv.Point2f(1167.2201416015625, 693.495068359375),
    ];

    var (affineMatrix, _) =
        cv.estimateAffinePartial2D(landmarks.cvd, faceTemplate.cvd, method: cv.LMEDS);

    var invMask = cv.warpAffine(mask, affineMatrix, (2048, 2048));
    for (int i = 0; i < 2047; i++) {
      for (int j = 0; j < 2047; j++) {
        var val = invMask.at<double>(i, j);
        expect(val == 0 || val == 1, true);
      }
    }
  });
}
