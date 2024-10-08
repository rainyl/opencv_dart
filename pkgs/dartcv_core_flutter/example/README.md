# dartcv_core_example

Demonstrates how to use the dartcv_core plugin.

## Getting Started

### v1.x

1. `flutter pub add dartcv_core` or `dart pub add dartcv_core`
2. `dart run dartcv_core:setup <platform> --arch <arch>`

| `platform` | `arch`                             |
| ---------- | ---------------------------------- |
| `auto`     | `x64`                              |
| `android`  | `x86_64` `arm64-v8a` `armeabi-v7a` |
| `linux`    | `x64`                              |
| `windows`  | `x64`                              |
| `macos`    | `x64` `arm64`                      |
| `ios`      | `x64` `arm64`                      |

> [!NOTE]
> for `windows`, `linux`, `macos`, and `ios`, libs with different `arch` will use same path, e.g.,
> for windows it will always be `dartcv_core/windows/dartcv_core.dll`
> (note it's not your app directory but the `dartcv_core` directory),
> so if you want to switch between different architectures,
> you have to rerun `dart run dartcv_core:setup <platform> --arch <arch>` with correct `arch`, this
> is the limitation of Dart/Flutter.
>
> for android, run with different `arch` will download the corresponding `libdartcv_core.so` to `dartcv_core/android/src/main/jniLibs/<arch>`, so if you want to exclude some `arch`, just delete the target `arch` folder

3. run app as normal and the dynamic library will be copied automatically

### v2.x

> [!WARNING]
> v2.x doesn't need to download the prebuild binaries but requires `Native Assets` feature, which is still experimental, see more here: https://github.com/dart-lang/sdk/issues/50565
>
> [conan](https://conan.io/) and cmake are required

To use v2.x:

for pure dart:

1. take a look at https://pub.dev/packages/dartcv_core/versions and find the latest version, e.g., `2.0.0-dev.2`
2. add to your `pubspec.yaml`
3. `dart --enable-experiment=native-assets run <path-to-your-code>`

for flutter:

1. take a look at https://pub.dev/packages/dartcv_core/versions and find the latest version, e.g., `2.0.0-dev.2`
2. add to your `pubspec.yaml`
3. `flutter config --enable-native-assets`
4. `flutter run`
