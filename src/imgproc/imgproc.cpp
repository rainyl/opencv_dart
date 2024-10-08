/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "imgproc.h"
#include "core/types.h"
#include "core/vec.hpp"
#include <vector>

CvStatus *ArcLength(VecPoint curve, bool is_closed, double *rval) {
  BEGIN_WRAP
  auto _curve = vecpoint_c2cpp(curve);
  *rval = cv::arcLength(_curve, is_closed);
  END_WRAP
}
CvStatus *ApproxPolyDP(VecPoint curve, double epsilon, bool closed, VecPoint *rval) {
  BEGIN_WRAP
  std::vector<cv::Point> approxCurvePts;
  auto _curve = vecpoint_c2cpp(curve);
  cv::approxPolyDP(_curve, approxCurvePts, epsilon, closed);
  *rval = vecpoint_cpp2c(approxCurvePts);
  END_WRAP
}
CvStatus *CvtColor(Mat src, Mat dst, int code) {
  BEGIN_WRAP
  cv::cvtColor(*src.ptr, *dst.ptr, code);
  END_WRAP
}
CvStatus *EqualizeHist(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::equalizeHist(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *CalcHist(VecMat mats, VecI32 chans, Mat mask, Mat hist, VecI32 sz, VecF32 rng, bool acc) {
  BEGIN_WRAP
  auto _mats = vecmat_c2cpp(mats);
  auto _chans = vecint_c2cpp(chans);
  auto _sz = vecint_c2cpp(sz);
  auto _rng = vecfloat_c2cpp(rng);
  cv::calcHist(_mats, _chans, *mask.ptr, *hist.ptr, _sz, _rng, acc);
  END_WRAP
}
CvStatus *
CalcBackProject(VecMat mats, VecI32 chans, Mat hist, Mat *backProject, VecF32 rng, double scale) {
  BEGIN_WRAP
  cv::Mat _backProject;
  auto _mats = vecmat_c2cpp(mats);
  auto _chans = vecint_c2cpp(chans);
  auto _rng = vecfloat_c2cpp(rng);
  cv::calcBackProject(_mats, _chans, *hist.ptr, _backProject, _rng, scale);
  *backProject = {new cv::Mat(_backProject)};
  END_WRAP
}
CvStatus *CompareHist(Mat hist1, Mat hist2, int method, double *rval) {
  BEGIN_WRAP
  *rval = cv::compareHist(*hist1.ptr, *hist2.ptr, method);
  END_WRAP
}
CvStatus *ConvexHull(VecPoint points, Mat hull, bool clockwise, bool returnPoints) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(points);
  cv::convexHull(_points, *hull.ptr, clockwise, returnPoints);
  END_WRAP
}
CvStatus *ConvexityDefects(VecPoint points, Mat hull, Mat result) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(points);
  cv::convexityDefects(_points, *hull.ptr, *result.ptr);
  END_WRAP
}
CvStatus *BilateralFilter(Mat src, Mat dst, int d, double sc, double ss) {
  BEGIN_WRAP
  cv::bilateralFilter(*src.ptr, *dst.ptr, d, sc, ss);
  END_WRAP
}
CvStatus *Blur(Mat src, Mat dst, Size ps) {
  BEGIN_WRAP
  cv::blur(*src.ptr, *dst.ptr, cv::Size(ps.width, ps.height));
  END_WRAP
}
CvStatus *
BoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType) {
  BEGIN_WRAP
  cv::boxFilter(
      *src.ptr,
      *dst.ptr,
      ddepth,
      cv::Size(ps.width, ps.height),
      cv::Point(anchor.x, anchor.y),
      normalize,
      borderType
  );
  END_WRAP
}
CvStatus *
SqrBoxFilter(Mat src, Mat dst, int ddepth, Size ps, Point anchor, bool normalize, int borderType) {
  BEGIN_WRAP
  cv::sqrBoxFilter(*src.ptr, *dst.ptr, ddepth, cv::Size(ps.width, ps.height));
  END_WRAP
}
CvStatus *Dilate(Mat src, Mat dst, Mat kernel) {
  BEGIN_WRAP
  cv::dilate(*src.ptr, *dst.ptr, *kernel.ptr);
  END_WRAP
}
CvStatus *DilateWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
) {
  BEGIN_WRAP
  cv::dilate(
      *src.ptr,
      *dst.ptr,
      *kernel.ptr,
      cv::Point(anchor.x, anchor.y),
      iterations,
      borderType,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  END_WRAP
}
CvStatus *
DistanceTransform(Mat src, Mat dst, Mat labels, int distanceType, int maskSize, int labelType) {
  BEGIN_WRAP
  cv::distanceTransform(*src.ptr, *dst.ptr, *labels.ptr, distanceType, maskSize, labelType);
  END_WRAP
}
CvStatus *Erode(Mat src, Mat dst, Mat kernel) {
  BEGIN_WRAP
  cv::erode(*src.ptr, *dst.ptr, *kernel.ptr);
  END_WRAP
}
CvStatus *ErodeWithParams(
    Mat src, Mat dst, Mat kernel, Point anchor, int iterations, int borderType, Scalar borderValue
) {
  BEGIN_WRAP
  cv::erode(
      *src.ptr,
      *dst.ptr,
      *kernel.ptr,
      cv::Point(anchor.x, anchor.y),
      iterations,
      borderType,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  END_WRAP
}
CvStatus *MatchTemplate(Mat image, Mat templ, Mat result, int method, Mat mask) {
  BEGIN_WRAP
  cv::matchTemplate(*image.ptr, *templ.ptr, *result.ptr, method, *mask.ptr);
  END_WRAP
}
CvStatus *Moments(Mat src, bool binaryImage, Moment *rval) {
  BEGIN_WRAP
  auto m = cv::moments(*src.ptr, binaryImage);
  *rval = {
      m.m00,  m.m10,  m.m01,  m.m20,  m.m11,  m.m02,  m.m30,  m.m21,
      m.m12,  m.m03,  m.mu20, m.mu11, m.mu02, m.mu30, m.mu21, m.mu12,
      m.mu03, m.nu20, m.nu11, m.nu02, m.nu30, m.nu21, m.nu12, m.nu03,
  };
  END_WRAP
}
CvStatus *PyrDown(Mat src, Mat dst, Size dstsize, int borderType) {
  BEGIN_WRAP
  cv::pyrDown(*src.ptr, *dst.ptr, cv::Size(dstsize.width, dstsize.height), borderType);
  END_WRAP
}
CvStatus *PyrUp(Mat src, Mat dst, Size dstsize, int borderType) {
  BEGIN_WRAP
  cv::pyrUp(*src.ptr, *dst.ptr, cv::Size(dstsize.width, dstsize.height), borderType);
  END_WRAP
}
CvStatus *BoundingRect(VecPoint pts, Rect *rval) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  cv::Rect r = cv::boundingRect(_points);
  *rval = {r.x, r.y, r.width, r.height};
  END_WRAP
}

CvStatus *BoxPoints(RotatedRect rect, VecPoint2f *boxPts) {
  BEGIN_WRAP
  /// bottom left, top left, top right, bottom right
  auto mat = cv::Mat();
  auto center = cv::Point2f(rect.center.x, rect.center.y);
  auto size = cv::Size2f(rect.size.width, rect.size.height);
  cv::boxPoints(cv::RotatedRect(center, size, rect.angle), mat);
  std::vector<cv::Point2f> vec;
  for (int i = 0; i < mat.rows; i++) {
    vec.push_back(cv::Point2f(mat.at<float>(i, 0), mat.at<float>(i, 1)));
  }
  *boxPts = vecpoint2f_cpp2c(vec);
  END_WRAP
}
CvStatus *ContourArea(VecPoint pts, double *rval) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  *rval = cv::contourArea(_points);
  END_WRAP
}
CvStatus *MinAreaRect(VecPoint pts, RotatedRect *rval) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  auto r = cv::minAreaRect(_points);
  *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
  END_WRAP
}
CvStatus *FitEllipse(VecPoint pts, RotatedRect *rval) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  auto r = cv::fitEllipse(_points);
  *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
  END_WRAP
}
CvStatus *MinEnclosingCircle(VecPoint pts, Point2f *center, float *radius) {
  BEGIN_WRAP
  cv::Point2f c;
  float r;
  auto _points = vecpoint_c2cpp(pts);
  cv::minEnclosingCircle(_points, c, r);
  *center = {c.y, c.x};
  *radius = r;
  END_WRAP
}
CvStatus *FindContours(Mat src, Mat hierarchy, int mode, int method, VecVecPoint *rval) {
  BEGIN_WRAP
  std::vector<std::vector<cv::Point>> contours;
  //   std::vector<cv::Vec4i> hierarchy;
  cv::findContours(*src.ptr, contours, *hierarchy.ptr, mode, method);
  *rval = vecvecpoint_cpp2c(contours);
  END_WRAP
}
CvStatus *PointPolygonTest(VecPoint pts, Point2f pt, bool measureDist, double *rval) {
  BEGIN_WRAP
  auto _points = vecpoint_c2cpp(pts);
  double d = cv::pointPolygonTest(_points, cv::Point2f(pt.x, pt.y), measureDist);
  *rval = d;
  END_WRAP
}
CvStatus *
ConnectedComponents(Mat src, Mat dst, int connectivity, int ltype, int ccltype, int *rval) {
  BEGIN_WRAP
  *rval = cv::connectedComponents(*src.ptr, *dst.ptr, connectivity, ltype, ccltype);
  END_WRAP
}
CvStatus *ConnectedComponentsWithStats(
    Mat src,
    Mat labels,
    Mat stats,
    Mat centroids,
    int connectivity,
    int ltype,
    int ccltype,
    int *rval
) {
  BEGIN_WRAP
  *rval = cv::connectedComponentsWithStats(
      *src.ptr, *labels.ptr, *stats.ptr, *centroids.ptr, connectivity, ltype, ccltype
  );
  END_WRAP
}

