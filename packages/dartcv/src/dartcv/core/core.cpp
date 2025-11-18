#include "dartcv/core/core.h"
#include "dartcv/core/lut.hpp"
#include "dartcv/core/vec.hpp"
#include "dartcv/core/stdvec.h"

#include <cstddef>
#include <cstdlib>
#include <cstring>
#include <vector>

CvStatus* cv_RotatedRect_points(RotatedRect rect, VecPoint2f* out_pts) {
    BEGIN_WRAP
    auto r = cv::RotatedRect(
        cv::Point2f(rect.center.x, rect.center.y),
        cv::Size2f(rect.size.width, rect.size.height),
        rect.angle
    );
    r.points(CVDEREF_P(out_pts));
    END_WRAP
}

CvStatus* cv_RotatedRect_boundingRect(RotatedRect rect, CvRect* rval) {
    BEGIN_WRAP
    auto r = cv::RotatedRect(
        cv::Point2f(rect.center.x, rect.center.y),
        cv::Size2f(rect.size.width, rect.size.height),
        rect.angle
    );
    auto rr = r.boundingRect();
    *rval = {rr.x, rr.y, rr.width, rr.height};
    END_WRAP
}

CvStatus* cv_RotatedRect_boundingRect2f(RotatedRect rect, CvRect2f* rval) {
    BEGIN_WRAP
    auto r = cv::RotatedRect(
        cv::Point2f(rect.center.x, rect.center.y),
        cv::Size2f(rect.size.width, rect.size.height),
        rect.angle
    );
    auto rr = r.boundingRect2f();
    *rval = {rr.x, rr.y, rr.width, rr.height};
    END_WRAP
}

void CvStatus_close(CvStatus* self) {
    if (self->err != nullptr) {
        free(self->err);
        self->err = nullptr;
    }
    if (self->file != nullptr) {
        free(self->file);
        self->file = nullptr;
    }
    if (self->msg != nullptr) {
        free(self->msg);
        self->msg = nullptr;
    }
    if (self->func != nullptr) {
        free(self->func);
        self->func = nullptr;
    }
    delete self;
}

