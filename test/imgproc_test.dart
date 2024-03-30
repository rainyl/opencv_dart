// @Skip()
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
    expect(
        List.generate(expected.length, (index) => triangleContour[index] == expected[index])
            .every((element) => element),
        equals(true));
  });

  // test('cv.convexHull, cv.convexityDefects', () {
  //   final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);
  //   final (contours, hierarchy) = cv.findContours(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
  //   expect(contours.length, greaterThan(0));
  //   expect(hierarchy.isEmpty, false);

  //   final area = cv.contourArea(contours[0]);
  //   expect(area, closeTo(127280.0, 1e-4));

  //   final hull = cv.Mat.empty();
  //   cv.convexHull(contours[0], hull, clockwise: true, returnPoints: false);
  //   expect(hull.isEmpty, false);

  //   final defects = cv.Mat.empty();
  //   cv.convexityDefects(contours[0], hull, defects);
  //   expect(defects.isEmpty, false);
  // });

  // test('cv.calcBackProject', () {
  //   final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final hist = cv.Mat.empty();
  //   final backProject = cv.Mat.empty();
  //   final mask = cv.Mat.empty();

  //   cv.calcHist([img], [0], mask, hist, [256], [0.0, 256.0]);
  //   cv.calcBackProject([img], [0], hist, backProject, [0.0, 256.0], uniform: false);
  //   expect(backProject.isEmpty, false);
  // });

  // test('cv.compareHist', () {
  //   final img = cv.imread("test/images/face-detect.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final hist1 = cv.Mat.empty();
  //   final hist2 = cv.Mat.empty();
  //   final mask = cv.Mat.empty();

  //   cv.calcHist([img], [0], mask, hist1, [256], [0.0, 256.0]);
  //   cv.calcHist([img], [0], mask, hist2, [256], [0.0, 256.0]);
  //   final dist = cv.compareHist(hist1, hist2, method: cv.HISTCMP_CORREL);
  //   expect(dist, closeTo(1.0, 1e-4));
  // });

  // test('cv.clipLine', () {
  //   final result = cv.clipLine((20, 20), (5, 5), (5, 5));
  //   expect(result, true);
  // });

  // test('cv.bilateralFilter', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.bilateralFilter(img, dst, 1, 2.0, 3.0);
  //   expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  // });

  // test('cv.blur', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.blur(img, dst, (3, 3));
  //   expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  // });

  // test('cv.boxFilter', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.boxFilter(img, dst, -1, (3, 3));
  //   expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  // });

  // test('cv.sqrBoxFilter', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.sqrBoxFilter(img, dst, -1, (3, 3));
  //   expect(dst.isEmpty || dst.rows != img.rows || dst.cols != img.cols, false);
  // });

  // test("cv2.findContours, cv.drawContours", () {
  //   final src = cv.imread("test/images/markers_6x6_250.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect((src.width, src.height, src.channels), (612, 760, 1));
  //   cv.bitwise_not(src, src);
  //   expect((src.width, src.height, src.channels), (612, 760, 1));
  //   var (cv.Contours? contours, hierarchy) = cv.findContours(
  //     src,
  //     cv.RETR_EXTERNAL,
  //     cv.CHAIN_APPROX_SIMPLE,
  //   );
  //   expect(contours.length, greaterThan(0));
  //   expect(hierarchy.isEmpty, equals(false));
  //   expect(
  //     List.generate(contours.length, (index) => contours[index].length).every((element) => element == 4),
  //     equals(true),
  //   );

  //   // draw
  //   final canvas = src.clone();
  //   cv.cvtColor(src, canvas, cv.COLOR_GRAY2BGR);
  //   cv.drawContours(canvas, contours, -1, cv.Scalar.red, thickness: 2);
  //   final success = cv.imwrite("test/images_out/markers_6x6_250_contours.png", canvas);
  //   expect(success, equals(true));

  //   // trigger GC
  //   // contours = null;
  //   // int size = 100000;
  //   // List<String> list = [];
  //   // for (int i = 0; i < size; i++) {
  //   //   list.add("AAAAAAAAA_" + i.toString());
  //   // }
  // });

  // test("cv2.cvtColor", () {
  //   final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
  //   final gray = cv.Mat.empty();
  //   cv.cvtColor(cvImage, gray, cv.COLOR_BGR2GRAY);
  //   expect((gray.width, gray.height, gray.channels), (512, 512, 1));
  //   expect(cv.imwrite("test/images_out/test_cvtcolor.png", gray), true);
  // });

  // test("cv2.equalizeHist", () async {
  //   final cvImage = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect((cvImage.width, cvImage.height), (512, 512));
  //   final imgNew = cv.Mat.empty();
  //   cv.equalizeHist(cvImage, imgNew);
  //   expect((cvImage.width, cvImage.height, cvImage.channels), (imgNew.width, imgNew.height, imgNew.channels));
  //   expect(cv.imwrite("test/images_out/circles_equalized.jpg", imgNew), equals(true));
  // });

  // test("cv2.calcHist", () async {
  //   final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   final hist = cv.Mat.empty();
  //   final mask = cv.Mat.empty();
  //   cv.calcHist([src], [0], mask, hist, [256], [0.0, 256.0]);
  //   expect(hist.height == 256 && hist.width == 1 && !hist.isEmpty, equals(true));
  // });

  // test('cv.erode', () {
  //   final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   final kernel = cv.getStructuringElement(
  //     cv.MORPH_RECT,
  //     (3, 3),
  //   );
  //   final dst = cv.Mat.empty();
  //   cv.erode(src, dst, kernel);
  //   expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  // });

  // test('cv.dilate', () {
  //   final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   final kernel = cv.getStructuringElement(
  //     cv.MORPH_RECT,
  //     (3, 3),
  //   );
  //   final dst = cv.Mat.empty();
  //   cv.dilate(src, dst, kernel);
  //   expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  // });

  // // cv.contourArea
  // test('cv.contourArea', () {
  //   final contour = <cv.Point>[
  //     cv.Point(0, 0),
  //     cv.Point(100, 0),
  //     cv.Point(100, 100),
  //     cv.Point(0, 100),
  //   ];
  //   expect(cv.contourArea(contour), equals(10000));
  // });

  // test('cv.getStructuringElement', () {
  //   final kernel = cv.getStructuringElement(
  //     cv.MORPH_RECT,
  //     (3, 3),
  //   );
  //   expect(kernel.height == 3 && kernel.width == 3 && !kernel.isEmpty, equals(true));
  // });

  // test('basic drawings', () {
  //   final src = cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_8UC3);
  //   cv.line(src, cv.Point(10, 10), cv.Point(90, 90), cv.Scalar.red, thickness: 2, lineType: cv.LINE_AA);
  //   cv.ellipse(src, cv.Point(50, 50), cv.Point(10, 20), 30.0, 0, 360, cv.Scalar.green);
  //   cv.rectangle(src, cv.Rect(20, 20, 30, 50), cv.Scalar.blue);
  //   final pts = [(10, 5), (20, 30), (70, 20), (50, 10)].map((e) => cv.Point(e.$1, e.$2)).toList();
  //   cv.polylines(src, [pts], false, cv.Scalar.white, thickness: 2, lineType: cv.LINE_AA);
  //   cv.putText(src, "OpenCv-Dart", cv.Point(1, 90), cv.FONT_HERSHEY_SIMPLEX, 0.4, cv.Scalar.white);
  //   cv.arrowedLine(src, cv.Point(5, 0), cv.Point(5, 10), cv.Scalar.blue);
  //   cv.circle(src, cv.Point(50, 50), 10, cv.Scalar.red);
  //   expect((src.width, src.height, src.channels), (100, 100, 3));

  //   cv.fillPoly(
  //       src,
  //       [
  //         [cv.Point(10, 10), cv.Point(10, 30), cv.Point(30, 30)]
  //       ],
  //       cv.Scalar.green);

  //   cv.imwrite("test/images_out/basic_drawings.png", src);
  // });

  // test('cv.threshold', () {
  //   final src = cv.imread(r"test/images/circles.jpg", flags: cv.IMREAD_COLOR);
  //   final dst = cv.Mat.empty();
  //   cv.threshold(src, dst, 100, 255, cv.THRESH_BINARY);
  //   expect((dst.width, dst.height, dst.channels), (src.width, src.height, src.channels));
  // });

  // test('cv.distanceTransform', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final gray = cv.Mat.empty();
  //   cv.cvtColor(img, gray, cv.COLOR_BGR2GRAY);

  //   final thres = cv.Mat.empty();
  //   cv.threshold(gray, thres, 25, 255, cv.THRESH_BINARY);

  //   final dest = cv.Mat.empty();
  //   final labels = cv.Mat.empty();
  //   cv.distanceTransform(thres, dest, labels, cv.DIST_L2, cv.DIST_MASK_3, cv.DIST_LABEL_CCOMP);
  //   expect(dest.isEmpty || dest.rows != img.rows || dest.cols != img.cols, false);
  // });

  // test('cv.boundingRect', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final (contours, _) = cv.findContours(img, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);
  //   final r = cv.boundingRect(contours[0]);
  //   expect(r.width > 0 && r.height > 0, true);
  // });

  // test('cv.boxPoints, cv.minAreaRect', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final thresImg = cv.Mat.empty();
  //   cv.threshold(img, thresImg, 25, 255, cv.THRESH_BINARY);
  //   final (contours, _) = cv.findContours(thresImg, cv.RETR_EXTERNAL, cv.CHAIN_APPROX_SIMPLE);

  //   final rect = cv.minAreaRect(contours[0]);
  //   expect(rect.width > 0 && rect.height > 0, true);

  //   final pts = cv.Mat.empty();
  //   cv.boxPoints(rect, pts);
  //   expect(pts.isEmpty, false);
  // });

  // // fitEllipse
  // test('cv.fitEllipse', () {
  //   final pv = [
  //     cv.Point(1, 1),
  //     cv.Point(0, 1),
  //     cv.Point(0, 2),
  //     cv.Point(1, 3),
  //     cv.Point(2, 3),
  //     cv.Point(4, 2),
  //     cv.Point(4, 1),
  //     cv.Point(0, 3),
  //     cv.Point(0, 2),
  //   ];
  //   final rect = cv.fitEllipse(pv);
  //   expect(rect.center.x, 2);
  //   expect(rect.center.y, 2);
  //   expect(rect.angle, closeTo(78.60807800292969, 1e-4));
  // });

  // // minEnclosingCircle
  // test('cv.minEnclosingCircle', () {
  //   final pts = [
  //     cv.Point(0, 2),
  //     cv.Point(2, 0),
  //     cv.Point(0, -2),
  //     cv.Point(-2, 0),
  //     cv.Point(1, -1),
  //   ];

  //   final (center, radius) = cv.minEnclosingCircle(pts);
  //   expect(radius, closeTo(2.0, 1e-3));
  //   expect(center.x, closeTo(0.0, 1e-3));
  //   expect(center.y, closeTo(0.0, 1e-3));
  // });

  // // pointPolygonTest
  // test('cv.pointPolygonTest', () {
  //   final tests = [
  //     ("Inside the polygon - measure=false", 1, cv.Point2f(20, 30), 1.0, false),
  //     ("Outside the polygon - measure=false", 1, cv.Point2f(5, 15), -1.0, false),
  //     ("On the polygon - measure=false", 1, cv.Point2f(10, 10), 0.0, false),
  //     ("Inside the polygon - measure=true", 1, cv.Point2f(20, 20), 10.0, true),
  //     ("Outside the polygon - measure=true", 1, cv.Point2f(5, 15), -5.0, true),
  //     ("On the polygon - measure=true", 1, cv.Point2f(10, 10), 0.0, true),
  //   ];
  //   final pts = [
  //     cv.Point(10, 10),
  //     cv.Point(10, 80),
  //     cv.Point(80, 80),
  //     cv.Point(80, 10),
  //   ];
  //   for (var t in tests) {
  //     var r = cv.pointPolygonTest(pts, t.$3, t.$5);
  //     expect(r, closeTo(t.$4, 1e-3));
  //   }
  // });

  // // connectedComponents
  // test('cv.connectedComponents', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   final dst = cv.Mat.empty();
  //   final res = cv.connectedComponents(src, dst, 8, cv.MatType.CV_32SC1.value, cv.CCL_DEFAULT);
  //   expect(dst.isEmpty, false);
  //   expect(res, greaterThan(1));
  // });

  // // connectedComponentsWithStats
  // test('cv.connectedComponentsWithStats', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   final dst = cv.Mat.empty();
  //   final stats = cv.Mat.empty();
  //   final centroids = cv.Mat.empty();
  //   final res = cv.connectedComponentsWithStats(
  //     src,
  //     dst,
  //     stats,
  //     centroids,
  //     8,
  //     cv.MatType.CV_32SC1.value,
  //     cv.CCL_DEFAULT,
  //   );
  //   expect(dst.isEmpty || stats.isEmpty || centroids.isEmpty, false);
  //   expect(res, greaterThan(1));
  // });

  // // matchTemplate
  // test('cv.matchTemplate', () {
  //   final imgScene = cv.imread("test/images/face.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect(imgScene.isEmpty, false);

  //   final imgTemplate = cv.imread("test/images/toy.jpg", flags: cv.IMREAD_GRAYSCALE);
  //   expect(imgTemplate.isEmpty, false);

  //   final result = cv.Mat.empty();
  //   cv.matchTemplate(imgScene, imgTemplate, result, cv.TM_CCOEFF_NORMED);
  //   final (_, maxConfidence, _, _) = cv.minMaxLoc(result);
  //   expect(maxConfidence, greaterThan(0.95));
  // });

  // // moments
  // test('cv.moments', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);
  //   final m = cv.moments(img);
  //   expect(m.m00, greaterThan(0));
  // });

  // // test pyrDown
  // test('cv.pyrDown, cv.pyrUp', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.pyrDown(img, dst, borderType: cv.BORDER_DEFAULT);
  //   expect(dst.isEmpty, false);

  //   final dst1 = cv.Mat.empty();
  //   cv.pyrUp(dst, dst1, borderType: cv.BORDER_DEFAULT);
  //   expect(dst1.isEmpty, false);
  // });

  // // morphologyEx
  // test('cv.morphologyEx', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   final kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));

  //   cv.morphologyEx(img, dst, cv.MORPH_OPEN, kernel);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // gaussianBlur
  // test('cv.gaussianBlur', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();

  //   cv.gaussianBlur(img, dst, (23, 23), 30, sigmaY: 30, borderType: cv.BORDER_CONSTANT);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // getGaussianKernel
  // test('cv.getGaussianKernel', () {
  //   final ketnel = cv.getGaussianKernel(1, 0.5);
  //   expect(ketnel.isEmpty, false);
  // });

  // // sobel
  // test('cv.sobel', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();

  //   cv.sobel(img, dst, cv.MatType.CV_16S, 0, 1, borderType: cv.BORDER_DEFAULT);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // spatialGradient
  // test('cv.spatialGradient', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dx = cv.Mat.empty();
  //   final dy = cv.Mat.empty();
  //   cv.spatialGradient(img, dx, dy, borderType: cv.BORDER_DEFAULT);
  //   expect(
  //       dx.isEmpty ||
  //           dy.isEmpty ||
  //           img.rows != dx.rows ||
  //           img.cols != dx.cols ||
  //           img.rows != dy.rows ||
  //           img.cols != dy.cols,
  //       false);
  // });

  // // Laplacian
  // test('cv.Laplacian', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.Laplacian(img, dst, cv.MatType.CV_16S);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // Scharr
  // test('cv.Scharr', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.Scharr(img, dst, cv.MatType.CV_16S, 1, 0);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // medianBlur
  // test('cv.medianBlur', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.medianBlur(img, dst, 3);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // Canny
  // test('cv.Canny', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.Canny(img, dst, 50, 150);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // cornerSubPix
  // test('cv.goodFeaturesToTrack, cv.cornerSubPix', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);
  //   final corners = cv.Mat.empty();
  //   cv.goodFeaturesToTrack(img, corners, 500, 0.01, 10);
  //   expect(corners.isEmpty, false);
  //   expect((corners.rows, corners.cols), (500, 1));

  //   final tc = cv.termCriteriaNew(cv.TERM_COUNT | cv.TERM_EPS, 20, 0.03);
  //   cv.cornerSubPix(img, corners, (10, 10), (-1, -1), tc);

  //   expect(corners.isEmpty, false);
  //   expect((corners.rows, corners.cols), (500, 1));
  // });

  // // grabCut
  // test('cv.grabCut', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   expect(img.type, cv.MatType.CV_8UC3);

  //   final mask = cv.Mat.zeros(img.rows, img.cols, cv.MatType.CV_8UC1);
  //   final bgdModel = cv.Mat.empty();
  //   final fgdModel = cv.Mat.empty();
  //   final r = cv.Rect(0, 0, 50, 50);
  //   cv.grabCut(img, mask, r, bgdModel, fgdModel, 1);
  //   expect(bgdModel.isEmpty, false);
  //   expect(fgdModel.isEmpty, false);
  // });

  // // HoughCircles
  // test('cv.HoughCircles', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final circles = cv.Mat.empty();
  //   cv.HoughCircles(img, circles, cv.HOUGH_GRADIENT, 5.0, 5.0);
  //   expect(circles.isEmpty, false);
  //   expect((circles.rows, circles.cols), (1, 815));
  // });

  // // HoughLines
  // test('cv.HoughLines', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final circles = cv.Mat.empty();
  //   cv.HoughLines(img, circles, 1, cv.CV_PI / 180, 50);
  //   expect(circles.isEmpty, false);
  // });

  // // HoughLinesP

  // // HoughLinesPointSet

  // // integral
  // test('cv.integral', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);

  //   final sum = cv.Mat.empty();
  //   final sqSum = cv.Mat.empty();
  //   final tilted = cv.Mat.empty();

  //   cv.integral(img, sum, sqSum, tilted);
  //   expect(sum.isEmpty || sqSum.isEmpty || tilted.isEmpty, false);
  // });

  // // adaptiveThreshold
  // test('cv.adaptiveThreshold', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final dst = cv.Mat.empty();
  //   cv.adaptiveThreshold(img, dst, 255, cv.ADAPTIVE_THRESH_MEAN_C, cv.THRESH_BINARY, 11, 2);
  //   expect(dst.isEmpty || img.rows != dst.rows || img.cols != dst.cols, false);
  // });

  // // getTextSize
  // test('cv.getTextSize', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   expect(img.isEmpty, false);

  //   final (textSize, baseline) = cv.getTextSize("Hello World", cv.FONT_HERSHEY_PLAIN, 1.0, 1);
  //   expect((textSize.$1, textSize.$2, baseline), (91, 10, 6));
  // });

  // // resize
  // test('cv.resize', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.resize(img, dst, (100, 100));
  //   expect(dst.isEmpty, false);
  //   expect((dst.rows, dst.cols), (100, 100));
  // });

  // // getRectSubPix
  // test('cv.getRectSubPix', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(img.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.getRectSubPix(img, (100, 100), cv.Point2f(200, 200), dst);
  //   expect(dst.isEmpty, false);
  //   expect((dst.rows, dst.cols), (100, 100));
  // });

  // // warpAffine
  // test('cv.getRotationMatrix2D, cv.warpAffine', () {
  //   final src = cv.Mat.zeros(256, 256, cv.MatType.CV_8UC1);
  //   final rot = cv.getRotationMatrix2D(cv.Point2f(0, 0), 1.0, 1.0);
  //   final dst = cv.Mat.empty();
  //   cv.warpAffine(src, dst, rot, (256, 256));
  //   final res = cv.norm(dst, normType: cv.NORM_L2);
  //   expect(res, closeTo(0.0, 1e-4));
  // });

  // // warpPerspective
  // test('cv.warpPerspective', () {
  //   final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(img.isEmpty, false);
  //   final pvs = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 5),
  //     cv.Point(10, 10),
  //     cv.Point(5, 10),
  //   ];

  //   final pvd = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 0),
  //     cv.Point(10, 10),
  //     cv.Point(0, 10),
  //   ];

  //   final m = cv.getPerspectiveTransform(pvs, pvd);
  //   final dst = cv.Mat.empty();
  //   cv.warpPerspective(img, dst, m, (img.width, img.height));

  //   expect((dst.rows, dst.cols), (img.rows, img.cols));
  // });

  // // watershed
  // test('cv.watershed', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);

  //   final gray = cv.Mat.empty();
  //   cv.cvtColor(src, gray, cv.COLOR_BGR2GRAY);
  //   expect(gray.isEmpty, false);

  //   final imgThresh = cv.Mat.empty();
  //   cv.threshold(gray, imgThresh, 5, 50, cv.THRESH_OTSU + cv.THRESH_BINARY);

  //   final markers = cv.Mat.empty();
  //   cv.connectedComponents(imgThresh, markers, 8, cv.MatType.CV_32SC1.value, cv.CCL_DEFAULT);
  //   cv.watershed(src, markers);
  //   expect(markers.isEmpty, false);
  //   expect((markers.rows, markers.cols), (src.rows, src.cols));
  // });

  // // applyColorMap
  // test('cv.applyColorMap', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   final dst = src.clone();
  //   cv.applyColorMap(src, dst, cv.COLORMAP_AUTUMN);
  //   expect((dst.rows, dst.cols), (src.rows, src.cols));
  // });

  // // applyCustomColorMap
  // test('cv.applyCustomColorMap', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_GRAYSCALE);
  //   final cmap = cv.Mat.zeros(256, 1, cv.MatType.CV_8UC1);
  //   final dst = src.clone();
  //   cv.applyCustomColorMap(src, dst, cmap);
  //   expect((dst.rows, dst.cols), (src.rows, src.cols));
  // });

  // // getPerspectiveTransform
  // test('cv.getPerspectiveTransform', () {
  //   final src = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 5),
  //     cv.Point(10, 10),
  //     cv.Point(5, 10),
  //   ];
  //   final dst = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 0),
  //     cv.Point(10, 10),
  //     cv.Point(0, 10),
  //   ];
  //   final m = cv.getPerspectiveTransform(src, dst);
  //   expect((m.rows, m.cols), (3, 3));
  // });

  // // getPerspectiveTransform2f
  // test('cv.getPerspectiveTransform2f', () {
  //   final src = [
  //     cv.Point2f(0, 0),
  //     cv.Point2f(10, 5),
  //     cv.Point2f(10, 10),
  //     cv.Point2f(5, 10),
  //   ];
  //   final dst = [
  //     cv.Point2f(0, 0),
  //     cv.Point2f(10, 0),
  //     cv.Point2f(10, 10),
  //     cv.Point2f(0, 10),
  //   ];
  //   final m = cv.getPerspectiveTransform2f(src, dst);
  //   expect((m.rows, m.cols), (3, 3));
  // });

  // // getAffineTransform
  // test('cv.getAffineTransform', () {
  //   final src = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 5),
  //     cv.Point(10, 10),
  //   ];

  //   final dst = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 0),
  //     cv.Point(10, 10),
  //   ];
  //   final m = cv.getAffineTransform(src, dst);
  //   expect((m.rows, m.cols), (2, 3));
  // });

  // // getAffineTransform2f
  // test('cv.getAffineTransform2f', () {
  //   final src = [
  //     cv.Point2f(0, 0),
  //     cv.Point2f(10, 5),
  //     cv.Point2f(10, 10),
  //   ];

  //   final dst = [
  //     cv.Point2f(0, 0),
  //     cv.Point2f(10, 0),
  //     cv.Point2f(10, 10),
  //   ];
  //   final m = cv.getAffineTransform2f(src, dst);
  //   expect((m.rows, m.cols), (2, 3));
  // });

  // // findHomography
  // // test('cv.findHomography', () {
  // //   final src = cv.Mat.zeros(4, 2, cv.MatType.CV_64FC1);
  // //   final dst = cv.Mat.zeros(4, 2, cv.MatType.CV_64FC2);
  // //   final srcPts = [
  // //     cv.Point(193, 932),
  // //     cv.Point(191, 378),
  // //     cv.Point(1497, 183),
  // //     cv.Point(1889, 681),
  // //   ];
  // //   final dstPts = [
  // //     cv.Point2f(51.51206544281359, -0.10425475260813055),
  // //     cv.Point2f(51.51211051314331, -0.10437947532732306),
  // //     cv.Point2f(51.512222354139325, -0.10437679311830816),
  // //     cv.Point2f(51.51214828037607, -0.1042212249954444),
  // //   ];
  // //   List.generate(srcPts.length, (index) => index).forEach((i) {
  // //     src.setValue<double>(i, 0, srcPts[i].x.toDouble());
  // //     src.setValue<double>(i, 1, srcPts[i].y.toDouble());
  // //   });
  // //   List.generate(dstPts.length, (index) => index).forEach((i) {
  // //     dst.setValue<double>(i, 0, dstPts[i].x.toDouble());
  // //     dst.setValue<double>(i, 1, dstPts[i].y.toDouble());
  // //   });

  // //   final mask = cv.Mat.empty();
  // //   final m = cv.findHomography(
  // //     src,
  // //     dst,
  // //     method: cv.HOMOGRAPY_ALL_POINTS,
  // //     ransacReprojThreshold: 3,
  // //     mask: mask,
  // //   );
  // //   expect(m.isEmpty, false);
  // // });

  // // remap
  // test('cv.remap', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   final map1 = cv.Mat.zeros(256, 256, cv.MatType.CV_16SC2);
  //   map1.setValue<int>(50, 50, 25);
  //   final map2 = cv.Mat.empty();
  //   cv.remap(src, dst, map1, map2, cv.INTER_LINEAR, borderValue: cv.Scalar.black);
  //   expect(dst.isEmpty, false);
  // });

  // // filter2D
  // test('cv.filter2D', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   final kernel = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
  //   cv.filter2D(src, dst, -1, kernel);
  //   expect(dst.isEmpty, false);
  // });

  // // sepFilter2D
  // test('cv.sepFilter2D', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   final kernelX = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
  //   final kernelY = cv.getStructuringElement(cv.MORPH_RECT, (1, 1));
  //   cv.sepFilter2D(src, dst, -1, kernelX, kernelY, anchor: cv.Point(-1, -1), delta: 0);
  //   expect(dst.isEmpty, false);
  // });

  // // logPolar
  // test('cv.logPolar', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.logPolar(src, dst, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
  //   expect(dst.isEmpty, false);
  // });

  // // linearPolar
  // test('cv.linearPolar', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_UNCHANGED);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.empty();
  //   cv.linearPolar(src, dst, cv.Point2f(21, 21), 1, cv.INTER_LINEAR);
  //   expect(dst.isEmpty, false);
  // });

  // // fitLine
  // test('cv.fitLine', () {
  //   final pts = [
  //     cv.Point(125, 24),
  //     cv.Point(124, 75),
  //     cv.Point(175, 76),
  //     cv.Point(176, 25),
  //   ];
  //   final dst = cv.Mat.empty();
  //   cv.fitLine(pts, dst, cv.DIST_L2, 0, 0.01, 0.01);
  //   expect(dst.isEmpty, false);
  // });

  // // matchShapes
  // test('cv.matchShapes', () {
  //   final pts1 = [
  //     cv.Point(0, 0),
  //     cv.Point(1, 0),
  //     cv.Point(2, 2),
  //     cv.Point(3, 3),
  //     cv.Point(3, 4),
  //   ];
  //   final pts2 = [
  //     cv.Point(0, 0),
  //     cv.Point(1, 0),
  //     cv.Point(2, 3),
  //     cv.Point(3, 3),
  //     cv.Point(3, 5),
  //   ];
  //   final similarity = cv.matchShapes(pts1, pts2, cv.CONTOURS_MATCH_I2, 0);
  //   expect(2.0 <= similarity && similarity <= 3.0, true);
  // });

  // test('cv.invertAffineTransform', () {
  //   final src = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 5),
  //     cv.Point(10, 10),
  //   ];

  //   final dst = [
  //     cv.Point(0, 0),
  //     cv.Point(10, 0),
  //     cv.Point(10, 10),
  //   ];
  //   final m = cv.getAffineTransform(src, dst);
  //   final inv = cv.invertAffineTransform(m);
  //   expect(inv.isEmpty, false);
  //   expect((inv.rows, inv.cols), (2, 3));
  // });

  // // accumulate
  // test('cv.accumulate', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
  //   final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
  //   cv.accumulate(src, dst, mask: mask);
  //   expect(dst.isEmpty, false);
  // });

  // // accumulateSquare
  // test('cv.accumulateSquare', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
  //   final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
  //   cv.accumulateSquare(src, dst, mask: mask);
  //   expect(dst.isEmpty, false);
  // });

  // // accumulateProduct
  // test('cv.accumulateProduct', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(src.isEmpty, false);
  //   final src2 = src.clone();
  //   final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
  //   final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
  //   cv.accumulateProduct(src, src2, dst, mask: mask);
  //   expect(dst.isEmpty, false);
  // });

  // // accumulateWeighted
  // test('cv.accumulateWeighted', () {
  //   final src = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  //   expect(src.isEmpty, false);
  //   final dst = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_64FC3);
  //   final mask = cv.Mat.zeros(src.rows, src.cols, cv.MatType.CV_8UC1);
  //   cv.accumulateWeighted(src, dst, 0.1, mask: mask);
  //   expect(dst.isEmpty, false);
  // });

  // test("Issue 8", () {
  //   cv.Mat mask = cv.Mat.ones(512, 512, cv.MatType.CV_32FC1);

  //   List<cv.Point2f> faceTemplate = [
  //     cv.Point2f(192.98138, 239.94708),
  //     cv.Point2f(318.90277, 240.1936),
  //     cv.Point2f(256.63416, 314.01935),
  //     cv.Point2f(201.26117, 371.41043),
  //     cv.Point2f(314.08905, 371.15118)
  //   ];

  //   List<cv.Point2f> landmarks = [
  //     cv.Point2f(916.1744018554688, 436.8168579101563),
  //     cv.Point2f(1179.1181030273438, 448.0384765625),
  //     cv.Point2f(1039.171106147766, 604.8748825073242),
  //     cv.Point2f(908.7911743164062, 683.4760314941407),
  //     cv.Point2f(1167.2201416015625, 693.495068359375),
  //   ];

  //   var (affineMatrix, _) = cv.estimateAffinePartial2D(landmarks, faceTemplate, method: cv.LMEDS);

  //   var invMask = cv.Mat.empty();
  //   cv.warpAffine(mask, invMask, affineMatrix, (2048, 2048));

  //   for (int i = 0; i < 2047; i++) {
  //     for (int j = 0; j < 2047; j++) {
  //       var val = invMask.at<double>(i, j);
  //       expect(val == 0 || val == 1, true);
  //     }
  //   }
  // });
}
