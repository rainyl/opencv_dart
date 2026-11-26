/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#include "dartcv/contrib/aruco.h"
#include "dartcv/core/vec.hpp"
#include "dartcv/core/handle.hpp"

CvStatus* cv_aruco_detectorParameters_create(ArucoDetectorParams* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::DetectorParameters());
    END_WRAP
}

void cv_aruco_detectorParameters_close(ArucoDetectorParamsPtr ap) {
    CVD_FREE(ap);
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMin(ArucoDetectorParams self, int value) {
    (*self.ptr)->adaptiveThreshWinSizeMin = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMin(ArucoDetectorParams self) {
    return (*self.ptr)->adaptiveThreshWinSizeMin;
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeMax(ArucoDetectorParams self, int value) {
    (*self.ptr)->adaptiveThreshWinSizeMax = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeMax(ArucoDetectorParams self) {
    return (*self.ptr)->adaptiveThreshWinSizeMax;
}

void cv_aruco_detectorParameters_set_adaptiveThreshWinSizeStep(
    ArucoDetectorParams self, int value
) {
    (*self.ptr)->adaptiveThreshWinSizeStep = value;
}

int cv_aruco_detectorParameters_get_adaptiveThreshWinSizeStep(ArucoDetectorParams self) {
    return (*self.ptr)->adaptiveThreshWinSizeStep;
}

void cv_aruco_detectorParameters_set_adaptiveThreshConstant(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->adaptiveThreshConstant = value;
}

double cv_aruco_detectorParameters_get_adaptiveThreshConstant(ArucoDetectorParams self) {
    return (*self.ptr)->adaptiveThreshConstant;
}

void cv_aruco_detectorParameters_set_minMarkerPerimeterRate(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->minMarkerPerimeterRate = value;
}

double cv_aruco_detectorParameters_get_minMarkerPerimeterRate(ArucoDetectorParams self) {
    return (*self.ptr)->minMarkerPerimeterRate;
}

void cv_aruco_detectorParameters_set_maxMarkerPerimeterRate(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->maxMarkerPerimeterRate = value;
}

double cv_aruco_detectorParameters_get_maxMarkerPerimeterRate(ArucoDetectorParams self) {
    return (*self.ptr)->maxMarkerPerimeterRate;
}

void cv_aruco_detectorParameters_set_polygonalApproxAccuracyRate(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->polygonalApproxAccuracyRate = value;
}

double cv_aruco_detectorParameters_get_polygonalApproxAccuracyRate(ArucoDetectorParams self) {
    return (*self.ptr)->polygonalApproxAccuracyRate;
}

void cv_aruco_detectorParameters_set_minCornerDistanceRate(ArucoDetectorParams self, double value) {
    (*self.ptr)->minCornerDistanceRate = value;
}

double cv_aruco_detectorParameters_get_minCornerDistanceRate(ArucoDetectorParams self) {
    return (*self.ptr)->minCornerDistanceRate;
}

void cv_aruco_detectorParameters_set_minDistanceToBorder(ArucoDetectorParams self, int value) {
    (*self.ptr)->minDistanceToBorder = value;
}

int cv_aruco_detectorParameters_get_minDistanceToBorder(ArucoDetectorParams self) {
    return (*self.ptr)->minDistanceToBorder;
}

void cv_aruco_detectorParameters_set_minMarkerDistanceRate(ArucoDetectorParams self, double value) {
    (*self.ptr)->minMarkerDistanceRate = value;
}

double cv_aruco_detectorParameters_get_minMarkerDistanceRate(ArucoDetectorParams self) {
    return (*self.ptr)->minMarkerDistanceRate;
}

void cv_aruco_detectorParameters_set_cornerRefinementMethod(ArucoDetectorParams self, int value) {
    (*self.ptr)->cornerRefinementMethod = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementMethod(ArucoDetectorParams self) {
    return (*self.ptr)->cornerRefinementMethod;
}

void cv_aruco_detectorParameters_set_cornerRefinementWinSize(ArucoDetectorParams self, int value) {
    (*self.ptr)->cornerRefinementWinSize = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementWinSize(ArucoDetectorParams self) {
    return (*self.ptr)->cornerRefinementWinSize;
}

void cv_aruco_detectorParameters_set_cornerRefinementMaxIterations(
    ArucoDetectorParams self, int value
) {
    (*self.ptr)->cornerRefinementMaxIterations = value;
}

int cv_aruco_detectorParameters_get_cornerRefinementMaxIterations(ArucoDetectorParams self) {
    return (*self.ptr)->cornerRefinementMaxIterations;
}

void cv_aruco_detectorParameters_set_cornerRefinementMinAccuracy(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->cornerRefinementMinAccuracy = value;
}

double cv_aruco_detectorParameters_get_cornerRefinementMinAccuracy(ArucoDetectorParams self) {
    return (*self.ptr)->cornerRefinementMinAccuracy;
}

void cv_aruco_detectorParameters_set_markerBorderBits(ArucoDetectorParams self, int value) {
    (*self.ptr)->markerBorderBits = value;
}

int cv_aruco_detectorParameters_get_markerBorderBits(ArucoDetectorParams self) {
    return (*self.ptr)->markerBorderBits;
}

void cv_aruco_detectorParameters_set_perspectiveRemovePixelPerCell(
    ArucoDetectorParams self, int value
) {
    (*self.ptr)->perspectiveRemovePixelPerCell = value;
}

int cv_aruco_detectorParameters_get_perspectiveRemovePixelPerCell(ArucoDetectorParams self) {
    return (*self.ptr)->perspectiveRemovePixelPerCell;
}

void cv_aruco_detectorParameters_set_perspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->perspectiveRemoveIgnoredMarginPerCell = value;
}

double cv_aruco_detectorParameters_get_perspectiveRemoveIgnoredMarginPerCell(
    ArucoDetectorParams self
) {
    return (*self.ptr)->perspectiveRemoveIgnoredMarginPerCell;
}

void cv_aruco_detectorParameters_set_maxErroneousBitsInBorderRate(
    ArucoDetectorParams self, double value
) {
    (*self.ptr)->maxErroneousBitsInBorderRate = value;
}

double cv_aruco_detectorParameters_get_maxErroneousBitsInBorderRate(ArucoDetectorParams self) {
    return (*self.ptr)->maxErroneousBitsInBorderRate;
}

void cv_aruco_detectorParameters_set_minOtsuStdDev(ArucoDetectorParams self, double value) {
    (*self.ptr)->minOtsuStdDev = value;
}

double cv_aruco_detectorParameters_get_minOtsuStdDev(ArucoDetectorParams self) {
    return (*self.ptr)->minOtsuStdDev;
}

void cv_aruco_detectorParameters_set_errorCorrectionRate(ArucoDetectorParams self, double value) {
    (*self.ptr)->errorCorrectionRate = value;
}

double cv_aruco_detectorParameters_get_errorCorrectionRate(ArucoDetectorParams self) {
    return (*self.ptr)->errorCorrectionRate;
}

void cv_aruco_detectorParameters_set_aprilTagQuadDecimate(ArucoDetectorParams self, float value) {
    (*self.ptr)->aprilTagQuadDecimate = value;
}

float cv_aruco_detectorParameters_get_aprilTagQuadDecimate(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagQuadDecimate;
}

void cv_aruco_detectorParameters_set_aprilTagQuadSigma(ArucoDetectorParams self, float value) {
    (*self.ptr)->aprilTagQuadSigma = value;
}

float cv_aruco_detectorParameters_get_aprilTagQuadSigma(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagQuadSigma;
}

void cv_aruco_detectorParameters_set_aprilTagMinClusterPixels(ArucoDetectorParams self, int value) {
    (*self.ptr)->aprilTagMinClusterPixels = value;
}

int cv_aruco_detectorParameters_get_aprilTagMinClusterPixels(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagMinClusterPixels;
}

void cv_aruco_detectorParameters_set_aprilTagMaxNmaxima(ArucoDetectorParams self, int value) {
    (*self.ptr)->aprilTagMaxNmaxima = value;
}

int cv_aruco_detectorParameters_get_aprilTagMaxNmaxima(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagMaxNmaxima;
}

void cv_aruco_detectorParameters_set_aprilTagCriticalRad(ArucoDetectorParams self, float value) {
    (*self.ptr)->aprilTagCriticalRad = value;
}

float cv_aruco_detectorParameters_get_aprilTagCriticalRad(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagCriticalRad;
}

void cv_aruco_detectorParameters_set_aprilTagMaxLineFitMse(ArucoDetectorParams self, float value) {
    (*self.ptr)->aprilTagMaxLineFitMse = value;
}

float cv_aruco_detectorParameters_get_aprilTagMaxLineFitMse(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagMaxLineFitMse;
}

void cv_aruco_detectorParameters_set_aprilTagMinWhiteBlackDiff(
    ArucoDetectorParams self, int value
) {
    (*self.ptr)->aprilTagMinWhiteBlackDiff = value;
}

int cv_aruco_detectorParameters_get_aprilTagMinWhiteBlackDiff(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagMinWhiteBlackDiff;
}

void cv_aruco_detectorParameters_set_aprilTagDeglitch(ArucoDetectorParams self, int value) {
    (*self.ptr)->aprilTagDeglitch = value;
}

int cv_aruco_detectorParameters_get_aprilTagDeglitch(ArucoDetectorParams self) {
    return (*self.ptr)->aprilTagDeglitch;
}

void cv_aruco_detectorParameters_set_detectInvertedMarker(ArucoDetectorParams self, bool value) {
    (*self.ptr)->detectInvertedMarker = value;
}

bool cv_aruco_detectorParameters_get_detectInvertedMarker(ArucoDetectorParams self) {
    return (*self.ptr)->detectInvertedMarker;
}

CvStatus* cv_aruco_refineParameters_create(ArucoRefineParams* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::RefineParameters());
    END_WRAP
}

CvStatus* cv_aruco_refineParameters_create_1(
    float minRepDistance,
    float errorCorrectionRate,
    bool checkAllOrders,
    ArucoRefineParams* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::RefineParameters(
        minRepDistance,
        errorCorrectionRate,
        checkAllOrders
    ));
    END_WRAP
}

void cv_aruco_refineParameters_close(ArucoRefineParamsPtr self) {
    CVD_FREE(self);
}

float cv_aruco_refineParameters_get_minRepDistance(ArucoRefineParams self) {
    return (*self.ptr)->minRepDistance;
}

void cv_aruco_refineParameters_set_minRepDistance(ArucoRefineParams self, float value) {
    (*self.ptr)->minRepDistance = value;
}

float cv_aruco_refineParameters_get_errorCorrectionRate(ArucoRefineParams self) {
    return (*self.ptr)->errorCorrectionRate;
}

void cv_aruco_refineParameters_set_errorCorrectionRate(ArucoRefineParams self, float value) {
    (*self.ptr)->errorCorrectionRate = value;
}

bool cv_aruco_refineParameters_get_checkAllOrders(ArucoRefineParams self) {
    return (*self.ptr)->checkAllOrders;
}

void cv_aruco_refineParameters_set_checkAllOrders(ArucoRefineParams self, bool value) {
    (*self.ptr)->checkAllOrders = value;
}

CvStatus* cv_aruco_Dictionary_create(ArucoDictionary* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::Dictionary());
    END_WRAP
}

CvStatus* cv_aruco_getPredefinedDictionary(int dictionaryId, ArucoDictionary* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::Dictionary(cv::aruco::getPredefinedDictionary(dictionaryId)));
    END_WRAP
}

CvStatus* cv_aruco_Dictionary_create_1(
    Mat bytesList, int markerSize, int maxCorr, ArucoDictionary* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::Dictionary(CVDEREF(bytesList), markerSize, maxCorr));
    END_WRAP
}

