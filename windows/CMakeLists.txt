# The Flutter tooling requires that developers have a version of Visual Studio
# installed that includes CMake 3.14 or later. You should not increase this
# version, as doing so will cause the plugin to fail to compile for some
# customers of the plugin.
cmake_minimum_required(VERSION 3.18)

# Project-level configuration.
set(PROJECT_NAME "opencv_dart")

project(${PROJECT_NAME} LANGUAGES CXX VERSION 1.0.0)

set(CVD_LIB_URL_BASE "https://github.com/rainyl/opencv_dart/releases/download")
# check whether the auto build is disabled
set(OPENCV_DART_DISABLE_AUTO_BUILD $ENV{OPENCV_DART_DISABLE_AUTO_BUILD})

macro(download_and_extract _url _dst_dir)
  file(GLOB _libs "${_dst_dir}/*.dll")
  if(NOT _libs)
    get_filename_component(_dst_file "${_url}" NAME)
    set(_dst_file "${_dst_dir}/${_dst_file}")
    if(NOT EXISTS ${_dst_file})
      # download if not exist
      message(STATUS "Downloading ${_url} -> ${_dst_file}")
      file(DOWNLOAD "${_url}" ${_dst_file}
        SHOW_PROGRESS STATUS _rtn TLS_VERIFY OFF TIMEOUT 300
      )
      list(GET _rtn 0 _rtncode)
      if(NOT 0 EQUAL _rtncode)
        message(FATAL_ERROR ${_rtn})
      endif()
    endif(NOT EXISTS ${_dst_file})

    # extract
    message(STATUS "Extracting ${_dst_file}")
    file(ARCHIVE_EXTRACT INPUT "${_dst_file}" DESTINATION ${_dst_dir})
  else()
    message(STATUS "${_libs} exists, no need to download or extract!")
  endif()
endmacro()

if(NOT OPENCV_DART_DISABLE_AUTO_BUILD)
  # Define default architecture
  set(OPENCV_DART_ARCH $ENV{OPENCV_DART_ARCH})
  if(NOT OPENCV_DART_ARCH)
    set(OPENCV_DART_ARCH "x64")
  endif()

  # Print messages
  message(STATUS "Auto-selected architecture: ${OPENCV_DART_ARCH}")
  message(STATUS "Running setup with architecture: ${OPENCV_DART_ARCH}")

  set(LIB_FILENAME "libopencv_dart-windows-${OPENCV_DART_ARCH}.tar.gz")
  set(LIB_URL "${CVD_LIB_URL_BASE}/v${PROJECT_VERSION}/${LIB_FILENAME}")
  download_and_extract(${LIB_URL} ${CMAKE_CURRENT_SOURCE_DIR})
endif()

# Invoke the build for native code shared with the other target platforms.
# This can be changed to accommodate different builds.
# add_subdirectory("${CMAKE_CURRENT_SOURCE_DIR}/../src" "${CMAKE_CURRENT_BINARY_DIR}/shared")

# List of absolute paths to libraries that should be bundled with the plugin.
# This list could contain prebuilt libraries, or libraries created by an
# external build triggered from this build file.
file(GLOB opencv_dart_libs "${CMAKE_CURRENT_SOURCE_DIR}/*.dll")
if(NOT opencv_dart_libs)
  message(FATAL_ERROR "${PROJECT_NAME} setup failed: not found any dll in ${CMAKE_CURRENT_SOURCE_DIR}")
endif()

set(opencv_dart_bundled_libraries
  # Defined in ../src/CMakeLists.txt.
  # This can be changed to accommodate different builds.
  # $<TARGET_FILE:opencv_dart>
  ${opencv_dart_libs}
  PARENT_SCOPE
)
