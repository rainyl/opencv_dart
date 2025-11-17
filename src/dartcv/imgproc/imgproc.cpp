/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "dartcv/imgproc/imgproc.h"
#include <vector>

CvStatus* cv_arcLength(VecPoint curve, bool is_closed, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::arcLength(CVDEREF(curve), is_closed);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_arcLength2f(
    VecPoint2f curve, bool is_closed, CVD_OUT double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::arcLength(CVDEREF(curve), is_closed);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_approxPolyDP(
    VecPoint curve, double epsilon, bool closed, VecPoint* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::approxPolyDP(CVDEREF(curve), CVDEREF_P(rval), epsilon, closed);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_approxPolyDP2f(
    VecPoint2f curve, double epsilon, bool closed, CVD_OUT VecPoint2f* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::approxPolyDP(CVDEREF(curve), CVDEREF_P(rval), epsilon, closed);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_approxPolyN(
    VecPoint curve,
    int nsides,
    float epsilon_percentage,
    bool ensure_convex,
    VecPoint* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::approxPolyN(CVDEREF(curve), CVDEREF_P(rval), nsides, epsilon_percentage, ensure_convex);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_approxPolyN2f(
    VecPoint2f curve,
    int nsides,
    float epsilon_percentage,
    bool ensure_convex,
    VecPoint2f* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::approxPolyN(CVDEREF(curve), CVDEREF_P(rval), nsides, epsilon_percentage, ensure_convex);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_cvtColor(Mat src, Mat dst, int code, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::cvtColor(CVDEREF(src), CVDEREF(dst), code);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_equalizeHist(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::equalizeHist(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_calcHist(
    VecMat mats,
    VecI32 chans,
    Mat mask,
    Mat hist,
    VecI32 sz,
    VecF32 rng,
    bool acc,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::calcHist(
        CVDEREF(mats), CVDEREF(chans), CVDEREF(mask), CVDEREF(hist), CVDEREF(sz), CVDEREF(rng), acc
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_calcBackProject(
    VecMat mats,
    VecI32 chans,
    Mat hist,
    Mat backProject,
    VecF32 rng,
    double scale,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::calcBackProject(
        CVDEREF(mats), CVDEREF(chans), CVDEREF(hist), CVDEREF(backProject), CVDEREF(rng), scale
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_compareHist(Mat hist1, Mat hist2, int method, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::compareHist(CVDEREF(hist1), CVDEREF(hist2), method);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_convexHull(
    VecPoint points, Mat hull, bool clockwise, bool returnPoints, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::convexHull(CVDEREF(points), CVDEREF(hull), clockwise, returnPoints);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_convexHull2f(
    VecPoint2f points, CVD_OUT Mat hull, bool clockwise, bool returnPoints, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::convexHull(CVDEREF(points), CVDEREF(hull), clockwise, returnPoints);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_convexityDefects(VecPoint points, Mat hull, Mat result, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::convexityDefects(CVDEREF(points), CVDEREF(hull), CVDEREF(result));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_convexityDefects2f(VecPoint2f points, Mat hull, Mat result, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::convexityDefects(CVDEREF(points), CVDEREF(hull), CVDEREF(result));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_bilateralFilter(Mat src, Mat dst, int d, double sc, double ss, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::bilateralFilter(CVDEREF(src), CVDEREF(dst), d, sc, ss);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_blur(Mat src, Mat dst, CvSize ps, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::blur(CVDEREF(src), CVDEREF(dst), cv::Size(ps.width, ps.height));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_boxFilter(
    Mat src,
    Mat dst,
    int ddepth,
    CvSize ps,
    CvPoint anchor,
    bool normalize,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::boxFilter(
        CVDEREF(src),
        CVDEREF(dst),
        ddepth,
        cv::Size(ps.width, ps.height),
        cv::Point(anchor.x, anchor.y),
        normalize,
        borderType
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_sqrBoxFilter(
    Mat src,
    Mat dst,
    int ddepth,
    CvSize ps,
    CvPoint anchor,
    bool normalize,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::sqrBoxFilter(CVDEREF(src), CVDEREF(dst), ddepth, cv::Size(ps.width, ps.height));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dilate(Mat src, Mat dst, Mat kernel, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::dilate(CVDEREF(src), CVDEREF(dst), CVDEREF(kernel));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_dilate_1(
    Mat src,
    Mat dst,
    Mat kernel,
    CvPoint anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::dilate(
        CVDEREF(src),
        CVDEREF(dst),
        CVDEREF(kernel),
        cv::Point(anchor.x, anchor.y),
        iterations,
        borderType,
        cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_distanceTransform(
    Mat src,
    Mat dst,
    Mat labels,
    int distanceType,
    int maskSize,
    int labelType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::distanceTransform(
        CVDEREF(src), CVDEREF(dst), CVDEREF(labels), distanceType, maskSize, labelType
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_erode(Mat src, Mat dst, Mat kernel, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::erode(CVDEREF(src), CVDEREF(dst), CVDEREF(kernel));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_erode_1(
    Mat src,
    Mat dst,
    Mat kernel,
    CvPoint anchor,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::erode(
        CVDEREF(src),
        CVDEREF(dst),
        CVDEREF(kernel),
        cv::Point(anchor.x, anchor.y),
        iterations,
        borderType,
        cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_matchTemplate(
    Mat image, Mat templ, Mat result, int method, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::matchTemplate(CVDEREF(image), CVDEREF(templ), CVDEREF(result), method, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_moments(Mat src, bool binaryImage, Moment* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto m = cv::moments(CVDEREF(src), binaryImage);
    *rval = {
        m.m00,  m.m10,  m.m01,  m.m20,  m.m11,  m.m02,  m.m30,  m.m21,
        m.m12,  m.m03,  m.mu20, m.mu11, m.mu02, m.mu30, m.mu21, m.mu12,
        m.mu03, m.nu20, m.nu11, m.nu02, m.nu30, m.nu21, m.nu12, m.nu03,
    };
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_pyrDown(Mat src, Mat dst, CvSize dstsize, int borderType, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::pyrDown(CVDEREF(src), CVDEREF(dst), cv::Size(dstsize.width, dstsize.height), borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_pyrUp(Mat src, Mat dst, CvSize dstsize, int borderType, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::pyrUp(CVDEREF(src), CVDEREF(dst), cv::Size(dstsize.width, dstsize.height), borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_boundingRect(VecPoint pts, CvRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Rect r = cv::boundingRect(CVDEREF(pts));
    *rval = {r.x, r.y, r.width, r.height};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_boundingRect2f(VecPoint2f pts, CvRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::Rect r = cv::boundingRect(CVDEREF(pts));
    *rval = {r.x, r.y, r.width, r.height};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_boxPoints(RotatedRect rect, VecPoint2f* boxPts, CvCallback_0 callback) {
    BEGIN_WRAP
    /// bottom left, top left, top right, bottom right
    auto mat = cv::Mat();
    auto center = cv::Point2f(rect.center.x, rect.center.y);
    auto size = cv::Size2f(rect.size.width, rect.size.height);
    cv::boxPoints(cv::RotatedRect(center, size, rect.angle), mat);
    boxPts->ptr->resize(mat.rows);
    for (int i = 0; i < mat.rows; i++) {
        boxPts->ptr->at(i) = cv::Point2f(mat.at<float>(i, 0), mat.at<float>(i, 1));
    }
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_contourArea(VecPoint pts, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::contourArea(CVDEREF(pts));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_contourArea2f(VecPoint2f pts, double* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = cv::contourArea(CVDEREF(pts));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_minAreaRect(VecPoint pts, RotatedRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto r = cv::minAreaRect(CVDEREF(pts));
    *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_minAreaRect2f(VecPoint2f pts, RotatedRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto r = cv::minAreaRect(CVDEREF(pts));
    *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fitEllipse(VecPoint pts, RotatedRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto r = cv::fitEllipse(CVDEREF(pts));
    *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fitEllipse2f(VecPoint2f pts, RotatedRect* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto r = cv::fitEllipse(CVDEREF(pts));
    *rval = {{r.center.x, r.center.y}, {r.size.width, r.size.height}, r.angle};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_minEnclosingCircle(
    VecPoint pts, CvPoint2f* center, float* radius, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Point2f c;
    float r;
    cv::minEnclosingCircle(CVDEREF(pts), c, r);
    *center = {c.x, c.y};
    *radius = r;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_minEnclosingCircle2f(
    VecPoint2f pts, CvPoint2f* center, float* radius, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Point2f c;
    float r;
    cv::minEnclosingCircle(CVDEREF(pts), c, r);
    *center = {c.x, c.y};
    *radius = r;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_findContours(
    Mat src,
    VecVecPoint* out_contours,
    VecVec4i* out_hierarchy,
    int mode,
    int method,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::findContours(CVDEREF(src), CVDEREF_P(out_contours), CVDEREF_P(out_hierarchy), mode, method);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_findContours2f(
    Mat src,
    VecVecPoint2f* out_contours,
    VecVec4i* out_hierarchy,
    int mode,
    int method,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    std::vector<std::vector<cv::Point>> _out_contours;
    cv::findContours(CVDEREF(src), _out_contours, CVDEREF_P(out_hierarchy), mode, method);
    for (auto& c : _out_contours) {
        std::vector<cv::Point2f> _row;
        for (const auto& p : c) {
            _row.emplace_back(static_cast<float>(p.x), static_cast<float>(p.y));
        }
        (CVDEREF_P(out_contours)).emplace_back(_row);
    }
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_pointPolygonTest(
    VecPoint pts, CvPoint2f pt, bool measureDist, double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    double d = cv::pointPolygonTest(CVDEREF(pts), cv::Point2f(pt.x, pt.y), measureDist);
    *rval = d;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_pointPolygonTest2f(
    VecPoint2f pts, CvPoint2f pt, bool measureDist, double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    double d = cv::pointPolygonTest(CVDEREF(pts), cv::Point2f(pt.x, pt.y), measureDist);
    *rval = d;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_connectedComponents(
    Mat src, Mat dst, int connectivity, int ltype, int ccltype, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::connectedComponents(CVDEREF(src), CVDEREF(dst), connectivity, ltype, ccltype);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_connectedComponents_1(
    Mat src,
    Mat labels,
    Mat stats,
    Mat centroids,
    int connectivity,
    int ltype,
    int ccltype,
    int* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::connectedComponentsWithStats(
        CVDEREF(src),
        CVDEREF(labels),
        CVDEREF(stats),
        CVDEREF(centroids),
        connectivity,
        ltype,
        ccltype
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_GaussianBlur(
    Mat src, Mat dst, CvSize ps, double sX, double sY, int bt, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::GaussianBlur(CVDEREF(src), CVDEREF(dst), cv::Size(ps.width, ps.height), sX, sY, bt);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getGaussianKernel(
    int ksize, double sigma, int ktype, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(cv::getGaussianKernel(ksize, sigma, ktype));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Laplacian(
    Mat src,
    Mat dst,
    int dDepth,
    int kSize,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Laplacian(CVDEREF(src), CVDEREF(dst), dDepth, kSize, scale, delta, borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Scharr(
    Mat src,
    Mat dst,
    int dDepth,
    int dx,
    int dy,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Scharr(CVDEREF(src), CVDEREF(dst), dDepth, dx, dy, scale, delta, borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getStructuringElement(int shape, CvSize ksize, Mat* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(cv::getStructuringElement(shape, cv::Size(ksize.width, ksize.height)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_morphologyDefaultBorderValue(Scalar* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto scalar = cv::morphologyDefaultBorderValue();
    *rval = {scalar.val[0], scalar.val[1], scalar.val[2], scalar.val[3]};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_morphologyEx(Mat src, Mat dst, int op, Mat kernel, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::morphologyEx(CVDEREF(src), CVDEREF(dst), op, CVDEREF(kernel));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_morphologyEx_1(
    Mat src,
    Mat dst,
    int op,
    Mat kernel,
    CvPoint pt,
    int iterations,
    int borderType,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto bv = cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4);
    cv::morphologyEx(
        CVDEREF(src),
        CVDEREF(dst),
        op,
        CVDEREF(kernel),
        cv::Point(pt.x, pt.y),
        iterations,
        borderType,
        bv
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_medianBlur(Mat src, Mat dst, int ksize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::medianBlur(CVDEREF(src), CVDEREF(dst), ksize);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_canny(
    Mat src,
    Mat edges,
    double t1,
    double t2,
    int apertureSize,
    bool l2gradient,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Canny(CVDEREF(src), CVDEREF(edges), t1, t2, apertureSize, l2gradient);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_cornerSubPix(
    Mat img,
    VecPoint2f corners,
    CvSize winSize,
    CvSize zeroZone,
    TermCriteria criteria,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto size = cv::Size(winSize.width, winSize.height);
    auto zone = cv::Size(zeroZone.width, zeroZone.height);
    auto tc = cv::TermCriteria(criteria.type, criteria.maxCount, criteria.epsilon);
    cv::cornerSubPix(CVDEREF(img), CVDEREF(corners), size, zone, tc);
    // std::cout << CVDEREF(corners) << std::endl;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_goodFeaturesToTrack(
    Mat img,
    VecPoint2f* corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    bool useHarrisDetector,
    double k,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::goodFeaturesToTrack(
        CVDEREF(img),
        CVDEREF_P(corners),
        maxCorners,
        quality,
        minDist,
        CVDEREF(mask),
        blockSize,
        useHarrisDetector,
        k
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_goodFeaturesToTrack_1(
    Mat img,
    VecPoint2f* corners,
    int maxCorners,
    double quality,
    double minDist,
    Mat mask,
    int blockSize,
    int gradientSize,
    bool useHarrisDetector,
    double k,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::goodFeaturesToTrack(
        CVDEREF(img),
        CVDEREF_P(corners),
        maxCorners,
        quality,
        minDist,
        CVDEREF(mask),
        blockSize,
        gradientSize,
        useHarrisDetector,
        k
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_grabCut(
    Mat img,
    Mat mask,
    CvRect rect,
    Mat bgdModel,
    Mat fgdModel,
    int iterCount,
    int mode,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::grabCut(
        CVDEREF(img),
        CVDEREF(mask),
        cv::Rect(rect.x, rect.y, rect.width, rect.height),
        CVDEREF(bgdModel),
        CVDEREF(fgdModel),
        iterCount,
        mode
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughCircles(
    Mat src, Mat circles, int method, double dp, double minDist, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughCircles(CVDEREF(src), CVDEREF(circles), method, dp, minDist);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughCircles_1(
    Mat src,
    Mat circles,
    int method,
    double dp,
    double minDist,
    double param1,
    double param2,
    int minRadius,
    int maxRadius,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughCircles(
        CVDEREF(src), CVDEREF(circles), method, dp, minDist, param1, param2, minRadius, maxRadius
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughLines(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double srn,
    double stn,
    double min_theta,
    double max_theta,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughLines(
        CVDEREF(src), CVDEREF(lines), rho, theta, threshold, srn, stn, min_theta, max_theta
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughLinesP(
    Mat src, Mat lines, double rho, double theta, int threshold, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughLinesP(CVDEREF(src), CVDEREF(lines), rho, theta, threshold);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughLinesP_1(
    Mat src,
    Mat lines,
    double rho,
    double theta,
    int threshold,
    double minLineLength,
    double maxLineGap,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughLinesP(CVDEREF(src), CVDEREF(lines), rho, theta, threshold, minLineLength, maxLineGap);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_HoughLinesPointSet(
    Mat points,
    Mat lines,
    int lines_max,
    int threshold,
    double min_rho,
    double max_rho,
    double rho_step,
    double min_theta,
    double max_theta,
    double theta_step,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::HoughLinesPointSet(
        CVDEREF(points),
        CVDEREF(lines),
        lines_max,
        threshold,
        min_rho,
        max_rho,
        rho_step,
        min_theta,
        max_theta,
        theta_step
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_integral(
    Mat src, Mat sum, Mat sqsum, Mat tilted, int sdepth, int sqdepth, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::integral(CVDEREF(src), CVDEREF(sum), CVDEREF(sqsum), CVDEREF(tilted), sdepth, sqdepth);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_threshold(
    Mat src, Mat dst, double thresh, double maxvalue, int typ, double* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::threshold(CVDEREF(src), CVDEREF(dst), thresh, maxvalue, typ);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_thresholdWithMask(
    Mat src,
    Mat dst,
    Mat mask,
    double thresh,
    double maxvalue,
    int typ,
    double* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::thresholdWithMask(CVDEREF(src), CVDEREF(dst), CVDEREF(mask), thresh, maxvalue, typ);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_adaptiveThreshold(
    Mat src,
    Mat dst,
    double maxValue,
    int adaptiveTyp,
    int typ,
    int blockSize,
    double c,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::adaptiveThreshold(CVDEREF(src), CVDEREF(dst), maxValue, adaptiveTyp, typ, blockSize, c);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_arrowedLine(
    Mat img,
    CvPoint pt1,
    CvPoint pt2,
    Scalar color,
    int thickness,
    int line_type,
    int shift,
    double tipLength,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::arrowedLine(
        CVDEREF(img),
        cv::Point(pt1.x, pt1.y),
        cv::Point(pt2.x, pt2.y),
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        line_type,
        shift,
        tipLength
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_circle(
    Mat img, CvPoint center, int radius, Scalar color, int thickness, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::circle(
        CVDEREF(img),
        cv::Point(center.x, center.y),
        radius,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_circle_1(
    Mat img,
    CvPoint center,
    int radius,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::circle(
        CVDEREF(img),
        cv::Point(center.x, center.y),
        radius,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        lineType,
        shift
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ellipse(
    Mat img,
    CvPoint center,
    CvPoint axes,
    double angle,
    double startAngle,
    double endAngle,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::ellipse(
        CVDEREF(img),
        cv::Point(center.x, center.y),
        cv::Size(axes.x, axes.y),
        angle,
        startAngle,
        endAngle,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_ellipse_1(
    Mat img,
    CvPoint center,
    CvPoint axes,
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
        CVDEREF(img),
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
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_line(
    Mat img,
    CvPoint pt1,
    CvPoint pt2,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::line(
        CVDEREF(img),
        cv::Point(pt1.x, pt1.y),
        cv::Point(pt2.x, pt2.y),
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        lineType,
        shift
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_rectangle(Mat img, CvRect rect, Scalar color, int thickness, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::rectangle(
        CVDEREF(img),
        cv::Rect(rect.x, rect.y, rect.width, rect.height),
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_rectangle_1(
    Mat img,
    CvRect rect,
    Scalar color,
    int thickness,
    int lineType,
    int shift,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::rectangle(
        CVDEREF(img),
        cv::Rect(rect.x, rect.y, rect.width, rect.height),
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        lineType,
        shift
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fillPoly(Mat img, VecVecPoint points, Scalar color, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::fillPoly(
        CVDEREF(img), CVDEREF(points), cv::Scalar(color.val1, color.val2, color.val3, color.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fillPoly_1(
    Mat img,
    VecVecPoint points,
    Scalar color,
    int lineType,
    int shift,
    CvPoint offset,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fillPoly(
        CVDEREF(img),
        CVDEREF(points),
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        lineType,
        shift,
        cv::Point(offset.x, offset.y)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_polylines(
    Mat img, VecVecPoint points, bool isClosed, Scalar color, int thickness, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::polylines(
        CVDEREF(img),
        CVDEREF(points),
        isClosed,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getTextSize(
    const char* text,
    int fontFace,
    double fontScale,
    int thickness,
    int* baseline,
    CvSize* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Size r = cv::getTextSize(text, fontFace, fontScale, thickness, baseline);
    *rval = {r.width, r.height};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_putText(
    Mat img,
    const char* text,
    CvPoint org,
    int fontFace,
    double fontScale,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::putText(
        CVDEREF(img),
        text,
        cv::Point(org.x, org.y),
        fontFace,
        fontScale,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_putText_1(
    Mat img,
    const char* text,
    CvPoint org,
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
        CVDEREF(img),
        text,
        cv::Point(org.x, org.y),
        fontFace,
        fontScale,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        lineType,
        bottomLeftOrigin
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_resize(
    Mat src, Mat dst, CvSize sz, double fx, double fy, int interp, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::resize(CVDEREF(src), CVDEREF(dst), cv::Size(sz.width, sz.height), fx, fy, interp);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getRectSubPix(
    Mat src, CvSize patchSize, CvPoint2f center, Mat dst, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::getRectSubPix(
        CVDEREF(src),
        cv::Size(patchSize.width, patchSize.height),
        cv::Point2f(center.x, center.y),
        CVDEREF(dst)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getRotationMatrix2D(
    CvPoint2f center, double angle, double scale, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(cv::getRotationMatrix2D(cv::Point2f(center.x, center.y), angle, scale));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_warpAffine(Mat src, Mat dst, Mat rot_mat, CvSize dsize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::warpAffine(
        CVDEREF(src), CVDEREF(dst), CVDEREF(rot_mat), cv::Size(dsize.width, dsize.height)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_warpAffine_1(
    Mat src,
    Mat dst,
    Mat rot_mat,
    CvSize dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::warpAffine(
        CVDEREF(src),
        CVDEREF(dst),
        CVDEREF(rot_mat),
        cv::Size(dsize.width, dsize.height),
        flags,
        borderMode,
        cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_warpPerspective(Mat src, Mat dst, Mat m, CvSize dsize, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::warpPerspective(
        CVDEREF(src), CVDEREF(dst), CVDEREF(m), cv::Size(dsize.width, dsize.height)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_warpPerspective_1(
    Mat src,
    Mat dst,
    Mat rot_mat,
    CvSize dsize,
    int flags,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::warpPerspective(
        CVDEREF(src),
        CVDEREF(dst),
        CVDEREF(rot_mat),
        cv::Size(dsize.width, dsize.height),
        flags,
        borderMode,
        cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_watershed(Mat image, Mat markers, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::watershed(CVDEREF(image), CVDEREF(markers));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_applyColorMap(Mat src, Mat dst, int colormap, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::applyColorMap(CVDEREF(src), CVDEREF(dst), colormap);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_applyColorMap_1(Mat src, Mat dst, Mat colormap, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::applyColorMap(CVDEREF(src), CVDEREF(dst), CVDEREF(colormap));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getPerspectiveTransform(
    VecPoint src, VecPoint dst, Mat* rval, int solveMethod, CvCallback_0 callback
) {
    BEGIN_WRAP
    std::vector<cv::Point2f> src2f(src.ptr->size());
    std::vector<cv::Point2f> dst2f(dst.ptr->size());
    for (int i = 0; i < src.ptr->size(); ++i) {
        src2f.at(i) = cv::Point2f(src.ptr->at(i));
    }
    for (int i = 0; i < dst.ptr->size(); ++i) {
        dst2f.at(i) = cv::Point2f(dst.ptr->at(i));
    }
    rval->ptr = new cv::Mat(cv::getPerspectiveTransform(src2f, dst2f, solveMethod));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getPerspectiveTransform2f(
    VecPoint2f src, VecPoint2f dst, Mat* rval, int solveMethod, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(cv::getPerspectiveTransform(CVDEREF(src), CVDEREF(dst), solveMethod));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getAffineTransform(VecPoint src, VecPoint dst, Mat* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    std::vector<cv::Point2f> src2f(src.ptr->size());
    std::vector<cv::Point2f> dst2f(dst.ptr->size());
    for (int i = 0; i < src.ptr->size(); ++i) {
        src2f.at(i) = cv::Point2f(src.ptr->at(i));
    }
    for (int i = 0; i < dst.ptr->size(); ++i) {
        dst2f.at(i) = cv::Point2f(dst.ptr->at(i));
    }
    rval->ptr = new cv::Mat(cv::getAffineTransform(src2f, dst2f));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_getAffineTransform2f(
    VecPoint2f src, VecPoint2f dst, Mat* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    rval->ptr = new cv::Mat(cv::getAffineTransform(CVDEREF(src), CVDEREF(dst)));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_drawContours(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::drawContours(
        CVDEREF(src),
        CVDEREF(contours),
        contourIdx,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_drawContours_1(
    Mat src,
    VecVecPoint contours,
    int contourIdx,
    Scalar color,
    int thickness,
    int lineType,
    VecVec4i hierarchy,
    int maxLevel,
    CvPoint offset,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::drawContours(
        CVDEREF(src),
        CVDEREF(contours),
        contourIdx,
        cv::Scalar(color.val1, color.val2, color.val3, color.val4),
        thickness,
        lineType,
        CVDEREF(hierarchy),
        maxLevel,
        cv::Point(offset.x, offset.y)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Sobel(
    Mat src,
    Mat dst,
    int ddepth,
    int dx,
    int dy,
    int ksize,
    double scale,
    double delta,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::Sobel(CVDEREF(src), CVDEREF(dst), ddepth, dx, dy, ksize, scale, delta, borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_spatialGradient(
    Mat src, Mat dx, Mat dy, int ksize, int borderType, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::spatialGradient(CVDEREF(src), CVDEREF(dx), CVDEREF(dy), ksize, borderType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_remap(
    Mat src,
    Mat dst,
    Mat map1,
    Mat map2,
    int interpolation,
    int borderMode,
    Scalar borderValue,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::remap(
        CVDEREF(src),
        CVDEREF(dst),
        CVDEREF(map1),
        CVDEREF(map2),
        interpolation,
        borderMode,
        cv::Scalar(borderValue.val1, borderValue.val2, borderValue.val3, borderValue.val4)
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_filter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernel,
    CvPoint anchor,
    double delta,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::filter2D(
        CVDEREF(src),
        CVDEREF(dst),
        ddepth,
        CVDEREF(kernel),
        cv::Point(anchor.x, anchor.y),
        delta,
        borderType
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_sepFilter2D(
    Mat src,
    Mat dst,
    int ddepth,
    Mat kernelX,
    Mat kernelY,
    CvPoint anchor,
    double delta,
    int borderType,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::sepFilter2D(
        CVDEREF(src),
        CVDEREF(dst),
        ddepth,
        CVDEREF(kernelX),
        CVDEREF(kernelY),
        cv::Point(anchor.x, anchor.y),
        delta,
        borderType
    );
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_logPolar(
    Mat src, Mat dst, CvPoint2f center, double m, int flags, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::logPolar(CVDEREF(src), CVDEREF(dst), cv::Point2f(center.x, center.y), m, flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fitLine(
    VecPoint pts,
    Mat line,
    int distType,
    double param,
    double reps,
    double aeps,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fitLine(CVDEREF(pts), CVDEREF(line), distType, param, reps, aeps);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_fitLine2f(
    VecPoint2f pts,
    Mat line,
    int distType,
    double param,
    double reps,
    double aeps,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::fitLine(CVDEREF(pts), CVDEREF(line), distType, param, reps, aeps);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus * cv_getClosestEllipsePoints(RotatedRect ellipse_params, Mat points, MatOut closest_pts){
    BEGIN_WRAP
    auto center = cv::Point2f(ellipse_params.center.x, ellipse_params.center.y);
    auto size = cv::Size2f(ellipse_params.size.width, ellipse_params.size.height);
    auto rect = cv::RotatedRect(center, size, ellipse_params.angle);
    cv::getClosestEllipsePoints(rect, CVDEREF(points), CVDEREF(closest_pts));
    END_WRAP
}

CvStatus* cv_linearPolar(
    Mat src, Mat dst, CvPoint2f center, double maxRadius, int flags, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::linearPolar(CVDEREF(src), CVDEREF(dst), cv::Point2f(center.x, center.y), maxRadius, flags);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_intersectConvexConvex(
    VecPoint p1, VecPoint p2, VecPoint* p12, bool handleNested, float* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::intersectConvexConvex(CVDEREF(p1), CVDEREF(p2), CVDEREF_P(p12), handleNested);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

bool cv_isContourConvex(VecPoint contour) {
    return cv::isContourConvex(CVDEREF(contour));
}

bool cv_isContourConvex2f(VecPoint2f contour) {
    return cv::isContourConvex(CVDEREF(contour));
}

CvStatus* cv_matchShapes(
    VecPoint contour1,
    VecPoint contour2,
    int method,
    double parameter,
    double* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = cv::matchShapes(CVDEREF(contour1), CVDEREF(contour2), method, parameter);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_clipLine(CvRect imgRect, CvPoint pt1, CvPoint pt2, bool* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    auto sz = cv::Rect(imgRect.x, imgRect.y, imgRect.width, imgRect.height);
    cv::Point p1(pt1.x, pt1.y);
    cv::Point p2(pt2.x, pt2.y);
    *rval = cv::clipLine(sz, p1, p2);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_CLAHE_create(CLAHE* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::CLAHE>(cv::createCLAHE())};
    END_WRAP
}

CvStatus* cv_CLAHE_create_1(double clipLimit, CvSize tileGridSize, CLAHE* rval) {
    BEGIN_WRAP
    *rval = {new cv::Ptr<cv::CLAHE>(
        cv::createCLAHE(clipLimit, cv::Size(tileGridSize.width, tileGridSize.height))
    )};
    END_WRAP
}

void cv_CLAHE_close(CLAHEPtr self) {
    self->ptr->reset();
    CVD_FREE(self);
}

CvStatus* cv_CLAHE_apply(CLAHE self, Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->apply(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_CLAHE_collectGarbage(CLAHE self, CvCallback_0 callback) {
    BEGIN_WRAP(CVDEREF(self))->collectGarbage();
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

double cv_CLAHE_getClipLimit(CLAHE self) {
    return (CVDEREF(self))->getClipLimit();
}

void cv_CLAHE_setClipLimit(CLAHE self, double clipLimit) {
    (CVDEREF(self))->setClipLimit(clipLimit);
}

CvSize* cv_CLAHE_getTilesGridSize(CLAHE self) {
    cv::Size sz = (CVDEREF(self))->getTilesGridSize();
    return new CvSize{sz.width, sz.height};
}

void cv_CLAHE_setTilesGridSize(CLAHE self, CvSize size) {
    (CVDEREF(self))->setTilesGridSize(cv::Size(size.width, size.height));
}

CvStatus* cv_Subdiv2D_create(Subdiv2D* rval) {
    BEGIN_WRAP
    *rval = {new cv::Subdiv2D()};
    END_WRAP
}

CvStatus* cv_Subdiv2D_create_1(CvRect rect, Subdiv2D* rval) {
    BEGIN_WRAP
    *rval = {new cv::Subdiv2D(cv::Rect(rect.x, rect.y, rect.width, rect.height))};
    END_WRAP
}

void cv_Subdiv2D_close(Subdiv2DPtr self) {
    CVD_FREE(self);
}

CvStatus* cv_Subdiv2D_edgeDst(
    Subdiv2D self, int edge, CvPoint2f* dstpt, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto p = cv::Point2f();
    *rval = self.ptr->edgeDst(edge, &p);
    *dstpt = {p.x, p.y};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_edgeOrg(
    Subdiv2D self, int edge, CvPoint2f* orgpt, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto p = cv::Point2f();
    *rval = self.ptr->edgeOrg(edge, &p);
    *orgpt = {p.x, p.y};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_findNearest(
    Subdiv2D self, CvPoint2f pt, CvPoint2f* nearestPt, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto p = cv::Point2f();
    *rval = self.ptr->findNearest(cv::Point2f(pt.x, pt.y), &p);
    *nearestPt = {p.x, p.y};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getEdge(
    Subdiv2D self, int edge, int nextEdgeType, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->getEdge(edge, nextEdgeType);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getEdgeList(
    Subdiv2D self, Vec4f** rval, size_t* size, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto v = std::vector<cv::Vec4f>();
    self.ptr->getEdgeList(v);
    *size = v.size();
    auto rv = new Vec4f[v.size()];
    for (int i = 0; i < v.size(); i++) {
        rv[i] = {v[i].val[0], v[i].val[1], v[i].val[2], v[i].val[3]};
    }
    *rval = rv;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getLeadingEdgeList(
    Subdiv2D self, VecI32* leadingEdgeList, CvCallback_0 callback
) {
    BEGIN_WRAP
    self.ptr->getLeadingEdgeList(CVDEREF_P(leadingEdgeList));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getTriangleList(
    Subdiv2D self, Vec6f** rval, size_t* size, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto v = std::vector<cv::Vec6f>();
    self.ptr->getTriangleList(v);
    *size = v.size();
    auto rv = new Vec6f[v.size()];
    for (int i = 0; i < v.size(); i++) {
        rv[i] = {v[i].val[0], v[i].val[1], v[i].val[2], v[i].val[3], v[i].val[4], v[i].val[5]};
    }
    *rval = rv;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getVertex(
    Subdiv2D self, int vertex, int* firstEdge, CvPoint2f* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto p = self.ptr->getVertex(vertex, firstEdge);
    *rval = {p.x, p.y};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_getVoronoiFacetList(
    Subdiv2D self,
    VecI32 idx,
    VecVecPoint2f* facetList,
    VecPoint2f* facetCenters,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    self.ptr->getVoronoiFacetList(CVDEREF(idx), CVDEREF_P(facetList), CVDEREF_P(facetCenters));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_initDelaunay(Subdiv2D self, CvRect rect, CvCallback_0 callback) {
    BEGIN_WRAP
    self.ptr->initDelaunay(cv::Rect(rect.x, rect.y, rect.width, rect.height));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_insert(Subdiv2D self, CvPoint2f pt, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = self.ptr->insert(cv::Point2f(pt.x, pt.y));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_insertVec(Subdiv2D self, VecPoint2f ptvec, CvCallback_0 callback) {
    BEGIN_WRAP
    self.ptr->insert(CVDEREF(ptvec));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_locate(
    Subdiv2D self, CvPoint2f pt, int* edge, int* vertex, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->locate(cv::Point2f(pt.x, pt.y), *edge, *vertex);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_nextEdge(Subdiv2D self, int edge, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = self.ptr->nextEdge(edge);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_rotateEdge(
    Subdiv2D self, int edge, int rotate, int* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    *rval = self.ptr->rotateEdge(edge, rotate);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_Subdiv2D_symEdge(Subdiv2D self, int edge, int* rval, CvCallback_0 callback) {
    BEGIN_WRAP
    *rval = self.ptr->symEdge(edge);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_invertAffineTransform(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::invertAffineTransform(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_phaseCorrelate(
    Mat src1, Mat src2, Mat window, double* response, CvPoint2f* rval, CvCallback_0 callback
) {
    BEGIN_WRAP
    auto p = cv::phaseCorrelate(CVDEREF(src1), CVDEREF(src2), CVDEREF(window), response);
    // TODO: add Point2d
    *rval = {static_cast<float>(p.x), static_cast<float>(p.y)};
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulate(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulate(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulate_1(Mat src, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulate(CVDEREF(src), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulateSquare(Mat src, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulateSquare(CVDEREF(src), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulateSquare_1(Mat src, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulateSquare(CVDEREF(src), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulateProduct(Mat src1, Mat src2, Mat dst, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulateProduct(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulateProduct_1(Mat src1, Mat src2, Mat dst, Mat mask, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulateProduct(CVDEREF(src1), CVDEREF(src2), CVDEREF(dst), CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulatedWeighted(Mat src, Mat dst, double alpha, CvCallback_0 callback) {
    BEGIN_WRAP
    cv::accumulateWeighted(CVDEREF(src), CVDEREF(dst), alpha);
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_accumulatedWeighted_1(
    Mat src, Mat dst, double alpha, Mat mask, CvCallback_0 callback
) {
    BEGIN_WRAP
    cv::accumulateWeighted(CVDEREF(src), CVDEREF(dst), alpha, CVDEREF(mask));
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_floodFill(
    Mat src,
    Mat mask,
    CvPoint seedPoint,
    Scalar newVal,
    CvRect* rect,
    Scalar loDiff,
    Scalar upDiff,
    int flags,
    int* rval,
    CvCallback_0 callback
) {
    BEGIN_WRAP
    auto _seedPoint = cv::Point(seedPoint.x, seedPoint.y);
    auto _rect = cv::Rect();
    auto _newVal = cv::Scalar(newVal.val1, newVal.val2, newVal.val3, newVal.val4);
    auto _loDiff = cv::Scalar(loDiff.val1, loDiff.val2, loDiff.val3, loDiff.val4);
    auto _upDiff = cv::Scalar(upDiff.val1, upDiff.val2, upDiff.val3, upDiff.val4);
    *rval = cv::floodFill(
        CVDEREF(src), CVDEREF(mask), _seedPoint, _newVal, &_rect, _loDiff, _upDiff, flags
    );
    rect->x = _rect.x;
    rect->y = _rect.y;
    rect->width = _rect.width;
    rect->height = _rect.height;
    if (callback != nullptr) {
        callback();
    }
    END_WRAP
}

CvStatus* cv_stackBlur(Mat src, MatOut dst, CvSize ksize, CvCallback_0 callback) {
  BEGIN_WRAP
  cv::stackBlur(CVDEREF(src), CVDEREF(dst), cv::Size(ksize.width, ksize.height));
  if (callback != nullptr) {
    callback();
  }
  END_WRAP
}
