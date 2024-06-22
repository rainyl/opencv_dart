#include "imgproc_async.h"
#include "opencv2/imgproc.hpp"

CvStatus *CvtColor_Async(Mat src, int code, CVD_OUT CvCallback_1 callback)
{
  BEGIN_WRAP
  cv::Mat dst;
  cv::cvtColor(*src.ptr, dst, code);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *GaussianBlur_Async(Mat src, Size ps, double sX, double sY, int bt, CVD_OUT CvCallback_1 callback)
{
  BEGIN_WRAP
  cv::Mat dst;
  cv::GaussianBlur(*src.ptr, dst, cv::Size(ps.width, ps.height), sX, sY, bt);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
