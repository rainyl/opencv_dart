# OpenCV build options based on options.txt
# This file contains all the OpenCV build options and configurations

# Image format support
set(BUILD_ZLIB ON CACHE BOOL "Build ZLIB")
set(BUILD_TIFF ON CACHE BOOL "Build TIFF")
set(BUILD_OPENJPEG ON CACHE BOOL "Build OpenJPEG")
set(BUILD_JASPER OFF CACHE BOOL "Build JASPER")
set(BUILD_JPEG ON CACHE BOOL "Build JPEG")
set(BUILD_PNG ON CACHE BOOL "Build PNG")
set(BUILD_WEBP ON CACHE BOOL "Build WebP")
set(BUILD_OPENEXR OFF CACHE BOOL "Build OpenEXR")

# Third-party libraries
set(BUILD_TBB OFF CACHE BOOL "Build TBB")
set(BUILD_ITT OFF CACHE BOOL "Build ITT")
set(WITH_ADE OFF CACHE BOOL "Use ADE")
set(WITH_VTK OFF CACHE BOOL "Use VTK")
set(WITH_LAPACK OFF CACHE BOOL "Use LAPACK")
set(WITH_FFMPEG OFF CACHE BOOL "Use FFmpeg")

# Hardware acceleration and parallel processing
set(WITH_VULKAN ON CACHE BOOL "Use Vulkan")
set(WITH_OPENCL ON CACHE BOOL "Use OpenCL")
set(WITH_OPENCL_SVM OFF CACHE BOOL "Use OpenCL SVM")
set(WITH_OPENCLAMDBLAS OFF CACHE BOOL "Use OpenCL AMD BLAS")
set(WITH_OPENCLAMDFFT OFF CACHE BOOL "Use OpenCL AMD FFT")

# Image codec support
set(WITH_OPENJPEG ON CACHE BOOL "Use OpenJPEG")
set(WITH_JPEG ON CACHE BOOL "Use JPEG")
set(WITH_WEBP ON CACHE BOOL "Use WebP")
set(WITH_OPENEXR OFF CACHE BOOL "Use OpenEXR")
set(WITH_PNG ON CACHE BOOL "Use PNG")
set(WITH_TIFF ON CACHE BOOL "Use TIFF")
set(WITH_AVIF OFF CACHE BOOL "Use AVIF")
set(WITH_IMGCODEC_HDR ON CACHE BOOL "Use HDR image codec")
set(WITH_IMGCODEC_SUNRASTER ON CACHE BOOL "Use Sun Raster image codec")
set(WITH_IMGCODEC_PXM ON CACHE BOOL "Use PXM image codec")
set(WITH_IMGCODEC_PFM ON CACHE BOOL "Use PFM image codec")

# Additional features
set(WITH_PROTOBUF ON CACHE BOOL "Use Protobuf")
set(WITH_QUIRC ON CACHE BOOL "Use QUIRC")

# Build configuration
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries")
set(BUILD_opencv_apps OFF CACHE BOOL "Build OpenCV apps")
set(BUILD_ANDROID_PROJECTS OFF CACHE BOOL "Build Android projects")
set(BUILD_ANDROID_EXAMPLES OFF CACHE BOOL "Build Android examples")
set(BUILD_DOCS OFF CACHE BOOL "Build documentation")
set(BUILD_EXAMPLES OFF CACHE BOOL "Build examples")
set(BUILD_PACKAGE OFF CACHE BOOL "Build package")
set(BUILD_PERF_TESTS OFF CACHE BOOL "Build performance tests")
set(BUILD_TESTS OFF CACHE BOOL "Build tests")
set(BUILD_FAT_JAVA_LIB OFF CACHE BOOL "Build fat Java library")
set(BUILD_JAVA OFF CACHE BOOL "Build Java bindings")
set(BUILD_OBJC OFF CACHE BOOL "Build Objective-C bindings")
set(BUILD_KOTLIN_EXTENSIONS OFF CACHE BOOL "Build Kotlin extensions")
set(ENABLE_PRECOMPILED_HEADERS OFF CACHE BOOL "Enable precompiled headers")

