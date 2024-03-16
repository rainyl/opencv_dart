cmake_minimum_required(VERSION 3.15)

project(opencv_dart_library VERSION 0.0.1 LANGUAGES C CXX)
set(library_name "opencv_dart")

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)

find_package(OpenCV REQUIRED)

set(OpenCV_LIBS
    opencv_aruco opencv_core opencv_calib3d opencv_dnn opencv_highgui
    opencv_features2d opencv_photo opencv_imgproc
    opencv_objdetect opencv_video opencv_videoio opencv_stitching
)

if(ANDROID)
    list(APPEND OpenCV_LIBS camera2ndk mediandk -landroid)
endif(ANDROID)

message(STATUS "OpenCV library status:")
message(STATUS "    config: ${OpenCV_DIR}")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")

file(GLOB GOCV_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.cpp"

    # "${CMAKE_CURRENT_SOURCE_DIR}/gocv/contrib/*.cpp"
)
file(GLOB GOCV_HEADERS
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"

    # "${CMAKE_CURRENT_SOURCE_DIR}/gocv/contrib/*.cpp"
)

add_library(${library_name} SHARED
    ${GOCV_FILES}
)
target_include_directories(${library_name} SYSTEM PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
    ${OpenCV_INCLUDE_DIRS}
)
target_link_libraries(${library_name} PRIVATE ${OpenCV_LIBS})
set_target_properties(${library_name} PROPERTIES

    # PUBLIC_HEADER ${GOCV_HEADERS}
    OUTPUT_NAME ${library_name}
    CXX_VISIBILITY_PRESET default
    C_VISIBILITY_PRESET default
    LINK_FLAGS_RELEASE -s
)

if(WIN32)
    set_target_properties(${library_name} PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS ON
    )
endif(WIN32)

target_compile_definitions(${library_name} PUBLIC DART_SHARED_LIB)

if(WITH_OPENCV_DART_DEMO)
    add_executable(
        demo
        "demo.c"
    )
    target_link_libraries(
        demo
        PUBLIC
        ${OpenCV_LIBS}
        ${library_name}
    )
endif()

# ## install
install(TARGETS ${library_name}
    DESTINATION ${CMAKE_INSTALL_PREFIX})

if(WIN32)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dll")
elseif(APPLE)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dylib")
elseif(LINUX)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.so")
endif()

install(FILES ${CV_DEPENDENCIES} DESTINATION ${CMAKE_INSTALL_PREFIX})
