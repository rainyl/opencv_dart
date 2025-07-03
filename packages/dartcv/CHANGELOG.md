## 1.1.5

* added `approxPolyN`.
* add more high-precision functions (`arcLength2f`, etc.) to `imgproc` module, https://github.com/rainyl/opencv_dart/pull/364
* breaking change: optional arg `hierarchy` of `drawContours` now change from `Mat` to `VecVec4i` type.

## 1.1.4

* remove deprecated `MatType.toInt()`, should use MatType.value instead
* add `MatType.elemSize` `MatType.elemSize1`
* remove deprecated `(double x, double y, double z).asPoint3f`
  `(double x, double y).asPoint2f` `(int x, int y).asPoint` `VecPoint.toVecVecPoint`
* add `bin/gen_cmake_vars.dart` for generating optional module vars for CMake

## 1.1.3

* add `VideoCapture.grabAsync`
* add `Mat.fromBuffer` to allow creating `Mat` from self-managed buffer
* add `copyData` parameter to `Mat.fromVec`
* remove `Mat.fromPtr`, merge it to `Mat.fromMat`
* add `Mat.atU8`, `Mat.setU8`, etc.
* remove deprecated `Mat.copyToWithMask`, `List<Mat>.asVecMat()`

## 1.1.2

* add more functions in `calib3d`

## 1.1.1

* make `VecVecChar` unmodifible
* more tests

## 1.1.0

* update to OpenCV 4.11.0
* change vector wrappers to std::vector
* fix reference of estimateAffinePartial2D
* support `VideoWriter.get()` and `VideoWriter.set()`
* use native implementation of 8U/8S -> F16 for `cv.LUT()`

## 1.0.1

* add example

## 1.0.0

* stable release
* add `cv.Mat.fromMat`

## 0.0.2

* More tests
* add copyToAsync PSNRAsync mulTransposedAsync VecRect2f Net.getUnconnectedOutLayersNames enableModelDiagnostics getAvailableBackends getAvailableTargets

## 0.0.1

* Initial version.