CvStatus *GaussianBlur(Mat src, Mat dst, Size ps, double sX, double sY, int bt) {
  BEGIN_WRAP
  cv::GaussianBlur(*src.ptr, *dst.ptr, cv::Size(ps.width, ps.height), sX, sY, bt);
  END_WRAP
}
CvStatus *GetGaussianKernel(int ksize, double sigma, int ktype, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::getGaussianKernel(ksize, sigma, ktype))};
  END_WRAP
}
CvStatus *
Laplacian(Mat src, Mat dst, int dDepth, int kSize, double scale, double delta, int borderType) {
  BEGIN_WRAP
  cv::Laplacian(*src.ptr, *dst.ptr, dDepth, kSize, scale, delta, borderType);
  END_WRAP
}
CvStatus *
Scharr(Mat src, Mat dst, int dDepth, int dx, int dy, double scale, double delta, int borderType) {
  BEGIN_WRAP
  cv::Scharr(*src.ptr, *dst.ptr, dDepth, dx, dy, scale, delta, borderType);
  END_WRAP
}
CvStatus *GetStructuringElement(int shape, Size ksize, Mat *rval) {
  BEGIN_WRAP
  *rval = {new cv::Mat(cv::getStructuringElement(shape, cv::Size(ksize.width, ksize.height)))};
  END_WRAP
}
CvStatus *MorphologyDefaultBorderValue(Scalar *rval) {
  BEGIN_WRAP
  auto scalar = cv::morphologyDefaultBorderValue();
  *rval = {scalar.val[0], scalar.val[1], scalar.val[2], scalar.val[3]};
  END_WRAP
}
CvStatus *MorphologyEx(Mat src, Mat dst, int op, Mat kernel) {
  BEGIN_WRAP
  cv::morphologyEx(*src.ptr, *dst.ptr, op, *kernel.ptr);
  END_WRAP
}
CvStatus *MorphologyExWithParams(
    Mat src,
    Mat dst,
    int op,
    Mat kernel,
    Point pt,
    int iterations,
    int borderType,
    Scalar borderValue
) {
  BEGIN_WRAP
  auto bv = cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4);
  cv::morphologyEx(
      *src.ptr, *dst.ptr, op, *kernel.ptr, cv::Point(pt.x, pt.y), iterations, borderType, bv
  );
  END_WRAP
}
CvStatus *MedianBlur(Mat src, Mat dst, int ksize) {
  BEGIN_WRAP
  cv::medianBlur(*src.ptr, *dst.ptr, ksize);
  END_WRAP
}

