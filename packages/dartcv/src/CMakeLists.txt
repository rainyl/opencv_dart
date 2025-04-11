cmake_minimum_required(VERSION 3.15)

project(dartcv_library VERSION 1.0.0 LANGUAGES C CXX)
set(LIBRARY_NAME "dartcv")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_C_STANDARD 99)
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

# must include
# option(DARTCV_WITH_CORE "Include core, imgcodecs models of opencv" ON)
option(DARTCV_WITH_CALIB3D "Include calib3d module of opencv" OFF)
option(DARTCV_WITH_CONTRIB "Include contrib module of opencv" OFF)
option(DARTCV_WITH_DNN "Include dnn module of opencv" OFF)
option(DARTCV_WITH_FEATURES2D "Include features2d module of opencv" ON)
option(DARTCV_WITH_FLANN "Include flann module of opencv" OFF)
option(DARTCV_WITH_HIGHGUI "Include highgui module of opencv" OFF)
option(DARTCV_WITH_IMGPROC "Include imgproc module of opencv" ON)
option(DARTCV_WITH_IMGCODECS "Include imgcodecs module of opencv" ON)
option(DARTCV_WITH_OBJDETECT "Include objdetect module of opencv" OFF)
option(DARTCV_WITH_PHOTO "Include photo module of opencv" ON)
option(DARTCV_WITH_STITCHING "Include stitching module of opencv" OFF)
option(DARTCV_WITH_VIDEO "Include video module of opencv" ON)
option(DARTCV_WITH_VIDEOIO "Include objdetect module of opencv" OFF)
# option(DARTCV_WITH_GAPI "Include gapi of opencv" OFF) # TODO: not finished
# option(DARTCV_WORLD "Include all modules" OFF) # world means build all modules

option(BUILD_WITH_STATIC_CRT "Build with static CRT" ON)

#set(CMAKE_MSVC_RUNTIME_LIBRARY "MultiThreaded$<$<CONFIG:Debug>:Debug>" CACHE INTERNAL "")

if (NOT OPENCV_VERSION)
  set(OPENCV_VERSION "4.11.0")
endif ()

# ============ download and prepare OpenCV =========
# Avoid warning about DOWNLOAD_EXTRACT_TIMESTAMP in CMake 3.24:
if (CMAKE_VERSION VERSION_GREATER_EQUAL "3.24.0")
  cmake_policy(SET CMP0135 NEW)
endif ()