CvStatus* cv_absdiff(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::absdiff(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_add(Mat src1, Mat src2, Mat dst, Mat mask, int dtype, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::add(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask), dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_addWeighted(
    Mat src1,
    double alpha,
    Mat src2,
    double beta,
    double gamma,
    Mat dst,
    int dtype,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::addWeighted(CVDEREF(src1), alpha, CVDEREF(src2), beta, gamma, CVDEREF(dst), dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_and(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_and(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_and_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_and(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_not(Mat src1, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_not(CVDEREF(src1), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_not_1(Mat src1, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_not(CVDEREF(src1), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_or(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_or(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_or_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_or(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_xor(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_xor(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_bitwise_xor_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bitwise_xor(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_compare(Mat src1, Mat src2, Mat dst, int cmpop, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::compare(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), cmpop);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
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
) {
    BEGIN_WRAP
    cv::batchDistance(
        CVDEREF(src1),
        CVDEREF(src2),
        CVDEREF(dist),
        dtype,
        CVDEREF(nidx),
        normType,
        K,
        CVDEREF(mask),
        update,
        crosscheck
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_borderInterpolate(int p, int len, int borderType, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::borderInterpolate(p, len, borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_calcCovarMatrix(
    Mat samples, Mat covar, Mat mean, int flags, int ctype, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::calcCovarMatrix(CVDEREF(samples), CVDEREF(covar), CVDEREF(mean), flags, ctype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_cartToPolar(
    Mat x, Mat y, Mat magnitude, Mat angle, bool angleInDegrees, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::cartToPolar(CVDEREF(x), CVDEREF(y), CVDEREF(magnitude), CVDEREF(angle), angleInDegrees);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_checkRange(
    Mat a, bool quiet, CvPoint* pos, double minVal, double maxVal, bool* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Point pos1;
    *rval = cv::checkRange(CVDEREF(a), quiet, &pos1, minVal, maxVal);
    pos->x = pos1.x;
    pos->y = pos1.y;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_completeSymm(Mat m, bool lowerToUpper, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::completeSymm(CVDEREF(m), lowerToUpper);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_convertScaleAbs(Mat src, Mat dst, double alpha, double beta, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::convertScaleAbs(CVDEREF(src), CVDEREF(dst), alpha, beta);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
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
) {
    BEGIN_WRAP
    cv::Scalar c_value(value.val1, value.val2, value.val3, value.val4);
    cv::copyMakeBorder(CVDEREF(src), CVDEREF(dst), top, bottom, left, right, borderType, c_value);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_copyTo(Mat src, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::copyTo(CVDEREF(src), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

int cv_countNonZero(Mat src) {
    return cv::countNonZero(CVDEREF(src));
}
CvStatus* cv_dct(Mat src, Mat dst, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::dct(CVDEREF(src), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_determinant(Mat self, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::determinant(CVDEREF(self));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_dft(Mat src, Mat dst, int flags, int nonzeroRows, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::dft(CVDEREF(src), CVDEREF(dst), flags, nonzeroRows);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_divide(Mat src1, Mat src2, Mat dst, double scale, int dtype, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::divide(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), scale, dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_eigen(Mat src, Mat eigenvalues, Mat eigenvectors, bool* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::eigen(CVDEREF(src), CVDEREF(eigenvalues), CVDEREF(eigenvectors));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_eigenNonSymmetric(Mat src, Mat eigenvalues, Mat eigenvectors, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::eigenNonSymmetric(CVDEREF(src), CVDEREF(eigenvalues), CVDEREF(eigenvectors));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_PCACompute(
    Mat src, Mat mean, Mat eigenvectors, Mat eigenvalues, int maxComponents, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::PCACompute(
        CVDEREF(src), CVDEREF(mean), CVDEREF(eigenvectors), CVDEREF(eigenvalues), maxComponents
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_exp(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::exp(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_extractChannel(Mat src, Mat dst, int coi, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::extractChannel(CVDEREF(src), CVDEREF(dst), coi);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_findNonZero(Mat src, Mat idx, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::findNonZero(CVDEREF(src), CVDEREF(idx));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_flip(Mat src, Mat dst, int flipCode, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::flip(CVDEREF(src), CVDEREF(dst), flipCode);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_flipND(Mat src, Mat dst, int axis, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::flipND(CVDEREF(src), CVDEREF(dst), axis);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_gemm(
    Mat src1,
    Mat src2,
    double alpha,
    Mat src3,
    double beta,
    Mat dst,
    int flags,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::gemm(CVDEREF(src1), CVDEREF(src2), alpha, CVDEREF(src3), beta, CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_getOptimalDFTSize(int vecsize, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::getOptimalDFTSize(vecsize);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_hasNonZero(Mat src, bool* rval) {
    BEGIN_WRAP
    *rval = cv::hasNonZero(CVDEREF(src));
    END_WRAP
}

CvStatus* cv_hconcat(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::hconcat(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_vconcat(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::vconcat(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_idct(Mat src, Mat dst, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::idct(CVDEREF(src), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_idft(Mat src, Mat dst, int flags, int nonzeroRows, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::idft(CVDEREF(src), CVDEREF(dst), flags, nonzeroRows);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_inRange(Mat src, Mat lowerb, Mat upperb, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::inRange(CVDEREF(src), CVDEREF(lowerb), CVDEREF(upperb), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_inRange_1(
    Mat src, const Scalar lowerb, const Scalar upperb, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar lb(lowerb.val1, lowerb.val2, lowerb.val3, lowerb.val4);
    cv::Scalar ub(upperb.val1, upperb.val2, upperb.val3, upperb.val4);
    cv::inRange(CVDEREF(src), lb, ub, CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_insertChannel(Mat src, Mat dst, int coi, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::insertChannel(CVDEREF(src), CVDEREF(dst), coi);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_invert(Mat src, Mat dst, int flags, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::invert(CVDEREF(src), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_log(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::log(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_magnitude(Mat x, Mat y, Mat magnitude, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::magnitude(CVDEREF(x), CVDEREF(y), CVDEREF(magnitude));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_max(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::max(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_mean(Mat src, Scalar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar mean = cv::mean(CVDEREF(src));
    *rval = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_mean_1(Mat src, Mat mask, Scalar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar mean = cv::mean(CVDEREF(src), CVDEREF(mask));
    *rval = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_meanStdDev(Mat src, Scalar* dstMean, Scalar* dstStdDev, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar mean, sd;
    cv::meanStdDev(CVDEREF(src), mean, sd);
    *dstMean = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
    *dstStdDev = {sd.val[0], sd.val[1], sd.val[2], sd.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_meanStdDev_1(
    Mat src, Scalar* dstMean, Scalar* dstStdDev, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scalar mean, sd;
    cv::meanStdDev(CVDEREF(src), mean, sd, CVDEREF(mask));
    *dstMean = {mean.val[0], mean.val[1], mean.val[2], mean.val[3]};
    *dstStdDev = {sd.val[0], sd.val[1], sd.val[2], sd.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_merge(VecMat mats, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::merge(CVDEREF(mats), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_min(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::min(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_minMaxIdx(
    Mat self,
    double* minVal,
    double* maxVal,
    int* minIdx,
    int* maxIdx,
    Mat mask,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::minMaxIdx(CVDEREF(self), minVal, maxVal, minIdx, maxIdx, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_minMaxLoc(
    Mat self,
    double* minVal,
    double* maxVal,
    CvPoint* minLoc,
    CvPoint* maxLoc,
    Mat mask,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Point cMinLoc, cMaxLoc;
    cv::minMaxLoc(CVDEREF(self), minVal, maxVal, &cMinLoc, &cMaxLoc, CVDEREF(mask));
    *minLoc = {cMinLoc.x, cMinLoc.y};
    *maxLoc = {cMaxLoc.x, cMaxLoc.y};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_mixChannels(VecMat src, VecMat dst, VecI32 fromTo, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::mixChannels(CVDEREF(src), CVDEREF(dst), CVDEREF(fromTo));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_mulSpectrums(Mat a, Mat b, Mat c, int flags, bool conjB, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::mulSpectrums(CVDEREF(a), CVDEREF(b), CVDEREF(c), flags, conjB);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_multiply(Mat src1, Mat src2, Mat dst, double scale, int dtype, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::multiply(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), scale, dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_mulTransposed(
    Mat src, Mat dst, bool aTa, Mat delta, double scale, int dtype, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::mulTransposed(CVDEREF(src), CVDEREF(dst), aTa, CVDEREF(delta), scale, dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_normalize(
    Mat src, Mat dst, double alpha, double beta, int typ, int dtype, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::normalize(CVDEREF(src), CVDEREF(dst), alpha, beta, typ, dtype, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_patchNaNs(Mat a, double val, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::patchNaNs(CVDEREF(a), val);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_PCABackProject(
    Mat data, Mat mean, Mat eigenvectors, Mat result, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::PCABackProject(CVDEREF(data), CVDEREF(mean), CVDEREF(eigenvectors), CVDEREF(result));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_PCACompute_1(
    Mat src,
    Mat mean,
    Mat eigenvectors,
    Mat eigenvalues,
    double retainedVariance,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::PCACompute(
        CVDEREF(src), CVDEREF(mean), CVDEREF(eigenvectors), CVDEREF(eigenvalues), retainedVariance
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_PCAProject(Mat data, Mat mean, Mat eigenvectors, Mat result, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::PCAProject(CVDEREF(data), CVDEREF(mean), CVDEREF(eigenvectors), CVDEREF(result));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_perspectiveTransform(Mat src, Mat dst, Mat tm, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::perspectiveTransform(CVDEREF(src), CVDEREF(dst), CVDEREF(tm));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_PSNR(Mat src1, Mat src2, double R, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::PSNR(CVDEREF(src1), CVDEREF(src2), R);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_solve(Mat src1, Mat src2, Mat dst, int flags, bool* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::solve(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_solveCubic(Mat coeffs, Mat roots, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::solveCubic(CVDEREF(coeffs), CVDEREF(roots));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_solvePoly(Mat coeffs, Mat roots, int maxIters, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::solvePoly(CVDEREF(coeffs), CVDEREF(roots), maxIters);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_reduce(Mat src, Mat dst, int dim, int rType, int dType, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::reduce(CVDEREF(src), CVDEREF(dst), dim, rType, dType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_reduceArgMax(Mat src, Mat dst, int axis, bool lastIndex, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::reduceArgMax(CVDEREF(src), CVDEREF(dst), axis, lastIndex);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_reduceArgMin(Mat src, Mat dst, int axis, bool lastIndex, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::reduceArgMin(CVDEREF(src), CVDEREF(dst), axis, lastIndex);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_repeat(Mat src, int nY, int nX, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::repeat(CVDEREF(src), nY, nX, CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_scaleAdd(Mat src1, double alpha, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::scaleAdd(CVDEREF(src1), alpha, CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_setIdentity(Mat src, Scalar scalar, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar _s(scalar.val1, scalar.val2, scalar.val3, scalar.val4);
    cv::setIdentity(CVDEREF(src), _s);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_sort(Mat src, Mat dst, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::sort(CVDEREF(src), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_sortIdx(Mat src, Mat dst, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::sortIdx(CVDEREF(src), CVDEREF(dst), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_split(Mat src, VecMat* out_rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::split(CVDEREF(src), CVDEREF_P(out_rval));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_sqrt(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::sqrt(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_subtract(Mat src1, Mat src2, Mat dst, Mat mask, int dtype, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::subtract(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask), dtype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_trace(Mat src, Scalar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar c = cv::trace(CVDEREF(src));
    *rval = {c.val[0], c.val[1], c.val[2], c.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_transform(Mat src, Mat dst, Mat tm, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::transform(CVDEREF(src), CVDEREF(dst), CVDEREF(tm));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_transpose(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::transpose(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_transposeND(Mat src, Mat dst, VecI32 order, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::transposeND(CVDEREF(src), CVDEREF(order), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_polarToCart(
    Mat magnitude, Mat degree, Mat x, Mat y, bool angleInDegrees, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::polarToCart(CVDEREF(magnitude), CVDEREF(degree), CVDEREF(x), CVDEREF(y), angleInDegrees);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_pow(Mat src, double power, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::pow(CVDEREF(src), power, CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_phase(Mat x, Mat y, Mat angle, bool angleInDegrees, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::phase(CVDEREF(x), CVDEREF(y), CVDEREF(angle), angleInDegrees);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_sum(Mat src, Scalar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Scalar c = cv::sum(CVDEREF(src));
    *rval = {c.val[0], c.val[1], c.val[2], c.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SVBackSubst(Mat w, Mat u, Mat vt, Mat rhs, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::SVBackSubst(CVDEREF(w), CVDEREF(u), CVDEREF(vt), CVDEREF(rhs), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_SVDecomp(Mat w, Mat u, Mat vt, Mat d, int flags, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::SVDecomp(CVDEREF(w), CVDEREF(u), CVDEREF(vt), CVDEREF(d), flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

// https://docs.opencv.org/4.x/db/da5/tutorial_how_to_scan_images.html#:~:text=Goal
CvStatus* cv_LUT(Mat src, Mat lut, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    auto cn = src.ptr->channels(), depth = src.ptr->depth();
    if (depth == CV_8U || depth == CV_8S) {
        cv::LUT(CVDEREF(src), CVDEREF(lut), CVDEREF(dst));
    } else {
        int lutcn = lut.ptr->channels(), lut_depth = lut.ptr->depth();
        size_t lut_total = lut.ptr->total(), expect_total = 0;
        switch (depth) {
            case CV_8U:
            case CV_8S:
                expect_total = 256;
                break;
            case CV_16U:
            case CV_16S:
                expect_total = 65536;
                break;
            // TODO: can't create a mat with 4294967296 rows, maybe use vector instead
            // case CV_32S:
            //   expect_total = 4294967296;
            //   break;
            default:
                throw cv::Exception(
                    cv::Error::StsNotImplemented,
                    "source Mat Type not supported",
                    __func__,
                    __FILE__,
                    __LINE__
                );
        }

        CV_Assert(
            (lutcn == cn || lutcn == 1) && lut_total == expect_total && lut.ptr->isContinuous()
        );
        dst.ptr->create(src.ptr->dims, src.ptr->size, CV_MAKETYPE(lut.ptr->depth(), cn));

        const cv::Mat* arrays[] = {src.ptr, dst.ptr, nullptr};
        uchar* ptrs[2] = {};
        cv::NAryMatIterator it(arrays, ptrs);
        int len = (int)it.size;

        switch (depth) {
            case CV_8U:
                cvd::LUT8u_16f(
                    src.ptr->ptr<uchar>(),
                    lut.ptr->ptr<cv::hfloat>(),
                    dst.ptr->ptr<cv::hfloat>(),
                    len,
                    cn,
                    lutcn
                );
                break;
            case CV_8S:
                cvd::LUT8s_16f(
                    src.ptr->ptr<char>(),
                    lut.ptr->ptr<cv::hfloat>(),
                    dst.ptr->ptr<cv::hfloat>(),
                    len,
                    cn,
                    lutcn
                );
                break;

            case CV_16U:
                switch (lut_depth) {
                    case CV_8U:
                        cvd::LUT16u_8u(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<uchar>(),
                            dst.ptr->ptr<uchar>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_8S:
                        cvd::LUT16u_8s(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<char>(),
                            dst.ptr->ptr<char>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16U:
                        cvd::LUT16u_16u(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<ushort>(),
                            dst.ptr->ptr<ushort>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16S:
                        cvd::LUT16u_16s(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<short>(),
                            dst.ptr->ptr<short>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_32S:
                        cvd::LUT16u_32s(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<int>(),
                            dst.ptr->ptr<int>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_32F:
                        cvd::LUT16u_32f(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<float>(),
                            dst.ptr->ptr<float>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_64F:
                        cvd::LUT16u_64f(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<double>(),
                            dst.ptr->ptr<double>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16F:
                        cvd::LUT16u_16f(
                            src.ptr->ptr<ushort>(),
                            lut.ptr->ptr<cv::hfloat>(),
                            dst.ptr->ptr<cv::hfloat>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    default:
                        cv::String err = "lut Mat Type not supported for CV_16U";
                        throw cv::Exception(
                            cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__
                        );
                }
                break;
            case CV_16S:
                switch (lut_depth) {
                    case CV_8U:
                        cvd::LUT16s_8u(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<uchar>(),
                            dst.ptr->ptr<uchar>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_8S:
                        cvd::LUT16s_8s(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<char>(),
                            dst.ptr->ptr<char>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16U:
                        cvd::LUT16s_16u(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<ushort>(),
                            dst.ptr->ptr<ushort>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16S:
                        cvd::LUT16s_16s(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<short>(),
                            dst.ptr->ptr<short>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_32S:
                        cvd::LUT16s_32s(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<int>(),
                            dst.ptr->ptr<int>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_32F:
                        cvd::LUT16s_32f(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<float>(),
                            dst.ptr->ptr<float>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_64F:
                        cvd::LUT16s_64f(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<double>(),
                            dst.ptr->ptr<double>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_16F:
                        cvd::LUT16s_16f(
                            src.ptr->ptr<short>(),
                            lut.ptr->ptr<cv::hfloat>(),
                            dst.ptr->ptr<cv::hfloat>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    default:
                        cv::String err = "lut Mat Type not supported for CV_16S";
                        throw cv::Exception(
                            cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__
                        );
                }
                break;
            case CV_32S:
                switch (lut_depth) {
                    case CV_32S:
                        cvd::LUT32s_32s(
                            src.ptr->ptr<int>(),
                            lut.ptr->ptr<int>(),
                            dst.ptr->ptr<int>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_32F:
                        cvd::LUT32s_32f(
                            src.ptr->ptr<int>(),
                            lut.ptr->ptr<float>(),
                            dst.ptr->ptr<float>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    case CV_64F:
                        cvd::LUT32s_64f(
                            src.ptr->ptr<int>(),
                            lut.ptr->ptr<double>(),
                            dst.ptr->ptr<double>(),
                            len,
                            cn,
                            lutcn
                        );
                        break;
                    default:
                        cv::String err = "lut Mat Type not supported for CV_32S";
                        throw cv::Exception(
                            cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__
                        );
                }
                break;
            default:
                cv::String err = "src Mat Type not supported";
                throw cv::Exception(
                    cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__
                );
        }
    }
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
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
) {
    BEGIN_WRAP
    auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
    *rval =
        cv::kmeans(CVDEREF(data), k, CVDEREF(bestLabels), tc, attempts, flags, CVDEREF(centers));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
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
) {
    BEGIN_WRAP
    auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
    *rval = cv::kmeans(CVDEREF(pts), k, CVDEREF(bestLabels), tc, attempts, flags, CVDEREF(centers));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_rotate(Mat src, Mat dst, int rotateCode, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::rotate(CVDEREF(src), CVDEREF(dst), rotateCode);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_norm(Mat src1, int normType, Mat mask, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::norm(CVDEREF(src1), normType, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_norm_1(
    Mat src1, Mat src2, int normType, Mat mask, double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::norm(CVDEREF(src1), CVDEREF(src2), normType, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_RNG_create(RNG* rval) {
    BEGIN_WRAP
    *rval = {new cv::RNG()};
    END_WRAP
}
CvStatus* cv_RNG_create_1(uint64_t state, RNG* rval) {
    BEGIN_WRAP
    *rval = {new cv::RNG(state)};
    END_WRAP
}
void cv_RNG_close(RNGPtr rng) {
    CVD_FREE(rng);
}
CvStatus* cv_RNG_fill(
    RNG rng, Mat mat, int distType, double a, double b, bool saturateRange, CvCallback_0 callback
) {
    BEGIN_WRAP
    rng.ptr->fill(CVDEREF(mat), distType, a, b, saturateRange);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_RNG_gaussian(RNG rng, double sigma, double* rval) {
    BEGIN_WRAP
    *rval = rng.ptr->gaussian(sigma);
    END_WRAP
}
CvStatus* cv_RNG_uniform(RNG rng, int a, int b, int* rval) {
    BEGIN_WRAP
    *rval = rng.ptr->uniform(a, b);
    END_WRAP
}
CvStatus* cv_RNG_uniformDouble(RNG rng, double a, double b, double* rval) {
    BEGIN_WRAP
    *rval = rng.ptr->uniform(a, b);
    END_WRAP
}
CvStatus* cv_RNG_next(RNG rng, uint32_t* rval) {
    BEGIN_WRAP
    *rval = rng.ptr->next();
    END_WRAP
}

CvStatus* cv_theRNG(RNGPtr rval) {
    BEGIN_WRAP
    *rval = {new cv::RNG(cv::theRNG())};
    END_WRAP
}
CvStatus* cv_setRNGSeed(int seed) {
    BEGIN_WRAP
    cv::setRNGSeed(seed);
    END_WRAP
}

CvStatus* cv_randn(Mat mat, Scalar mean, Scalar stddev, CvCallback_0 callback) {
    BEGIN_WRAP
    auto c_mean = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
    auto c_stddev = cv::Scalar(stddev.val1, stddev.val2, stddev.val3, stddev.val4);
    cv::randn(CVDEREF(mat), c_mean, c_stddev);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_randShuffle(Mat mat, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::randShuffle(CVDEREF(mat));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_randShuffle_1(Mat mat, double iterFactor, RNG rng, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::randShuffle(CVDEREF(mat), iterFactor, rng.ptr);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}
CvStatus* cv_randu(Mat mat, Scalar low, Scalar high, CvCallback_0 callback) {
    BEGIN_WRAP
    auto c_low = cv::Scalar(low.val1, low.val2, low.val3, low.val4);
    auto c_high = cv::Scalar(high.val1, high.val2, high.val3, high.val4);
    cv::randu(CVDEREF(mat), c_low, c_high);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

int64_t cv_getTickCount(void) {
    return cv::getTickCount();
}
double_t cv_getTickFrequency(void) {
    return cv::getTickFrequency();
}
void cv_setNumThreads(int n) {
    cv::setNumThreads(n);
}
int cv_getNumThreads(void) {
    return cv::getNumThreads();
}
