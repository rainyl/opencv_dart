/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "objdetect.h"
#include "core/vec.hpp"
#include <vector>

// CascadeClassifier
CvStatus *CascadeClassifier_New(CascadeClassifier *rval) {
  BEGIN_WRAP
  *rval = {new cv::CascadeClassifier()};
  END_WRAP
}
CvStatus *CascadeClassifier_NewFromFile(char *filename, CascadeClassifier *rval) {
  BEGIN_WRAP
  *rval = {new cv::CascadeClassifier(filename)};
  END_WRAP
}
void CascadeClassifier_Close(CascadeClassifierPtr self) { CVD_FREE(self); }

CvStatus *CascadeClassifier_Load(CascadeClassifier self, const char *name, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->load(name);
  END_WRAP
}
CvStatus *CascadeClassifier_DetectMultiScale(CascadeClassifier self, Mat img, VecRect *rval) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  self.ptr->detectMultiScale(*img.ptr, rects);
  *rval = vecrect_cpp2c(rects);
  END_WRAP
}
CvStatus *CascadeClassifier_DetectMultiScaleWithParams(
    CascadeClassifier self,
    Mat img,
    VecRect *objects,
    double scale,
    int minNeighbors,
    int flags,
    Size minSize,
    Size maxSize
) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects;
  auto minsize = cv::Size(minSize.width, minSize.height);
  auto maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(*img.ptr, rects, scale, minNeighbors, flags, minsize, maxsize);
  *objects = vecrect_cpp2c(rects);
  END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScale2(
    CascadeClassifier self,
    Mat img,
    VecRect *objects,
    VecI32 *numDetections,
    double scaleFactor,
    int minNeighbors,
    int flags,
    Size minSize,
    Size maxSize
) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects;
  std::vector<int> nums;
  auto minsize = cv::Size(minSize.width, minSize.height);
  auto maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(
      *img.ptr, rects, nums, scaleFactor, minNeighbors, flags, minsize, maxsize
  );
  *objects = vecrect_cpp2c(rects);
  *numDetections = vecint_cpp2c(nums);
  END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScale3(
    CascadeClassifier self,
    Mat img,
    VecRect *objects,
    VecI32 *rejectLevels,
    VecF64 *levelWeights,
    double scaleFactor,
    int minNeighbors,
    int flags,
    Size minSize,
    Size maxSize,
    bool outputRejectLevels
) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects;
  std::vector<int> rejects;
  std::vector<double> weights;
  auto minsize = cv::Size(minSize.width, minSize.height);
  auto maxsize = cv::Size(maxSize.width, maxSize.height);
  self.ptr->detectMultiScale(
      *img.ptr,
      rects,
      rejects,
      weights,
      scaleFactor,
      minNeighbors,
      flags,
      minsize,
      maxsize,
      outputRejectLevels
  );
  *objects = vecrect_cpp2c(rects);
  *rejectLevels = vecint_cpp2c(rejects);
  *levelWeights = vecdouble_cpp2c(weights);
  END_WRAP
}
CvStatus *CascadeClassifier_Empty(CascadeClassifier self, bool *rval) {
  BEGIN_WRAP
  *rval = self.ptr->empty();
  END_WRAP
}
CvStatus *CascadeClassifier_getFeatureType(CascadeClassifier self, int *rval) {
  BEGIN_WRAP
  *rval = self.ptr->getFeatureType();
  END_WRAP
}
CvStatus *CascadeClassifier_getOriginalWindowSize(CascadeClassifier self, Size *rval) {
  BEGIN_WRAP
  auto sz = self.ptr->getOriginalWindowSize();
  *rval = {sz.width, sz.height};
  END_WRAP
}
CvStatus *CascadeClassifier_isOldFormatCascade(CascadeClassifier self, bool *rval) {
  BEGIN_WRAP
  *rval = self.ptr->isOldFormatCascade();
  END_WRAP
}

CvStatus *HOGDescriptor_New(HOGDescriptor *rval) {
  BEGIN_WRAP
  *rval = {new cv::HOGDescriptor()};
  END_WRAP
}
CvStatus *HOGDescriptor_NewFromFile(char *filename, HOGDescriptor *rval) {
  BEGIN_WRAP
  *rval = {new cv::HOGDescriptor(filename)};
  END_WRAP
}
void HOGDescriptor_Close(HOGDescriptorPtr self) { CVD_FREE(self); }

