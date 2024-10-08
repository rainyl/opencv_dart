# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(dartcv_videoio_flutter_library VERSION 0.0.1 LANGUAGES C)

add_library(dartcv_videoio_flutter SHARED
  "dartcv_videoio_flutter.c"
)

set_target_properties(dartcv_videoio_flutter PROPERTIES
  PUBLIC_HEADER dartcv_videoio_flutter.h
  OUTPUT_NAME "dartcv_videoio_flutter"
)

target_compile_definitions(dartcv_videoio_flutter PUBLIC DART_SHARED_LIB)
