# opencv_dart_example

Demonstrates how to use the opencv_dart plugin.

## Getting Started

> [!WARNING]
> v2.x doesn't need to download the prebuild binaries but requires `Native Assets` feature, which is still experimental, see more here: https://github.com/dart-lang/sdk/issues/50565
>
> [conan](https://conan.io/) and cmake are required

To use v2.x:

for pure dart:

1. take a look at https://pub.dev/packages/opencv_dart/versions and find the latest version, e.g., `2.0.0-dev.2`
2. add to your `pubspec.yaml`
3. `dart --enable-experiment=native-assets run <path-to-your-code>`

for flutter:

1. take a look at https://pub.dev/packages/opencv_dart/versions and find the latest version, e.g., `2.0.0-dev.2`
2. add to your `pubspec.yaml`
3. `flutter config --enable-native-assets`
4. `flutter run`
