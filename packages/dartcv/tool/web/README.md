# dartcv on the web (experimental)

dartcv4 runs in the browser by compiling the same C wrapper (`src/dartcv`) and OpenCV to
WebAssembly with Emscripten. The hand-written Dart bindings are shared with native: on the web,
`lib/src/ffi.dart` and `lib/src/package_ffi.dart` export a stand-in for `dart:ffi` /
`package:ffi` backed by the wasm memory (`lib/src/web/`), and the ffigen output is mirrored by
generated web bindings (`lib/src/web/g/`). It works with dart2js and dart2wasm, including Flutter
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

On Windows use the PowerShell port, which takes the same knobs:

```powershell
pwsh -File tool/web/build_wasm.ps1                        # writes build/web/dartcv.mjs and .wasm
pwsh -File tool/web/build_wasm.ps1 -Modules imgproc,imgcodecs -Clean
```

It takes `-BuildDir`, `-OutDir`, `-OpenCVSrc`, `-ContribSrc`, `-Modules`, `-Emsdk <dir>` and
`-Clean`, and links through a response file because the object list is longer than a Windows
command line. It has been run end to end with emsdk 7.0.0 on Windows 11 (Ninja + CMake 4.3),
producing the same `dartcv.mjs` / `dartcv.wasm` as the shell script.

It does not care how Emscripten was installed: it uses `-Emsdk` (the emsdk root or its
`upstream/emscripten`), else an `emcc` already on PATH, else `EMSDK` / `EMSDK_ROOT` and the usual
locations (scoop, chocolatey, the emsdk default directories).

## Regenerating the web bindings

`dart tool/ffigen.dart` runs this at the end, so normally there is nothing to do by hand: it reads
the freshly written `lib/src/g/*.g.dart` and rewrites `lib/src/web/g/`. The generator only needs
those files, so it can also run on its own (this is what CI uses):

```bash
dart tool/web/gen_web_bindings.dart           # rewrite lib/src/web/g
dart tool/web/gen_web_bindings.dart --check   # report missing/stale/differing files, write nothing
```

CI fails if `lib/src/web/g` is out of date. Modules removed from `tool/ffigen.dart`'s list have
their `lib/src/web/g` file deleted on the next run.

Two things are shared with the native bindings instead of mirrored:

- `constants.g.dart` is nothing but `const int`s, so it has no web mirror at all: `tool/ffigen.dart`
drops the unused `dart:ffi` import ffigen writes into it, and both platforms import the same
`lib/src/g/constants.g.dart`.
- Doc comments travel with their declaration, so the web bindings document the same API as the
native ones.

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
