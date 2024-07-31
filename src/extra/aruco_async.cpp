#include "aruco_async.h"
#include "core/types.h"
#include "core/vec.hpp"

// Asynchronous functions for ArucoDetectorParameters
CvStatus *ArucoDetectorParameters_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  auto params = new cv::aruco::DetectorParameters();
  callback(new ArucoDetectorParameters{params});
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin_Async(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeMin, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeMin = adaptiveThreshWinSizeMin;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->adaptiveThreshWinSizeMin;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax_Async(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeMax, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeMax = adaptiveThreshWinSizeMax;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->adaptiveThreshWinSizeMax;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep_Async(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeStep, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeStep = adaptiveThreshWinSizeStep;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->adaptiveThreshWinSizeStep;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAdaptiveThreshConstant_Async(
    ArucoDetectorParameters ap, double adaptiveThreshConstant, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshConstant = adaptiveThreshConstant;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAdaptiveThreshConstant_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->adaptiveThreshConstant;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMinMarkerPerimeterRate_Async(
    ArucoDetectorParameters ap, double minMarkerPerimeterRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->minMarkerPerimeterRate = minMarkerPerimeterRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMinMarkerPerimeterRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->minMarkerPerimeterRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMaxMarkerPerimeterRate_Async(
    ArucoDetectorParameters ap, double maxMarkerPerimeterRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->maxMarkerPerimeterRate = maxMarkerPerimeterRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMaxMarkerPerimeterRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->maxMarkerPerimeterRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetPolygonalApproxAccuracyRate_Async(
    ArucoDetectorParameters ap, double polygonalApproxAccuracyRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->polygonalApproxAccuracyRate = polygonalApproxAccuracyRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetPolygonalApproxAccuracyRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->polygonalApproxAccuracyRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMinCornerDistanceRate_Async(
    ArucoDetectorParameters ap, double minCornerDistanceRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->minCornerDistanceRate = minCornerDistanceRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMinCornerDistanceRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->minCornerDistanceRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMinDistanceToBorder_Async(
    ArucoDetectorParameters ap, int minDistanceToBorder, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->minDistanceToBorder = minDistanceToBorder;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMinDistanceToBorder_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->minDistanceToBorder;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMinMarkerDistanceRate_Async(
    ArucoDetectorParameters ap, double minMarkerDistanceRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->minMarkerDistanceRate = minMarkerDistanceRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMinMarkerDistanceRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->minMarkerDistanceRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetCornerRefinementMethod_Async(
    ArucoDetectorParameters ap, int cornerRefinementMethod, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMethod = cornerRefinementMethod;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetCornerRefinementMethod_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->cornerRefinementMethod;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetCornerRefinementWinSize_Async(
    ArucoDetectorParameters ap, int cornerRefinementWinSize, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementWinSize = cornerRefinementWinSize;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetCornerRefinementWinSize_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->cornerRefinementWinSize;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetCornerRefinementMaxIterations_Async(
    ArucoDetectorParameters ap, int cornerRefinementMaxIterations, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMaxIterations = cornerRefinementMaxIterations;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetCornerRefinementMaxIterations_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->cornerRefinementMaxIterations;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetCornerRefinementMinAccuracy_Async(
    ArucoDetectorParameters ap, double cornerRefinementMinAccuracy, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMinAccuracy = cornerRefinementMinAccuracy;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetCornerRefinementMinAccuracy_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->cornerRefinementMinAccuracy;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMarkerBorderBits_Async(
    ArucoDetectorParameters ap, int markerBorderBits, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->markerBorderBits = markerBorderBits;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMarkerBorderBits_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->markerBorderBits;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell_Async(
    ArucoDetectorParameters ap, int perspectiveRemovePixelPerCell, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->perspectiveRemovePixelPerCell = perspectiveRemovePixelPerCell;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->perspectiveRemovePixelPerCell;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell_Async(
    ArucoDetectorParameters ap, double perspectiveRemoveIgnoredMarginPerCell, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->perspectiveRemoveIgnoredMarginPerCell = perspectiveRemoveIgnoredMarginPerCell;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->perspectiveRemoveIgnoredMarginPerCell;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate_Async(
    ArucoDetectorParameters ap, double maxErroneousBitsInBorderRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->maxErroneousBitsInBorderRate = maxErroneousBitsInBorderRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->maxErroneousBitsInBorderRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetMinOtsuStdDev_Async(
    ArucoDetectorParameters ap, double minOtsuStdDev, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->minOtsuStdDev = minOtsuStdDev;
  callback();
  END_WRAP
}

CvStatus *
ArucoDetectorParameters_GetMinOtsuStdDev_Async(ArucoDetectorParameters ap, CvCallback_1 callback) {
  BEGIN_WRAP
  double value = ap.ptr->minOtsuStdDev;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetErrorCorrectionRate_Async(
    ArucoDetectorParameters ap, double errorCorrectionRate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->errorCorrectionRate = errorCorrectionRate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetErrorCorrectionRate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  double value = ap.ptr->errorCorrectionRate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagQuadDecimate_Async(
    ArucoDetectorParameters ap, float aprilTagQuadDecimate, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagQuadDecimate = aprilTagQuadDecimate;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagQuadDecimate_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  float value = ap.ptr->aprilTagQuadDecimate;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagQuadSigma_Async(
    ArucoDetectorParameters ap, float aprilTagQuadSigma, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagQuadSigma = aprilTagQuadSigma;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagQuadSigma_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  float value = ap.ptr->aprilTagQuadSigma;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagMinClusterPixels_Async(
    ArucoDetectorParameters ap, int aprilTagMinClusterPixels, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMinClusterPixels = aprilTagMinClusterPixels;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagMinClusterPixels_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->aprilTagMinClusterPixels;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagMaxNmaxima_Async(
    ArucoDetectorParameters ap, int aprilTagMaxNmaxima, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMaxNmaxima = aprilTagMaxNmaxima;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagMaxNmaxima_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->aprilTagMaxNmaxima;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagCriticalRad_Async(
    ArucoDetectorParameters ap, float aprilTagCriticalRad, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagCriticalRad = aprilTagCriticalRad;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagCriticalRad_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  float value = ap.ptr->aprilTagCriticalRad;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagMaxLineFitMse_Async(
    ArucoDetectorParameters ap, float aprilTagMaxLineFitMse, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMaxLineFitMse = aprilTagMaxLineFitMse;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagMaxLineFitMse_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  float value = ap.ptr->aprilTagMaxLineFitMse;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff_Async(
    ArucoDetectorParameters ap, int aprilTagMinWhiteBlackDiff, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMinWhiteBlackDiff = aprilTagMinWhiteBlackDiff;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->aprilTagMinWhiteBlackDiff;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetAprilTagDeglitch_Async(
    ArucoDetectorParameters ap, int aprilTagDeglitch, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->aprilTagDeglitch = aprilTagDeglitch;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetAprilTagDeglitch_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  int value = ap.ptr->aprilTagDeglitch;
  callback(&value);
  END_WRAP
}

CvStatus *ArucoDetectorParameters_SetDetectInvertedMarker_Async(
    ArucoDetectorParameters ap, bool detectInvertedMarker, CvCallback_0 callback
) {
  BEGIN_WRAP
  ap.ptr->detectInvertedMarker = detectInvertedMarker;
  callback();
  END_WRAP
}

CvStatus *ArucoDetectorParameters_GetDetectInvertedMarker_Async(
    ArucoDetectorParameters ap, CvCallback_1 callback
) {
  BEGIN_WRAP
  bool value = ap.ptr->detectInvertedMarker;
  callback(&value);
  END_WRAP
}

// Detector
CvStatus *ArucoDetector_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  auto detector = new cv::aruco::ArucoDetector();
  callback(new ArucoDetector{detector});
  END_WRAP
}

CvStatus *ArucoDetector_NewWithParams_Async(
    ArucoDictionary dictionary, ArucoDetectorParameters params, CvCallback_1 callback
) {
  BEGIN_WRAP
  auto detector = new cv::aruco::ArucoDetector(*dictionary.ptr, *params.ptr);
  callback(new ArucoDetector{detector});
  END_WRAP
}

CvStatus *ArucoDetector_DetectMarkers_Async(ArucoDetector ad, Mat inputArr, CvCallback_3 callback) {
  BEGIN_WRAP
  std::vector<std::vector<cv::Point2f>> markerCorners;
  std::vector<int> markerIds;
  std::vector<std::vector<cv::Point2f>> rejectedCandidates;
  ad.ptr->detectMarkers(*inputArr.ptr, markerCorners, markerIds, rejectedCandidates);
  callback(
      vecvecpoint2f_cpp2c_p(markerCorners),
      vecint_cpp2c_p(markerIds),
      vecvecpoint2f_cpp2c_p(rejectedCandidates)
  );
  END_WRAP
}

// Utility Functions
CvStatus *ArucoDrawDetectedMarkers_Async(
    Mat image,
    VecVecPoint2f markerCorners,
    VecI32 markerIds,
    Scalar borderColor,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::Scalar _borderColor = cv::Scalar(borderColor.val1, borderColor.val2, borderColor.val3);
  auto _markerCorners = vecvecpoint2f_c2cpp(markerCorners);
  auto _markerIds = vecint_c2cpp(markerIds);
  cv::aruco::drawDetectedMarkers(*image.ptr, _markerCorners, _markerIds, _borderColor);
  callback();
  END_WRAP
}

CvStatus *ArucoGenerateImageMarker_Async(
    int dictionaryId, int id, int sidePixels, int borderBits, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::aruco::Dictionary dict = cv::aruco::getPredefinedDictionary(dictionaryId);
  cv::Mat dst;
  cv::aruco::generateImageMarker(dict, id, sidePixels, dst, borderBits);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *getPredefinedDictionary_Async(int dictionaryId, CvCallback_1 callback) {
  BEGIN_WRAP
  auto dict = new cv::aruco::Dictionary(cv::aruco::getPredefinedDictionary(dictionaryId));
  callback(new ArucoDictionary{dict});
  END_WRAP
}
