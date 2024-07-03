#include "svd_async.h"
#include "core/types.h"

CvStatus *SVD_Compute_Async(Mat src, int flags, CvCallback_3 callback) {
  BEGIN_WRAP
  cv::Mat w, u, vt;
  cv::SVD::compute(*src.ptr, w, u, vt, flags);
  callback(new Mat{new cv::Mat(w)}, new Mat{new cv::Mat(u)}, new Mat{new cv::Mat(vt)});
  END_WRAP
}
CvStatus *SVD_backSubst_Async(Mat w, Mat u, Mat vt, Mat rhs, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::SVD::backSubst(*w.ptr, *u.ptr, *vt.ptr, *rhs.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}
