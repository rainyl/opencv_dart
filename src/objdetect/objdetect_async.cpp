#include "objdetect_async.h"
#include "core/types.h"

// Asynchronous functions for CascadeClassifier
CvStatus *CascadeClassifier_New_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new CascadeClassifier{new cv::CascadeClassifier()});
    END_WRAP
}

CvStatus *CascadeClassifier_NewFromFile_Async(const char *filename, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new CascadeClassifier{new cv::CascadeClassifier(filename)});
    END_WRAP
}

CvStatus *CascadeClassifier_Load_Async(CascadeClassifier self, const char *name, CvCallback_1 callback) {
    BEGIN_WRAP
    int rval = self.ptr->load(name);
    callback(new int(rval));
    END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScale_Async(CascadeClassifier self, Mat img, CvCallback_1 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    self.ptr->detectMultiScale(*img.ptr, rects);
    callback(new VecRect{new std::vector<cv::Rect>(rects)});
    END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScaleWithParams_Async(CascadeClassifier self, Mat img, double scale, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_1 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    auto minsize = cv::Size(minSize.width, minSize.height);
    auto maxsize = cv::Size(maxSize.width, maxSize.height);
    self.ptr->detectMultiScale(*img.ptr, rects, scale, minNeighbors, flags, minsize, maxsize);
    callback(new VecRect{new std::vector<cv::Rect>(rects)});
    END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScale2_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, CvCallback_2 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    std::vector<int> nums;
    auto minsize = cv::Size(minSize.width, minSize.height);
    auto maxsize = cv::Size(maxSize.width, maxSize.height);
    self.ptr->detectMultiScale(*img.ptr, rects, nums, scaleFactor, minNeighbors, flags, minsize, maxsize);
    callback(new VecRect{new std::vector<cv::Rect>(rects)}, new VecInt{new std::vector<int>(nums)});
    END_WRAP
}

CvStatus *CascadeClassifier_DetectMultiScale3_Async(CascadeClassifier self, Mat img, double scaleFactor, int minNeighbors, int flags, Size minSize, Size maxSize, bool outputRejectLevels, CvCallback_3 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    std::vector<int> rejects;
    std::vector<double> weights;
    auto minsize = cv::Size(minSize.width, minSize.height);
    auto maxsize = cv::Size(maxSize.width, maxSize.height);
    self.ptr->detectMultiScale(*img.ptr, rects, rejects, weights, scaleFactor, minNeighbors, flags, minsize, maxsize, outputRejectLevels);
    callback(new VecRect{new std::vector<cv::Rect>(rects)}, new VecInt{new std::vector<int>(rejects)}, new VecDouble{new std::vector<double>(weights)});
    END_WRAP
}

CvStatus *CascadeClassifier_Empty_Async(CascadeClassifier self, CvCallback_1 callback) {
    BEGIN_WRAP
    bool rval = self.ptr->empty();
    callback(new bool(rval));
    END_WRAP
}

CvStatus *CascadeClassifier_getFeatureType_Async(CascadeClassifier self, CvCallback_1 callback) {
    BEGIN_WRAP
    int rval = self.ptr->getFeatureType();
    callback(new int(rval));
    END_WRAP
}

CvStatus *CascadeClassifier_getOriginalWindowSize_Async(CascadeClassifier self, CvCallback_1 callback) {
    BEGIN_WRAP
    auto sz = self.ptr->getOriginalWindowSize();
    callback(new Size{sz.width, sz.height});
    END_WRAP
}

CvStatus *CascadeClassifier_isOldFormatCascade_Async(CascadeClassifier self, CvCallback_1 callback) {
    BEGIN_WRAP
    bool rval = self.ptr->isOldFormatCascade();
    callback(new bool(rval));
    END_WRAP
}

// Asynchronous functions for HOGDescriptor
CvStatus *HOGDescriptor_New_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new HOGDescriptor{new cv::HOGDescriptor()});
    END_WRAP
}

