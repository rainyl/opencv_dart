cmake_minimum_required(VERSION 3.15)

project(dartcv VERSION 1.0.0 LANGUAGES C CXX)

# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif()

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

###############################################################################
# prepare files
###############################################################################

# dartcv_core includes core, calib3d, features2d, imgcodecs, imgproc, photo, stitching, video
set(_cpp_files
  "core/core_async.cpp"
  "core/core.cpp"
  "core/exception.cpp"
  "core/logging.cpp"
  "core/svd_async.cpp"
  "core/svd.cpp"
  "core/version.cpp"
  "calib3d/calib3d_async.cpp"
  "calib3d/calib3d.cpp"
  "features2d/features2d_async.cpp"
  "features2d/features2d.cpp"
  "imgcodecs/imgcodecs_async.cpp"
  "imgcodecs/imgcodecs.cpp"
  "imgproc/imgproc_async.cpp"
  "imgproc/imgproc.cpp"
  "photo/photo_async.cpp"
  "photo/photo.cpp"
  "stitching/stitching_async.cpp"
  "stitching/stitching.cpp"
)

set(DARTCV_DEPS opencv_core opencv_calib3d opencv_features2d opencv_imgcodecs
  opencv_imgproc opencv_photo opencv_stitching
)

# video
if(DARTCV_WITH_DNN)
  set(_cpp_files ${_cpp_files} "video/video.cpp" "video/video_async.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_video)
endif()

# dnn
if(DARTCV_WITH_DNN)
  set(_cpp_files ${_cpp_files} "dnn/dnn.cpp" "dnn/dnn_async.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_dnn)
endif()

# objdetect
if(DARTCV_WITH_OBJDETECT)
  set(_cpp_files ${_cpp_files} "objdetect/objdetect.cpp" "objdetect/objdetect_async.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_objdetect)
endif()

# contrib
if(DARTCV_WITH_CONTRIB)
  set(_cpp_files ${_cpp_files}
    "contrib/aruco.cpp"
    "contrib/aruco_async.cpp"
    "contrib/img_hash.cpp"
    "contrib/img_hash_async.cpp"
    "contrib/quality.cpp"
    "contrib/quality_async.cpp"
    "contrib/wechat_qrcode.cpp"
    "contrib/wechat_qrcode_async.cpp"
    "contrib/ximgproc.cpp"
    "contrib/ximgproc_async.cpp"
    "contrib/xobjdetect.cpp"
  )
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_aruco opencv_img_hash opencv_quality
    opencv_wechat_qrcode opencv_ximgproc opencv_xobjdetect
  )
endif()

# gapi
if(DARTCV_WITH_GAPI)
  set(_cpp_files ${_cpp_files} "gapi/gapi.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_gapi)
endif()

# highgui
if(DARTCV_WITH_HIGHGUI)
  set(_cpp_files ${_cpp_files} "highgui/highgui.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_highgui ${FFMPEG_LIBRARIES})
endif()

# videoio
if(DARTCV_WITH_VIDEOIO)
  set(_cpp_files ${_cpp_files} "videoio/videoio.cpp" "videoio/videoio_async.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_videoio ${FFMPEG_LIBRARIES})
endif()

set(_header_files)

foreach(_cpp_file IN LISTS _cpp_files)
  string(REGEX REPLACE "\\.cpp$" ".h" _header_file ${_cpp_file})
  list(APPEND _header_files ${_header_file})
endforeach()

###############################################################################
# Add library
###############################################################################

# provide include dir for other libs that depend on this one
set(dartcv_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

add_library(dartcv SHARED ${_cpp_files} ${_header_files})
target_include_directories(dartcv SYSTEM PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${OPENCV_DART_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)
message(STATUS "Added library: dartcv ${_header_files}")
set_target_properties(dartcv PROPERTIES
  PUBLIC_HEADER "${_header_files}"
  OUTPUT_NAME dartcv
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
  LINK_FLAGS_RELEASE -s
)
target_link_libraries(dartcv PRIVATE ${DARTCV_DEPS} ${PLATFORM_LIBS})

if(APPLE)
  target_link_options(dartcv PRIVATE "LINKER:-ld_classic")
endif(APPLE)

if(WIN32)
  set_target_properties(dartcv PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  if(BUILD_WITH_STATIC_CRT)
    target_compile_options(dartcv PRIVATE "/MT")
  endif()
endif(WIN32)

target_compile_definitions(dartcv PUBLIC DART_SHARED_LIB)