CvStatus *Canny(Mat src, Mat edges, double t1, double t2, int apertureSize, bool l2gradient) {
  BEGIN_WRAP
  cv::Canny(*src.ptr, *edges.ptr, t1, t2, apertureSize, l2gradient);
  END_WRAP
}
CvStatus *
CornerSubPix(Mat img, VecPoint2f corners, Size winSize, Size zeroZone, TermCriteria criteria) {
  BEGIN_WRAP
  auto size = cv::Size(winSize.width, winSize.height);
  auto zone = cv::Size(zeroZone.width, zeroZone.height);
  auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
  auto _corners = vecpoint2f_c2cpp(corners);
  cv::cornerSubPix(*img.ptr, _corners, size, zone, tc);
  // std::cout << *corners.ptr << std::endl;
  END_WRAP
}
CvStatus *GoodFeaturesToTrack(
    Mat img,
    VecPoint2f *corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k
) {
  BEGIN_WRAP
  std::vector<cv::Point2f> _corners;
  cv::goodFeaturesToTrack(
      *img.ptr, _corners, maxCorners, quality, minDist, *mask.ptr, blockSize, useHarrisDetector, k
  );
  *corners = vecpoint2f_cpp2c(_corners);
  END_WRAP
}
CvStatus *GoodFeaturesToTrackWithGradient(
    Mat img,
    VecPoint2f *corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k
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
  *corners = vecpoint2f_cpp2c(_corners);
  END_WRAP
}
CvStatus *
GrabCut(Mat img, Mat mask, Rect rect, Mat bgdModel, Mat fgdModel, int iterCount, int mode) {
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
  END_WRAP
}
CvStatus *HoughCircles(Mat src, Mat circles, int method, double dp, double minDist) {
  BEGIN_WRAP
  cv::HoughCircles(*src.ptr, *circles.ptr, method, dp, minDist);
  END_WRAP
}
CvStatus *HoughCirclesWithParams(
    Mat src,
    Mat circles,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius
) {
  BEGIN_WRAP
  cv::HoughCircles(
      *src.ptr, *circles.ptr, method, dp, minDist, param1, param2, minRadius, maxRadius
  );
  END_WRAP
}
CvStatus *HoughLines(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta
) {
  BEGIN_WRAP
  cv::HoughLines(*src.ptr, *lines.ptr, rho, theta, threshold, srn, stn, min_theta, max_theta);
  END_WRAP
}
CvStatus *HoughLinesP(Mat src, Mat lines, double rho, double theta, int threshold) {
  BEGIN_WRAP
  cv::HoughLinesP(*src.ptr, *lines.ptr, rho, theta, threshold);
  END_WRAP
}
CvStatus *HoughLinesPWithParams(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap
) {
  BEGIN_WRAP
  cv::HoughLinesP(*src.ptr, *lines.ptr, rho, theta, threshold, minLineLength, maxLineGap);
  END_WRAP
}
CvStatus *HoughLinesPointSet(
    Mat points,
    Mat lines,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step
) {
  BEGIN_WRAP
  cv::HoughLinesPointSet(
      *points.ptr,
      *lines.ptr,
      lines_max,
      threshold,
      min_rho,
      max_rho,
      rho_step,
      min_theta,
      max_theta,
      theta_step
  );
  END_WRAP
}
CvStatus *Integral(Mat src, Mat sum, Mat sqsum, Mat tilted, int sdepth, int sqdepth) {
  BEGIN_WRAP
  cv::integral(*src.ptr, *sum.ptr, *sqsum.ptr, *tilted.ptr, sdepth, sqdepth);
  END_WRAP
}
CvStatus *Threshold(Mat src, Mat dst, double thresh, double maxvalue, int typ, double *rval) {
  BEGIN_WRAP
  *rval = cv::threshold(*src.ptr, *dst.ptr, thresh, maxvalue, typ);
  END_WRAP
}
CvStatus *AdaptiveThreshold(
    Mat src, Mat dst, double maxValue, int adaptiveTyp, int typ, int blockSize, double c
) {
  BEGIN_WRAP
  cv::adaptiveThreshold(*src.ptr, *dst.ptr, maxValue, adaptiveTyp, typ, blockSize, c);
  END_WRAP
}

