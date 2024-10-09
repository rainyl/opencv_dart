set(DARTCV_WITH_VIDEOIO ON)
set(FFMPEG_USE_STATIC_LIBS OFF)

include(FetchContent)
FetchContent_Declare(
  dartcv
  GIT_REPOSITORY https://github.com/rainyl/dartcv.git
  GIT_TAG main
)
FetchContent_MakeAvailable(dartcv)