CvStatus *HOGDescriptor_Load(HOGDescriptor self, char *name, bool *rval) {
  BEGIN_WRAP
  *rval = self.ptr->load(name);
  END_WRAP
}
CvStatus *HOGDescriptor_Detect(
    HOGDescriptor self,
    Mat img,
    VecPoint *foundLocations,
    VecF64 *weights,
    double hitThresh,
    Size winStride,
    Size padding,
    VecPoint *searchLocations
) {
  BEGIN_WRAP
  std::vector<cv::Point> _foundLocations;
  std::vector<cv::Point> _searchLocations;
  std::vector<double> _weights;
  self.ptr->detect(
      *img.ptr,
      _foundLocations,
      _weights,
      hitThresh,
      cv::Point(winStride.width, winStride.height),
      cv::Point(padding.width, padding.height),
      _searchLocations
  );
  *foundLocations = vecpoint_cpp2c(_foundLocations);
  *weights = vecdouble_cpp2c(_weights);
  *searchLocations = vecpoint_cpp2c(_searchLocations);
  END_WRAP
}
CvStatus *HOGDescriptor_Detect2(
    HOGDescriptor self,
    Mat img,
    VecPoint *foundLocations,
    double hitThresh,
    Size winStride,
    Size padding,
    VecPoint *searchLocations
) {
  BEGIN_WRAP
  std::vector<cv::Point> _foundLocations;
  std::vector<cv::Point> _searchLocations;
  self.ptr->detect(
      *img.ptr,
      _foundLocations,
      hitThresh,
      cv::Point(winStride.width, winStride.height),
      cv::Point(padding.width, padding.height),
      _searchLocations
  );
  *foundLocations = vecpoint_cpp2c(_foundLocations);
  *searchLocations = vecpoint_cpp2c(_searchLocations);
  END_WRAP
}
CvStatus *HOGDescriptor_DetectMultiScale(HOGDescriptor self, Mat img, VecRect *rval) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects = std::vector<cv::Rect>();
  self.ptr->detectMultiScale(*img.ptr, rects);
  *rval = vecrect_cpp2c(rects);
  END_WRAP
}
CvStatus *HOGDescriptor_DetectMultiScaleWithParams(
    HOGDescriptor self,
    Mat img,
    double hitThresh,
    Size winStride,
    Size padding,
    double scale,
    double finalThreshold,
    bool useMeanshiftGrouping,
    VecRect *rval
) {
  BEGIN_WRAP
  std::vector<cv::Rect> rects;
  auto winstride = cv::Size(winStride.width, winStride.height);
  auto pad = cv::Size(padding.width, padding.height);
  self.ptr->detectMultiScale(
      *img.ptr, rects, hitThresh, winstride, pad, scale, finalThreshold, useMeanshiftGrouping
  );
  *rval = vecrect_cpp2c(rects);
  END_WRAP
}
CvStatus *HOG_GetDefaultPeopleDetector(VecF32 *rval) {
  BEGIN_WRAP
  *rval = vecfloat_cpp2c(cv::HOGDescriptor::getDefaultPeopleDetector());
  END_WRAP
}
CvStatus *HOGDescriptor_SetSVMDetector(HOGDescriptor self, VecF32 det) {
  BEGIN_WRAP
  self.ptr->setSVMDetector(vecfloat_c2cpp(det));
  END_WRAP
}
CvStatus *HOGDescriptor_Compute(
    HOGDescriptor self,
    Mat img,
    VecF32 *descriptors,
    Size winStride,
    Size padding,
    VecPoint *locations
) {
  BEGIN_WRAP
  std::vector<float> _descriptors;
  std::vector<cv::Point> _locations;
  self.ptr->compute(
      *img.ptr,
      _descriptors,
      cv::Size(winStride.width, winStride.height),
      cv::Size(padding.width, padding.height),
      _locations
  );
  *descriptors = vecfloat_cpp2c(_descriptors);
  *locations = vecpoint_cpp2c(_locations);
  END_WRAP
}
CvStatus *HOGDescriptor_computeGradient(
    HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL, Size paddingBR
) {
  BEGIN_WRAP
  self.ptr->computeGradient(
      *img.ptr,
      *grad.ptr,
      *angleOfs.ptr,
      cv::Size(paddingTL.width, paddingTL.height),
      cv::Size(paddingBR.width, paddingBR.height)
  );
  END_WRAP
}
// CvStatus *HOGDescriptor_detectMultiScaleROI(HOGDescriptor self, Mat img, VecRect *foundLocations,
//                                            DetectionROI *locations, int *lenLocations, double
//                                            hitThreshold, int groupThreshold)
// {
//   BEGIN_WRAP
//   auto _foundLocations = vecrect_cpp2c();
//   auto _locations = new std::vector<cv::DetectionROI>();
//   self.ptr->detectMultiScaleROI(*img.ptr, *_foundLocations, *_locations, hitThreshold,
//   groupThreshold); *foundLocations = {_foundLocations}; locations = _locations->data(); END_WRAP
// }
// CvStatus *HOGDescriptor_detectROI(HOGDescriptor self, Mat img, VecPoint *locations, VecPoint
// *foundLocations,
//                                  VecF64 *confidences, double hitThreshold, Size winStride,
//                                  Size padding)
// {
//   BEGIN_WRAP
//   auto _locations = vecpoint_cpp2c();
//   auto _foundLocations = vecpoint_cpp2c();
//   auto _confidences = vecdouble_cpp2c();
//   self.ptr->detectROI(*img.ptr, *_locations, *_foundLocations, *_confidences, hitThreshold,
//                       cv::Size(winStride.width, winStride.height), cv::Size(padding.width,
//                       padding.height));
//   *locations = {_locations};
//   *foundLocations = {_foundLocations};
//   *confidences = {_confidences};
//   END_WRAP
// }
CvStatus *HOGDescriptor_getDaimlerPeopleDetector(VecF32 *rval) {
  BEGIN_WRAP
  *rval = vecfloat_cpp2c(cv::HOGDescriptor::getDaimlerPeopleDetector());
  END_WRAP
}
CvStatus *HOGDescriptor_getDescriptorSize(HOGDescriptor self, size_t *rval) {
  BEGIN_WRAP
  *rval = self.ptr->getDescriptorSize();
  END_WRAP
}
CvStatus *HOGDescriptor_getWinSigma(HOGDescriptor self, double *rval) {
  BEGIN_WRAP
  *rval = self.ptr->getWinSigma();
  END_WRAP
}
CvStatus *HOGDescriptor_groupRectangles(
    HOGDescriptor self, VecRect *rectList, VecF64 *weights, int groupThreshold, double eps
) {
  BEGIN_WRAP
  auto _rectList = vecrect_c2cpp(*rectList);
  auto _weights = vecdouble_c2cpp(*weights);
  self.ptr->groupRectangles(_rectList, _weights, groupThreshold, eps);
  vecrect_cpp2c(_rectList, rectList);
  vecdouble_cpp2c(_weights, weights);
  END_WRAP
}

