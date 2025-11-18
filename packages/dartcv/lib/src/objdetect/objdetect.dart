// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.objdetect;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../g/objdetect.g.dart' as cvg;
import '../g/objdetect.g.dart' as cobjdetect;

class CascadeClassifier extends CvStruct<cvg.CascadeClassifier> {
  CascadeClassifier._(cvg.CascadeClassifierPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory CascadeClassifier.fromPointer(cvg.CascadeClassifierPtr ptr, [bool attach = true]) =>
      CascadeClassifier._(ptr, attach);

  factory CascadeClassifier.empty() {
    final p = calloc<cvg.CascadeClassifier>();
    cvRun(() => cobjdetect.cv_CascadeClassifier_create(p));
    return CascadeClassifier._(p);
  }

  factory CascadeClassifier.fromFile(String filename) {
    final p = calloc<cvg.CascadeClassifier>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.cv_CascadeClassifier_create_1(cp, p));
    calloc.free(cp);
    return CascadeClassifier._(p);
  }

  /// Load cascade classifier from a file.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#a1a5884c8cc749422f9eb77c2471958bc
  bool load(String name) {
    final cname = name.toNativeUtf8().cast<ffi.Char>();
    final p = calloc<ffi.Int>();
    cvRun(() => cobjdetect.cv_CascadeClassifier_load(ref, cname, p));
    final rval = p.value != 0;
    calloc.free(p);
    calloc.free(cname);
    return rval;
  }

  /// DetectMultiScale detects objects of different sizes in the input Mat image.
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#aaf8181cb63968136476ec4204ffca498
  VecRect detectMultiScale(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final ret = VecRect();
    cvRun(
      () => cobjdetect.cv_CascadeClassifier_detectMultiScale_1(
        ref,
        image.ref,
        ret.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        ffi.nullptr,
      ),
    );
    return ret;
  }

  (VecRect objects, VecI32 numDetections) detectMultiScale2(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final ret = VecRect();
    final pnums = VecI32();
    cvRun(
      () => cobjdetect.cv_CascadeClassifier_detectMultiScale_2(
        ref,
        image.ref,
        ret.ptr,
        pnums.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
        ffi.nullptr,
      ),
    );
    return (ret, pnums);
  }

  (VecRect objects, VecI32 numDetections, VecF64 levelWeights) detectMultiScale3(
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
    cvRun(
      () => cobjdetect.cv_CascadeClassifier_detectMultiScale_3(
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
        ffi.nullptr,
      ),
    );
    return (objects, rejectLevels, levelWeights);
  }

  /// Checks whether the classifier has been loaded.
  ///
  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a1753ebe58554fe0673ce46cb4e83f08a
  bool empty() => cobjdetect.cv_CascadeClassifier_empty(ref);

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a0bab6de516c685ba879a4b1f1debdef1
  int getFeatureType() => cobjdetect.cv_CascadeClassifier_getFeatureType(ref);

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a7a131d319ab42a444ff2bcbb433b7b41
  (int, int) getOriginalWindowSize() {
    final p = cobjdetect.cv_CascadeClassifier_getOriginalWindowSize(ref);
    return (p.width, p.height);
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a556bdd8738ba96aac07628ec38ff46da
  bool isOldFormatCascade() => cobjdetect.cv_CascadeClassifier_isOldFormatCascade(ref);

  @override
  cvg.CascadeClassifier get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CascadeClassifierPtr>(
    cobjdetect.addresses.cv_CascadeClassifier_close,
  );

  void dispose() {
    finalizer.detach(this);
    cobjdetect.cv_CascadeClassifier_close(ptr);
  }
}

class HOGDescriptor extends CvStruct<cvg.HOGDescriptor> {
  HOGDescriptor._(cvg.HOGDescriptorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory HOGDescriptor.fromPointer(cvg.HOGDescriptorPtr ptr, [bool attach = true]) =>
      HOGDescriptor._(ptr, attach);

  factory HOGDescriptor.empty() {
    final p = calloc<cvg.HOGDescriptor>();
    cvRun(() => cobjdetect.cv_HOGDescriptor_create(p));
    return HOGDescriptor._(p);
  }

  /// This is an overloaded member function, provided for convenience. It differs from the above function only in what argument(s) it accepts.
  ///
  /// Creates the HOG descriptor and detector and loads HOGDescriptor parameters and coefficients for the linear SVM classifier from a file.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a32a635936edaed1b2789caf3dcb09b6e
  factory HOGDescriptor.fromFile(String filename) {
    final p = calloc<cvg.HOGDescriptor>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.cv_HOGDescriptor_create_1(cp, p));
    calloc.free(cp);
    return HOGDescriptor._(p);
  }

