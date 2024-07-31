/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XOBJDETECT_H
#define CVD_XOBJDETECT_H

#include "../core/core.h"
#ifdef __cplusplus
#include <opencv2/opencv.hpp>
#include <opencv2/xobjdetect.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::xobjdetect::WBDetector>, PtrWBDetector)
#else
CVD_TYPEDEF(void *, PtrWBDetector)
#endif

CvStatus *WBDetector_Create(PtrWBDetector *rval);
void      WBDetector_Close(PtrWBDetectorPtr self);
CvStatus *WBDetector_Detect(PtrWBDetector *self, Mat img, CVD_OUT VecRect *bbox,
                            CVD_OUT VecF64 *confidences);
CvStatus *WBDetector_Train(PtrWBDetector *self, char *pos_samples, char *neg_imgs);
CvStatus *WBDetector_Read(PtrWBDetector *self, char *filename);
CvStatus *WBDetector_Write(PtrWBDetector *self, char *filename);

#ifdef __cplusplus
}
#endif

#endif // CVD_XOBJDETECT_H
