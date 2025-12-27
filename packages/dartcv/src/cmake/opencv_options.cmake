# OpenCV build options based on options.txt
# This file contains all the OpenCV build options and configurations

set(BUILD_ZLIB ON CACHE BOOL "Build ZLIB" FORCE)
set(BUILD_TIFF ON CACHE BOOL "Build TIFF" FORCE)
set(BUILD_OPENJPEG ON CACHE BOOL "Build OpenJPEG" FORCE)
set(BUILD_JASPER OFF CACHE BOOL "Build JASPER" FORCE)
set(BUILD_JPEG ON CACHE BOOL "Build JPEG" FORCE)
set(BUILD_PNG ON CACHE BOOL "Build PNG" FORCE)
set(BUILD_WEBP ON CACHE BOOL "Build WebP" FORCE)
set(WITH_VULKAN ON CACHE BOOL "Use Vulkan" FORCE)
set(WITH_OPENJPEG ON CACHE BOOL "Use OpenJPEG" FORCE)
set(WITH_JPEG ON CACHE BOOL "Use JPEG" FORCE)
set(WITH_WEBP ON CACHE BOOL "Use WebP" FORCE)
# Image codec support
set(WITH_OPENEXR OFF CACHE BOOL "Use OpenEXR" FORCE)
set(WITH_PNG ON CACHE BOOL "Use PNG" FORCE)
set(WITH_TIFF ON CACHE BOOL "Use TIFF" FORCE)
set(WITH_AVIF OFF CACHE BOOL "Use AVIF" FORCE)
set(WITH_IMGCODEC_HDR ON CACHE BOOL "Use HDR image codec" FORCE)
set(WITH_IMGCODEC_SUNRASTER ON CACHE BOOL "Use Sun Raster image codec" FORCE)
set(WITH_IMGCODEC_PXM ON CACHE BOOL "Use PXM image codec" FORCE)
set(WITH_IMGCODEC_PFM ON CACHE BOOL "Use PFM image codec" FORCE)
# Additional features
set(WITH_PROTOBUF ON CACHE BOOL "Use Protobuf" FORCE)
set(WITH_QUIRC ON CACHE BOOL "Use QUIRC" FORCE)

# Hardware acceleration and parallel processing
set(WITH_OPENCL ON CACHE BOOL "Use OpenCL" FORCE)
set(WITH_OPENCL_SVM OFF CACHE BOOL "Use OpenCL SVM" FORCE)
set(WITH_OPENCLAMDBLAS OFF CACHE BOOL "Use OpenCL AMD BLAS" FORCE)
set(WITH_OPENCLAMDFFT OFF CACHE BOOL "Use OpenCL AMD FFT" FORCE)


set(BUILD_OPENEXR OFF CACHE BOOL "Build OpenEXR" FORCE)
set(BUILD_IPP_IW OFF CACHE BOOL "Build IPP IW" FORCE)
set(BUILD_TBB OFF CACHE BOOL "Build TBB" FORCE)
set(BUILD_ITT OFF CACHE BOOL "Build ITT" FORCE)
set(WITH_ADE OFF CACHE BOOL "Use ADE" FORCE)
set(WITH_VTK OFF CACHE BOOL "Use VTK" FORCE)
set(WITH_LAPACK OFF CACHE BOOL "Use LAPACK" FORCE)
set(WITH_FFMPEG OFF CACHE BOOL "Use FFmpeg" FORCE)

# Build configuration
set(BUILD_SHARED_LIBS OFF CACHE BOOL "Build shared libraries" FORCE)
set(BUILD_opencv_apps OFF CACHE BOOL "Build OpenCV apps" FORCE)
set(BUILD_ANDROID_PROJECTS OFF CACHE BOOL "Build Android projects" FORCE)
set(BUILD_ANDROID_EXAMPLES OFF CACHE BOOL "Build Android examples" FORCE)
set(BUILD_DOCS OFF CACHE BOOL "Build documentation" FORCE)
set(BUILD_EXAMPLES OFF CACHE BOOL "Build examples" FORCE)
set(BUILD_PACKAGE OFF CACHE BOOL "Build package" FORCE)
set(BUILD_PERF_TESTS OFF CACHE BOOL "Build performance tests" FORCE)
set(BUILD_TESTS OFF CACHE BOOL "Build tests" FORCE)
set(BUILD_FAT_JAVA_LIB OFF CACHE BOOL "Build fat Java library" FORCE)
set(BUILD_JAVA OFF CACHE BOOL "Build Java bindings" FORCE)
set(BUILD_OBJC OFF CACHE BOOL "Build Objective-C bindings" FORCE)
set(BUILD_KOTLIN_EXTENSIONS OFF CACHE BOOL "Build Kotlin extensions" FORCE)
set(ENABLE_PRECOMPILED_HEADERS OFF CACHE BOOL "Enable precompiled headers" FORCE)

