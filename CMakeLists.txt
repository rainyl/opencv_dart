cmake_minimum_required(VERSION 3.15)

project(opencv_dart_library VERSION 1.0.0 LANGUAGES C CXX)
set(LIBRARY_NAME "opencv_dart")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

option(DARTCV_WITH_CORE
  "Include core, calib3d, features2d, imgcodecs, imgproc, photo, stitching, video models of opencv"
  ON
)
option(DARTCV_WITH_DNN "Include dnn module of opencv" ON)
option(DARTCV_WITH_OBJDETECT "Include objdetect module of opencv" ON)
option(DARTCV_WITH_HIGHGUI "Include highgui module of opencv" ON)
option(DARTCV_WITH_CONTRIB "Include contrib module of opencv" ON)
option(DARTCV_WITH_VIDEOIO "Include objdetect module of opencv" ON)
option(DARTCV_WITH_GAPI "Include gapi of opencv" OFF) # TODO: not finished
option(DARTCV_WORLD "Include all modules" OFF)

option(BUILD_WITH_STATIC_CRT "Build with static CRT" ON)
option(DARTCV_DISABLE_DOWNLOAD_OPENCV "Download opencv sdk from opencv.full" OFF)

set(OPENCV_VERSION "4.10.0+9")

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

# ============ download and prepare OpenCV =========
include(cmake/download_setup_opencv.cmake)

if(LINUX OR APPLE)
  find_package(Iconv REQUIRED)
endif()

# ============ download and prepare OpenCV_DIR finished ==============
find_package(OpenCV REQUIRED)

set(OPENCV_DART_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/src)

message(STATUS "OpenCV library status:")
message(STATUS "    config: ${OpenCV_DIR}")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")
message(STATUS "Project version: ${PROJECT_VERSION}")

if(DARTCV_WORLD)
  find_package(FFMPEG REQUIRED)
  add_subdirectory(src/world)
else()
  if(DARTCV_WITH_CORE)
    add_subdirectory(src/core)
    add_subdirectory(src/calib3d)
    add_subdirectory(src/features2d)
    add_subdirectory(src/imgcodecs)
    add_subdirectory(src/imgproc)
    add_subdirectory(src/photo)
    add_subdirectory(src/stitching)
    add_subdirectory(src/video)
  endif()

  if(DARTCV_WITH_DNN)
    add_subdirectory(src/dnn)
  endif()

  if(DARTCV_WITH_OBJDETECT)
    add_subdirectory(src/objdetect)
  endif()

  if(DARTCV_WITH_HIGHGUI)
    find_package(FFMPEG REQUIRED)
    add_subdirectory(src/highgui)
  endif()

  if(DARTCV_WITH_CONTRIB)
    add_subdirectory(src/contrib)
  endif()

  if(DARTCV_WITH_VIDEOIO)
    find_package(FFMPEG REQUIRED)
    add_subdirectory(src/videoio)
  endif()

  if(DARTCV_WITH_GAPI)
    add_subdirectory(src/gapi)
  endif()
endif()
