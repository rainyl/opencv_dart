cmake_minimum_required(VERSION 3.14)

project(dartcv LANGUAGES CXX VERSION 1.0.0)

# Flutter doesn't support build android-x86, disable here
# https://docs.flutter.dev/deployment/android#what-are-the-supported-target-architectures
if(ANDROID AND(DEFINED ANDROID_ABI))
  if(${ANDROID_ABI} STREQUAL "x86")
    message(STATUS "Unsupported ABI: x86")
    return()
  endif()
endif()

set(DARTCV_WITH_CALIB3D ON)
set(DARTCV_WITH_CONTRIB ON)
set(DARTCV_WITH_DNN ON)
set(DARTCV_WITH_FEATURE2D ON)
set(DARTCV_WITH_HIGHGUI OFF)
set(DARTCV_WITH_IMGPROC ON)
set(DARTCV_WITH_OBJDETECT ON)
set(DARTCV_WITH_PHOTO ON)
set(DARTCV_WITH_STITCHING ON)
set(DARTCV_WITH_VIDEO ON)
set(DARTCV_WITH_VIDEOIO OFF)
set(DARTCV_WITH_GAPI OFF)
set(DARTCV_WORLD OFF)

# TODO: read opencv_version from pubspec.yaml
set(OPENCV_VERSION "4.10.0+9")
set(DARTCV_DISABLE_DOWNLOAD_OPENCV OFF)

include(FetchContent)
FetchContent_Declare(
  dartcv
  GIT_REPOSITORY https://github.com/rainyl/dartcv.git
  GIT_TAG 61effe0762f7919b38f1da58d87c9aa541ee1569
)
FetchContent_MakeAvailable(dartcv)

if(ANDROID)
  message(STATUS "Installing ${FFMPEG_LIB_PATHS} to ${CMAKE_INSTALL_PREFIX}")
  file(COPY ${FFMPEG_LIB_PATHS} DESTINATION ${CMAKE_INSTALL_PREFIX}/${ANDROID_ABI})
endif()
