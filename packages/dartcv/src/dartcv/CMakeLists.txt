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

# ml
if (DARTCV_WITH_ML)
  set(_cpp_files ${_cpp_files}
    "ml/ann_mlp.cpp"
    "ml/boost.cpp"
    "ml/dtrees.cpp"
    "ml/em.cpp"
    "ml/knearest.cpp"
    "ml/logistic_regression.cpp"
    "ml/normal_bayes_classifier.cpp"
    "ml/rtrees.cpp"
    "ml/svm.cpp"
    "ml/svmsgd.cpp"
    "ml/train_data.cpp"
  )
  set(DARTCV_DEPS ${DARTCV_DEPS} opencv_ml)
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

# Under Emscripten the wrapper is never a shared library: `tool/web/build_wasm.dart` links it
# into the `dartcv_wasm` executable together with OpenCV's static libraries, and only the exports
# listed in `DARTCV_WASM_EXPORTS` survive. Making it an OBJECT library here keeps a single compile
# for both, and the deprecated shell scripts (they build the `dartcv` target and glob its objects,
# whose paths do not change) keep working.
if (EMSCRIPTEN)
  add_library(${LIBRARY_NAME} OBJECT ${_cpp_files} ${_header_files})
else ()
  add_library(${LIBRARY_NAME} SHARED ${_cpp_files} ${_header_files})
endif ()
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

set(_link_flags "")
if (DARTCV_TREESHAKE)
  if (MSVC)
    # /Gy: function-level linking; /OPT:REF: remove unreferenced; /OPT:ICF: merge identical COMDATs.
    target_compile_options(${LIBRARY_NAME} PRIVATE /Gy)
    string(APPEND _link_flags " /OPT:REF /OPT:ICF")
  elseif (APPLE)
    target_compile_options(${LIBRARY_NAME} PRIVATE -ffunction-sections -fdata-sections)
    string(APPEND _link_flags " -Wl,-dead_strip")
  else ()
    target_compile_options(${LIBRARY_NAME} PRIVATE -ffunction-sections -fdata-sections)
    string(APPEND _link_flags " -Wl,--gc-sections")
  endif ()
endif ()

if (_link_flags)
  set_target_properties(${LIBRARY_NAME} PROPERTIES LINK_FLAGS "${_link_flags}")
endif ()

if (UNIX AND NOT APPLE AND NOT EMSCRIPTEN)
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

# ---------------------------------------------------------------------------
# WebAssembly module (Emscripten)
# ---------------------------------------------------------------------------
# The module is a *main* module that carries OpenCV and the wrapper, not a dylink side module:
# the objects of ${LIBRARY_NAME} and the OpenCV static libraries are linked into one executable
# and only the exports in DARTCV_WASM_EXPORTS remain callable from Dart.
#
# Only added when the caller can supply the export list (`tool/web/build_wasm.dart` always does),
# so a plain `emcmake cmake` - and the deprecated scripts, which do their own linking - still
# configure and build only the objects.
if (EMSCRIPTEN)
  if (NOT DARTCV_WASM_EXPORTS)
    message(STATUS "DARTCV_WASM_EXPORTS not set: building the objects only, no dartcv_wasm target")
  else ()
    add_executable(dartcv_wasm $<TARGET_OBJECTS:${LIBRARY_NAME}>)
    # An OBJECT library does not link, so the dependencies are repeated here.
    target_link_libraries(dartcv_wasm PRIVATE ${DARTCV_DEPS} ${PLATFORM_LIBS})
    target_link_options(dartcv_wasm PRIVATE
      # A *response file for emcc*, whose lines are `-Wl,--export-if-defined=cv_...`:
      # `-sEXPORTED_FUNCTIONS` cannot be read from a file without failing on the symbols of modules
      # that were not built, and `-Wl,@file` is expanded by emcc itself, which then feeds the flags
      # to the compiler instead of the linker.
      "@${DARTCV_WASM_EXPORTS}"
      # malloc/free come from Emscripten, not from the wrapper, and `--export-if-defined` does not
      # reach them, so they stay in the setting (which is where its `_`-prefixed names belong).
      "-sEXPORTED_FUNCTIONS=_malloc,_free"
      # There is no main(); lib/src/web/runtime.dart looks the wrapper's functions up as
      # `Module['_cv_...']`, which needs the exports and nothing else.
      "--no-entry"
      "-sMODULARIZE=1"
      "-sEXPORT_ES6=1"
      "-sEXPORT_NAME=createDartcvModule"
      "-sENVIRONMENT=web,worker,node"
      # ximgproc's EdgeDrawing keeps 64 MB of static lookup tables (zero-initialised, so they are
      # not in the .wasm file), hence the large initial memory.
      "-sINITIAL_MEMORY=96MB"
      "-sSTACK_SIZE=1MB"
      "-sALLOW_MEMORY_GROWTH=1"
      "-sALLOW_TABLE_GROWTH=1"
      "-sFORCE_FILESYSTEM=1"
      "-sEXPORTED_RUNTIME_METHODS=HEAPU8,wasmMemory,addFunction,removeFunction,FS"
      "-sERROR_ON_UNDEFINED_SYMBOLS=1"
    )
    # `target_link_options` does not make the link depend on that file, and the export list changes
    # whenever a binding does: without LINK_DEPENDS ninja would happily ship the previous module.
    set_target_properties(dartcv_wasm PROPERTIES LINK_DEPENDS "${DARTCV_WASM_EXPORTS}")
    # The builder collects `<name>.js`/`<name>.wasm`, and the runtime loads `dartcv.js`.
    set_target_properties(dartcv_wasm PROPERTIES OUTPUT_NAME ${LIBRARY_NAME})
    message(STATUS "Added WebAssembly module: dartcv_wasm -> ${LIBRARY_NAME}.js")
  endif ()
endif ()

# if (APPLE)
#     message(STATUS "XCODE_VERSION: ${XCODE_VERSION}")
#     target_link_options(${LIBRARY_NAME} PRIVATE "LINKER:-ld_classic")
# endif (APPLE)

if (WIN32)
  # The shared library exports everything (the tree-shaken variant is linked by
  # `hook/link.dart`, which passes its own .def).
  set_target_properties(${LIBRARY_NAME} PROPERTIES
    WINDOWS_EXPORT_ALL_SYMBOLS ON
    COMPILE_FLAGS "/EHsc"
  )

  #  if (BUILD_WITH_STATIC_CRT)
  #    target_compile_options(${LIBRARY_NAME} PRIVATE "/MT")
  #  endif ()
endif (WIN32)

target_compile_definitions(${LIBRARY_NAME} PUBLIC DART_SHARED_LIB)

# The tree-shaken variant of the library. It is added last, once ${LIBRARY_NAME}
# has all its compile and link settings: `dntcm_add_treeshake_target` mirrors them.
# It is a native-assets/AOT concern only; the web module is trimmed by its export list instead.
if (DARTCV_TREESHAKE_LINK AND NOT EMSCRIPTEN)
  if (NOT DEFINED DNTCM_CMAKE_DIR)
    message(FATAL_ERROR
      "DARTCV_TREESHAKE_LINK needs the CMake modules of package:native_toolchain_cmake. "
      "Build through hook/build.dart (it passes -DDNTCM_CMAKE_DIR) or set it yourself.")
  endif ()
  include(${DNTCM_CMAKE_DIR}/treeshake.cmake)
  dntcm_add_treeshake_target(NAME ${LIBRARY_NAME} TARGET ${LIBRARY_NAME})
endif ()
