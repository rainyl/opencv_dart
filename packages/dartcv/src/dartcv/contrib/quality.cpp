#include "dartcv/contrib/quality.h"

CvStatus* cv_quality_QualityBRISQUE_create(
    const char* model_file, const char* range_file, QualityBRISQUE* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::Ptr<cv::quality::QualityBRISQUE>(
        cv::quality::QualityBRISQUE::create(model_file, range_file)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_quality_QualityBRISQUE_close(QualityBRISQUEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_quality_QualityBRISQUE_compute(
    QualityBRISQUE self, Mat img, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = (CVDEREF(self))->compute(CVDEREF(img));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityBRISQUE_compute_static(
    Mat img, const char* model_file, const char* range_file, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = cv::quality::QualityBRISQUE::compute(CVDEREF(img), model_file, range_file);
    if (callback != nullptr) {
        callback();
    }
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    END_WRAP
}

CvStatus* cv_quality_QualityBRISQUE_computeFeatures_static(
    Mat img, Mat features, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::quality::QualityBRISQUE::computeFeatures(CVDEREF(img), CVDEREF(features));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityGMSD_create(Mat ref, QualityGMSD* rval) {
    BEGIN_WRAP
    rval->ptr =
        new cv::Ptr<cv::quality::QualityGMSD>(cv::quality::QualityGMSD::create(CVDEREF(ref)));
    END_WRAP
}

void cv_quality_QualityGMSD_close(QualityGMSDPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_quality_QualityGMSD_compute(
    QualityGMSD self, Mat cmp, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = (CVDEREF(self))->compute(CVDEREF(cmp));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityGMSD_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r =
        cv::quality::QualityGMSD::compute(CVDEREF(ref), CVDEREF(cmp), CVDEREF(qualityMap));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityMSE_create(Mat ref, QualityMSE* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::quality::QualityMSE>(cv::quality::QualityMSE::create(CVDEREF(ref)))};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_quality_QualityMSE_close(QualityMSEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_quality_QualityMSE_compute(
    QualityMSE self, Mat cmpImgs, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = (CVDEREF(self))->compute(CVDEREF(cmpImgs));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityMSE_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r =
        cv::quality::QualityMSE::compute(CVDEREF(ref), CVDEREF(cmp), CVDEREF(qualityMap));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityPSNR_create(
    Mat ref, double maxPixelValue, QualityPSNR* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::quality::QualityPSNR>(
        cv::quality::QualityPSNR::create(CVDEREF(ref), maxPixelValue)
    )};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_quality_QualityPSNR_close(QualityPSNRPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_quality_QualityPSNR_compute(
    QualityPSNR self, Mat cmp, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = (CVDEREF(self))->compute(CVDEREF(cmp));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualityPSNR_compute_static(
    Mat ref, Mat cmp, double maxPixelValue, Mat qualityMap, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = cv::quality::QualityPSNR::compute(
        CVDEREF(ref), CVDEREF(cmp), CVDEREF(qualityMap), maxPixelValue
    );
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

double cv_quality_QualityPSNR_getMaxPixelValue(QualityPSNR self) {
    return (CVDEREF(self))->getMaxPixelValue();
}

void cv_quality_QualityPSNR_setMaxPixelValue(QualityPSNR self, double maxPixelValue) {
    (CVDEREF(self))->setMaxPixelValue(maxPixelValue);
}

CvStatus* cv_quality_QualitySSIM_create(Mat ref, QualitySSIM* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::quality::QualitySSIM>(cv::quality::QualitySSIM::create(CVDEREF(ref)))};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

void cv_quality_QualitySSIM_close(QualitySSIMPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_quality_QualitySSIM_compute(
    QualitySSIM self, Mat cmp, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r = (CVDEREF(self))->compute(CVDEREF(cmp));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_quality_QualitySSIM_compute_static(
    Mat ref, Mat cmp, Mat qualityMap, Scalar* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar r =
        cv::quality::QualitySSIM::compute(CVDEREF(ref), CVDEREF(cmp), CVDEREF(qualityMap));
    *rval = {r.val[0], r.val[1], r.val[2], r.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
