/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#include "aruco.h"
#include "core/vec.hpp"

CvStatus *ArucoDetectorParameters_Create(ArucoDetectorParameters *rval) {
  BEGIN_WRAP
  *rval = {new cv::aruco::DetectorParameters()};
  END_WRAP
}
void ArucoDetectorParameters_Close(ArucoDetectorParametersPtr ap) { CVD_FREE(ap); }

CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeMin
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeMin = adaptiveThreshWinSizeMin;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->adaptiveThreshWinSizeMin;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeMax
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeMax = adaptiveThreshWinSizeMax;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->adaptiveThreshWinSizeMax;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(
    ArucoDetectorParameters ap, int adaptiveThreshWinSizeStep
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshWinSizeStep = adaptiveThreshWinSizeStep;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->adaptiveThreshWinSizeStep;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshConstant(
    ArucoDetectorParameters ap, double adaptiveThreshConstant
) {
  BEGIN_WRAP
  ap.ptr->adaptiveThreshConstant = adaptiveThreshConstant;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAdaptiveThreshConstant(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->adaptiveThreshConstant;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMinMarkerPerimeterRate(
    ArucoDetectorParameters ap, double minMarkerPerimeterRate
) {
  BEGIN_WRAP
  ap.ptr->minMarkerPerimeterRate = minMarkerPerimeterRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetMinMarkerPerimeterRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->minMarkerPerimeterRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMaxMarkerPerimeterRate(
    ArucoDetectorParameters ap, double maxMarkerPerimeterRate
) {
  BEGIN_WRAP
  ap.ptr->maxMarkerPerimeterRate = maxMarkerPerimeterRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetMaxMarkerPerimeterRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->maxMarkerPerimeterRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(
    ArucoDetectorParameters ap, double polygonalApproxAccuracyRate
) {
  BEGIN_WRAP
  ap.ptr->polygonalApproxAccuracyRate = polygonalApproxAccuracyRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->polygonalApproxAccuracyRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMinCornerDistanceRate(
    ArucoDetectorParameters ap, double minCornerDistanceRate
) {
  BEGIN_WRAP
  ap.ptr->minCornerDistanceRate = minCornerDistanceRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetMinCornerDistanceRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->minCornerDistanceRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMinDistanceToBorder(
    ArucoDetectorParameters ap, int minDistanceToBorder
) {
  BEGIN_WRAP
  ap.ptr->minDistanceToBorder = minDistanceToBorder;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetMinDistanceToBorder(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->minDistanceToBorder;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMinMarkerDistanceRate(
    ArucoDetectorParameters ap, double minMarkerDistanceRate
) {
  BEGIN_WRAP
  ap.ptr->minMarkerDistanceRate = minMarkerDistanceRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetMinMarkerDistanceRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->minMarkerDistanceRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetCornerRefinementMethod(
    ArucoDetectorParameters ap, int cornerRefinementMethod
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMethod = cornerRefinementMethod;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetCornerRefinementMethod(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->cornerRefinementMethod;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetCornerRefinementWinSize(
    ArucoDetectorParameters ap, int cornerRefinementWinSize
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementWinSize = cornerRefinementWinSize;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetCornerRefinementWinSize(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->cornerRefinementWinSize;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetCornerRefinementMaxIterations(
    ArucoDetectorParameters ap, int cornerRefinementMaxIterations
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMaxIterations = cornerRefinementMaxIterations;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetCornerRefinementMaxIterations(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->cornerRefinementMaxIterations;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetCornerRefinementMinAccuracy(
    ArucoDetectorParameters ap, double cornerRefinementMinAccuracy
) {
  BEGIN_WRAP
  ap.ptr->cornerRefinementMinAccuracy = cornerRefinementMinAccuracy;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetCornerRefinementMinAccuracy(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->cornerRefinementMinAccuracy;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_SetMarkerBorderBits(ArucoDetectorParameters ap, int markerBorderBits) {
  BEGIN_WRAP
  ap.ptr->markerBorderBits = markerBorderBits;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetMarkerBorderBits(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->markerBorderBits;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(
    ArucoDetectorParameters ap, int perspectiveRemovePixelPerCell
) {
  BEGIN_WRAP
  ap.ptr->perspectiveRemovePixelPerCell = perspectiveRemovePixelPerCell;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->perspectiveRemovePixelPerCell;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParameters ap, double perspectiveRemoveIgnoredMarginPerCell
) {
  BEGIN_WRAP
  ap.ptr->perspectiveRemoveIgnoredMarginPerCell = perspectiveRemoveIgnoredMarginPerCell;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParameters ap, double *rval
) {
  BEGIN_WRAP
  *rval = ap.ptr->perspectiveRemoveIgnoredMarginPerCell;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(
    ArucoDetectorParameters ap, double maxErroneousBitsInBorderRate
) {
  BEGIN_WRAP
  ap.ptr->maxErroneousBitsInBorderRate = maxErroneousBitsInBorderRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->maxErroneousBitsInBorderRate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_SetMinOtsuStdDev(ArucoDetectorParameters ap, double minOtsuStdDev) {
  BEGIN_WRAP
  ap.ptr->minOtsuStdDev = minOtsuStdDev;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetMinOtsuStdDev(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->minOtsuStdDev;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetErrorCorrectionRate(
    ArucoDetectorParameters ap, double errorCorrectionRate
) {
  BEGIN_WRAP
  ap.ptr->errorCorrectionRate = errorCorrectionRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetErrorCorrectionRate(ArucoDetectorParameters ap, double *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->errorCorrectionRate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAprilTagQuadDecimate(
    ArucoDetectorParameters ap, float aprilTagQuadDecimate
) {
  BEGIN_WRAP
  ap.ptr->aprilTagQuadDecimate = aprilTagQuadDecimate;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetAprilTagQuadDecimate(ArucoDetectorParameters ap, float *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagQuadDecimate;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_SetAprilTagQuadSigma(ArucoDetectorParameters ap, float aprilTagQuadSigma) {
  BEGIN_WRAP
  ap.ptr->aprilTagQuadSigma = aprilTagQuadSigma;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetAprilTagQuadSigma(ArucoDetectorParameters ap, float *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagQuadSigma;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAprilTagMinClusterPixels(
    ArucoDetectorParameters ap, int aprilTagMinClusterPixels
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMinClusterPixels = aprilTagMinClusterPixels;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAprilTagMinClusterPixels(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagMinClusterPixels;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_SetAprilTagMaxNmaxima(ArucoDetectorParameters ap, int aprilTagMaxNmaxima) {
  BEGIN_WRAP
  ap.ptr->aprilTagMaxNmaxima = aprilTagMaxNmaxima;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetAprilTagMaxNmaxima(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagMaxNmaxima;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAprilTagCriticalRad(
    ArucoDetectorParameters ap, float aprilTagCriticalRad
) {
  BEGIN_WRAP
  ap.ptr->aprilTagCriticalRad = aprilTagCriticalRad;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetAprilTagCriticalRad(ArucoDetectorParameters ap, float *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagCriticalRad;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAprilTagMaxLineFitMse(
    ArucoDetectorParameters ap, float aprilTagMaxLineFitMse
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMaxLineFitMse = aprilTagMaxLineFitMse;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAprilTagMaxLineFitMse(ArucoDetectorParameters ap, float *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagMaxLineFitMse;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(
    ArucoDetectorParameters ap, int aprilTagMinWhiteBlackDiff
) {
  BEGIN_WRAP
  ap.ptr->aprilTagMinWhiteBlackDiff = aprilTagMinWhiteBlackDiff;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagMinWhiteBlackDiff;
  END_WRAP
}
CvStatus *
ArucoDetectorParameters_SetAprilTagDeglitch(ArucoDetectorParameters ap, int aprilTagDeglitch) {
  BEGIN_WRAP
  ap.ptr->aprilTagDeglitch = aprilTagDeglitch;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetAprilTagDeglitch(ArucoDetectorParameters ap, int *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->aprilTagDeglitch;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_SetDetectInvertedMarker(
    ArucoDetectorParameters ap, bool detectInvertedMarker
) {
  BEGIN_WRAP
  ap.ptr->detectInvertedMarker = detectInvertedMarker;
  END_WRAP
}
CvStatus *ArucoDetectorParameters_GetDetectInvertedMarker(ArucoDetectorParameters ap, bool *rval) {
  BEGIN_WRAP
  *rval = ap.ptr->detectInvertedMarker;
  END_WRAP
}

CvStatus *getPredefinedDictionary(int dictionaryId, ArucoDictionary *rval) {
  BEGIN_WRAP
  *rval = {new cv::aruco::Dictionary(cv::aruco::getPredefinedDictionary(dictionaryId))};
  END_WRAP
}
void ArucoDictionary_Close(ArucoDictionaryPtr self) { CVD_FREE(self); }

CvStatus *ArucoDetector_New(ArucoDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::aruco::ArucoDetector()};
  END_WRAP
}
CvStatus *ArucoDetector_NewWithParams(
    ArucoDictionary dictionary, ArucoDetectorParameters params, ArucoDetector *rval
) {
  BEGIN_WRAP
  *rval = {new cv::aruco::ArucoDetector(*dictionary.ptr, *params.ptr)};
  END_WRAP
}
void ArucoDetector_Close(ArucoDetectorPtr ad) { CVD_FREE(ad); }

CvStatus *ArucoDetector_DetectMarkers(
    ArucoDetector ad,
    Mat inputArr,
    VecVecPoint2f *markerCorners,
    VecI32 *markerIds,
    VecVecPoint2f *rejectedCandidates
) {
  BEGIN_WRAP
  std::vector<std::vector<cv::Point2f>> _markerCorners;
  std::vector<int> _markerIds;
  std::vector<std::vector<cv::Point2f>> _rejectedCandidates;
  ad.ptr->detectMarkers(*inputArr.ptr, _markerCorners, _markerIds, _rejectedCandidates);
  *markerCorners = vecvecpoint2f_cpp2c(_markerCorners);
  *markerIds = vecint_cpp2c(_markerIds);
  if (rejectedCandidates != NULL) {
    *rejectedCandidates = vecvecpoint2f_cpp2c(_rejectedCandidates);
  }
  END_WRAP
}

CvStatus *ArucoDrawDetectedMarkers(
    Mat image, VecVecPoint2f markerCorners, VecI32 markerIds, Scalar borderColor
) {
  BEGIN_WRAP
  cv::Scalar _borderColor =
      cv::Scalar(borderColor.val1, borderColor.val2, borderColor.val3, borderColor.val4);
  auto _markerCorners = vecvecpoint2f_c2cpp(markerCorners);
  auto _markerIds = vecint_c2cpp(markerIds);
  cv::aruco::drawDetectedMarkers(*image.ptr, _markerCorners, _markerIds, _borderColor);
  END_WRAP
}

CvStatus *
ArucoGenerateImageMarker(int dictionaryId, int id, int sidePixels, int borderBits, Mat *img) {
  BEGIN_WRAP
  cv::aruco::Dictionary dict = cv::aruco::getPredefinedDictionary(dictionaryId);
  cv::Mat dst;
  cv::aruco::generateImageMarker(dict, id, sidePixels, dst, borderBits);
  *img = {new cv::Mat(dst)};
  END_WRAP
}
