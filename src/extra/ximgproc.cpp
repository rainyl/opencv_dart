#include "ximgproc.h"

CvStatus ximgproc_anisotropicDiffusion(Mat src, CVD_OUT Mat *dst, float alpha, float K, int niters)
{
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::anisotropicDiffusion(*src.ptr, *_dst, alpha, K, niters);
  *dst = {_dst};
  END_WRAP
}
CvStatus ximgproc_edgePreservingFilter(Mat src, CVD_OUT Mat *dst, int d, double threshold)
{
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::edgePreservingFilter(*src.ptr, *_dst, d, threshold);
  *dst = {_dst};
  END_WRAP
}
CvStatus ximgproc_findEllipses(Mat image, CVD_OUT Mat *ellipses, float scoreThreshold,
                               float reliabilityThreshold, float centerDistanceThreshold)
{
  BEGIN_WRAP
  cv::Mat *_ellipses = new cv::Mat();
  cv::ximgproc::findEllipses(*image.ptr, *_ellipses, scoreThreshold, reliabilityThreshold,
                             centerDistanceThreshold);
  *ellipses = {_ellipses};
  END_WRAP
}
CvStatus ximgproc_niBlackThreshold(Mat src, CVD_OUT Mat *dst, double maxValue, int type, int blockSize,
                                   double k, int binarizationMethod, double r)
{
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::niBlackThreshold(*src.ptr, *_dst, maxValue, type, blockSize, k, binarizationMethod, r);
  *dst = {_dst};
  END_WRAP
}
CvStatus ximgproc_PeiLinNormalization(Mat I, CVD_OUT Mat *dst)
{
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::PeiLinNormalization(*I.ptr, *_dst);
  *dst = {_dst};
  END_WRAP
}
CvStatus ximgproc_thinning(Mat src, Mat *dst, int thinningType)
{
  BEGIN_WRAP
  cv::Mat *_dst = new cv::Mat();
  cv::ximgproc::thinning(*src.ptr, *_dst, thinningType);
  *dst = {_dst};
  END_WRAP
}
