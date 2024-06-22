#include "core_async.h"
#include "core/types.h"

// CvStatus *RotatedRect_Points_Async(RotatedRect rect, CvCallback1 callback)
// {
//   BEGIN_WRAP
//   auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
//                            cv::Size2f(rect.size.width, rect.size.height), rect.angle);
//   std::vector<cv::Point2f> pts_;
//   r.points(pts_);
//   callback(new VecPoint2f{new std::vector<cv::Point2f>(pts_)});
//   END_WRAP
// }
// CvStatus *RotatedRect_BoundingRect_Async(RotatedRect rect, CvCallback1 callback)
// {
//   BEGIN_WRAP
//   auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
//                            cv::Size2f(rect.size.width, rect.size.height), rect.angle);
//   auto rr = r.boundingRect();
//   callback(new Rect{rr.x, rr.y, rr.width, rr.height});
//   END_WRAP
// }
// CvStatus *RotatedRect_BoundingRect2f_Async(RotatedRect rect, CvCallback1 callback)
// {
//   BEGIN_WRAP
//   auto r = cv::RotatedRect(cv::Point2f(rect.center.x, rect.center.y),
//                            cv::Size2f(rect.size.width, rect.size.height), rect.angle);
//   auto rr = r.boundingRect2f();
//   callback(new Rect2f{rr.x, rr.y, rr.width, rr.height});
//   END_WRAP
// }
