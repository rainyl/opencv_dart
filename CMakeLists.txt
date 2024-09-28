cmake_minimum_required(VERSION 3.15)

project(opencv_dart_library VERSION 1.0.0 LANGUAGES C CXX)
set(LIBRARY_NAME "opencv_dart")

file(READ ${CMAKE_SOURCE_DIR}/binary.version PROJECT_VERSION)

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
cmake_policy(SET CMP0135 NEW)

option(CVD_ENABLE_TEST "Enable unit tests" OFF)
option(CVD_PLATFORM_INSTALL_DIR "Install to platform specific directory" "")
option(BUILD_WITH_STATIC_CRT "Build with static CRT" ON)

set(OpenCV_STATIC ON)

find_package(FFMPEG REQUIRED)
if(LINUX OR APPLE)
  find_package(Iconv REQUIRED)
endif()
find_package(OpenCV REQUIRED)

set(OpenCV_LIBS
  opencv_aruco opencv_core opencv_calib3d opencv_dnn opencv_highgui
  opencv_features2d opencv_gapi opencv_photo opencv_imgproc
  opencv_objdetect opencv_video opencv_videoio opencv_stitching
  opencv_img_hash opencv_wechat_qrcode opencv_ximgproc opencv_xobjdetect
  opencv_quality
)

if(ANDROID)
  list(APPEND OpenCV_LIBS camera2ndk mediandk -landroid)
endif(ANDROID)

if(IOS)
  # https://github.com/opencv/opencv/blob/450e741f8d53ff12b4e194c7762adaefb952555a/platforms/ios/build_framework.py#L386
  list(APPEND OpenCV_LIBS
    "-framework AVFoundation"
    "-framework CoreGraphics"
    "-framework CoreImage"
    "-framework CoreMedia"
    "-framework QuartzCore"
    "-framework Accelerate"
    "-framework UIKit"
    "-framework CoreVideo"
  )
endif(IOS)

message(STATUS "Project version: ${PROJECT_VERSION}")
message(STATUS "FFMPEG libraries: ${FFMPEG_LIBRARIES}")

file(GLOB_RECURSE CPP_FILES
  "${CMAKE_CURRENT_SOURCE_DIR}/src/**/*.cpp"
)
file(GLOB_RECURSE HEADER_FILES
  "${CMAKE_CURRENT_SOURCE_DIR}/src/**/*.h"
)

add_library(${LIBRARY_NAME} SHARED ${CPP_FILES} ${HEADER_FILES})
target_include_directories(${LIBRARY_NAME} SYSTEM PUBLIC
  "${CMAKE_CURRENT_SOURCE_DIR}/src"
  ${OpenCV_INCLUDE_DIRS}
)
target_link_libraries(${LIBRARY_NAME} PRIVATE ${OpenCV_LIBS} ${FFMPEG_LIBRARIES})

set_target_properties(${LIBRARY_NAME} PROPERTIES
  # PUBLIC_HEADER ${HEADER_FILES}
  OUTPUT_NAME ${LIBRARY_NAME}
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
  LINK_FLAGS_RELEASE -s
)

if(IOS)
  # PLATFORM will be defined using ios.toolchain.cmake
  if(DEFINED PLATFORM)
    if(PLATFORM MATCHES "SIMULATOR*")
      set(IOS_SUPPORTED_PLATFORM "iPhoneSimulator")
    elseif(PLATFORM STREQUAL "OS64")
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
    MACOSX_FRAMEWORK_INFO_PLIST ${CMAKE_SOURCE_DIR}/cmake/Info.plist.in
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

if(CVD_ENABLE_TEST)
  set_target_properties(${LIBRARY_NAME} PROPERTIES COMPILE_DEFINITIONS "CVD_ENABLE_TEST")
endif()

### install
if(WIN32)
  file(GLOB CV_DEPENDENCIES "${FFMPEG_ROOT}/bin/*.dll")
elseif(IOS)
  file(GLOB CV_DEPENDENCIES "${FFMPEG_ROOT}/lib/*.dylib")
elseif(APPLE)
  file(GLOB CV_DEPENDENCIES "${FFMPEG_ROOT}/lib/*.dylib")
elseif(ANDROID OR LINUX)
  file(GLOB CV_DEPENDENCIES "${FFMPEG_ROOT}/lib/*.so")
else()
  message(FATAL_ERROR "Unknown platform")
endif()

install(TARGETS ${LIBRARY_NAME} DESTINATION ${CMAKE_INSTALL_PREFIX})
install(FILES ${CV_DEPENDENCIES} DESTINATION ${CMAKE_INSTALL_PREFIX})
# TODO: install ffmpeg

if(CVD_PLATFORM_INSTALL_DIR)
  # also install to platform specific directories
  install(TARGETS ${LIBRARY_NAME} DESTINATION ${CVD_PLATFORM_INSTALL_DIR})
  install(FILES ${CV_DEPENDENCIES} DESTINATION ${CVD_PLATFORM_INSTALL_DIR})
endif()

if(CVD_ENABLE_TEST)
  ### test
  include(FetchContent)
  FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/heads/main.zip
  )
  # For Windows: Prevent overriding the parent project's compiler/linker settings
  if(WIN32)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
  endif(WIN32)
  FetchContent_MakeAvailable(googletest)
  # copy test images
  file(MAKE_DIRECTORY ${CMAKE_BINARY_DIR}/test)
  file(COPY
    "${CMAKE_CURRENT_SOURCE_DIR}/test/images"
    DESTINATION ${CMAKE_BINARY_DIR}/test
  )
  # model files for DNN test
  if(EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/test/models")
    file(COPY
      "${CMAKE_CURRENT_SOURCE_DIR}/test/models"
      DESTINATION ${CMAKE_BINARY_DIR}/test
    )
  endif()

  enable_testing()

  macro(add_ocv_dart_test executable_name source_file)
    add_executable(
      ${executable_name}
      "${source_file}"
    )

    target_link_libraries(
      ${executable_name}
      PUBLIC
      ${OpenCV_LIBS}
      ${LIBRARY_NAME}
      GTest::gtest_main
    )

    if(WIN32)
      set_target_properties(${executable_name} PROPERTIES
        COMPILE_FLAGS "/EHsc"
      )
    endif(WIN32)
  endmacro()

  add_ocv_dart_test(ocv_dart_test_vec "src/test/vec.cc")
  add_ocv_dart_test(ocv_dart_test_core "src/test/core.cc")
  add_ocv_dart_test(ocv_dart_test_calib3d "src/test/calib3d.cc")
  add_ocv_dart_test(ocv_dart_test_dnn "src/test/dnn.cc")
  add_ocv_dart_test(ocv_dart_test_imgcodecs "src/test/imgcodecs.cc")
  add_ocv_dart_test(ocv_dart_test_imgproc "src/test/imgproc.cc")
  add_ocv_dart_test(ocv_dart_test_video "src/test/video.cc")

  include(GoogleTest)
  gtest_discover_tests(ocv_dart_test_vec)
  gtest_discover_tests(ocv_dart_test_core)
  gtest_discover_tests(ocv_dart_test_calib3d)
  gtest_discover_tests(ocv_dart_test_dnn)
  gtest_discover_tests(ocv_dart_test_imgcodecs)
  gtest_discover_tests(ocv_dart_test_imgproc)
  gtest_discover_tests(ocv_dart_test_video)
endif()
