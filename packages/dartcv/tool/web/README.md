# Web (WebAssembly) spike

Experimental. Proves that the existing C wrapper (`src/dartcv/`) plus OpenCV can run on the web,
compiled with Emscripten and called from Dart via `dart:js_interop`. Only a small slice of the API
is wired up: `Mat`, `imdecode`, `imencode`, `cvtColor`, `gaussianBlur`. It is exposed through
`package:dartcv4/web_spike.dart`, which re-exports the normal ffi API on the VM and the wasm backend
on dart2js/dart2wasm.

## Build the wasm module

Requires a local [Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html), CMake
and Ninja.

```bash
source /path/to/emsdk/emsdk_env.sh
cd packages/dartcv
OUT_DIR=build/web tool/web/build_wasm.sh            # all core/imgproc/imgcodecs symbols
EXPORTS=demo OUT_DIR=build/web tool/web/build_wasm.sh  # just what the demo uses
```

The script runs `emcmake cmake` on the unchanged `src/CMakeLists.txt`. It then links the wrapper
objects and OpenCV's static libraries into `dartcv.mjs` + `dartcv.wasm`, with `-fwasm-exceptions`
so that C++ exceptions still become `CvStatus`. Set `OPENCV_SRC=/path/to/opencv-4.x` to reuse an
extracted source tree instead of downloading one.

## Run the Flutter web demo

```bash
cp build/web/dartcv.mjs build/web/dartcv.wasm tool/web/flutter_demo/web/
cd tool/web/flutter_demo
flutter run -d chrome          # dart2js
flutter run -d chrome --wasm   # dart2wasm
```

The app decodes `assets/lenna.png`, converts it to gray and blurs it with dartcv. It shows the result
and prints the slice checks (`dartcv-demo ...`) to the browser console.

## Plain-Dart demo

`demo/main_web.dart` runs the same checks without Flutter, together with a comparison against the
prebuilt `opencv.js` (`lib/src/web/opencvjs.dart`). Compile it with `dart compile js` or
`dart compile wasm`, then serve `demo/index.html` next to `dartcv.mjs`, `dartcv.wasm`, `opencv.js`
and `lenna.png`. `demo/main_vm.dart` runs the same checks on the native backend.
