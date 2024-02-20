# The Flutter tooling requires that developers have CMake 3.10 or later
# installed. You should not increase this version, as doing so will cause
# the plugin to fail to compile for some customers of the plugin.
cmake_minimum_required(VERSION 3.10)

project(opencv_dart_library VERSION 0.0.1 LANGUAGES C CXX)
set(library_name "opencv_dart")

set(CMAKE_EXPORT_COMPILE_COMMANDS TRUE)
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_INSTALL_PREFIX "install")

if (CMAKE_SYSTEM_PROCESSOR MATCHES "amd64.*|x86_64.*|AMD64.*")
    set(OpenCV_Dart_ARCH x64)
else ()
    set(OpenCV_Dart_ARCH x86)
endif ()

if (WIN32)
    set(OpenCV_Dart_OS windows)
elseif (UNIX)
    set(OpenCV_Dart_OS linux)
elseif (APPLE)
    set(OpenCV_Dart_OS macos)
endif ()

set(OpenCV_DIR
    "${CMAKE_CURRENT_SOURCE_DIR}/../build/opencv/${OpenCV_Dart_OS}-${OpenCV_Dart_ARCH}/install/")
#find_package(OpenCV 4.9.0 REQUIRED)
find_package(OpenCV REQUIRED
    COMPONENTS
    core calib3d dnn highgui features2d photo imgproc objdetect video videoio
)

message(STATUS "OpenCV library status:")
message(STATUS "    config: ${OpenCV_DIR}")
message(STATUS "    version: ${OpenCV_VERSION}")
message(STATUS "    libraries: ${OpenCV_LIBS}")
message(STATUS "    include path: ${OpenCV_INCLUDE_DIRS}")

#add_library(cv SHARED IMPORTED GLOBAL)
#set_property(TARGET cv PROPERTY IMPORTED)

file(GLOB GOCV_FILES
    "${CMAKE_CURRENT_SOURCE_DIR}/gocv/*.cpp"
)
add_library(${library_name} SHARED ${GOCV_FILES}
    #    cv/types.h
)
target_include_directories(${library_name} SYSTEM PUBLIC
    "${OpenCV_DIR}/include"
)
target_link_libraries(${library_name} PUBLIC ${OpenCV_LIBS})
set_target_properties(opencv_dart PROPERTIES
    #  PUBLIC_HEADER opencv_dart.h
    OUTPUT_NAME "opencv_dart"
)

if (WIN32)
    set_target_properties(${library_name} PROPERTIES
        WINDOWS_EXPORT_ALL_SYMBOLS ON
    )
endif (WIN32)

target_compile_definitions(${library_name} PUBLIC DART_SHARED_LIB)

add_custom_command(TARGET ${library_name} POST_BUILD
    COMMAND ${CMAKE_COMMAND} -E copy_if_different $<TARGET_RUNTIME_DLLS:${library_name}> $<TARGET_FILE_DIR:${library_name}>
    COMMAND_EXPAND_LISTS
)

### install
install(TARGETS ${library_name}
    DESTINATION ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX})
if (WIN32)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dll")
elseif (UNIX)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.so")
elseif (APPLE)
    file(GLOB CV_DEPENDENCIES "${CMAKE_BINARY_DIR}/*.dylib")
endif ()
install(FILES ${CV_DEPENDENCIES} DESTINATION ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX})
#file(COPY ${CV_DEPENDENCIES} DESTINATION ${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX})
#file(COPY "gocv/images/circles.jpg" DESTINATION ${CMAKE_BINARY_DIR})

if (WIN32)
    file(GLOB OPENCV_DART_WIN_DLLS "${CMAKE_BINARY_DIR}/${CMAKE_INSTALL_PREFIX}/*")
    # file(COPY ${OPENCV_DART_WIN_DLLS} DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/../windows/libs")
    install(FILES ${OPENCV_DART_WIN_DLLS} DESTINATION "${CMAKE_CURRENT_SOURCE_DIR}/../windows/libs")
endif (WIN32)
# TODO: add linux copy dll

if (OPENCV_DART_COMPILE_DEMO)
    add_executable(
        demo
        "demo.c"
    )
    # target_include_directories(demo SYSTEM)
    target_link_libraries(
        demo
        PUBLIC
        ${library_name}
        ${OpenCV_LIBS}
    )
endif ()
