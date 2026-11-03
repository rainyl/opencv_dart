# dartcv on the web (experimental)

dartcv4 runs in the browser by compiling the same C wrapper (`src/dartcv`) and OpenCV to
WebAssembly with Emscripten. The hand-written Dart bindings are shared with native: on the web,
`lib/src/ffi.dart` and `lib/src/package_ffi.dart` export a stand-in for `dart:ffi` /
`package:ffi` backed by the wasm memory (`lib/src/web/`), and the ffigen output is mirrored by
generated web bindings (`lib/src/g_web/`). It works with dart2js and dart2wasm, including Flutter
web (CanvasKit and skwasm).

## Using it

1. Put `dartcv.mjs` and `dartcv.wasm` next to your page, e.g. in a Flutter app's `web/` folder.
   Each GitHub release has them in `dartcv-web.zip`; or build them yourself (below).
2. Await `initDartcv()` once before any other call (it is a no-op on native platforms):

   ```dart
   import 'package:opencv_dart/opencv.dart' as cv;

   Future<void> main() async {
     await cv.initDartcv(); // loads dartcv.mjs/dartcv.wasm relative to the page
     runApp(const MyApp());
   }
   ```

Differences from native:

- Call `dispose()` on Mats and other objects you are done with. Finalizers still run, but the
  browser's garbage collector does not see the wasm heap, so it may collect late.
- `Mat.data` and other typed-data views point into the wasm heap; growing the heap (any large
  allocation) detaches them, so re-read them after further OpenCV calls instead of keeping them.
- The `*Async` functions return Futures but run on the calling thread (as on native, where the
  C side completes the callback before returning). Move heavy work to a Web Worker if needed.
- File paths refer to Emscripten's in-memory file system. Decode browser data with `imdecode`
  instead of `imread`, and load models with the `fromBytes`/buffer variants.
- `highgui` and `gapi` are not in the web build; their functions throw `UnsupportedError`.
  `videoio` is built without capture backends.

## Building dartcv.wasm

Needs an [Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html) (CI uses
6.0.13), CMake and Ninja. From `packages/dartcv`:

```bash
source <emsdk>/emsdk_env.sh
tool/web/build_wasm.sh            # writes build/web/dartcv.mjs and build/web/dartcv.wasm
```

`MODULES="imgproc imgcodecs"` builds a smaller module (core is always included). The full
build is about 14 MB (4.4 MB gzip, 3.2 MB brotli).

## Regenerating the web bindings

After `dart tool/ffigen.dart`, run:

```bash
dart tool/web/gen_web_bindings.dart
```

CI fails if `lib/src/g_web` is out of date.

## Testing

```bash
dart test -p chrome test/web_test.dart
dart test -p chrome -c dart2wasm test/web_test.dart
```

`test/web_test.dart` runs every test file that compiles for the web (all but the ones using
`dart:io`, highgui and gapi) against `build/web/dartcv.wasm`, after copying the fixtures into the
in-memory file system.

To try the Flutter example, point `packages/opencv_dart` at the local package (see `AGENTS.md`),
copy `build/web/dartcv.{mjs,wasm}` into `packages/opencv_dart/example/web/` and run
`flutter run -d chrome` there.
