# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(dartcv_dnn_library VERSION 0.0.1 LANGUAGES C)

add_library(dartcv_dnn SHARED
  "dartcv_dnn.c"
)

set_target_properties(dartcv_dnn PROPERTIES
  PUBLIC_HEADER dartcv_dnn.h
  OUTPUT_NAME "dartcv_dnn"
)

target_compile_definitions(dartcv_dnn PUBLIC DART_SHARED_LIB)
