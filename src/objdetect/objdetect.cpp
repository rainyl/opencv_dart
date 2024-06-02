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
CvStatus CascadeClassifier_NewFromFile(char *filename, CascadeClassifier *rval)
{
  BEGIN_WRAP
  *rval = {new cv::CascadeClassifier(filename)};
  END_WRAP
}
void CascadeClassifier_Close(CascadeClassifier *self){CVD_FREE(self)}

CvStatus CascadeClassifier_Load(CascadeClassifier self, const char *name, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->load(name);
  END_WRAP
}
CvStatus CascadeClassifier_DetectMultiScale(CascadeClassifier self, Mat img, VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  self.ptr->detectMultiScale(*img.ptr, rects);
  *rval = {new std::vector<cv::Rect>(rects)};
  END_WRAP
}
CvStatus CascadeClassifier_DetectMultiScaleWithParams(CascadeClassifier self, Mat img, VecRect *objects,
                                                      double scale, int minNeighbors, int flags, Size minSize,
                                                      Size maxSize)
{
  BEGIN_WRAP
  std::vector<cv::Rect> *rects = new std::vector<cv::Rect>();
  auto                   minsize = cv::Size(minSize.width, minSize.height);
  auto                   maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(*img.ptr, *rects, scale, minNeighbors, flags, minsize, maxsize);
  *objects = {rects};
  END_WRAP
}

CvStatus CascadeClassifier_DetectMultiScale2(CascadeClassifier self, Mat img, VecRect *objects,
                                             VecInt *numDetections, double scaleFactor, int minNeighbors,
                                             int flags, Size minSize, Size maxSize)
{
  BEGIN_WRAP
  std::vector<cv::Rect> *rects = new std::vector<cv::Rect>();
  std::vector<int>      *nums = new std::vector<int>();
  auto                   minsize = cv::Size(minSize.width, minSize.height);
  auto                   maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(*img.ptr, *rects, *nums, scaleFactor, minNeighbors, flags, minsize, maxsize);
  *objects = {rects};
  *numDetections = {nums};
  END_WRAP
}

CvStatus CascadeClassifier_DetectMultiScale3(CascadeClassifier self, Mat img, VecRect *objects,
                                             VecInt *rejectLevels, VecDouble *levelWeights,
                                             double scaleFactor, int minNeighbors, int flags, Size minSize,
                                             Size maxSize, bool outputRejectLevels)
{
  BEGIN_WRAP
  std::vector<cv::Rect> *rects = new std::vector<cv::Rect>();
  std::vector<int>      *rejects = new std::vector<int>();
  std::vector<double>   *weights = new std::vector<double>();
  auto                   minsize = cv::Size(minSize.width, minSize.height);
  auto                   maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(*img.ptr, *rects, *rejects, *weights, scaleFactor, minNeighbors, flags, minsize,
                             maxsize, outputRejectLevels);
  *objects = {rects};
  *rejectLevels = {rejects};
  *levelWeights = {weights};
  END_WRAP
}
CvStatus CascadeClassifier_Empty(CascadeClassifier self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->empty();
  END_WRAP
}
CvStatus CascadeClassifier_getFeatureType(CascadeClassifier self, int *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getFeatureType();
  END_WRAP
}
CvStatus CascadeClassifier_getOriginalWindowSize(CascadeClassifier self, Size *rval)
{
  BEGIN_WRAP
  auto sz = self.ptr->getOriginalWindowSize();
  *rval = {sz.width, sz.height};
  END_WRAP
}
CvStatus CascadeClassifier_isOldFormatCascade(CascadeClassifier self, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->isOldFormatCascade();
  END_WRAP
}

CvStatus HOGDescriptor_New(HOGDescriptor *rval)
{
  BEGIN_WRAP
  *rval = {new cv::HOGDescriptor()};
  END_WRAP
}
CvStatus HOGDescriptor_NewFromFile(char *filename, HOGDescriptor *rval)
{
  BEGIN_WRAP
  *rval = {new cv::HOGDescriptor(filename)};
  END_WRAP
}
void HOGDescriptor_Close(HOGDescriptor *self){CVD_FREE(self)}

