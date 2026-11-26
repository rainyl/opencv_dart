# dartcv on the web (experimental)

dartcv4 runs in the browser by compiling the same C wrapper (`src/dartcv`) and OpenCV to
WebAssembly with Emscripten. The hand-written Dart bindings are shared with native: on the web,
`lib/src/ffi.dart` and `lib/src/package_ffi.dart` export a stand-in for `dart:ffi` /
`package:ffi` backed by the wasm memory (`lib/src/web/`), and the ffigen output is mirrored by
generated web bindings (`lib/src/web/g/`). It works with dart2js and dart2wasm, including Flutter
web (CanvasKit and skwasm).

## Using it

1. Put `dartcv.js` and `dartcv.wasm` next to your page, e.g. in a Flutter app's `web/` folder.
   Each GitHub release has them in `dartcv-web-<version>.zip`, or you build them yourself (below).
2. Await `initDartcv()` once before any other call (it is a no-op on native platforms):

   ```dart
   import 'package:opencv_dart/opencv.dart' as cv;

   Future<void> main() async {
     await cv.initDartcv(); // loads dartcv.js/dartcv.wasm relative to the page
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

Needs an [Emscripten SDK](https://emscripten.org/docs/getting_started/downloads.html) (6.0 or newer:
CI uses 6.0.13 on Linux and 7.0.0 on Windows), CMake and Ninja.

From an application that depends on `dartcv4` the tool is the package's `bin/` entry point, and it
writes where a Flutter web build picks the files up:

```bash
dart run dartcv4:build_wasm                     # -> ./web/dartcv.js + ./web/dartcv.wasm
dart run dartcv4:build_wasm --modules imgproc   # a smaller module
dart run dartcv4:build_wasm --out-dir some/dir  # somewhere else
```

A web-only app should also tell the native hooks not to run, or `dart run` builds the native library
(and downloads OpenCV) before the tool starts:

```yaml
hooks:
  user_defines:
    dartcv4:
      skip_build: true
```

From this package's own checkout it keeps the CI layout (`build/wasm` for the build tree, which the
CI cache keys, and `build/web` for the artifacts):

```bash
dart tool/web/build_wasm.dart     # writes build/web/dartcv.js and build/web/dartcv.wasm
```

The tool drives `package:native_toolchain_cmake`'s `CMakeWasmBuilder`: it runs `emcmake cmake` on
`src/` and builds the `dartcv_wasm` target, which is the C wrapper linked against OpenCV's static
libraries and exporting exactly the symbols `lib/src/g/*.g.dart` declares. A module left out of the
build is not a link error - its functions throw `UnsupportedError` at call time instead.

| option | meaning |
| --- | --- |
| `--modules imgproc,imgcodecs` | build a smaller module (core is always included); `--modules all` adds highgui and gapi, which are not expected to link |
| `--clean` | delete the build directory first |
| `--jobs N` | parallel build jobs |
| `--single-file` | embed the `.wasm` in `dartcv.js` (`-sSINGLE_FILE=1`), so there is no separate file to serve |
| `--check-emscripten` | report the Emscripten, Ninja and CMake it would use, build nothing |
| `-v` | show the CMake command lines |
| `--build-dir`, `--out-dir`, `--opencv-src`, `--contrib-src`, `--emsdk` | same knobs as the environment variables `BUILD_DIR`, `OUT_DIR`, `OPENCV_SRC`, `CONTRIB_SRC`, `EMSDK` |

The full build is about 14 MB (4.4 MB gzip, 3.2 MB brotli); `--modules imgproc,imgcodecs` produces
about 5 MB. Emscripten is found through `--emsdk` (an emsdk root, or the directory holding `emcc`),
then an `emcc` on `PATH`, then `EMSDK` and the usual emsdk locations.

The module records the `dartcv4` version it was built from (`export const dartcvVersion`), and
`initDartcv()` warns when it differs from `lib/src/package_version.dart` (generated from
`pubspec.yaml`), which is how a `dartcv.js` left over from another release is noticed. A warning,
not a failure: a pinned patch level is legitimate. Modules built before this check have no stamp and
load silently.

`tool/web/build_wasm.sh` and `tool/web/build_wasm.ps1` are the previous per-OS implementations:
they still work, they are deprecated, and they will be removed in the next release.

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

The same run also writes `lib/src/bindings/<module>.dart`, one line per module:

```dart
export '../g/core.g.dart' if (dart.library.js_interop) '../web/g/core.g.dart';
```

Hand-written code imports that facade (`import '../bindings/core.dart' as ccore;`) instead of naming
either `g/` file, so the platform switch exists once per module rather than in every file that calls
into the bindings; `--check` covers these too.

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
copy `build/web/dartcv.{js,wasm}` into `packages/opencv_dart/example/web/` and run
`flutter run -d chrome` there. `packages/dartcv/example/flutter` is web-ready as well, and depends on
this package by path already: copy the same two files into its `web/` and run it (see its README).
