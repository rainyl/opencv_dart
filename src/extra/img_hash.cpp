#include "img_hash.h"

CvStatus *pHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::pHash(*inputArr.ptr, *outputArr.ptr);
  END_WRAP
}
CvStatus *pHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::PHash::create()->compare(*a.ptr, *b.ptr);
  END_WRAP
}

CvStatus *averageHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::averageHash(*inputArr.ptr, *outputArr.ptr);
  END_WRAP
}
CvStatus *averageHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::AverageHash::create()->compare(*a.ptr, *b.ptr);
  END_WRAP
}

CvStatus *BlockMeanHash_Create(int mode, BlockMeanHash *rval)
{
  BEGIN_WRAP
  *rval = {new cv::Ptr<cv::img_hash::BlockMeanHash>(cv::img_hash::BlockMeanHash::create(mode))};
  END_WRAP
}
CvStatus *BlockMeanHash_GetMean(BlockMeanHash self, double **rval, int *length)
{
  BEGIN_WRAP
  auto m = (*self.ptr)->getMean();
  *rval = m.data();
  *length = m.size();
  END_WRAP
}
CvStatus *BlockMeanHash_SetMode(BlockMeanHash self, int mode)
{
  BEGIN_WRAP(*self.ptr)->setMode(mode);
  END_WRAP
}
void BlockMeanHash_Close(BlockMeanHashPtr self)
{
  self->ptr->reset();
  CVD_FREE(self);
}

CvStatus *BlockMeanHash_Compute(BlockMeanHash self, Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP(self.ptr)->get()->compute(*inputArr.ptr, *outputArr.ptr);
  END_WRAP
}
CvStatus *BlockMeanHash_Compare(BlockMeanHash self, Mat hashOne, Mat hashTwo, double *rval)
{
  BEGIN_WRAP
  *rval = (self.ptr)->get()->compare(*hashOne.ptr, *hashTwo.ptr);
  END_WRAP
}
CvStatus *blockMeanHashCompute(Mat inputArr, Mat outputArr, int mode)
{
  BEGIN_WRAP
  cv::img_hash::blockMeanHash(*inputArr.ptr, *outputArr.ptr, mode);
  END_WRAP
}
CvStatus *blockMeanHashCompare(Mat a, Mat b, int mode, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::BlockMeanHash::create(mode)->compare(*a.ptr, *b.ptr);
  END_WRAP
}

CvStatus *colorMomentHashCompute(Mat inputArr, Mat outputArr)
{
  BEGIN_WRAP
  cv::img_hash::colorMomentHash(*inputArr.ptr, *outputArr.ptr);
  END_WRAP
}
CvStatus *colorMomentHashCompare(Mat a, Mat b, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::ColorMomentHash::create()->compare(*a.ptr, *b.ptr);
  END_WRAP
}

CvStatus *marrHildrethHashCompute(Mat inputArr, Mat outputArr, float alpha, float scale)
{
  BEGIN_WRAP
  cv::img_hash::marrHildrethHash(*inputArr.ptr, *outputArr.ptr, alpha, scale);
  END_WRAP
}
CvStatus *marrHildrethHashCompare(Mat a, Mat b, float alpha, float scale, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::MarrHildrethHash::create(alpha, scale)->compare(*a.ptr, *b.ptr);
  END_WRAP
}

CvStatus *radialVarianceHashCompute(Mat inputArr, Mat outputArr, double sigma, int numOfAngleLine)
{
  BEGIN_WRAP
  cv::img_hash::radialVarianceHash(*inputArr.ptr, *outputArr.ptr, sigma, numOfAngleLine);
  END_WRAP
}
CvStatus *radialVarianceHashCompare(Mat a, Mat b, double sigma, int numOfAngleLine, double *rval)
{
  BEGIN_WRAP
  *rval = cv::img_hash::RadialVarianceHash::create(sigma, numOfAngleLine)->compare(*a.ptr, *b.ptr);
  END_WRAP
}