CvStatus *ArrowedLine(
    Mat img,
    Point pt1,
    Point pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength
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
  END_WRAP
}
CvStatus *Circle(Mat img, Point center, int radius, Scalar color, int thickness) {
  BEGIN_WRAP
  cv::circle(
      *img.ptr,
      cv::Point(center.x, center.y),
      radius,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  END_WRAP
}
CvStatus *CircleWithParams(
    Mat img, Point center, int radius, Scalar color, int thickness, int lineType, int shift
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
  END_WRAP
}
CvStatus *Ellipse(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness
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
  END_WRAP
}
CvStatus *EllipseWithParams(
    Mat img,
    Point center,
    Point axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    int lineType,
    int shift
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
  END_WRAP
}
CvStatus *
Line(Mat img, Point pt1, Point pt2, Scalar color, int thickness, int lineType, int shift) {
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
  END_WRAP
}
CvStatus *Rectangle(Mat img, Rect rect, Scalar color, int thickness) {
  BEGIN_WRAP
  cv::rectangle(
      *img.ptr,
      cv::Rect(rect.x, rect.y, rect.width, rect.height),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  END_WRAP
}
CvStatus *
RectangleWithParams(Mat img, Rect rect, Scalar color, int thickness, int lineType, int shift) {
  BEGIN_WRAP
  cv::rectangle(
      *img.ptr,
      cv::Rect(rect.x, rect.y, rect.width, rect.height),
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      shift
  );
  END_WRAP
}
CvStatus *FillPoly(Mat img, VecVecPoint points, Scalar color) {
  BEGIN_WRAP
  auto _points = vecvecpoint_c2cpp(points);
  cv::fillPoly(*img.ptr, _points, cv::Scalar(color.val1, color.val2, color.val3, color.val4));
  END_WRAP
}
CvStatus *FillPolyWithParams(
    Mat img, VecVecPoint points, Scalar color, int lineType, int shift, Point offset
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
  END_WRAP
}
CvStatus *Polylines(Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness) {
  BEGIN_WRAP
  auto _points = vecvecpoint_c2cpp(points);
  cv::polylines(
      *img.ptr,
      _points,
      isClosed,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  END_WRAP
}
CvStatus *GetTextSizeWithBaseline(
    const char *text, int fontFace, double fontScale, int thickness, int *baseline, Size *rval
) {
  BEGIN_WRAP
  cv::Size r = cv::getTextSize(text, fontFace, fontScale, thickness, baseline);
  *rval = {r.width, r.height};
  END_WRAP
}
CvStatus *PutText(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness
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
  END_WRAP
}
CvStatus *PutTextWithParams(
    Mat img,
    const char *text,
    Point org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    int lineType,
    bool bottomLeftOrigin
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
  END_WRAP
}
CvStatus *Resize(Mat src, Mat dst, Size sz, double fx, double fy, int interp) {
  BEGIN_WRAP
  cv::resize(*src.ptr, *dst.ptr, cv::Size(sz.width, sz.height), fx, fy, interp);
  END_WRAP
}
CvStatus *GetRectSubPix(Mat src, Size patchSize, Point2f center, Mat dst) {
  BEGIN_WRAP
  cv::getRectSubPix(
      *src.ptr,
      cv::Size(patchSize.width, patchSize.height),
      cv::Point2f(center.x, center.y),
      *dst.ptr
  );
  END_WRAP
}
CvStatus *GetRotationMatrix2D(Point2f center, double angle, double scale, Mat *rval) {
  BEGIN_WRAP
  auto mat = cv::getRotationMatrix2D(cv::Point2f(center.x, center.y), angle, scale);
  *rval = {new cv::Mat(mat)};
  END_WRAP
}
CvStatus *WarpAffine(Mat src, Mat dst, Mat rot_mat, Size dsize) {
  BEGIN_WRAP
  cv::warpAffine(*src.ptr, *dst.ptr, *rot_mat.ptr, cv::Size(dsize.width, dsize.height));
  END_WRAP
}
CvStatus *WarpAffineWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
) {
  BEGIN_WRAP
  cv::warpAffine(
      *src.ptr,
      *dst.ptr,
      *rot_mat.ptr,
      cv::Size(dsize.width, dsize.height),
      flags,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  END_WRAP
}
CvStatus *WarpPerspective(Mat src, Mat dst, Mat m, Size dsize) {
  BEGIN_WRAP
  cv::warpPerspective(*src.ptr, *dst.ptr, *m.ptr, cv::Size(dsize.width, dsize.height));
  END_WRAP
}
CvStatus *WarpPerspectiveWithParams(
    Mat src, Mat dst, Mat rot_mat, Size dsize, int flags, int borderMode, Scalar borderValue
) {
  BEGIN_WRAP
  cv::warpPerspective(
      *src.ptr,
      *dst.ptr,
      *rot_mat.ptr,
      cv::Size(dsize.width, dsize.height),
      flags,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  END_WRAP
}
CvStatus *Watershed(Mat image, Mat markers) {
  BEGIN_WRAP
  cv::watershed(*image.ptr, *markers.ptr);
  END_WRAP
}
CvStatus *ApplyColorMap(Mat src, Mat dst, int colormap) {
  BEGIN_WRAP
  cv::applyColorMap(*src.ptr, *dst.ptr, colormap);
  END_WRAP
}
CvStatus *ApplyCustomColorMap(Mat src, Mat dst, Mat colormap) {
  BEGIN_WRAP
  cv::applyColorMap(*src.ptr, *dst.ptr, *colormap.ptr);
  END_WRAP
}

CvStatus *GetPerspectiveTransform(VecPoint src, VecPoint dst, Mat *rval, int solveMethod) {
  BEGIN_WRAP
  std::vector<cv::Point2f> src2f = vecPointToVecPoint2f(src);
  std::vector<cv::Point2f> dst2f = vecPointToVecPoint2f(dst);
  *rval = {new cv::Mat(cv::getPerspectiveTransform(src2f, dst2f, solveMethod))};
  END_WRAP
}
CvStatus *GetPerspectiveTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval, int solveMethod) {
  BEGIN_WRAP
  auto _src = vecpoint2f_c2cpp(src);
  auto _dst = vecpoint2f_c2cpp(dst);
  *rval = {new cv::Mat(cv::getPerspectiveTransform(_src, _dst, solveMethod))};
  END_WRAP
}
CvStatus *GetAffineTransform(VecPoint src, VecPoint dst, Mat *rval) {
  BEGIN_WRAP
  std::vector<cv::Point2f> src2f = vecPointToVecPoint2f(src);
  std::vector<cv::Point2f> dst2f = vecPointToVecPoint2f(dst);
  *rval = {new cv::Mat(cv::getAffineTransform(src2f, dst2f))};
  END_WRAP
}
CvStatus *GetAffineTransform2f(VecPoint2f src, VecPoint2f dst, Mat *rval) {
  BEGIN_WRAP
  auto _src = vecpoint2f_c2cpp(src);
  auto _dst = vecpoint2f_c2cpp(dst);
  *rval = {new cv::Mat(cv::getAffineTransform(_src, _dst))};
  END_WRAP
}

CvStatus *DrawContours(Mat src, VecVecPoint contours, int contourIdx, Scalar color, int thickness) {
  BEGIN_WRAP
  auto _contours = vecvecpoint_c2cpp(contours);
  cv::drawContours(
      *src.ptr,
      _contours,
      contourIdx,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness
  );
  END_WRAP
}
CvStatus *DrawContoursWithParams(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    Mat hierarchy,
    int maxLevel,
    Point offset
) {
  BEGIN_WRAP
  auto _contours = vecvecpoint_c2cpp(contours);
  cv::drawContours(
      *src.ptr,
      _contours,
      contourIdx,
      cv::Scalar(color.val1, color.val2, color.val3, color.val4),
      thickness,
      lineType,
      *hierarchy.ptr,
      maxLevel,
      cv::Point(offset.x, offset.y)
  );
  END_WRAP
}
CvStatus *Sobel(
    Mat src,
    Mat dst,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType
) {
  BEGIN_WRAP
  cv::Sobel(*src.ptr, *dst.ptr, ddepth, dx, dy, ksize, scale, delta, borderType);
  END_WRAP
}
CvStatus *SpatialGradient(Mat src, Mat dx, Mat dy, int ksize, int borderType) {
  BEGIN_WRAP
  cv::spatialGradient(*src.ptr, *dx.ptr, *dy.ptr, ksize, borderType);
  END_WRAP
}
CvStatus *
Remap(Mat src, Mat dst, Mat map1, Mat map2, int interpolation, int borderMode, Scalar borderValue) {
  BEGIN_WRAP
  cv::remap(
      *src.ptr,
      *dst.ptr,
      *map1.ptr,
      *map2.ptr,
      interpolation,
      borderMode,
      cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
  );
  END_WRAP
}
CvStatus *
Filter2D(Mat src, Mat dst, int ddepth, Mat kernel, Point anchor, double delta, int borderType) {
  BEGIN_WRAP
  cv::filter2D(
      *src.ptr, *dst.ptr, ddepth, *kernel.ptr, cv::Point(anchor.x, anchor.y), delta, borderType
  );
  END_WRAP
}
CvStatus *SepFilter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    Point anchor,
    double delta,
    int borderType
) {
  BEGIN_WRAP
  cv::sepFilter2D(
      *src.ptr,
      *dst.ptr,
      ddepth,
      *kernelX.ptr,
      *kernelY.ptr,
      cv::Point(anchor.x, anchor.y),
      delta,
      borderType
  );
  END_WRAP
}
CvStatus *LogPolar(Mat src, Mat dst, Point2f center, double m, int flags) {
  BEGIN_WRAP
  cv::logPolar(*src.ptr, *dst.ptr, cv::Point2f(center.x, center.y), m, flags);
  END_WRAP
}
CvStatus *FitLine(VecPoint pts, Mat line, int distType, double param, double reps, double aeps) {
  BEGIN_WRAP
  auto _pts = vecpoint_c2cpp(pts);
  cv::fitLine(_pts, *line.ptr, distType, param, reps, aeps);
  END_WRAP
}
CvStatus *LinearPolar(Mat src, Mat dst, Point2f center, double maxRadius, int flags) {
  BEGIN_WRAP
  cv::linearPolar(*src.ptr, *dst.ptr, cv::Point2f(center.x, center.y), maxRadius, flags);
  END_WRAP
}
CvStatus *
MatchShapes(VecPoint contour1, VecPoint contour2, int method, double parameter, double *rval) {
  BEGIN_WRAP
  auto _contour1 = vecpoint_c2cpp(contour1);
  auto _contour2 = vecpoint_c2cpp(contour2);
  *rval = cv::matchShapes(_contour1, _contour2, method, parameter);
  END_WRAP
}
CvStatus *ClipLine(Rect imgRect, Point pt1, Point pt2, bool *rval) {
  BEGIN_WRAP
  auto sz = cv::Rect(imgRect.x, imgRect.y, imgRect.width, imgRect.height);
  cv::Point p1(pt1.x, pt1.y);
  cv::Point p2(pt2.x, pt2.y);
  *rval = cv::clipLine(sz, p1, p2);
  END_WRAP
}

CvStatus *CLAHE_Create(CLAHE *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::CLAHE>(cv::createCLAHE())};
  END_WRAP
}
CvStatus *CLAHE_CreateWithParams(double clipLimit, Size tileGridSize, CLAHE *rval) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::CLAHE>(
      cv::createCLAHE(clipLimit, cv::Size(tileGridSize.width, tileGridSize.height))
  )};
  END_WRAP
}
void CLAHE_Close(CLAHEPtr c) {
  c->ptr->reset();
  CVD_FREE(c);
}