CvStatus *GroupRectangles(VecRect *rects, int groupThreshold, double eps) {
  BEGIN_WRAP
  auto _rects = vecrect_c2cpp(*rects);
  cv::groupRectangles(_rects, groupThreshold, eps);
  vecrect_cpp2c(_rects, rects);
  END_WRAP
}

CvStatus *QRCodeDetector_New(QRCodeDetector *rval) {
  BEGIN_WRAP
  *rval = {new cv::QRCodeDetector()};
  END_WRAP
}
CvStatus *QRCodeDetector_DetectAndDecode(
    QRCodeDetector self, Mat input, VecPoint *points, Mat *straight_qrcode, char **rval
) {
  BEGIN_WRAP
  std::vector<cv::Point> points_;
  cv::Mat mat;
  auto info = self.ptr->detectAndDecode(*input.ptr, points_, mat);
  *rval = strdup(info.c_str());
  *points = vecpoint_cpp2c(points_);
  *straight_qrcode = {new cv::Mat(mat)};
  END_WRAP
}
CvStatus *QRCodeDetector_Detect(QRCodeDetector self, Mat input, VecPoint *points, bool *rval) {
  BEGIN_WRAP
  std::vector<cv::Point> _points;
  *rval = self.ptr->detect(*input.ptr, _points);
  *points = vecpoint_cpp2c(_points);
  END_WRAP
}
CvStatus *QRCodeDetector_Decode(
    QRCodeDetector self, Mat input, VecPoint *points, Mat straight_qrcode, char **rval
) {
  BEGIN_WRAP
  std::vector<cv::Point> _points;
  auto info = self.ptr->detectAndDecode(*input.ptr, _points, *straight_qrcode.ptr);
  *rval = strdup(info.c_str());
  *points = vecpoint_cpp2c(_points);
  END_WRAP
}
CvStatus *QRCodeDetector_decodeCurved(
    QRCodeDetector self, Mat img, VecPoint points, CVD_OUT Mat *straight_qrcode, char **rval
) {
  BEGIN_WRAP
  cv::Mat _straight_qrcode;
  auto _points = vecpoint_c2cpp(points);
  auto ret = self.ptr->decodeCurved(*img.ptr, _points, _straight_qrcode);
  *rval = strdup(ret.c_str());
  *straight_qrcode = {new cv::Mat(_straight_qrcode)};
  END_WRAP
}
CvStatus *QRCodeDetector_detectAndDecodeCurved(
    QRCodeDetector self, Mat img, VecPoint *points, CVD_OUT Mat *straight_qrcode, char **rval
) {
  BEGIN_WRAP
  cv::Mat _straight_qrcode;
  std::vector<cv::Point> _points;
  auto ret = self.ptr->detectAndDecodeCurved(*img.ptr, _points, _straight_qrcode);
  *rval = strdup(ret.c_str());
  *points = vecpoint_cpp2c(_points);
  *straight_qrcode = {new cv::Mat(_straight_qrcode)};
  END_WRAP
}
void QRCodeDetector_Close(QRCodeDetectorPtr self) { CVD_FREE(self); }