CvStatus* cv_aruco_Dictionary_generateImageMarker(
    ArucoDictionary self, int id, int sidePixels, Mat _img, int borderBits
) {
    BEGIN_WRAP
    (*self.ptr)->generateImageMarker(id, sidePixels, CVDEREF(_img), borderBits);
    END_WRAP
}
int cv_aruco_Dictionary_getDistanceToId(ArucoDictionary self, Mat bits, int id, bool allRotations) {
    return (*self.ptr)->getDistanceToId(CVDEREF(bits), id, allRotations);
}
bool cv_aruco_Dictionary_identify(
    ArucoDictionary self, Mat onlyBits, int* idx, int* rotation, double maxCorrectionRate
) {
    int _idx, _rotation;
    bool rval = (*self.ptr)->identify(CVDEREF(onlyBits), _idx, _rotation, maxCorrectionRate);
    *idx = _idx;
    *rotation = _rotation;
    return rval;
}
CvStatus* cv_aruco_Dictionary_get_bytesList(ArucoDictionary self, Mat* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::Mat((*self.ptr)->bytesList));
    END_WRAP
}
int cv_aruco_Dictionary_get_markerSize(ArucoDictionary self) {
    return (*self.ptr)->markerSize;
}
int cv_aruco_Dictionary_get_maxCorrectionBits(ArucoDictionary self) {
    return (*self.ptr)->maxCorrectionBits;
}

