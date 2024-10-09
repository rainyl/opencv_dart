set(DARTCV_WITH_VIDEOIO ON)
set(FFMPEG_USE_STATIC_LIBS OFF)

include(FetchContent)
FetchContent_Declare(
  dartcv
  GIT_REPOSITORY https://github.com/rainyl/opencv_dart.git
  GIT_TAG cpp
)
FetchContent_MakeAvailable(dartcv)
