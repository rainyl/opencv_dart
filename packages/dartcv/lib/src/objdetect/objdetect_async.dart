// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.objdetect;

import '../bindings/objdetect.dart' as cobjdetect;
import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';
import './objdetect.dart';

extension CascadeClassifierAsync on CascadeClassifier {
  Future<VecRect> detectMultiScaleAsync(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final pObjects = VecRect();
    return cvRunAsync0<VecRect>(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_1(
        ref,
        image.ref,
        pObjects.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvdRef,
        maxSize.cvdRef,
        callback,
      ),
      (c) {
        return c.complete(pObjects);
      },
    );
  }

  Future<(VecRect objects, VecI32 numDetections)> detectMultiScale2Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    Duration? timeout,
  }) {
    final ret = VecRect();
    final pnums = VecI32();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_2(
        ref,
        image.ref,
        ret.ptr,
        pnums.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvdRef,
        maxSize.cvdRef,
        callback,
      ),
      (c) {
        return c.complete((ret, pnums));
      },
      timeout: timeout,
    );
  }

  Future<(VecRect objects, VecI32 rejectLevels, VecF64 levelWeights)> detectMultiScale3Async(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    bool outputRejectLevels = false,
    Duration? timeout,
  }) {
    final objects = VecRect();
    final rejectLevels = VecI32();
    final levelWeights = VecF64();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_3(
        ref,
        image.ref,
        objects.ptr,
        rejectLevels.ptr,
        levelWeights.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvdRef,
        maxSize.cvdRef,
        outputRejectLevels,
        callback,
      ),
      (c) {
        return c.complete((objects, rejectLevels, levelWeights));
      },
      timeout: timeout,
    );
  }
}

extension HOGDescriptorAsync on HOGDescriptor {
  Future<(VecF32 descriptors, VecPoint locations)> computeAsync(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    Duration? timeout,
  }) {
    final descriptors = VecF32();
    final locations = VecPoint();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_compute(
        ref,
        img.ref,
        descriptors.ptr,
        winStride.cvdRef,
        padding.cvdRef,
        locations.ptr,
        callback,
      ),
      (c) {
        return c.complete((descriptors, locations));
      },
      timeout: timeout,
    );
  }

  Future<void> computeGradientAsync(
    InputArray img,
    InputOutputArray grad,
    InputOutputArray angleOfs, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
    Duration? timeout,
  }) {
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_computeGradient(
        ref,
        img.ref,
        grad.ref,
        angleOfs.ref,
        paddingTL.cvdRef,
        paddingBR.cvdRef,
        callback,
      ),
      (c) {
        return c.complete();
      },
      timeout: timeout,
    );
  }

  Future<(VecPoint foundLocations, VecF64 weights, VecPoint searchLocations)> detect2Async(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    Duration? timeout,
  }) {
    final foundLocations = VecPoint();
    final searchLocations = VecPoint();
    final weights = VecF64();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detect(
        ref,
        img.ref,
        foundLocations.ptr,
        weights.ptr,
        hitThreshold,
        winStride.cvdRef,
        padding.cvdRef,
        searchLocations.ptr,
        callback,
      ),
      (c) {
        return c.complete((foundLocations, weights, searchLocations));
      },
      timeout: timeout,
    );
  }

  Future<(VecPoint foundLocations, VecPoint searchLocations)> detectAsync(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    Duration? timeout,
  }) {
    final foundLocations = VecPoint();
    final searchLocations = VecPoint();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detect2(
        ref,
        img.ref,
        foundLocations.ptr,
        hitThreshold,
        winStride.cvdRef,
        padding.cvdRef,
        searchLocations.ptr,
        callback,
      ),
      (c) {
        return c.complete((foundLocations, searchLocations));
      },
      timeout: timeout,
    );
  }

  Future<VecRect> detectMultiScaleAsync(
    InputArray image, {
    double hitThreshold = 0,
    int minNeighbors = 3,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
    double scale = 1.05,
    double groupThreshold = 2.0,
    bool useMeanshiftGrouping = false,
    Duration? timeout,
  }) {
    final rects = VecRect();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detectMultiScale_1(
        ref,
        image.ref,
        hitThreshold,
        winStride.cvdRef,
        padding.cvdRef,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
        rects.ptr,
        callback,
      ),
      (c) {
        return c.complete(rects);
      },
      timeout: timeout,
    );
  }

  Future<(VecRect rectList, VecF64 weights)> groupRectanglesAsync(
    VecRect rectList,
    VecF64 weights,
    int groupThreshold,
    double eps, {
    Duration? timeout,
  }) {
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_groupRectangles(
        ref,
        rectList.ptr,
        weights.ptr,
        groupThreshold,
        eps,
        callback,
      ),
      (c) {
        return c.complete((rectList, weights));
      },
      timeout: timeout,
    );
  }
}

Future<VecRect> groupRectanglesAsync(
  VecRect rects,
  int groupThreshold,
  double eps, {
  Duration? timeout,
}) async {
  return cvRunAsync0((callback) => cobjdetect.cv_groupRectangles(rects.ptr, groupThreshold, eps, callback), (
    c,
  ) {
    return c.complete(rects);
  }, timeout: timeout);
}

