/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/
#ifndef CVD_CORE_H_
#define CVD_CORE_H_
#pragma warning(disable : 4996)

#include "dartcv/core/types.h"

#ifdef __cplusplus
extern "C" {
#endif

CvStatus* cv_RotatedRect_points(RotatedRect rect, VecPoint2f* out_pts);
CvStatus* cv_RotatedRect_boundingRect(RotatedRect rect, CvRect* rval);
CvStatus* cv_RotatedRect_boundingRect2f(RotatedRect rect, CvRect2f* rval);
// CvStatus *noArray(InputOutputArray *rval);

void CvStatus_close(CvStatus* self);

CvStatus* cv_absdiff(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_add(Mat src1, Mat src2, Mat dst, Mat mask, int dtype, CvCallback_0 callback);
CvStatus* cv_addWeighted(
    Mat src1,
    double alpha,
    Mat src2,
    double beta,
    double gamma,
    Mat dst,
    int dtype,
    CvCallback_0 callback
);
CvStatus* cv_batchDistance(
    Mat src1,
    Mat src2,
    Mat dist,
    int dtype,
    Mat nidx,
    int normType,
    int K,
    Mat mask,
    int update,
    bool crosscheck,
    CvCallback_0 callback
);
CvStatus* cv_bitwise_and(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_bitwise_and_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus* cv_bitwise_not(Mat src1, Mat dst, CvCallback_0 callback);
CvStatus* cv_bitwise_not_1(Mat src1, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus* cv_bitwise_or(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_bitwise_or_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus* cv_bitwise_xor(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_bitwise_xor_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback);
CvStatus* cv_borderInterpolate(int p, int len, int borderType, int* rval, CvCallback_0 callback);
// Broadcast the given Mat to the given shape.
//void cv::broadcast (InputArray src, InputArray shape, OutputArray dst)
CvStatus* cv_calcCovarMatrix(
    Mat samples, Mat covar, Mat mean, int flags, int ctype, CvCallback_0 callback
);
CvStatus* cv_cartToPolar(
    Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees, CvCallback_0 callback
);
CvStatus* cv_checkRange(
    Mat a, bool quiet, CvPoint* pos, double minVal, double maxVal, bool* rval, CvCallback_0 callback
);
CvStatus* cv_compare(Mat src1, Mat src2, Mat dst, int cmpop, CvCallback_0 callback);
CvStatus* cv_completeSymm(Mat m, bool lowerToUpper, CvCallback_0 callback);
CvStatus* cv_convertScaleAbs(Mat src, Mat dst, double alpha, double beta, CvCallback_0 callback);
CvStatus* cv_copyMakeBorder(
    Mat src,
    Mat dst,
    int top,
    int bottom,
    int left,
    int right,
    int borderType,
    Scalar value,
    CvCallback_0 callback
);
CvStatus* cv_copyTo(Mat src, Mat dst, Mat mask, CvCallback_0 callback);
int cv_countNonZero(Mat src);
CvStatus* cv_dct(Mat src, Mat dst, int flags, CvCallback_0 callback);
CvStatus* cv_determinant(Mat self, double* rval, CvCallback_0 callback);
CvStatus* cv_dft(Mat src, Mat dst, int flags, int nonzeroRows, CvCallback_0 callback);
CvStatus* cv_divide(Mat src1, Mat src2, Mat dst, double scale, int dtype, CvCallback_0 callback);
CvStatus* cv_eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool* rval, CvCallback_0 callback);
CvStatus* cv_eigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors, CvCallback_0 callback);
CvStatus* cv_exp(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_extractChannel(Mat src, Mat dst, int coi, CvCallback_0 callback);
CvStatus* cv_findNonZero(Mat src, Mat idx, CvCallback_0 callback);
CvStatus* cv_flip(Mat src, Mat dst, int flipCode, CvCallback_0 callback);
CvStatus* cv_flipND(Mat src, Mat dst, int axis, CvCallback_0 callback);
CvStatus* cv_gemm(
    Mat src1,
    Mat src2,
    double alpha,
    Mat src3,
    double beta,
    Mat dst,
    int flags,
    CvCallback_0 callback
);
CvStatus* cv_getOptimalDFTSize(int vecsize, int* rval, CvCallback_0 callback);
CvStatus* cv_hasNonZero(Mat src, bool* rval);
CvStatus* cv_hconcat(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_idct(Mat src, Mat dst, int flags, CvCallback_0 callback);
CvStatus* cv_idft(Mat src, Mat dst, int flags, int nonzeroRows, CvCallback_0 callback);
CvStatus* cv_inRange(Mat src, Mat lowerb, Mat upperb, Mat dst, CvCallback_0 callback);
CvStatus* cv_inRange_1(Mat src, Scalar lowerb, Scalar upperb, Mat dst, CvCallback_0 callback);
CvStatus* cv_insertChannel(Mat src, Mat dst, int coi, CvCallback_0 callback);
CvStatus* cv_invert(Mat src, Mat dst, int flags, double* rval, CvCallback_0 callback);
CvStatus* cv_log(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_LUT(Mat src, Mat lut, Mat dst, CvCallback_0 callback);
CvStatus* cv_magnitude(Mat x, Mat y, Mat magnitude, CvCallback_0 callback);
//double cv::Mahalanobis (InputArray v1, InputArray v2, InputArray icovar)
CvStatus* cv_max(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_mean(Mat src, Scalar* rval, CvCallback_0 callback);
CvStatus* cv_mean_1(Mat src, Mat mask, Scalar* rval, CvCallback_0 callback);
CvStatus* cv_meanStdDev(Mat src, Scalar* dstMean, Scalar* dstStdDev, CvCallback_0 callback);
CvStatus* cv_meanStdDev_1(
    Mat src, Scalar* dstMean, Scalar* dstStdDev, Mat mask, CvCallback_0 callback
);
CvStatus* cv_merge(VecMat mats, Mat dst, CvCallback_0 callback);
CvStatus* cv_min(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_minMaxIdx(
    Mat self,
    double* minVal,
    double* maxVal,
    int* minIdx,
    int* maxIdx,
    Mat mask,
    CvCallback_0 callback
);
CvStatus* cv_minMaxLoc(
    Mat self,
    double* minVal,
    double* maxVal,
    CvPoint* minLoc,
    CvPoint* maxLoc,
    Mat mask,
    CvCallback_0 callback
);
CvStatus* cv_mixChannels(VecMat src, VecMat dst, VecI32 fromTo, CvCallback_0 callback);
CvStatus* cv_mulSpectrums(Mat a, Mat b, Mat c, int flags, bool conjB, CvCallback_0 callback);
CvStatus* cv_multiply(Mat src1, Mat src2, Mat dst, double scale, int dtype, CvCallback_0 callback);
CvStatus* cv_mulTransposed(
    Mat src, Mat dst, bool aTa, Mat delta, double scale, int dtype, CvCallback_0 callback
);
CvStatus* cv_norm(Mat src1, int normType, Mat mask, double* rval, CvCallback_0 callback);
CvStatus* cv_norm_1(
    Mat src1, Mat src2, int normType, Mat mask, double* rval, CvCallback_0 callback
);
CvStatus* cv_normalize(
    Mat src, Mat dst, double alpha, double beta, int typ, int dtype, Mat mask, CvCallback_0 callback
);
CvStatus* cv_patchNaNs(Mat a, double val, CvCallback_0 callback);
//cv::PCABackProject (InputArray data, InputArray mean, InputArray eigenvectors, OutputArray result)
CvStatus* cv_PCABackProject(
    Mat data, Mat mean, Mat eigenvectors, Mat result, CvCallback_0 callback
);
CvStatus* cv_PCACompute(
    Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents, CvCallback_0 callback
);
// cv::PCACompute (InputArray data, InputOutputArray mean, OutputArray eigenvectors, OutputArray eigenvalues, double retainedVariance)
CvStatus* cv_PCACompute_1(
    Mat src,
    Mat mean,
    Mat eigenvectors,
    Mat eigenvalues,
    double retainedVariance,
    CvCallback_0 callback
);
// cv::PCAProject (InputArray data, InputArray mean, InputArray eigenvectors, OutputArray result)
CvStatus* cv_PCAProject(Mat data, Mat mean, Mat eigenvectors, Mat result, CvCallback_0 callback);
CvStatus* cv_perspectiveTransform(Mat src, Mat dst, Mat tm, CvCallback_0 callback);
CvStatus* cv_phase(Mat x, Mat y, Mat angle, bool angleInDegrees, CvCallback_0 callback);
CvStatus* cv_polarToCart(
    Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees, CvCallback_0 callback
);
CvStatus* cv_pow(Mat src, double power, Mat dst, CvCallback_0 callback);
//double cv::PSNR (InputArray src1, InputArray src2, double R=255.)
CvStatus* cv_PSNR(Mat src1, Mat src2, double R, double* rval, CvCallback_0 callback);
CvStatus* cv_randn(Mat mat, Scalar mean, Scalar stddev, CvCallback_0 callback);
CvStatus* cv_randShuffle(Mat mat, CvCallback_0 callback);
CvStatus* cv_randShuffle_1(Mat mat, double iterFactor, RNG rng, CvCallback_0 callback);
CvStatus* cv_randu(Mat mat, Scalar low, Scalar high, CvCallback_0 callback);
CvStatus* cv_reduce(Mat src, Mat dst, int dim, int rType, int dType, CvCallback_0 callback);
CvStatus* cv_reduceArgMax(Mat src, Mat dst, int axis, bool lastIndex, CvCallback_0 callback);
CvStatus* cv_reduceArgMin(Mat src, Mat dst, int axis, bool lastIndex, CvCallback_0 callback);
CvStatus* cv_repeat(Mat src, int nY, int nX, Mat dst, CvCallback_0 callback);
CvStatus* cv_rotate(Mat src, Mat dst, int rotateCode, CvCallback_0 callback);
CvStatus* cv_scaleAdd(Mat src1, double alpha, Mat src2, Mat dst, CvCallback_0 callback);
CvStatus* cv_setIdentity(Mat src, Scalar scalar, CvCallback_0 callback);
CvStatus* cv_solve(Mat src1, Mat src2, Mat dst, int flags, bool* rval, CvCallback_0 callback);
CvStatus* cv_solveCubic(Mat coeffs, Mat roots, int* rval, CvCallback_0 callback);
CvStatus* cv_solvePoly(Mat coeffs, Mat roots, int maxIters, double* rval, CvCallback_0 callback);
CvStatus* cv_sort(Mat src, Mat dst, int flags, CvCallback_0 callback);
CvStatus* cv_sortIdx(Mat src, Mat dst, int flags, CvCallback_0 callback);
CvStatus* cv_split(Mat src, VecMat* out_rval, CvCallback_0 callback);
CvStatus* cv_sqrt(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_subtract(Mat src1, Mat src2, Mat dst, Mat mask, int dtype, CvCallback_0 callback);
CvStatus* cv_sum(Mat src, Scalar* rval, CvCallback_0 callback);
//void cv::SVBackSubst (InputArray w, InputArray u, InputArray vt, InputArray rhs, OutputArray dst)
CvStatus* cv_SVBackSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat dst, CvCallback_0 callback);
//void cv::SVDecomp (InputArray src, OutputArray w, OutputArray u, OutputArray vt, int flags=0)
CvStatus* cv_SVDecomp(Mat w, Mat u, Mat vt, Mat d, int flags, CvCallback_0 callback);
CvStatus* cv_trace(Mat src, Scalar* rval, CvCallback_0 callback);
CvStatus* cv_transform(Mat src, Mat dst, Mat tm, CvCallback_0 callback);
CvStatus* cv_transpose(Mat src, Mat dst, CvCallback_0 callback);
CvStatus* cv_transposeND(Mat src, Mat dst, VecI32 order, CvCallback_0 callback);
CvStatus* cv_vconcat(Mat src1, Mat src2, Mat dst, CvCallback_0 callback);

CvStatus* cv_kmeans(
    Mat data,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    Mat centers,
    double* rval,
    CvCallback_0 callback
);
CvStatus* cv_kmeans_points(
    VecPoint2f pts,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    Mat centers,
    double* rval,
    CvCallback_0 callback
);

CvStatus* cv_RNG_create(RNG* rval);
CvStatus* cv_RNG_create_1(uint64_t state, RNG* rval);
void cv_RNG_close(RNGPtr rng);
CvStatus* cv_RNG_fill(
    RNG rng, Mat mat, int distType, double a, double b, bool saturateRange, CvCallback_0 callback
);
CvStatus* cv_RNG_gaussian(RNG rng, double sigma, double* rval);
CvStatus* cv_RNG_uniform(RNG rng, int a, int b, int* rval);
CvStatus* cv_RNG_uniformDouble(RNG rng, double a, double b, double* rval);
CvStatus* cv_RNG_next(RNG rng, uint32_t* rval);

CvStatus* cv_theRNG(RNGPtr rval);
CvStatus* cv_setRNGSeed(int seed);

int64_t cv_getTickCount(void);
double_t cv_getTickFrequency(void);
void cv_setNumThreads(int n);
int cv_getNumThreads(void);

#ifdef __cplusplus
}
#endif

#endif  //CVD_CORE_H_
