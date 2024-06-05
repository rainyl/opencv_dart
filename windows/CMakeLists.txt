# The Flutter tooling requires that developers have a version of Visual Studio
# installed that includes CMake 3.14 or later. You should not increase this
# version, as doing so will cause the plugin to fail to compile for some
# customers of the plugin.
cmake_minimum_required(VERSION 3.14)

# Project-level configuration.
set(PROJECT_NAME "opencv_dart")
project(${PROJECT_NAME} LANGUAGES CXX)

# Define default architecture
set(OPENCV_DART_ARCH $ENV{OPENCV_DART_ARCH})
if(NOT OPENCV_DART_ARCH)
  set(OPENCV_DART_ARCH "x64")
endif()

# Print messages
message(STATUS "Auto-selected architecture: ${OPENCV_DART_ARCH}")
message(STATUS "Running setup with architecture: ${OPENCV_DART_ARCH}")

# Get the parent directory of the current working directory
get_filename_component(PARENT_DIR ${CMAKE_CURRENT_LIST_DIR} DIRECTORY)

execute_process(
  COMMAND conan build . -b missing -s compiler.cppstd=20 -o output_dir=build/windows/${OPENCV_DART_ARCH}
  WORKING_DIRECTORY ${PARENT_DIR}
)

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
