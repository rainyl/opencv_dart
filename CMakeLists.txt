cmake_minimum_required(VERSION 3.15)

project(opencv_dart_library VERSION 0.0.1 LANGUAGES C CXX)
set(LIBRARY_NAME "opencv_dart")

set(CMAKE_CXX_STANDARD 20)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
cmake_policy(SET CMP0135 NEW)

find_package(OpenCV REQUIRED)

set(OpenCV_LIBS
    opencv_aruco opencv_core opencv_calib3d opencv_dnn opencv_highgui
    opencv_features2d opencv_gapi opencv_photo opencv_imgproc
    opencv_objdetect opencv_video opencv_videoio opencv_stitching
)

if(ANDROID)
    list(APPEND OpenCV_LIBS camera2ndk mediandk -landroid)
endif(ANDROID)

if(IOS)
    list(APPEND OpenCV_LIBS
        "-framework CoreFoundation"
        "-framework CoreImage"
        "-framework Foundation"
    )
endif(IOS)

message(STATUS "OpenCV library status:")
message(STATUS "    config: ${OpenCV_DIR}")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")

file(GLOB_RECURSE CPP_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/src/core/*.cpp"
    "${CMAKE_CURRENT_SOURCE_DIR}/src/calib3d.cpp"
)
file(GLOB_RECURSE HEADER_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/src/*.h"
)

add_library(${LIBRARY_NAME} SHARED
    ${CPP_FILES}
)
target_include_directories(${LIBRARY_NAME} SYSTEM PUBLIC
    "${CMAKE_CURRENT_SOURCE_DIR}/src"
    ${OpenCV_INCLUDE_DIRS}
)
target_link_libraries(${LIBRARY_NAME} PRIVATE ${OpenCV_LIBS})

set_target_properties(${LIBRARY_NAME} PROPERTIES
    # PUBLIC_HEADER ${GOCV_HEADERS}
    OUTPUT_NAME ${LIBRARY_NAME}
    CXX_VISIBILITY_PRESET default
    C_VISIBILITY_PRESET default
    LINK_FLAGS_RELEASE -s
)

if(IOS)
    set_target_properties(${LIBRARY_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION CXX
        MACOSX_FRAMEWORK_IDENTIFIER dev.rainyl.opencvDart
        MACOSX_FRAMEWORK_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${PROJECT_VERSION}
    )
endif(IOS)


if(WIN32)
    set_target_properties(${LIBRARY_NAME} PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS ON
        COMPILE_FLAGS "/EHsc"
    )
endif(WIN32)

target_compile_definitions(${LIBRARY_NAME} PUBLIC DART_SHARED_LIB)

### install
install(TARGETS ${LIBRARY_NAME}
    DESTINATION ${CMAKE_INSTALL_PREFIX})

if(WIN32)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dll")
elseif(APPLE)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dylib")
elseif(LINUX)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.so")
endif()

install(FILES ${CV_DEPENDENCIES} DESTINATION ${CMAKE_INSTALL_PREFIX})

### test
include(FetchContent)
FetchContent_Declare(
    googletest
    URL https://github.com/google/googletest/archive/refs/heads/main.zip
)
# For Windows: Prevent overriding the parent project's compiler/linker settings
if(WIN32)
    set(gtest_force_shared_crt ON CACHE BOOL "" FORCE)
endif(WIN32)
FetchContent_MakeAvailable(googletest)
enable_testing()

macro(add_ocv_dart_test executable_name source_file)
    add_executable(
        ${executable_name}
        "${source_file}"
    )

    target_link_libraries(
        ${executable_name}
        PUBLIC
        ${OpenCV_LIBS}
        ${LIBRARY_NAME}
        GTest::gtest_main
    )

    if(WIN32)
        set_target_properties(${executable_name} PROPERTIES
            COMPILE_FLAGS "/EHsc"
        )
    endif(WIN32)
endmacro()

add_ocv_dart_test(ocv_dart_test_vec "src/test/vec.cc")
add_ocv_dart_test(ocv_dart_test_core "src/test/core.cc")

include(GoogleTest)
gtest_discover_tests(ocv_dart_test_vec)
gtest_discover_tests(ocv_dart_test_core)