  bool load(String name) {
    return using<bool>((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      final p = arena<ffi.Bool>();
      cvRun(() => cobjdetect.cv_HOGDescriptor_load(ref, cname.cast(), p));
      return p.value;
    });
  }

  /// Computes HOG descriptors of given image.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a38cd712cd5a6d9ed0344731fcd121e8b
  (VecF32 descriptors, VecPoint locations) compute(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final descriptors = VecF32();
    final locations = VecPoint();
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_compute(
        ref,
        img.ref,
        descriptors.ptr,
        winStride.cvd.ref,
        padding.cvd.ref,
        locations.ptr,
        ffi.nullptr,
      ),
    );
    return (descriptors, locations);
  }

  /// Computes gradients and quantized gradient orientations.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a1f76c51c08d69f2b8a0f079efc4bd093
  void computeGradient(
    InputArray img,
    InputOutputArray grad,
    InputOutputArray angleOfs, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) {
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_computeGradient(
        ref,
        img.ref,
        grad.ref,
        angleOfs.ref,
        paddingTL.cvd.ref,
        paddingBR.cvd.ref,
        ffi.nullptr,
      ),
    );
  }

  /// Performs object detection without a multi-scale window.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a309829908ffaf4645755729d7aa90627
  (VecPoint foundLocations, VecF64 weights, VecPoint searchLocations) detect2(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = VecPoint();
    final searchLocations = VecPoint();
    final weights = VecF64();
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_detect(
        ref,
        img.ref,
        foundLocations.ptr,
        weights.ptr,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations.ptr,
        ffi.nullptr,
      ),
    );
    return (foundLocations, weights, searchLocations);
  }

  /// Performs object detection without a multi-scale window.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a309829908ffaf4645755729d7aa90627
  (VecPoint foundLocations, VecPoint searchLocations) detect(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = VecPoint();
    final searchLocations = VecPoint();
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_detect2(
        ref,
        img.ref,
        foundLocations.ptr,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations.ptr,
        ffi.nullptr,
      ),
    );
    return (foundLocations, searchLocations);
  }

  /// DetectMultiScale calls DetectMultiScale but allows setting parameters
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  VecRect detectMultiScale(
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
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_detectMultiScale_1(
        ref,
        image.ref,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
        rects.ptr,
        ffi.nullptr,
      ),
    );
    return rects;
  }

  /// HOGDefaultPeopleDetector returns a new Mat with the HOG DefaultPeopleDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  static VecF32 getDefaultPeopleDetector() {
    final v = VecF32();
    cvRun(() => cobjdetect.cv_HOGDescriptor_getDefaultPeopleDetector(v.ptr));
    return v;
  }

  static VecF32 getDaimlerPeopleDetector() {
    final v = VecF32();
    cvRun(() => cobjdetect.cv_HOGDescriptor_getDaimlerPeopleDetector(v.ptr));
    return v;
  }

  int getDescriptorSize() => cobjdetect.cv_HOGDescriptor_getDescriptorSize(ref);

  /// Returns winSigma value.
  double getWinSigma() => cobjdetect.cv_HOGDescriptor_getWinSigma(ref);

  /// Groups the object candidate rectangles.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#ad7c9679b23e8476e332e9114181d656d
  (VecRect rectList, VecF64 weights) groupRectangles(
    VecRect rectList,
    VecF64 weights,
    int groupThreshold,
    double eps,
  ) {
    cvRun(
      () => cobjdetect.cv_HOGDescriptor_groupRectangles(
        ref,
        rectList.ptr,
        weights.ptr,
        groupThreshold,
        eps,
        ffi.nullptr,
      ),
    );
    return (rectList, weights);
  }

  /// SetSVMDetector sets the data for the HOGDescriptor.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a09e354ad701f56f9c550dc0385dc36f1
  void setSVMDetector(VecF32 det) {
    cvRun(() => cobjdetect.cv_HOGDescriptor_setSVMDetector(ref, det.ref));
  }

  @override
  cvg.HOGDescriptor get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.HOGDescriptorPtr>(cobjdetect.addresses.cv_HOGDescriptor_close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.cv_HOGDescriptor_close(ptr);
  }
}

