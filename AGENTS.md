# AGENTS.md

## Repository layout

- `packages/dartcv` is the real package (published as `dartcv4`, `pubspec.yaml` `name: dartcv4`). Nearly all work happens here; run `dart` commands from it, not the repo root (there is no root `pubspec.yaml`).
- `packages/opencv_dart` is a Flutter wrapper that only re-exports `package:dartcv4`. It depends on the *published* `dartcv4` by default; to test local dartcv changes there, switch its `pubspec.yaml` to the commented-out `path: ../dartcv`.
- `packages/opencv_dart/CHANGELOG.md` **always mirrors** `packages/dartcv/CHANGELOG.md`: every release gets the same version heading and the same entries in both files (only the `# ` title differs), because the wrapper is a re-export and a `dartcv4` change is an `opencv_dart` change. Write the notes once, copy them over; never document a change in one file only. History before `2.2.1` was versioned independently per package and is left as it is (the same number can mean different things there, e.g. `1.1.0`), so only compare/align from the current release on. `publish.yml`'s `check-release` job fails a release whose changelog has no section for the version being published.
- `packages/dartcv/src/dartcv/<module>/` — hand-written C/C++ wrappers around OpenCV (`.cpp` + `.h` per module).
- `packages/dartcv/lib/src/<module>/` — hand-written Dart bindings (sync + `*_async.dart`).
- `packages/dartcv/lib/src/g/*.g.dart` — **generated** by ffigen (`types.g.dart`, `constants.g.dart`, `<module>.g.dart` + `<module>.record_use_mapping.g.dart`). Never hand-edit; analyzer excludes them.

## Adding a new API / module

Follow `CONTRIBUTING.md`. Flow: C wrapper in `src/dartcv/<module>/` → register the `.cpp` in `src/dartcv/CMakeLists.txt` under a `DARTCV_WITH_*` guard → regenerate FFI bindings → hand-written Dart in `lib/src/<module>/` → tests in `test/<module>/`.

C wrapper conventions (see `src/dartcv/core/types.h`): wrap C++ classes via `CVD_TYPEDEF`, every function returns a `CvStatus*` (`BEGIN_WRAP`/`END_WRAP` translate C++ exceptions). Async APIs pass a native callback and complete via `cvRunAsync`/`cvRunAsync0`.

Modules are gated at build time: core is always on, the default is core+imgcodecs+imgproc. The checked-in `pubspec.yaml` `hooks.user_defines.dartcv4.include_modules` enables everything for dev. Even when a module isn't built, its Dart code exists and throws "symbol not found" at call time. Adding a module also means adding it to `allowedModules` in `lib/src/hook_helpers/user_defines.dart` and the module maps in `hook/link.dart`.

## Build & test (from `packages/dartcv`)

- Requires the Flutter SDK pinned in `.fvmrc` (currently `3.50.1` / Dart 3.14 — CI reads the same file), CMake, and a C/C++ toolchain (Visual Studio on Windows; Ninja preferred on mac/linux/android).
- `dart pub get && dart test`
  - Since `dartcv 2.2.0`, OpenCV libraries are built from source by default (`DARTCV_BUILD_OPENCV_FROM_SOURCE=ON`), native-assets hooks (`hook/build.dart`, `hook/link.dart`) auto-build the `dartcv` shared lib.
  - Prebuilt OpenCV binaries from `rainyl/opencv.full` releases are only recommended for use before `dartcv 2.2.0` (large download); set `DARTCV_CACHE_DIR` to reuse the cache. `DARTCV_DISABLE_DOWNLOAD_OPENCV=1` forces a system `OpenCV_DIR`.
- The build hook declares its non-Dart inputs (`src/CMakeLists.txt`, `src/cmake/**`, `src/dartcv/**`)
  through `output.dependencies`, so editing C/C++/CMake sources does invalidate the hook cache. Dart sources
  (including `lib/src/g/*.g.dart`) and the `user_defines` of `pubspec.yaml` are tracked by the SDK itself.
  Two consequences: a *missing* dependency makes Dart re-run the hook on every invocation, and a dependency
  outside the package (a byo OpenCV via `opencv_dir`) is not tracked at all.
