/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#pragma once
#ifndef _OPENCV3_ARUCO_H_
#define _OPENCV3_ARUCO_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/core.h"

#ifdef __cplusplus
CVD_TYPEDEF(cv::aruco::Dictionary, ArucoDictionary);
CVD_TYPEDEF(cv::aruco::DetectorParameters, ArucoDetectorParameters);
CVD_TYPEDEF(cv::aruco::ArucoDetector, ArucoDetector);
#else
CVD_TYPEDEF(void, ArucoDictionary);
CVD_TYPEDEF(void, ArucoDetectorParameters);
CVD_TYPEDEF(void, ArucoDetector);
#endif

CvStatus *ArucoDetectorParameters_Create(ArucoDetectorParameters *rval);
void      ArucoDetectorParameters_Close(ArucoDetectorParametersPtr ap);
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMin(ArucoDetectorParameters ap,
                                                              int adaptiveThreshWinSizeMin);
CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeMin(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeMax(ArucoDetectorParameters ap,
                                                              int adaptiveThreshWinSizeMax);
CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeMax(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshWinSizeStep(ArucoDetectorParameters ap,
                                                               int adaptiveThreshWinSizeStep);
CvStatus *ArucoDetectorParameters_GetAdaptiveThreshWinSizeStep(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAdaptiveThreshConstant(ArucoDetectorParameters ap,
                                                            double                  adaptiveThreshConstant);
CvStatus *ArucoDetectorParameters_GetAdaptiveThreshConstant(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMinMarkerPerimeterRate(ArucoDetectorParameters ap,
                                                            double                  minMarkerPerimeterRate);
CvStatus *ArucoDetectorParameters_GetMinMarkerPerimeterRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMaxMarkerPerimeterRate(ArucoDetectorParameters ap,
                                                            double                  maxMarkerPerimeterRate);
CvStatus *ArucoDetectorParameters_GetMaxMarkerPerimeterRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetPolygonalApproxAccuracyRate(ArucoDetectorParameters ap,
                                                                 double polygonalApproxAccuracyRate);
CvStatus *ArucoDetectorParameters_GetPolygonalApproxAccuracyRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMinCornerDistanceRate(ArucoDetectorParameters ap,
                                                           double                  minCornerDistanceRate);
CvStatus *ArucoDetectorParameters_GetMinCornerDistanceRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMinDistanceToBorder(ArucoDetectorParameters ap, int minDistanceToBorder);
CvStatus *ArucoDetectorParameters_GetMinDistanceToBorder(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetMinMarkerDistanceRate(ArucoDetectorParameters ap,
                                                           double                  minMarkerDistanceRate);
CvStatus *ArucoDetectorParameters_GetMinMarkerDistanceRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetCornerRefinementMethod(ArucoDetectorParameters ap,
                                                            int                     cornerRefinementMethod);
CvStatus *ArucoDetectorParameters_GetCornerRefinementMethod(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetCornerRefinementWinSize(ArucoDetectorParameters ap,
                                                             int                     cornerRefinementWinSize);
CvStatus *ArucoDetectorParameters_GetCornerRefinementWinSize(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetCornerRefinementMaxIterations(ArucoDetectorParameters ap,
                                                                   int cornerRefinementMaxIterations);
CvStatus *ArucoDetectorParameters_GetCornerRefinementMaxIterations(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetCornerRefinementMinAccuracy(ArucoDetectorParameters ap,
                                                                 double cornerRefinementMinAccuracy);
CvStatus *ArucoDetectorParameters_GetCornerRefinementMinAccuracy(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMarkerBorderBits(ArucoDetectorParameters ap, int markerBorderBits);
CvStatus *ArucoDetectorParameters_GetMarkerBorderBits(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetPerspectiveRemovePixelPerCell(ArucoDetectorParameters ap,
                                                                   int perspectiveRemovePixelPerCell);
CvStatus *ArucoDetectorParameters_GetPerspectiveRemovePixelPerCell(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetPerspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParameters ap, double perspectiveRemoveIgnoredMarginPerCell);
CvStatus *ArucoDetectorParameters_GetPerspectiveRemoveIgnoredMarginPerCell(ArucoDetectorParameters ap,
                                                                           double                 *rval);
CvStatus *ArucoDetectorParameters_SetMaxErroneousBitsInBorderRate(ArucoDetectorParameters ap,
                                                                  double maxErroneousBitsInBorderRate);
CvStatus *ArucoDetectorParameters_GetMaxErroneousBitsInBorderRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetMinOtsuStdDev(ArucoDetectorParameters ap, double minOtsuStdDev);
CvStatus *ArucoDetectorParameters_GetMinOtsuStdDev(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetErrorCorrectionRate(ArucoDetectorParameters ap,
                                                         double                  errorCorrectionRate);
CvStatus *ArucoDetectorParameters_GetErrorCorrectionRate(ArucoDetectorParameters ap, double *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagQuadDecimate(ArucoDetectorParameters ap,
                                                          float                   aprilTagQuadDecimate);
CvStatus *ArucoDetectorParameters_GetAprilTagQuadDecimate(ArucoDetectorParameters ap, float *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagQuadSigma(ArucoDetectorParameters ap, float aprilTagQuadSigma);
CvStatus *ArucoDetectorParameters_GetAprilTagQuadSigma(ArucoDetectorParameters ap, float *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagMinClusterPixels(ArucoDetectorParameters ap,
                                                              int aprilTagMinClusterPixels);
CvStatus *ArucoDetectorParameters_GetAprilTagMinClusterPixels(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagMaxNmaxima(ArucoDetectorParameters ap, int aprilTagMaxNmaxima);
CvStatus *ArucoDetectorParameters_GetAprilTagMaxNmaxima(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagCriticalRad(ArucoDetectorParameters ap,
                                                         float                   aprilTagCriticalRad);
CvStatus *ArucoDetectorParameters_GetAprilTagCriticalRad(ArucoDetectorParameters ap, float *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagMaxLineFitMse(ArucoDetectorParameters ap,
                                                           float                   aprilTagMaxLineFitMse);
CvStatus *ArucoDetectorParameters_GetAprilTagMaxLineFitMse(ArucoDetectorParameters ap, float *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagMinWhiteBlackDiff(ArucoDetectorParameters ap,
                                                               int aprilTagMinWhiteBlackDiff);
CvStatus *ArucoDetectorParameters_GetAprilTagMinWhiteBlackDiff(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetAprilTagDeglitch(ArucoDetectorParameters ap, int aprilTagDeglitch);
CvStatus *ArucoDetectorParameters_GetAprilTagDeglitch(ArucoDetectorParameters ap, int *rval);
CvStatus *ArucoDetectorParameters_SetDetectInvertedMarker(ArucoDetectorParameters ap,
                                                          bool                    detectInvertedMarker);
CvStatus *ArucoDetectorParameters_GetDetectInvertedMarker(ArucoDetectorParameters ap, bool *rval);

CvStatus *getPredefinedDictionary(int dictionaryId, ArucoDictionary *rval);
void      ArucoDictionary_Close(ArucoDictionaryPtr self);

CvStatus *ArucoDetector_New(ArucoDetector *rval);
CvStatus *ArucoDetector_NewWithParams(ArucoDictionary dictionary, ArucoDetectorParameters params,
                                      ArucoDetector *rval);
void      ArucoDetector_Close(ArucoDetectorPtr ad);
CvStatus *ArucoDetector_DetectMarkers(ArucoDetector ad, Mat inputArr, VecVecPoint2f *markerCorners,
                                      VecI32 *markerIds, VecVecPoint2f *rejectedCandidates);

CvStatus *ArucoDrawDetectedMarkers(Mat image, VecVecPoint2f markerCorners, VecI32 markerIds,
                                   Scalar borderColor);
CvStatus *ArucoGenerateImageMarker(int dictionaryId, int id, int sidePixels, int borderBits, Mat *img);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_ARUCO_H_
