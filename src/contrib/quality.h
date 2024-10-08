/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_QUALITY_H
#define CVD_QUALITY_H

#include "core/types.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
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

CvStatus *QualityBRISQUE_create(char *model_file, char *range_file, QualityBRISQUE *rval);
void QualityBRISQUE_close(QualityBRISQUEPtr self);
CvStatus *QualityBRISQUE_compute(QualityBRISQUE self, Mat img, Scalar *rval);
CvStatus *QualityBRISQUE_compute_static(Mat img, char *model_file, char *range_file, Scalar *rval);
CvStatus *QualityBRISQUE_computeFeatures_static(Mat img, Mat features);

CvStatus *QualityGMSD_create(Mat ref, QualityGMSD *rval);
void QualityGMSD_close(QualityGMSDPtr self);
CvStatus *QualityGMSD_compute(QualityGMSD self, Mat cmp, Scalar *rval);
CvStatus *QualityGMSD_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval);

CvStatus *QualityMSE_create(Mat ref, QualityMSE *rval);
void QualityMSE_close(QualityMSEPtr self);
CvStatus *QualityMSE_compute(QualityMSE self, Mat cmpImgs, Scalar *rval);
CvStatus *QualityMSE_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval);

CvStatus *QualityPSNR_create(Mat ref, double maxPixelValue, QualityPSNR *rval);
void QualityPSNR_close(QualityPSNRPtr self);
CvStatus *QualityPSNR_compute(QualityPSNR self, Mat cmp, Scalar *rval);
CvStatus *
QualityPSNR_compute_static(Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, Scalar *rval);
double QualityPSNR_getMaxPixelValue(QualityPSNR self);
void QualityPSNR_setMaxPixelValue(QualityPSNR self, double maxPixelValue);

CvStatus *QualitySSIM_create(Mat ref, QualitySSIM *rval);
void QualitySSIM_close(QualitySSIMPtr self);
CvStatus *QualitySSIM_compute(QualitySSIM self, Mat cmp, Scalar *rval);
CvStatus *QualitySSIM_compute_static(Mat ref, Mat cmp, Mat qualityMap, Scalar *rval);

#ifdef __cplusplus
}
#endif

#endif // CVD_QUALITY_H