# Disable features not needed
set(OPENCV_ENABLE_NONFREE OFF CACHE BOOL "Enable non-free algorithms" FORCE)
set(WITH_CUDA OFF CACHE BOOL "Disable CUDA support" FORCE)
set(WITH_TBB OFF CACHE BOOL "Disable TBB support" FORCE)
set(WITH_IPP OFF CACHE BOOL "Disable IPP support" FORCE)
set(WITH_EIGEN OFF CACHE BOOL "Disable Eigen support" FORCE)
set(WITH_V4L OFF CACHE BOOL "Disable V4L support" FORCE)
set(WITH_GTK OFF CACHE BOOL "Disable GTK support" FORCE)
set(WITH_QT OFF CACHE BOOL "Disable Qt support" FORCE)
set(WITH_OPENGL OFF CACHE BOOL "Disable OpenGL support" FORCE)
set(WITH_OPENMP OFF CACHE BOOL "Disable OpenMP support" FORCE)
set(WITH_OBSENSOR OFF CACHE BOOL "Disable OBSENSOR support" FORCE)
set(WITH_VA OFF CACHE BOOL "Disable VA support" FORCE)
set(WITH_VA_INTEL OFF CACHE BOOL "Disable VA Intel support" FORCE)
set(WITH_ITT OFF CACHE BOOL "Disable ITT support" FORCE)
set(WITH_OPENVX OFF CACHE BOOL "Disable OpenVX support" FORCE)
set(WITH_GDCM OFF CACHE BOOL "Disable GDCM support" FORCE)
set(WITH_HPX OFF CACHE BOOL "Disable HPX support" FORCE)
set(WITH_CLP OFF CACHE BOOL "Disable CLP support" FORCE)
set(WITH_HALIDE OFF CACHE BOOL "Disable Halide support" FORCE)
set(WITH_INF_ENGINE OFF CACHE BOOL "Disable Inference Engine support" FORCE)

# Core modules
set(BUILD_opencv_core ON CACHE BOOL "Build core module" FORCE)
set(BUILD_opencv_world OFF CACHE BOOL "Build all modules into world module" FORCE)
set(BUILD_opencv_imgproc ${DARTCV_WITH_IMGPROC} CACHE BOOL "Build imgproc module" FORCE)
set(BUILD_opencv_gapi ${DARTCV_WITH_GAPI} CACHE BOOL "Build gapi module" FORCE)
set(BUILD_opencv_ml ${DARTCV_WITH_ML} CACHE BOOL "Build ml module" FORCE)
set(BUILD_opencv_flann (${DARTCV_WITH_FLANN} OR ${DARTCV_WITH_FEATURES2D}) CACHE BOOL "Build flann module" FORCE)

if(DARTCV_WITH_CALIB3D)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_flann ON CACHE BOOL "Build flann module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
endif()

