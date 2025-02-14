// ignore_for_file: constant_identifier_names
import 'package:dartcv4/dartcv.dart' as cv;
import 'package:test/test.dart';

const arucoImage6x6_250 = "test/images/aruco_6X6_250_6.png";
const arucoImage6x6_250_contour = "test/images/aruco_6X6_250_6_contour.png";
const arucoImage6x6_250_1 = "test/images/aruco_6X6_250_1.png";

void main() async {
  test('cv.ArucoDetector', () async {
    final img = cv.imread(arucoImage6x6_250);
    expect(img.isEmpty, false);

    final dict = cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final params = cv.ArucoDetectorParameters.empty();
    final detector = cv.ArucoDetector.create(dict, params);

    final (_, ids, _) = await detector.detectMarkersAsync(img);
    expect(ids, isNotEmpty);

    dict.dispose();
    params.dispose();
    img.dispose();
    detector.dispose();
  });

  test('cv.arucoDrawDetectedMarkers', () async {
    final img = cv.imread(arucoImage6x6_250);
    expect(img.isEmpty, false);
    final imgExpected = cv.imread(arucoImage6x6_250_contour);
    expect(imgExpected.isEmpty, false);

    final dict = cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final params = cv.ArucoDetectorParameters.empty();
    final detector = cv.ArucoDetector.create(dict, params);

    final (corners, ids, _) = await detector.detectMarkersAsync(img);
    expect(corners.length, greaterThan(0));
    await cv.arucoDrawDetectedMarkersAsync(img, corners, ids, cv.Scalar(200, 0, 0, 0));
    var diff = cv.Mat.empty();
    cv.absDiff(img, imgExpected, dst: diff);
    diff = cv.cvtColor(diff, cv.COLOR_BGR2GRAY);
    expect(cv.countNonZero(diff), 0);
  });

  test('cv.arucoGenerateImageMarker', () async {
    final imgExpected = cv.imread(arucoImage6x6_250_1, flags: cv.IMREAD_GRAYSCALE);
    expect(imgExpected.isEmpty, false);

    final img = await cv.arucoGenerateImageMarkerAsync(cv.PredefinedDictionaryType.DICT_6X6_250, 1, 200, 1);

    final diff = cv.Mat.empty();
    cv.absDiff(img, imgExpected, dst: diff);
    expect(cv.countNonZero(diff), 0);
  });
}
