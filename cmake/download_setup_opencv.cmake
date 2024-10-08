set(LIBOPENCV_URL_BASE "https://github.com/rainyl/opencv.full/releases/download")

set(_env_disable_download_opencv $ENV{DARTCV_DISABLE_DOWNLOAD_OPENCV})

if(_env_disable_download_opencv)
  set(DARTCV_DISABLE_DOWNLOAD_OPENCV ${_env_disable_download_opencv})
endif(_env_disable_download_opencv)

unset(_env_disable_download_opencv)

# check whether the download is disabled
if(DARTCV_DISABLE_DOWNLOAD_OPENCV)
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
  set(FFMPEG_DIR ${libopencv_SOURCE_DIR}/ffmpeg/cmake)

  unset(_tmp)
endif()

if(NOT OpenCV_DIR)
  message(FATAL_ERROR "OpenCV_DIR is not defined, please check your environment")
else()
  message(STATUS "OpenCV_DIR: ${OpenCV_DIR}")
endif()

set(OpenCV_STATIC ON)
