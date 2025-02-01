/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#include "dartcv/core/logging.h"
#include <opencv2/core/utils/logger.hpp>

CvStatus *setLogLevel(int logLevel) {
  BEGIN_WRAP
  cv::utils::logging::setLogLevel(static_cast<cv::utils::logging::LogLevel>(logLevel));
  END_WRAP
}

CvStatus *getLogLevel(int *logLevel) {
  BEGIN_WRAP
  *logLevel = static_cast<int>(cv::utils::logging::getLogLevel());
  END_WRAP
}
