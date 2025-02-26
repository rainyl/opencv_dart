# DartCv

OpenCV bindings for Dart language.

[dartcv4](https://pub.dev/packages/dartcv4) is **only** for pure dart, for Flutter,
use [opencv_core](https://pub.dev/packages/opencv_core) (if `videoio` module is NOT required)
or [opencv_dart](https://pub.dev/packages/opencv_dart) (if `videoio` module IS required).

## Install

- `dart pub add dartcv4` or Add dartcv4 to `pubspec.yaml`
- Prepare libraries for your platform, you have 2 options:
  - build from source, see [workflows](https://github.com/rainyl/dartcv/tree/main/.github/workflows)
  - download prebuilt libraries from [release](https://github.com/rainyl/dartcv/releases)
- move/copy the libraries to a directory, e.g., `~/.dartcv`
- Setup environment variables
  - windows: append the above path to `PATH`
  - linux: append the above path to `LD_LIBRARY_PATH`
  - macos: append the above path to `DYLD_LIBRARY_PATH` or `DYLD_FALLBACK_LIBRARY_PATH`

## Usage

### Synchronous

```dart
import 'package:dartcv4/dartcv.dart' as cv;

void main() {
  final img = cv.imread("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  cv.imwrite("test_cvtcolor.png", gray);
}
```

### Asynchronous

```dart
import 'package:dartcv4/dartcv.dart' as cv;
import 'dart:async';
void main() async {
  final img = await cv.imreadAsync("test/images/lenna.png", flags: cv.IMREAD_COLOR);
  final gray = await cv.cvtColorAsync(img, cv.COLOR_BGR2GRAY);
  print("${img.rows}, ${img.cols}");

  await cv.imwriteAsync("test_cvtcolor.png", gray);
}
```

### Q&A

- Refer to [#212](https://github.com/rainyl/opencv_dart/issues/212) or open new issues.

### More examples

Refer to [tests](https://github.com/rainyl/opencv_dart/tree/main/packages/dartcv/test)

## Screenshots

see [Demos](https://github.com/rainyl/opencv_dart?tab=readme-ov-file#Demos)

## Build libdartcv from source

Refer to [dartcv](https://github.com/rainyl/dartcv/blob/main/README.md)

## License

[Apache-2.0 License](LICENSE)
