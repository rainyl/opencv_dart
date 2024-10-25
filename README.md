# opencv_dart

OpenCV Bindings for Dart Language. Support both asynchronous and synchronous!

<p align="center">
<a href="https://codecov.io/github/rainyl/opencv_dart" ><img src="https://codecov.io/github/rainyl/opencv_dart/graph/badge.svg?token=2H0WWT39SN"/></a>
<a href="https://github.com/rainyl/opencv_dart"><img src="https://img.shields.io/github/stars/rainyl/opencv_dart.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
<a href="https://pub.dev/packages/opencv_dart"><img src="https://img.shields.io/pub/v/opencv_dart.svg?logo=dart" alt="https://pub.dev/packages/opencv_dart"></a>
<a href="https://pub.dev/packages/opencv_dart"><img src="https://img.shields.io/pub/popularity/opencv_dart?logo=dart" alt="https://pub.dev/packages/opencv_dart"></a>
<a href="https://opensource.org/license/apache-2-0"><img src="https://img.shields.io/github/license/rainyl/opencv_dart" alt="License: Apache-2.0"></a>
<a href="https://github.com/rainyl/opencv_dart/actions/workflows/build_test_native_assets.yaml"><img src="https://github.com/rainyl/opencv_dart/actions/workflows/build_test_native_assets.yaml/badge.svg" alt="Native Assets Build"></a>
<a href="https://discord.gg/rtkC7MWvPJ"><img src="https://img.shields.io/discord/1268767086683885598?logo=discord" alt="Discord Server"></a>
</p>

> [!NOTE]
> WIP, APIs may change in the future, contributions are welcome!

- [opencv\_dart](#opencv_dart)
  - [Example](#example)
  - [Supported Platforms](#supported-platforms)
  - [Status](#status)
    - [Core Modules](#core-modules)
    - [Contrib Modules](#contrib-modules)
    - [Usage](#usage)
      - [Pure Dart](#pure-dart)
      - [Flutter](#flutter)
    - [Screenshots](#screenshots)
    - [TODO](#todo)
  - [Contributors](#contributors)
  - [Acknowledgement](#acknowledgement)
  - [Star History](#star-history)
  - [License](#license)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

## Example

![example](https://raw.githubusercontent.com/rainyl/opencv_dart/main/images/example.png)

## Supported Platforms

| Platform | Supported          | Tested             | Platforms                      |
| -------- | ------------------ | ------------------ | ------------------------------ |
| Android  | :white_check_mark: | :white_check_mark: | x86_64, arm64-v8a, armeabi-v7a |
| iOS      | :white_check_mark: | :white_check_mark: | arm64, x64(Simulator)          |
| Linux    | :white_check_mark: | :white_check_mark: | x64, arm64                     |
| Windows  | :white_check_mark: | :white_check_mark: | x64, arm64                     |
| macOS    | :white_check_mark: | :white_check_mark: | x64, arm64                     |

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
| ximgproc      | :white_check_mark: | :white_check_mark: |                      |
| xobjdetect    | :white_check_mark: | :white_check_mark: |                      |
| xphoto        | :x:                | :x:                |                      |
| quality       | :white_check_mark: | :white_check_mark: |                      |

- :x: : not finished
- :ballot_box_with_check: : partially supported
- :white_check_mark: : finished
- modules not in the above table are not considered, contributions are welcome
- ~~videoio: `cv.VideoCapture` from file is not supported yet~~ supported now.

### Usage

#### Pure Dart

```dart
import 'package:dartcv4/dartcv.dart' as cv;

void main() {
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  cv.imwrite("test_cvtcolor.png", gray);
}
```

#### Flutter

see [example](https://github.com/rainyl/opencv_dart/tree/main/example)

~~More examples are on the way...~~ see [awesome-opencv_dart](https://github.com/rainyl/awesome-opencv_dart) and share yours

### Screenshots

| | |
|:-------------------------:|:-------------------------:|
|<img width="480" alt="example" src="https://raw.githubusercontent.com/rainyl/opencv_dart/main/images/example.png"> |  <img width="480" alt="dnn_minist" src="https://raw.githubusercontent.com/rainyl/awesome-opencv_dart/refs/heads/main/examples/dnn_mnist/images/screenshot.png">|
|<img width="480" alt="videoio texture renderer" src="https://raw.githubusercontent.com/rainyl/awesome-opencv_dart/30fa0f501cea4a8a77d7c2f0e30c2b0c64b7dbec/examples/texture_renderer/texture_rgba_renderer.gif">|<img width="480" alt="videoio texture renderer" src="https://raw.githubusercontent.com/rainyl/awesome-opencv_dart/refs/heads/main/examples/stitching/stitching_demo.png">|

### TODO

- [x] ~~compile libs for android, linux~~
- [x] ~~support for iOS, macOS~~
- [x] ~~add more examples~~
- [ ] documentation
- [x] ~~modify C wrapper to catch exceptions~~
- [x] Native Assets, see `native-assets` branch
- [x] async
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
                <a href="https://github.com/einsitang">
                    <img src="https://avatars.githubusercontent.com/u/1745525?v=4" width="100;" alt="einsitang"/>
                    <br />
                    <sub><b>爱因斯唐</b></sub>
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
