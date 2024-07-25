/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#pragma once
#ifndef _OPENCV3_LOGGING_H_
#define _OPENCV3_LOGGING_H_

#ifdef __cplusplus
#include <opencv2/opencv.hpp>
extern "C" {
#endif

#include "core/types.h"

CvStatus *setLogLevel(int logLevel);
CvStatus *setLogLevel_Async(int logLevel, CvCallback_0 callback);
CvStatus *getLogLevel(int *logLevel);
CvStatus *getLogLevel_Async(CvCallback_1 callback);

CvStatus *setLogTagLevel(const char *tag, int logLevel);
CvStatus *setLogTagLevel_Async(const char *tag, int logLevel, CvCallback_0 callback);
CvStatus *getLogTagLevel(const char *tag, int *logLevel);
CvStatus *getLogTagLevel_Async(const char *tag, CvCallback_1 callback);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_LOGGING_H_