CvStatus HOGDescriptor_Load(HOGDescriptor self, char *name, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->load(name);
  END_WRAP
}
CvStatus HOGDescriptor_Detect(HOGDescriptor self, Mat img, VecPoint *foundLocations, VecDouble *weights,
                              double hitThresh, Size winStride, Size padding, VecPoint *searchLocations)
{
  BEGIN_WRAP
  std::vector<cv::Point> *_foundLocations = new std::vector<cv::Point>();
  std::vector<cv::Point> *_searchLocations = new std::vector<cv::Point>();
  std::vector<double>    *_weights = new std::vector<double>();
  self.ptr->detect(*img.ptr, *_foundLocations, *_weights, hitThresh,
                   cv::Point(winStride.width, winStride.height), cv::Point(padding.width, padding.height),
                   *_searchLocations);
  *foundLocations = {_foundLocations};
  *weights = {_weights};
  *searchLocations = {_searchLocations};
  END_WRAP
}
CvStatus HOGDescriptor_Detect2(HOGDescriptor self, Mat img, VecPoint *foundLocations, double hitThresh,
                               Size winStride, Size padding, VecPoint *searchLocations)
{
  BEGIN_WRAP
  std::vector<cv::Point> *_foundLocations = new std::vector<cv::Point>();
  std::vector<cv::Point> *_searchLocations = new std::vector<cv::Point>();
  self.ptr->detect(*img.ptr, *_foundLocations, hitThresh, cv::Point(winStride.width, winStride.height),
                   cv::Point(padding.width, padding.height), *_searchLocations);
  *foundLocations = {_foundLocations};
  *searchLocations = {_searchLocations};
  END_WRAP
}
CvStatus HOGDescriptor_DetectMultiScale(HOGDescriptor self, Mat img, VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  self.ptr->detectMultiScale(*img.ptr, rects);
  *rval = {new std::vector<cv::Rect>(rects)};
  END_WRAP
}
CvStatus HOGDescriptor_DetectMultiScaleWithParams(HOGDescriptor self, Mat img, double hitThresh,
                                                  Size winStride, Size padding, double scale,
                                                  double finalThreshold, bool useMeanshiftGrouping,
                                                  VecRect *rval)
{
  BEGIN_WRAP
  std::vector<cv::Rect> *rects = new std::vector<cv::Rect>();
  auto                   winstride = cv::Size(winStride.width, winStride.height);
  auto                   pad = cv::Size(padding.width, padding.height);
  self.ptr->detectMultiScale(*img.ptr, *rects, hitThresh, winstride, pad, scale, finalThreshold,
                             useMeanshiftGrouping);
  *rval = {rects};
  END_WRAP
}
CvStatus HOG_GetDefaultPeopleDetector(VecFloat *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<float>(cv::HOGDescriptor::getDefaultPeopleDetector())};
  END_WRAP
}
CvStatus HOGDescriptor_SetSVMDetector(HOGDescriptor self, VecFloat det)
{
  BEGIN_WRAP
  self.ptr->setSVMDetector(*det.ptr);
  END_WRAP
}
CvStatus HOGDescriptor_Compute(HOGDescriptor self, Mat img, VecFloat *descriptors, Size winStride,
                               Size padding, VecPoint *locations)
{
  BEGIN_WRAP
  std::vector<float>     *_descriptors = new std::vector<float>();
  std::vector<cv::Point> *_locations = new std::vector<cv::Point>();
  self.ptr->compute(*img.ptr, *_descriptors, cv::Size(winStride.width, winStride.height),
                    cv::Size(padding.width, padding.height), *_locations);
  *descriptors = {_descriptors};
  *locations = {_locations};
  END_WRAP
}
CvStatus HOGDescriptor_computeGradient(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL,
                                       Size paddingBR)
{
  BEGIN_WRAP
  self.ptr->computeGradient(*img.ptr, *grad.ptr, *angleOfs.ptr, cv::Size(paddingTL.width, paddingTL.height),
                            cv::Size(paddingBR.width, paddingBR.height));
  END_WRAP
}
// CvStatus HOGDescriptor_detectMultiScaleROI(HOGDescriptor self, Mat img, VecRect *foundLocations,
//                                            DetectionROI *locations, int *lenLocations, double hitThreshold,
//                                            int groupThreshold)
// {
//   BEGIN_WRAP
//   auto _foundLocations = new std::vector<cv::Rect>();
//   auto _locations = new std::vector<cv::DetectionROI>();
//   self.ptr->detectMultiScaleROI(*img.ptr, *_foundLocations, *_locations, hitThreshold, groupThreshold);
//   *foundLocations = {_foundLocations};
//   locations = _locations->data();
//   END_WRAP
// }
// CvStatus HOGDescriptor_detectROI(HOGDescriptor self, Mat img, VecPoint *locations, VecPoint
// *foundLocations,
//                                  VecDouble *confidences, double hitThreshold, Size winStride, Size padding)
// {
//   BEGIN_WRAP
//   auto _locations = new std::vector<cv::Point>();
//   auto _foundLocations = new std::vector<cv::Point>();
//   auto _confidences = new std::vector<double>();
//   self.ptr->detectROI(*img.ptr, *_locations, *_foundLocations, *_confidences, hitThreshold,
//                       cv::Size(winStride.width, winStride.height), cv::Size(padding.width,
//                       padding.height));
//   *locations = {_locations};
//   *foundLocations = {_foundLocations};
//   *confidences = {_confidences};
//   END_WRAP
// }
CvStatus HOGDescriptor_getDaimlerPeopleDetector(VecFloat *rval)
{
  BEGIN_WRAP
  *rval = {new std::vector<float>(cv::HOGDescriptor::getDaimlerPeopleDetector())};
  END_WRAP
}
CvStatus HOGDescriptor_getDescriptorSize(HOGDescriptor self, size_t *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getDescriptorSize();
  END_WRAP
}
CvStatus HOGDescriptor_getWinSigma(HOGDescriptor self, double *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->getWinSigma();
  END_WRAP
}
CvStatus HOGDescriptor_groupRectangles(HOGDescriptor self, VecRect rectList, VecDouble weights,
                                       int groupThreshold, double eps)
{
  BEGIN_WRAP
  self.ptr->groupRectangles(*rectList.ptr, *weights.ptr, groupThreshold, eps);
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
CvStatus QRCodeDetector_DetectAndDecode(QRCodeDetector self, Mat input, VecPoint *points,
                                        Mat *straight_qrcode, VecChar *rval)
{
  BEGIN_WRAP
  auto points_ = new std::vector<cv::Point>();
  auto mat = new cv::Mat();
  auto info = self.ptr->detectAndDecode(*input.ptr, *points_, *mat);
  *rval = {new std::vector<char>(info.begin(), info.end())};
  *points = {points_};
  *straight_qrcode = {mat};
  END_WRAP
}
CvStatus QRCodeDetector_Detect(QRCodeDetector self, Mat input, VecPoint *points, bool *rval)
{
  BEGIN_WRAP
  auto _points = new std::vector<cv::Point>();
  *rval = self.ptr->detect(*input.ptr, *_points);
  *points = {_points};
  END_WRAP
}
CvStatus QRCodeDetector_Decode(QRCodeDetector self, Mat input, VecPoint inputPoints, Mat straight_qrcode,
                               VecChar *rval)
{
  BEGIN_WRAP
  auto info = self.ptr->detectAndDecode(*input.ptr, *inputPoints.ptr, *straight_qrcode.ptr);
  *rval = {new std::vector<char>(info.begin(), info.end())};
  END_WRAP
}
CvStatus QRCodeDetector_decodeCurved(QRCodeDetector self, Mat img, VecPoint points,
                                     CVD_OUT Mat *straight_qrcode, char **rval)
{
  BEGIN_WRAP
  auto _straight_qrcode = new cv::Mat();
  auto ret = self.ptr->decodeCurved(*img.ptr, *points.ptr, *_straight_qrcode);
  *rval = strdup(ret.c_str());
  *straight_qrcode = {_straight_qrcode};
  END_WRAP
}
CvStatus QRCodeDetector_detectAndDecodeCurved(QRCodeDetector self, Mat img, VecPoint *points,
                                              CVD_OUT Mat *straight_qrcode, char **rval)
{
  BEGIN_WRAP
  auto _straight_qrcode = new cv::Mat();
  auto _points = new std::vector<cv::Point>();
  auto ret = self.ptr->detectAndDecodeCurved(*img.ptr, *_points, *_straight_qrcode);
  *rval = strdup(ret.c_str());
  *points = {_points};
  *straight_qrcode = {_straight_qrcode};
  END_WRAP
}
void QRCodeDetector_Close(QRCodeDetector *self){CVD_FREE(self)}

CvStatus QRCodeDetector_DetectMulti(QRCodeDetector self, Mat input, VecPoint points, bool *rval)
{
  BEGIN_WRAP
  *rval = self.ptr->detectMulti(*input.ptr, *points.ptr);
  END_WRAP
}
CvStatus QRCodeDetector_DetectAndDecodeMulti(QRCodeDetector self, Mat input, VecVecChar *decoded,
                                             VecPoint *points, VecMat *straight_code, bool *rval)
{
  BEGIN_WRAP
  std::vector<cv::String> decodedCodes;
  std::vector<cv::Mat>    straightQrCodes;
  std::vector<cv::Point>  points_;

  *rval = self.ptr->detectAndDecodeMulti(*input.ptr, decodedCodes, points_, straightQrCodes);
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

CvStatus QRCodeDetector_setEpsX(QRCodeDetector self, double epsX)
{
  BEGIN_WRAP
  self.ptr->setEpsX(epsX);
  END_WRAP
}
CvStatus QRCodeDetector_setEpsY(QRCodeDetector self, double epsY)
{
  BEGIN_WRAP
  self.ptr->setEpsY(epsY);
  END_WRAP
}
CvStatus QRCodeDetector_setUseAlignmentMarkers(QRCodeDetector self, bool useAlignmentMarkers)
{
  BEGIN_WRAP
  self.ptr->setUseAlignmentMarkers(useAlignmentMarkers);
  END_WRAP
}
