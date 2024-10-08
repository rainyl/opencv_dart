#include "img_hash_async.h"
#include "core/types.h"
#include "core/vec.hpp"

// Asynchronous functions for Image Hashing

CvStatus *pHashCompute_Async(Mat inputArr, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::img_hash::pHash(*inputArr.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *pHashCompare_Async(Mat a, Mat b, CvCallback_1 callback) {
  BEGIN_WRAP
  double result = cv::img_hash::PHash::create()->compare(*a.ptr, *b.ptr);
  callback(new double(result));
  END_WRAP
}

CvStatus *averageHashCompute_Async(Mat inputArr, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::img_hash::averageHash(*inputArr.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *averageHashCompare_Async(Mat a, Mat b, CvCallback_1 callback) {
  BEGIN_WRAP
  double result = cv::img_hash::AverageHash::create()->compare(*a.ptr, *b.ptr);
  callback(new double(result));
  END_WRAP
}

CvStatus *BlockMeanHash_Create_Async(int mode, CvCallback_1 callback) {
  BEGIN_WRAP
  auto hash = new cv::Ptr<cv::img_hash::BlockMeanHash>(cv::img_hash::BlockMeanHash::create(mode));
  callback(new BlockMeanHash{hash});
  END_WRAP
}

CvStatus *BlockMeanHash_GetMean_Async(BlockMeanHash self, CvCallback_1 callback) {
  BEGIN_WRAP
  auto vec = self.ptr->get()->getMean();
  callback(vecdouble_cpp2c_p(vec));
  END_WRAP
}

CvStatus *BlockMeanHash_SetMode_Async(BlockMeanHash self, int mode, CvCallback_0 callback) {
  BEGIN_WRAP(*self.ptr)->setMode(mode);
  callback();
  END_WRAP
}

CvStatus *BlockMeanHash_Compute_Async(BlockMeanHash self, Mat inputArr, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  self.ptr->get()->compute(*inputArr.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
BlockMeanHash_Compare_Async(BlockMeanHash self, Mat hashOne, Mat hashTwo, CvCallback_1 callback) {
  BEGIN_WRAP
  double result = self.ptr->get()->compare(*hashOne.ptr, *hashTwo.ptr);
  callback(new double(result));
  END_WRAP
}

CvStatus *colorMomentHashCompute_Async(Mat inputArr, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::img_hash::colorMomentHash(*inputArr.ptr, dst);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *colorMomentHashCompare_Async(Mat a, Mat b, CvCallback_1 callback) {
  BEGIN_WRAP
  double result = cv::img_hash::ColorMomentHash::create()->compare(*a.ptr, *b.ptr);
  callback(new double(result));
  END_WRAP
}

CvStatus *
marrHildrethHashCompute_Async(Mat inputArr, float alpha, float scale, CvCallback_1 callback) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::img_hash::marrHildrethHash(*inputArr.ptr, dst, alpha, scale);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *
marrHildrethHashCompare_Async(Mat a, Mat b, float alpha, float scale, CvCallback_1 callback) {
  BEGIN_WRAP
  double result = cv::img_hash::MarrHildrethHash::create(alpha, scale)->compare(*a.ptr, *b.ptr);
  callback(new double(result));
  END_WRAP
}

CvStatus *radialVarianceHashCompute_Async(
    Mat inputArr, double sigma, int numOfAngleLine, CvCallback_1 callback
) {
  BEGIN_WRAP
  cv::Mat dst;
  cv::img_hash::radialVarianceHash(*inputArr.ptr, dst, sigma, numOfAngleLine);
  callback(new Mat{new cv::Mat(dst)});
  END_WRAP
}

CvStatus *radialVarianceHashCompare_Async(
    Mat a, Mat b, double sigma, int numOfAngleLine, CvCallback_1 callback
) {
  BEGIN_WRAP
  double result =
      cv::img_hash::RadialVarianceHash::create(sigma, numOfAngleLine)->compare(*a.ptr, *b.ptr);
  callback(new double(result));
  END_WRAP
}