CvStatus* cv_aruco_Dictionary_set_bytesList(ArucoDictionary self, Mat value){
    BEGIN_WRAP
    (*self.ptr)->bytesList = CVDEREF(value);
    END_WRAP
}
void cv_aruco_Dictionary_set_markerSize(ArucoDictionary self, int value){
    (*self.ptr)->markerSize = value;
}
void cv_aruco_Dictionary_set_maxCorrectionBits(ArucoDictionary self, int value){
    (*self.ptr)->maxCorrectionBits = value;
}

void cv_aruco_Dictionary_close(ArucoDictionaryPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_aruco_arucoDetector_create(ArucoDetector* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::ArucoDetector());
    END_WRAP
}

CvStatus* cv_aruco_arucoDetector_create_1(
    ArucoDictionary dictionary, ArucoDetectorParams params, ArucoDetector* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::ArucoDetector(CVDEREF(dictionary), CVDEREF(params)));
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
    return cvd::dispatch(callback, cvd::hold(self, inputArr), [=]() -> CvStatus* {
        BEGIN_WRAP
        (*self.ptr)->detectMarkers(CVDEREF(inputArr), CVDEREF_P(out_markerCorners), CVDEREF_P(out_markerIds), CVDEREF_P(out_rejectedCandidates));
        END_WRAP
    });
}

