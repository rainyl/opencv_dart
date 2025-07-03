## 1.4.2

* support optional modules, configure it in `pubspec.yaml`, from this version, both opencv_core and
  opencv_dart can enable/disable optional modules.
* added `approxPolyN`.

## 1.4.1

* add `VideoCapture.grabAsync`
* add `Mat.fromBuffer` to allow creating `Mat` from self-managed buffer
* add `copyData` parameter to `Mat.fromVec`
* remove `Mat.fromPtr`, merge it to `Mat.fromMat`
* add `Mat.atU8`, `Mat.setU8`, etc.
* remove deprecated `Mat.copyToWithMask`, `List<Mat>.asVecMat()`

## 1.4.0

* update to OpenCV 4.11.0
* change vector wrappers to std::vector
* fix reference of estimateAffinePartial2D
* support `VideoWriter.get()` and `VideoWriter.set()`
* use native implementation of 8U/8S -> F16 for `cv.LUT()`
* make `VecVecChar` unmodifible
* more tests
* add more functions in `calib3d`
* make the version of `dartcv4` fixed

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
