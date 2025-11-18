/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#include "dartcv/contrib/aruco.h"
#include "dartcv/core/vec.hpp"

CvStatus* cv_aruco_detectorParameters_create(ArucoDetectorParams* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::DetectorParameters();
    END_WRAP
}

void cv_aruco_detectorParameters_close(ArucoDetectorParamsPtr ap) {
    CVD_FREE(ap);
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMin(ArucoDetectorParams self, int value) {
    self.ptr->adaptiveThreshWinSizeMin = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMin(ArucoDetectorParams self) {
    return self.ptr->adaptiveThreshWinSizeMin;
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMax(ArucoDetectorParams self, int value) {
    self.ptr->adaptiveThreshWinSizeMax = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMax(ArucoDetectorParams self) {
    return self.ptr->adaptiveThreshWinSizeMax;
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeStep(
    ArucoDetectorParams self, int value
) {
    self.ptr->adaptiveThreshWinSizeStep = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeStep(ArucoDetectorParams self) {
    return self.ptr->adaptiveThreshWinSizeStep;
}

void cv_aruco_detectorParameters_set_adaptiveThreshConstant(
    ArucoDetectorParams self, double value
) {
    self.ptr->adaptiveThreshConstant = value;
}

double cv_aruco_detectorParameters_get_adaptiveThreshConstant(ArucoDetectorParams self) {
    return self.ptr->adaptiveThreshConstant;
}

void cv_aruco_detectorParameters_set_minMarkerPerimeterRate(
    ArucoDetectorParams self, double value
) {
    self.ptr->minMarkerPerimeterRate = value;
}

double cv_aruco_detectorParameters_get_minMarkerPerimeterRate(ArucoDetectorParams self) {
    return self.ptr->minMarkerPerimeterRate;
}

void cv_aruco_detectorParameters_set_maxMarkerPerimeterRate(
    ArucoDetectorParams self, double value
) {
    self.ptr->maxMarkerPerimeterRate = value;
}

double cv_aruco_detectorParameters_get_maxMarkerPerimeterRate(ArucoDetectorParams self) {
    return self.ptr->maxMarkerPerimeterRate;
}

void cv_aruco_detectorParameters_set_polygonalApproxAccuracyRate(
    ArucoDetectorParams self, double value
) {
    self.ptr->polygonalApproxAccuracyRate = value;
}

double cv_aruco_detectorParameters_get_polygonalApproxAccuracyRate(ArucoDetectorParams self) {
    return self.ptr->polygonalApproxAccuracyRate;
}

void cv_aruco_detectorParameters_set_minCornerDistanceRate(ArucoDetectorParams self, double value) {
    self.ptr->minCornerDistanceRate = value;
}

double cv_aruco_detectorParameters_get_minCornerDistanceRate(ArucoDetectorParams self) {
    return self.ptr->minCornerDistanceRate;
}

void cv_aruco_detectorParameters_set_minDistanceToBorder(ArucoDetectorParams self, int value) {
    self.ptr->minDistanceToBorder = value;
}

int cv_aruco_detectorParameters_get_minDistanceToBorder(ArucoDetectorParams self) {
    return self.ptr->minDistanceToBorder;
}

void cv_aruco_detectorParameters_set_minMarkerDistanceRate(ArucoDetectorParams self, double value) {
    self.ptr->minMarkerDistanceRate = value;
}

double cv_aruco_detectorParameters_get_minMarkerDistanceRate(ArucoDetectorParams self) {
    return self.ptr->minMarkerDistanceRate;
}

void cv_aruco_detectorParameters_set_cornerRefinementMethod(ArucoDetectorParams self, int value) {
    self.ptr->cornerRefinementMethod = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementMethod(ArucoDetectorParams self) {
    return self.ptr->cornerRefinementMethod;
}

void cv_aruco_detectorParameters_set_cornerRefinementWinSize(ArucoDetectorParams self, int value) {
    self.ptr->cornerRefinementWinSize = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementWinSize(ArucoDetectorParams self) {
    return self.ptr->cornerRefinementWinSize;
}

void cv_aruco_detectorParameters_set_cornerRefinementMaxIterations(
    ArucoDetectorParams self, int value
) {
    self.ptr->cornerRefinementMaxIterations = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementMaxIterations(ArucoDetectorParams self) {
    return self.ptr->cornerRefinementMaxIterations;
}

void cv_aruco_detectorParameters_set_cornerRefinementMinAccuracy(
    ArucoDetectorParams self, double value
) {
    self.ptr->cornerRefinementMinAccuracy = value;
}

double cv_aruco_detectorParameters_get_cornerRefinementMinAccuracy(ArucoDetectorParams self) {
    return self.ptr->cornerRefinementMinAccuracy;
}

void cv_aruco_detectorParameters_set_markerBorderBits(ArucoDetectorParams self, int value) {
    self.ptr->markerBorderBits = value;
}

int cv_aruco_detectorParameters_get_markerBorderBits(ArucoDetectorParams self) {
    return self.ptr->markerBorderBits;
}

void cv_aruco_detectorParameters_set_perspectiveRemovePixelPerCell(
    ArucoDetectorParams self, int value
) {
    self.ptr->perspectiveRemovePixelPerCell = value;
}

int cv_aruco_detectorParameters_get_perspectiveRemovePixelPerCell(ArucoDetectorParams self) {
    return self.ptr->perspectiveRemovePixelPerCell;
}

void cv_aruco_detectorParameters_set_perspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParams self, double value
) {
    self.ptr->perspectiveRemoveIgnoredMarginPerCell = value;
}

double cv_aruco_detectorParameters_get_perspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParams self
) {
    return self.ptr->perspectiveRemoveIgnoredMarginPerCell;
}

void cv_aruco_detectorParameters_set_maxErroneousBitsInBorderRate(
    ArucoDetectorParams self, double value
) {
    self.ptr->maxErroneousBitsInBorderRate = value;
}

double cv_aruco_detectorParameters_get_maxErroneousBitsInBorderRate(ArucoDetectorParams self) {
    return self.ptr->maxErroneousBitsInBorderRate;
}

void cv_aruco_detectorParameters_set_minOtsuStdDev(ArucoDetectorParams self, double value) {
    self.ptr->minOtsuStdDev = value;
}

double cv_aruco_detectorParameters_get_minOtsuStdDev(ArucoDetectorParams self) {
    return self.ptr->minOtsuStdDev;
}

void cv_aruco_detectorParameters_set_errorCorrectionRate(ArucoDetectorParams self, double value) {
    self.ptr->errorCorrectionRate = value;
}

double cv_aruco_detectorParameters_get_errorCorrectionRate(ArucoDetectorParams self) {
    return self.ptr->errorCorrectionRate;
}

void cv_aruco_detectorParameters_set_aprilTagQuadDecimate(ArucoDetectorParams self, float value) {
    self.ptr->aprilTagQuadDecimate = value;
}

float cv_aruco_detectorParameters_get_aprilTagQuadDecimate(ArucoDetectorParams self) {
    return self.ptr->aprilTagQuadDecimate;
}

void cv_aruco_detectorParameters_set_aprilTagQuadSigma(ArucoDetectorParams self, float value) {
    self.ptr->aprilTagQuadSigma = value;
}

float cv_aruco_detectorParameters_get_aprilTagQuadSigma(ArucoDetectorParams self) {
    return self.ptr->aprilTagQuadSigma;
}

void cv_aruco_detectorParameters_set_aprilTagMinClusterPixels(ArucoDetectorParams self, int value) {
    self.ptr->aprilTagMinClusterPixels = value;
}

int cv_aruco_detectorParameters_get_aprilTagMinClusterPixels(ArucoDetectorParams self) {
    return self.ptr->aprilTagMinClusterPixels;
}

void cv_aruco_detectorParameters_set_aprilTagMaxNmaxima(ArucoDetectorParams self, int value) {
    self.ptr->aprilTagMaxNmaxima = value;
}

int cv_aruco_detectorParameters_get_aprilTagMaxNmaxima(ArucoDetectorParams self) {
    return self.ptr->aprilTagMaxNmaxima;
}

void cv_aruco_detectorParameters_set_aprilTagCriticalRad(ArucoDetectorParams self, float value) {
    self.ptr->aprilTagCriticalRad = value;
}

float cv_aruco_detectorParameters_get_aprilTagCriticalRad(ArucoDetectorParams self) {
    return self.ptr->aprilTagCriticalRad;
}

void cv_aruco_detectorParameters_set_aprilTagMaxLineFitMse(ArucoDetectorParams self, float value) {
    self.ptr->aprilTagMaxLineFitMse = value;
}

float cv_aruco_detectorParameters_get_aprilTagMaxLineFitMse(ArucoDetectorParams self) {
    return self.ptr->aprilTagMaxLineFitMse;
}

void cv_aruco_detectorParameters_set_aprilTagMinWhiteBlackDiff(
    ArucoDetectorParams self, int value
) {
    self.ptr->aprilTagMinWhiteBlackDiff = value;
}

int cv_aruco_detectorParameters_get_aprilTagMinWhiteBlackDiff(ArucoDetectorParams self) {
    return self.ptr->aprilTagMinWhiteBlackDiff;
}

void cv_aruco_detectorParameters_set_aprilTagDeglitch(ArucoDetectorParams self, int value) {
    self.ptr->aprilTagDeglitch = value;
}

int cv_aruco_detectorParameters_get_aprilTagDeglitch(ArucoDetectorParams self) {
    return self.ptr->aprilTagDeglitch;
}

void cv_aruco_detectorParameters_set_detectInvertedMarker(ArucoDetectorParams self, bool value) {
    self.ptr->detectInvertedMarker = value;
}

bool cv_aruco_detectorParameters_get_detectInvertedMarker(ArucoDetectorParams self) {
    return self.ptr->detectInvertedMarker;
}

CvStatus* cv_aruco_Dictionary_create(ArucoDictionary* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::Dictionary();
    END_WRAP
}

CvStatus* cv_aruco_getPredefinedDictionary(int dictionaryId, ArucoDictionary* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::Dictionary(cv::aruco::getPredefinedDictionary(dictionaryId));
    END_WRAP
}

CvStatus* cv_aruco_Dictionary_create_1(
    Mat bytesList, int markerSize, int maxCorr, ArucoDictionary* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::Dictionary(CVDEREF(bytesList), markerSize, maxCorr);
    END_WRAP
}

CvStatus* cv_aruco_Dictionary_generateImageMarker(
    ArucoDictionary self, int id, int sidePixels, Mat _img, int borderBits
) {
    BEGIN_WRAP
    self.ptr->generateImageMarker(id, sidePixels, CVDEREF(_img), borderBits);
    END_WRAP
}
int cv_aruco_Dictionary_getDistanceToId(ArucoDictionary self, Mat bits, int id, bool allRotations) {
    return self.ptr->getDistanceToId(CVDEREF(bits), id, allRotations);
}
bool cv_aruco_Dictionary_identify(
    ArucoDictionary self, Mat onlyBits, int* idx, int* rotation, double maxCorrectionRate
) {
    int _idx, _rotation;
    bool rval = self.ptr->identify(CVDEREF(onlyBits), _idx, _rotation, maxCorrectionRate);
    *idx = _idx;
    *rotation = _rotation;
    return rval;
}
CvStatus* cv_aruco_Dictionary_get_bytesList(ArucoDictionary self, Mat* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(self.ptr->bytesList);
    END_WRAP
}
int cv_aruco_Dictionary_get_markerSize(ArucoDictionary self) {
    return self.ptr->markerSize;
}
int cv_aruco_Dictionary_get_maxCorrectionBits(ArucoDictionary self) {
    return self.ptr->maxCorrectionBits;
}

CvStatus* cv_aruco_Dictionary_set_bytesList(ArucoDictionary self, Mat value){
    BEGIN_WRAP
    self.ptr->bytesList = CVDEREF(value);
    END_WRAP
}
void cv_aruco_Dictionary_set_markerSize(ArucoDictionary self, int value){
    self.ptr->markerSize = value;
}
void cv_aruco_Dictionary_set_maxCorrectionBits(ArucoDictionary self, int value){
    self.ptr->maxCorrectionBits = value;
}

void cv_aruco_Dictionary_close(ArucoDictionaryPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_aruco_arucoDetector_create(ArucoDetector* rval) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::ArucoDetector();
    END_WRAP
}

CvStatus* cv_aruco_arucoDetector_create_1(
    ArucoDictionary dictionary, ArucoDetectorParams params, ArucoDetector* rval
) {
    BEGIN_WRAP
    rval->ptr = new cv::aruco::ArucoDetector(CVDEREF(dictionary), CVDEREF(params));
    END_WRAP
}

void cv_aruco_arucoDetector_close(ArucoDetectorPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_aruco_arucoDetector_detectMarkers(
    ArucoDetector self,
    Mat inputArr,
    VecVecPoint2f* out_markerCorners,
    VecI32* out_markerIds,
    VecVecPoint2f* out_rejectedCandidates,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    self.ptr->detectMarkers(*inputArr.ptr, CVDEREF_P(out_markerCorners), CVDEREF_P(out_markerIds), CVDEREF_P(out_rejectedCandidates));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_aruco_drawDetectedMarkers(
    Mat image,
    VecVecPoint2f markerCorners,
    VecI32 markerIds,
    Scalar borderColor,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar _borderColor =
        cv::Scalar(borderColor.val1, borderColor.val2, borderColor.val3, borderColor.val4);
    cv::aruco::drawDetectedMarkers(*image.ptr, CVDEREF(markerCorners), CVDEREF(markerIds), _borderColor);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_aruco_generateImageMarker(
    int dictionaryId, int id, int sidePixels, int borderBits, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::aruco::Dictionary dict = cv::aruco::getPredefinedDictionary(dictionaryId);
    cv::aruco::generateImageMarker(dict, id, sidePixels, *dst.ptr, borderBits);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