CvStatus *QRCodeDetector_DetectMulti(QRCodeDetector self, Mat input, VecPoint *points, bool *rval) {
  BEGIN_WRAP
  std::vector<cv::Point> _points;
  *rval = self.ptr->detectMulti(*input.ptr, _points);
  *points = vecpoint_cpp2c(_points);
  END_WRAP
}
CvStatus *QRCodeDetector_DetectAndDecodeMulti(
    QRCodeDetector self,
    Mat input,
    VecVecChar *decoded,
    VecPoint *points,
    VecMat *straight_code,
    bool *rval
) {
  BEGIN_WRAP
  std::vector<cv::String> decodedCodes;
  std::vector<cv::Mat> straightQrCodes;
  std::vector<cv::Point> points_;

  *rval = self.ptr->detectAndDecodeMulti(*input.ptr, decodedCodes, points_, straightQrCodes);
  if (!*rval) {
    *decoded = {NULL, 0};
    *straight_code = {NULL, 0};
    *points = {NULL, 0};
  } else {
    std::vector<std::vector<char>> vecvec;
    for (int i = 0; i < decodedCodes.size(); i++) {
      vecvec.push_back(std::vector<char>(decodedCodes[i].begin(), decodedCodes[i].end()));
    }
    *decoded = vecvecchar_cpp2c(vecvec);
    *straight_code = vecmat_cpp2c(straightQrCodes);
    *points = vecpoint_cpp2c(points_);
  }
  END_WRAP
}

CvStatus *QRCodeDetector_setEpsX(QRCodeDetector self, double epsX) {
  BEGIN_WRAP
  self.ptr->setEpsX(epsX);
  END_WRAP
}
CvStatus *QRCodeDetector_setEpsY(QRCodeDetector self, double epsY) {
  BEGIN_WRAP
  self.ptr->setEpsY(epsY);
  END_WRAP
}
CvStatus *QRCodeDetector_setUseAlignmentMarkers(QRCodeDetector self, bool useAlignmentMarkers) {
  BEGIN_WRAP
  self.ptr->setUseAlignmentMarkers(useAlignmentMarkers);
  END_WRAP
}
// FaceDetectorYN
CvStatus *FaceDetectorYN_New(
    const char *model,
    const char *config,
    Size input_size,
    float score_threshold,
    float nms_threshold,
    int top_k,
    int backend_id,
    int target_id,
    FaceDetectorYN *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FaceDetectorYN>(cv::FaceDetectorYN::create(
      model,
      config,
      cv::Size(input_size.width, input_size.height),
      score_threshold,
      nms_threshold,
      top_k,
      backend_id,
      target_id
  ))};
  END_WRAP
}

