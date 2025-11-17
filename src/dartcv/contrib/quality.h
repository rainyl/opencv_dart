/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_QUALITY_H
#define CVD_QUALITY_H

#include "dartcv/core/types.h"

#ifdef __cplusplus
#include <opencv2/quality.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::quality::QualityBRISQUE>, QualityBRISQUE);
CVD_TYPEDEF(cv::Ptr<cv::quality::QualityGMSD>, QualityGMSD);
CVD_TYPEDEF(cv::Ptr<cv::quality::QualityMSE>, QualityMSE);
CVD_TYPEDEF(cv::Ptr<cv::quality::QualityPSNR>, QualityPSNR);
CVD_TYPEDEF(cv::Ptr<cv::quality::QualitySSIM>, QualitySSIM);

#else
CVD_TYPEDEF(void, QualityBRISQUE);
CVD_TYPEDEF(void, QualityGMSD);
CVD_TYPEDEF(void, QualityMSE);
CVD_TYPEDEF(void, QualityPSNR);
CVD_TYPEDEF(void, QualitySSIM);

#endif

CvStatus* cv_quality_QualityBRISQUE_create(
    const char* model_file, const char* range_file, QualityBRISQUE* rval, CvCallback_0 callback
);
void cv_quality_QualityBRISQUE_close(QualityBRISQUEPtr self);
CvStatus* cv_quality_QualityBRISQUE_compute(
    QualityBRISQUE self, Mat img, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualityBRISQUE_compute_static(
    Mat img, const char* model_file, const char* range_file, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualityBRISQUE_computeFeatures_static(
    Mat img, Mat features, CvCallback_0 callback
);

CvStatus* cv_quality_QualityGMSD_create(Mat ref, QualityGMSD* rval);
void cv_quality_QualityGMSD_close(QualityGMSDPtr self);
CvStatus* cv_quality_QualityGMSD_compute(
    QualityGMSD self, Mat cmp, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualityGMSD_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
);

CvStatus* cv_quality_QualityMSE_create(Mat ref, QualityMSE* rval, CvCallback_0 callback);
void cv_quality_QualityMSE_close(QualityMSEPtr self);
CvStatus* cv_quality_QualityMSE_compute(
    QualityMSE self, Mat cmpImgs, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualityMSE_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
);

CvStatus* cv_quality_QualityPSNR_create(
    Mat ref, double maxPixelValue, QualityPSNR* rval, CvCallback_0 callback
);
void cv_quality_QualityPSNR_close(QualityPSNRPtr self);
CvStatus* cv_quality_QualityPSNR_compute(
    QualityPSNR self, Mat cmp, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualityPSNR_compute_static(
    Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, Scalar* rval, CvCallback_0 callback
);
double cv_quality_QualityPSNR_getMaxPixelValue(QualityPSNR self);
void cv_quality_QualityPSNR_setMaxPixelValue(QualityPSNR self, double maxPixelValue);

CvStatus* cv_quality_QualitySSIM_create(Mat ref, QualitySSIM* rval, CvCallback_0 callback);
void cv_quality_QualitySSIM_close(QualitySSIMPtr self);
CvStatus* cv_quality_QualitySSIM_compute(
    QualitySSIM self, Mat cmp, Scalar* rval, CvCallback_0 callback
);
CvStatus* cv_quality_QualitySSIM_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
);

#ifdef __cplusplus
}
#endif

#endif  // CVD_QUALITY_H
