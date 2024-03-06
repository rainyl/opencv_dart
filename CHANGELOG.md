## 0.6.2

* try add support for macos, see [this workflow](https://github.com/rainyl/opencv_dart/actions/workflows/build_macos.yaml)

## 0.6.1

* add `stitching` module, for now, cv::Stitcher implemented

## 0.6.0

* add `dnn` module
* add more friendly error message, use `cv.registerErrorCallback();` before potential error occurring.
* change return shape of `Mat.toList()` from `(cols, rows)` to `(rows, cols)`

## 0.5.0

* add `asyncarray`
* add `calib3d` module

## 0.4.0

* :rocket: add support for `photo` module

## 0.3.0

* Please use 0.3.0 or later, tested for android, linux, and windows

## 0.2.0

* :tada: add android `arm64-v8a`, `armeabi-v7a`, `x86`, `x86_64` prebuild binaries, e.g., `dart run opencv_dart:setup -p android -a arm64-v8a` to download prebuilt binaries for android arm64-v8a

## 0.1.0

* Finished: test for aruco, features2d, video module
* :tada: this package is STABLE now! :rocket: check API reference for more details
* more examples and docs are on the way

## 0.0.4

* adjust prebuilt binaries distribution, use `dart run opencv_dart:setup` to download prebuilt binaries
* Finished: test for imgproc module
* Finished: test for Linux

## 0.0.3

* more test for imgproc module

## 0.0.3-dev.0

* Finished: test for core module
* Minor changes for Mat

## 0.0.2

* Implemented: imgproc, imgcodecs, core, video, need to be tested!
* add example

## 0.0.1

* Initial Release
* Implemented: imgproc, imgcodecs, core, video, need to be tested!
