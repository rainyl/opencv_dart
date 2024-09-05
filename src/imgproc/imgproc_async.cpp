#include "imgproc_async.h"
#include "core/types.h"
#include "core/vec.hpp"
#include "opencv2/core/mat.hpp"
#include "opencv2/core/matx.hpp"
#include <opencv2/imgproc.hpp>
#include <vector>

CvStatus *ArcLength_Async(VecPoint curve, bool is_closed, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  auto _curve = vecpoint_c2cpp(curve);
  callback(new double(cv::arcLength(_curve, is_closed)));
  END_WRAP
}

CvStatus *ApproxPolyDP_Async(VecPoint curve, double epsilon, bool closed, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Point> approxCurvePts;
  auto _curve = vecpoint_c2cpp(curve);
  cv::approxPolyDP(_curve, approxCurvePts, epsilon, closed);
  callback(vecpoint_cpp2c_p(approxCurvePts));
  END_WRAP
}

CvStatus *BilateralFilter_Async(Mat src, int d, double sc, double ss, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::bilateralFilter(*src.ptr, dst, d, sc, ss);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Blur_Async(Mat src, Size ps, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::blur(*src.ptr, dst, cv::Size(ps.width, ps.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *BoxFilter_Async(Mat src, int ddepth, Size ps, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::boxFilter(*src.ptr, dst, ddepth, cv::Size(ps.width, ps.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *CvtColor_Async(Mat src, int code, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::cvtColor(*src.ptr, dst, code);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *CalcHist_Async(
    VecMat mats, VecI32 chans, Mat mask, VecI32 sz, VecF32 rng, bool acc, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat hist;
  auto _mats = vecmat_c2cpp(mats);
  auto _chans = vecint_c2cpp(chans);
  auto _sz = vecint_c2cpp(sz);
  auto _rng = vecfloat_c2cpp(rng);
  cv::calcHist(_mats, _chans, *mask.ptr, hist, _sz, _rng, acc);
  callback(new Mat{new cv::Mat(hist)});
  END_WRAP
}

CvStatus *CalcBackProject_Async(
    VecMat mats, VecI32 chans, Mat hist, VecF32 rng, double scale, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat backProject;
  auto _mats = vecmat_c2cpp(mats);
  auto _chans = vecint_c2cpp(chans);
  auto _rng = vecfloat_c2cpp(rng);
  cv::calcBackProject(_mats, _chans, *hist.ptr, backProject, _rng, scale);
  callback(new Mat{new cv::Mat(backProject)});
  END_WRAP
}

CvStatus *CompareHist_Async(Mat hist1, Mat hist2, int method, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new double{cv::compareHist(*hist1.ptr, *hist2.ptr, method)});
  END_WRAP
}

CvStatus *
ConvexHull_Async(VecPoint points, bool clockwise, bool returnPoints, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat hull;
  auto _points = vecpoint_c2cpp(points);
  cv::convexHull(_points, hull, clockwise, returnPoints);
  callback(new Mat{new cv::Mat(hull)});
  END_WRAP
}

CvStatus *ConvexityDefects_Async(VecPoint points, Mat hull, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat defects;
  auto _points = vecpoint_c2cpp(points);
  cv::convexityDefects(_points, *hull.ptr, defects);
  callback(new Mat{new cv::Mat(defects)});
  END_WRAP
}

CvStatus *SqBoxFilter_Async(Mat src, int ddepth, Size ps, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::sqrBoxFilter(*src.ptr, dst, ddepth, cv::Size(ps.width, ps.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Dilate_Async(Mat src, Mat kernel, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::dilate(*src.ptr, dst, *kernel.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *DilateWithParams_Async(
    Mat src,
    Mat kernel,
    Point anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::dilate(
      *src.ptr,
      dst,
      *kernel.ptr,
      cv::Point(anchor.x, anchor.y),
      iterations,
      borderType,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *DistanceTransform_Async(
    Mat src, int distanceType, int maskSize, int labelType, CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Mat labels;
  cv::distanceTransform(*src.ptr, dst, labels, distanceType, maskSize, labelType);
  callback(new Mat{new cv::Mat(dst)}, new Mat{new cv::Mat(labels)});
  END_WRAP
}

CvStatus *FloodFill_Async(
    Mat src,
    Mat mask,
    Point seedPoint,
    Scalar newVal,
    Scalar loDiff,
    Scalar upDiff,
    int flags,
    CvCallback_2 callback
) {
  BEGIN_WRAP
  auto _seedPoint = cv::Point(seedPoint.x, seedPoint.y);
  auto _rect = cv::Rect();
  auto _newVal = cv::Scalar(newVal.val1, newVal.val2, newVal.val3, newVal.val4);
  auto _loDiff = cv::Scalar(loDiff.val1, loDiff.val2, loDiff.val3, loDiff.val4);
  auto _upDiff = cv::Scalar(upDiff.val1, upDiff.val2, upDiff.val3, upDiff.val4);
  int rval =
      cv::floodFill(*src.ptr, *mask.ptr, _seedPoint, _newVal, &_rect, _loDiff, _upDiff, flags);
  callback(new int(rval), new Rect{_rect.x, _rect.y, _rect.width, _rect.height});
  END_WRAP
}

CvStatus *EqualizeHist_Async(Mat src, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::equalizeHist(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Erode_Async(Mat src, Mat kernel, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::erode(*src.ptr, dst, *kernel.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *ErodeWithParams_Async(
    Mat src,
    Mat kernel,
    Point anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::erode(
      *src.ptr,
      dst,
      *kernel.ptr,
      cv::Point(anchor.x, anchor.y),
      iterations,
      borderType,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *MatchTemplate_Async(Mat image, Mat templ, int method, Mat mask, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat result;
  cv::matchTemplate(*image.ptr, *templ.ptr, result, method, *mask.ptr);
  callback(new Mat{new cv::Mat(result)});
  END_WRAP
}

CvStatus *Moments_Async(Mat src, bool binaryImage, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Moments m = cv::moments(*src.ptr, binaryImage);
  callback(new Moment{
      m.m00,  m.m10,  m.m01,  m.m20,  m.m11,  m.m02,  m.m30,  m.m21,
      m.m12,  m.m03,  m.mu20, m.mu11, m.mu02, m.mu30, m.mu21, m.mu12,
      m.mu03, m.nu20, m.nu11, m.nu02, m.nu30, m.nu21, m.nu12, m.nu03,
  });
  END_WRAP
}

CvStatus *PyrDown_Async(Mat src, Size dstsize, int borderType, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::pyrDown(*src.ptr, dst, cv::Size(dstsize.width, dstsize.height), borderType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *PyrUp_Async(Mat src, Size dstsize, int borderType, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::pyrUp(*src.ptr, dst, cv::Size(dstsize.width, dstsize.height), borderType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *BoundingRect_Async(VecPoint pts, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  cv::Rect r = cv::boundingRect(_points);
  callback(new Rect{r.x, r.y, r.width, r.height});
  END_WRAP
}

CvStatus *BoxPoints_Async(RotatedRect rect, CvCallback_1 callback) {
  BEGIN_WRAP
  /// bottom left, top left, top right, bottom right
  auto mat = cv::Mat();
  std::vector<cv::Point2f> vec;
  auto center = cv::Point2f(rect.center.x, rect.center.y);
  auto size = cv::Size2f(rect.size.width, rect.size.height);
  cv::boxPoints(cv::RotatedRect(center, size, rect.angle), mat);
  for (int i = 0; i < mat.rows; i++) {
    vec.push_back(cv::Point2f(mat.at<float>(i, 0), mat.at<float>(i, 1)));
  }
  callback(vecpoint2f_cpp2c_p(vec));
  END_WRAP
}

CvStatus *ContourArea_Async(VecPoint pts, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  callback(new double(cv::contourArea(_points)));
  END_WRAP
}

CvStatus *MinAreaRect_Async(VecPoint pts, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  auto r = cv::minAreaRect(_points);
  callback(new RotatedRect{{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle});
  END_WRAP
}

CvStatus *FitEllipse_Async(VecPoint pts, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  auto r = cv::fitEllipse(_points);
  callback(new RotatedRect{{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle});
  END_WRAP
}

CvStatus *MinEnclosingCircle_Async(VecPoint pts, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Point2f c;
  float r;
  auto _points = vecpoint_c2cpp(pts);
  cv::minEnclosingCircle(_points, c, r);
  callback(new Point2f{c.y, c.x}, new float(r));
  END_WRAP
}

CvStatus *FindContours_Async(Mat src, int mode, int method, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<std::vector<cv::Point>> contours;
  // std::vector<cv::Vec4i> hierarchy;
  cv::Mat hierarchy;
  cv::findContours(*src.ptr, contours, hierarchy, mode, method);
  callback(vecvecpoint_cpp2c_p(contours), new Mat{new cv::Mat(hierarchy)});
  END_WRAP
}

CvStatus *
PointPolygonTest_Async(VecPoint pts, Point2f pt, bool measureDist, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  callback(new double(cv::pointPolygonTest(_points, cv::Point2f(pt.x, pt.y), measureDist)));
  END_WRAP
}

CvStatus *ConnectedComponents_Async(
    Mat src, int connectivity, int ltype, int ccltype, CvCallback_2 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  int rval = cv::connectedComponents(*src.ptr, dst, connectivity, ltype, ccltype);
  callback(new int(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *ConnectedComponentsWithStats_Async(
    Mat src, int connectivity, int ltype, int ccltype, CvCallback_4 callback
) {
  BEGIN_WRAP
  cv::Mat labels, stats, centroids;
  int rval = cv::connectedComponentsWithStats(
      *src.ptr, labels, stats, centroids, connectivity, ltype, ccltype
  );
  callback(
      new int(rval),
      new Mat{new cv::Mat(labels)},
      new Mat{new cv::Mat(stats)},
      new Mat{new cv::Mat(centroids)}
  );
  END_WRAP
}

CvStatus *
GaussianBlur_Async(Mat src, Size ps, double sX, double sY, int bt, CVD_OUT CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::GaussianBlur(*src.ptr, dst, cv::Size(ps.width, ps.height), sX, sY, bt);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *GetGaussianKernel_Async(int ksize, double sigma, int ktype, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(cv::getGaussianKernel(ksize, sigma, ktype))});
  END_WRAP
}

CvStatus *Laplacian_Async(
    Mat src,
    int dDepth,
    int kSize,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Laplacian(*src.ptr, dst, dDepth, kSize, scale, delta, borderType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Scharr_Async(
    Mat src,
    int dDepth,
    int dx,
    int dy,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Scharr(*src.ptr, dst, dDepth, dx, dy, scale, delta, borderType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *GetStructuringElement_Async(int shape, Size ksize, Point anchor, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat element = cv::getStructuringElement(
      shape, cv::Size(ksize.width, ksize.height), cv::Point(anchor.x, anchor.y)
  );
  callback(new Mat{new cv::Mat(element)});
  END_WRAP
}

CvStatus *MorphologyDefaultBorderValue_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  auto scalar = cv::morphologyDefaultBorderValue();
  callback(new Scalar{scalar.val[0], scalar.val[1], scalar.val[2], scalar.val[3]});
  END_WRAP
}

CvStatus *MorphologyEx_Async(Mat src, int op, Mat kernel, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::morphologyEx(*src.ptr, dst, op, *kernel.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *MorphologyExWithParams_Async(
    Mat src,
    int op,
    Mat kernel,
    Point pt,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  auto bv = cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4);
  cv::morphologyEx(
      *src.ptr, dst, op, *kernel.ptr, cv::Point(pt.x, pt.y), iterations, borderType, bv
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *MedianBlur_Async(Mat src, int ksize, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::medianBlur(*src.ptr, dst, ksize);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Canny_Async(
    Mat src, double t1, double t2, int apertureSize, bool l2gradient, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Canny(*src.ptr, dst, t1, t2, apertureSize, l2gradient);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *CornerSubPix_Async(
    Mat img,
    VecPoint2f corners,
    Size winSize,
    Size zeroZone,
    TermCriteria criteria,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  auto size = cv::Size(winSize.width, winSize.height);
  auto zone = cv::Size(zeroZone.width, zeroZone.height);
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  auto _corners = vecpoint2f_c2cpp(corners);
  cv::cornerSubPix(*img.ptr, _corners, size, zone, tc);
  // std::cout << *corners.ptr << std::endl;
  callback();
  END_WRAP
}

CvStatus *GoodFeaturesToTrack_Async(
    Mat img,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  std::vector<cv::Point2f> _corners;
  cv::goodFeaturesToTrack(
      *img.ptr, _corners, maxCorners, quality, minDist, *mask.ptr, blockSize, useHarrisDetector, k
  );
  callback(vecpoint2f_cpp2c_p(_corners));
  END_WRAP
}

CvStatus *GoodFeaturesToTrackWithGradient_Async(
    Mat img,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  std::vector<cv::Point2f> _corners;
  cv::goodFeaturesToTrack(
      *img.ptr,
      _corners,
      maxCorners,
      quality,
      minDist,
      *mask.ptr,
      blockSize,
      gradientSize,
      useHarrisDetector,
      k
  );
  callback(vecpoint2f_cpp2c_p(_corners));
  END_WRAP
}

CvStatus *GrabCut_Async(
    Mat img,
    Mat mask,
    Rect rect,
    Mat bgdModel,
    Mat fgdModel,
    int iterCount,
    int mode,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::grabCut(
      *img.ptr,
      *mask.ptr,
      cv::Rect(rect.x, rect.y, rect.width, rect.height),
      *bgdModel.ptr,
      *fgdModel.ptr,
      iterCount,
      mode
  );
  callback();
  END_WRAP
}

CvStatus *
HoughCircles_Async(Mat src, int method, double dp, double minDist, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat circles;
  cv::HoughCircles(*src.ptr, circles, method, dp, minDist);
  callback(new Mat{new cv::Mat(circles)});
  END_WRAP
}

CvStatus *HoughCirclesWithParams_Async(
    Mat src,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat circles;
  cv::HoughCircles(*src.ptr, circles, method, dp, minDist, param1, param2, minRadius, maxRadius);
  callback(new Mat{new cv::Mat(circles)});
  END_WRAP
}

CvStatus *HoughLines_Async(
    Mat src,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat lines;
  cv::HoughLines(*src.ptr, lines, rho, theta, threshold, srn, stn, min_theta, max_theta);
  callback(new Mat{new cv::Mat(lines)});
  END_WRAP
}

CvStatus *
HoughLinesP_Async(Mat src, double rho, double theta, int threshold, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat lines;
  cv::HoughLinesP(*src.ptr, lines, rho, theta, threshold);
  callback(new Mat{new cv::Mat(lines)});
  END_WRAP
}

CvStatus *HoughLinesPWithParams_Async(
    Mat src,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat lines;
  cv::HoughLinesP(*src.ptr, lines, rho, theta, threshold, minLineLength, maxLineGap);
  callback(new Mat{new cv::Mat(lines)});
  END_WRAP
}

CvStatus *HoughLinesPointSet_Async(
    Mat points,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat lines;
  cv::HoughLinesPointSet(
      *points.ptr,
      lines,
      lines_max,
      threshold,
      min_rho,
      max_rho,
      rho_step,
      min_theta,
      max_theta,
      theta_step
  );
  callback(new Mat{new cv::Mat(lines)});
  END_WRAP
}

CvStatus *Integral_Async(Mat src, int sdepth, int sqdepth, CvCallback_3 callback) {
  BEGIN_WRAP
  cv::Mat sum, sqsum, tilted;
  cv::integral(*src.ptr, sum, sqsum, tilted, sdepth, sqdepth);
  callback(new Mat{new cv::Mat(sum)}, new Mat{new cv::Mat(sqsum)}, new Mat{new cv::Mat(tilted)});
  END_WRAP
}

CvStatus *Threshold_Async(Mat src, double thresh, double maxvalue, int typ, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  auto rval = cv::threshold(*src.ptr, dst, thresh, maxvalue, typ);
  callback(new double(rval), new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *AdaptiveThreshold_Async(
    Mat src,
    double maxValue,
    int adaptiveTyp,
    int typ,
    int blockSize,
    double c,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::adaptiveThreshold(*src.ptr, dst, maxValue, adaptiveTyp, typ, blockSize, c);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *ArrowedLine_Async(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::arrowedLine(
      *img.ptr,
      cv::Point(pt1.x, pt1.y),
      cv::Point(pt2.x, pt2.y),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      line_type,
      shift,
      tipLength
  );
  callback();
  END_WRAP
}

CvStatus *Circle_Async(
    Mat img, Point center, int radius, Scalar color, int thickness, CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::circle(
      *img.ptr,
      cv::Point(center.x, center.y),
      radius,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  callback();
  END_WRAP
}

CvStatus *CircleWithParams_Async(
    Mat img,
    Point center,
    int radius,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::circle(
      *img.ptr,
      cv::Point(center.x, center.y),
      radius,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      shift
  );
  callback();
  END_WRAP
}

CvStatus *Ellipse_Async(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::ellipse(
      *img.ptr,
      cv::Point(center.x, center.y),
      cv::Size(axes.x, axes.y),
      angle,
      startAngle,
      endAngle,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  callback();
  END_WRAP
}

CvStatus *EllipseWithParams_Async(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::ellipse(
      *img.ptr,
      cv::Point(center.x, center.y),
      cv::Size(axes.x, axes.y),
      angle,
      startAngle,
      endAngle,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      shift
  );
  callback();
  END_WRAP
}

CvStatus *Line_Async(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::line(
      *img.ptr,
      cv::Point(pt1.x, pt1.y),
      cv::Point(pt2.x, pt2.y),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      shift
  );
  callback();
  END_WRAP
}

CvStatus *Rectangle_Async(Mat img, Rect rect, Scalar color, int thickness, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::rectangle(
      *img.ptr,
      cv::Rect(rect.x, rect.y, rect.width, rect.height),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  callback();
  END_WRAP
}

CvStatus *RectangleWithParams_Async(
    Mat img, Rect rect, Scalar color, int thickness, int lineType, int shift, CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::rectangle(
      *img.ptr,
      cv::Rect(rect.x, rect.y, rect.width, rect.height),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      shift
  );
  callback();
  END_WRAP
}

CvStatus *FillPoly_Async(Mat img, VecVecPoint points, Scalar color, CvCallback_0 callback) {
  BEGIN_WRAP
  auto _points = vecvecpoint_c2cpp(points);
  cv::fillPoly(*img.ptr, _points, cv::Scalar(color.val1, color.val2, color.val3, color.val4));
  callback();
  END_WRAP
}

CvStatus *FillPolyWithParams_Async(
    Mat img,
    VecVecPoint points,
    Scalar color,
    int lineType,
    int shift,
    Point offset,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  auto _points = vecvecpoint_c2cpp(points);
  cv::fillPoly(
      *img.ptr,
      _points,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      lineType,
      shift,
      cv::Point(offset.x, offset.y)
  );
  callback();
  END_WRAP
}

CvStatus *Polylines_Async(
    Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness, CvCallback_0 callback
) {
  BEGIN_WRAP
  auto _points = vecvecpoint_c2cpp(points);
  cv::polylines(
      *img.ptr,
      _points,
      isClosed,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  callback();
  END_WRAP
}

CvStatus *GetTextSizeWithBaseline_Async(
    const char *text, int fontFace, double fontScale, int thickness, CvCallback_2 callback
) {
  BEGIN_WRAP
  int baseline;
  cv::Size r = cv::getTextSize(text, fontFace, fontScale, thickness, &baseline);
  callback(new Size{r.width, r.height}, new int(baseline));
  END_WRAP
}

CvStatus *PutText_Async(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::putText(
      *img.ptr,
      text,
      cv::Point(org.x, org.y),
      fontFace,
      fontScale,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  callback();
  END_WRAP
}

CvStatus *PutTextWithParams_Async(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    int lineType,
    bool bottomLeftOrigin,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::putText(
      *img.ptr,
      text,
      cv::Point(org.x, org.y),
      fontFace,
      fontScale,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      bottomLeftOrigin
  );
  callback();
  END_WRAP
}

CvStatus *Resize_Async(Mat src, Size sz, double fx, double fy, int interp, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::resize(*src.ptr, dst, cv::Size(sz.width, sz.height), fx, fy, interp);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *GetRectSubPix_Async(Mat src, Size patchSize, Point2f center, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::getRectSubPix(
      *src.ptr, cv::Size(patchSize.width, patchSize.height), cv::Point2f(center.x, center.y), dst
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
GetRotationMatrix2D_Async(Point2f center, double angle, double scale, CvCallback_1 callback) {
  BEGIN_WRAP
  auto mat = cv::getRotationMatrix2D(cv::Point2f(center.x, center.y), angle, scale);
  callback(new Mat{new cv::Mat(mat)});
  END_WRAP
}

CvStatus *WarpAffine_Async(Mat src, Mat rot_mat, Size dsize, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::warpAffine(*src.ptr, dst, *rot_mat.ptr, cv::Size(dsize.width, dsize.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *WarpAffineWithParams_Async(
    Mat src,
    Mat rot_mat,
    Size dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::warpAffine(
      *src.ptr,
      dst,
      *rot_mat.ptr,
      cv::Size(dsize.width, dsize.height),
      flags,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *WarpPerspective_Async(Mat src, Mat m, Size dsize, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::warpPerspective(*src.ptr, dst, *m.ptr, cv::Size(dsize.width, dsize.height));
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *WarpPerspectiveWithParams_Async(
    Mat src,
    Mat rot_mat,
    Size dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::warpPerspective(
      *src.ptr,
      dst,
      *rot_mat.ptr,
      cv::Size(dsize.width, dsize.height),
      flags,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Watershed_Async(Mat image, Mat markers, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::watershed(*image.ptr, *markers.ptr);
  callback();
  END_WRAP
}

CvStatus *ApplyColorMap_Async(Mat src, int colormap, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::applyColorMap(*src.ptr, dst, colormap);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *ApplyCustomColorMap_Async(Mat src, Mat colormap, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::applyColorMap(*src.ptr, dst, *colormap.ptr);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
GetPerspectiveTransform_Async(VecPoint src, VecPoint dst, int solveMethod, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Point2f> src2f = vecPointToVecPoint2f(src);
  std::vector<cv::Point2f> dst2f = vecPointToVecPoint2f(dst);
  callback(new Mat{new cv::Mat(cv::getPerspectiveTransform(src2f, dst2f, solveMethod))});
  END_WRAP
}

CvStatus *GetPerspectiveTransform2f_Async(
    VecPoint2f src, VecPoint2f dst, int solveMethod, CvCallback_1 callback
) {
  BEGIN_WRAP
  auto _src = vecpoint2f_c2cpp(src);
  auto _dst = vecpoint2f_c2cpp(dst);
  callback(new Mat{new cv::Mat(cv::getPerspectiveTransform(_src, _dst, solveMethod))});
  END_WRAP
}

CvStatus *GetAffineTransform_Async(VecPoint src, VecPoint dst, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<cv::Point2f> src2f = vecPointToVecPoint2f(src);
  std::vector<cv::Point2f> dst2f = vecPointToVecPoint2f(dst);
  callback(new Mat{new cv::Mat(cv::getAffineTransform(src2f, dst2f))});
  END_WRAP
}

CvStatus *GetAffineTransform2f_Async(VecPoint2f src, VecPoint2f dst, CvCallback_1 callback) {
  BEGIN_WRAP
  auto _src = vecpoint2f_c2cpp(src);
  auto _dst = vecpoint2f_c2cpp(dst);
  callback(new Mat{new cv::Mat(cv::getAffineTransform(_src, _dst))});
  END_WRAP
}

CvStatus *DrawContours_Async(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  auto _contours = vecvecpoint_c2cpp(contours);
  cv::Scalar _color = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
  cv::drawContours(*src.ptr, _contours, contourIdx, _color, thickness);
  callback();
  END_WRAP
}

CvStatus *DrawContoursWithParams_Async(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    Mat hierarchy,
    int maxLevel,
    Point offset,
    CvCallback_0 callback
) {
  BEGIN_WRAP
  auto _contours = vecvecpoint_c2cpp(contours);
  cv::Scalar _color = cv::Scalar(color.val1, color.val2, color.val3, color.val4);
  cv::drawContours(
      *src.ptr,
      _contours,
      contourIdx,
      _color,
      thickness,
      lineType,
      *hierarchy.ptr,
      maxLevel,
      cv::Point(offset.x, offset.y)
  );
  callback();
  END_WRAP
}

CvStatus *Sobel_Async(
    Mat src,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::Sobel(*src.ptr, dst, ddepth, dx, dy, ksize, scale, delta, borderType);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *SpatialGradient_Async(Mat src, int ksize, int borderType, CvCallback_2 callback) {
  BEGIN_WRAP
  cv::Mat dx, dy;
  cv::spatialGradient(*src.ptr, dx, dy, ksize, borderType);
  callback(new Mat{new cv::Mat(dx)}, new Mat{new cv::Mat(dy)});
  END_WRAP
}

CvStatus *Remap_Async(
    Mat src,
    Mat map1,
    Mat map2,
    int interpolation,
    int borderMode,
    Scalar borderValue,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::remap(
      *src.ptr,
      dst,
      *map1.ptr,
      *map2.ptr,
      interpolation,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *Filter2D_Async(
    Mat src,
    int ddepth,
    Mat kernel,
    Point anchor,
    double delta,
    int borderType,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::filter2D(
      *src.ptr, dst, ddepth, *kernel.ptr, cv::Point(anchor.x, anchor.y), delta, borderType
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *SepFilter2D_Async(
    Mat src,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    Point anchor,
    double delta,
    int borderType,
    CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::sepFilter2D(
      *src.ptr,
      dst,
      ddepth,
      *kernelX.ptr,
      *kernelY.ptr,
      cv::Point(anchor.x, anchor.y),
      delta,
      borderType
  );
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *LogPolar_Async(Mat src, Point2f center, double m, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::logPolar(*src.ptr, dst, cv::Point2f(center.x, center.y), m, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *FitLine_Async(
    VecPoint pts, int distType, double param, double reps, double aeps, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  auto _points = vecpoint_c2cpp(pts);
  cv::fitLine(_points, dst, distType, param, reps, aeps);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
LinearPolar_Async(Mat src, Point2f center, double maxRadius, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::linearPolar(*src.ptr, dst, cv::Point2f(center.x, center.y), maxRadius, flags);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *MatchShapes_Async(
    VecPoint contour1, VecPoint contour2, int method, double parameter, CvCallback_1 callback
) {
  BEGIN_WRAP
  auto _contour1 = vecpoint_c2cpp(contour1);
  auto _contour2 = vecpoint_c2cpp(contour2);
  auto rval = cv::matchShapes(_contour1, _contour2, method, parameter);
  callback(new double{rval});
  END_WRAP
}

CvStatus *ClipLine_Async(Rect imgRect, Point pt1, Point pt2, CvCallback_1 callback) {
  BEGIN_WRAP
  auto sz = cv::Rect(imgRect.x, imgRect.y, imgRect.width, imgRect.height);
  cv::Point p1(pt1.x, pt1.y);
  cv::Point p2(pt2.x, pt2.y);
  auto rval = cv::clipLine(sz, p1, p2);
  callback(new bool{rval});
  END_WRAP
}

CvStatus *CLAHE_Create_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new CLAHE{new cv::Ptr<cv::CLAHE>(cv::createCLAHE())});
  END_WRAP
}

CvStatus *CLAHE_CreateWithParams_Async(double clipLimit, Size tileGridSize, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new CLAHE{new cv::Ptr<cv::CLAHE>(
      cv::createCLAHE(clipLimit, cv::Size(tileGridSize.width, tileGridSize.height))
  )});
  END_WRAP
}

void CLAHE_Close_Async(CLAHEPtr self, CvCallback_0 callback) {
  self->ptr->reset();
  CVD_FREE(self);
  callback();
}

CvStatus *CLAHE_Apply_Async(CLAHE self, Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  (*self.ptr)->apply(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *CLAHE_CollectGarbage_Async(CLAHE self, CvCallback_0 callback) {
  BEGIN_WRAP(*self.ptr)->collectGarbage();
  callback();
  END_WRAP
}

CvStatus *CLAHE_GetClipLimit_Async(CLAHE self, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new double((*self.ptr)->getClipLimit()));
  END_WRAP
}

CvStatus *CLAHE_SetClipLimit_Async(CLAHE self, double clipLimit, CvCallback_0 callback) {
  BEGIN_WRAP(*self.ptr)->setClipLimit(clipLimit);
  callback();
  END_WRAP
}

CvStatus *CLAHE_GetTilesGridSize_Async(CLAHE self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto sz = (*self.ptr)->getTilesGridSize();
  callback(new Size{sz.width, sz.height});
  END_WRAP
}

CvStatus *CLAHE_SetTilesGridSize_Async(CLAHE self, Size size, CvCallback_0 callback) {
  BEGIN_WRAP(*self.ptr)->setTilesGridSize(cv::Size(size.width, size.height));
  callback();
  END_WRAP
}

CvStatus *Subdiv2D_NewEmpty_Async(CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Subdiv2D{new cv::Subdiv2D()});
  END_WRAP
}

CvStatus *Subdiv2D_NewWithRect_Async(Rect rect, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Subdiv2D{new cv::Subdiv2D(cv::Rect(rect.x, rect.y, rect.width, rect.height))});
  END_WRAP
}

void Subdiv2D_Close_Async(Subdiv2DPtr self, CvCallback_0 callback) {
  CVD_FREE(self);
  callback();
}

CvStatus *Subdiv2D_EdgeDst_Async(Subdiv2D self, int edge, CvCallback_2 callback) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  auto rval = self.ptr->edgeDst(edge, &p);
  callback(new int(rval), new Point2f{p.x, p.y});
  END_WRAP
}

CvStatus *Subdiv2D_EdgeOrg_Async(Subdiv2D self, int edge, CvCallback_2 callback) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  auto rval = self.ptr->edgeOrg(edge, &p);
  callback(new int(rval), new Point2f{p.x, p.y});
  END_WRAP
}

CvStatus *Subdiv2D_FindNearest_Async(Subdiv2D self, Point2f pt, CvCallback_2 callback) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  int rval = self.ptr->findNearest(cv::Point2f(pt.x, pt.y), &p);
  callback(new int(rval), new Point2f{p.x, p.y});
  END_WRAP
}

CvStatus *Subdiv2D_GetEdge_Async(Subdiv2D self, int edge, int nextEdgeType, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = self.ptr->getEdge(edge, nextEdgeType);
  callback(new int(rval));
  END_WRAP
}

CvStatus *Subdiv2D_GetEdgeList_Async(Subdiv2D self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto v = std::vector<cv::Vec4f>();
  self.ptr->getEdgeList(v);
  callback(vec_vec4f_cpp2c_p(v));
  END_WRAP
}

CvStatus *Subdiv2D_GetLeadingEdgeList_Async(Subdiv2D self, CvCallback_1 callback) {
  BEGIN_WRAP
  std::vector<int> v;
  self.ptr->getLeadingEdgeList(v);
  callback(vecint_cpp2c_p(v));
  END_WRAP
}

CvStatus *Subdiv2D_GetTriangleList_Async(Subdiv2D self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto v = std::vector<cv::Vec6f>();
  self.ptr->getTriangleList(v);
  callback(vec_vec6f_cpp2c_p(v));
  END_WRAP
}

CvStatus *Subdiv2D_GetVertex_Async(Subdiv2D self, int vertex, CvCallback_2 callback) {
  BEGIN_WRAP
  int firstEdge;
  cv::Point2f p = self.ptr->getVertex(vertex, &firstEdge);
  callback(new Point2f{p.x, p.y}, new int(firstEdge));
  END_WRAP
}

CvStatus *Subdiv2D_GetVoronoiFacetList_Async(Subdiv2D self, VecI32 idx, CvCallback_2 callback) {
  BEGIN_WRAP
  auto vf = std::vector<std::vector<cv::Point2f>>();
  auto vfc = std::vector<cv::Point2f>();
  auto _idx = vecint_c2cpp(idx);
  self.ptr->getVoronoiFacetList(_idx, vf, vfc);
  callback(vecvecpoint2f_cpp2c_p(vf), vecpoint2f_cpp2c_p(vfc));
  END_WRAP;
}

CvStatus *Subdiv2D_InitDelaunay_Async(Subdiv2D self, Rect rect, CvCallback_0 callback) {
  BEGIN_WRAP
  self.ptr->initDelaunay(cv::Rect(rect.x, rect.y, rect.width, rect.height));
  callback();
  END_WRAP
}

CvStatus *Subdiv2D_Insert_Async(Subdiv2D self, Point2f pt, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = self.ptr->insert(cv::Point2f(pt.x, pt.y));
  callback(new int(rval));
  END_WRAP
}

CvStatus *Subdiv2D_InsertVec_Async(Subdiv2D self, VecPoint2f ptvec, CvCallback_0 callback) {
  BEGIN_WRAP
  auto _ptvec = vecpoint2f_c2cpp(ptvec);
  self.ptr->insert(_ptvec);
  callback();
  END_WRAP
}

CvStatus *Subdiv2D_Locate_Async(Subdiv2D self, Point2f pt, CvCallback_3 callback) {
  BEGIN_WRAP
  int edge;
  int vertex;
  int rval = self.ptr->locate(cv::Point2f(pt.x, pt.y), edge, vertex);
  callback(new int(rval), new int(edge), new int(vertex));
  END_WRAP
}

CvStatus *Subdiv2D_NextEdge_Async(Subdiv2D self, int edge, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = self.ptr->nextEdge(edge);
  callback(new int(rval));
  END_WRAP
}

CvStatus *Subdiv2D_RotateEdge_Async(Subdiv2D self, int edge, int rotate, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = self.ptr->rotateEdge(edge, rotate);
  callback(new int(rval));
  END_WRAP
}

CvStatus *Subdiv2D_SymEdge_Async(Subdiv2D self, int edge, CvCallback_1 callback) {
  BEGIN_WRAP
  int rval = self.ptr->symEdge(edge);
  callback(new int(rval));
  END_WRAP
}

CvStatus *InvertAffineTransform_Async(Mat src, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::invertAffineTransform(*src.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *PhaseCorrelate_Async(Mat src1, Mat src2, Mat window, CvCallback_2 callback) {
  BEGIN_WRAP
  double response;
  auto p = cv::phaseCorrelate(*src1.ptr, *src2.ptr, *window.ptr, &response);
  // TODO: add Point2d
  callback(new Point2f{static_cast<float>(p.x), static_cast<float>(p.y)}, new double(response));
  END_WRAP
}

CvStatus *Mat_Accumulate_Async(Mat src, Mat dst, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulate(*src.ptr, *dst.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulateWithMask_Async(Mat src, Mat dst, Mat mask, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulate(*src.ptr, *dst.ptr, *mask.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulateSquare_Async(Mat src, Mat dst, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulateSquare(*src.ptr, *dst.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulateSquareWithMask_Async(Mat src, Mat dst, Mat mask, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulateSquare(*src.ptr, *dst.ptr, *mask.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulateProduct_Async(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulateProduct(*src1.ptr, *src2.ptr, *dst.ptr);
  callback();
  END_WRAP
}

CvStatus *
Mat_AccumulateProductWithMask_Async(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulateProduct(*src1.ptr, *src2.ptr, *dst.ptr, *mask.ptr);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulatedWeighted_Async(Mat src, Mat dst, double alpha, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::accumulateWeighted(*src.ptr, *dst.ptr, alpha);
  callback();
  END_WRAP
}

CvStatus *Mat_AccumulatedWeightedWithMask_Async(
    Mat src, Mat dst, double alpha, Mat mask, CvCallback_0 callback
) {
  BEGIN_WRAP
  cv::accumulateWeighted(*src.ptr, *dst.ptr, alpha, *mask.ptr);
  callback();
  END_WRAP
}
