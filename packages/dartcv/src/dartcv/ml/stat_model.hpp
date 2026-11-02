/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_STAT_MODEL_HPP
#define CVD_ML_STAT_MODEL_HPP

#include "dartcv/ml/stat_model.h"
#include <string>

/// Throws instead of handing back an empty model, OpenCV returns an empty Ptr on failure.
template <typename T> inline cv::Ptr<T> cvd_ml_checked(cv::Ptr<T> p, const std::string& what) {
    if (p.empty()) {
        CV_Error(cv::Error::StsError, "Failed to load model from " + what);
    }
    return p;
}

/// An optional input: an empty (or null) Mat becomes cv::noArray().
inline cv::_InputArray cvd_or_noarray(Mat m) {
    if (m.ptr == nullptr || m.ptr->empty()) {
        return cv::_InputArray();
    }
    return cv::_InputArray(*m.ptr);
}

/// Fails for a model that is not trained. OpenCV does not always check: SVMImpl leaves var_count
/// uninitialized, so a fresh SVM can pass predict's input check and divide by zero (a SIGFPE crash
/// on x86) when the allocation reuses a freed trained SVM.
inline void cvd_ml_check_trained(const cv::ml::StatModel& model) {
    if (!model.isTrained()) {
        CV_Error(cv::Error::StsError, "The model is not trained");
    }
}

/// cv::Algorithm::save, but failing when the file can not be opened: OpenCV only logs that, and
/// models whose write() uses no FileStorage::write (e.g. KNearest) would silently save nothing.
inline void cvd_ml_save(const cv::Algorithm& model, const char* filename) {
    cv::FileStorage fs(filename, cv::FileStorage::WRITE);
    if (!fs.isOpened()) {
        CV_Error(cv::Error::StsError, std::string("Failed to open ") + filename + " for writing");
    }
    fs << model.getDefaultName() << "{";
    model.write(fs);
    fs << "}";
    fs.release();
}

/// Defines the functions declared by CVD_ML_STAT_MODEL_DECL(NAME) for the OpenCV class CVTYPE.
#define CVD_ML_STAT_MODEL_IMPL(NAME, CVTYPE)                                                       \
    CvStatus* cv_ml_##NAME##_create(NAME* rval) {                                                  \
        BEGIN_WRAP                                                                                 \
        rval->ptr = new cv::Ptr<CVTYPE>(CVTYPE::create());                                         \
        END_WRAP                                                                                   \
    }                                                                                              \
    void cv_ml_##NAME##_close(NAME##Ptr self) {                                                    \
        self->ptr->reset();                                                                        \
        CVD_FREE(self);                                                                            \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_load(const char* filepath, NAME* rval) {                              \
        BEGIN_WRAP                                                                                 \
        auto p = cvd_ml_checked(cv::Algorithm::load<CVTYPE>(filepath), filepath);                  \
        rval->ptr = new cv::Ptr<CVTYPE>(p);                                                        \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_loadFromString(                                                       \
        const char* strModel, const char* objname, NAME* rval                                      \
    ) {                                                                                            \
        BEGIN_WRAP                                                                                 \
        auto p = cvd_ml_checked(                                                                   \
            cv::Algorithm::loadFromString<CVTYPE>(strModel, objname), std::string("string")        \
        );                                                                                         \
        rval->ptr = new cv::Ptr<CVTYPE>(p);                                                        \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_save(NAME self, const char* filename) {                               \
        BEGIN_WRAP                                                                                 \
        cvd_ml_save(*CVDEREF(self), filename);                                                     \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_clear(NAME self) {                                                    \
        BEGIN_WRAP(CVDEREF(self))                                                                  \
        ->clear();                                                                                 \
        END_WRAP                                                                                   \
    }                                                                                              \
    bool cv_ml_##NAME##_empty(NAME self) {                                                         \
        return (CVDEREF(self))->empty();                                                           \
    }                                                                                              \
    bool cv_ml_##NAME##_isTrained(NAME self) {                                                     \
        return (CVDEREF(self))->isTrained();                                                       \
    }                                                                                              \
    bool cv_ml_##NAME##_isClassifier(NAME self) {                                                  \
        return (CVDEREF(self))->isClassifier();                                                    \
    }                                                                                              \
    int cv_ml_##NAME##_getVarCount(NAME self) {                                                    \
        return (CVDEREF(self))->getVarCount();                                                     \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_getDefaultName(NAME self, char** rval) {                              \
        BEGIN_WRAP                                                                                 \
        *rval = strdup((CVDEREF(self))->getDefaultName().c_str());                                 \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_train(                                                                \
        NAME self, TrainData data, int flags, bool* rval, CvCallback_0 callback                    \
    ) {                                                                                            \
        BEGIN_WRAP                                                                                 \
        *rval = (CVDEREF(self))->train(CVDEREF(data), flags);                                      \
        if (callback != nullptr) {                                                                 \
            callback();                                                                            \
        }                                                                                          \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_train_1(                                                              \
        NAME self, Mat samples, int layout, Mat responses, bool* rval, CvCallback_0 callback       \
    ) {                                                                                            \
        BEGIN_WRAP                                                                                 \
        *rval = (CVDEREF(self))->train(CVDEREF(samples), layout, CVDEREF(responses));              \
        if (callback != nullptr) {                                                                 \
            callback();                                                                            \
        }                                                                                          \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_predict(                                                              \
        NAME self, Mat samples, Mat results, int flags, float* rval, CvCallback_0 callback         \
    ) {                                                                                            \
        BEGIN_WRAP                                                                                 \
        cvd_ml_check_trained(*CVDEREF(self));                                                      \
        *rval = (CVDEREF(self))->predict(CVDEREF(samples), CVDEREF(results), flags);               \
        if (callback != nullptr) {                                                                 \
            callback();                                                                            \
        }                                                                                          \
        END_WRAP                                                                                   \
    }                                                                                              \
    CvStatus* cv_ml_##NAME##_calcError(                                                            \
        NAME self, TrainData data, bool test, Mat resp, float* rval, CvCallback_0 callback         \
    ) {                                                                                            \
        BEGIN_WRAP                                                                                 \
        cvd_ml_check_trained(*CVDEREF(self));                                                      \
        *rval = (CVDEREF(self))->calcError(CVDEREF(data), test, CVDEREF(resp));                    \
        if (callback != nullptr) {                                                                 \
            callback();                                                                            \
        }                                                                                          \
        END_WRAP                                                                                   \
    }

#endif  // CVD_ML_STAT_MODEL_HPP
