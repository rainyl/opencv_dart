#include "calib3d_async.h"
#include "opencv2/calib3d.hpp"

CvStatus *Fisheye_UndistortImage(Mat distorted, CVD_OUT CvCallback_1 callback, Mat k, Mat d)
{
  BEGIN_WRAP
  cv::Mat dst;
  cv::fisheye::undistortImage(*distorted.ptr, dst, *k.ptr, *d.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
