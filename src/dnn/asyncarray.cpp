/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "asyncarray.h"
#include <string.h>

// AsyncArray_New creates a new empty AsyncArray
CvStatus *AsyncArray_New(AsyncArray *rval)
{
  BEGIN_WRAP
  *rval = {new cv::AsyncArray()};
  END_WRAP
}

// AsyncArray_Close deletes an existing AsyncArray
void AsyncArray_Close(AsyncArrayPtr a) { CVD_FREE(a); }

CvStatus *AsyncArray_Get(AsyncArray async_out, Mat out)
{
  BEGIN_WRAP
  async_out.ptr->get(*out.ptr);
  END_WRAP
}

CvStatus *Net_forwardAsync(Net net, const char *outputName, AsyncArray *rval)
{
  BEGIN_WRAP
  auto arr = net.ptr->forwardAsync();
  *rval = {&arr};
  END_WRAP
}
