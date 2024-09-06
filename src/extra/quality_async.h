/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#ifndef CVD_QUALITY_ASYNC_H
#define CVD_QUALITY_ASYNC_H

#include "core/types.h"
#include "quality.h"

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

CvStatus *QualityBRISQUE_compute_async(QualityBRISQUE self, Mat img, CvCallback_1 callback);
CvStatus *QualityBRISQUE_compute_static_async(Mat img, char *model_file, char *range_file, CvCallback_1 callback);
CvStatus *QualityBRISQUE_computeFeatures_static_async(Mat img, Mat features, CvCallback_0 callback);

CvStatus *QualityGMSD_compute_async(QualityGMSD self, Mat cmp, CvCallback_1 callback);
CvStatus *QualityGMSD_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback);

CvStatus *QualityMSE_compute_async(QualityMSE self, Mat cmpImgs, CvCallback_1 callback);
CvStatus *QualityMSE_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback);

CvStatus *QualityPSNR_compute_async(QualityPSNR self, Mat cmp, CvCallback_1 callback);
CvStatus *
QualityPSNR_compute_static_async(Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, CvCallback_1 callback);

CvStatus *QualitySSIM_compute_async(QualitySSIM self, Mat cmp, CvCallback_1 callback);
CvStatus *QualitySSIM_compute_static_async(Mat ref, Mat cmp, Mat qualityMap, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif // CVD_QUALITY_ASYNC_H
