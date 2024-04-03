/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "objdetect.h"
#include <vector>

// CascadeClassifier
CvStatus CascadeClassifier_New(CascadeClassifier *rval)
{
  BEGIN_WRAP
  *rval = {new cv::CascadeClassifier()};
  END_WRAP
}
void CascadeClassifier_Close(CascadeClassifier *cs)
{
  delete cs->ptr;
  cs->ptr = nullptr;
}
CvStatus CascadeClassifier_Load(CascadeClassifier cs, const char *name, int *rval)
{
  BEGIN_WRAP
  *rval = cs.ptr->load(name);
  END_WRAP
}
CvStatus CascadeClassifier_DetectMultiScale(CascadeClassifier cs, Mat img, VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  cs.ptr->detectMultiScale(*img.ptr, rects);
  *rval = {new std::vector<cv::Rect>(rects)};
  END_WRAP
}
CvStatus CascadeClassifier_DetectMultiScaleWithParams(CascadeClassifier cs, Mat img, double scale,
                                                      int minNeighbors, int flags, Size minSize, Size maxSize,
                                                      VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  auto                  minsize = cv::Size(minSize.width, minSize.height);
  auto                  maxsize = cv::Size(maxSize.width, maxSize.height);
  cs.ptr->detectMultiScale(*img.ptr, rects, scale, minNeighbors, flags, minsize, maxsize);
  *rval = {new std::vector<cv::Rect>(rects)};
  END_WRAP
}

CvStatus HOGDescriptor_New(HOGDescriptor *rval)
{
  BEGIN_WRAP
  *rval = {new cv::HOGDescriptor()};
  END_WRAP
}
void HOGDescriptor_Close(HOGDescriptor *hog)
{
  delete hog->ptr;
  hog->ptr = nullptr;
}
CvStatus HOGDescriptor_Load(HOGDescriptor hog, const char *name, int *rval)
{
  BEGIN_WRAP
  *rval = hog.ptr->load(name);
  END_WRAP
}
CvStatus HOGDescriptor_DetectMultiScale(HOGDescriptor hog, Mat img, VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  hog.ptr->detectMultiScale(*img.ptr, rects);
  *rval = {new std::vector<cv::Rect>(rects)};
  END_WRAP
}
CvStatus HOGDescriptor_DetectMultiScaleWithParams(HOGDescriptor hog, Mat img, double hitThresh,
                                                  Size winStride, Size padding, double scale,
                                                  double finalThreshold, bool useMeanshiftGrouping,
                                                  VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  auto                  winstride = cv::Size(winStride.width, winStride.height);
  auto                  pad = cv::Size(padding.width, padding.height);
  hog.ptr->detectMultiScale(*img.ptr, rects, hitThresh, winstride, pad, scale, finalThreshold,
                            useMeanshiftGrouping);
  END_WRAP
}
CvStatus HOG_GetDefaultPeopleDetector(VecFloat *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<float>(cv::HOGDescriptor::getDefaultPeopleDetector())};
  END_WRAP
}
CvStatus HOGDescriptor_SetSVMDetector(HOGDescriptor hog, VecFloat det)
{
  BEGIN_WRAP
  hog.ptr->setSVMDetector(*det.ptr);
  END_WRAP
}

CvStatus GroupRectangles(VecRect rects, int groupThreshold, double eps)
{
  BEGIN_WRAP
  cv::groupRectangles(*rects.ptr, groupThreshold, eps);
  END_WRAP
}

CvStatus QRCodeDetector_New(QRCodeDetector *rval)
{
  BEGIN_WRAP
  *rval = {new cv::QRCodeDetector()};
  END_WRAP
}
CvStatus QRCodeDetector_DetectAndDecode(QRCodeDetector qr, Mat input, VecPoint *points, Mat *straight_qrcode,
                                        VecChar *rval)
{
  BEGIN_WRAP
  auto points_ = std::vector<cv::Point>();
  auto mat = cv::Mat();
  auto info = qr.ptr->detectAndDecode(*input.ptr, points_, mat);
  *rval = {new std::vector<char>(info.begin(), info.end())};
  *points = {new std::vector<cv::Point>(points_)};
  *straight_qrcode = {new cv::Mat(mat)};
  END_WRAP
}
CvStatus QRCodeDetector_Detect(QRCodeDetector qr, Mat input, VecPoint points, bool *rval)
{
  BEGIN_WRAP
  *rval = qr.ptr->detect(*input.ptr, *points.ptr);
  END_WRAP
}
CvStatus QRCodeDetector_Decode(QRCodeDetector qr, Mat input, VecPoint inputPoints, Mat straight_qrcode,
                               VecChar *rval)
{
  BEGIN_WRAP
  auto info = qr.ptr->detectAndDecode(*input.ptr, *inputPoints.ptr, *straight_qrcode.ptr);
  *rval = {new std::vector<char>(info.begin(), info.end())};
  END_WRAP
}
void QRCodeDetector_Close(QRCodeDetector *qr)
{
  delete CVD_TYPECAST_CPP(QRCodeDetector, qr);
  qr->ptr = nullptr;
}
CvStatus QRCodeDetector_DetectMulti(QRCodeDetector qr, Mat input, VecPoint points, bool *rval)
{
  BEGIN_WRAP
  *rval = qr.ptr->detectMulti(*input.ptr, *points.ptr);
  END_WRAP
}
CvStatus QRCodeDetector_DetectAndDecodeMulti(QRCodeDetector qr, Mat input, VecVecChar *decoded,
                                             VecPoint *points, VecMat *straight_code, bool *rval)
{
  BEGIN_WRAP
  std::vector<cv::String> decodedCodes;
  std::vector<cv::Mat>    straightQrCodes;
  std::vector<cv::Point>  points_;

  *rval = qr.ptr->detectAndDecodeMulti(*input.ptr, decodedCodes, points_, straightQrCodes);
  if (!*rval) {
    *decoded = {new std::vector<std::vector<char>>()};
    *straight_code = {new std::vector<cv::Mat>()};
    *points = {new std::vector<cv::Point>()};
  } else {
    auto vecvec = new std::vector<std::vector<char>>();
    for (int i = 0; i < decodedCodes.size(); i++) {
      vecvec->push_back(std::vector<char>(decodedCodes[i].begin(), decodedCodes[i].end()));
    }
    *decoded = {vecvec};
    *straight_code = {new std::vector<cv::Mat>(straightQrCodes)};
    *points = {new std::vector<cv::Point>(points_)};
  }
  END_WRAP
}
