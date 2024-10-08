#include "core_async.h"
#include "core/types.h"
#include "lut.hpp"
#include "vec.hpp"

#include "opencv2/core.hpp"
#include "opencv2/core/types.hpp"

#pragma region Mat_Constructors
CvStatus *Mat_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat()});
  END_WRAP
}

CvStatus *Mat_NewWithSize_Async(int rows, int cols, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(rows, cols, type)});
  END_WRAP
}

CvStatus *Mat_NewWithSizes_Async(VecI32 sizes, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat((int)sizes.length, sizes.ptr, type)});
  END_WRAP
}

CvStatus *Mat_NewWithSizesScalar_Async(VecI32 sizes, int type, Scalar s, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(s.val1, s.val2, s.val3, s.val4);
  callback(new Mat{new cv::Mat((int)sizes.length, sizes.ptr, type, c)});
  END_WRAP
}

CvStatus *
Mat_NewWithSizesFromBytes_Async(VecI32 sizes, int type, VecChar buf, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat((int)sizes.length, sizes.ptr, type, buf.ptr)});
  END_WRAP
}

CvStatus *
Mat_NewFromScalar_Async(const Scalar s, int rows, int cols, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar c = cv::Scalar(s.val1, s.val2, s.val3, s.val4);
  callback(new Mat{new cv::Mat(rows, cols, type, c)});
  END_WRAP
}

CvStatus *
Mat_NewFromBytes_Async(int rows, int cols, int type, void *buf, int step, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat m = cv::Mat(rows, cols, type);
  m.create(rows, cols, type);
  memcpy(m.data, buf, m.total() * m.elemSize());
  callback(new Mat{new cv::Mat(m)});
  END_WRAP
}

CvStatus *Mat_NewFromVecPoint_Async(VecPoint vec, CvCallback_1 callback) {
  BEGIN_WRAP
  auto v = vecpoint_c2cpp(vec);
  callback(new Mat{new cv::Mat(v, true)});
  END_WRAP
}

CvStatus *Mat_NewFromVecPoint2f_Async(VecPoint2f vec, CvCallback_1 callback) {
  BEGIN_WRAP
  auto v = vecpoint2f_c2cpp(vec);
  callback(new Mat{new cv::Mat(v, true)});
  END_WRAP
}

CvStatus *Mat_NewFromVecPoint3f_Async(VecPoint3f vec, CvCallback_1 callback) {
  BEGIN_WRAP
  auto v = vecpoint3f_c2cpp(vec);
  callback(new Mat{new cv::Mat(v, true)});
  END_WRAP
}

CvStatus *Mat_Eye_Async(int rows, int cols, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(cv::Mat::eye(rows, cols, type))});
  END_WRAP
}

CvStatus *Mat_Zeros_Async(int rows, int cols, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(cv::Mat::zeros(rows, cols, type))});
  END_WRAP
}

CvStatus *Mat_Ones_Async(int rows, int cols, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(cv::Mat::ones(rows, cols, type))});
  END_WRAP
}
#pragma endregion

#pragma region Mat_functions

CvStatus *Mat_Clone_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->clone())});
  END_WRAP
}

CvStatus *Mat_CopyTo_Async(Mat self, Mat dst, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->copyTo(*dst.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_CopyToWithMask_Async(Mat self, Mat dst, Mat mask, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->copyTo(*dst.ptr, *mask.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_ConvertTo_Async(Mat self, int type, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  self.ptr->convertTo(dst, type);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
Mat_ConvertToWithParams_Async(Mat self, int type, float alpha, float beta, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  self.ptr->convertTo(dst, type, alpha, beta);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Mat_ToVecUChar_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  if (self.ptr->isContinuous()) {
    callback(new VecUChar{self.ptr->data, self.ptr->total() * self.ptr->channels()});
  } else {
    throw cv::Exception(
        cv::Error::StsNotImplemented, "Mat is not continuous", __func__, __FILE__, __LINE__
    );
  }
  END_WRAP
}

CvStatus *Mat_ToVecChar_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  if (self.ptr->isContinuous()) {
    callback(new VecChar{(char *)self.ptr->data, self.ptr->total() * self.ptr->channels()});
  } else {
    throw cv::Exception(
        cv::Error::StsNotImplemented, "Mat is not continuous", __func__, __FILE__, __LINE__
    );
  }
  END_WRAP
}

CvStatus *Mat_Region_Async(Mat self, Rect r, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(*self.ptr, cv::Rect(r.x, r.y, r.width, r.height))});
  END_WRAP
}

CvStatus *Mat_Reshape_Async(Mat self, int cn, int rows, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(self.ptr->reshape(cn, rows))});
  END_WRAP
}
#pragma endregion

