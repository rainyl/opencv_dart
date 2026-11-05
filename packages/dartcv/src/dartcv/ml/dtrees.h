/*
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl and all contributors.
*/

#ifndef CVD_ML_DTREES_H
#define CVD_ML_DTREES_H

#include "dartcv/core/types.h"
#include "dartcv/ml/stat_model.h"
#include "dartcv/ml/train_data.h"

#ifdef __cplusplus
#include <opencv2/ml.hpp>
extern "C" {
#endif

#ifdef __cplusplus
CVD_TYPEDEF(cv::Ptr<cv::ml::DTrees>, DTrees);
#else
CVD_TYPEDEF(void*, DTrees);
#endif

/// Value copy of cv::ml::DTrees::Node.
typedef struct MlDTreesNode {
    double value;
    int classIdx;
    int parent;
    int left;
    int right;
    int defaultDir;
    int split;
} MlDTreesNode;

/// Value copy of cv::ml::DTrees::Split.
typedef struct MlDTreesSplit {
    int varIdx;
    bool inversed;
    float quality;
    int next;
    float c;
    int subsetOfs;
} MlDTreesSplit;

/// Declares the tree structure accessors of DTrees and its subclasses.
/// getNodes/getSplits copy at most `capacity` items into `rval` (which may be null) and always
/// set `count` to the total number, so callers can size a buffer with a first call.
#define CVD_ML_TREES_DECL(NAME)                                                                    \
    CvStatus* cv_ml_##NAME##_getRoots(NAME self, VecI32* rval);                                    \
    CvStatus* cv_ml_##NAME##_getSubsets(NAME self, VecI32* rval);                                  \
    CvStatus* cv_ml_##NAME##_getNodes(NAME self, MlDTreesNode* rval, int capacity, int* count);    \
    CvStatus* cv_ml_##NAME##_getSplits(NAME self, MlDTreesSplit* rval, int capacity, int* count);

CVD_ML_STAT_MODEL_DECL(DTrees)
CVD_ML_TREES_DECL(DTrees)

int cv_ml_DTrees_get_maxCategories(DTrees self);
CvStatus* cv_ml_DTrees_set_maxCategories(DTrees self, int val);
int cv_ml_DTrees_get_maxDepth(DTrees self);
CvStatus* cv_ml_DTrees_set_maxDepth(DTrees self, int val);
int cv_ml_DTrees_get_minSampleCount(DTrees self);
CvStatus* cv_ml_DTrees_set_minSampleCount(DTrees self, int val);
int cv_ml_DTrees_get_cvFolds(DTrees self);
CvStatus* cv_ml_DTrees_set_cvFolds(DTrees self, int val);
bool cv_ml_DTrees_get_useSurrogates(DTrees self);
CvStatus* cv_ml_DTrees_set_useSurrogates(DTrees self, bool val);
bool cv_ml_DTrees_get_use1SERule(DTrees self);
CvStatus* cv_ml_DTrees_set_use1SERule(DTrees self, bool val);
bool cv_ml_DTrees_get_truncatePrunedTree(DTrees self);
CvStatus* cv_ml_DTrees_set_truncatePrunedTree(DTrees self, bool val);
float cv_ml_DTrees_get_regressionAccuracy(DTrees self);
CvStatus* cv_ml_DTrees_set_regressionAccuracy(DTrees self, float val);
CvStatus* cv_ml_DTrees_getPriors(DTrees self, Mat rval);
CvStatus* cv_ml_DTrees_setPriors(DTrees self, Mat val);

#ifdef __cplusplus
}
#endif

#endif  // CVD_ML_DTREES_H
