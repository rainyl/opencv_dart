cmake_minimum_required(VERSION 3.15)

project(dartcv_contrib_library VERSION 1.0.0 LANGUAGES C CXX)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

if(ANDROID)
  set(PLATFORM_LIBS ${PLATFORM_LIBS} camera2ndk mediandk -landroid)
elseif(IOS)
  # https://github.com/opencv/opencv/blob/450e741f8d53ff12b4e194c7762adaefb952555a/platforms/ios/build_framework.py#L386
  set(PLATFORM_LIBS ${PLATFORM_LIBS}
    "-framework AVFoundation"
    "-framework CoreGraphics"
    "-framework CoreImage"
    "-framework CoreMedia"
    "-framework QuartzCore"
    "-framework Accelerate"
    "-framework UIKit"
    "-framework CoreVideo"
  )
endif()

set(_cpp_files
  "aruco.cpp"
  "aruco_async.cpp"
  "img_hash.cpp"
  "img_hash_async.cpp"
  "quality.cpp"
  "quality_async.cpp"
  "wechat_qrcode.cpp"
  "wechat_qrcode_async.cpp"
  "ximgproc.cpp"
  "ximgproc_async.cpp"
  "xobjdetect.cpp"
)
set(_header_files
  "aruco.h"
  "aruco_async.h"
  "img_hash.h"
  "img_hash_async.h"
  "quality.h"
  "quality_async.h"
  "wechat_qrcode.h"
  "wechat_qrcode_async.h"
  "ximgproc.h"
  "ximgproc_async.h"
  "xobjdetect.h"
)

# provide include dir for other libs that depend on this one
set(dartcv_contrib_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

add_library(dartcv_contrib SHARED ${_cpp_files} ${_header_files})
target_include_directories(dartcv_contrib SYSTEM PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${OPENCV_DART_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)
message(STATUS "Added library: dartcv_contrib")
set_target_properties(dartcv_contrib PROPERTIES
  PUBLIC_HEADER "${_header_files}"
  OUTPUT_NAME dartcv_contrib
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
  LINK_FLAGS_RELEASE -s
)
target_link_libraries(dartcv_contrib PRIVATE
  opencv_aruco
  opencv_img_hash
  opencv_quality
  opencv_wechat_qrcode
  opencv_ximgproc
  opencv_xobjdetect
  dartcv_core
  ${PLATFORM_LIBS}
)

if(APPLE)
  target_link_options(dartcv_contrib PRIVATE "LINKER:-ld_classic")
endif(APPLE)

if(WIN32)
  set_target_properties(dartcv_contrib PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  if(BUILD_WITH_STATIC_CRT)
    target_compile_options(dartcv_contrib PRIVATE "/MT")
  endif()
endif(WIN32)

target_compile_definitions(dartcv_contrib PUBLIC DART_SHARED_LIB)
