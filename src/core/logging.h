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
CvStatus *getLogLevel(int *logLevel);

#ifdef __cplusplus
}
#endif

#endif //_OPENCV3_LOGGING_H_
