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
import '../g/objdetect.g.dart' as cvg;
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
    final ret = calloc<cvg.VecRect>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_1(
        ref,
        image.ref,
        ret,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        callback,
      ),
      (c) {
        return c.complete(VecRect.fromPointer(ret));
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
    final ret = calloc<cvg.VecRect>();
    final pnums = calloc<cvg.VecI32>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_2(
        ref,
        image.ref,
        ret,
        pnums,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        callback,
      ),
      (c) {
        return c.complete((VecRect.fromPointer(ret), VecI32.fromPointer(pnums)));
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
    final objects = calloc<cvg.VecRect>();
    final rejectLevels = calloc<cvg.VecI32>();
    final levelWeights = calloc<cvg.VecF64>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_CascadeClassifier_detectMultiScale_3(
        ref,
        image.ref,
        objects,
        rejectLevels,
        levelWeights,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        outputRejectLevels,
        callback,
      ),
      (c) {
        return c.complete(
          (VecRect.fromPointer(objects), VecI32.fromPointer(rejectLevels), VecF64.fromPointer(levelWeights)),
        );
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
    final descriptors = calloc<cvg.VecF32>();
    final locations = calloc<cvg.VecPoint>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_compute(
        ref,
        img.ref,
        descriptors,
        winStride.cvd.ref,
        padding.cvd.ref,
        locations,
        callback,
      ),
      (c) {
        return c.complete(
          (
            VecF32.fromPointer(descriptors),
            VecPoint.fromPointer(locations),
          ),
        );
      },
    );
  }

  Future<(Mat grad, Mat angleOfs)> computeGradientAsync(
    InputArray img, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) {
    final grad = Mat.empty();
    final angleOfs = Mat.empty();
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
        return c.complete((grad, angleOfs));
      },
    );
  }

  Future<(VecPoint foundLocations, VecF64 weights, VecPoint searchLocations)> detect2Async(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = calloc<cvg.VecPoint>();
    final searchLocations = calloc<cvg.VecPoint>();
    final weights = calloc<cvg.VecF64>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detect(
        ref,
        img.ref,
        foundLocations,
        weights,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
        callback,
      ),
      (c) {
        return c.complete(
          (
            VecPoint.fromPointer(foundLocations),
            VecF64.fromPointer(weights),
            VecPoint.fromPointer(searchLocations),
          ),
        );
      },
    );
  }

  Future<(VecPoint foundLocations, VecPoint searchLocations)> detectAsync(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = calloc<cvg.VecPoint>();
    final searchLocations = calloc<cvg.VecPoint>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_HOGDescriptor_detect2(
        ref,
        img.ref,
        foundLocations,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
        callback,
      ),
      (c) {
        return c.complete((VecPoint.fromPointer(foundLocations), VecPoint.fromPointer(searchLocations)));
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
    final rects = calloc<cvg.VecRect>();
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
        rects,
        callback,
      ),
      (c) {
        return c.complete(VecRect.fromPointer(rects));
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
        rectList.reattach();
        weights.reattach();
        return c.complete((rectList, weights));
      },
    );
  }
}

Future<VecRect> groupRectanglesAsync(VecRect rects, int groupThreshold, double eps) {
  return cvRunAsync0(
    (callback) => cobjdetect.cv_groupRectangles(rects.ptr, groupThreshold, eps, callback),
    (c) {
      rects.reattach();
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
    final s = straightQRcode?.ptr ?? calloc<cvg.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_decodeCurved(ref, img.ref, points.ref, s, v, callback),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((ss, Mat.fromPointer(s)));
      },
    );
  }

  Future<(String rval, VecPoint points, Mat straightQRcode)> detectAndDecodeCurvedAsync(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) {
    final p = points?.ptr ?? calloc<cvg.VecPoint>();
    final s = straightQRcode?.ptr ?? calloc<cvg.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecodeCurved(ref, img.ref, p, s, v, callback),
      (c) {
        final ss = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((ss, points ?? VecPoint.fromPointer(p), Mat.fromPointer(s)));
      },
    );
  }

  Future<(String ret, VecPoint points, Mat straightCode)> detectAndDecodeAsync(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) {
    final code = straightCode?.ptr ?? calloc<cvg.Mat>();
    final points = calloc<cvg.VecPoint>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecode(ref, img.ref, points, code, v, callback),
      (c) {
        final s = v.value.cast<Utf8>().toDartString();
        calloc.free(v);
        return c.complete((s, VecPoint.fromPointer(points), Mat.fromPointer(code)));
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectAsync(InputArray input, {VecPoint? points}) {
    final pts = calloc<cvg.VecPoint>();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detect(ref, input.ref, pts, ret, callback),
      (c) {
        final rval = (ret.value, VecPoint.fromPointer(pts));
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
    final p = points?.ptr ?? calloc<cvg.VecPoint>();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_decode(ref, img.ref, p, straightCode!.ref, ret, callback),
      (c) {
        final info = ret.value.cast<Utf8>().toDartString();
        calloc.free(ret);
        return c.complete((info, VecPoint.fromPointer(p), straightCode));
      },
    );
  }

  Future<(bool ret, VecPoint points)> detectMultiAsync(InputArray img, {VecPoint? points}) {
    final p = points?.ptr ?? calloc<cvg.VecPoint>();
    final ret = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectMulti(ref, img.ref, p, ret, callback),
      (c) {
        final rval = (ret.value, VecPoint.fromPointer(p));
        calloc.free(ret);
        return c.complete(rval);
      },
    );
  }

  Future<(bool, List<String>, VecPoint, VecMat)> detectAndDecodeMultiAsync(InputArray img) {
    final info = calloc<cvg.VecVecChar>();
    final points = calloc<cvg.VecPoint>();
    final codes = calloc<cvg.VecMat>();
    final rval = calloc<ffi.Bool>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_QRCodeDetector_detectAndDecodeMulti(
        ref,
        img.ref,
        info,
        points,
        codes,
        rval,
        callback,
      ),
      (c) {
        final ret = (
          rval.value,
          VecVecChar.fromPointer(info).asStringList(),
          VecPoint.fromPointer(points),
          VecMat.fromPointer(codes),
        );
        calloc.free(rval);
        return c.complete(ret);
      },
    );
  }
}

extension FaceDetectorYNAsync on FaceDetectorYN {
  Future<Mat> detectAsync(Mat image) {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceDetectorYN_detect(ref, image.ref, p, callback),
      (c) {
        return c.complete(Mat.fromPointer(p));
      },
    );
  }
}

extension FaceRecognizerSFAsync on FaceRecognizerSF {
  Future<Mat> alignCropAsync(Mat srcImg, Mat faceBox) {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_alignCrop(ref, srcImg.ref, faceBox.ref, p, callback),
      (c) {
        return c.complete(Mat.fromPointer(p));
      },
    );
  }

  Future<Mat> featureAsync(Mat alignedImg, {bool clone = false}) {
    final p = calloc<cvg.Mat>();
    return cvRunAsync0(
      (callback) => cobjdetect.cv_FaceRecognizerSF_feature(ref, alignedImg.ref, clone, p, callback),
      (c) {
        return c.complete(Mat.fromPointer(p));
      },
    );
  }

  Future<double> matchAsync(Mat faceFeature1, Mat faceFeature2, {int disType = FaceRecognizerSF.FR_COSINE}) {
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
