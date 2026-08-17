# AGENTS.md

## Repository layout

- `packages/dartcv` is the real package (published as `dartcv4`, `pubspec.yaml` `name: dartcv4`). Nearly all work happens here; run `dart` commands from it, not the repo root (there is no root `pubspec.yaml`).
- `packages/opencv_dart` is a Flutter wrapper that only re-exports `package:dartcv4`. It depends on the *published* `dartcv4` by default; to test local dartcv changes there, switch its `pubspec.yaml` to the commented-out `path: ../dartcv`.
- `packages/dartcv/src/dartcv/<module>/` — hand-written C/C++ wrappers around OpenCV (`.cpp` + `.h` per module).
- `packages/dartcv/lib/src/<module>/` — hand-written Dart bindings (sync + `*_async.dart`).
- `packages/dartcv/lib/src/g/*.g.dart` — **generated** by ffigen (`types.g.dart`, `constants.g.dart`, `<module>.g.dart` + `<module>.record_use_mapping.g.dart`). Never hand-edit; analyzer excludes them.

## Adding a new API / module

Follow `CONTRIBUTING.md`. Flow: C wrapper in `src/dartcv/<module>/` → register the `.cpp` in `src/dartcv/CMakeLists.txt` under a `DARTCV_WITH_*` guard → regenerate FFI bindings → hand-written Dart in `lib/src/<module>/` → tests in `test/<module>/`.

C wrapper conventions (see `src/dartcv/core/types.h`): wrap C++ classes via `CVD_TYPEDEF`, every function returns a `CvStatus*` (`BEGIN_WRAP`/`END_WRAP` translate C++ exceptions). Async APIs pass a native callback and complete via `cvRunAsync`/`cvRunAsync0`.

Modules are gated at build time: core is always on, the default is core+imgcodecs+imgproc. The checked-in `pubspec.yaml` `hooks.user_defines.dartcv4.include_modules` enables everything for dev. Even when a module isn't built, its Dart code exists and throws "symbol not found" at call time. Adding a module also means adding it to `allowedModules` in `lib/src/hook_helpers/run_build.dart` and the module maps in `hook/link.dart`.

## Build & test (from `packages/dartcv`)

- Requires Dart ≥ 3.10 (Flutter stable, see `.fvmrc`), CMake, and a C/C++ toolchain (Visual Studio on Windows; Ninja preferred on mac/linux/android).
- `dart pub get && dart test`
  - Since `dartcv 2.2.0`, OpenCV libraries are built from source by default (`DARTCV_BUILD_OPENCV_FROM_SOURCE=ON`), native-assets hooks (`hook/build.dart`, `hook/link.dart`) auto-build the `dartcv` shared lib.
  - Prebuilt OpenCV binaries from `rainyl/opencv.full` releases are only recommended for use before `dartcv 2.2.0` (large download); set `DARTCV_CACHE_DIR` to reuse the cache. `DARTCV_DISABLE_DOWNLOAD_OPENCV=1` forces a system `OpenCV_DIR`.
- **Critical gotcha:** the native-assets build cache is keyed on the *contents of `hook/build.dart` `hook/link.dart` and `pubspec.yaml`*. After changing any C/C++/CMake source, edit `hook/build.dart` (e.g. append a comment) or the hooks will not recompile.
- Run one test: `dart test test/core/mat_test.dart`.
- DNN tests read `test/models/*` (gitignored) — download `models.zip` from the GitHub release tag `dnn_test_files` (CI does this). videoio writer tests write to per-test temp dirs (so `dart test`'s parallel isolates never race on a shared file); only `test/images/small.mp4` is a committed read-only fixture. Other tests use `test/images/`.
- Coverage (CI): `dart pub global activate coverage && dart pub global run coverage:test_with_coverage --package . --package-name dartcv4`.

## Regenerating FFI bindings

- Intended generator: `dart tool/ffigen.dart` from `packages/dartcv`. Unlike the raw yaml runs, it also emits `@RecordUse()` and the `<module>.record_use_mapping.g.dart` tables that `hook/link.dart` consumes for tree-shaking.
- Do **not** use `make ffigen` / `dart run ffigen --config ffigen/*.yaml` for a full regen — it skips the record-use mapping, silently breaking tree-shaking.

## Style & checks

- Format with `dart format --line-length 110` (repo-wide; CI auto-commits the result). `analysis_options.yaml` sets `formatter.page_width: 110`, `trailing_commas: preserve`.
- `dart analyze` passes apart from the known `tool/ffigen.dart` errors. C++ follows `.clang-format` (LLVM-based, 2-space indent, column limit 100).
- Tree-shaking (`DARTCV_TREESHAKE` + keep-list `dartcv_keep.txt`) only works on AOT builds; the link hook deliberately leaves the keep-list untouched on JIT (`dart test`) builds.