CvStatus *core_PatchNaNs_Async(Mat self, double val, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::patchNaNs(*self.ptr, val);
  callback();
  END_WRAP
}
// Deprecated:
// Use Mat::convertTo with CV_16F instead.
// CvStatus *Mat_ConvertFp16_Async(Mat self, CvCallback_1 callback);
CvStatus *core_Mean_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*self.ptr);
  callback(new Scalar{c.val[0], c.val[1], c.val[2], c.val[3]});
  END_WRAP
}

CvStatus *core_MeanWithMask_Async(Mat self, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar c = cv::mean(*self.ptr, *mask.ptr);
  callback(new Scalar{c.val[0], c.val[1], c.val[2], c.val[3]});
  END_WRAP
}

CvStatus *core_Sqrt_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::sqrt(*self.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_AbsDiff_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::absdiff(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Add_Async(Mat src1, Mat src2, Mat mask, int dtype, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::add(*src1.ptr, *src2.ptr, dst, *mask.ptr, dtype);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_AddWeighted_Async(
    Mat src1, double alpha, Mat src2, double beta, double gamma, int dtype, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::addWeighted(*src1.ptr, alpha, *src2.ptr, beta, gamma, dst, dtype);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseAnd_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_and(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseAndWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_and(*src1.ptr, *src2.ptr, dst, *mask.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseNot_Async(Mat src1, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_not(*src1.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseNotWithMask_Async(Mat src1, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_not(*src1.ptr, dst, *mask.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseOr_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_or(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseOrWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_or(*src1.ptr, *src2.ptr, dst, *mask.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseXor_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_xor(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BitwiseXorWithMask_Async(Mat src1, Mat src2, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bitwise_xor(*src1.ptr, *src2.ptr, dst, *mask.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Compare_Async(Mat src1, Mat src2, int ct, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::compare(*src1.ptr, *src2.ptr, dst, ct);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_BatchDistance_Async(
    Mat src1,
    Mat src2,
    int dtype,
    int normType,
    int K,
    Mat mask,
    int update,
    bool crosscheck,
    CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat dist, nidx;
  cv::batchDistance(
      *src1.ptr, *src2.ptr, dist, dtype, nidx, normType, K, *mask.ptr, update, crosscheck
  );
  callback(new Mat{new cv::Mat(dist)}, new Mat{new cv::Mat(nidx)});
  END_WRAP
}

CvStatus *core_BorderInterpolate_Async(int p, int len, int borderType, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new int(cv::borderInterpolate(p, len, borderType)));
  END_WRAP
}

CvStatus *
core_CalcCovarMatrix_Async(Mat samples, Mat mean, int flags, int ctype, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat cov;
  cv::calcCovarMatrix(*samples.ptr, cov, *mean.ptr, flags, ctype);
  callback(new Mat{new cv::Mat(cov)});
  END_WRAP
}

CvStatus *core_CartToPolar_Async(Mat x, Mat y, bool angleInDegrees, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat mag, ang;
  cv::cartToPolar(*x.ptr, *y.ptr, mag, ang, angleInDegrees);
  callback(new Mat{new cv::Mat(mag)}, new Mat{new cv::Mat(ang)});
  END_WRAP
}

CvStatus *
core_CheckRange_Async(Mat self, bool quiet, double minVal, double maxVal, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Point point;
  bool rval = cv::checkRange(*self.ptr, quiet, &point, minVal, maxVal);
  callback(new bool(rval), new Point{point.x, point.y});
  END_WRAP
}

CvStatus *core_CompleteSymm_Async(Mat self, bool lowerToUpper, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::completeSymm(*self.ptr, lowerToUpper);
  callback();
  END_WRAP
}

CvStatus *core_ConvertScaleAbs_Async(Mat src, double alpha, double beta, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::convertScaleAbs(*src.ptr, dst, alpha, beta);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_CopyMakeBorder_Async(
    Mat src,
    int top,
    int bottom,
    int left,
    int right,
    int borderType,
    Scalar value,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Scalar val = cv::Scalar(value.val1, value.val2, value.val3, value.val4);
  cv::copyMakeBorder(*src.ptr, dst, top, bottom, left, right, borderType, val);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_CountNonZero_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new int(cv::countNonZero(*src.ptr)));
  END_WRAP
}

CvStatus *core_DCT_Async(Mat src, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::dct(*src.ptr, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Determinant_Async(Mat self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new double(cv::determinant(*self.ptr)));
  END_WRAP
}

CvStatus *core_DFT_Async(Mat self, int flags, int nonzeroRows, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::dft(*self.ptr, dst, flags, nonzeroRows);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Divide_Async(Mat src1, Mat src2, double scale, int dtype, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::divide(*src1.ptr, *src2.ptr, *src1.ptr, scale, dtype);
  callback(new Mat{new cv::Mat(*src1.ptr)});
  END_WRAP
}

CvStatus *core_Eigen_Async(Mat src, CvCallback_3 callback) {
  BEGIN_WRAP
  cv::Mat eigenvalues, eigenvectors;
  bool rval = cv::eigen(*src.ptr, eigenvalues, eigenvectors);
  callback(new bool(rval), new Mat{new cv::Mat(eigenvalues)}, new Mat{new cv::Mat(eigenvectors)});
  END_WRAP
}

CvStatus *core_EigenNonSymmetric_Async(Mat src, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat eigenvalues, eigenvectors;
  cv::eigenNonSymmetric(*src.ptr, eigenvalues, eigenvectors);
  callback(new Mat{new cv::Mat(eigenvalues)}, new Mat{new cv::Mat(eigenvectors)});
  END_WRAP
}

CvStatus *core_PCABackProject_Async(Mat src, Mat mean, Mat eigenvectors, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat result;
  cv::PCABackProject(*src.ptr, *mean.ptr, *eigenvectors.ptr, result);
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}

CvStatus *
core_PCACompute_3_Async(Mat src, Mat mean, double retainedVariance, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat eigenvectors;
  cv::PCACompute(*src.ptr, *mean.ptr, eigenvectors, retainedVariance);
  callback(new Mat{new cv::Mat(eigenvectors)});
  END_WRAP
}

CvStatus *core_PCACompute_1_Async(Mat src, Mat mean, int maxComponents, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat eigenvectors;
  cv::PCACompute(*src.ptr, *mean.ptr, eigenvectors, maxComponents);
  callback(new Mat{new cv::Mat(eigenvectors)});
  END_WRAP
}

CvStatus *
core_PCACompute_2_Async(Mat src, Mat mean, double retainedVariance, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat eigenvectors, eigenValues;
  cv::PCACompute(*src.ptr, *mean.ptr, eigenvectors, eigenValues, retainedVariance);
  callback(new Mat{new cv::Mat(eigenvectors)}, new Mat{new cv::Mat(eigenValues)});
  END_WRAP
}

CvStatus *core_PCACompute_Async(Mat src, Mat mean, int maxComponents, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat eigenvectors, eigenValues;
  cv::PCACompute(*src.ptr, *mean.ptr, eigenvectors, eigenValues, maxComponents);
  callback(new Mat{new cv::Mat(eigenvectors)}, new Mat{new cv::Mat(eigenValues)});
  END_WRAP
}

CvStatus *core_PCAProject_Async(Mat src, Mat mean, Mat eigenvectors, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat result;
  cv::PCAProject(*src.ptr, *mean.ptr, *eigenvectors.ptr, result);
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}

CvStatus *core_Exp_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::exp(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_ExtractChannel_Async(Mat src, int coi, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::extractChannel(*src.ptr, dst, coi);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_FindNonZero_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat indices;
  cv::findNonZero(*src.ptr, indices);
  callback(new Mat{new cv::Mat(indices)});
  END_WRAP
}

CvStatus *core_Flip_Async(Mat src, int flipCode, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::flip(*src.ptr, dst, flipCode);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Gemm_Async(
    Mat src1, Mat src2, double alpha, Mat src3, double beta, int flags, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::gemm(*src1.ptr, *src2.ptr, alpha, *src3.ptr, beta, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_GetOptimalDFTSize_Async(int vecsize, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new int(cv::getOptimalDFTSize(vecsize)));
  END_WRAP
}

CvStatus *core_Hconcat_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::hconcat(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Vconcat_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::vconcat(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Idct_Async(Mat src, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::idct(*src.ptr, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Idft_Async(Mat src, int flags, int nonzeroRows, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::idft(*src.ptr, dst, flags, nonzeroRows);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_InRange_Async(Mat src, Mat lowerb, Mat upperb, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::inRange(*src.ptr, *lowerb.ptr, *upperb.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_InRangeWithScalar_Async(
    Mat src, const Scalar lowerb, const Scalar upperb, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Scalar lowb(lowerb.val1, lowerb.val2, lowerb.val3, lowerb.val4);
  cv::Scalar upb(upperb.val1, upperb.val2, upperb.val3, upperb.val4);
  cv::inRange(*src.ptr, lowb, upb, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_InsertChannel_Async(Mat src, Mat dst, int coi, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::insertChannel(*src.ptr, *dst.ptr, coi);
  callback();
  END_WRAP
}

CvStatus *core_Invert_Async(Mat src, int flags, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  double rval = cv::invert(*src.ptr, dst, flags);
  callback(new double(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Log_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::log(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Magnitude_Async(Mat x, Mat y, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::magnitude(*x.ptr, *y.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Max_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::max(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_MeanStdDev_Async(Mat src, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Scalar mean, stddev;
  cv::meanStdDev(*src.ptr, mean, stddev);
  callback(
      new Scalar{mean.val[0], mean.val[1], mean.val[2], mean.val[3]},
      new Scalar{stddev.val[0], stddev.val[1], stddev.val[2], stddev.val[3]}
  );
  END_WRAP
}

CvStatus *core_MeanStdDevWithMask_Async(Mat src, Mat mask, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Scalar mean, stddev;
  cv::meanStdDev(*src.ptr, mean, stddev, *mask.ptr);
  callback(
      new Scalar{mean.val[0], mean.val[1], mean.val[2], mean.val[3]},
      new Scalar{stddev.val[0], stddev.val[1], stddev.val[2], stddev.val[3]}
  );
  END_WRAP
}

CvStatus *core_Merge_Async(VecMat mats, CvCallback_1 callback) {
  BEGIN_WRAP
  auto mv = vecmat_c2cpp(mats);
  cv::Mat _dst;
  cv::merge(mv, _dst);
  callback(new Mat{new cv::Mat(_dst)});
  END_WRAP
}

CvStatus *core_Min_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::min(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_MinMaxIdx_Async(Mat self, CvCallback_4 callback) {
  BEGIN_WRAP
  double minVal, maxVal;
  int minLoc, maxLoc;
  cv::minMaxIdx(*self.ptr, &minVal, &maxVal, &minLoc, &maxLoc);
  callback(new double(minVal), new double(maxVal), new int(minLoc), new int(maxLoc));
  END_WRAP
}

CvStatus *core_MinMaxIdx_Mask_Async(Mat self, Mat mask, CvCallback_4 callback) {
  BEGIN_WRAP
  double minVal, maxVal;
  int minLoc, maxLoc;
  cv::minMaxIdx(*self.ptr, &minVal, &maxVal, &minLoc, &maxLoc, *mask.ptr);
  callback(new double(minVal), new double(maxVal), new int(minLoc), new int(maxLoc));
  END_WRAP
}

CvStatus *core_MinMaxLoc_Async(Mat self, CvCallback_4 callback) {
  BEGIN_WRAP
  double minVal, maxVal;
  cv::Point minLoc, maxLoc;
  cv::minMaxLoc(*self.ptr, &minVal, &maxVal, &minLoc, &maxLoc);
  callback(
      new double(minVal),
      new double(maxVal),
      new Point{minLoc.x, minLoc.y},
      new Point{maxLoc.x, maxLoc.y}
  );
  END_WRAP
}

CvStatus *core_MinMaxLoc_Mask_Async(Mat self, Mat mask, CvCallback_4 callback) {
  BEGIN_WRAP
  double minVal, maxVal;
  cv::Point minLoc, maxLoc;
  cv::minMaxLoc(*self.ptr, &minVal, &maxVal, &minLoc, &maxLoc, *mask.ptr);
  callback(
      new double(minVal),
      new double(maxVal),
      new Point{minLoc.x, minLoc.y},
      new Point{maxLoc.x, maxLoc.y}
  );
  END_WRAP
}

CvStatus *core_MixChannels_Async(VecMat src, VecMat dst, VecI32 fromTo, CvCallback_0 callback) {
  BEGIN_WRAP
  auto _src = vecmat_c2cpp(src);
  auto _dst = vecmat_c2cpp(dst);
  std::vector<int> _fromTo(fromTo.ptr, fromTo.ptr + fromTo.length);
  cv::mixChannels(_src, _dst, _fromTo);
  // TODO: check whether dst changed
  callback();
  END_WRAP
}

CvStatus *core_MulSpectrums_Async(Mat a, Mat b, int flags, bool conjB, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::mulSpectrums(*a.ptr, *b.ptr, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Multiply_Async(Mat src1, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::multiply(*src1.ptr, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
core_MultiplyWithParams_Async(Mat src1, Mat src2, double scale, int dtype, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::multiply(*src1.ptr, *src2.ptr, dst, scale, dtype);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Normalize_Async(
    Mat src, Mat dst, double alpha, double beta, int typ, int dtype, CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::normalize(*src.ptr, *dst.ptr, alpha, beta, typ, dtype);
  callback();
  END_WRAP
}

CvStatus *core_Normalize_Mask_Async(
    Mat src, Mat dst, double alpha, double beta, int typ, int dtype, Mat mask, CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::normalize(*src.ptr, *dst.ptr, alpha, beta, typ, dtype, *mask.ptr);
  callback();
  END_WRAP
}

CvStatus *core_PerspectiveTransform_Async(Mat src, Mat tm, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::perspectiveTransform(*src.ptr, dst, *tm.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Solve_Async(Mat src1, Mat src2, int flags, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  bool rval = cv::solve(*src1.ptr, *src2.ptr, dst, flags);
  callback(new bool(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_SolveCubic_Async(Mat coeffs, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  int rval = cv::solveCubic(*coeffs.ptr, dst);
  callback(new int(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_SolvePoly_Async(Mat coeffs, int maxIters, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  double rval = cv::solvePoly(*coeffs.ptr, dst, maxIters);
  callback(new double(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Reduce_Async(Mat src, int dim, int rType, int dType, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::reduce(*src.ptr, dst, dim, rType, dType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_ReduceArgMax_Async(Mat src, int axis, bool lastIndex, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::reduceArgMax(*src.ptr, dst, axis, lastIndex);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_ReduceArgMin_Async(Mat src, int axis, bool lastIndex, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::reduceArgMin(*src.ptr, dst, axis, lastIndex);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Repeat_Async(Mat src, int nY, int nX, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::repeat(*src.ptr, nY, nX, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_ScaleAdd_Async(Mat src1, double alpha, Mat src2, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::scaleAdd(*src1.ptr, alpha, *src2.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_SetIdentity_Async(Mat src, Scalar scalar, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::setIdentity(*src.ptr, *new cv::Scalar(scalar.val1, scalar.val2, scalar.val3, scalar.val4));
  callback();
  END_WRAP
}

CvStatus *core_Sort_Async(Mat src, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::sort(*src.ptr, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_SortIdx_Async(Mat src, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::sortIdx(*src.ptr, dst, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Split_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Mat> dst;
  cv::split(*src.ptr, dst);
  callback(vecmat_cpp2c_p(dst));
  END_WRAP
}

CvStatus *core_Subtract_Async(Mat src1, Mat src2, Mat mask, int dtype, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::subtract(*src1.ptr, *src2.ptr, dst, *mask.ptr, dtype);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_T_Async(Mat x, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::transpose(*x.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Trace_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar dst = cv::trace(*src.ptr);
  callback(new Scalar{dst.val[0], dst.val[1], dst.val[2], dst.val[3]});
  END_WRAP
}

CvStatus *core_Transform_Async(Mat src, Mat tm, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::transform(*src.ptr, dst, *tm.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Transpose_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::transpose(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
core_PolarToCart_Async(Mat magnitude, Mat degree, bool angleInDegrees, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat x, y;
  cv::polarToCart(*magnitude.ptr, *degree.ptr, x, y, angleInDegrees);
  callback(new Mat{new cv::Mat(x)}, new Mat{new cv::Mat(y)});
  END_WRAP
}

CvStatus *core_Pow_Async(Mat src, double power, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::pow(*src.ptr, power, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Phase_Async(Mat x, Mat y, bool angleInDegrees, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::phase(*x.ptr, *y.ptr, dst, angleInDegrees);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Sum_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Scalar dst = cv::sum(*src.ptr);
  callback(new Scalar{dst.val[0], dst.val[1], dst.val[2], dst.val[3]});
  END_WRAP
}

CvStatus *core_rowRange_Async(Mat self, int start, int end, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst = self.ptr->rowRange(start, end);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_colRange_Async(Mat self, int start, int end, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst = self.ptr->colRange(start, end);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_LUT_Async(Mat src, Mat lut, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  auto cn = src.ptr->channels(), depth = src.ptr->depth();
  if (depth == CV_8U || depth == CV_8S) {
    cv::LUT(*src.ptr, *lut.ptr, dst);
  } else {
    int lutcn = lut.ptr->channels(), lut_depth = lut.ptr->depth();
    size_t lut_total = lut.ptr->total(), expect_total = 0;
    switch (depth) {
    case CV_8U:
    case CV_8S: expect_total = 256; break;
    case CV_16U:
    case CV_16S: expect_total = 65536; break;
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

    CV_Assert((lutcn == cn || lutcn == 1) && lut_total == expect_total && lut.ptr->isContinuous());
    dst.create(src.ptr->dims, src.ptr->size, CV_MAKETYPE(lut.ptr->depth(), cn));

    const cv::Mat *arrays[] = {src.ptr, &dst, 0};
    uchar *ptrs[2] = {};
    cv::NAryMatIterator it(arrays, ptrs);
    int len = (int)it.size;

    switch (depth) {
    case CV_16U:
      switch (lut_depth) {
      case CV_8U:
        cvd::LUT16u_8u(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<uchar>(), dst.ptr<uchar>(), len, cn, lutcn
        );
        break;
      case CV_8S:
        cvd::LUT16u_8s(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<char>(), dst.ptr<char>(), len, cn, lutcn
        );
        break;
      case CV_16U:
        cvd::LUT16u_16u(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<ushort>(), dst.ptr<ushort>(), len, cn, lutcn
        );
        break;
      case CV_16S:
        cvd::LUT16u_16s(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<short>(), dst.ptr<short>(), len, cn, lutcn
        );
        break;
      case CV_32S:
        cvd::LUT16u_32s(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<int>(), dst.ptr<int>(), len, cn, lutcn
        );
        break;
      case CV_32F:
        cvd::LUT16u_32f(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<float>(), dst.ptr<float>(), len, cn, lutcn
        );
        break;
      case CV_64F:
        cvd::LUT16u_64f(
            src.ptr->ptr<ushort>(), lut.ptr->ptr<double>(), dst.ptr<double>(), len, cn, lutcn
        );
        break;
      default:
        cv::String err = "lut Mat Type not supported for CV_16U";
        throw cv::Exception(cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__);
      }
      break;
    case CV_16S:
      switch (lut_depth) {
      case CV_8U:
        cvd::LUT16s_8u(
            src.ptr->ptr<short>(), lut.ptr->ptr<uchar>(), dst.ptr<uchar>(), len, cn, lutcn
        );
        break;
      case CV_8S:
        cvd::LUT16s_8s(
            src.ptr->ptr<short>(), lut.ptr->ptr<char>(), dst.ptr<char>(), len, cn, lutcn
        );
        break;
      case CV_16U:
        cvd::LUT16s_16u(
            src.ptr->ptr<short>(), lut.ptr->ptr<ushort>(), dst.ptr<ushort>(), len, cn, lutcn
        );
        break;
      case CV_16S:
        cvd::LUT16s_16s(
            src.ptr->ptr<short>(), lut.ptr->ptr<short>(), dst.ptr<short>(), len, cn, lutcn
        );
        break;
      case CV_32S:
        cvd::LUT16s_32s(src.ptr->ptr<short>(), lut.ptr->ptr<int>(), dst.ptr<int>(), len, cn, lutcn);
        break;
      case CV_32F:
        cvd::LUT16s_32f(
            src.ptr->ptr<short>(), lut.ptr->ptr<float>(), dst.ptr<float>(), len, cn, lutcn
        );
        break;
      case CV_64F:
        cvd::LUT16s_64f(
            src.ptr->ptr<short>(), lut.ptr->ptr<double>(), dst.ptr<double>(), len, cn, lutcn
        );
        break;
      default:
        cv::String err = "lut Mat Type not supported for CV_16S";
        throw cv::Exception(cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__);
      }
      break;
    case CV_32S:
      switch (lut_depth) {
      case CV_32S:
        cvd::LUT32s_32s(src.ptr->ptr<int>(), lut.ptr->ptr<int>(), dst.ptr<int>(), len, cn, lutcn);
        break;
      case CV_32F:
        cvd::LUT32s_32f(
            src.ptr->ptr<int>(), lut.ptr->ptr<float>(), dst.ptr<float>(), len, cn, lutcn
        );
        break;
      case CV_64F:
        cvd::LUT32s_64f(
            src.ptr->ptr<int>(), lut.ptr->ptr<double>(), dst.ptr<double>(), len, cn, lutcn
        );
        break;
      default:
        cv::String err = "lut Mat Type not supported for CV_32S";
        throw cv::Exception(cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__);
      }
      break;
    default:
      cv::String err = "src Mat Type not supported";
      throw cv::Exception(cv::Error::StsNotImplemented, err, __func__, __FILE__, __LINE__);
    }
  }
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_KMeans_Async(
    Mat data,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::TermCriteria tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  cv::Mat centers;
  double rval = cv::kmeans(*data.ptr, k, *bestLabels.ptr, tc, attempts, flags, centers);
  callback(new double(rval), new Mat{new cv::Mat(centers)});
  END_WRAP
}

CvStatus *core_KMeans_Points_Async(
    VecPoint2f pts,
    int k,
    Mat bestLabels,
    TermCriteria criteria,
    int attempts,
    int flags,
    CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::TermCriteria tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  cv::Mat centers;
  auto _pts = vecpoint2f_c2cpp(pts);
  double rval = cv::kmeans(_pts, k, *bestLabels.ptr, tc, attempts, flags, centers);
  callback(new double(rval), new Mat{new cv::Mat(centers)});
  END_WRAP
}

CvStatus *core_Rotate_Async(Mat src, int rotateCode, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::rotate(*src.ptr, dst, rotateCode);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *core_Norm_Async(Mat src1, int normType, CvCallback_1 callback) {
  BEGIN_WRAP
  double rval = cv::norm(*src1.ptr, normType);
  callback(new double(rval));
  END_WRAP
}

CvStatus *core_Norm_Mask_Async(Mat src1, int normType, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  double rval = cv::norm(*src1.ptr, normType, *mask.ptr);
  callback(new double(rval));
  END_WRAP
}

CvStatus *core_NormWithMats_Async(Mat src1, Mat src2, int normType, CvCallback_1 callback) {
  BEGIN_WRAP
  double rval = cv::norm(*src1.ptr, *src2.ptr, normType);
  callback(new double(rval));
  END_WRAP
}
#pragma region RNG

CvStatus *Rng_New_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new RNG{new cv::RNG()});
  END_WRAP
}

CvStatus *Rng_NewWithState_Async(uint64_t state, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new RNG{new cv::RNG(state)});
  END_WRAP
}

CvStatus *RNG_Fill_Async(
    RNG rng, Mat mat, int distType, double a, double b, bool saturateRange, CvCallback_0 callback
) {
  BEGIN_WRAP
  rng.ptr->fill(*mat.ptr, distType, a, b, saturateRange);
  callback();
  END_WRAP
}

CvStatus *RNG_Gaussian_Async(RNG rng, double sigma, CvCallback_1 callback) {
  BEGIN_WRAP
  double rval = rng.ptr->gaussian(sigma);
  callback(new double(rval));
  END_WRAP
}

CvStatus *RNG_Uniform_Async(RNG rng, int a, int b, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = rng.ptr->uniform(a, b);
  callback(new int(rval));
  END_WRAP
}

CvStatus *RNG_UniformDouble_Async(RNG rng, double a, double b, CvCallback_1 callback) {
  BEGIN_WRAP
  double rval = rng.ptr->uniform(a, b);
  callback(new double(rval));
  END_WRAP
}

CvStatus *RNG_Next_Async(RNG rng, CvCallback_1 callback) {
  BEGIN_WRAP
  uint32_t rval = rng.ptr->next();
  callback(new uint32_t(rval));
  END_WRAP
}

CvStatus *RandN_Async(Mat mat, Scalar mean, Scalar stddev, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::Scalar mean_ = cv::Scalar(mean.val1, mean.val2, mean.val3, mean.val4);
  cv::Scalar stddev_ = cv::Scalar(stddev.val1, stddev.val2, stddev.val3, stddev.val4);
  cv::randn(*mat.ptr, mean_, stddev_);
  callback();
  END_WRAP
}

CvStatus *RandShuffle_Async(Mat mat, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::randShuffle(*mat.ptr);
  callback();
  END_WRAP
}

CvStatus *RandShuffleWithParams_Async(Mat mat, double iterFactor, RNG rng, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::randShuffle(*mat.ptr, iterFactor, rng.ptr);
  callback();
  END_WRAP
}

CvStatus *RandU_Async(Mat mat, Scalar low, Scalar high, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::Scalar low_ = cv::Scalar(low.val1, low.val2, low.val3, low.val4);
  cv::Scalar high_ = cv::Scalar(high.val1, high.val2, high.val3, high.val4);
  cv::randu(*mat.ptr, low_, high_);
  callback();
  END_WRAP
}
#pragma endregion
