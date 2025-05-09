# opencv_dart

OpenCV for Flutter, includes all modules. if `videoio` and `highgui` are not reqired,
use [opencv_core](https://pub.dev/packages/opencv_core)

> [!IMPORTANT]
>
> From `v1.3.0`, dynamic libraries will be built locally, invoked by flutter during the build.
> Note: OpenCV SDK (~100M) will be downloaded via `FetchContent` of cmake, you can
> set `DARTCV_CACHE_DIR` environment variable to cache it and avoid downloading it again.
> e.g., `export DARTCV_CACHE_DIR=$HOME/.cache/dartcv`
>
> - Q&A: [#212](https://github.com/rainyl/opencv_dart/issues/212) or open new issues.
> - ~~If you are using flutter with [Native Assets](https://github.com/flutter/flutter/issues/129757) feature supported, consider using v2.x version, see more in [native-assets branch](https://github.com/rainyl/opencv_dart/tree/native-assets)~~ Won't update until `Native Assets` being stable.

## Supported platforms

| Platform | Supported          | Tested             | Platforms                      |
| -------- | ------------------ | ------------------ | ------------------------------ |
| Android  | :white_check_mark: | :white_check_mark: | x86_64, arm64-v8a, armeabi-v7a |
| iOS      | :white_check_mark: | :white_check_mark: | arm64, x64(Simulator)          |
| Linux    | :white_check_mark: | :white_check_mark: | x64, arm64                     |
| Windows  | :white_check_mark: | :white_check_mark: | x64, arm64                     |
| macOS    | :white_check_mark: | :white_check_mark: | x64, arm64                     |

## Supported modules

[Supported modules](https://github.com/rainyl/opencv_dart?tab=readme-ov-file#status)

## Package Size

![opencv_dart_size_report](images/opencv_dart_size_report.svg)

## Examples

see [example](https://github.com/rainyl/opencv_dart/tree/main/packages/opencv_dart/example)

More examples refer to [awesome-opencv_dart](https://github.com/rainyl/awesome-opencv_dart) and share yours

## Screenshots

see [Demos](https://github.com/rainyl/opencv_dart?tab=readme-ov-file#Demos)

## License

[Apache-2.0 License](LICENSE)

## Customizing OpenCV Modules

You can enable or disable specific OpenCV modules for your build by specifying them in your app's `pubspec.yaml` file under the `dartcv_modules` section. A Dart script will read this section and generate a `dartcv_modules.cmake` file, which is used by the build system.

### Example `pubspec.yaml` configuration

```yaml
dartcv_modules:
  exclude:
    - contrib
    - dnn
    - features2d
# or
# dartcv_modules:
#   include:
#     - core
#     - imgproc
```

- Use `exclude` to disable specific modules, or `include` to enable only specific modules.
- The Dart script will generate a `dartcv_modules.cmake` file in your app root before building.
- If neither is specified, all default modules will be enabled.

### iOS/macOS Module Selection

For iOS and macOS, module selection is handled via CocoaPods. In your `ios/Podfile` or `macos/Podfile`, specify only the modules you need:

```ruby
pod 'DartCvIOS/core', '4.11.0.2'
pod 'DartCvIOS/imgproc', '4.11.0.2'
# Add more as needed
```

- Only the modules you list will be included in your app.
- Make sure your Podfile matches your desired module configuration.

### Generating the CMake Config

The build system will automatically generate the CMake config from your `pubspec.yaml` at build time. You do not need to run any script manually.