# Disable features not needed
set(OPENCV_ENABLE_NONFREE OFF CACHE BOOL "Enable non-free algorithms")
set(WITH_CUDA OFF CACHE BOOL "Disable CUDA support")
set(WITH_TBB OFF CACHE BOOL "Disable TBB support")
set(WITH_IPP OFF CACHE BOOL "Disable IPP support")
set(WITH_EIGEN OFF CACHE BOOL "Disable Eigen support")
set(WITH_V4L OFF CACHE BOOL "Disable V4L support")
set(WITH_GTK OFF CACHE BOOL "Disable GTK support")
set(WITH_QT OFF CACHE BOOL "Disable Qt support")
set(WITH_OPENGL OFF CACHE BOOL "Disable OpenGL support")
set(WITH_OPENMP OFF CACHE BOOL "Disable OpenMP support")
set(WITH_OBSENSOR OFF CACHE BOOL "Disable OBSENSOR support")
set(WITH_VA OFF CACHE BOOL "Disable VA support")
set(WITH_VA_INTEL OFF CACHE BOOL "Disable VA Intel support")
set(WITH_ITT OFF CACHE BOOL "Disable ITT support")
set(WITH_OPENVX OFF CACHE BOOL "Disable OpenVX support")
set(WITH_GDCM OFF CACHE BOOL "Disable GDCM support")
set(WITH_HPX OFF CACHE BOOL "Disable HPX support")
set(WITH_CLP OFF CACHE BOOL "Disable CLP support")
set(WITH_HALIDE OFF CACHE BOOL "Disable Halide support")
set(WITH_INF_ENGINE OFF CACHE BOOL "Disable Inference Engine support")


# module dependencies
#   aruco: core imgproc calib3d objdetect
#   calib3d: flann imgproc features2d
#   dnn: imgproc
#   features2d: imgproc
#   flann: core
#   freetype: imgproc
#   highgui: imgproc
#   img_hash: imgproc core
#   imgcodecs: imgproc
#   imgproc: core
#   objdetect: core imgproc calib3d
#   photo: imgproc
#   quality: core imgproc ml
#   stitching: imgproc features2d calib3d flann
#   video: imgproc
#   videoio: imgproc imgcodecs
#   wechat_qrcode: core imgproc objdetect dnn
#   xfeatures2d: core imgproc features2d calib3d
#   ximgproc: core imgproc calib3d imgcodecs video
#   xobjdetect: core imgproc objdetect imgcodecs
#   xphoto: core imgproc photo

#   bgsegm: core imgproc video
#   bioinspired: core
#   ccalib: core imgproc calib3d features2d highgui imgcodecs
#   datasets: core imgcodecs ml flann
#   dnn_objdetect: core imgproc dnn
#   dnn_superres: core imgproc dnn
#   dpm: core imgproc objdetect
#   face: core imgproc objdetect calib3d photo
#   fuzzy: imgproc core
#   hfs: core imgproc
#   intensity_transform: core imgproc
#   line_descriptor: imgproc
#   mcc: core imgproc calib3d dnn
#   ml: core
#   optflow: core imgproc calib3d video ximgproc imgcodecs flann
#   unwrapping: core imgproc
#   plot: core imgproc
#   rapid: core imgproc calib3d
#   reg: imgproc core
#   rgbd: core calib3d imgproc
#   saliency: imgproc features2d
#   shape: core imgproc calib3d
#   signal: core
#   stereo: imgproc features2d core tracking
#   light: core imgproc calib3d phase_unwrapping
#   superres: imgproc video optflow
#   surface_matching: core flann
#   text: ml imgproc core features2d dnn
#   tracking: imgproc core video plot
#   videostab: imgproc features2d video photo calib3d

# Core modules
set(BUILD_opencv_core ON CACHE BOOL "Build core module" FORCE)
set(BUILD_opencv_gapi ${DARTCV_WITH_GAPI} CACHE BOOL "Build gapi module" FORCE)
set(BUILD_opencv_world OFF CACHE BOOL "Build all modules into world module" FORCE)
set(BUILD_opencv_ml ${DARTCV_WITH_ML} CACHE BOOL "Build ml module" FORCE)
set(BUILD_opencv_imgproc ${DARTCV_WITH_IMGPROC} CACHE BOOL "Build imgproc module" FORCE)

