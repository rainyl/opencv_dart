# opencv_dart

OpenCV Bindings for Dart Language.

<p align="center">
<a href="https://codecov.io/github/rainyl/opencv_dart" ><img src="https://codecov.io/github/rainyl/opencv_dart/graph/badge.svg?token=2H0WWT39SN"/></a>
<a href="https://github.com/rainyl/opencv_dart"><img src="https://img.shields.io/github/stars/rainyl/opencv_dart.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
<a href="https://pub.dev/packages/opencv_dart"><img src="https://img.shields.io/pub/v/opencv_dart.svg?logo=dart" alt="https://pub.dev/packages/opencv_dart"></a>
<a href="https://pub.dev/packages/opencv_dart"><img src="https://img.shields.io/pub/popularity/opencv_dart?logo=dart" alt="https://pub.dev/packages/opencv_dart"></a>
<a href="https://opensource.org/license/apache-2-0"><img src="https://img.shields.io/github/license/rainyl/opencv_dart" alt="License: Apache-2.0"></a>
<a href="https://github.com/rainyl/opencv_dart/actions/workflows/build_test_native_assets.yaml"><img src="https://github.com/rainyl/opencv_dart/actions/workflows/build_test_native_assets.yaml/badge.svg" alt="Native Assets Build"></a>
</p>