CvStatus* cv_aruco_drawDetectedMarkers(
    Mat image,
    VecVecPoint2f markerCorners,
    VecI32 markerIds,
    Scalar borderColor,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(image, markerCorners, markerIds), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::Scalar _borderColor =
            cv::Scalar(borderColor.val1, borderColor.val2, borderColor.val3, borderColor.val4);
        cv::aruco::drawDetectedMarkers(CVDEREF(image), CVDEREF(markerCorners), CVDEREF(markerIds), _borderColor);
        END_WRAP
    });
}

CvStatus* cv_aruco_generateImageMarker(
    int dictionaryId, int id, int sidePixels, int borderBits, Mat dst, CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(dst), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::aruco::Dictionary dict = cv::aruco::getPredefinedDictionary(dictionaryId);
        cv::aruco::generateImageMarker(dict, id, sidePixels, CVDEREF(dst), borderBits);
        END_WRAP
    });
}

CvStatus* cv_aruco_charucoBoard_create(CharucoBoard* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoBoard());
    END_WRAP
}

CvStatus* cv_aruco_charucoBoard_create_1(
    CvSize size,
    float squareLength,
    float markerLength,
    ArucoDictionary dictionary,
    CharucoBoard* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoBoard(
        cv::Size(size.width, size.height),
        squareLength,
        markerLength,
        CVDEREF(dictionary)
    ));
    END_WRAP
}

