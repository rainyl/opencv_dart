# DartCv

OpenCV bindings for Dart language.

[dartcv4](https://pub.dev/packages/dartcv4) is only for pure dart, for Flutter, use [opencv_core](https://pub.dev/packages/opencv_core),
if videoio module is required, use [opencv_dart](https://pub.dev/packages/opencv_dart)

## Install

- `dart pub add dartcv4` or Add dartcv4 to `pubspec.yaml`
- Prepare libraries for your platform, you have 2 options (macos: please build from source.)
  - build from source, see [workflows](https://github.com/rainyl/dartcv/tree/main/.github/workflows)
  - download prebuilt libraries from [release](https://github.com/rainyl/dartcv/releases)
  - move/copy the libraries to a directory, e.g., `~/.dartcv`
- Setup environment variables
  - windows: append the above path to `PATH`
  - linux: append the above path to `LD_LIBRARY_PATH`
  - macos: append the above path to `DYLD_FALLBACK_LIBRARY_PATH`
