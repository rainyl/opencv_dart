set(LIBOPENCV_URL_BASE "https://github.com/rainyl/opencv.full/releases/download")

set(_env_disable_download_opencv $ENV{DARTCV_DISABLE_DOWNLOAD_OPENCV})

if(_env_disable_download_opencv)
  set(DARTCV_DISABLE_DOWNLOAD_OPENCV ${_env_disable_download_opencv})
endif(_env_disable_download_opencv)

unset(_env_disable_download_opencv)

# DARTCV_CACHE_DIR is used to cache opencv sdk to system directory
# if not specified, set it to the default value of FETCHCONTENT_BASE_DIR, i.e., "CMAKE_BINARY_DIR/_deps"
set(_env_cache_dir $ENV{DARTCV_CACHE_DIR})
if(_env_cache_dir)
  if(NOT EXISTS ${_env_cache_dir})
    file(MAKE_DIRECTORY ${_env_cache_dir})
  endif()

  if(EXISTS ${_env_cache_dir} AND IS_DIRECTORY ${_env_cache_dir})
    message(STATUS "Using cache directory: ${_env_cache_dir}")
    file(TO_CMAKE_PATH ${_env_cache_dir} _env_cache_dir)
    set(DARTCV_CACHE_DIR ${_env_cache_dir} CACHE PATH "Cache directory for DartCV")
    set(FETCHCONTENT_BASE_DIR "${DARTCV_CACHE_DIR}/${CMAKE_SYSTEM_NAME}/${CMAKE_SYSTEM_PROCESSOR}"
            CACHE PATH "Directory under which to collect all populated content" FORCE
    )
  else()
    message(WARNING "DARTCV_CACHE_DIR is defined as ${_env_cache_dir} but invalid, ignored.")
  endif()
endif()
unset(_env_cache_dir)

# cache opencv to system cache directory

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

  string(TOLOWER ${CMAKE_SYSTEM_PROCESSOR} _processor_lower)
  set(_target_arch_arm64 "arm64" "aarch64")
  set(_target_arch_x64 "x64" "x86_64" "amd64")
  message(STATUS "Detected processor: ${_processor_lower}")

  if(ANDROID AND(DEFINED ANDROID_ABI))
    # if(${ANDROID_ABI} STREQUAL "x86")
    #   message(STATUS "Unsupported ABI: x86")
    #   return()
    # endif()

    set(_dartcv_arch ${ANDROID_ABI})
  elseif(${_processor_lower} IN_LIST _target_arch_x64)
    set(_dartcv_arch "x64")
  elseif(${_processor_lower} IN_LIST _target_arch_arm64)
    set(_dartcv_arch "arm64")
  else()
    message(FATAL_ERROR "Unsupported processor: ${CMAKE_SYSTEM_PROCESSOR}")
  endif()

  # detect os, supported: windows, linux, macos, android, ios
  set(_target_os "windows" "android" "linux" "ios")
  string(TOLOWER ${CMAKE_SYSTEM_NAME} _dartcv_os)

  if (${_dartcv_os} STREQUAL "windows")
    set(LIB_FILENAME "libopencv-windows-${_dartcv_arch}.tar.gz")
  elseif (${_dartcv_os} STREQUAL "linux")
    set(LIB_FILENAME "libopencv-linux-${_dartcv_arch}.tar.gz")
  elseif (${_dartcv_os} STREQUAL "android")
    set(LIB_FILENAME "libopencv-android-${_dartcv_arch}.tar.gz")
  elseif (${_dartcv_os} STREQUAL "darwin")
    set(LIB_FILENAME "libopencv-macos-${_dartcv_arch}.tar.gz")
  elseif (${_dartcv_os} STREQUAL "ios")
    if(${PLATFORM} MATCHES "SIMULATOR*")
      set(LIB_FILENAME "libopencv-iossimulator-${_dartcv_arch}.tar.gz")
    elseif(${PLATFORM} MATCHES "OS*")
      set(LIB_FILENAME "libopencv-ios-${_dartcv_arch}.tar.gz")
    else()
      message(FATAL_ERROR "Unsupported iOS platform: ${PLATFORM}")
    endif()
  else()
    message(FATAL_ERROR "Unsupported OS: ${CMAKE_SYSTEM_NAME}")
  endif ()

  # Print messages
  message(STATUS "os: ${_dartcv_os}, arch: ${_dartcv_arch}")
  unset(_target_os)
  message(STATUS "FETCHCONTENT_BASE_DIR: ${FETCHCONTENT_BASE_DIR}")
  include(FetchContent)
  FetchContent_Declare(
    libopencv
    URL "${LIBOPENCV_URL_BASE}/${OPENCV_VERSION}/${LIB_FILENAME}"
  )
  if(NOT libopencv_POPULATED)
    # FetchContent_Populate(libopencv)
    FetchContent_MakeAvailable(libopencv)
  endif()

  set(_tmp "linux" "macos" "darwin" "ios")

  if(${_dartcv_os} STREQUAL "windows")
    set(OpenCV_DIR ${libopencv_SOURCE_DIR} CACHE PATH "Directory with OpenCVConfig.cmake")
  elseif(${_dartcv_os} IN_LIST _tmp)
    set(OpenCV_DIR ${libopencv_SOURCE_DIR}/lib/cmake/opencv4 CACHE PATH "Directory with OpenCVConfig.cmake")
  elseif(${_dartcv_os} STREQUAL "android")
    set(OpenCV_DIR ${libopencv_SOURCE_DIR}/sdk/native/jni CACHE PATH "Directory with OpenCVConfig.cmake")
  else()
    message(FATAL_ERROR "Unsupported OS: ${_dartcv_os}")
  endif()
  set(FFMPEG_DIR ${libopencv_SOURCE_DIR}/ffmpeg/cmake CACHE PATH "Directory with ffmpeg-config.cmake")
  unset(_tmp)
endif()

if(NOT OpenCV_DIR)
  message(FATAL_ERROR "OpenCV_DIR is not defined, please check your environment")
else()
  message(STATUS "OpenCV_DIR: ${OpenCV_DIR}")
endif()

set(OpenCV_STATIC ON)

# restore the original value
set(FETCHCONTENT_BASE_DIR "${CMAKE_BINARY_DIR}/_deps" CACHE PATH "Directory under which to collect all populated content" FORCE)
