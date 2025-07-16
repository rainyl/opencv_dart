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

function(_parse_dartcv_cmake_vars)
  # Generate module config from pubspec.yaml using Dart script
  # The step should not be mendatary for better user experience
  if(CMAKE_HOST_SYSTEM_NAME MATCHES "Windows")
    find_program(DART_EXECUTABLE NAMES "dart.bat" NO_CACHE)
  elseif(CMAKE_HOST_SYSTEM_NAME MATCHES "Linux|Darwin")
    find_program(DART_EXECUTABLE NAMES dart NO_CACHE)
  else()
    message(FATAL_ERROR "Current host system ${CMAKE_HOST_SYSTEM_NAME} is not supported!")
  endif()

  if(NOT DART_EXECUTABLE)
    message(WARNING "Dart SDK not found! Will use default modules.")
    return()
  else()
    message(STATUS "Dart SDK found: ${DART_EXECUTABLE}")
  endif()

  # Infer working directory
  message(STATUS "CMAKE_LIBRARY_OUTPUT_DIRECTORY: ${CMAKE_LIBRARY_OUTPUT_DIRECTORY}")
  if(ANDROID AND DEFINED CMAKE_LIBRARY_OUTPUT_DIRECTORY)
    get_filename_component(_working_dir "${CMAKE_LIBRARY_OUTPUT_DIRECTORY}" DIRECTORY)
  elseif(WIN32 OR UNIX)
    get_filename_component(_working_dir "${CMAKE_BINARY_DIR}" DIRECTORY)
  endif()

  message(STATUS "WORKING_DIR: ${_working_dir}")

  if(NOT DEFINED _working_dir)
    message(FATAL_ERROR "Can not infer working directory.")
  endif()

  while(NOT EXISTS "${_working_dir}/build" AND NOT "${_working_dir}" STREQUAL "/")
    get_filename_component(_working_dir "${_working_dir}" DIRECTORY)
  endwhile()

  message(STATUS "Final WORKING_DIR: ${_working_dir}")

  execute_process(
    COMMAND ${DART_EXECUTABLE} run dartcv4:gen_cmake_vars
    OUTPUT_VARIABLE _output
    ERROR_VARIABLE _error
    WORKING_DIRECTORY ${_working_dir}
    OUTPUT_STRIP_TRAILING_WHITESPACE
  )

  message(STATUS "Generate command output:\n${_output}")

  if(_error OR (NOT _output))
    message(FATAL_ERROR "Error while running dartcv4:gen_cmake_vars, error: ${_error}, output: ${_output}")
  endif()

  string(REGEX MATCH "###DARTCV_GEN_CMAKE_VAR_BEGIN###\n.*###DARTCV_GEN_CMAKE_VAR_END###" _content ${_output})

  if(_content)
    string(REGEX REPLACE "###DARTCV_GEN_CMAKE_VAR_BEGIN###\n" "" _content ${_content})
    string(REGEX REPLACE "###DARTCV_GEN_CMAKE_VAR_END###" "" _content ${_content})
    string(STRIP _content ${_content})
  else()
    message(WARNING "No matching DARTCV_GEN_CMAKE_VAR block found.")
    return()
  endif()

  # Split to lines
  string(REGEX REPLACE "\r?\n" ";" _lines "${_content}")

  foreach(_line IN LISTS _lines)
    if(_line MATCHES "^([^=]+)=(ON|OFF)$")
      set(_var_name "DARTCV_WITH_${CMAKE_MATCH_1}")
      set(_var_value "${CMAKE_MATCH_2}")
      set(${_var_name} ${_var_value} CACHE BOOL "Enable OpenCV ${CMAKE_MATCH_1} module" FORCE)
    endif()
  endforeach()
endfunction()

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
if(ANDROID AND (DEFINED ANDROID_ABI))
  if(${ANDROID_ABI} STREQUAL "x86")
    message(STATUS "Unsupported ABI: x86")
    return()
  endif()
endif()

_parse_dartcv_cmake_vars()

set(_enabled_modules "core")
set(_disabled_modules)

# ebabled modules by default
set(_modules CALIB3D CONTRIB DNN FEATURES2D HIGHGUI IMGPROC OBJDETECT PHOTO STITCHING VIDEO VIDEOIO)

foreach(_m IN LISTS _modules)
  string(TOLOWER ${_m} _m_lower)

  if(${DARTCV_WITH_${_m}})
    set(_enabled_modules ${_enabled_modules} ${_m_lower})
  else()
    set(_disabled_modules ${_disabled_modules} ${_m_lower})
  endif()
endforeach()

set(DARTCV_WITH_GAPI OFF CACHE BOOL "Enable OpenCV gapi module" FORCE)
set(DARTCV_WORLD OFF CACHE BOOL "Enable OpenCV world module" FORCE)

set(OPENCV_VERSION "${_version_opencv}")
set(DARTCV_DISABLE_DOWNLOAD_OPENCV OFF)

message(DEBUG "DARTCV_WITH_CALIB3D: ${DARTCV_WITH_CALIB3D}")
message(DEBUG "DARTCV_WITH_CONTRIB: ${DARTCV_WITH_CONTRIB}")
message(DEBUG "DARTCV_WITH_DNN: ${DARTCV_WITH_DNN}")
message(DEBUG "DARTCV_WITH_FEATURES2D: ${DARTCV_WITH_FEATURES2D}")
message(DEBUG "DARTCV_WITH_HIGHGUI: ${DARTCV_WITH_HIGHGUI}")
message(DEBUG "DARTCV_WITH_IMGPROC: ${DARTCV_WITH_IMGPROC}")
message(DEBUG "DARTCV_WITH_OBJDETECT: ${DARTCV_WITH_OBJDETECT}")
message(DEBUG "DARTCV_WITH_PHOTO: ${DARTCV_WITH_PHOTO}")
message(DEBUG "DARTCV_WITH_STITCHING: ${DARTCV_WITH_STITCHING}")
message(DEBUG "DARTCV_WITH_VIDEO: ${DARTCV_WITH_VIDEO}")
message(DEBUG "DARTCV_WITH_VIDEOIO: ${DARTCV_WITH_VIDEOIO}")

message(STATUS "Enabled modules: ${_enabled_modules}")
message(STATUS "Disabled modules: ${_disabled_modules}")

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
