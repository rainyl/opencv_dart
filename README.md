# opencv_dart

OpenCV Bindings for Dart Language.

**!!!This package is experimental and APIs may change in the future!!!**

*WIP, contributions are welcome!*

| Platform | Supported          | Tested                  | Prebuilt Binaries              |
| -------- | ------------------ | ----------------------- | ------------------------------ |
| Android  | :white_check_mark: | :ballot_box_with_check: | x86_64, arm64-v8a, armeabi-v7a |
| iOS      | :x:                | :x:                     | :x:                            |
| Linux    | :white_check_mark: | :white_check_mark:      | x64                            |
| Windows  | :white_check_mark: | :white_check_mark:      | x64                            |
| macOS    | :white_check_mark: | :white_check_mark:      | x64, arm64                     |

- I have no Apple devices, so iOS and ~~macOS are not supported yet~~ macOS compiled by Github Workflow available now, try it!
- Theorically the dart codes will work for iOS, you can compile binaries by yourself, contributions are welcome!

## IMPORTANT

After added to `pubspec.yaml` or install by commandline,
please run `dart run opencv_dart:setup <platform> --arch <arch>` to download
prebuilt binaries.

- `platform`: `auto` `android` `linux` `windows` `macos`
- `arch`: `auto` `x86` `x64` `arm64`(macOS only) `x86_64`(android only) `arm64-v8a`(android only) `armeabi-v7a`(android only)
- run `dart run opencv_dart:setup -h` to see more options

**Please use v0.3.0 and later version.**

## Status

| module     | Binding status          | Test status             | description             |
| ---------- | ----------------------- | ----------------------- | ----------------------- |
| aruco      | :white_check_mark:      | :white_check_mark:      | ArUco module            |
| core       | :white_check_mark:      | :white_check_mark:      | Core module             |
| features2d | :white_check_mark:      | :white_check_mark:      | Features2D module       |
| highgui    | :white_check_mark:      | :white_check_mark:      | HighGUI module          |
| imgcodecs  | :white_check_mark:      | :white_check_mark:      | ImageCodecs module      |
| imgproc    | :white_check_mark:      | :white_check_mark:      | ImageProc module        |
| objdetect  | :white_check_mark:      | :white_check_mark:      | Object Detection module |
| svd        | :white_check_mark:      | :white_check_mark:      | SVD module              |
| video      | :white_check_mark:      | :white_check_mark:      | Video module            |
| videoio    | :white_check_mark:      | :white_check_mark:      | VideoIO module          |
| asyncarray | :white_check_mark:      | :white_check_mark:      | AsyncArray module       |
| calib3d    | :white_check_mark:      | :white_check_mark:      | Calib3D module          |
| dnn        | :white_check_mark:      | :white_check_mark:      | DNN module              |
| photo      | :white_check_mark:      | :white_check_mark:      | Photo module            |
| stitching  | :ballot_box_with_check: | :ballot_box_with_check: | Stitching module        |
| cuda       | :x:                     | :x:                     | CUDA module             |
| contrib    | :x:                     | :x:                     | Contrib module          |

- :x: : not finished
- :ballot_box_with_check: : partially supported
- :white_check_mark: : finished
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
- [ ] support for iOS, macOS
- [ ] add more examples
- [ ] documentation
- [ ] modify C wrapper to catch exceptions
- [ ] Native Assets
- [ ] async?

## For Developers

This package is in heavy development, dynamic libraries for Windows and linux have been compiled, for other platforms, you need to compile it yourself.

### How to compile

1. prepare a compiler.

   windows: Install Visual Studio 2019 or Later

   ubuntu: reference [opencv official build guide](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html) to install

   ```bash
   sudo apt-get install build-essential libgtk-3-dev ffmpeg libavcodec-dev cmake \
      ninja-build ccache nasm libavformat-dev libavutil-dev libswscale-dev \
      libgflags-dev python3 libjpeg-dev libpng-dev libtiff-dev
   ```

   macos:

   ```bash
   brew install --force --overwrite ninja ccache ffmpeg nasm
   ```

2. install dependencies: `cmake`, `python`, add to PATH
3. clone this repo, `git clone --recursive https://github.com/rainyl/opencv_dart.git`
4. `cd opencv_dart`
5. compile opencv

   for windows:

   ```pwsh
   python .\scripts\build.py --opencv --build-dir build --src src windows --arch x64
   ```

    for linux:

    ```bash
    python ./scripts/build.py --opencv --build-dir build --src src linux --arch x64
    ```

   for macOS:

   ```bash
   python3 ./scripts/build.py --opencv --build-dir build --src src macos --arch <arm64, x64>
   ```

   for android, you need to download [android ndk](https://developer.android.com/ndk/downloads) and [opencv for android sdk](https://opencv.org/releases/), extract opencv sdk and copy and rename `OpenCV-android-sdk` to `build/opencv/android` directory.

6. compile this package along with gocv.

   windows:

   ```bash
    python ./scripts/build.py --dart --build-dir build --src src windows --arch x64
    ```

   linux:

   ```bash
    python ./scripts/build.py --dart --build-dir build --src src linux --arch x64
   ```

   macOS:

   ```bash
   python3 ./scripts/build.py --dart --build-dir build --src src macos --arch <x64, arm64>
   ```

   Android:

   ```bash
    python ./scripts/build.py --dart --build-dir build --src src --android-ndk <Android NDK path> android --arch <x86_64, arm64-v8a, armeabi-v7a>
    ```

7. If you want to test using vscode, add dynamic library path to `"dart.env"` in `settings.json`

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## License

Apache-2.0 License