CvStatus *HOGDescriptor_NewFromFile_Async(const char *filename, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new HOGDescriptor{new cv::HOGDescriptor(filename)});
    END_WRAP
}

CvStatus *HOGDescriptor_Load_Async(HOGDescriptor self, const char *name, CvCallback_1 callback) {
    BEGIN_WRAP
    bool rval = self.ptr->load(name);
    callback(new bool(rval));
    END_WRAP
}

CvStatus *HOGDescriptor_Detect_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_3 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> _foundLocations;
    std::vector<cv::Point> _searchLocations;
    std::vector<double> _weights;
    self.ptr->detect(*img.ptr, _foundLocations, _weights, hitThresh, cv::Point(winStride.width, winStride.height), cv::Point(padding.width, padding.height), _searchLocations);
    callback(new VecPoint{new std::vector<cv::Point>(_foundLocations)}, new VecDouble{new std::vector<double>(_weights)}, new VecPoint{new std::vector<cv::Point>(_searchLocations)});
    END_WRAP
}

CvStatus *HOGDescriptor_Detect2_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, CvCallback_2 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> _foundLocations;
    std::vector<cv::Point> _searchLocations;
    self.ptr->detect(*img.ptr, _foundLocations, hitThresh, cv::Point(winStride.width, winStride.height), cv::Point(padding.width, padding.height), _searchLocations);
    callback(new VecPoint{new std::vector<cv::Point>(_foundLocations)}, new VecPoint{new std::vector<cv::Point>(_searchLocations)});
    END_WRAP
}

CvStatus *HOGDescriptor_DetectMultiScale_Async(HOGDescriptor self, Mat img, CvCallback_1 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    self.ptr->detectMultiScale(*img.ptr, rects);
    callback(new VecRect{new std::vector<cv::Rect>(rects)});
    END_WRAP
}

CvStatus *HOGDescriptor_DetectMultiScaleWithParams_Async(HOGDescriptor self, Mat img, double hitThresh, Size winStride, Size padding, double scale, double finalThreshold, bool useMeanshiftGrouping, CvCallback_1 callback) {
    BEGIN_WRAP
    std::vector<cv::Rect> rects;
    auto winstride = cv::Size(winStride.width, winStride.height);
    auto pad = cv::Size(padding.width, padding.height);
    self.ptr->detectMultiScale(*img.ptr, rects, hitThresh, winstride, pad, scale, finalThreshold, useMeanshiftGrouping);
    callback(new VecRect{new std::vector<cv::Rect>(rects)});
    END_WRAP
}

CvStatus *HOGDescriptor_Compute_Async(HOGDescriptor self, Mat img, Size winStride, Size padding, CvCallback_2 callback) {
    BEGIN_WRAP
    std::vector<float> _descriptors;
    std::vector<cv::Point> _locations;
    self.ptr->compute(*img.ptr, _descriptors, cv::Size(winStride.width, winStride.height), cv::Size(padding.width, padding.height), _locations);
    callback(new VecFloat{new std::vector<float>(_descriptors)}, new VecPoint{new std::vector<cv::Point>(_locations)});
    END_WRAP
}

CvStatus *HOGDescriptor_computeGradient_Async(HOGDescriptor self, Mat img, Mat grad, Mat angleOfs, Size paddingTL, Size paddingBR, CvCallback_0 callback) {
    BEGIN_WRAP
    self.ptr->computeGradient(*img.ptr, *grad.ptr, *angleOfs.ptr, cv::Size(paddingTL.width, paddingTL.height), cv::Size(paddingBR.width, paddingBR.height));
    callback();
    END_WRAP
}

CvStatus *HOG_GetDefaultPeopleDetector_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new VecFloat{new std::vector<float>(cv::HOGDescriptor::getDefaultPeopleDetector())});
    END_WRAP
}

CvStatus *HOGDescriptor_SetSVMDetector_Async(HOGDescriptor self, VecFloat det, CvCallback_1 callback) {
    BEGIN_WRAP
    self.ptr->setSVMDetector(*det.ptr);
    callback(new int(0));
    END_WRAP
}