// GroupRectangles groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/d5/d54/group__objdetect.html#ga3dba897ade8aa8227edda66508e16ab9
VecRect groupRectangles(VecRect rects, int groupThreshold, double eps) {
  cvRun(() => cobjdetect.cv_groupRectangles(rects.ptr, groupThreshold, eps, ffi.nullptr));
  return rects;
}

// QRCodeDetector groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html
class QRCodeDetector extends CvStruct<cvg.QRCodeDetector> {
  QRCodeDetector._(cvg.QRCodeDetectorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory QRCodeDetector.fromPointer(cvg.QRCodeDetectorPtr ptr, [bool attach = true]) =>
      QRCodeDetector._(ptr, attach);

  factory QRCodeDetector.empty() {
    final p = calloc<cvg.QRCodeDetector>();
    cvRun(() => cobjdetect.cv_QRCodeDetector_create(p));
    return QRCodeDetector._(p);
  }

  /// Decodes QR code on a curved surface in image once it's found by the detect() method.
  ///
  /// Returns UTF8-encoded output string or empty string if the code cannot be decoded.
  ///
  /// https://docs.opencv.org/4.x/de/dc3/classcv_1_1QRCodeDetector.html#ac7e9526c748b04186a6aa179f56096cf
  (String rval, Mat straightQRcode) decodeCurved(
    InputArray img,
    VecPoint points, {
    OutputArray? straightQRcode,
  }) {
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(
      () => cobjdetect.cv_QRCodeDetector_decodeCurved(
        ref,
        img.ref,
        points.ref,
        straightQRcode!.ptr,
        v,
        ffi.nullptr,
      ),
    );
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, straightQRcode);
  }

