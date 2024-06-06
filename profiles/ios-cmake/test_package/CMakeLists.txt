cmake_minimum_required(VERSION 3.12)
project(test_package VERSION 0.0.1 LANGUAGES C CXX)

add_library(${PROJECT_NAME} test_package.cpp)

if(IOS)
    message(STATUS "Building for IOS framework")
    set_target_properties(${PROJECT_NAME} PROPERTIES
        FRAMEWORK TRUE
        FRAMEWORK_VERSION CXX
        MACOSX_FRAMEWORK_IDENTIFIER ioscmaketestpackage
        MACOSX_FRAMEWORK_BUNDLE_VERSION ${PROJECT_VERSION}
        MACOSX_FRAMEWORK_SHORT_VERSION_STRING ${PROJECT_VERSION}
    )
endif(IOS)

target_compile_features(${PROJECT_NAME} PRIVATE cxx_std_20)
