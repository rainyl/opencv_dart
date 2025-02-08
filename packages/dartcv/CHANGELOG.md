## 1.1.3-WIP

* add `VideoCapture.grabAsync`
* add `Mat.fromBuffer` to allow creating `Mat` from self-managed buffer
* add `copyData` parameter to `Mat.fromVec`

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
