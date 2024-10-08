include(FetchContent)
FetchContent_Declare(
  dartcv
  GIT_REPOSITORY https://github.com/rainyl/opencv_dart.git
  GIT_TAG        cpp
)
FetchContent_MakeAvailable(dartcv)
