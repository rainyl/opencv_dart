// ignore_for_file: constant_identifier_names

library cv;

import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../core/base.dart';
import '../core/mat.dart';
import '../core/point.dart';
import '../core/rect.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;

class CascadeClassifier extends CvStruct<cvg.CascadeClassifier> {
  CascadeClassifier._(cvg.CascadeClassifierPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory CascadeClassifier.empty() {
    final p = calloc<cvg.CascadeClassifier>();
    cvRun(() => CFFI.CascadeClassifier_New(p));
    return CascadeClassifier._(p);
  }

  factory CascadeClassifier.fromFile(String filename) {
    final p = calloc<cvg.CascadeClassifier>();
    final cp = filename.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => CFFI.CascadeClassifier_NewFromFile(cp, p));
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
    cvRun(() => CFFI.CascadeClassifier_Load(ref, cname, p));
    calloc.free(cname);
    return p.value != 0;
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
    final ret = calloc<cvg.VecRect>();
    cvRun(
      () => CFFI.CascadeClassifier_DetectMultiScaleWithParams(
        ref,
        image.ref,
        ret,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
      ),
    );
    return VecRect.fromPointer(ret);
  }

  (VecRect objects, VecInt numDetections) detectMultiScale2(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
  }) {
    final ret = calloc<cvg.VecRect>();
    final pnums = calloc<cvg.VecInt>();
    cvRun(
      () => CFFI.CascadeClassifier_DetectMultiScale2(
        ref,
        image.ref,
        ret,
        pnums,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.cvd.ref,
        maxSize.cvd.ref,
      ),
    );
    return (VecRect.fromPointer(ret), VecInt.fromPointer(pnums));
  }

  (VecRect objects, VecInt numDetections, VecDouble levelWeights) detectMultiScale3(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    (int, int) minSize = (0, 0),
    (int, int) maxSize = (0, 0),
    bool outputRejectLevels = false,
  }) {
    final objects = calloc<cvg.VecRect>();
    final rejectLevels = calloc<cvg.VecInt>();
    final levelWeights = calloc<cvg.VecDouble>();
    cvRun(
      () => CFFI.CascadeClassifier_DetectMultiScale3(
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
      ),
    );
    return (
      VecRect.fromPointer(objects),
      VecInt.fromPointer(rejectLevels),
      VecDouble.fromPointer(levelWeights)
    );
  }

  /// Checks whether the classifier has been loaded.
  ///
  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a1753ebe58554fe0673ce46cb4e83f08a
  bool empty() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.CascadeClassifier_Empty(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a0bab6de516c685ba879a4b1f1debdef1
  int getFeatureType() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.CascadeClassifier_getFeatureType(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a7a131d319ab42a444ff2bcbb433b7b41
  (int, int) getOriginalWindowSize() {
    final p = calloc<cvg.Size>();
    cvRun(() => CFFI.CascadeClassifier_getOriginalWindowSize(ref, p));
    final ret = (p.ref.width, p.ref.height);
    calloc.free(p);
    return ret;
  }

  /// https://docs.opencv.org/4.x/d1/de5/classcv_1_1CascadeClassifier.html#a556bdd8738ba96aac07628ec38ff46da
  bool isOldFormatCascade() {
    return using<bool>((arena) {
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.CascadeClassifier_isOldFormatCascade(ref, p));
      return p.value;
    });
  }

  @override
  cvg.CascadeClassifier get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.CascadeClassifierPtr>(CFFI.addresses.CascadeClassifier_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.CascadeClassifier_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

class HOGDescriptor extends CvStruct<cvg.HOGDescriptor> {
  HOGDescriptor._(cvg.HOGDescriptorPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  factory HOGDescriptor.empty() {
    final p = calloc<cvg.HOGDescriptor>();
    cvRun(() => CFFI.HOGDescriptor_New(p));
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
    cvRun(() => CFFI.HOGDescriptor_NewFromFile(cp, p));
    calloc.free(cp);
    return HOGDescriptor._(p);
  }

  bool load(String name) {
    return using<bool>((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      final p = arena<ffi.Bool>();
      cvRun(() => CFFI.HOGDescriptor_Load(ref, cname.cast(), p));
      return p.value;
    });
  }

  /// Computes HOG descriptors of given image.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a38cd712cd5a6d9ed0344731fcd121e8b
  (VecFloat descriptors, VecPoint locations) compute(
    Mat img, {
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final descriptors = calloc<cvg.VecFloat>();
    final locations = calloc<cvg.VecPoint>();
    cvRun(
      () => CFFI.HOGDescriptor_Compute(
        ref,
        img.ref,
        descriptors,
        winStride.cvd.ref,
        padding.cvd.ref,
        locations,
      ),
    );
    return (
      VecFloat.fromPointer(descriptors),
      VecPoint.fromPointer(locations),
    );
  }

  /// Computes gradients and quantized gradient orientations.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a1f76c51c08d69f2b8a0f079efc4bd093
  (Mat grad, Mat angleOfs) computeGradient(
    InputArray img, {
    (int, int) paddingTL = (0, 0),
    (int, int) paddingBR = (0, 0),
  }) {
    final grad = Mat.empty();
    final angleOfs = Mat.empty();
    cvRun(
      () => CFFI.HOGDescriptor_computeGradient(
        ref,
        img.ref,
        grad.ref,
        angleOfs.ref,
        paddingTL.cvd.ref,
        paddingBR.cvd.ref,
      ),
    );
    return (grad, angleOfs);
  }

  /// Performs object detection without a multi-scale window.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#a309829908ffaf4645755729d7aa90627
  (VecPoint foundLocations, VecDouble weights, VecPoint searchLocations) detect2(
    InputArray img, {
    double hitThreshold = 0,
    (int, int) winStride = (0, 0),
    (int, int) padding = (0, 0),
  }) {
    final foundLocations = calloc<cvg.VecPoint>();
    final searchLocations = calloc<cvg.VecPoint>();
    final weights = calloc<cvg.VecDouble>();
    cvRun(
      () => CFFI.HOGDescriptor_Detect(
        ref,
        img.ref,
        foundLocations,
        weights,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
      ),
    );
    return (
      VecPoint.fromPointer(foundLocations),
      VecDouble.fromPointer(weights),
      VecPoint.fromPointer(searchLocations),
    );
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
    final foundLocations = calloc<cvg.VecPoint>();
    final searchLocations = calloc<cvg.VecPoint>();
    cvRun(
      () => CFFI.HOGDescriptor_Detect2(
        ref,
        img.ref,
        foundLocations,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        searchLocations,
      ),
    );
    return (VecPoint.fromPointer(foundLocations), VecPoint.fromPointer(searchLocations));
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
    final rects = calloc<cvg.VecRect>();
    cvRun(
      () => CFFI.HOGDescriptor_DetectMultiScaleWithParams(
        ref,
        image.ref,
        hitThreshold,
        winStride.cvd.ref,
        padding.cvd.ref,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
        rects,
      ),
    );
    return VecRect.fromPointer(rects);
  }

  /// HOGDefaultPeopleDetector returns a new Mat with the HOG DefaultPeopleDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  static VecFloat getDefaultPeopleDetector() {
    final v = calloc<cvg.VecFloat>();
    cvRun(() => CFFI.HOG_GetDefaultPeopleDetector(v));
    return VecFloat.fromPointer(v);
  }

  static VecFloat getDaimlerPeopleDetector() {
    final v = calloc<cvg.VecFloat>();
    cvRun(() => CFFI.HOGDescriptor_getDaimlerPeopleDetector(v));
    return VecFloat.fromPointer(v);
  }

  int getDescriptorSize() {
    return using<int>((arena) {
      final p = arena<ffi.Size>(); // size_t
      cvRun(() => CFFI.HOGDescriptor_getDescriptorSize(ref, p));
      return p.value;
    });
  }

  /// Returns winSigma value.
  double getWinSigma() {
    return using<double>((arena) {
      final p = arena<ffi.Double>();
      cvRun(() => CFFI.HOGDescriptor_getWinSigma(ref, p));
      return p.value;
    });
  }

  /// Groups the object candidate rectangles.
  ///
  /// https://docs.opencv.org/4.x/d5/d33/structcv_1_1HOGDescriptor.html#ad7c9679b23e8476e332e9114181d656d
  (VecRect rectList, VecDouble weights) groupRectangles(
    VecRect rectList,
    VecDouble weights,
    int groupThreshold,
    double eps,
  ) {
    cvRun(
      () => CFFI.HOGDescriptor_groupRectangles(
        ref,
        rectList.ref,
        weights.ref,
        groupThreshold,
        eps,
      ),
    );
    return (rectList, weights);
  }

  /// SetSVMDetector sets the data for the HOGDescriptor.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a09e354ad701f56f9c550dc0385dc36f1
  void setSVMDetector(VecFloat det) {
    cvRun(() => CFFI.HOGDescriptor_SetSVMDetector(ref, det.ref));
  }

  @override
  cvg.HOGDescriptor get ref => ptr.ref;
  static final finalizer = OcvFinalizer<cvg.HOGDescriptorPtr>(CFFI.addresses.HOGDescriptor_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.HOGDescriptor_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
}

// GroupRectangles groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/d5/d54/group__objdetect.html#ga3dba897ade8aa8227edda66508e16ab9
VecRect groupRectangles(VecRect rects, int groupThreshold, double eps) {
  cvRun(() => CFFI.GroupRectangles(rects.ref, groupThreshold, eps));
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

  factory QRCodeDetector.empty() {
    final p = calloc<cvg.QRCodeDetector>();
    cvRun(() => CFFI.QRCodeDetector_New(p));
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
    final s = straightQRcode?.ptr ?? calloc<cvg.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => CFFI.QRCodeDetector_decodeCurved(ref, img.ref, points.ref, s, v));
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, Mat.fromPointer(s));
  }

  /// Both detects and decodes QR code on a curved surface.
  ///
  /// https://docs.opencv.org/4.x/de/dc3/classcv_1_1QRCodeDetector.html#a9166527f6e20b600ed6a53ab3dd61f51
  (String rval, VecPoint points, Mat straightQRcode) detectAndDecodeCurved(
    InputArray img, {
    VecPoint? points,
    Mat? straightQRcode,
  }) {
    final p = points?.ptr ?? calloc<cvg.VecPoint>();
    final s = straightQRcode?.ptr ?? calloc<cvg.Mat>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => CFFI.QRCodeDetector_detectAndDecodeCurved(ref, img.ref, p, s, v));
    final ss = v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (ss, points ?? VecPoint.fromPointer(p), Mat.fromPointer(s));
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
    final code = straightCode?.ptr ?? calloc<cvg.Mat>();
    final points = calloc<cvg.VecPoint>();
    final v = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => CFFI.QRCodeDetector_DetectAndDecode(ref, img.ref, points, code, v));
    final s = v == ffi.nullptr ? "" : v.value.cast<Utf8>().toDartString();
    calloc.free(v);
    return (s, VecPoint.fromPointer(points), Mat.fromPointer(code));
  }

  /// Detect detects QR code in image and returns the quadrangle containing the code.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a64373f7d877d27473f64fe04bb57d22b
  (bool ret, VecPoint points) detect(InputArray input, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint)>((arena) {
      final pts = calloc<cvg.VecPoint>();
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.QRCodeDetector_Detect(ref, input.ref, pts, ret));
      return (ret.value, VecPoint.fromPointer(pts));
    });
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
    final p = points?.ptr ?? calloc<cvg.VecPoint>();
    final ret = calloc<ffi.Pointer<ffi.Char>>();
    straightCode ??= Mat.empty();
    cvRun(() => CFFI.QRCodeDetector_Decode(ref, img.ref, p, straightCode!.ref, ret));
    final info = ret.value.cast<Utf8>().toDartString();
    calloc.free(ret);
    return (info, VecPoint.fromPointer(p), straightCode);
  }

  /// Detects QR codes in image and finds of the quadrangles containing the codes.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true if QR code was detected
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#aaf2b6b2115b8e8fbc9acf3a8f68872b6
  (bool, VecPoint points) detectMulti(InputArray img, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint)>((arena) {
      final p = points?.ptr ?? calloc<cvg.VecPoint>();
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.QRCodeDetector_DetectMulti(ref, img.ref, p, ret));
      return (ret.value, VecPoint.fromPointer(p));
    });
  }

  /// Detects QR codes in image, finds the quadrangles containing the codes, and decodes the QRCodes to strings.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a188b63ffa17922b2c65d8a0ab7b70775
  (bool, List<String>, VecPoint, VecMat) detectAndDecodeMulti(InputArray img) {
    final info = calloc<cvg.VecVecChar>();
    final points = calloc<cvg.VecPoint>();
    final codes = calloc<cvg.VecMat>();
    final rval = calloc<ffi.Bool>();
    cvRun(() => CFFI.QRCodeDetector_DetectAndDecodeMulti(ref, img.ref, info, points, codes, rval));
    final ret = (
      rval.value,
      VecVecChar.fromPointer(info).asStringList(),
      VecPoint.fromPointer(points),
      VecMat.fromPointer(codes),
    );
    calloc.free(rval);
    return ret;
  }

  void setEpsX(double epsX) {
    cvRun(() => CFFI.QRCodeDetector_setEpsX(ref, epsX));
  }

  void setEpsY(double epsY) {
    cvRun(() => CFFI.QRCodeDetector_setEpsY(ref, epsY));
  }

  void setUseAlignmentMarkers(bool useAlignmentMarkers) {
    cvRun(() => CFFI.QRCodeDetector_setUseAlignmentMarkers(ref, useAlignmentMarkers));
  }

  static final finalizer = OcvFinalizer<cvg.QRCodeDetectorPtr>(CFFI.addresses.QRCodeDetector_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.QRCodeDetector_Close(ptr);
  }

  @override
  cvg.QRCodeDetector get ref => ptr.ref;
  @override
  List<int> get props => [ptr.address];
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
      () => CFFI.FaceDetectorYN_New(
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
    cvRun(
      () => CFFI.FaceDetectorYN_NewFromBuffer(
        cFramework,
        VecUChar.fromList(bufferModel).ref,
        VecUChar.fromList(bufferConfig).ref,
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
    return FaceDetectorYN._(p);
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a68b6fb9bffbed0f3d5c104996113f247
  (int, int) getInputSize() {
    final p = calloc<cvg.Size>();
    cvRun(() => CFFI.FaceDetectorYN_GetInputSize(ref, p));
    final ret = (p.ref.width, p.ref.height);
    calloc.free(p);
    return ret;
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a5329744e10441e1c01526f1ff10b80de
  double getScoreThreshold() {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.FaceDetectorYN_GetScoreThreshold(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a40749dc04b9578631d55122be9ab10c3
  double getNmsThreshold() {
    return using<double>((arena) {
      final p = arena<ffi.Float>();
      cvRun(() => CFFI.FaceDetectorYN_GetNMSThreshold(ref, p));
      return p.value;
    });
  }

  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#acc6139ba763acd67f4aa738cee45b7ec
  int getTopK() {
    return using<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.FaceDetectorYN_GetTopK(ref, p));
      return p.value;
    });
  }

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
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.FaceDetectorYN_Detect(ref, image.ref, p));
    return Mat.fromPointer(p);
  }

  /// Set the size for the network input, which overwrites the input size
  /// of creating model. Call this method when the size of input image does
  /// not match the input size when creating model.
  ///
  /// [inputSize]	the size of the input image
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a072418e5ce7beeb69c41edda75c41d2e
  void setInputSize((int, int) inputSize) {
    cvRun(() => CFFI.FaceDetectorYN_SetInputSize(ref, inputSize.cvd.ref));
  }

  /// Set the score threshold to filter out bounding boxes of score less than
  /// the given value.
  ///
  /// [scoreThreshold]	threshold for filtering out bounding boxes
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#a37f3c23b82158fac7fdad967d315f85a
  void setScoreThreshold(double scoreThreshold) {
    cvRun(() => CFFI.FaceDetectorYN_SetScoreThreshold(ref, scoreThreshold));
  }

  /// Set the Non-maximum-suppression threshold to suppress
  /// bounding boxes that have IoU greater than the given value.
  ///
  /// [nmsThreshold]	threshold for NMS operation
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#ab6011efee7e12dca3857d82de5269ac5
  void setNMSThreshold(double nmsThreshold) {
    cvRun(() => CFFI.FaceDetectorYN_SetNMSThreshold(ref, nmsThreshold));
  }

  /// Set the number of bounding boxes preserved before NMS.
  ///
  /// [topK]	the number of bounding boxes to preserve from top rank based on score
  ///
  /// https://docs.opencv.org/4.x/df/d20/classcv_1_1FaceDetectorYN.html#aa88d20e1e2df75ea36b851534089856a
  void setTopK(int topK) {
    cvRun(() => CFFI.FaceDetectorYN_SetTopK(ref, topK));
  }

  @override
  cvg.FaceDetectorYN get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cvg.FaceDetectorYNPtr>(CFFI.addresses.FaceDetectorYN_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.FaceDetectorYN_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];
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

  @Deprecated("Use FaceRecognizerSF.fromFile instead, will be removed in 1.1.0")
  factory FaceRecognizerSF.newRecognizer(
    String model,
    String config,
    int backendId,
    int targetId,
  ) {
    final p = calloc<cvg.FaceRecognizerSF>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => CFFI.FaceRecognizerSF_New(cModel, cConfig, backendId, targetId, p));
    calloc.free(cModel);
    calloc.free(cConfig);
    return FaceRecognizerSF._(p);
  }

  /// Creates an instance of this class with given parameters.
  ///
  /// [model]	the path of the onnx model used for face recognition
  /// [config]	the path to the config file for compability, which is not requested for ONNX models
  /// [backendId]	the id of backend
  /// [targetId]	the id of target device
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#a04df90b0cd7d26d350acd92621a35743
  factory FaceRecognizerSF.fromFile(
    String model,
    String config, {
    int backendId = 0,
    int targetId = 0,
  }) {
    final p = calloc<cvg.FaceRecognizerSF>();
    final cModel = model.toNativeUtf8().cast<ffi.Char>();
    final cConfig = config.toNativeUtf8().cast<ffi.Char>();
    cvRun(() => CFFI.FaceRecognizerSF_New(cModel, cConfig, backendId, targetId, p));
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
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.FaceRecognizerSF_AlignCrop(ref, srcImg.ref, faceBox.ref, p));
    return Mat.fromPointer(p);
  }

  /// Extracts face feature from aligned image.
  ///
  /// [alignedImg]	input aligned image
  /// [clone] the default implementation of opencv won't clone the returned Mat
  /// set [clone] to true will return a clone of returned Mat
  ///
  /// https://docs.opencv.org/4.x/da/d09/classcv_1_1FaceRecognizerSF.html#ab1b4a3c12213e89091a490c573dc5aba
  Mat feature(Mat alignedImg, {bool clone = false}) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.FaceRecognizerSF_Feature(ref, alignedImg.ref, clone, p));
    return Mat.fromPointer(p);
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
    return using<double>((arena) {
      final distance = arena<ffi.Double>();
      cvRun(
        () => CFFI.FaceRecognizerSF_Match(
          ref,
          faceFeature1.ref,
          faceFeature2.ref,
          disType,
          distance,
        ),
      );
      return distance.value;
    });
  }

  @override
  cvg.FaceRecognizerSF get ref => ptr.ref;

  static final finalizer = OcvFinalizer<cvg.FaceRecognizerSFPtr>(CFFI.addresses.FaceRecognizerSF_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.FaceRecognizerSF_Close(ptr);
  }

  @override
  List<int> get props => [ptr.address];

  @Deprecated("Use [FR_COSINE] instead.")
  static const int DIS_TYPR_FR_COSINE = 0;
  @Deprecated("Use [FR_NORM_L2] instead.")
  static const int DIS_TYPE_FR_NORM_L2 = 1;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_COSINE = 0;

  /// Definition of distance used for calculating the distance between two face features.
  static const int FR_NORM_L2 = 1;
}