set(BUILD_ZLIB OFF)
set(BUILD_TIFF OFF)
set(BUILD_OPENJPEG OFF)
set(BUILD_JASPER OFF)
set(BUILD_JPEG OFF)
set(BUILD_PNG OFF)
set(BUILD_OPENEXR OFF)
set(BUILD_WEBP OFF)
set(BUILD_TBB OFF)
set(BUILD_IPP_IW OFF)
set(BUILD_ITT OFF)
set(WITH_AVFOUNDATION OFF)
set(WITH_CAP_IOS OFF)
set(WITH_CAROTENE OFF)
set(WITH_CPUFEATURES OFF)
set(WITH_EIGEN OFF)
set(WITH_FFMPEG OFF)
set(WITH_GSTREAMER OFF)
set(WITH_GTK OFF)
set(WITH_IPP OFF)
set(WITH_HALIDE OFF)
set(WITH_VULKAN OFF)
set(WITH_INF_ENGINE OFF)
set(WITH_NGRAPH OFF)
set(WITH_JASPER OFF)
set(WITH_OPENJPEG OFF)
set(WITH_JPEG OFF)
set(WITH_WEBP OFF)
set(WITH_OPENEXR OFF)
set(WITH_PNG OFF)
set(WITH_TIFF OFF)
set(WITH_OPENVX OFF)
set(WITH_GDCM OFF)
set(WITH_TBB OFF)
set(WITH_HPX OFF)
set(WITH_OPENMP ON)
set(WITH_PTHREADS_PF OFF)
set(WITH_V4L OFF)
set(WITH_CLP OFF)
set(WITH_OPENCL OFF)
set(WITH_OPENCL_SVM OFF)
set(WITH_VA OFF)
set(WITH_VA_INTEL OFF)
set(WITH_ITT OFF)
set(WITH_PROTOBUF OFF)
set(WITH_IMGCODEC_HDR OFF)
set(WITH_IMGCODEC_SUNRASTER OFF)
set(WITH_IMGCODEC_PXM OFF)
set(WITH_IMGCODEC_PFM OFF)
set(WITH_QUIRC OFF)
set(WITH_ANDROID_MEDIANDK OFF)
set(WITH_TENGINE OFF)
set(WITH_ONNX OFF)
set(WITH_TIMVX OFF)
set(WITH_OBSENSOR OFF)
set(WITH_CANN OFF)
set(WITH_FLATBUFFERS OFF)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_opencv_apps OFF)
set(BUILD_ANDROID_PROJECTS OFF)
set(BUILD_ANDROID_EXAMPLES OFF)
set(BUILD_DOCS OFF)
set(BUILD_EXAMPLES OFF)
set(BUILD_PACKAGE OFF)
set(BUILD_PERF_TESTS OFF)
set(BUILD_TESTS OFF)
set(BUILD_WITH_STATIC_CRT OFF)
set(BUILD_FAT_JAVA_LIB OFF)
set(BUILD_ANDROID_SERVICE OFF)
set(BUILD_JAVA OFF)
set(BUILD_OBJC OFF)
set(BUILD_KOTLIN_EXTENSIONS OFF)
set(ENABLE_PRECOMPILED_HEADERS OFF)
set(ENABLE_FAST_MATH ON)
set(CV_TRACE OFF)
set(BUILD_opencv_java OFF)
set(BUILD_opencv_gapi OFF)
set(BUILD_opencv_objc OFF)
set(BUILD_opencv_js OFF)
set(BUILD_opencv_ts OFF)
set(BUILD_opencv_python2 OFF)
set(BUILD_opencv_python3 OFF)
set(BUILD_opencv_flann ${DARTCV_WITH_FLANN})
set(BUILD_opencv_ml ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_aruco ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_img_hash ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_quality ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_wechat_qrcode ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_ximgproc ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_xobjdetect ${DARTCV_WITH_CONTRIB})
set(BUILD_opencv_calib3d ${DARTCV_WITH_CALIB3D})
set(BUILD_opencv_dnn ${DARTCV_WITH_DNN})
set(BUILD_opencv_features2d ${DARTCV_WITH_FEATURES2D})
set(BUILD_opencv_highgui ${DARTCV_WITH_HIGHGUI})
set(BUILD_opencv_imgproc ${DARTCV_WITH_IMGPROC})
set(BUILD_opencv_imgcodecs ${DARTCV_WITH_IMGCODECS})
set(BUILD_opencv_objdetect ${DARTCV_WITH_OBJDETECT})
set(BUILD_opencv_photo ${DARTCV_WITH_PHOTO})
set(BUILD_opencv_stitching ${DARTCV_WITH_STITCHING})
set(BUILD_opencv_video ${DARTCV_WITH_VIDEO})
set(BUILD_opencv_videoio ${DARTCV_WITH_VIDEOIO})

include(FetchContent)
if(CMAKE_VERSION VERSION_GREATER_EQUAL "3.28.0")
  if(DARTCV_WITH_CONTRIB)
    FetchContent_Declare(
        libopencv_contrib
        URL https://github.com/opencv/opencv_contrib/archive/refs/tags/${OPENCV_VERSION}.tar.gz
        EXCLUDE_FROM_ALL
    )
    FetchContent_MakeAvailable(libopencv_contrib)
    set(OPENCV_EXTRA_MODULES_PATH "${libopencv_contrib_SOURCE_DIR}/modules")
  endif(DARTCV_WITH_CONTRIB)

  FetchContent_Declare(
    libopencv
    # URL "https://github.com/nihui/opencv-mobile/releases/download/v32/opencv-mobile-${OPENCV_VERSION}.zip"
    URL https://github.com/opencv/opencv/archive/refs/tags/${OPENCV_VERSION}.tar.gz
    EXCLUDE_FROM_ALL
  )
  FetchContent_MakeAvailable(libopencv)