CvStatus *HOGDescriptor_getDaimlerPeopleDetector_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new VecFloat{new std::vector<float>(cv::HOGDescriptor::getDaimlerPeopleDetector())});
    END_WRAP
}

CvStatus *HOGDescriptor_getDescriptorSize_Async(HOGDescriptor self, CvCallback_1 callback) {
    BEGIN_WRAP
    size_t rval = self.ptr->getDescriptorSize();
    callback(new size_t(rval));
    END_WRAP
}

CvStatus *HOGDescriptor_getWinSigma_Async(HOGDescriptor self, CvCallback_1 callback) {
    BEGIN_WRAP
    double rval = self.ptr->getWinSigma();
    callback(new double(rval));
    END_WRAP
}

CvStatus *HOGDescriptor_groupRectangles_Async(HOGDescriptor self, VecRect rectList, VecDouble weights, int groupThreshold, double eps, CvCallback_1 callback) {
    BEGIN_WRAP
    self.ptr->groupRectangles(*rectList.ptr, *weights.ptr, groupThreshold, eps);
    callback(new int(0));
    END_WRAP
}

CvStatus *GroupRectangles_Async(VecRect rects, int groupThreshold, double eps, CvCallback_1 callback) {
    BEGIN_WRAP
    cv::groupRectangles(*rects.ptr, groupThreshold, eps);
    callback(new int(0));
    END_WRAP
}

// Asynchronous functions for QRCodeDetector
CvStatus *QRCodeDetector_New_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new QRCodeDetector{new cv::QRCodeDetector()});
    END_WRAP
}

CvStatus *QRCodeDetector_DetectAndDecode_Async(QRCodeDetector self, Mat input, CvCallback_3 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> points_;
    cv::Mat straight_qrcode;
    auto info = self.ptr->detectAndDecode(*input.ptr, points_, straight_qrcode);
    callback(new char*(strdup(info.c_str())), new VecPoint{new std::vector<cv::Point>(points_)}, new Mat{new cv::Mat(straight_qrcode)});
    END_WRAP
}

CvStatus *QRCodeDetector_Detect_Async(QRCodeDetector self, Mat input, CvCallback_2 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> _points;
    bool rval = self.ptr->detect(*input.ptr, _points);
    callback(new bool(rval), new VecPoint{new std::vector<cv::Point>(_points)});
    END_WRAP
}

CvStatus *QRCodeDetector_Decode_Async(QRCodeDetector self, Mat input, CvCallback_3 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> _points;
    cv::Mat straight_qrcode;
    auto info = self.ptr->detectAndDecode(*input.ptr, _points, straight_qrcode);
    callback(new char*(strdup(info.c_str())), new VecPoint{new std::vector<cv::Point>(_points)}, new Mat{new cv::Mat(straight_qrcode)});
    END_WRAP
}

CvStatus *QRCodeDetector_decodeCurved_Async(QRCodeDetector self, Mat img, VecPoint points, CvCallback_2 callback) {
    BEGIN_WRAP
    cv::Mat _straight_qrcode;
    auto ret = self.ptr->decodeCurved(*img.ptr, *points.ptr, _straight_qrcode);
    callback(new char*(strdup(ret.c_str())), new Mat{new cv::Mat(_straight_qrcode)});
    END_WRAP
}

CvStatus *QRCodeDetector_detectAndDecodeCurved_Async(QRCodeDetector self, Mat img, CvCallback_3 callback) {
    BEGIN_WRAP
    cv::Mat _straight_qrcode;
    std::vector<cv::Point> _points;
    auto ret = self.ptr->detectAndDecodeCurved(*img.ptr, _points, _straight_qrcode);
    callback(new char*(strdup(ret.c_str())), new VecPoint{new std::vector<cv::Point>(_points)}, new Mat{new cv::Mat(_straight_qrcode)});
    END_WRAP
}

