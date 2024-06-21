#include "../video/videoio.h"
#include <gtest/gtest.h>
#include <iostream>
#include <stdint.h>

TEST(videoCapture, get)
{
  auto vcc = cv::VideoCapture("test/images/small.mp4");
  std::cout << vcc.isOpened() << std::endl;
  std::cout << vcc.get(3) << " " << vcc.get(4) << " " << vcc.get(5) << " " << vcc.get(6) << " " << vcc.get(7)
            << " " << vcc.get(8) << " " << vcc.get(9) << " " << vcc.get(10) << " " << vcc.get(11) << " "
            << vcc.get(12) << std::endl;
  auto fourcc = (int)vcc.get(cv::CAP_PROP_FOURCC);
  std::cout << (char)(fourcc & 255) << (char)((fourcc >> 8) & 255) << (char)((fourcc >> 16) & 255)
            << (char)((fourcc >> 24) & 255) << std::endl;

  VideoCapture cap = {};
  CvStatus    *s = VideoCapture_New(&cap);
  EXPECT_EQ(s->code, 0);

  bool rval;
  s = VideoCapture_OpenWithAPI(cap, "test/images/small.mp4", 0, &rval);
  EXPECT_EQ(s->code, 0);

  double cc = 0;
  s = VideoCapture_Get(cap, 6, &cc);
  EXPECT_EQ(s->code, 0);
  std::cout << cc << std::endl;
}