  /// Both detects and decodes QR code on a curved surface.
  ///
  /// https://docs.opencv.org/4.x/de/dc3/classcv_1_1QRCodeDetector.html#a9166527f6e20b600ed6a53ab3dd61f51
  (String rval, VecPoint points, Mat straightQRcode) detectAndDecodeCurved(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) {
    points ??= VecPoint();
    straightQRcode ??= Mat.empty();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(
      () => cobjdetect.cv_QRCodeDetector_detectAndDecodeCurved(
        ref,
        img.ref,
        points!.ptr,
        straightQRcode!.ptr,
        v,
        ffi.nullptr,
      ),
    );
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, points, straightQRcode);
  }

  /// DetectAndDecode Both detects and decodes QR code.
  ///
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a7290bd6a5d59b14a37979c3a14fbf394
  (String ret, VecPoint points, Mat straightCode) detectAndDecode(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) {
    straightCode ??= Mat.empty();
    final points = VecPoint();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(
      () => cobjdetect.cv_QRCodeDetector_detectAndDecode(
        ref,
        img.ref,
        points.ptr,
        straightCode!.ptr,
        v,
        ffi.nullptr,
      ),
    );
    final s = v == ffi.nullptr ? "" : v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (s, points, straightCode);
  }

  /// Detect detects QR code in image and returns the quadrangle containing the code.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a64373f7d877d27473f64fe04bb57d22b
  (bool ret, VecPoint points) detect(InputArray input, {VecPoint? points}) {
    points ??= VecPoint();
    final ret = calloc<ffi.Bool>();
    cvRun(() => cobjdetect.cv_QRCodeDetector_detect(ref, input.ref, points!.ptr, ret, ffi.nullptr));
    final rval = (ret.value, points);
    calloc.free(ret);
    return rval;
  }

  /// Decode decodes QR code in image once it's found by the detect() method. Returns UTF8-encoded output string or empty string if the code cannot be decoded.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a4172c2eb4825c844fb1b0ae67202d329
  (String ret, VecPoint? points, Mat? straightCode) decode(
    InputArray img, {
    VecPoint? points,
    Mat? straightCode,
  }) {
    points ??= VecPoint();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    cvRun(
      () =>
          cobjdetect.cv_QRCodeDetector_decode(ref, img.ref, points!.ptr, straightCode!.ref, ret, ffi.nullptr),
    );
    final info = ret.value.cast<Utf8>().toDartString();
    calloc.free(ret);
    return (info, points, straightCode);
  }

  /// Detects QR codes in image and finds of the quadrangles containing the codes.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true if QR code was detected
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#aaf2b6b2115b8e8fbc9acf3a8f68872b6
  (bool, VecPoint points) detectMulti(InputArray img, {VecPoint? points}) {
    points ??= VecPoint();
    final ret = calloc<ffi.Bool>();
    cvRun(() => cobjdetect.cv_QRCodeDetector_detectMulti(ref, img.ref, points!.ptr, ret, ffi.nullptr));
    final rval = (ret.value, points);
    calloc.free(ret);
    return rval;
  }

  /// Detects QR codes in image, finds the quadrangles containing the codes, and decodes the QRCodes to strings.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a188b63ffa17922b2c65d8a0ab7b70775
  (bool, List<String>, VecPoint, VecMat) detectAndDecodeMulti(InputArray img) {
    final info = VecVecChar();
    final points = VecPoint();
    final codes = VecMat();
    final rval = calloc<ffi.Bool>();
    cvRun(
      () => cobjdetect.cv_QRCodeDetector_detectAndDecodeMulti(
        ref,
        img.ref,
        info.ptr,
        points.ptr,
        codes.ptr,
        rval,
        ffi.nullptr,
      ),
    );
    final ret = (rval.value, info.asStringList(), points, codes);
    info.dispose();
    calloc.free(rval);
    return ret;
  }

  void setEpsX(double epsX) => cobjdetect.cv_QRCodeDetector_setEpsX(ref, epsX);

  void setEpsY(double epsY) => cobjdetect.cv_QRCodeDetector_setEpsY(ref, epsY);

  void setUseAlignmentMarkers(bool useAlignmentMarkers) =>
      cobjdetect.cv_QRCodeDetector_setUseAlignmentMarkers(ref, useAlignmentMarkers);

  static final finalizer = OcvFinalizer<cvg.QRCodeDetectorPtr>(cobjdetect.addresses.cv_QRCodeDetector_close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.cv_QRCodeDetector_close(ptr);
  }

  @override
  cvg.QRCodeDetector get ref => ptr.ref;
}

