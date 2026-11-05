#!/usr/bin/env bash
# Build the dartcv C wrapper + OpenCV to WebAssembly with Emscripten and link it into an
# ES module: `dartcv.mjs` (loader) + `dartcv.wasm`.
#
# Usage (from packages/dartcv, with emsdk activated: `source <emsdk>/emsdk_env.sh`):
#   tool/web/build_wasm.sh
#
# Environment:
#   BUILD_DIR   CMake build directory (default build/wasm)
#   OUT_DIR     where dartcv.mjs / dartcv.wasm are written (default build/web)
#   OPENCV_SRC  optional local OpenCV source tree (skips the download)
#   CONTRIB_SRC optional local opencv_contrib source tree (skips the download)
#   MODULES     space separated dartcv modules (default: every module that works in a browser)
#
# The existing src/CMakeLists.txt is used unchanged; only -D options differ from a native build.
# -fwasm-exceptions is required: BEGIN_WRAP/END_WRAP turn C++ exceptions into CvStatus, and
# Emscripten's default (exception catching disabled) would abort instead.
# CMake builds dartcv as a dylink side module (libdartcv.so); we link its objects and the
# OpenCV static libraries into one main module instead.
set -euo pipefail

PKG_DIR="$(cd "$(dirname "$0")/../.." && pwd)"
BUILD_DIR="${BUILD_DIR:-$PKG_DIR/build/wasm}"
OUT_DIR="${OUT_DIR:-$PKG_DIR/build/web}"
# highgui needs a GUI backend and gapi is unfinished upstream, so neither is in the default set.
MODULES="${MODULES:-calib3d dnn features2d flann freetype imgcodecs imgproc objdetect photo stitching video videoio aruco img_hash quality wechat_qrcode ximgproc xobjdetect}"
GENERATOR_ARGS=()
if command -v ninja >/dev/null; then GENERATOR_ARGS=(-G Ninja); fi

ALL_MODULES="calib3d dnn features2d flann freetype highgui imgcodecs imgproc objdetect photo stitching video videoio gapi aruco img_hash quality wechat_qrcode ximgproc xobjdetect"
MODULE_ARGS=()
for m in $ALL_MODULES; do
  flag=OFF
  for want in $MODULES; do [[ "$want" == "$m" ]] && flag=ON; done
  MODULE_ARGS+=("-DDARTCV_WITH_$(echo "$m" | tr '[:lower:]' '[:upper:]')=$flag")
done

# OpenCV turns off its filesystem helpers (utils::fs::exists, ...) for Emscripten; the in-memory
# file system supports the POSIX calls they need, and wechat_qrcode/dnn model loading use them.
CFLAGS_WASM="-fwasm-exceptions -DOPENCV_HAVE_FILESYSTEM_SUPPORT=1"

if [[ ! -f "$BUILD_DIR/build.ninja" && ! -f "$BUILD_DIR/Makefile" ]]; then
  FETCH_ARGS=()
  if [[ -n "${OPENCV_SRC:-}" ]]; then FETCH_ARGS+=(-DFETCHCONTENT_SOURCE_DIR_OPENCV="$OPENCV_SRC"); fi
  if [[ -n "${CONTRIB_SRC:-}" ]]; then FETCH_ARGS+=(-DFETCHCONTENT_SOURCE_DIR_OPENCV_CONTRIB="$CONTRIB_SRC"); fi
  emcmake cmake -S "$PKG_DIR/src" -B "$BUILD_DIR" "${GENERATOR_ARGS[@]}" -DCMAKE_BUILD_TYPE=Release \
    "${FETCH_ARGS[@]}" "${MODULE_ARGS[@]}" \
    -DWITH_OPENCL=OFF -DWITH_VULKAN=OFF -DWITH_PTHREADS_PF=OFF -DCV_ENABLE_INTRINSICS=OFF \
    -DBUILD_TIFF=OFF -DWITH_TIFF=OFF -DBUILD_OPENJPEG=OFF -DWITH_OPENJPEG=OFF \
    -DENABLE_LIBJPEG_TURBO_SIMD=OFF -DCMAKE_POLICY_VERSION_MINIMUM=3.5 \
    -DCMAKE_C_FLAGS="$CFLAGS_WASM" -DCMAKE_CXX_FLAGS="$CFLAGS_WASM"
fi
cmake --build "$BUILD_DIR" --target dartcv

OBJS=("$BUILD_DIR"/dartcv/CMakeFiles/dartcv.dir/*/*.cpp.o)
LIBS=()
while IFS= read -r lib; do LIBS+=("$lib"); done < <(
  find "$BUILD_DIR/_deps" -name '*.a' -not -path '*/CMakeFiles/*' | sort
)

# Export list: every C symbol the Dart bindings declare (lib/src/g/*.g.dart) that this build
# defines. Symbols of modules left out of MODULES are skipped; the web bindings throw
# UnsupportedError for them at call time.
mkdir -p "$OUT_DIR"
EXPORT_FILE="$OUT_DIR/exports.txt"
DEFINED="$(mktemp)"
emnm --defined-only -j "${OBJS[@]}" 2>/dev/null | grep -vE ':$|^$' | sort -u > "$DEFINED"
cat "$PKG_DIR"/lib/src/g/*.g.dart \
  | grep -oE '^external [^=(]* ([A-Za-z_][A-Za-z0-9_]*)\(' \
  | sed -E 's/.* ([A-Za-z_][A-Za-z0-9_]*)\($/\1/' | sort -u \
  | comm -12 - "$DEFINED" | sed 's/^/_/' > "$EXPORT_FILE"
rm -f "$DEFINED"
printf '_malloc\n_free\n' >> "$EXPORT_FILE"
echo "exporting $(wc -l < "$EXPORT_FILE" | tr -d ' ') symbols"

# ximgproc's EdgeDrawing has 64 MB of static lookup tables (zero-initialised, so not in the .wasm
# file), hence the large initial memory.
em++ -O3 "${OBJS[@]}" "${LIBS[@]}" -o "$OUT_DIR/dartcv.mjs" \
  -sMODULARIZE=1 -sEXPORT_ES6=1 -sEXPORT_NAME=createDartcvModule -sENVIRONMENT=web,worker,node \
  -sALLOW_MEMORY_GROWTH=1 -sINITIAL_MEMORY=96MB -sSTACK_SIZE=1MB -fwasm-exceptions \
  -sALLOW_TABLE_GROWTH=1 -sFORCE_FILESYSTEM=1 \
  -sEXPORTED_FUNCTIONS=@"$EXPORT_FILE" \
  -sEXPORTED_RUNTIME_METHODS=HEAPU8,wasmMemory,addFunction,removeFunction,FS \
  -sERROR_ON_UNDEFINED_SYMBOLS=1

ls -l "$OUT_DIR"/dartcv.*