CvStatus *FaceDetectorYN_NewFromBuffer(
    const char *framework,
    VecUChar buffer,
    VecUChar buffer_config,
    Size input_size,
    float score_threshold,
    float nms_threshold,
    int top_k,
    int backend_id,
    int target_id,
    FaceDetectorYN *rval
) {
  BEGIN_WRAP
  auto _buffer = vecuchar_c2cpp(buffer);
  auto _buffer_config = vecuchar_c2cpp(buffer_config);
  *rval = {new cv::Ptr<cv::FaceDetectorYN>(cv::FaceDetectorYN::create(
      framework,
      _buffer,
      _buffer_config,
      cv::Size(input_size.width, input_size.height),
      score_threshold,
      nms_threshold,
      top_k,
      backend_id,
      target_id
  ))};
  END_WRAP
}

void FaceDetectorYN_Close(FaceDetectorYNPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *FaceDetectorYN_Detect(FaceDetectorYN self, Mat img, Mat *faces) {
  BEGIN_WRAP
  cv::Mat _faces;
  (*self.ptr)->detect(*img.ptr, _faces);
  *faces = {new cv::Mat(_faces)};
  END_WRAP
}

CvStatus *FaceDetectorYN_SetInputSize(FaceDetectorYN self, Size input_size) {
  BEGIN_WRAP(*self.ptr)->setInputSize(cv::Size(input_size.width, input_size.height));
  END_WRAP
}

CvStatus *FaceDetectorYN_GetInputSize(FaceDetectorYN self, Size *input_size) {
  BEGIN_WRAP
  cv::Size sz = (*self.ptr)->getInputSize();
  *input_size = {sz.width, sz.height};
  END_WRAP
}

CvStatus *FaceDetectorYN_SetScoreThreshold(FaceDetectorYN self, float score_threshold) {
  BEGIN_WRAP(*self.ptr)->setScoreThreshold(score_threshold);
  END_WRAP
}

CvStatus *FaceDetectorYN_GetScoreThreshold(FaceDetectorYN self, float *score_threshold) {
  BEGIN_WRAP
  *score_threshold = (*self.ptr)->getScoreThreshold();
  END_WRAP
}
CvStatus *FaceDetectorYN_SetNMSThreshold(FaceDetectorYN self, float nms_threshold) {
  BEGIN_WRAP(*self.ptr)->setNMSThreshold(nms_threshold);
  END_WRAP
}

CvStatus *FaceDetectorYN_GetNMSThreshold(FaceDetectorYN self, float *nms_threshold) {
  BEGIN_WRAP
  *nms_threshold = (*self.ptr)->getNMSThreshold();
  END_WRAP
}

CvStatus *FaceDetectorYN_SetTopK(FaceDetectorYN self, int top_k) {
  BEGIN_WRAP(*self.ptr)->setTopK(top_k);
  END_WRAP
}

CvStatus *FaceDetectorYN_GetTopK(FaceDetectorYN self, int *top_k) {
  BEGIN_WRAP
  *top_k = (*self.ptr)->getTopK();
  END_WRAP
}
// FaceRecognizerSF
CvStatus *FaceRecognizerSF_New(
    const char *model, const char *config, int backend_id, int target_id, FaceRecognizerSF *rval
) {
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::FaceRecognizerSF>(
      cv::FaceRecognizerSF::create(model, config, backend_id, target_id)
  )};
  END_WRAP
}
void FaceRecognizerSF_Close(FaceRecognizerSFPtr self) {
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *
FaceRecognizerSF_AlignCrop(FaceRecognizerSF self, Mat src_img, Mat face_box, Mat *aligned_img) {
  BEGIN_WRAP
  cv::Mat _align;
  (*self.ptr)->alignCrop(*src_img.ptr, *face_box.ptr, _align);
  *aligned_img = {new cv::Mat(_align)};
  END_WRAP
}

CvStatus *
FaceRecognizerSF_Feature(FaceRecognizerSF self, Mat aligned_img, bool clone, Mat *face_feature) {
  BEGIN_WRAP
  cv::Mat _face_feature;
  (*self.ptr)->feature(*aligned_img.ptr, _face_feature);
  if (clone) {
    *face_feature = {new cv::Mat(_face_feature.clone())};
  } else {
    *face_feature = {new cv::Mat(_face_feature)};
  }
  END_WRAP
}

CvStatus *FaceRecognizerSF_Match(
    FaceRecognizerSF self, Mat face_feature1, Mat face_feature2, int dis_type, double *distance
) {
  BEGIN_WRAP
  *distance = (*self.ptr)->match(*face_feature1.ptr, *face_feature2.ptr, dis_type);
  END_WRAP
}
