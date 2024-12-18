// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.objdetect;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../native_lib.dart' show cobjdetect;
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
        minSize.cvd.ref,
        maxSize.cvd.ref,
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
        minSize.cvd.ref,
        maxSize.cvd.ref,
        callback,
      ),
      (c) {
        return c.complete((ret, pnums));
      },
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
        minSize.cvd.ref,
        maxSize.cvd.ref,
        outputRejectLevels,
        callback,
      ),
      (c) {
        return c.complete((objects, rejectLevels, levelWeights));
      },
    );
  }
}

extension HOGDescriptorAsync on HOGDescriptor {
  Future<(VecF32 descriptors, VecPoint locations)> computeAsync(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final descriptors = VecF32();
    final locations = VecPoint();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_compute(
        ref,
        img.ref,
        descriptors.ptr,
        winStride.cvd.ref,
        padding.cvd.ref,
        locations.ptr,
        callback,
      ),
      (c) {
        return c.complete((descriptors, locations));
      },
    );
  }

  Future<void> computeGradientAsync(
    InputArray img,
    InputOutputArray grad,
    InputOutputArray angleOfs, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) {
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_computeGradient(
        ref,
        img.ref,
        grad.ref,
        angleOfs.ref,
        paddingTL.cvd.ref,
        paddingBR.cvd.ref,
        callback,
      ),
      (c) {
        return c.complete();
      },
    );
  }

  Future<(VecPoint foundLocations, VecF64 weights, VecPoint searchLocations)> detect2Async(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
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
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations.ptr,
        callback,
      ),
      (c) {
        return c.complete((foundLocations, weights, searchLocations));
      },
    );
  }

  Future<(VecPoint foundLocations, VecPoint searchLocations)> detectAsync(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = VecPoint();
    final searchLocations = VecPoint();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detect2(
        ref,
        img.ref,
        foundLocations.ptr,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations.ptr,
        callback,
      ),
      (c) {
        return c.complete((foundLocations, searchLocations));
      },
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
  }) {
    final rects = VecRect();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detectMultiScale_1(
        ref,
        image.ref,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
        rects.ptr,
        callback,
      ),
      (c) {
        return c.complete(rects);
      },
    );
  }

  Future<(VecRect rectList, VecF64 weights)> groupRectanglesAsync(
    VecRect rectList,
    VecF64 weights,
    int groupThreshold,
    double eps,
  ) {
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
    );
  }
}

Future<VecRect> groupRectanglesAsync(VecRect rects, int groupThreshold, double eps) async {
  return cvRunAsync0(
    (callback) => cobjdetect.cv_groupRectangles(rects.ptr, groupThreshold, eps, callback),
    (c) {
      return c.complete(rects);
    },
  );
}

extension QRCodeDetectorAsync on QRCodeDetector {
  Future<(String rval, Mat straightQRcode)> decodeCurvedAsync(
    InputArray img,
    VecPoint points, {
    OutputArray? straightQRcode,
  }) {
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_decodeCurved(ref, img.ref, points.ref, straightQRcode!.ptr, v, callback),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((ss, straightQRcode!));
      },
    );
  }

  Future<(String rval, VecPoint points, Mat straightQRcode)> detectAndDecodeCurvedAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) {
    points ??= VecPoint();
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) =>
          cobjdetect.cv_QRCodeDetector_detectAndDecodeCurved(ref, img.ref, points!.ptr, straightQRcode!.ptr, v, callback),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((ss, points!, straightQRcode!));
      },
    );
  }

  Future<(String ret, VecPoint points, Mat straightCode)> detectAndDecodeAsync(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) {
    straightCode ??= Mat.empty();
    final points = VecPoint();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecode(ref, img.ref, points.ptr, straightCode!.ptr, v, callback),
      (c) {
        final s = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((s, points, straightCode!));
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectAsync(InputArray input, {VecPoint? points}) async {
    final pts = VecPoint();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detect(ref, input.ref, pts.ptr, ret, callback),
      (c) {
        final rval = (ret.value, pts);
        calloc.free(ret);
        return c.complete(rval);
      },
    );
  }

  Future<(String ret, VecPoint? points, Mat? straightCode)> decodeAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightCode,
  }) {
    points ??= VecPoint();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    return cvRunAsync0(
      (callback) =>
          cobjdetect.cv_QRCodeDetector_decode(ref, img.ref, points!.ptr, straightCode!.ref, ret, callback),
      (c) {
        final info = ret.value.cast<Utf8>().toDartString();
        calloc.free(ret);
        return c.complete((info, points, straightCode));
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectMultiAsync(InputArray img, {VecPoint? points}) async {
    points ??= VecPoint();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectMulti(ref, img.ref, points!.ptr, ret, callback),
      (c) {
        final rval = (ret.value, points!);
        calloc.free(ret);
        return c.complete(rval);
      },
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
        final ret = (
          rval.value,
          info.asStringList(),
          points,
          codes,
        );
        calloc.free(rval);
        info.dispose();
        return c.complete(ret);
      },
    );
  }
}

extension FaceDetectorYNAsync on FaceDetectorYN {
  Future<Mat> detectAsync(Mat image) async {
    final ret = Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceDetectorYN_detect(ref, image.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension FaceRecognizerSFAsync on FaceRecognizerSF {
  Future<Mat> alignCropAsync(Mat srcImg, Mat faceBox) async {
    final ret = Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_alignCrop(ref, srcImg.ref, faceBox.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }

  Future<Mat> featureAsync(Mat alignedImg, {bool clone = false}) async {
    final ret = Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_feature(ref, alignedImg.ref, clone, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }

  Future<double> matchAsync(
    Mat faceFeature1,
    Mat faceFeature2, {
    int disType = FaceRecognizerSF.FR_COSINE,
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
        calloc.free(distance);
        return c.complete(rval);
      },
    );
  }
}