if(DARTCV_WITH_IMGCODECS)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_DNN)
  set(BUILD_opencv_dnn ON CACHE BOOL "Build dnn module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_STITCHING)
  set(BUILD_opencv_stitching ON CACHE BOOL "Build stitching module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_flann ON CACHE BOOL "Build flann module" FORCE)
endif()

if(DARTCV_WITH_VIDEOIO)
  set(BUILD_opencv_videoio ON CACHE BOOL "Build videoio module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
endif()

if(DARTCV_WITH_OBJDETECT)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
endif()

if(DARTCV_WITH_FEATURES2D)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_HIGHGUI)
  set(BUILD_opencv_highgui ON CACHE BOOL "Build highgui module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_PHOTO)
  set(BUILD_opencv_photo ON CACHE BOOL "Build photo module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_VIDEO)
  set(BUILD_opencv_video ON CACHE BOOL "Build video module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

# Contrib modules
if(DARTCV_WITH_ARUCO)
  set(BUILD_opencv_aruco ON CACHE BOOL "Build aruco module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_features2d ON CACHE BOOL "Build features2d module" FORCE)
endif()

if(DARTCV_WITH_IMG_HASH)
  set(BUILD_opencv_img_hash ON CACHE BOOL "Build img_hash module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
endif()

if(DARTCV_WITH_QUALITY)
  set(BUILD_opencv_quality ON CACHE BOOL "Build quality module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_ml ON CACHE BOOL "Build ml module" FORCE)
endif()

if(DARTCV_WITH_WECHAT_QRCODE)
  set(BUILD_opencv_wechat_qrcode ON CACHE BOOL "Build wechat_qrcode module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_dnn ON CACHE BOOL "Build dnn module" FORCE)
endif()

if(DARTCV_WITH_XIMGPROC)
  set(BUILD_opencv_ximgproc ON CACHE BOOL "Build ximgproc module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_calib3d ON CACHE BOOL "Build calib3d module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
  set(BUILD_opencv_video ON CACHE BOOL "Build video module" FORCE)
endif()

if(DARTCV_WITH_XOBJDETECT)
  set(BUILD_opencv_xobjdetect ON CACHE BOOL "Build xobjdetect module" FORCE)
  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
  set(BUILD_opencv_objdetect ON CACHE BOOL "Build objdetect module" FORCE)
  set(BUILD_opencv_imgcodecs ON CACHE BOOL "Build imgcodecs module" FORCE)
endif()

# not implemented
set(BUILD_opencv_xphoto OFF CACHE BOOL "Build xphoto module" FORCE)
#if (DARTCV_WITH_XPHOTO)
#  set(BUILD_opencv_xphoto ON CACHE BOOL "Build xphoto module" FORCE)
#  set(BUILD_opencv_imgproc ON CACHE BOOL "Build imgproc module" FORCE)
#  set(BUILD_opencv_photo ON CACHE BOOL "Build photo module" FORCE)
#endif ()

# Unsupported modules
set(BUILD_opencv_bgsegm OFF CACHE BOOL "Build bgsegm module" FORCE)
set(BUILD_opencv_bioinspired OFF CACHE BOOL "Build bioinspired module" FORCE)
set(BUILD_opencv_ccalib OFF CACHE BOOL "Build ccalib module" FORCE)
set(BUILD_opencv_dnn_objdetect OFF CACHE BOOL "Build dnn_objdetect module" FORCE)
set(BUILD_opencv_dnn_superres OFF CACHE BOOL "Build dnn_superres module" FORCE)
set(BUILD_opencv_dpm OFF CACHE BOOL "Build dpm module" FORCE)
set(BUILD_opencv_face OFF CACHE BOOL "Build face module" FORCE)
set(BUILD_opencv_fuzzy OFF CACHE BOOL "Build fuzzy module" FORCE)
set(BUILD_opencv_hfs OFF CACHE BOOL "Build hfs module" FORCE)
set(BUILD_opencv_intensity_transform OFF CACHE BOOL "Build intensity_transform module" FORCE)
set(BUILD_opencv_line_descriptor OFF CACHE BOOL "Build line_descriptor module" FORCE)
set(BUILD_opencv_mcc OFF CACHE BOOL "Build mcc module" FORCE)
set(BUILD_opencv_optflow OFF CACHE BOOL "Build optflow module" FORCE)
set(BUILD_opencv_phase_unwrapping OFF CACHE BOOL "Build phase_unwrapping module" FORCE)
set(BUILD_opencv_plot OFF CACHE BOOL "Build plot module" FORCE)
set(BUILD_opencv_rapid OFF CACHE BOOL "Build rapid module" FORCE)
set(BUILD_opencv_reg OFF CACHE BOOL "Build reg module" FORCE)
set(BUILD_opencv_rgbd OFF CACHE BOOL "Build rgbd module" FORCE)
set(BUILD_opencv_saliency OFF CACHE BOOL "Build saliency module" FORCE)
set(BUILD_opencv_shape OFF CACHE BOOL "Build shape module" FORCE)
set(BUILD_opencv_signal OFF CACHE BOOL "Build signal module" FORCE)
set(BUILD_opencv_stereo OFF CACHE BOOL "Build stereo module" FORCE)
set(BUILD_opencv_structured_light OFF CACHE BOOL "Build structured_light module" FORCE)
set(BUILD_opencv_superres OFF CACHE BOOL "Build superres module" FORCE)
set(BUILD_opencv_surface_matching OFF CACHE BOOL "Build surface_matching module" FORCE)
set(BUILD_opencv_tracking OFF CACHE BOOL "Build tracking module" FORCE)
set(BUILD_opencv_videostab OFF CACHE BOOL "Build videostab module" FORCE)
set(BUILD_opencv_xfeatures2d OFF CACHE BOOL "Build xfeatures2d module" FORCE)
set(BUILD_opencv_alphamat OFF CACHE BOOL "Build alphamat module" FORCE)
set(BUILD_opencv_cannops OFF CACHE BOOL "Build cannops module" FORCE)
set(BUILD_opencv_cudaarithm OFF CACHE BOOL "Build cudaarithm module" FORCE)
set(BUILD_opencv_cudabgsegm OFF CACHE BOOL "Build cudabgsegm module" FORCE)
set(BUILD_opencv_cudacodec OFF CACHE BOOL "Build cudacodec module" FORCE)
set(BUILD_opencv_cudafeatures2d OFF CACHE BOOL "Build cudafeatures2d module" FORCE)
set(BUILD_opencv_cudafilters OFF CACHE BOOL "Build cudafilters module" FORCE)
set(BUILD_opencv_cudaimgproc OFF CACHE BOOL "Build cudaimgproc module" FORCE)
set(BUILD_opencv_cudalegacy OFF CACHE BOOL "Build cudalegacy module" FORCE)
set(BUILD_opencv_cudaobjdetect OFF CACHE BOOL "Build cudaobjdetect module" FORCE)
set(BUILD_opencv_cudaoptflow OFF CACHE BOOL "Build cudaoptflow module" FORCE)
set(BUILD_opencv_cudastereo OFF CACHE BOOL "Build cudastereo module" FORCE)
set(BUILD_opencv_cudawarping OFF CACHE BOOL "Build cudawarping module" FORCE)
set(BUILD_opencv_cudev OFF CACHE BOOL "Build cudev module" FORCE)
set(BUILD_opencv_cvv OFF CACHE BOOL "Build cvv module" FORCE)
set(BUILD_opencv_freetype OFF CACHE BOOL "Build freetype module" FORCE)
set(BUILD_opencv_hdf OFF CACHE BOOL "Build hdf module" FORCE)
set(BUILD_opencv_java OFF CACHE BOOL "Build java module" FORCE)
#set(BUILD_opencv_java_bindings_generator OFF CACHE BOOL "Build java_bindings_generator module" FORCE)
set(BUILD_opencv_objc OFF CACHE BOOL "Build objc module" FORCE)
#set(BUILD_opencv_objc_bindings_generator OFF CACHE BOOL "Build objc_bindings_generator module" FORCE)
set(BUILD_opencv_js OFF CACHE BOOL "Build js module" FORCE)
#set(BUILD_opencv_js_bindings_generator OFF CACHE BOOL "Build js_bindings_generator module" FORCE)
set(BUILD_opencv_ts OFF CACHE BOOL "Build ts module" FORCE)
set(BUILD_opencv_python2 OFF CACHE BOOL "Build python2 module" FORCE)
set(BUILD_opencv_python3 OFF CACHE BOOL "Build python3 module" FORCE)
#set(BUILD_opencv_python_bindings_generator OFF CACHE BOOL "Build python_bindings_generator module" FORCE)
#set(BUILD_opencv_python_tests OFF CACHE BOOL "Build python_test module" FORCE)
set(BUILD_opencv_julia OFF CACHE BOOL "Build julia module" FORCE)
set(BUILD_opencv_matlab OFF CACHE BOOL "Build matlab module" FORCE)
set(BUILD_opencv_ovis OFF CACHE BOOL "Build ovis module" FORCE)
set(BUILD_opencv_sfm OFF CACHE BOOL "Build sfm module" FORCE)
set(BUILD_opencv_viz OFF CACHE BOOL "Build viz module" FORCE)

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
