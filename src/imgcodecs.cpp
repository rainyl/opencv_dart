/*
    This file is originally from gocv project
    Licensed: Apache 2.0 license. Copyright (c) 2017-2021 The Hybrid Group.

    Modified by Rainyl.
    Licensed: Apache 2.0 license. Copyright (c) 2024 Rainyl.
*/

#include "imgcodecs.h"

// Image
Mat Image_IMRead(const char *filename, int flags)
{
    // BEGIN_WRAP
    return new cv::Mat(cv::imread(filename, flags));
    // END_WRAP
}

bool Image_IMWrite(const char *filename, Mat img)
{
    return cv::imwrite(filename, *img);
}

bool Image_IMWrite_WithParams(const char *filename, Mat img, IntVector params)
{
    std::vector<int> compression_params;

    for (int i = 0, *v = params.val; i < params.length; ++v, ++i)
    {
        compression_params.push_back(*v);
    }

    return cv::imwrite(filename, *img, compression_params);
}

void Image_IMEncode(const char *fileExt, Mat img, void *vector)
{
    auto vectorPtr = reinterpret_cast<std::vector<uchar> *>(vector);
    cv::imencode(fileExt, *img, *vectorPtr);
}

void Image_IMEncode_WithParams(const char *fileExt, Mat img, IntVector params, void *vector)
{
    auto vectorPtr = reinterpret_cast<std::vector<uchar> *>(vector);
    std::vector<int> compression_params;

    for (int i = 0, *v = params.val; i < params.length; ++v, ++i)
    {
        compression_params.push_back(*v);
    }

    cv::imencode(fileExt, *img, *vectorPtr, compression_params);
}

Mat Image_IMDecode(UCharVector buf, int flags)
{
    cv::Mat img = cv::imdecode(*buf, flags);
    return new cv::Mat(img);
}

void Image_IMDecodeIntoMat(UCharVector buf, int flags, Mat dest)
{
    cv::imdecode(*buf, flags, dest);
}