else()
  if(DARTCV_WITH_CONTRIB)
    FetchContent_Declare(
        libopencv_contrib
        URL https://github.com/opencv/opencv_contrib/archive/refs/tags/${OPENCV_VERSION}.tar.gz
    )
    FetchContent_GetProperties(libopencv_contrib)
    if(NOT libopencv_contrib_POPULATED)
      FetchContent_Populate(libopencv_contrib)
      add_subdirectory(${libopencv_contrib_SOURCE_DIR} ${libopencv_contrib_BINARY_DIR} EXCLUDE_FROM_ALL)
    endif()
    set(OPENCV_EXTRA_MODULES_PATH "${libopencv_contrib_SOURCE_DIR}/modules")
  endif(DARTCV_WITH_CONTRIB)

  FetchContent_Declare(
    libopencv
    # URL "https://github.com/nihui/opencv-mobile/releases/download/v32/opencv-mobile-${OPENCV_VERSION}.zip"
    URL https://github.com/opencv/opencv/archive/refs/tags/${OPENCV_VERSION}.tar.gz
  )
  FetchContent_GetProperties(libopencv)
  if(NOT libopencv_POPULATED)
    FetchContent_Populate(libopencv)
    add_subdirectory(${libopencv_SOURCE_DIR} ${libopencv_BINARY_DIR} EXCLUDE_FROM_ALL)
  endif()
endif()

if (UNIX AND NOT ANDROID)
  find_package(Iconv REQUIRED)
endif ()

set(DARTCV_INCLUDE_DIRS ${CMAKE_CURRENT_SOURCE_DIR} CACHE INTERNAL "DARTCV_INCLUDE_DIRS")

if (ANDROID)
    set(PLATFORM_LIBS ${PLATFORM_LIBS} camera2ndk mediandk -landroid)
elseif (APPLE AND IOS)
    # https://github.com/opencv/opencv/blob/450e741f8d53ff12b4e194c7762adaefb952555a/platforms/ios/build_framework.py#L386
    set(PLATFORM_LIBS ${PLATFORM_LIBS}
        "-framework UIKit"
        "-framework AVFoundation"
        "-framework CoreVideo"
        "-framework CoreGraphics"
        "-framework CoreMedia"
        "-framework CoreImage"
        "-framework QuartzCore"
        "-framework Accelerate"
    )
elseif (APPLE AND NOT IOS)
    set(PLATFORM_LIBS ${PLATFORM_LIBS}
        "-framework Cocoa"
        "-framework AVFoundation"
        "-framework OpenGL"
        "-framework CoreVideo"
        "-framework CoreGraphics"
        "-framework CoreMedia"
        "-framework CoreImage"
        "-framework QuartzCore"
        "-framework Accelerate"
    )
endif ()

# ##############################################################################
# prepare files
# ##############################################################################

# core includes core, imgcodecs
set(_cpp_files
    "core/core.cpp"
    "core/mat.cpp"
    "core/exception.cpp"
    "core/logging.cpp"
    "core/svd.cpp"
    "core/utils.cpp"
    "core/version.cpp"
    "core/stdvec.cpp"
)
set(DARTCV_DEPS opencv_core)
set(OpenCV_INCLUDE_DIRS ${OPENCV_CONFIG_FILE_INCLUDE_DIR} ${OPENCV_MODULE_opencv_core_LOCATION}/include)

# calib3d
if (DARTCV_WITH_CALIB3D OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "calib3d/calib3d.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_calib3d)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_calib3d_LOCATION}/include)
endif ()

#contrib
if (DARTCV_WITH_CONTRIB OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files}
        "contrib/aruco.cpp" "contrib/img_hash.cpp" "contrib/quality.cpp"
        "contrib/wechat_qrcode.cpp" "contrib/ximgproc.cpp" "contrib/xobjdetect.cpp"
    )
    set(DARTCV_DEPS ${DARTCV_DEPS}
        opencv_aruco opencv_img_hash opencv_quality
        opencv_wechat_qrcode opencv_ximgproc opencv_xobjdetect
    )
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS}
        ${OPENCV_MODULE_opencv_aruco_LOCATION}/include
        ${OPENCV_MODULE_opencv_img_hash_LOCATION}/include
        ${OPENCV_MODULE_opencv_quality_LOCATION}/include
        ${OPENCV_MODULE_opencv_wechat_qrcode_LOCATION}/include
        ${OPENCV_MODULE_opencv_ximgproc_LOCATION}/include
        ${OPENCV_MODULE_opencv_xobjdetect_LOCATION}/include
        ${OPENCV_MODULE_opencv_ml_LOCATION}/include
    )