CvStatus *QRCodeDetector_DetectMulti_Async(QRCodeDetector self, Mat input, CvCallback_2 callback) {
    BEGIN_WRAP
    std::vector<cv::Point> _points;
    bool rval = self.ptr->detectMulti(*input.ptr, _points);
    callback(new bool(rval), new VecPoint{new std::vector<cv::Point>(_points)});
    END_WRAP
}

CvStatus *QRCodeDetector_DetectAndDecodeMulti_Async(QRCodeDetector self, Mat input, CvCallback_4 callback) {
    BEGIN_WRAP
    std::vector<cv::String> decodedCodes;
    std::vector<cv::Mat> straightQrCodes;
    std::vector<cv::Point> points_;
    bool rval = self.ptr->detectAndDecodeMulti(*input.ptr, decodedCodes, points_, straightQrCodes);
    if (!rval) {
        callback(new bool(rval), new VecVecChar{new std::vector<std::vector<char>>()}, new VecPoint{new std::vector<cv::Point>()}, new VecMat{new std::vector<cv::Mat>()});
    } else {
        std::vector<std::vector<char>> vecvec;
        for (int i = 0; i < decodedCodes.size(); i++) {
            vecvec.push_back(std::vector<char>(decodedCodes[i].begin(), decodedCodes[i].end()));
        }
        callback(new bool(rval), new VecVecChar{new std::vector<std::vector<char>>(vecvec)}, new VecPoint{new std::vector<cv::Point>(points_)}, new VecMat{new std::vector<cv::Mat>(straightQrCodes)});
    }
    END_WRAP
}

CvStatus *QRCodeDetector_setEpsX_Async(QRCodeDetector self, double epsX, CvCallback_1 callback) {
    BEGIN_WRAP
    self.ptr->setEpsX(epsX);
    callback(new int(0));
    END_WRAP
}

CvStatus *QRCodeDetector_setEpsY_Async(QRCodeDetector self, double epsY, CvCallback_1 callback) {
    BEGIN_WRAP
    self.ptr->setEpsY(epsY);
    callback(new int(0));
    END_WRAP
}

CvStatus *QRCodeDetector_setUseAlignmentMarkers_Async(QRCodeDetector self, bool useAlignmentMarkers, CvCallback_1 callback) {
    BEGIN_WRAP
    self.ptr->setUseAlignmentMarkers(useAlignmentMarkers);
    callback(new int(0));
    END_WRAP
}

// Asynchronous functions for FaceDetectorYN
CvStatus *FaceDetectorYN_New_Async(const char *model, const char *config, Size input_size, float score_threshold, float nms_threshold, int top_k, int backend_id, int target_id, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new FaceDetectorYN{new cv::Ptr<cv::FaceDetectorYN>(cv::FaceDetectorYN::create(model, config, cv::Size(input_size.width, input_size.height), score_threshold, nms_threshold, top_k, backend_id, target_id))});
    END_WRAP
}

CvStatus *FaceDetectorYN_NewFromBuffer_Async(const char *framework, VecUChar buffer, VecUChar buffer_config, Size input_size, float score_threshold, float nms_threshold, int top_k, int backend_id, int target_id, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new FaceDetectorYN{new cv::Ptr<cv::FaceDetectorYN>(cv::FaceDetectorYN::create(framework, *buffer.ptr, *buffer_config.ptr, cv::Size(input_size.width, input_size.height), score_threshold, nms_threshold, top_k, backend_id, target_id))});
    END_WRAP
}

CvStatus *FaceDetectorYN_Detect_Async(FaceDetectorYN self, Mat img, CvCallback_1 callback) {
    BEGIN_WRAP
    cv::Mat faces;
    (*self.ptr)->detect(*img.ptr, faces);
    callback(new Mat{new cv::Mat(faces)});
    END_WRAP
}

