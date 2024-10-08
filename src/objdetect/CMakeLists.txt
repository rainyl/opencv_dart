cmake_minimum_required(VERSION 3.15)

project(dartcv_objdetect_library VERSION 1.0.0 LANGUAGES C CXX)

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
  "objdetect_async.cpp"
  "objdetect.cpp"
)
set(_header_files
  "objdetect_async.h"
  "objdetect.h"
)

# provide include dir for other libs that depend on this one
set(dartcv_objdetect_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

add_library(dartcv_objdetect SHARED ${_cpp_files} ${_header_files})
target_include_directories(dartcv_objdetect SYSTEM PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${OPENCV_DART_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)
message(STATUS "Added library: dartcv_objdetect")
set_target_properties(dartcv_objdetect PROPERTIES
  PUBLIC_HEADER "${_header_files}"
  OUTPUT_NAME dartcv_objdetect
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
  LINK_FLAGS_RELEASE -s
)
target_link_libraries(dartcv_objdetect PRIVATE
  opencv_objdetect
  dartcv_core
  ${PLATFORM_LIBS}
)

if(APPLE)
  target_link_options(dartcv_objdetect PRIVATE "LINKER:-ld_classic")
endif(APPLE)

if(WIN32)
  set_target_properties(dartcv_objdetect PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  if(BUILD_WITH_STATIC_CRT)
    target_compile_options(dartcv_objdetect PRIVATE "/MT")
  endif()
endif(WIN32)

target_compile_definitions(dartcv_objdetect PUBLIC DART_SHARED_LIB)