CvStatus *CLAHE_Apply(CLAHE c, Mat src, Mat dst) {
  BEGIN_WRAP(*c.ptr)->apply(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *CLAHE_CollectGarbage(CLAHE c) {
  BEGIN_WRAP(*c.ptr)->collectGarbage();
  END_WRAP
}

CvStatus *CLAHE_GetClipLimit(CLAHE c, double *rval) {
  BEGIN_WRAP
  *rval = (*c.ptr)->getClipLimit();
  END_WRAP
}
CvStatus *CLAHE_SetClipLimit(CLAHE c, double clipLimit) {
  BEGIN_WRAP(*c.ptr)->setClipLimit(clipLimit);
  END_WRAP
}
CvStatus *CLAHE_GetTilesGridSize(CLAHE c, Size *rval) {
  BEGIN_WRAP
  auto sz = (*c.ptr)->getTilesGridSize();
  *rval = {sz.width, sz.height};
  END_WRAP
}
CvStatus *CLAHE_SetTilesGridSize(CLAHE c, Size size) {
  BEGIN_WRAP(*c.ptr)->setTilesGridSize(cv::Size(size.width, size.height));
  END_WRAP
}

CvStatus *Subdiv2D_NewEmpty(Subdiv2D *rval) {
  BEGIN_WRAP
  *rval = {new cv::Subdiv2D()};
  END_WRAP
}
CvStatus *Subdiv2D_NewWithRect(Rect rect, Subdiv2D *rval) {
  BEGIN_WRAP
  *rval = {new cv::Subdiv2D(cv::Rect(rect.x, rect.y, rect.width, rect.height))};
  END_WRAP
}
void Subdiv2D_Close(Subdiv2DPtr self) { CVD_FREE(self); }

CvStatus *Subdiv2D_EdgeDst(Subdiv2D self, int edge, Point2f *dstpt, int *rval) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  *rval = self.ptr->edgeDst(edge, &p);
  *dstpt = {p.x, p.y};
  END_WRAP
}
CvStatus *Subdiv2D_EdgeOrg(Subdiv2D self, int edge, Point2f *orgpt, int *rval) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  *rval = self.ptr->edgeOrg(edge, &p);
  *orgpt = {p.x, p.y};
  END_WRAP
}
CvStatus *Subdiv2D_FindNearest(Subdiv2D self, Point2f pt, Point2f *nearestPt, int *rval) {
  BEGIN_WRAP
  auto p = cv::Point2f();
  *rval = self.ptr->findNearest(cv::Point2f(pt.x, pt.y), &p);
  *nearestPt = {p.x, p.y};
  END_WRAP
}
CvStatus *Subdiv2D_GetEdge(Subdiv2D self, int edge, int nextEdgeType, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->getEdge(edge, nextEdgeType);
  END_WRAP
}
CvStatus *Subdiv2D_GetEdgeList(Subdiv2D self, Vec4f **rval, size_t *size) {
  BEGIN_WRAP
  auto v = std::vector<cv::Vec4f>();
  self.ptr->getEdgeList(v);
  *size = v.size();
  auto rv = new Vec4f[v.size()];
  for (int i = 0; i < v.size(); i++) {
    rv[i] = {v[i].val[0], v[i].val[1], v[i].val[2], v[i].val[3]};
  }
  *rval = rv;
  END_WRAP
}
CvStatus *Subdiv2D_GetLeadingEdgeList(Subdiv2D self, VecI32 *leadingEdgeList) {
  BEGIN_WRAP
  std::vector<int> v;
  self.ptr->getLeadingEdgeList(v);
  *leadingEdgeList = vecint_cpp2c(v);
  END_WRAP
}
CvStatus *Subdiv2D_GetTriangleList(Subdiv2D self, Vec6f **rval, size_t *size) {
  BEGIN_WRAP
  auto v = std::vector<cv::Vec6f>();
  self.ptr->getTriangleList(v);
  *size = v.size();
  auto rv = new Vec6f[v.size()];
  for (int i = 0; i < v.size(); i++) {
    rv[i] = {v[i].val[0], v[i].val[1], v[i].val[2], v[i].val[3], v[i].val[4], v[i].val[5]};
  }
  *rval = rv;
  END_WRAP
}
CvStatus *Subdiv2D_GetVertex(Subdiv2D self, int vertex, int *firstEdge, Point2f *rval) {
  BEGIN_WRAP
  auto p = self.ptr->getVertex(vertex, firstEdge);
  *rval = {p.x, p.y};
  END_WRAP
}
CvStatus *Subdiv2D_GetVoronoiFacetList(
    Subdiv2D self, VecI32 idx, VecVecPoint2f *facetList, VecPoint2f *facetCenters
) {
  BEGIN_WRAP
  auto vf = std::vector<std::vector<cv::Point2f>>();
  auto vfc = std::vector<cv::Point2f>();
  auto _idx = vecint_c2cpp(idx);
  self.ptr->getVoronoiFacetList(_idx, vf, vfc);
  *facetList = vecvecpoint2f_cpp2c(vf);
  *facetCenters = vecpoint2f_cpp2c(vfc);
  END_WRAP;
}
CvStatus *Subdiv2D_InitDelaunay(Subdiv2D self, Rect rect) {
  BEGIN_WRAP
  self.ptr->initDelaunay(cv::Rect(rect.x, rect.y, rect.width, rect.height));
  END_WRAP
}
CvStatus *Subdiv2D_Insert(Subdiv2D self, Point2f pt, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->insert(cv::Point2f(pt.x, pt.y));
  END_WRAP
}
CvStatus *Subdiv2D_InsertVec(Subdiv2D self, VecPoint2f ptvec) {
  BEGIN_WRAP
  auto _ptvec = vecpoint2f_c2cpp(ptvec);
  self.ptr->insert(_ptvec);
  END_WRAP
}
CvStatus *Subdiv2D_Locate(Subdiv2D self, Point2f pt, int *edge, int *vertex, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->locate(cv::Point2f(pt.x, pt.y), *edge, *vertex);
  END_WRAP
}
CvStatus *Subdiv2D_NextEdge(Subdiv2D self, int edge, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->nextEdge(edge);
  END_WRAP
}
CvStatus *Subdiv2D_RotateEdge(Subdiv2D self, int edge, int rotate, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->rotateEdge(edge, rotate);
  END_WRAP
}
CvStatus *Subdiv2D_SymEdge(Subdiv2D self, int edge, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->symEdge(edge);
  END_WRAP
}

