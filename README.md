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

> [!IMPORTANT]
> For `v1.0.6` and later, auto setup is supported, libs will be downloaded from
> [Releases](https://github.com/rainyl/opencv_dart/releases) automatically.
>
> 1. If you want to setup manually, please set `OPENCV_DART_DISABLE_AUTO_BUILD` environment variable,
> e.g., `export OPENCV_DART_DISABLE_AUTO_BUILD=1`(for Unix-like)
> or `$env:OPENCV_DART_DISABLE_AUTO_BUILD=1`(for Windows)

> For `v1.0.4` and below, make sure run the following setup commands before running your app:
>
> 1. `flutter pub add opencv_dart` or `dart pub add opencv_dart`
> 2. `dart run opencv_dart:setup <platform> --arch <arch>`
>
> | `platform` | `arch`                             |
> | ---------- | ---------------------------------- |
> | `android`  | `x86_64` `arm64-v8a` `armeabi-v7a` |
> | `linux`    | `x64`                              |
> | `windows`  | `x64`                              |
> | `macos`    | `x64` `arm64`                      |
> | `ios`      | `x64` `arm64` `os64`               |
>
> - More questions: refer to [#29](https://github.com/rainyl/opencv_dart/issues/29) or open new issues.
> - If you are using flutter with [Native Assets](https://github.com/flutter/flutter/issues/129757) feature supported, consider using v2.x version, see more in [native-assets branch](https://github.com/rainyl/opencv_dart/tree/native-assets)
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
  - [For Developers](#for-developers)
    - [How to compile](#how-to-compile)
      - [1. Install dependencies](#1-install-dependencies)
      - [2. clone this repo](#2-clone-this-repo)
      - [3. compile](#3-compile)
      - [4. test](#4-test)
      - [5. Cross-compile for linux aarch64](#5-cross-compile-for-linux-aarch64)
  - [Contributors](#contributors)
  - [Acknowledgement](#acknowledgement)
  - [Star History](#star-history)
  - [License](#license)

<!-- Created by https://github.com/ekalinin/github-markdown-toc -->

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
| ximgproc      | :white_check_mark: | :white_check_mark: |                      |
| xobjdetect    | :white_check_mark: | :white_check_mark: |                      |
| xphoto        | :x:                | :x:                |                      |

- :x: : not finished
- :ballot_box_with_check: : partially supported
- :white_check_mark: : finished
- modules not in the above table are not considered, contributions are welcome
- ~~videoio: `cv.VideoCapture` from file is not supported yet~~ supported now.

### Usage

> [!WARNING]
> Since `v1.0.0`, nearly ALL APIs were changed to compitable with **opencv-python**,
> for example:
>
> ```dart
> // old API
> void cvtColor(Mat src, Mat dst, int code);
> // new API
> Mat cvtColor(Mat src, int code, {Mat? dst});
>
> // then usage will be changed from:
> cvtColor(src, dst, cv.COLOR_BGR2GRAY);
> // to:
> final dst = cvtColor(src, cv.COLOR_BGR2GRAY);
> // or:
> cvtColor(src, cv.COLOR_BGR2GRAY, dst: dst);
> ```
>
> If you really need updates for `v0.6.x`, open PRs and it will be merged to `v0.6` branch.

#### Pure Dart

```dart
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  cv.imwrite("test_cvtcolor.png", gray);
}
```

#### Flutter

> Android only
> 
> if you want build Android apk with custom arch , you can set `OPENCV_DART_ANDROID_SUPPORT_ARCHS` environment variable before **flutter build** 
>
> e.g., `export OPENCV_DART_ANDROID_SUPPORT_ARCHS=x86_64,arm64-v8a`(for Unix-like)
> 
> or `$env:OPENCV_DART_DISABLE_AUTO_BUILD=x86_64,arm64-v8a`(for Windows)

see [example](https://github.com/rainyl/opencv_dart/tree/main/example)

~~More examples are on the way...~~see [opencv_dart.examples](https://github.com/rainyl/opencv_dart.examples) and share yours

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

## For Developers

> [!NOTE]
> since v1.0.1, to speed up compile in CI, opencv is precompiled in [opencv.full](https://github.com/rainyl/opencv.full),
> and this repo will download the prebuilt static libraries from it's release,
> if you want to compile entirely by yourself,
> you can compile opencv and explicitly set `-o opencv_dir=<path to opencv>` for the
> below commands or set `OpenCV_DIR` environment variable.

### How to compile

#### 1. Install dependencies

- Windows: Install Visual Studio 2019 or Later, install [Conan](https://conan.io/)

  ```pwsh
   python3 -m pip install conan
   conan profile detect -f
  ```

  If you are usin [Scoop](https://scoop.sh/):

  ```pwsh
  scoop install conan
  ```

- Linux: Ubuntu as example

  ```bash
  sudo apt-get install build-essential libgtk-3-dev ffmpeg libavcodec-dev cmake \
    ninja-build libavformat-dev libavutil-dev libswscale-dev \
    libgflags-dev python3 libjpeg-dev libpng-dev libtiff-dev python3-pip

  python3 -m pip install conan
  conan profile detect -f
  ```

- macOS: XCode is required

  ```bash
  brew install --force --overwrite ninja ffmpeg@6 conan
  brew link --overwrite ffmpeg@6
  conan profile detect -f
  ```

#### 2. clone this repo

```bash
git clone https://github.com/rainyl/opencv_dart.git
cd opencv_dart
```

#### 3. compile

- Windows:

   ```pwsh
   conan build . -b missing -s compiler.cppstd=20
   ```

- Linux, macos:

    ```bash
    conan build . -b missing
    ```

- android

If you want to use your own NDK instead of conan maintained one, please set `ANDROID_NDK_HOME`
or `ANDROID_NDK_ROOT` environment variable, e.g., `export ANDROID_NDK_HOME=/opt/android-ndk-r26c`

  ```bash
  conan build . -b missing -pr:h profiles/android-<arch> -c tools.android:ndk_path="<ABSOLUTE path for ndk>"
  ```

- ios:

  ```bash
  conan build . -b missing -pr:h profiles/ios-<arch>
  ```

#### 4. test

- Set `OPENCV_DART_LIB_PATH` environment variable to the path of the compiled dynamic library,
e.g., `export OPENCV_DART_LIB_PATH=`pwd`/linux/libopencv_dart.so`
or `$ENV:OPENCV_DART_LIB_PATH=$PWD\windows\opencv_dart.dll`
- or append the lib path to the library search path of your system
- If you want to test using vscode, add above variable to `"dart.env"` in `settings.json`

#### 5. Cross-compile for linux aarch64

Compiling for linux aarch64 requires GCC 13 and newer,
conan toolchain for linux arm is located in [opencv.full](https://github.com/rainyl/opencv.full/tree/linux-aarch64/profiles), explore more there.

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