endif ()

# dnn
if (DARTCV_WITH_DNN OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "dnn/dnn.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_dnn)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_dnn_LOCATION}/include)
endif ()

# features2d
if (DARTCV_WITH_FEATURES2D OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "features2d/features2d.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_features2d)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_features2d_LOCATION}/include)
    if(DARTCV_WITH_FLANN)
      set(DARTCV_DEPS ${DARTCV_DEPS} opencv_flann)
      set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_flann_LOCATION}/include)
    endif(DARTCV_WITH_FLANN)
endif ()

# highgui
if (DARTCV_WITH_HIGHGUI OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "highgui/highgui.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_highgui ${FFMPEG_LIBRARIES})
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_highgui_LOCATION}/include)
endif ()

# imgproc
if (DARTCV_WITH_IMGPROC OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "imgproc/imgproc.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgproc)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_imgproc_LOCATION}/include)
endif ()

if(DARTCV_WITH_IMGCODECS OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "imgcodecs/imgcodecs.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgcodecs)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_imgcodecs_LOCATION}/include)
endif(DARTCV_WITH_IMGCODECS OR DARTCV_WORLD)

# video
if (DARTCV_WITH_VIDEO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "video/video.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_video)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_video_LOCATION}/include)
endif ()

# objdetect
if (DARTCV_WITH_OBJDETECT OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "objdetect/objdetect.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_objdetect)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_objdetect_LOCATION}/include)
endif ()

# photo
if (DARTCV_WITH_PHOTO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "photo/photo.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_photo)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_photo_LOCATION}/include)
endif ()

# stitching
if (DARTCV_WITH_STITCHING OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "stitching/stitching.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_stitching)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_stitching_LOCATION}/include)
endif ()

# videoio
if (DARTCV_WITH_VIDEOIO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "videoio/videoio.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_videoio)
    set(OpenCV_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS} ${OPENCV_MODULE_opencv_videoio_LOCATION}/include)
endif ()

foreach (_cpp_file IN LISTS _cpp_files)
    string(REGEX REPLACE "\\.cpp$" ".h" _header_file ${_cpp_file})
    list(APPEND _header_files ${_header_file})
endforeach ()

# ##############################################################################
# Add library
# ##############################################################################

# provide include dir for other libs that depend on this one
set(dartcv_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

add_library(${LIBRARY_NAME} SHARED ${_cpp_files} ${_header_files})
target_include_directories(${LIBRARY_NAME} SYSTEM PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        ${DARTCV_INCLUDE_DIRS}
        ${OpenCV_INCLUDE_DIRS}
)
message(STATUS "Added library: ${LIBRARY_NAME}")
set_target_properties(${LIBRARY_NAME} PROPERTIES
        OUTPUT_NAME ${LIBRARY_NAME}
        CXX_VISIBILITY_PRESET default
        C_VISIBILITY_PRESET default
)
target_link_libraries(${LIBRARY_NAME} PUBLIC ${DARTCV_DEPS} ${PLATFORM_LIBS})
if(ANDROID)
    target_link_options(${LIBRARY_NAME} PRIVATE "-Wl,-z,max-page-size=16384")
endif()

# if (APPLE)
#     message(STATUS "XCODE_VERSION: ${XCODE_VERSION}")
#     target_link_options(${LIBRARY_NAME} PRIVATE "LINKER:-ld_classic")
# endif (APPLE)

if (WIN32)
    set_target_properties(${LIBRARY_NAME} PROPERTIES
            WINDOWS_EXPORT_ALL_SYMBOLS ON
            COMPILE_FLAGS "/EHsc"
    )

    if (BUILD_WITH_STATIC_CRT)
        target_compile_options(${LIBRARY_NAME} PRIVATE "/MT")
    endif ()
endif (WIN32)

target_compile_definitions(${LIBRARY_NAME} PUBLIC DART_SHARED_LIB)


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

