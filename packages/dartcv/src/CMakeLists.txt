cmake_minimum_required(VERSION 3.15)

project(dartcv_library VERSION 1.0.0 LANGUAGES C CXX)
set(LIBRARY_NAME "dartcv")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

# must include
# option(DARTCV_WITH_CORE "Include core module of opencv" ON)
option(DARTCV_WITH_CALIB3D "Include calib3d module of opencv" ON)
option(DARTCV_WITH_DNN "Include dnn module of opencv" ON)
option(DARTCV_WITH_FEATURES2D "Include features2d module of opencv" ON)
option(DARTCV_WITH_FREETYPE "Include freetype" OFF)
option(DARTCV_WITH_FLANN "Include flann module of opencv" ON)
option(DARTCV_WITH_HIGHGUI "Include highgui module of opencv" OFF)
option(DARTCV_WITH_IMGCODECS "Include imgcodecs module of opencv" ON)
option(DARTCV_WITH_IMGPROC "Include imgproc module of opencv" ON)
option(DARTCV_WITH_OBJDETECT "Include objdetect module of opencv" ON)
option(DARTCV_WITH_PHOTO "Include photo module of opencv" ON)
option(DARTCV_WITH_STITCHING "Include stitching module of opencv" ON)
option(DARTCV_WITH_VIDEO "Include video module of opencv" ON)
option(DARTCV_WITH_VIDEOIO "Include videoio module of opencv" OFF)
option(DARTCV_WITH_GAPI "Include gapi of opencv" OFF) # TODO: not finished
option(DARTCV_WITH_ML "Include ml module" OFF)

# Contrib
option(DARTCV_WITH_ARUCO "Include aruco module" OFF)
option(DARTCV_WITH_IMG_HASH "Include img_hash module" OFF)
option(DARTCV_WITH_QUALITY "Include quality module" OFF)
option(DARTCV_WITH_WECHAT_QRCODE "Include wechat_qrcode module" OFF)
option(DARTCV_WITH_XIMGPROC "Include ximgproc module" OFF)
option(DARTCV_WITH_XOBJDETECT "Include xobjdetect module" OFF)

option(DARTCV_ENABLE_INSTALL "Enable install" OFF)
option(DARTCV_ENABLE_TEST "Enable tests" OFF)

option(BUILD_WITH_STATIC_CRT "Build with static CRT" ON)


if (MSVC)
  add_compile_definitions(_USE_MATH_DEFINES)
endif ()

if (MSVC AND BUILD_WITH_STATIC_CRT)
  if (CMAKE_BUILD_TYPE STREQUAL "Debug")
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreadedDebug" CACHE STRING "MSVC runtime library" FORCE)
  else ()
    set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded" CACHE STRING "MSVC runtime library" FORCE)
  endif ()
endif ()

# Include FFmpeg configuration from separate file
#include(cmake/ffmpeg_options.cmake)

# ============ download and prepare OpenCV =========
# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif ()

if (UNIX AND NOT ANDROID)
  find_package(Iconv REQUIRED)
endif ()

# Set OpenCV version
if (NOT OPENCV_VERSION)
  set(OPENCV_VERSION "4.12.0")
endif ()

include(FetchContent)
include(cmake/opencv_options.cmake)

if (DARTCV_WITH_ARUCO
  OR DARTCV_WITH_IMG_HASH
  OR DARTCV_WITH_QUALITY
  OR DARTCV_WITH_WECHAT_QRCODE
  OR DARTCV_WITH_XIMGPROC
  OR DARTCV_WITH_XOBJDETECT
)
  FetchContent_Declare(
    opencv_contrib
    GIT_REPOSITORY https://github.com/opencv/opencv_contrib.git
    GIT_TAG ${OPENCV_VERSION}
    GIT_SHALLOW TRUE
  )
  FetchContent_MakeAvailable(opencv_contrib)
  set(OPENCV_EXTRA_MODULES_PATH ${opencv_contrib_SOURCE_DIR}/modules CACHE PATH "Path to opencv_contrib modules")
endif ()

FetchContent_Declare(
  opencv
  GIT_REPOSITORY https://github.com/opencv/opencv.git
  GIT_TAG ${OPENCV_VERSION}
  GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(opencv)
# ============ OpenCV setup finished ==============


set(DARTCV_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} CACHE INTERNAL "DARTCV_INCLUDE_DIRS")

if (DARTCV_WITH_FREETYPE)
  set(FT_DISABLE_ZLIB ON CACHE BOOL "")
  set(FT_DISABLE_BZIP2 ON CACHE BOOL "")
  set(FT_DISABLE_HARFBUZZ ON CACHE BOOL "")
  set(FT_DISABLE_PNG ON CACHE BOOL "")
  set(FT_DISABLE_BROTLI ON CACHE BOOL "")
  set(HB_BUILD_SUBSET OFF CACHE BOOL "")
  set(HB_HAVE_FREETYPE ON CACHE BOOL "")
  set(HB_BUILD_TESTS OFF CACHE BOOL "" FORCE)
  set(CMAKE_POSITION_INDEPENDENT_CODE ON) # -fPIC

  FetchContent_Declare(
    libharfbuzz
    GIT_REPOSITORY https://github.com/harfbuzz/harfbuzz.git
    GIT_TAG 8.4.0
    GIT_SHALLOW TRUE
  )

  FetchContent_Declare(
    libfreetype
    GIT_REPOSITORY https://github.com/freetype/freetype.git
    GIT_TAG VER-2-13-2
    GIT_SHALLOW TRUE
  )

  FetchContent_MakeAvailable(libfreetype libharfbuzz)
endif ()

add_subdirectory(dartcv)

if (DARTCV_ENABLE_INSTALL)
  set(ROOT_PROJECT_DIR ${CMAKE_CURRENT_SOURCE_DIR})

  # install
  install(DIRECTORY ${ROOT_PROJECT_DIR}/dartcv
    DESTINATION ${CMAKE_INSTALL_PREFIX}/include
    COMPONENT header_files
    FILES_MATCHING
    PATTERN "*.h"
    PATTERN "t.h" EXCLUDE
    PATTERN "test" EXCLUDE
    PATTERN "build" EXCLUDE
  )

  install(TARGETS dartcv
    DESTINATION ${CMAKE_INSTALL_PREFIX}/lib
    COMPONENT target_libs
  )

  # Include FFmpeg installation configuration from separate file
  #  include(cmake/ffmpeg_install.cmake)
endif ()

if (DARTCV_ENABLE_TEST)
  add_subdirectory(test)
endif ()
