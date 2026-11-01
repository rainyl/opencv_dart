/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_STAT_MODEL_H
#define CVD_ML_STAT_MODEL_H

#include "dartcv/ml/train_data.h"

/// Declares the cv::Algorithm / cv::ml::StatModel functions shared by every model type.
/// `load` and `loadFromString` fail instead of returning an empty model.
#define CVD_ML_STAT_MODEL_DECL(NAME)                                                               \
    CvStatus* cv_ml_##NAME##_create(NAME* rval);                                                   \
    void cv_ml_##NAME##_close(NAME##Ptr self);                                                     \
    CvStatus* cv_ml_##NAME##_load(const char* filepath, NAME* rval);                               \
    CvStatus* cv_ml_##NAME##_loadFromString(                                                       \
        const char* strModel, const char* objname, NAME* rval                                      \
    );                                                                                             \
    CvStatus* cv_ml_##NAME##_save(NAME self, const char* filename);                                \
    CvStatus* cv_ml_##NAME##_clear(NAME self);                                                     \
    bool cv_ml_##NAME##_empty(NAME self);                                                          \
    bool cv_ml_##NAME##_isTrained(NAME self);                                                      \
    bool cv_ml_##NAME##_isClassifier(NAME self);                                                   \
    int cv_ml_##NAME##_getVarCount(NAME self);                                                     \
    CvStatus* cv_ml_##NAME##_getDefaultName(NAME self, char** rval);                               \
    CvStatus* cv_ml_##NAME##_train(                                                                \
        NAME self, TrainData data, int flags, bool* rval, CvCallback_0 callback                    \
    );                                                                                             \
    CvStatus* cv_ml_##NAME##_train_1(                                                              \
        NAME self, Mat samples, int layout, Mat responses, bool* rval, CvCallback_0 callback       \
    );                                                                                             \
    CvStatus* cv_ml_##NAME##_predict(                                                              \
        NAME self, Mat samples, Mat results, int flags, float* rval, CvCallback_0 callback         \
    );                                                                                             \
    CvStatus* cv_ml_##NAME##_calcError(                                                            \
        NAME self, TrainData data, bool test, Mat resp, float* rval, CvCallback_0 callback         \
    );

#endif  // CVD_ML_STAT_MODEL_H
