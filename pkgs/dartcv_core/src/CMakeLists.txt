cmake_minimum_required(VERSION 3.10)

project(dartcv_core_library VERSION 1.0.0 LANGUAGES C CXX)
string(REGEX REPLACE "_library" "" LIBRARY_NAME ${PROJECT_NAME})

set(ROOT_PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR}/..)
file(STRINGS ${ROOT_PROJECT_DIR}/pubspec.yaml PROJECT_VERSION REGEX "^version:")
string(REGEX REPLACE "^version:[ ]+" "" PROJECT_VERSION "${PROJECT_VERSION}")
message(STATUS "Project version: ${PROJECT_VERSION}")

# used to determine the version of opencv to download
file(STRINGS ${ROOT_PROJECT_DIR}/pubspec.yaml OPENCV_VERSION REGEX "^version_opencv:")
string(REGEX REPLACE "^version_opencv:[ ]+" "" OPENCV_VERSION "${OPENCV_VERSION}")
message(STATUS "OpenCV version: ${OPENCV_VERSION}")

if(NOT PROJECT_VERSION OR NOT OPENCV_VERSION)
  message(FATAL_ERROR "Can not determin the project version or opencv version, check pubspec.yaml")
endif()

# ============= start =====================
set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

option(CVD_PLATFORM_INSTALL_DIR "Install to platform specific directory" "")
option(BUILD_WITH_STATIC_CRT "Build with static CRT" ON)
option(CVD_DISABLE_DOWNLOAD_OPENCV "Download opencv sdk from opencv.full" OFF)

# ============ download and prepare OpenCV =========
set(LIBOPENCV_URL_BASE "https://github.com/rainyl/opencv.full/releases/download")

set(_env_disable_download_opencv $ENV{CVD_DISABLE_DOWNLOAD_OPENCV})

if(_env_disable_download_opencv)
  set(CVD_DISABLE_DOWNLOAD_OPENCV ${_env_disable_download_opencv})
endif(_env_disable_download_opencv)

unset(_env_disable_download_opencv)

# check whether the download is disabled
if(CVD_DISABLE_DOWNLOAD_OPENCV)
  message(STATUS "Download OpenCV: disabled")

  if(NOT DEFINED OpenCV_DIR)
    set(OpenCV_DIR $ENV{OpenCV_DIR})
  endif()

  # check whether user has set OpenCV_DIR
  if(OpenCV_DIR AND NOT EXISTS ${OpenCV_DIR}/OpenCVConfig.cmake)
    message(FATAL_ERROR "Looks like you set OpenCV_DIR environment variable, "
      "but OpenCVConfig.cmake does not exist in: ${OpenCV_DIR}"
    )
  endif()
else()
  message(STATUS "Download OpenCV: enabled")

  # detect os, supported values: windows, linux, macos, android, ios
  string(TOLOWER ${CMAKE_SYSTEM_NAME} _dartcv_os)
  set(_target_os "windows" "android" "linux" "ios")

  if(${_dartcv_os} IN_LIST _target_os)
  # placeholder
  elseif(${CMAKE_SYSTEM_NAME} STREQUAL "darwin")
    set(_dartcv_os "macos")
  else()
    message(FATAL_ERROR "Unsupported OS: ${CMAKE_SYSTEM_NAME}")
  endif()

  unset(_target_os)

  # detect arch
  string(TOLOWER ${CMAKE_SYSTEM_PROCESSOR} _processor_lower)
  set(_target_arch_arm64 "arm64" "aarch64")
  set(_target_arch_x64 "x64" "x86_64" "amd64")
  message(STATUS "Detected processor: ${_processor_lower}")

  if(ANDROID AND(DEFINED ANDROID_ABI))
    if(${ANDROID_ABI} STREQUAL "x86")
      message(STATUS "Unsupported ABI: x86")
      return()
    endif()

    set(_dartcv_arch ${ANDROID_ABI})
  elseif(${_processor_lower} IN_LIST _target_arch_x64)
    set(_dartcv_arch "x64")
  elseif(${_processor_lower} IN_LIST _target_arch_arm64)
    set(_dartcv_arch "arm64")
  else()
    message(FATAL_ERROR "Unsupported processor: ${CMAKE_SYSTEM_PROCESSOR}")
  endif()

  # Print messages
  message(STATUS "os: ${_dartcv_os}, arch: ${_dartcv_arch}")

  set(LIB_FILENAME "libopencv-${_dartcv_os}-${_dartcv_arch}.tar.gz")
  include(FetchContent)
  FetchContent_Declare(
    libopencv
    URL "${LIBOPENCV_URL_BASE}/${OPENCV_VERSION}/${LIB_FILENAME}"
  )
  FetchContent_MakeAvailable(libopencv)

  set(_tmp "linux" "macos" "ios")

  if(${_dartcv_os} STREQUAL "windows")
    set(OpenCV_DIR ${libopencv_SOURCE_DIR})
  elseif(${_dartcv_os} IN_LIST _tmp)
    set(OpenCV_DIR ${libopencv_SOURCE_DIR}/lib/cmake/opencv4)
  elseif(${_dartcv_os} STREQUAL "android")
    set(OpenCV_DIR ${libopencv_SOURCE_DIR}/sdk/native/jni)
  else()
    message(FATAL_ERROR "Unsupported OS: ${_dartcv_os}")
  endif()

  unset(_tmp)
