# opencv_dart

OpenCV Bindings for Dart Language.

<p align="center">
<a href="https://codecov.io/github/rainyl/opencv_dart" ><img src="https://codecov.io/github/rainyl/opencv_dart/graph/badge.svg?token=2H0WWT39SN"/></a>
<a href="https://github.com/rainyl/opencv_dart"><img src="https://img.shields.io/github/stars/rainyl/opencv_dart.svg?style=flat&logo=github&label=stars" alt="Star on Github"></a>
<a href="https://opensource.org/license/apache-2-0"><img src="https://img.shields.io/github/license/rainyl/opencv_dart" alt="License: Apache-2.0"></a>
</p>

**!!!This package is experimental and APIs may change in the future!!!**

*WIP, contributions are welcome!*

| Platform | Supported          | Tested                  | Prebuilt Binaries              |
| -------- | ------------------ | ----------------------- | ------------------------------ |
| Android  | :white_check_mark: | :ballot_box_with_check: | x86_64, arm64-v8a, armeabi-v7a |
| iOS      | :white_check_mark: | :ballot_box_with_check: | arm64, x64(Simulator)          |
| Linux    | :white_check_mark: | :white_check_mark:      | x64                            |
| Windows  | :white_check_mark: | :white_check_mark:      | x64                            |
| macOS    | :white_check_mark: | :white_check_mark:      | x64, arm64                     |

## BREAKING CHANGES

The refactor of [#13](https://github.com/rainyl/opencv_dart/issues/13) bas been finished,
since `v1.0.0`, nearly ALL APIs were changed to compitable with **opencv-python**,
for example:

```dart
// old API
void cvtColor(Mat src, Mat dst, int code);
// new API
Mat cvtColor(Mat src, int code, {Mat? dst});

// then usage will be changed from:
cvtColor(src, dst, cv.COLOR_BGR2GRAY);
// to:
final dst = cvtColor(src, cv.COLOR_BGR2GRAY);
// or:
cvtColor(src, cv.COLOR_BGR2GRAY, dst: dst);
```

The new APIs have been published in `v1.0.0`, if you are still using the old ones and
do not want to upgrade, you can use the old versions less than `v1.0.0`.

The OLD APIs won't get any updates from maintainer since `v0.6.7`,
if you really need updates, open PRs and I will merge it to `v0.6` branch.

## IMPORTANT

Please run

```bash
dart run opencv_dart:setup <platform> --arch <arch>
```

to download prebuilt binaries.

- **platform**: `auto` `android` `linux` `windows` `macos` `ios`
- for **Windows**, arch: `x64`
- for **Linux**, arch: `x64`
- for **macOS**, arch: `x64` `arm64`
- for **IOS**, arch: `x64` `arm64`
- for **Android**, arch: `x86_64` `arm64-v8a` `armeabi-v7a`
- run `dart run opencv_dart:setup -h` to see more options

**Please use v0.3.0 and later version.**

## Example

![example](https://raw.githubusercontent.com/rainyl/opencv_dart/main/images/example.png)

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
| wechat_qrcode | :x:                | :x:                |                      |
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
- ~~videoio: `cv.VideoCapture` from file is not supported yet~~ supported now.

### Usage

```dart
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = cv.Mat.empty();

  cv.cvtColor(img, gray, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  cv.imwrite("test_cvtcolor.png", gray);
}
```

More examples are on the way...

### TODO

- [x] ~~compile libs for android, linux~~
- [x] ~~support for iOS, macOS~~
- [ ] add more examples
- [ ] documentation
- [x] modify C wrapper to catch exceptions
- [ ] Native Assets
- [ ] async?
- [ ] more/full test coverage
- [x] ~~directly include opencv source code, refactor cmakelists.txt~~

## For Developers

This package is in heavy development, dynamic libraries for Windows and linux have been compiled, for other platforms, you need to compile it yourself.

### How to compile

1. prepare a compiler.

   windows: Install Visual Studio 2019 or Later

   ubuntu: reference [opencv official build guide](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html) to install

   ```bash
   sudo apt-get install build-essential libgtk-3-dev ffmpeg libavcodec-dev cmake \
      ninja-build ccache nasm libavformat-dev libavutil-dev libswscale-dev \
      libgflags-dev python3 libjpeg-dev libpng-dev libtiff-dev python3-pip
   ```

   macos:

   ```bash
   brew install --force --overwrite ninja ccache ffmpeg nasm cmake
   ```

   from v0.6.4, build system has been migrated to [conan](https://conan.io/)

   ```bash
      python3 -m pip install conan
      conan profile detect -f
   ```

2. clone this repo, `git clone https://github.com/rainyl/opencv_dart.git`
3. `cd opencv_dart`
4. compile

   for windows:

   ```pwsh
   conan build . -b missing -s compiler.cppstd=20
   ```

    for linux, macos:

    ```bash
    conan build . -b missing
    ```

   for android, you need to download [android ndk](https://developer.android.com/ndk/downloads) ~~and [opencv for android sdk](https://opencv.org/releases/), extract opencv sdk and copy and rename `OpenCV-android-sdk` to `build/opencv/android` directory.~~ NO need for opencv sdk now, will be compiled from source to enable contrib modules

   ```bash
   conan build . -b missing -pr:h profiles/android-<arch> -c tools.android:ndk_path="<ABSOLUTE path for ndk>"
   ```

   for ios:

   ```bash
   echo "tools.cmake.cmaketoolchain:user_toolchain=[\"`pwd`/profiles/ios.toolchain.cmake\"]" >> profiles/ios-<arch>
   conan build . -b missing -pr:h profiles/ios-<arch>
   ```

5. If you want to test using vscode, add dynamic library path to `"dart.env"` in `settings.json`

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## Star History

[![Star History Chart](https://api.star-history.com/svg?repos=rainyl/opencv_dart&type=Date)](https://star-history.com/#rainyl/opencv_dart&Date)

## License

Apache-2.0 License
