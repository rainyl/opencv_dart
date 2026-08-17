# Contributing

- [Contributing](#contributing)
  - [Contribute new modules](#contribute-new-modules)
  - [Contribute to Documentation](#contribute-to-documentation)
  - [Contribute to Testing](#contribute-to-testing)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

## Prerequisites

- Dart SDK >= 3.10 (Flutter `stable`, see `.fvmrc`) — required for Native Assets (hooks) support.
- CMake and a C/C++ toolchain (Visual Studio on Windows, Ninja preferred on mac/linux/android).
- Since `dartcv 2.2.0`, OpenCV is built from source by default (`DARTCV_BUILD_OPENCV_FROM_SOURCE=ON`): the hooks FetchContent-download the `opencv`/`opencv_contrib` sources and compile them, so the first build is heavy. The prebuilt OpenCV binaries from `rainyl/opencv.full` releases are only for use with `dartcv < 2.2.0` (or when `DARTCV_BUILD_OPENCV_FROM_SOURCE` is OFF); then `DARTCV_CACHE_DIR` caches the download and `DARTCV_DISABLE_DOWNLOAD_OPENCV=1` forces a system OpenCV via `OpenCV_DIR`.

## Contribute new modules

If you want to add a new OpenCV API/module:

1. Check the [OpenCV docs](https://docs.opencv.org) and make sure the required functions/modules are absent in opencv_dart.
2. Create the C wrapper in a new directory `packages/dartcv/src/dartcv/<module>/` (e.g. `cuda/`), containing a `<module>.cpp` and `<module>.h`. Note:
   - Study the existing code first, especially `packages/dartcv/src/dartcv/core/types.h`, which defines the basic structures.
   - Nearly all C wrappers of C++ classes are structs; wrap a C++ class with `CVD_TYPEDEF`, e.g. `CVD_TYPEDEF(cv::Mat, Mat)`.
   - Every exported function returns a `CvStatus*`; wrap the body in `BEGIN_WRAP`/`END_WRAP` to translate C++ exceptions.
   - For async APIs, pass a native callback and complete via `cvRunAsync`/`cvRunAsync0`; add a `<module>_async.dart` in `lib/src/<module>/`.
3. Register the new `.cpp` files in `packages/dartcv/src/dartcv/CMakeLists.txt` under a `DARTCV_WITH_<MODULE>` guard, declare the module option in `packages/dartcv/src/CMakeLists.txt`, and wire its OpenCV module dependencies in `src/cmake/opencv_options.cmake`.
4. Register the module in the Dart side so it can be selected at build time:
   - add it to `allowedModules` in `lib/src/hook_helpers/run_build.dart` and the module maps in `hook/link.dart`,
   - add it to `hooks.user_defines.dartcv4.include_modules` in `packages/dartcv/pubspec.yaml` so it builds during development (consumers enable it the same way).
   - Modules are off by default; even when not built, the Dart code exists and throws "symbol not found" at call time.
5. Generate the FFI bindings: add your `.h` file to the per-module ffigen config in `packages/dartcv/ffigen/` and run `dart tool/ffigen.dart` from `packages/dartcv`. This writes the `lib/src/g/<module>.g.dart` bindings plus the `<module>.record_use_mapping.g.dart` tables used for tree-shaking. **Do not** use `make ffigen` / `dart run ffigen --config ffigen/*.yaml` for a full regen — those skip the record-use mapping and silently break tree-shaking.
6. Add the hand-written Dart code in `packages/dartcv/lib/src/<module>/` and export it from `lib/dartcv.dart`.
7. Write tests in `packages/dartcv/test/<module>/`. Refer to [OpencvSharp](https://github.com/shimat/opencvsharp) and [gocv](https://github.com/hybridgroup/gocv) for expected behavior.
8. Build and test, see below.

## Contribute to Documentation

1. `git clone https://github.com/rainyl/opencv_dart`
2. Open the project in an IDE and write doc strings above functions and classes in source code.
3. Follow the Dart documentation recommendations, https://dart.dev/effective-dart/documentation

## Contribute to Testing

1. `git clone https://github.com/rainyl/opencv_dart`
2. `cd opencv_dart/packages/dartcv`
3. Install dependencies: `dart pub get` (the dynamic library is now built automatically by the native-assets hooks; no need to add it to `PATH`).
4. Write new Dart tests and place them in `test/`.
5. Run `dart test` — the hooks configure and build the `dartcv` native library on the fly. To run a single test file: `dart test test/core/mat_test.dart`.
6. Note:
   - **After changing any C/C++/CMake source, touch `hook/build.dart`** (e.g. append a comment) — the native-assets build cache is keyed on its content, and the hooks will not recompile otherwise.
   - DNN tests read `test/models/*` (gitignored); download `models.zip` from the GitHub release tag `dnn_test_files` into `test/`. videoio writer tests write to per-test temp dirs (so `dart test`'s parallel isolates never race on a shared file); only `test/images/small.mp4` is a committed read-only fixture.
   - Format with `dart format --line-length 110` and check with `dart analyze` before committing.

Other platforms are similar.