CvStatus *FaceDetectorYN_SetInputSize_Async(FaceDetectorYN self, Size input_size, CvCallback_1 callback) {
    BEGIN_WRAP
    (*self.ptr)->setInputSize(cv::Size(input_size.width, input_size.height));
    callback(new int(0));
    END_WRAP
}

CvStatus *FaceDetectorYN_GetInputSize_Async(FaceDetectorYN self, CvCallback_1 callback) {
    BEGIN_WRAP
    cv::Size sz = (*self.ptr)->getInputSize();
    callback(new Size{sz.width, sz.height});
    END_WRAP
}

CvStatus *FaceDetectorYN_SetScoreThreshold_Async(FaceDetectorYN self, float score_threshold, CvCallback_1 callback) {
    BEGIN_WRAP
    (*self.ptr)->setScoreThreshold(score_threshold);
    callback(new int(0));
    END_WRAP
}

CvStatus *FaceDetectorYN_GetScoreThreshold_Async(FaceDetectorYN self, CvCallback_1 callback) {
    BEGIN_WRAP
    float score_threshold = (*self.ptr)->getScoreThreshold();
    callback(new float(score_threshold));
    END_WRAP
}

CvStatus *FaceDetectorYN_SetNMSThreshold_Async(FaceDetectorYN self, float nms_threshold, CvCallback_1 callback) {
    BEGIN_WRAP
    (*self.ptr)->setNMSThreshold(nms_threshold);
    callback(new int(0));
    END_WRAP
}

CvStatus *FaceDetectorYN_GetNMSThreshold_Async(FaceDetectorYN self, CvCallback_1 callback) {
    BEGIN_WRAP
    float nms_threshold = (*self.ptr)->getNMSThreshold();
    callback(new float(nms_threshold));
    END_WRAP
}

CvStatus *FaceDetectorYN_SetTopK_Async(FaceDetectorYN self, int top_k, CvCallback_1 callback) {
    BEGIN_WRAP
    (*self.ptr)->setTopK(top_k);
    callback(new int(0));
    END_WRAP
}

CvStatus *FaceDetectorYN_GetTopK_Async(FaceDetectorYN self, CvCallback_1 callback) {
    BEGIN_WRAP
    int top_k = (*self.ptr)->getTopK();
    callback(new int(top_k));
    END_WRAP
}

// Asynchronous functions for FaceRecognizerSF
CvStatus *FaceRecognizerSF_New_Async(const char *model, const char *config, int backend_id, int target_id, CvCallback_1 callback) {
    BEGIN_WRAP
    callback(new FaceRecognizerSF{new cv::Ptr<cv::FaceRecognizerSF>(cv::FaceRecognizerSF::create(model, config, backend_id, target_id))});
    END_WRAP
}

CvStatus *FaceRecognizerSF_AlignCrop_Async(FaceRecognizerSF self, Mat src_img, Mat face_box, CvCallback_1 callback) {
    BEGIN_WRAP
    cv::Mat aligned_img;
    (*self.ptr)->alignCrop(*src_img.ptr, *face_box.ptr, aligned_img);
    callback(new Mat{new cv::Mat(aligned_img)});
    END_WRAP
}

CvStatus *FaceRecognizerSF_Feature_Async(FaceRecognizerSF self, Mat aligned_img, bool clone, CvCallback_1 callback) {
    BEGIN_WRAP
    cv::Mat face_feature;
    (*self.ptr)->feature(*aligned_img.ptr, face_feature);
    if (clone) {
        callback(new Mat{new cv::Mat(face_feature.clone())});
    } else {
        callback(new Mat{new cv::Mat(face_feature)});
    }
    END_WRAP
}

CvStatus *FaceRecognizerSF_Match_Async(FaceRecognizerSF self, Mat face_feature1, Mat face_feature2, int dis_type, CvCallback_1 callback) {
    BEGIN_WRAP
    double distance = (*self.ptr)->match(*face_feature1.ptr, *face_feature2.ptr, dis_type);
    callback(new double(distance));
    END_WRAP
}
