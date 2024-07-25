/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#include "logging.h"
#include <opencv2/core/utils/logger.hpp>
#include <cstring>

CvStatus *setLogLevel(int logLevel) {
    BEGIN_WRAP
    cv::utils::logging::setLogLevel(static_cast<cv::utils::logging::LogLevel>(logLevel));
    END_WRAP
}

CvStatus *setLogLevel_Async( int logLevel,CvCallback_0 callback) {
    BEGIN_WRAP
    cv::utils::logging::setLogLevel(static_cast<cv::utils::logging::LogLevel>(logLevel));
    callback();
    END_WRAP
}

CvStatus *getLogLevel(int *logLevel) {
    BEGIN_WRAP
    *logLevel = static_cast<int>(cv::utils::logging::getLogLevel());
    END_WRAP
}

CvStatus *getLogLevel_Async(CvCallback_1 callback) {
    BEGIN_WRAP
    int level = static_cast<int>(cv::utils::logging::getLogLevel());
    callback(new int(level));
    END_WRAP
}

CvStatus *setLogTagLevel(const char *tag, int logLevel) {
    BEGIN_WRAP
    cv::utils::logging::setLogTagLevel(tag, static_cast<cv::utils::logging::LogLevel>(logLevel));
    END_WRAP
}

CvStatus *setLogTagLevel_Async(const char *tag, int logLevel,CvCallback_0 callback) {
    BEGIN_WRAP
    cv::utils::logging::setLogTagLevel(tag, static_cast<cv::utils::logging::LogLevel>(logLevel));
    callback();
    END_WRAP
}

CvStatus *getLogTagLevel(const char *tag, int *logLevel) {
    BEGIN_WRAP
    *logLevel = static_cast<int>(cv::utils::logging::getLogTagLevel(tag));
    END_WRAP
}

CvStatus *getLogTagLevel_Async(const char *tag,CvCallback_1 callback ) {
    BEGIN_WRAP
    int level = static_cast<int>(cv::utils::logging::getLogTagLevel(tag));
    callback(new int(level));
    END_WRAP
}
