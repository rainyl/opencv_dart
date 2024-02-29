# opencv_dart

OpenCV Bindings for Dart Language.

**!!!This package is experiment and APIs may change in the future!!!**

*Many tests unfinished, contributions are welcome!*

Prebuilt binaries for Android(arm64-v8a, armeabi-v7a, x86_64), Linux(x64) and Windows(x64) are available,for other platforms, you have to build them your self.

## IMPORTANT

After added to `pubspec.yaml` or install by commandline,
please run `dart run opencv_dart:setup -p <platform> -a <arch>` to download
prebuilt binaries.

- `platform`: `auto` `android` `linux` `windows`
- `arch`: `auto` `x86` `x64` `x86_64`(android only) `arm64-v8a`(android only) `armeabi-v7a`(android only)

**Please use v0.3.0 and later version.**

## Status

| module     | Binding status     | Test status        | description             |
| ---------- | ------------------ | ------------------ | ----------------------- |
| aruco      | :white_check_mark: | :white_check_mark: | ArUco module            |
| core       | :white_check_mark: | :white_check_mark: | Core module             |
| features2d | :white_check_mark: | :white_check_mark: | Features2D module       |
| highgui    | :white_check_mark: | :white_check_mark: | HighGUI module          |
| imgcodecs  | :white_check_mark: | :white_check_mark: | ImageCodecs module      |
| imgproc    | :white_check_mark: | :white_check_mark: | ImageProc module        |
| objdetect  | :white_check_mark: | :white_check_mark: | Object Detection module |
| svd        | :white_check_mark: | :white_check_mark: | SVD module              |
| video      | :white_check_mark: | :white_check_mark: | Video module            |
| videoio    | :white_check_mark: | :white_check_mark: | VideoIO module          |
| asyncarray | :x:                | :x:                | AsyncArray module       |
| calib3d    | :x:                | :x:                | Calib3D module          |
| dnn        | :x:                | :x:                | DNN module              |
| photo      | :white_check_mark: | :white_check_mark: | Photo module            |
| cuda       | :x:                | :x:                | CUDA module             |
| contrib    | :x:                | :x:                | Contrib module          |

- :x: : not finished
- :ballot_box_with_check: : almost finished
- :white_check_mark: : finished
- ~~videoio: `cv.VideoCapture` from file is not supported yet~~ supported now.

### Usage

```dart
import 'package:opencv_dart/opencv_dart.dart' as cv;

final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
final gray = cv.Mat.empty();

cv.cvtColor(img, gray, cv.COLOR_BGR2GRAY);
print("${img.rows}, ${img.cols}");

cv.imwrite("test_cvtcolor.png", gray);
```

More examples are on the way...

### TODO

- [x] compile libs for android, linux
- [ ] support for iOS, macOS
- [ ] add more examples
- [ ] modify C wrapper to catch exceptions
- [ ] Native Assets
- [ ] async?

## For Developers

This package is in heavy development, dynamic libraries for Windows and linux have been compiled, for other platforms, you need to compile it yourself.

### How to compile

1. prepare a compiler.

   windows: Install Visual Studio 2019 or Later

   ubuntu: reference [opencv official build guide](https://docs.opencv.org/4.x/d7/d9f/tutorial_linux_install.html) to install
2. install dependencies: `cmake`, `python`, add to PATH
3. clone this repo, `git clone https://github.com/rainyl/opencv_dart.git`
4. `cd opencv_dart` and `git submodule update --init`
5. compile opencv

   for windows:

   ```pwsh
   python .\scripts\build.py --opencv --os linux --arch x64 --build-dir build --src src
   ```

    for linux:

    ```bash
    python ./scripts/build.py --opencv --os linux --arch x64 --build-dir build --src src
    ```

    for android, you need to download [android ndk](https://developer.android.com/ndk/downloads) and [opencv for android sdk](https://opencv.org/releases/), extract opencv sdk and copy and rename `OpenCV-android-sdk` to `build/android` directory.

6. compile this package along with gocv, windows: `./scripts/build.ps1`, linux: `./scripts/build.sh`, this will generate `libopencv_dart.dll` or `libopencv_dart.so`
7. copy libs to corresponding platform directorys, i.e., `libopencv_dart.dll` to `windows`, `libopencv_dart.so` to `linux`. this is necessary for dart and flutter to load the dynamic library.
8. If you want to test using vscode, add dynamic library path to `"dart.env"` in `settings.json`

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## License

Apache-2.0 License
