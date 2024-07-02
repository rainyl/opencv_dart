#ifndef CVD_IMGPROC_UTILS_H
#define CVD_IMGPROC_UTILS_H

#include <vector>
#include <opencv2/opencv.hpp>

inline std::vector<cv::Point2f> vecPointToVecPoint2f(std::vector<cv::Point> src)
{
  std::vector<cv::Point2f> v;
  for (int i = 0; i < src.size(); i++) {
    v.push_back(cv::Point2f(src.at(i).x, src.at(i).y));
  }
  return v;
}

#endif // CVD_IMGPROC_UTILS_H
