#!/usr/bin/env bash
# Spike: build the dartcv C wrapper + OpenCV (core, imgproc, imgcodecs) to WebAssembly
# with a local Emscripten SDK, then link it into an ES module (`dartcv.mjs` + `dartcv.wasm`).
#
# Usage (from packages/dartcv):
#   source ~/Developer/emsdk/emsdk_env.sh
#   OPENCV_SRC=/path/to/opencv-4.13.0 BUILD_DIR=/tmp/dartcv-wasm OUT_DIR=build/web tool/web/build_wasm.sh
#
# The existing src/CMakeLists.txt is used unchanged; only -D options differ from a native build.
# -fwasm-exceptions is required: BEGIN_WRAP/END_WRAP turn C++ exceptions into CvStatus, and
# Emscripten's default (exception catching disabled) would abort instead.
# CMake builds dartcv as a dylink side module (libdartcv.so); we link its objects statically.
set -euo pipefail

PKG_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$PKG_DIR/build/wasm}"
OUT_DIR="${OUT_DIR:-$PKG_DIR/build/web}"
# Which symbols to export: "all" = every ffigen symbol of core/imgproc/imgcodecs, "demo" = the spike subset.
EXPORTS="${EXPORTS:-all}"
GENERATOR_ARGS=()
if command -v ninja >/dev/null; then GENERATOR_ARGS=(-G Ninja); fi

if [[ ! -f "$BUILD_DIR/build.ninja" && ! -f "$BUILD_DIR/Makefile" ]]; then
  FETCH_ARGS=()
  if [[ -n "${OPENCV_SRC:-}" ]]; then FETCH_ARGS=(-DFETCHCONTENT_SOURCE_DIR_OPENCV="$OPENCV_SRC"); fi
  emcmake cmake -S "$PKG_DIR/src" -B "$BUILD_DIR" "${GENERATOR_ARGS[@]}" -DCMAKE_BUILD_TYPE=Release \
    "${FETCH_ARGS[@]}" \
    -DDARTCV_WITH_CALIB3D=OFF -DDARTCV_WITH_DNN=OFF -DDARTCV_WITH_FEATURES2D=OFF \
    -DDARTCV_WITH_FLANN=OFF -DDARTCV_WITH_OBJDETECT=OFF -DDARTCV_WITH_PHOTO=OFF \
    -DDARTCV_WITH_STITCHING=OFF -DDARTCV_WITH_VIDEO=OFF \
    -DDARTCV_WITH_IMGPROC=ON -DDARTCV_WITH_IMGCODECS=ON \
    -DWITH_OPENCL=OFF -DWITH_VULKAN=OFF -DWITH_PTHREADS_PF=OFF -DCV_ENABLE_INTRINSICS=OFF \
    -DBUILD_TIFF=OFF -DWITH_TIFF=OFF -DBUILD_OPENJPEG=OFF -DWITH_OPENJPEG=OFF \
    -DENABLE_LIBJPEG_TURBO_SIMD=OFF \
    -DCMAKE_C_FLAGS=-fwasm-exceptions -DCMAKE_CXX_FLAGS=-fwasm-exceptions
fi
cmake --build "$BUILD_DIR" --target dartcv

# Export list: the C symbols the Dart side may call, taken from the ffigen output so it
# stays in sync with lib/src/g/*.g.dart.
mkdir -p "$OUT_DIR"
EXPORT_FILE="$OUT_DIR/exports.txt"
if [[ "$EXPORTS" == "all" ]]; then
  for m in core imgproc imgcodecs; do
    grep -hoE '^external [^=]* ([A-Za-z_][A-Za-z0-9_]*)\($' "$PKG_DIR/lib/src/g/$m.g.dart" \
      | sed -E 's/.* ([A-Za-z_][A-Za-z0-9_]*)\($/_\1/'
  done | sort -u > "$EXPORT_FILE"
else
  cp "$PKG_DIR/tool/web/exports_demo.txt" "$EXPORT_FILE"
fi
printf '_malloc\n_free\n' >> "$EXPORT_FILE"

LIBS=(
  "$BUILD_DIR"/dartcv/CMakeFiles/dartcv.dir/*/*.cpp.o
  "$BUILD_DIR"/_deps/opencv-build/lib/libopencv_imgcodecs.a
  "$BUILD_DIR"/_deps/opencv-build/lib/libopencv_imgproc.a
  "$BUILD_DIR"/_deps/opencv-build/lib/libopencv_core.a
)
while IFS= read -r lib; do LIBS+=("$lib"); done < <(find "$BUILD_DIR/_deps/opencv-build/3rdparty/lib" -name '*.a' | sort)

em++ -O3 "${LIBS[@]}" -o "$OUT_DIR/dartcv.mjs" \
  -sMODULARIZE=1 -sEXPORT_ES6=1 -sEXPORT_NAME=createDartcvModule -sENVIRONMENT=web,worker,node \
  -sALLOW_MEMORY_GROWTH=1 -sINITIAL_MEMORY=32MB -fwasm-exceptions \
  -sEXPORTED_FUNCTIONS=@"$EXPORT_FILE" \
  -sEXPORTED_RUNTIME_METHODS=HEAPU8,HEAP32,HEAPF64,UTF8ToString,stringToNewUTF8,wasmMemory \
  -sERROR_ON_UNDEFINED_SYMBOLS=1

ls -l "$OUT_DIR"/dartcv.*