if (DARTCV_WITH_CALIB3D)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_flann ON CACHE BOOL "Build flann module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
endif ()

if (DARTCV_WITH_IMGCODECS)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_FEATURES2D)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

set(BUILD_opencv_flann (${DARTCV_WITH_FLANN} OR ${DARTCV_WITH_FEATURES2D}) CACHE BOOL "Build flann module" FORCE)

if (DARTCV_WITH_DNN)
  set(BUILD_opencv_dnn ON CACHE BOOL "Build dnn module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_HIGHGUI)
  set(BUILD_opencv_highgui ON CACHE BOOL "Build highgui module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_OBJDETECT)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
endif ()

if (DARTCV_WITH_PHOTO)
  set(BUILD_opencv_photo ON CACHE BOOL "Build photo module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_STITCHING)
  set(BUILD_opencv_stitching ON CACHE BOOL "Build stitching module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_flann ON CACHE BOOL "Build flann module" FORCE)
endif ()

if (DARTCV_WITH_VIDEO)
  set(BUILD_opencv_video ON CACHE BOOL "Build video module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_VIDEOIO)
  set(BUILD_opencv_videoio ON CACHE BOOL "Build videoio module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
endif ()

# Contrib modules
if (DARTCV_WITH_ARUCO)
  set(BUILD_opencv_aruco ON CACHE BOOL "Build aruco module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
endif ()

if (DARTCV_WITH_IMG_HASH)
  set(BUILD_opencv_img_hash ON CACHE BOOL "Build img_hash module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif ()

if (DARTCV_WITH_QUALITY)
  set(BUILD_opencv_quality ON CACHE BOOL "Build quality module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_ml ON CACHE BOOL "Build ml module" FORCE)
endif ()

if (DARTCV_WITH_WECHAT_QRCODE)
  set(BUILD_opencv_wechat_qrcode ON CACHE BOOL "Build wechat_qrcode module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_dnn ON CACHE BOOL "Build dnn module" FORCE)
endif ()

if (DARTCV_WITH_XIMGPROC)
  set(BUILD_opencv_ximgproc ON CACHE BOOL "Build ximgproc module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
  set(BUILD_opencv_video ON CACHE BOOL "Build video module" FORCE)
endif ()

if (DARTCV_WITH_XOBJDETECT)
  set(BUILD_opencv_xobjdetect ON CACHE BOOL "Build xobjdetect module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
endif ()

# not implemented
set(BUILD_opencv_xphoto OFF CACHE BOOL "Build xphoto module" FORCE)
#if (DARTCV_WITH_XPHOTO)
#  set(BUILD_opencv_xphoto ON CACHE BOOL "Build xphoto module" FORCE)
#  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
#  set(BUILD_opencv_photo ON CACHE BOOL "Build photo module" FORCE)
#endif ()

# Unsupported modules
set(BUILD_opencv_bgsegm OFF CACHE BOOL "Build bgsegm module")
set(BUILD_opencv_bioinspired OFF CACHE BOOL "Build bioinspired module")
set(BUILD_opencv_ccalib OFF CACHE BOOL "Build ccalib module")
set(BUILD_opencv_dnn_objdetect OFF CACHE BOOL "Build dnn_objdetect module")
set(BUILD_opencv_dnn_superres OFF CACHE BOOL "Build dnn_superres module")
set(BUILD_opencv_dpm OFF CACHE BOOL "Build dpm module")
set(BUILD_opencv_face OFF CACHE BOOL "Build face module")
set(BUILD_opencv_fuzzy OFF CACHE BOOL "Build fuzzy module")
set(BUILD_opencv_hfs OFF CACHE BOOL "Build hfs module")
set(BUILD_opencv_intensity_transform OFF CACHE BOOL "Build intensity_transform module")
set(BUILD_opencv_line_descriptor OFF CACHE BOOL "Build line_descriptor module")
set(BUILD_opencv_mcc OFF CACHE BOOL "Build mcc module")
set(BUILD_opencv_optflow OFF CACHE BOOL "Build optflow module")
set(BUILD_opencv_phase_unwrapping OFF CACHE BOOL "Build phase_unwrapping module")
set(BUILD_opencv_plot OFF CACHE BOOL "Build plot module")
set(BUILD_opencv_rapid OFF CACHE BOOL "Build rapid module")
set(BUILD_opencv_reg OFF CACHE BOOL "Build reg module")
set(BUILD_opencv_rgbd OFF CACHE BOOL "Build rgbd module")
set(BUILD_opencv_saliency OFF CACHE BOOL "Build saliency module")
set(BUILD_opencv_shape OFF CACHE BOOL "Build shape module")
set(BUILD_opencv_signal OFF CACHE BOOL "Build signal module")
set(BUILD_opencv_stereo OFF CACHE BOOL "Build stereo module")
set(BUILD_opencv_structured_light OFF CACHE BOOL "Build structured_light module")
set(BUILD_opencv_superres OFF CACHE BOOL "Build superres module")
set(BUILD_opencv_surface_matching OFF CACHE BOOL "Build surface_matching module")
set(BUILD_opencv_tracking OFF CACHE BOOL "Build tracking module")
set(BUILD_opencv_videostab OFF CACHE BOOL "Build videostab module")
set(BUILD_opencv_xfeatures2d OFF CACHE BOOL "Build xfeatures2d module")
set(BUILD_opencv_alphamat OFF CACHE BOOL "Build alphamat module")
set(BUILD_opencv_cannops OFF CACHE BOOL "Build cannops module")
set(BUILD_opencv_cudaarithm OFF CACHE BOOL "Build cudaarithm module")
set(BUILD_opencv_cudabgsegm OFF CACHE BOOL "Build cudabgsegm module")
set(BUILD_opencv_cudacodec OFF CACHE BOOL "Build cudacodec module")
set(BUILD_opencv_cudafeatures2d OFF CACHE BOOL "Build cudafeatures2d module")
set(BUILD_opencv_cudafilters OFF CACHE BOOL "Build cudafilters module")
set(BUILD_opencv_cudaimgproc OFF CACHE BOOL "Build cudaimgproc module")
set(BUILD_opencv_cudalegacy OFF CACHE BOOL "Build cudalegacy module")
set(BUILD_opencv_cudaobjdetect OFF CACHE BOOL "Build cudaobjdetect module")
set(BUILD_opencv_cudaoptflow OFF CACHE BOOL "Build cudaoptflow module")
set(BUILD_opencv_cudastereo OFF CACHE BOOL "Build cudastereo module")
set(BUILD_opencv_cudawarping OFF CACHE BOOL "Build cudawarping module")
set(BUILD_opencv_cudev OFF CACHE BOOL "Build cudev module")
set(BUILD_opencv_cvv OFF CACHE BOOL "Build cvv module")
set(BUILD_opencv_freetype OFF CACHE BOOL "Build freetype module")
set(BUILD_opencv_hdf OFF CACHE BOOL "Build hdf module")
set(BUILD_opencv_java OFF CACHE BOOL "Build java module")
#set(BUILD_opencv_java_bindings_generator OFF CACHE BOOL "Build java_bindings_generator module")
set(BUILD_opencv_objc OFF CACHE BOOL "Build objc module")
#set(BUILD_opencv_objc_bindings_generator OFF CACHE BOOL "Build objc_bindings_generator module")
set(BUILD_opencv_js OFF CACHE BOOL "Build js module")
#set(BUILD_opencv_js_bindings_generator OFF CACHE BOOL "Build js_bindings_generator module")
set(BUILD_opencv_ts OFF CACHE BOOL "Build ts module")
set(BUILD_opencv_python2 OFF CACHE BOOL "Build python2 module")
set(BUILD_opencv_python3 OFF CACHE BOOL "Build python3 module")
#set(BUILD_opencv_python_bindings_generator OFF CACHE BOOL "Build python_bindings_generator module")
#set(BUILD_opencv_python_tests OFF CACHE BOOL "Build python_test module")
set(BUILD_opencv_julia OFF CACHE BOOL "Build julia module")
set(BUILD_opencv_matlab OFF CACHE BOOL "Build matlab module")
set(BUILD_opencv_ovis OFF CACHE BOOL "Build ovis module")
set(BUILD_opencv_sfm OFF CACHE BOOL "Build sfm module")
set(BUILD_opencv_viz OFF CACHE BOOL "Build viz module")
