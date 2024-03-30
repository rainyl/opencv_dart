#include "../imgcodecs/imgcodecs.h"
#include "../core/core.h"
#include <fstream>
#include <gtest/gtest.h>

// #include <opencv/opencv.hpp>
#include <stdint.h>
#include <stdio.h>
#include <vector>

TEST(ImgCodecs, Read)
{
  Mat      im;
  CvStatus status = Image_IMRead("test/images/circles.jpg", 0, &im);
  ASSERT_EQ(status.code, 0);
  ASSERT_EQ(im.ptr->empty(), false);
}