/// DNN-based face detector.
///
/// model download link: https://github.com/opencv/opencv_zoo/tree/master/models/face_detection_yunet
class FaceDetectorYN extends CvStruct<cvg.FaceDetectorYN> {
  FaceDetectorYN._(cvg.FaceDetectorYNPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FaceDetectorYN.fromPointer(cvg.FaceDetectorYNPtr ptr, [bool attach = true]) =>
      FaceDetectorYN._(ptr, attach);

  /// Creates an instance of face detector class with given parameters.
  ///
  /// [model]	the path to the requested model
  ///
  /// [config]	the path to the config file for compability, which is not requested for ONNX models
  ///
  /// [inputSize]	the size of the input image
  ///
  /// [scoreThreshold]	the threshold to filter out bounding boxes of score smaller than the given value
  ///
  /// [nmsThreshold]	the threshold to suppress bounding boxes of IoU bigger than the given value
  ///
  /// [topK]	keep top K bboxes before NMS
  ///
  /// [backendId]	the id of backend
  ///
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a5f7fb43c60c95ca5ebab78483de02516
  factory FaceDetectorYN.fromFile(
    String model,
    String config,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceDetectorYN>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(
      () => cobjdetect.cv_FaceDetectorYN_create(
        cModel,
        cConfig,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceDetectorYN._(p);
  }

  /// Creates an instance of face detector class with given parameters.
  ///
  /// [framework]	Name of origin framework
  ///
  /// [bufferModel]	A buffer with a content of binary file with weights
  ///
  /// [bufferConfig]	A buffer with a content of text file contains network configuration
  ///
  /// [inputSize]	the size of the input image
  ///
  /// [scoreThreshold]	the threshold to filter out bounding boxes of score smaller than the given value
  ///
  /// [nmsThreshold]	the threshold to suppress bounding boxes of IoU bigger than the given value
  ///
  /// [topK]	keep top K bboxes before NMS
  ///
  /// [backendId]	the id of backend
  ///
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#aa0796a4bfe2d4709bef81abbae9a927a
  factory FaceDetectorYN.fromBuffer(
    String framework,
    Uint8List bufferModel,
    Uint8List bufferConfig,
    (int, int) inputSize, {
    double scoreThreshold = 0.9,
    double nmsThreshold = 0.3,
    int topK = 5000,
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceDetectorYN>();
    final cFramework = framework.toNativeUtf8().cast<ffi.Char>();
    final bufM = VecUChar.fromList(bufferModel);
    final bufC = VecUChar.fromList(bufferConfig);
    cvRun(
      () => cobjdetect.cv_FaceDetectorYN_create_1(
        cFramework,
        bufM.ref,
        bufC.ref,
        inputSize.cvd.ref,
        scoreThreshold,
        nmsThreshold,
        topK,
        backendId,
        targetId,
        p,
      ),
    );
    calloc.free(cFramework);
    bufM.dispose();
    bufC.dispose();
    return FaceDetectorYN._(p);
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a68b6fb9bffbed0f3d5c104996113f247
  (int, int) getInputSize() {
    final p = cobjdetect.cv_FaceDetectorYN_getInputSize(ref);
    final ret = (p.width, p.height);
    return ret;
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a5329744e10441e1c01526f1ff10b80de
  double getScoreThreshold() => cobjdetect.cv_FaceDetectorYN_getScoreThreshold(ref);

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a40749dc04b9578631d55122be9ab10c3
  double getNmsThreshold() => cobjdetect.cv_FaceDetectorYN_getNMSThreshold(ref);

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#acc6139ba763acd67f4aa738cee45b7ec
  int getTopK() => cobjdetect.cv_FaceDetectorYN_getTopK(ref);

  /// Detects faces in the input image. Following is an example output.
  ///
  /// [image]	an image to detect
  ///
  /// detection results stored in a 2D cv::Mat of shape [num_faces, 15]
  ///
  /// - 0-1: x, y of bbox top left corner
  /// - 2-3: width, height of bbox
  /// - 4-5: x, y of right eye (blue point in the example image)
  /// - 6-7: x, y of left eye (red point in the example image)
  /// - 8-9: x, y of nose tip (green point in the example image)
  /// - 10-11: x, y of right corner of mouth (pink point in the example image)
  /// - 12-13: x, y of left corner of mouth (yellow point in the example image)
  /// - 14: face score
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#ac05bd075ca3e6edc0e328927aae6f45b
  Mat detect(Mat image) {
    final ret = Mat.empty();
    cvRun(() => cobjdetect.cv_FaceDetectorYN_detect(ref, image.ref, ret.ptr, ffi.nullptr));
    return ret;
  }

  /// Set the size for the network input, which overwrites the input size
  /// of creating model. Call this method when the size of input image does
  /// not match the input size when creating model.
  ///
  /// [inputSize]	the size of the input image
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a072418e5ce7beeb69c41edda75c41d2e
  void setInputSize((int, int) inputSize) =>
      cobjdetect.cv_FaceDetectorYN_setInputSize(ref, inputSize.cvd.ref);

  /// Set the score threshold to filter out bounding boxes of score less than
  /// the given value.
  ///
  /// [scoreThreshold]	threshold for filtering out bounding boxes
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a37f3c23b82158fac7fdad967d315f85a
  void setScoreThreshold(double scoreThreshold) =>
      cobjdetect.cv_FaceDetectorYN_setScoreThreshold(ref, scoreThreshold);

  /// Set the Non-maximum-suppression threshold to suppress
  /// bounding boxes that have IoU greater than the given value.
  ///
  /// [nmsThreshold]	threshold for NMS operation
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#ab6011efee7e12dca3857d82de5269ac5
  void setNMSThreshold(double nmsThreshold) =>
      cobjdetect.cv_FaceDetectorYN_setNMSThreshold(ref, nmsThreshold);

  /// Set the number of bounding boxes preserved before NMS.
  ///
  /// [topK]	the number of bounding boxes to preserve from top rank based on score
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#aa88d20e1e2df75ea36b851534089856a
  void setTopK(int topK) => cobjdetect.cv_FaceDetectorYN_setTopK(ref, topK);

  @override
  cvg.FaceDetectorYN get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cvg.FaceDetectorYNPtr>(cobjdetect.addresses.cv_FaceDetectorYN_close);

  void dispose() {
    finalizer.detach(this);
    cobjdetect.cv_FaceDetectorYN_close(ptr);
  }
}

/// DNN-based face recognizer.
///
/// model download link: https://github.com/opencv/opencv_zoo/tree/master/models/face_recognition_sface
class FaceRecognizerSF extends CvStruct<cvg.FaceRecognizerSF> {
  FaceRecognizerSF._(cvg.FaceRecognizerSFPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory FaceRecognizerSF.fromPointer(cvg.FaceRecognizerSFPtr ptr, [bool attach = true]) =>
      FaceRecognizerSF._(ptr, attach);

  /// Creates an instance of this class with given parameters.
  ///
  /// [model]	the path of the onnx model used for face recognition
  /// [config]	the path to the config file for compability, which is not requested for ONNX models
  /// [backendId]	the id of backend
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a04df90b0cd7d26d350acd92621a35743
  factory FaceRecognizerSF.fromFile(String model, String config, {int backendId = 0, int targetId = 0}) {
    final p = calloc<cvg.FaceRecognizerSF>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => cobjdetect.cv_FaceRecognizerSF_create(cModel, cConfig, backendId, targetId, p));
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceRecognizerSF._(p);
  }

  /// Aligns detected face with the source input image and crops it.
  ///
  /// [srcImg]	input image
  /// [faceBox]	the detected face result from the input image
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a84492908abecbc9362b4ddc8d46b8345
  Mat alignCrop(Mat srcImg, Mat faceBox) {
    final ret = Mat.empty();
    cvRun(() => cobjdetect.cv_FaceRecognizerSF_alignCrop(ref, srcImg.ref, faceBox.ref, ret.ptr, ffi.nullptr));
    return ret;
  }

  /// Extracts face feature from aligned image.
  ///
  /// [alignedImg]	input aligned image
  /// [clone] the default implementation of opencv won't clone the returned Mat
  /// set [clone] to true will return a clone of returned Mat
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#ab1b4a3c12213e89091a490c573dc5aba
  Mat feature(Mat alignedImg, {bool clone = false}) {
    final ret = Mat.empty();
    cvRun(() => cobjdetect.cv_FaceRecognizerSF_feature(ref, alignedImg.ref, clone, ret.ptr, ffi.nullptr));
    return ret;
  }

  /// Calculates the distance between two face features.
  ///
  /// [faceFeature1]	the first input feature
  /// [faceFeature2]	the second input feature of the same size and the same type as face_feature1
  /// [disType]	defines how to calculate the distance between two face features
  /// with optional values "FR_COSINE" or "FR_NORM_L2"
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a2f0362ca1e64320a1f3ba7e1386d0219
  double match(Mat faceFeature1, Mat faceFeature2, {int disType = FR_COSINE}) {
    final distance = calloc<ffi.Double>();
    cvRun(
      () => cobjdetect.cv_FaceRecognizerSF_match(
        ref,
        faceFeature1.ref,
        faceFeature2.ref,
        disType,
        distance,
        ffi.nullptr,
      ),
    );
    final rval = distance.value;
    calloc.free(distance);
    return rval;
  }

  @override
  cvg.FaceRecognizerSF get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cvg.FaceRecognizerSFPtr>(
    cobjdetect.addresses.cv_FaceRecognizerSF_close,
  );

  void dispose() {
    finalizer.detach(this);
    cobjdetect.cv_FaceRecognizerSF_close(ptr);
  }

  @Deprecated("Use [FR_COSINE] instead.")
  static const int DIS_TYPR_FR_COSINE = 0;
  @Deprecated("Use [FR_NORM_L2] instead.")
  static const int DIS_TYPE_FR_NORM_L2 = 1;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_COSINE = 0;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_NORM_L2 = 1;
}
