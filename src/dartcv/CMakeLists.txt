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
        "imgcodecs/imgcodecs.cpp"
        "core/stdvec.cpp"
)
set(DARTCV_DEPS opencv_core opencv_imgcodecs)

# calib3d
if (DARTCV_WITH_CALIB3D OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "calib3d/calib3d.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_calib3d)
endif ()

# contrib
if (DARTCV_WITH_CONTRIB OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files}
            "contrib/aruco.cpp"
            "contrib/img_hash.cpp"
            "contrib/quality.cpp"
            "contrib/wechat_qrcode.cpp"
            "contrib/ximgproc.cpp"
            "contrib/xobjdetect.cpp"
    )
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_aruco opencv_img_hash opencv_quality
            opencv_wechat_qrcode opencv_ximgproc opencv_xobjdetect
    )
endif ()

# dnn
if (DARTCV_WITH_DNN OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "dnn/dnn.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_dnn)
endif ()

# features2d
if (DARTCV_WITH_FEATURES2D OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "features2d/features2d.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_features2d)
endif ()

# gapi
if (DARTCV_WITH_GAPI OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "gapi/gapi.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_gapi)
endif ()

# highgui
if (DARTCV_WITH_HIGHGUI OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "highgui/highgui.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_highgui ${FFMPEG_LIBRARIES})
endif ()

# imgproc
if (DARTCV_WITH_IMGPROC OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "imgproc/imgproc.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_imgproc)
endif ()

# video
if (DARTCV_WITH_VIDEO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "video/video.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_video)
endif ()

# objdetect
if (DARTCV_WITH_OBJDETECT OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "objdetect/objdetect.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_objdetect)
endif ()

# photo
if (DARTCV_WITH_PHOTO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "photo/photo.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_photo)
endif ()

# stitching
if (DARTCV_WITH_STITCHING OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "stitching/stitching.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_stitching)
endif ()

# videoio
if (DARTCV_WITH_VIDEOIO OR DARTCV_WORLD)
    set(_cpp_files ${_cpp_files} "videoio/videoio.cpp")
    set(DARTCV_DEPS ${DARTCV_DEPS} opencv_videoio ${FFMPEG_LIBRARIES})
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

if (APPLE)
  set(DARTCV_DEPS opencv_world opencv_img_hash)
  if ((NOT IOS) AND DARTCV_WITH_FFMPEG)
    set(DARTCV_DEPS ${DARTCV_DEPS} ${FFMPEG_LIBRARIES})
  endif ()
endif ()

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
