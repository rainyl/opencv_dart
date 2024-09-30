/*
    Created by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "exception.h"

int ErrorCallbackProxy(int status, const char *func_name, const char *err_msg, const char *file_name, int line, void *callback)
{
  ((ErrorCallback)callback)(status, func_name, err_msg, file_name, line, nullptr);
  return status;
}

void registerErrorCallback(ErrorCallback callback)
{
  cv::redirectError(ErrorCallbackProxy, (void *)callback);
}
