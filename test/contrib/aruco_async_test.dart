// ignore_for_file: constant_identifier_names
import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

const arucoImage6x6_250 = "test/images/aruco_6X6_250_6.png";
const arucoImage6x6_250_contour = "test/images/aruco_6X6_250_6_contour.png";
const arucoImage6x6_250_1 = "test/images/aruco_6X6_250_1.png";

void main() async {
  test('cv.ArucoDetector', () async {
    final img = cv.imread(arucoImage6x6_250);
    expect(img.isEmpty, false);

    final dict =
        cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final params = await cv.ArucoDetectorParametersAsync.emptyAsync();
    final detector = await cv.ArucoDetectorAsync.createAsync(dict, params);

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

    final dict =
        cv.ArucoDictionary.predefined(cv.PredefinedDictionaryType.DICT_6X6_250);
    final params = await cv.ArucoDetectorParametersAsync.emptyAsync();
    final detector = await cv.ArucoDetectorAsync.createAsync(dict, params);

    final (corners, ids, _) = await detector.detectMarkersAsync(img);
    expect(corners.length, greaterThan(0));
    await cv.arucoDrawDetectedMarkersAsync(
        img, corners, ids, cv.Scalar(200, 0, 0, 0),);
    var diff = cv.Mat.empty();
    cv.absDiff(img, imgExpected, diff);
    diff = cv.cvtColor(diff, cv.COLOR_BGR2GRAY);
    expect(cv.countNonZero(diff), 0);
  });

  test('cv.arucoGenerateImageMarker', () async {
    final imgExpected =
        cv.imread(arucoImage6x6_250_1, flags: cv.IMREAD_GRAYSCALE);
    expect(imgExpected.isEmpty, false);

    final img = cv.Mat.empty();
    await cv.arucoGenerateImageMarkerAsync(
        cv.PredefinedDictionaryType.DICT_6X6_250, 1, 200, img, 1,);

    final diff = cv.Mat.empty();
    cv.absDiff(img, imgExpected, diff);
    expect(cv.countNonZero(diff), 0);
  });

  test('cv.ArucoDetectorParameters', () async {
    const int adaptiveThreshWinSizeMin = 4;
    const int adaptiveThreshWinSizeMax = 22;
    const int adaptiveThreshWinSizeStep = 1;
    const double adaptiveThreshConstant = 1.0;
    const double minMarkerPerimeterRate = 0.2;
    const double maxMarkerPerimeterRate = 0.5;
    const double polygonalApproxAccuracyRate = 1.0;
    const double minCornerDistanceRate = 0.1;
    const int minDistanceToBorder = 0;
    const double minMarkerDistanceRate = 1.0;
    const int cornerRefinementMethod = 1;
    const int cornerRefinementWinSize = 1;
    const int cornerRefinementMaxIterations = 1;
    const double cornerRefinementMinAccuracy = 0.5;
    const int markerBorderBits = 1;
    const int perspectiveRemovePixelPerCell = 1;
    const double perspectiveRemoveIgnoredMarginPerCell = 1.0;
    const double maxErroneousBitsInBorderRate = 0.5;
    const double minOtsuStdDev = .5;
    const double errorCorrectionRate = 0.2;
    const double aprilTagQuadDecimate = 0.5;
    const double aprilTagQuadSigma = 1;
    const int aprilTagMinClusterPixels = 1;
    const int aprilTagMaxNmaxima = 1;
    const double aprilTagCriticalRad = 0.2;
    const double aprilTagMaxLineFitMse = 0.2;
    const int aprilTagMinWhiteBlackDiff = 1;
    const int aprilTagDeglitch = 1;
    const bool detectInvertedMarker = false;

    final params = await cv.ArucoDetectorParametersAsync.emptyAsync();
    await params.setAdaptiveThreshWinSizeMinAsync(adaptiveThreshWinSizeMin);
    await params.setAdaptiveThreshWinSizeMaxAsync(adaptiveThreshWinSizeMax);
    await params.setAdaptiveThreshWinSizeStepAsync(adaptiveThreshWinSizeStep);
    await params.setAdaptiveThreshConstantAsync(adaptiveThreshConstant);
    await params.setMinMarkerPerimeterRateAsync(minMarkerPerimeterRate);
    await params.setMaxMarkerPerimeterRateAsync(maxMarkerPerimeterRate);
    await params
        .setPolygonalApproxAccuracyRateAsync(polygonalApproxAccuracyRate);
    await params.setMinCornerDistanceRateAsync(minCornerDistanceRate);
    await params.setMinDistanceToBorderAsync(minDistanceToBorder);
    await params.setMinMarkerDistanceRateAsync(minMarkerDistanceRate);
    await params.setCornerRefinementMethodAsync(cornerRefinementMethod);
    await params.setCornerRefinementWinSizeAsync(cornerRefinementWinSize);
    await params
        .setCornerRefinementMaxIterationsAsync(cornerRefinementMaxIterations);
    await params
        .setCornerRefinementMinAccuracyAsync(cornerRefinementMinAccuracy);
    await params.setMarkerBorderBitsAsync(markerBorderBits);
    await params
        .setPerspectiveRemovePixelPerCellAsync(perspectiveRemovePixelPerCell);
    await params.setPerspectiveRemoveIgnoredMarginPerCellAsync(
        perspectiveRemoveIgnoredMarginPerCell,);
    await params
        .setMaxErroneousBitsInBorderRateAsync(maxErroneousBitsInBorderRate);
    await params.setMinOtsuStdDevAsync(minOtsuStdDev);
    await params.setErrorCorrectionRateAsync(errorCorrectionRate);
    await params.setAprilTagQuadDecimateAsync(aprilTagQuadDecimate);
    await params.setAprilTagQuadSigmaAsync(aprilTagQuadSigma);
    await params.setAprilTagMinClusterPixelsAsync(aprilTagMinClusterPixels);
    await params.setAprilTagMaxNmaximaAsync(aprilTagMaxNmaxima);
    await params.setAprilTagCriticalRadAsync(aprilTagCriticalRad);
    await params.setAprilTagMaxLineFitMseAsync(aprilTagMaxLineFitMse);
    await params.setAprilTagMinWhiteBlackDiffAsync(aprilTagMinWhiteBlackDiff);
    await params.setAprilTagDeglitchAsync(aprilTagDeglitch);
    await params.setDetectInvertedMarkerAsync(detectInvertedMarker);

    expect(
        await params.adaptiveThreshWinSizeMinAsync, adaptiveThreshWinSizeMin,);
    expect(
        await params.adaptiveThreshWinSizeMaxAsync, adaptiveThreshWinSizeMax,);
    expect(
        await params.adaptiveThreshWinSizeStepAsync, adaptiveThreshWinSizeStep,);
    expect(await params.adaptiveThreshConstantAsync,
        closeTo(adaptiveThreshConstant, 1e-4),);
    expect(await params.minMarkerPerimeterRateAsync,
        closeTo(minMarkerPerimeterRate, 1e-4),);
    expect(await params.maxMarkerPerimeterRateAsync,
        closeTo(maxMarkerPerimeterRate, 1e-4),);
    expect(await params.polygonalApproxAccuracyRateAsync,
        closeTo(polygonalApproxAccuracyRate, 1e-4),);
    expect(await params.minCornerDistanceRateAsync,
        closeTo(minCornerDistanceRate, 1e-4),);
    expect(await params.minDistanceToBorderAsync, minDistanceToBorder);
    expect(await params.minMarkerDistanceRateAsync,
        closeTo(minMarkerDistanceRate, 1e-4),);
    expect(await params.cornerRefinementMethodAsync, cornerRefinementMethod);
    expect(await params.cornerRefinementWinSizeAsync, cornerRefinementWinSize);
    expect(await params.cornerRefinementMaxIterationsAsync,
        cornerRefinementMaxIterations,);
    expect(await params.cornerRefinementMinAccuracyAsync,
        closeTo(cornerRefinementMinAccuracy, 1e-4),);
    expect(await params.markerBorderBitsAsync, markerBorderBits);
    expect(await params.perspectiveRemovePixelPerCellAsync,
        perspectiveRemovePixelPerCell,);
    expect(await params.perspectiveRemoveIgnoredMarginPerCellAsync,
        closeTo(perspectiveRemoveIgnoredMarginPerCell, 1e-4),);
    expect(await params.maxErroneousBitsInBorderRateAsync,
        closeTo(maxErroneousBitsInBorderRate, 1e-4),);
    expect(await params.minOtsuStdDevAsync, closeTo(minOtsuStdDev, 1e-4));
    expect(await params.errorCorrectionRateAsync,
        closeTo(errorCorrectionRate, 1e-4),);
    expect(await params.aprilTagQuadDecimateAsync,
        closeTo(aprilTagQuadDecimate, 1e-4),);
    expect(
        await params.aprilTagQuadSigmaAsync, closeTo(aprilTagQuadSigma, 1e-4),);
    expect(
        await params.aprilTagMinClusterPixelsAsync, aprilTagMinClusterPixels,);
    expect(await params.aprilTagMaxNmaximaAsync, aprilTagMaxNmaxima);
    expect(await params.aprilTagCriticalRadAsync,
        closeTo(aprilTagCriticalRad, 1e-4),);
    expect(await params.aprilTagMaxLineFitMseAsync,
        closeTo(aprilTagMaxLineFitMse, 1e-4),);
    expect(await params.aprilTagMinWhiteBlackDiffAsync,
        closeTo(aprilTagMinWhiteBlackDiff, 1e-4),);
    expect(await params.aprilTagDeglitchAsync, aprilTagDeglitch);
    expect(await params.detectInvertedMarkerAsync, detectInvertedMarker);

    expect(params, isA<cv.ArucoDetectorParameters>());
  });
}
