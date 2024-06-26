#include "imgcodecs_async.h"
#include "core/types.h"

CvStatus *Image_IMRead_Async(const char *filename, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new Mat{new cv::Mat(cv::imread(filename, flags))});
  END_WRAP
}

CvStatus *Image_IMWrite_Async(const char *filename, Mat img, CvCallback_1 callback) {
  BEGIN_WRAP
  callback(new bool(cv::imwrite(filename, *img.ptr)));
  END_WRAP
}

CvStatus *Image_IMWrite_WithParams_Async(
    const char *filename, Mat img, VecInt params, CvCallback_1 callback
) {
  BEGIN_WRAP
  callback(new bool(cv::imwrite(filename, *img.ptr, *params.ptr)));
  END_WRAP
}

CvStatus *Image_IMEncode_Async(const char *fileExt, Mat img, CvCallback_2 callback) {
  BEGIN_WRAP
  std::vector<uchar> buf;
  bool success = cv::imencode(fileExt, *img.ptr, buf);
  callback(new bool(success), new VecUChar{new std::vector<uchar>(buf)});
  END_WRAP
}

CvStatus *Image_IMEncode_WithParams_Async(
    const char *fileExt, Mat img, VecInt params, CvCallback_2 callback
) {
  BEGIN_WRAP
  std::vector<uchar> buf;
  bool success = cv::imencode(fileExt, *img.ptr, buf, *params.ptr);
  callback(new bool(success), new VecUChar{new std::vector<uchar>(buf)});
  END_WRAP
}

CvStatus *Image_IMDecode_Async(VecUChar buf, int flags, CvCallback_1 callback) {
  BEGIN_WRAP
  auto m = cv::imdecode(*buf.ptr, flags);
  callback(new Mat{new cv::Mat(m)});
  END_WRAP
}
