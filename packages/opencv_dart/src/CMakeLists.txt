cmake_minimum_required(VERSION 3.14)

get_filename_component(PROJ_DIR ${CMAKE_CURRENT_SOURCE_DIR} DIRECTORY)

macro(_find_version _version_var _version_file _regex_find _regex_replace)
  # read versions
  if(EXISTS ${_version_file})
    file(STRINGS ${_version_file} _version_string REGEX ${_regex_find})
    string(REGEX REPLACE ${_regex_replace} "\\1" _version_string "${_version_string}")
    set(${_version_var} "${_version_string}")
  else()
    message(FATAL_ERROR "file ${_version_file} not found!")
  endif()
endmacro()

_find_version(_version_project "${PROJ_DIR}/pubspec.yaml" "^version: (.+)*$" "version: (.+)*$")
_find_version(_version_opencv "${PROJ_DIR}/pubspec.yaml" "^opencv_version: (.+)*$" "opencv_version: (.+)*$")
_find_version(_version_dartcv "${PROJ_DIR}/pubspec.yaml" "^dartcv_version: (.+)*$" "dartcv_version: (.+)*$")

message(STATUS "Project Version: ${_version_project}")
message(STATUS "OpenCV Version: ${_version_opencv}")
message(STATUS "DartCv Version: ${_version_dartcv}")

project(dartcv LANGUAGES CXX VERSION 1.0.0)

set(PROJECT_VERSION "${_version_project}")

# Flutter doesn't support build android-x86, disable here
# https://docs.flutter.dev/deployment/android#what-are-the-supported-target-architectures
if(ANDROID AND(DEFINED ANDROID_ABI))
  if(${ANDROID_ABI} STREQUAL "x86")
    message(STATUS "Unsupported ABI: x86")
    return()
  endif()
endif()

set(DARTCV_WITH_CALIB3D ON CACHE BOOL "Enable OpenCV calib3d module" FORCE)
set(DARTCV_WITH_CONTRIB ON CACHE BOOL "Enable OpenCV contrib module" FORCE)
set(DARTCV_WITH_DNN ON CACHE BOOL "Enable OpenCV dnn module" FORCE)
set(DARTCV_WITH_FEATURE2D ON CACHE BOOL "Enable OpenCV feature2d module" FORCE)
set(DARTCV_WITH_HIGHGUI OFF CACHE BOOL "Enable OpenCV highgui module" FORCE)
set(DARTCV_WITH_IMGPROC ON CACHE BOOL "Enable OpenCV imgproc module" FORCE)
set(DARTCV_WITH_OBJDETECT ON CACHE BOOL "Enable OpenCV objdetect module" FORCE)
set(DARTCV_WITH_PHOTO ON CACHE BOOL "Enable OpenCV photo module" FORCE)
set(DARTCV_WITH_STITCHING ON CACHE BOOL "Enable OpenCV stitching module" FORCE)
set(DARTCV_WITH_VIDEO ON CACHE BOOL "Enable OpenCV video module")
set(DARTCV_WITH_VIDEOIO ON CACHE BOOL "Enable OpenCV videoio module" FORCE)
set(DARTCV_WITH_GAPI OFF CACHE BOOL "Enable OpenCV gapi module" FORCE)
set(DARTCV_WORLD OFF CACHE BOOL "Enable OpenCV world module" FORCE)

set(OPENCV_VERSION "${_version_opencv}")
set(DARTCV_DISABLE_DOWNLOAD_OPENCV OFF)

include(FetchContent)
FetchContent_Declare(
  libdartcv
  GIT_REPOSITORY https://github.com/rainyl/dartcv.git
  GIT_TAG ${_version_dartcv}
)
FetchContent_MakeAvailable(libdartcv)

if(ANDROID)
  message(STATUS "Installing ${FFMPEG_LIB_PATHS} to ${CMAKE_INSTALL_PREFIX}")
  file(COPY ${FFMPEG_LIB_PATHS} DESTINATION ${CMAKE_INSTALL_PREFIX}/${ANDROID_ABI})
endif()