CvStatus *InvertAffineTransform(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::invertAffineTransform(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *PhaseCorrelate(Mat src1, Mat src2, Mat window, double *response, Point2f *rval) {
  BEGIN_WRAP
  auto p = cv::phaseCorrelate(*src1.ptr, *src2.ptr, *window.ptr, response);
  // TODO: add Point2d
  *rval = {static_cast<float>(p.x), static_cast<float>(p.y)};
  END_WRAP
}

CvStatus *Mat_Accumulate(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::accumulate(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulateWithMask(Mat src, Mat dst, Mat mask) {
  BEGIN_WRAP
  cv::accumulate(*src.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulateSquare(Mat src, Mat dst) {
  BEGIN_WRAP
  cv::accumulateSquare(*src.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulateSquareWithMask(Mat src, Mat dst, Mat mask) {
  BEGIN_WRAP
  cv::accumulateSquare(*src.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulateProduct(Mat src1, Mat src2, Mat dst) {
  BEGIN_WRAP
  cv::accumulateProduct(*src1.ptr, *src2.ptr, *dst.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulateProductWithMask(Mat src1, Mat src2, Mat dst, Mat mask) {
  BEGIN_WRAP
  cv::accumulateProduct(*src1.ptr, *src2.ptr, *dst.ptr, *mask.ptr);
  END_WRAP
}
CvStatus *Mat_AccumulatedWeighted(Mat src, Mat dst, double alpha) {
  BEGIN_WRAP
  cv::accumulateWeighted(*src.ptr, *dst.ptr, alpha);
  END_WRAP
}
CvStatus *Mat_AccumulatedWeightedWithMask(Mat src, Mat dst, double alpha, Mat mask) {
  BEGIN_WRAP
  cv::accumulateWeighted(*src.ptr, *dst.ptr, alpha, *mask.ptr);
  END_WRAP
}

CvStatus *FloodFill(
    Mat src,
    Mat mask,
    Point seedPoint,
    Scalar newVal,
    Rect *rect,
    Scalar loDiff,
    Scalar upDiff,
    int flags,
    int *rval
) {
  BEGIN_WRAP
  auto _seedPoint = cv::Point(seedPoint.x, seedPoint.y);
  auto _rect = cv::Rect();
  auto _newVal = cv::Scalar(newVal.val1, newVal.val2, newVal.val3, newVal.val4);
  auto _loDiff = cv::Scalar(loDiff.val1, loDiff.val2, loDiff.val3, loDiff.val4);
  auto _upDiff = cv::Scalar(upDiff.val1, upDiff.val2, upDiff.val3, upDiff.val4);
  *rval = cv::floodFill(*src.ptr, *mask.ptr, _seedPoint, _newVal, &_rect, _loDiff, _upDiff, flags);
  rect->x = _rect.x;
  rect->y = _rect.y;
  rect->width = _rect.width;
  rect->height = _rect.height;
  END_WRAP
}
