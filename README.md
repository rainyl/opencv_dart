# opencv_dart

OpenCV Bindings for Dart Language.

**!!!This package is experiment and APIs may change in the future!!!**

*Many tests unfinished, contributions are welcome!*

Prebuilt binaries for Linux and Windows are available, for other platforms, you have to build 
them your self.

**IMPORTANT**

After added to `pubspec.yaml` or install by commandline, 
please run `dart run opencv_dart:setup -p <platform>` to download 
prebuilt binaries, for now, `platform` supports `auto`, `linux` and `windows`.

## Status

| module     | Binding status     | Test status             | description             |
| ---------- | ------------------ | ----------------------- | ----------------------- |
| aruco      | :white_check_mark: | :white_check_mark:      | ArUco module            |
| core       | :white_check_mark: | :white_check_mark:      | Core module             |
| features2d | :white_check_mark: | :white_check_mark:      | Features2D module       |
| highgui    | :white_check_mark: | :white_check_mark:      | HighGUI module          |
| imgcodecs  | :white_check_mark: | :white_check_mark:      | ImageCodecs module      |
| imgproc    | :white_check_mark: | :white_check_mark:      | ImageProc module        |
| objdetect  | :white_check_mark: | :white_check_mark:      | Object Detection module |
| svd        | :white_check_mark: | :white_check_mark:      | SVD module              |
| video      | :white_check_mark: | :white_check_mark:      | Video module            |
| videoio    | :white_check_mark: | :ballot_box_with_check: | VideoIO module          |
| asyncarray | :x:                | :x:                     | AsyncArray module       |
| calib3d    | :x:                | :x:                     | Calib3D module          |
| dnn        | :x:                | :x:                     | DNN module              |
| photo      | :x:                | :x:                     | Photo module            |
| cuda       | :x:                | :x:                     | CUDA module             |
| contrib    | :x:                | :x:                     | Contrib module          |

- :x: : not finished
- :ballot_box_with_check: : almost finished
- :white_check_mark: : finished
- videoio: `cv.VideoCapture` from file is not supported yet

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

- [ ] compile libs for android, linux
- [ ] support for iOS, macOS
- [ ] add more examples
- [ ] modify C wrapper to catch exceptions
- [ ] Native Assets

## For Developers

This package is in heavy development, dynamic libraries for Windows and linux have been compiled, for other platforms, you need to compile it yourself.

### How to compile

1. clone this repo.
2. compile opencv, windows: `./scripts/build_opencv.ps1`, linux: `./scripts/build_opencv.sh`
3. compile this package along with gocv, windows: `./scripts/build.ps1`, linux: `./scripts/build.sh`, this will generate `libopencv_dart.dll` or `libopencv_dart.so`
4. copy libs to corresponding platform directorys, i.e., `libopencv_dart.dll` to `windows`, `libopencv_dart.so` to `linux`. this is necessary for dart and flutter to load the dynamic library.
5. If you want to test using vscode, add dynamic library path to `"dart.env"` in `settings.json`

## Acknowledgement

- `gocv` project: <https://github.com/hybridgroup/gocv> License: Apache-2.0

## License

Apache-2.0 License