CvStatus* cv_aruco_charucoBoard_create_2(
    CvSize size,
    float squareLength,
    float markerLength,
    ArucoDictionary dictionary,
    VecI32 ids,
    CharucoBoard* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoBoard(
        cv::Size(size.width, size.height),
        squareLength,
        markerLength,
        CVDEREF(dictionary),
        CVDEREF(ids)
    ));
    END_WRAP
}

void cv_aruco_charucoBoard_close(CharucoBoardPtr self) {
    CVD_FREE(self);
}

bool cv_aruco_charucoBoard_checkCharucoCornersCollinear(CharucoBoard self, VecI32 charucoIds) {
    return (*self.ptr)->checkCharucoCornersCollinear(CVDEREF(charucoIds));
}

CvStatus* cv_aruco_charucoBoard_generateImage(
    CharucoBoard self,
    CvSize outSize,
    Mat img,
    int marginSize,
    int borderBits,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, img), [=]() -> CvStatus* {
        BEGIN_WRAP
        (*self.ptr)->generateImage(cv::Size(outSize.width, outSize.height), CVDEREF(img), marginSize, borderBits);
        END_WRAP
    });
}

CvStatus* cv_aruco_charucoBoard_getChessboardCorners(CharucoBoard self, VecPoint3f* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new std::vector<cv::Point3f>((*self.ptr)->getChessboardCorners()));
    END_WRAP
}

CvSize cv_aruco_charucoBoard_getChessboardSize(CharucoBoard self) {
    cv::Size size = (*self.ptr)->getChessboardSize();
    return CvSize{size.width, size.height};
}

float cv_aruco_charucoBoard_getMarkerLength(CharucoBoard self) {
    return (*self.ptr)->getMarkerLength();
}

float cv_aruco_charucoBoard_getSquareLength(CharucoBoard self) {
    return (*self.ptr)->getSquareLength();
}

bool cv_aruco_charucoBoard_getLegacyPattern(CharucoBoard self) {
    return (*self.ptr)->getLegacyPattern();
}

void cv_aruco_charucoBoard_setLegacyPattern(CharucoBoard self, bool value) {
    (*self.ptr)->setLegacyPattern(value);
}

CvStatus* cv_aruco_charucoBoard_getIds(CharucoBoard self, VecI32* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new std::vector<int>((*self.ptr)->getIds()));
    END_WRAP
}

CvStatus* cv_aruco_charucoBoard_getObjPoints(CharucoBoard self, VecVecPoint3f* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new std::vector<std::vector<cv::Point3f>>((*self.ptr)->getObjPoints()));
    END_WRAP
}

CvStatus* cv_aruco_charucoBoard_matchImagePoints(
    CharucoBoard self,
    VecPoint2f detectedCharuco,
    VecI32 detectedIds,
    Mat objPoints,
    Mat imgPoints,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, detectedCharuco, detectedIds, objPoints, imgPoints), [=]() -> CvStatus* {
        BEGIN_WRAP
        (*self.ptr)->matchImagePoints(CVDEREF(detectedCharuco), CVDEREF(detectedIds), CVDEREF(objPoints), CVDEREF(imgPoints));
        END_WRAP
    });
}

CvStatus* cv_aruco_charucoDetectorParameters_create(CharucoDetectorParams* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoParameters());
    END_WRAP
}

void cv_aruco_charucoDetectorParameters_close(CharucoDetectorParamsPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_aruco_charucoDetectorParameters_get_cameraMatrix(CharucoDetectorParams self, Mat* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::Mat((*self.ptr)->cameraMatrix));
    END_WRAP
}

