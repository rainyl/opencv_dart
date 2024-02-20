# opencv_dart

OpenCV Bindings for Dart Language.

## TODO

### Bindings

- [ ] aruco
  - [ ] test
- [ ] asyncarray
  - [ ] test
- [ ] calib3d
  - [ ] test
- [x] core
  - [ ] test
- [ ] dnn
  - [ ] test
- [ ] features2d
  - [ ] test
- [ ] highgui
  - [ ] test
- [x] imgcodecs
  - [ ] test
- [x] imgproc
  - [ ] test
- [ ] objdetect
  - [ ] test
- [ ] photo
  - [ ] test
- [ ] svd
  - [ ] test
- [x] video
  - [ ] test
- [x] videoio
  - [ ] test

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## License

Apache-2.0 License

## Getting Started

This project is a starting point for a Flutter
[FFI plugin](https://docs.flutter.dev/development/platform-integration/c-interop),
a specialized package that includes native code directly invoked with Dart FFI.

## Project structure

This template uses the following structure:

* `src`: Contains the native source code, and a CmakeFile.txt file for building
  that source code into a dynamic library.

* `lib`: Contains the Dart code that defines the API of the plugin, and which
  calls into the native code using `dart:ffi`.

* platform folders (`android`, `ios`, `windows`, etc.): Contains the build files
  for building and bundling the native code library with the platform application.

## Building and bundling native code

The `pubspec.yaml` specifies FFI plugins as follows:

```yaml
  plugin:
    platforms:
      some_platform:
        ffiPlugin: true
```

This configuration invokes the native build for the various target platforms
and bundles the binaries in Flutter applications using these FFI plugins.

This can be combined with dartPluginClass, such as when FFI is used for the
implementation of one platform in a federated plugin:

```yaml
  plugin:
    implements: some_other_plugin
    platforms:
      some_platform:
        dartPluginClass: SomeClass
        ffiPlugin: true
```

A plugin can have both FFI and method channels:

```yaml
  plugin:
    platforms:
      some_platform:
        pluginClass: SomeName
        ffiPlugin: true
```

The native build systems that are invoked by FFI (and method channel) plugins are:

* For Android: Gradle, which invokes the Android NDK for native builds.
  * See the documentation in android/build.gradle.
* For iOS and MacOS: Xcode, via CocoaPods.
  * See the documentation in ios/opencv_dart.podspec.
  * See the documentation in macos/opencv_dart.podspec.
* For Linux and Windows: CMake.
  * See the documentation in linux/CMakeLists.txt.
  * See the documentation in windows/CMakeLists.txt.

## Binding to native code

To use the native code, bindings in Dart are needed.
To avoid writing these by hand, they are generated from the header file
(`src/opencv_dart.h`) by `package:ffigen`.
Regenerate the bindings by running `flutter pub run ffigen --config ffigen.yaml`.