> [!IMPORTANT]
> `v2.x` is prepared for [Native Assets](https://github.com/dart-lang/sdk/issues/50565), Use only if you know what you are doing!
>
> `v2.x` doesn't need to download the prebuild binaries but requires `Native Assets` feature, which is still experimental, see more here: https://github.com/dart-lang/sdk/issues/50565
>
> [conan](https://conan.io/) and cmake are required
>
> Usage:
>
> for pure dart:
>
> 1. take a look at https://pub.dev/packages/opencv_dart/versions and find the latest version, e.g., `2.0.0-dev.2`
> 2. add to your `pubspec.yaml`
> 3. `dart --enable-experiment=native-assets run <path-to-your-code>`
>
> for flutter:
>
> 1. take a look at https://pub.dev/packages/opencv_dart/versions and find the latest version, e.g., `2.0.0-dev.2`
> 2. add to your `pubspec.yaml`
> 3. `flutter config --enable-native-assets`
> 4. `flutter run`
>

> [!NOTE]
> WIP, contributions are welcome!

- [opencv\_dart](#opencv_dart)
  - [Example](#example)
  - [Supported Platforms](#supported-platforms)
  - [Status](#status)
    - [Core Modules](#core-modules)
    - [Contrib Modules](#contrib-modules)
    - [Usage](#usage)
      - [Pure Dart](#pure-dart)
      - [Flutter](#flutter)
    - [TODO](#todo)
  - [Contributors](#contributors)
  - [Acknowledgement](#acknowledgement)
  - [Star History](#star-history)
  - [License](#license)

## Example

![example](https://raw.githubusercontent.com/rainyl/opencv_dart/main/images/example.png)

## Supported Platforms

| Platform | Supported          | Tested                  | Prebuilt Binaries              |
| -------- | ------------------ | ----------------------- | ------------------------------ |
| Android  | :white_check_mark: | :ballot_box_with_check: | x86_64, arm64-v8a, armeabi-v7a |
| iOS      | :white_check_mark: | :ballot_box_with_check: | arm64, x64(Simulator)          |
| Linux    | :white_check_mark: | :white_check_mark:      | x64                            |
| Windows  | :white_check_mark: | :white_check_mark:      | x64                            |
| macOS    | :white_check_mark: | :white_check_mark:      | x64, arm64                     |

## Status

### Core Modules

| module     | Binding status          | Test status             | description             |
| ---------- | ----------------------- | ----------------------- | ----------------------- |
| core       | :white_check_mark:      | :white_check_mark:      | Core module             |
| calib3d    | :white_check_mark:      | :white_check_mark:      | Calib3D module          |
| dnn        | :white_check_mark:      | :white_check_mark:      | DNN module              |
| features2d | :white_check_mark:      | :white_check_mark:      | Features2D module       |
| gapi       | :x:                     | :x:                     | GAPI module             |
| highgui    | :white_check_mark:      | :white_check_mark:      | HighGUI module          |
| imgcodecs  | :white_check_mark:      | :white_check_mark:      | ImageCodecs module      |
| imgproc    | :white_check_mark:      | :white_check_mark:      | ImageProc module        |
| ml         | :x:                     | :x:                     | ML module               |
| objdetect  | :white_check_mark:      | :white_check_mark:      | Object Detection module |
| photo      | :white_check_mark:      | :white_check_mark:      | Photo module            |
| stitching  | :ballot_box_with_check: | :ballot_box_with_check: | Stitching module        |
| svd        | :white_check_mark:      | :white_check_mark:      | SVD module              |
| video      | :white_check_mark:      | :white_check_mark:      | Video module            |
| videoio    | :white_check_mark:      | :white_check_mark:      | VideoIO module          |

### Contrib Modules

| module        | Binding status     | Test status        | description          |
| ------------- | ------------------ | ------------------ | -------------------- |
| aruco         | :white_check_mark: | :white_check_mark: | ArUco module         |
| img_hash      | :white_check_mark: | :white_check_mark: | Image hashing module |
| cuda          | :x:                | :x:                |                      |
| wechat_qrcode | :white_check_mark: | :white_check_mark: |                      |
| bgsegm        | :x:                | :x:                |                      |
| superres      | :x:                | :x:                |                      |
| xfeatures2d   | :x:                | :x:                |                      |
| ximgproc      | :x:                | :x:                |                      |
| xobjdetect    | :x:                | :x:                |                      |
| xphoto        | :x:                | :x:                |                      |

- :x: : not finished
- :ballot_box_with_check: : partially supported
- :white_check_mark: : finished
- modules not in the above table are not considered, contributions are welcome

### Usage

#### Pure Dart

```dart
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = cv.cvtColor(img, gray, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  cv.imwrite("test_cvtcolor.png", gray);
}
```

#### Flutter

see [example](https://github.com/rainyl/opencv_dart/tree/native-assets/example)

~~More examples are on the way...~~ see [opencv_dart.examples](https://github.com/rainyl/opencv_dart.examples) and share yours

### TODO

- [x] ~~compile libs for android, linux~~
- [x] ~~support for iOS, macOS~~
- [x] ~~add more examples~~
- [ ] documentation
- [x] ~~modify C wrapper to catch exceptions~~
- [x] ~~Native Assets~~
- [ ] async?
- [x] more/full test coverage
- [x] ~~directly include opencv source code, refactor cmakelists.txt~~

## Contributors

<!-- readme: contributors,TotemaT -start -->
<table>
	<tbody>
		<tr>
            <td align="center">
                <a href="https://github.com/rainyl">
                    <img src="https://avatars.githubusercontent.com/u/30213663?v=4" width="100;" alt="rainyl"/>
                    <br />
                    <sub><b>rainy liu</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/abdelaziz-mahdy">
                    <img src="https://avatars.githubusercontent.com/u/25157308?v=4" width="100;" alt="abdelaziz-mahdy"/>
                    <br />
                    <sub><b>Abdelaziz Mahdy</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/Jiinwoo">
                    <img src="https://avatars.githubusercontent.com/u/46522752?v=4" width="100;" alt="Jiinwoo"/>
                    <br />
                    <sub><b>JinWoo Jung</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/mdeleau">
                    <img src="https://avatars.githubusercontent.com/u/112755117?v=4" width="100;" alt="mdeleau"/>
                    <br />
                    <sub><b>mdeleau</b></sub>
                </a>
            </td>
            <td align="center">
                <a href="https://github.com/totemat">
                    <img src="https://avatars.githubusercontent.com/u/9088953?v=4" width="100;" alt="totemat"/>
                    <br />
                    <sub><b>Matteo T.</b></sub>
                </a>
            </td>
		</tr>
	<tbody>
</table>
<!-- readme: contributors,TotemaT -end -->

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=rainyl/opencv_dart&type=Date)](https://star-history.com/#rainyl/opencv_dart&Date)

## License

Apache-2.0 License
