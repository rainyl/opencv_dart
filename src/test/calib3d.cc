#include "../calib3d/calib3d.h"
#include "../core/core.h"
#include <gtest/gtest.h>
// #include <opencv/opencv.hpp>
#include <stdint.h>

TEST(calib3d, findChessboardCornersSB)
{
  Mat img = {new cv::Mat(cv::imread("test/images/chessboard_4x6.png", 0))};
  EXPECT_EQ(img.ptr->empty(), false);
  Mat       corners = {new cv::Mat()};
  bool      rval;
  CvStatus *s = FindChessboardCornersSB(img, {4, 6}, corners, 0, &rval);
  EXPECT_EQ(s->code, 0);
}