CvStatus* cv_aruco_charucoDetectorParameters_set_cameraMatrix(CharucoDetectorParams self, Mat value) {
    BEGIN_WRAP
    (*self.ptr)->cameraMatrix = CVDEREF(value);
    END_WRAP
}

CvStatus* cv_aruco_charucoDetectorParameters_get_distCoeffs(CharucoDetectorParams self, Mat* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::Mat((*self.ptr)->distCoeffs));
    END_WRAP
}

CvStatus* cv_aruco_charucoDetectorParameters_set_distCoeffs(CharucoDetectorParams self, Mat value) {
    BEGIN_WRAP
    (*self.ptr)->distCoeffs = CVDEREF(value);
    END_WRAP
}

int cv_aruco_charucoDetectorParameters_get_minMarkers(CharucoDetectorParams self) {
    return (*self.ptr)->minMarkers;
}

void cv_aruco_charucoDetectorParameters_set_minMarkers(CharucoDetectorParams self, int value) {
    (*self.ptr)->minMarkers = value;
}

bool cv_aruco_charucoDetectorParameters_get_tryRefineMarkers(CharucoDetectorParams self) {
    return (*self.ptr)->tryRefineMarkers;
}

void cv_aruco_charucoDetectorParameters_set_tryRefineMarkers(CharucoDetectorParams self, bool value) {
    (*self.ptr)->tryRefineMarkers = value;
}

bool cv_aruco_charucoDetectorParameters_get_checkMarkers(CharucoDetectorParams self) {
    return (*self.ptr)->checkMarkers;
}

void cv_aruco_charucoDetectorParameters_set_checkMarkers(CharucoDetectorParams self, bool value) {
    (*self.ptr)->checkMarkers = value;
}

CvStatus* cv_aruco_charucoDetector_create_1(
    CharucoBoard board,
    CharucoDetector* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoDetector(CVDEREF(board)));
    END_WRAP
}

CvStatus* cv_aruco_charucoDetector_create_2(
    CharucoBoard board,
    CharucoDetectorParams charucoParams,
    CharucoDetector* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoDetector(
        CVDEREF(board),
        CVDEREF(charucoParams)
    ));
    END_WRAP
}

CvStatus* cv_aruco_charucoDetector_create_3(
    CharucoBoard board,
    CharucoDetectorParams charucoParams,
    ArucoDetectorParams detectorParams,
    CharucoDetector* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoDetector(
        CVDEREF(board),
        CVDEREF(charucoParams),
        CVDEREF(detectorParams)
    ));
    END_WRAP
}

CvStatus* cv_aruco_charucoDetector_create_4(
    CharucoBoard board,
    CharucoDetectorParams charucoParams,
    ArucoDetectorParams detectorParams,
    ArucoRefineParams refineParams,
    CharucoDetector* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoDetector(
        CVDEREF(board),
        CVDEREF(charucoParams),
        CVDEREF(detectorParams),
        CVDEREF(refineParams)
    ));
    END_WRAP
}

void cv_aruco_charucoDetector_close(CharucoDetectorPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_aruco_charucoDetector_detectBoard(
    CharucoDetector self,
    Mat image,
    VecPoint2f* out_charucoCorners,
    VecI32* out_charucoIds,
    VecVecPoint2f* inout_markerCorners,
    VecI32* inout_markerIds,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, image), [=]() -> CvStatus* {
        BEGIN_WRAP
        (*self.ptr)->detectBoard(
            CVDEREF(image),
            CVDEREF_P(out_charucoCorners),
            CVDEREF_P(out_charucoIds),
            CVDEREF_P(inout_markerCorners),
            CVDEREF_P(inout_markerIds)
        );
        END_WRAP
    });
}

