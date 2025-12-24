if (ANDROID)
  set(PLATFORM_LIBS ${PLATFORM_LIBS} camera2ndk mediandk -landroid)
elseif (APPLE AND IOS)
  # https://github.com/opencv/opencv/blob/450e741f8d53ff12b4e194c7762adaefb952555a/platforms/ios/build_framework.py#L386
  set(PLATFORM_LIBS ${PLATFORM_LIBS}
    "-framework UIKit"
    "-framework AVFoundation"
    "-framework CoreText"
    "-framework CoreFoundation"
    "-framework Foundation"
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
    "-framework CoreText"
    "-framework CoreFoundation"
    "-framework CoreMedia"
    "-framework CoreImage"
    "-framework QuartzCore"
    "-framework Accelerate"
  )
endif ()


# ##############################################################################
# prepare files
# ##############################################################################

# core
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

# calib3d
if (DARTCV_WITH_CALIB3D)
  set(_cpp_files ${_cpp_files}
    "calib3d/calib3d.cpp"
    "calib3d/stereo.cpp"
  )
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_calib3d opencv_flann opencv_imgproc opencv_features2d)
endif ()

# dnn
if (DARTCV_WITH_DNN)
  set(_cpp_files ${_cpp_files} "dnn/dnn.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_dnn opencv_imgproc)
endif ()

# features2d
if (DARTCV_WITH_FEATURES2D)
  set(_cpp_files ${_cpp_files} "features2d/features2d.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_features2d opencv_imgproc)
endif ()

# freetype
if (DARTCV_WITH_FREETYPE)
  set(_cpp_files ${_cpp_files}
    "freetype/freetype.cpp"
    "freetype/freetype.h"
  )
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgproc harfbuzz freetype)
endif ()

# gapi
if (DARTCV_WITH_GAPI)
  set(_cpp_files ${_cpp_files} "gapi/gapi.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_gapi)
endif ()

# highgui
if (DARTCV_WITH_HIGHGUI)
  set(_cpp_files ${_cpp_files} "highgui/highgui.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_highgui opencv_imgproc ${FFMPEG_LIBRARIES})
endif ()

# imgcodecs
if (DARTCV_WITH_IMGCODECS)
  set(_cpp_files ${_cpp_files} "imgcodecs/imgcodecs.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgcodecs opencv_imgproc)
endif ()

# imgproc
if (DARTCV_WITH_IMGPROC)
  set(_cpp_files ${_cpp_files} "imgproc/imgproc.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgproc)
endif ()

# objdetect
if (DARTCV_WITH_OBJDETECT)
  set(_cpp_files ${_cpp_files} "objdetect/objdetect.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_objdetect opencv_imgproc opencv_calib3d)
endif ()

# photo
if (DARTCV_WITH_PHOTO)
  set(_cpp_files ${_cpp_files} "photo/photo.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_photo opencv_imgproc)
endif ()

# stitching
if (DARTCV_WITH_STITCHING)
  set(_cpp_files ${_cpp_files} "stitching/stitching.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_stitching opencv_imgproc opencv_features2d opencv_calib3d opencv_flann)
endif ()

# video
if (DARTCV_WITH_VIDEO)
  set(_cpp_files ${_cpp_files} "video/video.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_video opencv_imgproc)
endif ()

# videoio
if (DARTCV_WITH_VIDEOIO)
  set(_cpp_files ${_cpp_files} "videoio/videoio.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_videoio opencv_imgproc opencv_imgcodecs ${FFMPEG_LIBRARIES})
endif ()

# contrib-aruco
if (DARTCV_WITH_ARUCO)
  set(_cpp_files ${_cpp_files} "contrib/aruco.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_aruco opencv_imgproc opencv_calib3d opencv_objdetect)
endif ()

# contrib-img_hash
if (DARTCV_WITH_IMG_HASH)
  set(_cpp_files ${_cpp_files} "contrib/img_hash.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_img_hash opencv_imgproc)
endif ()

# contrib-quality
if (DARTCV_WITH_QUALITY)
  set(_cpp_files ${_cpp_files} "contrib/quality.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_quality opencv_imgproc opencv_ml)
endif ()

# contrib-wechat_qrcode
if (DARTCV_WITH_WECHAT_QRCODE)
  set(_cpp_files ${_cpp_files} "contrib/wechat_qrcode.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_wechat_qrcode opencv_imgproc opencv_objdetect opencv_dnn)
endif ()

# contrib-ximgproc
if (DARTCV_WITH_XIMGPROC)
  set(_cpp_files ${_cpp_files} "contrib/ximgproc.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_ximgproc opencv_imgproc opencv_calib3d opencv_imgcodecs opencv_video)
endif ()

# contrib-xobjdetect
if (DARTCV_WITH_XOBJDETECT)
  set(_cpp_files ${_cpp_files} "contrib/xobjdetect.cpp")
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_xobjdetect opencv_imgproc opencv_objdetect opencv_imgcodecs)
endif ()

if (DARTCV_WITH_FFMPEG)
  foreach (_tgt ${FFMPEG_LIBRARIES})
    set_target_properties(${_tgt} PROPERTIES
      BUILD_RPATH_USE_ORIGIN TRUE
      LINK_FLAGS "-Wl,-rpath,\$ORIGIN/lib"
    )
  endforeach ()
endif ()

foreach (_cpp_file IN LISTS _cpp_files)
  string(REGEX REPLACE "\\.cpp$" ".h" _header_file ${_cpp_file})
  list(APPEND _header_files ${_header_file})
endforeach ()

if (APPLE AND (NOT IOS) AND DARTCV_WITH_FFMPEG)
  set(DARTCV_DEPS ${DARTCV_DEPS} ${FFMPEG_LIBRARIES})
endif ()

# ##############################################################################
# Add library
# ##############################################################################

# provide include dir for other libs that depend on this one
if(NOT DEFINED DARTCV_DEP_INCLUDE_DIRS)
  set(DARTCV_DEP_INCLUDE_DIRS ${OpenCV_INCLUDE_DIRS})
endif()
set(dartcv_INCLUDE_DIR ${CMAKE_CURRENT_SOURCE_DIR} PARENT_SCOPE)

add_library(${LIBRARY_NAME} SHARED ${_cpp_files} ${_header_files})
target_include_directories(${LIBRARY_NAME} SYSTEM PUBLIC
  ${CMAKE_CURRENT_SOURCE_DIR}
  ${DARTCV_INCLUDE_DIRS}
  ${DARTCV_DEP_INCLUDE_DIRS}
)
message(STATUS "Added library: ${LIBRARY_NAME}")
set_target_properties(${LIBRARY_NAME} PROPERTIES
  OUTPUT_NAME ${LIBRARY_NAME}
  CXX_VISIBILITY_PRESET default
  C_VISIBILITY_PRESET default
)

if (UNIX AND NOT APPLE)
  set_target_properties(${LIBRARY_NAME} PROPERTIES
    BUILD_WITH_INSTALL_RPATH FALSE
    BUILD_RPATH "\$ORIGIN"
    INSTALL_RPATH "\$ORIGIN"
  )
elseif (APPLE)
  set_target_properties(${LIBRARY_NAME} PROPERTIES
    BUILD_WITH_INSTALL_RPATH FALSE
    BUILD_RPATH "@loader_path"
    INSTALL_RPATH "@loader_path"
  )
endif ()

list(REMOVE_DUPLICATES DARTCV_DEPS)
list(REMOVE_DUPLICATES DARTCV_DEP_INCLUDE_DIRS)
message(STATUS "DARTCV_DEPS: ${DARTCV_DEPS}")
message(STATUS "PLATFORM_LIBS: ${PLATFORM_LIBS}")
message(DEBUG "DARTCV_DEP_INCLUDE_DIRS: ${DARTCV_DEP_INCLUDE_DIRS}")
target_link_libraries(${LIBRARY_NAME} PUBLIC ${DARTCV_DEPS} ${PLATFORM_LIBS})
if (ANDROID)
  target_link_options(${LIBRARY_NAME} PRIVATE "-Wl,-z,max-page-size=16384")
endif ()

# if (APPLE)
#     message(STATUS "XCODE_VERSION: ${XCODE_VERSION}")
#     target_link_options(${LIBRARY_NAME} PRIVATE "LINKER:-ld_classic")
# endif (APPLE)

if (WIN32)
  set_target_properties(${LIBRARY_NAME} PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  #  if (BUILD_WITH_STATIC_CRT)
  #    target_compile_options(${LIBRARY_NAME} PRIVATE "/MT")
  #  endif ()
endif (WIN32)

target_compile_definitions(${LIBRARY_NAME} PUBLIC DART_SHARED_LIB)
