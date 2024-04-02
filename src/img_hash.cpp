#include "img_hash.h"

CvStatus pHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::pHash(*inputArr, *outputArr);
  END_WRAP
}
CvStatus pHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::PHash::create()->compare(*a, *b);
  END_WRAP
}

CvStatus averageHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::averageHash(*inputArr, *outputArr);
  END_WRAP
}
CvStatus averageHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::AverageHash::create()->compare(*a, *b);
  END_WRAP
}

CvStatus BlockMeanHash_Create(int mode, BlockMeanHash *rval)
{
  BEGIN_WRAP
  *rval = new cv::Ptr<cv::img_hash::BlockMeanHash>(cv::img_hash::BlockMeanHash::create(mode));
  END_WRAP
}
CvStatus BlockMeanHash_GetMean(BlockMeanHash self, double **rval, int *length)
{
  BEGIN_WRAP
  auto m = (*self)->getMean();
  *rval = m.data();
  *length = m.size();
  END_WRAP
}
CvStatus BlockMeanHash_SetMode(BlockMeanHash self, int mode)
{
  BEGIN_WRAP(*self)->setMode(mode);
  END_WRAP
}
CvStatus BlockMeanHash_Close(BlockMeanHash *self)
{
  BEGIN_WRAP
  delete *self;
  END_WRAP
}
CvStatus BlockMeanHash_Compute(BlockMeanHash *self, Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP(*self)->get()->compute(*inputArr, *outputArr);
  END_WRAP
}
CvStatus BlockMeanHash_Compare(BlockMeanHash *self, Mat hashOne, Mat hashTwo, double *rval)
{
  BEGIN_WRAP
  *rval = (*self)->get()->compare(*hashOne, *hashTwo);
  END_WRAP
}
CvStatus blockMeanHashCompute(Mat inputArr, Mat outputArr, int mode)
{
  BEGIN_WRAP
  cv::img_hash::blockMeanHash(*inputArr, *outputArr, mode);
  END_WRAP
}
CvStatus blockMeanHashCompare(Mat a, Mat b, int mode, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::BlockMeanHash::create(mode)->compare(*a, *b);
  END_WRAP
}

CvStatus colorMomentHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::colorMomentHash(*inputArr, *outputArr);
  END_WRAP
}
CvStatus colorMomentHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::ColorMomentHash::create()->compare(*a, *b);
  END_WRAP
}

CvStatus marrHildrethHashCompute(Mat inputArr, Mat outputArr, float alpha, float scale)
{
  BEGIN_WRAP
  cv::img_hash::marrHildrethHash(*inputArr, *outputArr, alpha, scale);
  END_WRAP
}
CvStatus marrHildrethHashCompare(Mat a, Mat b, float alpha, float scale, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::MarrHildrethHash::create(alpha, scale)->compare(*a, *b);
  END_WRAP
}

CvStatus radialVarianceHashCompute(Mat inputArr, Mat outputArr, double sigma, int numOfAngleLine)
{
  BEGIN_WRAP
  cv::img_hash::radialVarianceHash(*inputArr, *outputArr, sigma, numOfAngleLine);
  END_WRAP
}
CvStatus radialVarianceHashCompare(Mat a, Mat b, double sigma, int numOfAngleLine, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::RadialVarianceHash::create(sigma, numOfAngleLine)->compare(*a, *b);
  END_WRAP
}
