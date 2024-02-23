// @Skip()
import 'package:test/test.dart';

import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() async {
  // String libPath = Platform.environment["OPENCV_DART_LIB_DIR"] ?? ".";
  // late CvNative _bindings;
  // setUp(() {
  //   // Directory.current = Directory(libPath);
  // });
  // setUpAll(() {
  //   _bindings = CvNative(DynamicLibrary.open("libopencv_dart.dll"));
  // });
  // tearDown(() => null);

  test("cv2.approxPolyDP", () {
    final img =
        cv.Mat.create(cols: 100, rows: 200, type: cv.MatType.CV_8UC1);
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
    final length = cv.arcLength(contours[0], true);
    final triangleContour = cv.approxPolyDP(contours[0], 0.04 * length, true);
    final expected = <cv.Point>[
      cv.Point(25, 25),
      cv.Point(25, 75),
      cv.Point(75, 50)
    ];
    expect(triangleContour.length, equals(expected.length));
    expect(
        List.generate(expected.length,
                (index) => triangleContour[index] == expected[index])
            .every((element) => element),
        equals(true));
  });

  test("cv2.findContours, cv.drawContours", () {
    final src = cv.imread("test/_data/image/markers_6x6_250.png",
        flags: cv.IMREAD_GRAYSCALE);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    cv.bitwise_not(src, src);
    expect((src.width, src.height, src.channels), (612, 760, 1));
    var (cv.Contours? contours, hierarchy) = cv.findContours(
      src,
      cv.RETR_EXTERNAL,
      cv.CHAIN_APPROX_SIMPLE,
    );
    expect(contours.length, greaterThan(0));
    expect(hierarchy.isEmpty, equals(false));
    expect(
      List.generate(contours.length, (index) => contours[index].length)
          .every((element) => element == 4),
      equals(true),
    );

    // draw
    final canvas = src.clone();
    cv.cvtColor(src, canvas, cv.COLOR_GRAY2BGR);
    cv.drawContours(canvas, contours, -1, cv.Scalar.red, thickness: 2);
    final success =
        cv.imwrite("test/images_out/markers_6x6_250_contours.png", canvas);
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
    final cvImage = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_COLOR);
    final gray = cv.Mat.empty();
    cv.cvtColor(cvImage, gray, cv.COLOR_BGR2GRAY);
    expect((gray.width, gray.height, gray.channels), (512, 512, 1));
    expect(cv.imwrite("test/images_out/test_cvtcolor.png", gray), true);
  });

  test("cv2.equalizeHist", () async {
    final cvImage = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_GRAYSCALE);
    expect((cvImage.width, cvImage.height), (512, 512));
    final imgNew = cv.Mat.empty();
    cv.equalizeHist(cvImage, imgNew);
    expect((cvImage.width, cvImage.height, cvImage.channels),
        (imgNew.width, imgNew.height, imgNew.channels));
    expect(cv.imwrite("test/images_out/circles_equalized.jpg", imgNew),
        equals(true));
  });

  test("cv2.calcHist", () async {
    final src = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_GRAYSCALE);
    final hist = cv.Mat.empty();
    final mask = cv.Mat.empty();
    cv.calcHist([src], [0], mask, hist, [256], [0.0, 256.0]);
    expect(
        hist.height == 256 && hist.width == 1 && !hist.isEmpty, equals(true));
  });

  test('cv.erode', () {
    final src = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_GRAYSCALE);
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (width: 3, height: 3),
    );
    final dst = cv.Mat.empty();
    cv.erode(src, dst, kernel);
    expect((dst.width, dst.height, dst.channels),
        (src.width, src.height, src.channels));
  });

  test('cv.dilate', () {
    final src = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_GRAYSCALE);
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (width: 3, height: 3),
    );
    final dst = cv.Mat.empty();
    cv.dilate(src, dst, kernel);
    expect((dst.width, dst.height, dst.channels),
        (src.width, src.height, src.channels));
  });

  // cv.contourArea
  test('cv.contourArea', () {
    final contour = <cv.Point>[
      cv.Point(0, 0),
      cv.Point(100, 0),
      cv.Point(100, 100),
      cv.Point(0, 100),
    ];
    expect(cv.contourArea(contour), equals(10000));
  });

  test('cv.getStructuringElement', () {
    final kernel = cv.getStructuringElement(
      cv.MORPH_RECT,
      (width: 3, height: 3),
    );
    expect(kernel.height == 3 && kernel.width == 3 && !kernel.isEmpty,
        equals(true));
  });

  test('basic drawings', () {
    final src =
        cv.Mat.create(cols: 100, rows: 100, type: cv.MatType.CV_8UC3);
    cv.line(src, cv.Point(10, 10), cv.Point(90, 90), cv.Scalar.red, thickness: 2, lineType: cv.LINE_AA);
    cv.ellipse(src, cv.Point(50, 50), cv.Point(10, 20), 30.0, 0, 360, cv.Scalar.green);
    cv.rectangle(src, cv.Rect(20, 20, 30, 50), cv.Scalar.blue);
    final pts = [(10, 5), (20,30), (70, 20), (50, 10)].map((e) => cv.Point(e.$1, e.$2)).toList();
    cv.polylines(src, [pts], false, cv.Scalar.white, thickness: 2, lineType: cv.LINE_AA);
    cv.putText(src, "OpenCv-Dart", cv.Point(1, 90), cv.FONT_HERSHEY_SIMPLEX, 0.4, cv.Scalar.white);
    expect((src.width, src.height, src.channels), (100, 100, 3));
    
    cv.imwrite("test/images_out/basic_drawings.png", src);
  });

  test('cv.threshold', () {
    final src = cv.imread(r"test/images/circles.jpg",
        flags: cv.IMREAD_COLOR);
    final dst = cv.Mat.empty();
    cv.threshold(src, dst, 100, 255, cv.THRESH_BINARY);
    expect((dst.width, dst.height, dst.channels),
        (src.width, src.height, src.channels));
  });
}
