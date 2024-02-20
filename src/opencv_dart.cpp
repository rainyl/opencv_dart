#include "opencv_dart.h"

// void rmbg_cv(CvMatPtr src, CvMatPtr dst, double contrast, double brightness, double threshold, int n_erode, int n_dilate)
// {
//   cv::Mat img1;
//   cv::convertScaleAbs(CVCMatRef(src), img1, contrast, brightness);
//   cv::cvtColor(img1, img1, cv::COLOR_BGR2GRAY);
//   cv::threshold(img1, img1, threshold, 255.0, cv::THRESH_BINARY);
//   cv::Mat element = cv::getStructuringElement(cv::MORPH_RECT, cv::Size(3, 3));
//   if (n_erode > 0)
//   {
//     cv::erode(img1, img1, element, cv::Point(-1, -1), n_erode);
//   }
//   if (n_dilate > 0)
//   {
//     cv::dilate(img1, img1, element, cv::Point(-1, -1), n_dilate);
//   }
//   std::vector<std::vector<cv::Point>> contours;
//   std::vector<cv::Vec4i> hierarchy;
//   cv::findContours(img1, contours, hierarchy, cv::RETR_EXTERNAL, cv::CHAIN_APPROX_NONE);
//   CVCMatRef(dst) = cv::Mat(img1.rows, img1.cols, CV_8UC3, cv::Scalar(0, 0, 0));

//   size_t max_idx = 0;
//   double max_area = -1;
//   for (size_t i = 0; i < contours.size(); i++)
//   {
//     double area = cv::contourArea(contours[i]);
//     if (area > max_area)
//     {
//       max_area = area;
//       max_idx = i;
//     }
//   }
//   cv::drawContours(CVCMatRef(dst), contours, max_idx, cv::Scalar(0, 0, 255), cv::FILLED);
//   cv::imwrite("test.png", CVCMatRef(dst));
// }

// CVCScalar create_scalar(double v0, double v1, double v2, double v3)
// {
//   CVCScalar s = {v0, v1, v2, v3};
//   return s;
// }

int sum(int a, int b){
  return a+b;
}