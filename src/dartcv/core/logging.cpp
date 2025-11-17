/* Created by Abdelaziz Mahdy. Licensed: Apache 2.0 license. Copyright (c) 2024 Abdelaziz Mahdy. */
#include "dartcv/core/logging.h"
#include <opencv2/core/utils/logger.hpp>

CvStatus* setLogLevel(int logLevel) {
    BEGIN_WRAP
    cv::utils::logging::setLogLevel(static_cast<cv::utils::logging::LogLevel>(logLevel));
    END_WRAP
}

CvStatus* getLogLevel(int* logLevel) {
    BEGIN_WRAP
    *logLevel = static_cast<int>(cv::utils::logging::getLogLevel());
    END_WRAP
}

void writeLogMessage(int logLevel, const char* message) {
    cv::utils::logging::internal::writeLogMessage(
        static_cast<cv::utils::logging::LogLevel>(logLevel), message
    );
}

void writeLogMessageEx(
    int logLevel, const char* tag, const char* file, int line, const char* func, const char* message
) {
    cv::utils::logging::internal::writeLogMessageEx(
        static_cast<cv::utils::logging::LogLevel>(logLevel), tag, file, line, func, message
    );
}

void setLogCallbackEx(LogCallbackEx callback) {
    logCallbackEx = callback;
}
LogCallbackEx getLogCallbackEx() {
    return logCallbackEx;
}

void setLogCallback(LogCallback callback) {
    logCallback = callback;
}
LogCallback getLogCallback() {
    return logCallback;
}

void LogCallbackExProxy(
    cv::utils::logging::LogLevel logLevel,
    const char* tag,
    const char* file,
    int line,
    const char* func,
    const char* message
) {
    logCallbackEx(
        static_cast<int>(logLevel),
        strdup(tag),
        strlen(tag),
        strdup(file),
        strlen(file),
        line,
        strdup(func),
        strlen(func),
        strdup(message),
        strlen(message)
    );
}

CvStatus* replaceWriteLogMessageEx(LogCallbackEx callback) {
    BEGIN_WRAP
    if (callback != nullptr) {
        logCallbackEx = callback;
        cv::utils::logging::internal::replaceWriteLogMessageEx(LogCallbackExProxy);
    } else {
        logCallbackEx = nullptr;
        cv::utils::logging::internal::replaceWriteLogMessageEx(nullptr);
    }
    END_WRAP
}

void logCallbackProxy(cv::utils::logging::LogLevel logLevel, const char* message) {
    logCallback(logLevel, strdup(message), strlen(message));
}

CvStatus* replaceWriteLogMessage(LogCallback callback) {
    BEGIN_WRAP
    if (callback != nullptr) {
        logCallback = callback;
        cv::utils::logging::internal::replaceWriteLogMessage(logCallbackProxy);
    } else {
        logCallback = nullptr;
        cv::utils::logging::internal::replaceWriteLogMessage(nullptr);
    }
    END_WRAP
}