endif()

if(NOT OpenCV_DIR)
  message(FATAL_ERROR "OpenCV_DIR is not defined, please check your environment")
else()
  message(STATUS "OpenCV_DIR: ${OpenCV_DIR}")
endif()

set(OpenCV_STATIC ON)

if(LINUX OR APPLE)
  find_package(Iconv REQUIRED)
endif()

# ============ download and prepare OpenCV_DIR finished ==============

# ============ build start ===========================================
find_package(OpenCV REQUIRED COMPONENTS
  opencv_core opencv_imgcodecs opencv_imgproc
  opencv_calib3d opencv_features2d
  opencv_photo opencv_stitching opencv_video
)

message(STATUS "OpenCV_LIBS: ${OpenCV_LIBS}")

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

set(CPP_FILES
  "core_async.cpp"
  "core.cpp"
  "exception.cpp"
  "logging.cpp"
  "svd_async.cpp"
  "svd.cpp"
  "version.cpp"
  "imgcodecs.cpp"
  "imgcodecs_async.cpp"
  "imgproc.cpp"
  "imgproc_async.cpp"
  "calib3d.cpp"
  "calib3d_async.cpp"
  "features2d.cpp"
  "features2d_async.cpp"
  "photo.cpp"
  "photo_async.cpp"
  "stitching.cpp"
  "stitching_async.cpp"
  "video.cpp"
  "video_async.cpp"
)
set(HEADER_FILES
  "core_async.h"
  "core.h"
  "exception.h"
  "logging.h"
  "svd_async.h"
  "svd.h"
  "version.h"
  "imgcodecs.h"
  "imgcodecs_async.h"
  "imgproc.h"
  "imgproc_async.h"
  "calib3d.h"
  "calib3d_async.h"
  "features2d.h"
  "features2d_async.h"
  "photo.h"
  "photo_async.h"
  "stitching.h"
  "stitching_async.h"
  "video.h"
  "video_async.h"
)

# provide include dir for other project
set(dartcv_core_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR})

message(STATUS "Building library: ${LIBRARY_NAME}")

add_library(${LIBRARY_NAME} SHARED ${CPP_FILES} ${HEADER_FILES})
target_include_directories(${LIBRARY_NAME} SYSTEM PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${OpenCV_INCLUDE_DIRS}
)
message(STATUS "Added library: ${LIBRARY_NAME} ${HEADER_FILES}")
set_target_properties(${LIBRARY_NAME} PROPERTIES
  PUBLIC_HEADER ${HEADER_FILES}
  OUTPUT_NAME ${LIBRARY_NAME}
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
  LINK_FLAGS_RELEASE -s
)
target_link_libraries(${LIBRARY_NAME} PRIVATE ${OpenCV_LIBS} ${PLATFORM_LIBS})

if(IOS)
  # PLATFORM will be defined using ios.toolchain.cmake
  if(DEFINED PLATFORM)
    if(${PLATFORM} MATCHES "SIMULATOR*")
      set(IOS_SUPPORTED_PLATFORM "iPhoneSimulator")
    elseif(${PLATFORM} STREQUAL "OS64")
      set(IOS_SUPPORTED_PLATFORM "iPhoneOS")
    else()
      message(FATAL_ERROR "For IOS, only OS64 and SIMULATOR64 are supported now.")
    endif()
  else()
    message(FATAL_ERROR "For IOS, you must define PLATFORM")
  endif()

  set_target_properties(${LIBRARY_NAME} PROPERTIES
    FRAMEWORK TRUE
    FRAMEWORK_VERSION CXX
    MACOSX_FRAMEWORK_INFO_PLIST ${ROOT_PROJECT_DIR}/cmake/Info.plist.in
  )
endif(IOS)

if(APPLE)
  target_link_options(${LIBRARY_NAME} PRIVATE "LINKER:-ld_classic")
endif(APPLE)

if(WIN32)
  set_target_properties(${LIBRARY_NAME} PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  if(BUILD_WITH_STATIC_CRT)
    target_compile_options(${LIBRARY_NAME} PRIVATE "/MT")
  endif()
endif(WIN32)

target_compile_definitions(${LIBRARY_NAME} PUBLIC DART_SHARED_LIB)
