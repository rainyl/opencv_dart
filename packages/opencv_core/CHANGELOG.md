## 1.3.5

* update to OpenCV 4.11.0
* change vector wrappers to std::vector
* fix reference of estimateAffinePartial2D
* support `VideoWriter.get()` and `VideoWriter.set()`
* use native implementation of 8U/8S -> F16 for `cv.LUT()`

## 1.3.3

* Fix example link in readme
* [Android] Support 16KB Page Size
* Fix: `minEnclosingCircle`
* Fix: requested object not found in `glob_rec`
* Exclude system paths from search paths in `ffmpeg-config.cmake`
* bump dartcv to 4.10.0.5
* bump opencv to 4.10.0+10

## 1.3.2

* Fix: minEnclosingCircle
* hide highgui from building, cache options
* [Android] Remove debug info in release build to reduce package size
* bump DartCvIOS and DartCvMacOS to 4.10.0.4, remove `-Wl,-ld_classic` for ios and macos

## 1.3.1

* breaking change: hide `highgui`
* bump DartCvMacOS and DartCvIOS to 4.10.0.3, conditionally add link option `-ld_classic`

## 1.3.0

* bump dartcv to 0.0.3
* add `cv.Mat.fromMat`

## 0.0.2

* bump dartcv to 0.0.2

## 0.0.1

* initial release
