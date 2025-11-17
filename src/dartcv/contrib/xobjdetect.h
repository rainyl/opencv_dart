/*
    Created by rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 rainyl.
*/
#ifndef CVD_XOBJDETECT_H
#define CVD_XOBJDETECT_H

#include "dartcv/core/types.h"
#ifdef __cplusplus
#include <opencv2/xobjdetect.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::xobjdetect::WBDetector>, PtrWBDetector)
#else
CVD_TYPEDEF(void*, PtrWBDetector)
#endif

CvStatus* cv_xobjdetect_WBDetector_create(PtrWBDetector* rval);
void cv_xobjdetect_WBDetector_close(PtrWBDetectorPtr self);
CvStatus* cv_xobjdetect_WBDetector_detect(
    PtrWBDetector self, Mat img, CVD_OUT VecRect* out_bbox, CVD_OUT VecF64* confidences
);
CvStatus* cv_xobjdetect_WBDetector_train(
    PtrWBDetector self, const char* pos_samples, const char* neg_imgs
);
CvStatus* cv_xobjdetect_WBDetector_read(PtrWBDetector self, const char* filename);
CvStatus* cv_xobjdetect_WBDetector_write(PtrWBDetector self, const char* filename);

#ifdef __cplusplus
}
#endif

#endif  // CVD_XOBJDETECT_H