CvStatus* cv_aruco_charucoDetector_detectDiamonds(
    CharucoDetector self,
    Mat image,
    VecVecPoint2f* out_diamondCorners,
    VecVec4i* out_diamondIds,
    VecVecPoint2f* inout_markerCorners,
    VecI32* inout_markerIds,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(self, image), [=]() -> CvStatus* {
        BEGIN_WRAP
        (*self.ptr)->detectDiamonds(
            CVDEREF(image),
            CVDEREF_P(out_diamondCorners),
            CVDEREF_P(out_diamondIds),
            CVDEREF_P(inout_markerCorners),
            CVDEREF_P(inout_markerIds)
        );
        END_WRAP
    });
}

CvStatus* cv_aruco_charucoDetector_getBoard(CharucoDetector self, CharucoBoard* rval) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoBoard((*self.ptr)->getBoard()));
    END_WRAP
}

void cv_aruco_charucoDetector_setBoard(CharucoDetector self, CharucoBoard board) {
    (*self.ptr)->setBoard(CVDEREF(board));
}

CvStatus* cv_aruco_charucoDetector_getCharucoParameters(
    CharucoDetector self,
    CharucoDetectorParams* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::CharucoParameters((*self.ptr)->getCharucoParameters()));
    END_WRAP
}

void cv_aruco_charucoDetector_setCharucoParameters(
    CharucoDetector self,
    CharucoDetectorParams params
) {
    (*self.ptr)->setCharucoParameters(CVDEREF(params));
}

CvStatus* cv_aruco_charucoDetector_getDetectorParameters(
    CharucoDetector self,
    ArucoDetectorParams* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::DetectorParameters((*self.ptr)->getDetectorParameters()));
    END_WRAP
}

void cv_aruco_charucoDetector_setDetectorParameters(
    CharucoDetector self,
    ArucoDetectorParams params
) {
    (*self.ptr)->setDetectorParameters(CVDEREF(params));
}

CvStatus* cv_aruco_charucoDetector_getRefineParameters(
    CharucoDetector self,
    ArucoRefineParams* rval
) {
    BEGIN_WRAP
    CVD_SET(rval, new cv::aruco::RefineParameters((*self.ptr)->getRefineParameters()));
    END_WRAP
}

void cv_aruco_charucoDetector_setRefineParameters(
    CharucoDetector self,
    ArucoRefineParams params
) {
    (*self.ptr)->setRefineParameters(CVDEREF(params));
}

CvStatus* cv_aruco_drawDetectedCornersCharuco(
    Mat image,
    VecPoint2f charucoCorners,
    VecI32 charucoIds,
    Scalar cornerColor,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(image, charucoCorners, charucoIds), [=]() -> CvStatus* {
        BEGIN_WRAP
        cv::Scalar _cornerColor =
            cv::Scalar(cornerColor.val1, cornerColor.val2, cornerColor.val3, cornerColor.val4);
        cv::aruco::drawDetectedCornersCharuco(
            CVDEREF(image),
            CVDEREF(charucoCorners),
            CVDEREF(charucoIds),
            _cornerColor
        );
        END_WRAP
    });
}

CvStatus* cv_aruco_estimatePoseCharucoBoard(
    VecPoint2f charucoCorners,
    VecI32 charucoIds,
    CharucoBoard board,
    Mat cameraMatrix,
    Mat distCoeffs,
    Mat rvec,
    Mat tvec,
    bool useExtrinsicGuess,
    bool* rval,
    CvCallback_0 callback
) {
    return cvd::dispatch(callback, cvd::hold(charucoCorners, charucoIds, board, cameraMatrix, distCoeffs, rvec, tvec), [=]() -> CvStatus* {
        BEGIN_WRAP
        auto boardPtr = cv::makePtr<cv::aruco::CharucoBoard>(CVDEREF(board));
        *rval = cv::aruco::estimatePoseCharucoBoard(
            CVDEREF(charucoCorners),
            CVDEREF(charucoIds),
            boardPtr,
            CVDEREF(cameraMatrix),
            CVDEREF(distCoeffs),
            CVDEREF(rvec),
            CVDEREF(tvec),
            useExtrinsicGuess
        );
        END_WRAP
    });
}