extension QRCodeDetectorAsync on QRCodeDetector {
  Future<(String rval, Mat straightQRcode)> decodeCurvedAsync(
    InputArray img,
    VecPoint points, {
    OutputArray? straightQRcode,
    Duration? timeout,
  }) {
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_decodeCurved(
        ref,
        img.ref,
        points.ref,
        straightQRcode!.ptr,
        v,
        callback,
      ),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        return c.complete((ss, straightQRcode!));
      },
      timeout: timeout,
      release: () {
        calloc.free(v.value);
        calloc.free(v);
      },
    );
  }

  Future<(String rval, VecPoint points, Mat straightQRcode)> detectAndDecodeCurvedAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
    Duration? timeout,
  }) {
    points ??= VecPoint();
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecodeCurved(
        ref,
        img.ref,
        points!.ptr,
        straightQRcode!.ptr,
        v,
        callback,
      ),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        return c.complete((ss, points!, straightQRcode!));
      },
      timeout: timeout,
      release: () {
        calloc.free(v.value);
        calloc.free(v);
      },
    );
  }

  Future<(String ret, VecPoint points, Mat straightCode)> detectAndDecodeAsync(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
    Duration? timeout,
  }) {
    straightCode ??= Mat.empty();
    final points = VecPoint();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecode(
        ref,
        img.ref,
        points.ptr,
        straightCode!.ptr,
        v,
        callback,
      ),
      (c) {
        final s = v.value.cast<Utf8>().toDartString();
        return c.complete((s, points, straightCode!));
      },
      timeout: timeout,
      release: () {
        calloc.free(v.value);
        calloc.free(v);
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectAsync(
    InputArray input, {
    VecPoint? points,
    Duration? timeout,
  }) async {
    final pts = VecPoint();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detect(ref, input.ref, pts.ptr, ret, callback),
      (c) {
        final rval = (ret.value, pts);
        return c.complete(rval);
      },
      release: () => calloc.free(ret),
      timeout: timeout,
    );
  }

  Future<(String ret, VecPoint? points, Mat? straightCode)> decodeAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightCode,
    Duration? timeout,
  }) {
    points ??= VecPoint();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          cobjdetect.cv_QRCodeDetector_decode(ref, img.ref, points!.ptr, straightCode!.ref, ret, callback),
      (c) {
        final info = ret.value.cast<Utf8>().toDartString();
        return c.complete((info, points, straightCode));
      },
      timeout: timeout,
      release: () {
        calloc.free(ret.value);
        calloc.free(ret);
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectMultiAsync(
    InputArray img, {
    VecPoint? points,
    Duration? timeout,
  }) async {
    points ??= VecPoint();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectMulti(ref, img.ref, points!.ptr, ret, callback),
      (c) {
        final rval = (ret.value, points!);
        return c.complete(rval);
      },
      release: () => calloc.free(ret),
      timeout: timeout,
    );
  }

  Future<(bool, List<String>, VecPoint, VecMat)> detectAndDecodeMultiAsync(InputArray img) async {
    final info = VecVecChar();
    final points = VecPoint();
    final codes = VecMat();
    final rval = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecodeMulti(
        ref,
        img.ref,
        info.ptr,
        points.ptr,
        codes.ptr,
        rval,
        callback,
      ),
      (c) {
        final ret = (rval.value, info.asStringList(), points, codes);
        info.dispose();
        return c.complete(ret);
      },

      release: () => calloc.free(rval),
    );
  }
}

extension FaceDetectorYNAsync on FaceDetectorYN {
  Future<Mat> detectAsync(Mat image, {Duration? timeout}) async {
    final ret = Mat.empty();
    return cvRunAsync0((callback) => cobjdetect.cv_FaceDetectorYN_detect(ref, image.ref, ret.ptr, callback), (
      c,
    ) {
      return c.complete(ret);
    }, timeout: timeout);
  }
}

extension FaceRecognizerSFAsync on FaceRecognizerSF {
  Future<Mat> alignCropAsync(Mat srcImg, Mat faceBox, {Duration? timeout}) async {
    final ret = Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_alignCrop(ref, srcImg.ref, faceBox.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
      timeout: timeout,
    );
  }

  Future<Mat> featureAsync(Mat alignedImg, {bool clone = false, Duration? timeout}) async {
    final ret = Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_feature(ref, alignedImg.ref, clone, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
      timeout: timeout,
    );
  }

  Future<double> matchAsync(
    Mat faceFeature1,
    Mat faceFeature2, {
    int disType = FaceRecognizerSF.FR_COSINE,
    Duration? timeout,
  }) async {
    final distance = calloc<ffi.Double>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_match(
        ref,
        faceFeature1.ref,
        faceFeature2.ref,
        disType,
        distance,
        callback,
      ),
      (c) {
        final rval = distance.value;
        return c.complete(rval);
      },
      release: () => calloc.free(distance),
      timeout: timeout,
    );
  }
}