- Run one test: `dart test test/core/mat_test.dart`.
- DNN tests read `test/models/*` (gitignored) — download `models.zip` from the GitHub release tag `dnn_test_files` (CI does this). videoio writer tests write to per-test temp dirs (so `dart test`'s parallel isolates never race on a shared file); only `test/images/small.mp4` is a committed read-only fixture. Other tests use `test/images/`.
- Coverage (CI): `dart pub global activate coverage && dart pub global run coverage:test_with_coverage --package . --package-name dartcv4`.
- CI caches `packages/dartcv/.dart_tool/hooks_runner/shared` (the CMake build tree for the native build, ~2 GB) and deletes the cached *results* (`hooks_runner/dartcv4`) after restoring. That is deliberate: the hook cache key does not cover `src/**`, so reusing a result would silently test a stale binary. With the build tree only, the hook re-runs and `cmake --build` redoes the changed files (~1 min instead of ~10). The wasm jobs cache `build/wasm` the same way.

## Regenerating FFI bindings

- Intended generator: `dart tool/ffigen.dart` from `packages/dartcv` (optionally followed by module names, e.g. `dart tool/ffigen.dart types ml`, to regenerate only those). Unlike the raw yaml runs, it also emits `@RecordUse()` and the `<module>.record_use_mapping.g.dart` tables that `hook/link.dart` consumes for tree-shaking.
- The same command then refreshes the web mirror in `lib/src/web/g/` by calling `tool/web/gen_web_bindings.dart` (`--no-web` skips that, and `dart tool/web/gen_web_bindings.dart [--check]` runs the web step alone: it only needs `lib/src/g/` on disk, which is what CI uses to fail when `lib/src/web/g/` is stale). Web support is described in `packages/dartcv/tool/web/README.md`.
- Do **not** use `make ffigen` / `dart run ffigen --config ffigen/*.yaml` for a full regen — it skips the record-use mapping, silently breaking tree-shaking.

## Style & checks

- Format with plain `dart format` — no flags. Line width (110) and trailing-comma handling come from the `formatter:` block of the nearest `analysis_options.yaml` (`page_width: 110`, `trailing_commas: preserve`); the CLI `--line-length` flag is not needed and CI does not pass it either, so local and CI output are identical.
- **Gotcha:** `dart format` reads only the *nearest* `analysis_options.yaml` and does not merge it with a parent package's. Every package **and example** under `packages/` therefore repeats the `formatter:` block; a new one that forgets it gets formatted at 80 columns instead of 110 (CI fails on it, and an editor would rewrap the files).
- Never format `lib/src/g/*.g.dart` (and any other generated `*.g.dart`): those are ffigen output and must match a regeneration. CI excludes them.
- CI (`.github/workflows/formatter.yaml`) runs the same `dart format` on every push and commits the result as `dart format ✅`; on a pull request it fails instead, since the token is read-only there. The SDK comes from `.fvmrc`, so a Flutter upgrade is one deliberate commit rather than a surprise repository-wide reformat.
- `dart analyze` passes. C++ follows `.clang-format` (LLVM-based, 2-space indent, column limit 100).
- Tree-shaking happens in `hook/link.dart`, never in `hook/build.dart`: only the link hook sees `input.recordedUses` (the `@ffi.Native` functions the compiler recorded for *this* build). With `treeshake: true` and `linkingEnabled` (AOT), `run_build.dart` routes the unrestricted library to the link hook and the CMake project adds the `dartcv_treeshake` target (`DARTCV_TREESHAKE_LINK` -> `dntcm_add_treeshake_target` from `package:native_toolchain_cmake`'s `cmake/treeshake.cmake`). The link hook builds the keep-list (recorded uses + the finalizer symbols from the ffigen `_SymbolAddresses`) and calls `CMakeBuilder.forLink(...).runLink(...)`, which writes `<build dir>/dntcm_keep_symbols_<lib>.txt` and links `dartcv_treeshake` with only those symbols. Without recorded uses, with `treeshake: false`, or when that link fails, the unrestricted library is bundled unchanged. Restricting the exports in the build hook (a "second build pass") was #462: the list never exists on a clean build and describes the previous app on the next one, so symbols the new code needs get stripped.
- `recordedUses` is only populated by SDKs with the `record-use` experiment enabled (stable Dart 3.10, e.g. the SDK pinned in `.fvmrc`, returns `null`), so locally an AOT build takes the pass-through path (`[dartcv4] link: keeping all exports (the build recorded no native usages)` in the hook's `stdout.txt`). To exercise the tree-shaken link, temporarily add symbols to `recordedSymbols` in `hook/link.dart` and run `dart build cli` on a package that depends on `dartcv4` by path (pointing `hooks.user_defines.dartcv4.opencv_dir` at an existing OpenCV install avoids rebuilding OpenCV); the link hook also writes `dartcv_link_diag.txt` into its output directory.
