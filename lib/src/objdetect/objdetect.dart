library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/rect.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../core/size.dart';
import '../core/vec.dart';
import '../core/point.dart';
import '../opencv.g.dart' as cvg;

class CascadeClassifier extends CvStruct<cvg.CascadeClassifier> {
  CascadeClassifier._(cvg.CascadeClassifierPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  factory CascadeClassifier.empty() {
    final p = calloc<cvg.CascadeClassifier>();
    cvRun(() => CFFI.CascadeClassifier_New(p));
    return CascadeClassifier._(p);
  }

  /// Load cascade classifier from a file.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#a1a5884c8cc749422f9eb77c2471958bc
  bool load(String name) {
    return using<bool>((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.CascadeClassifier_Load(ref, cname.cast(), p));
      return p.value != 0;
    });
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
    Size minSize = (0, 0),
    Size maxSize = (0, 0),
  }) {
    return using<VecRect>((arena) {
      final ret = arena<cvg.VecRect>();
      cvRun(() => CFFI.CascadeClassifier_DetectMultiScaleWithParams(ref, image.ref, scaleFactor, minNeighbors,
          flags, minSize.toSize(arena).ref, maxSize.toSize(arena).ref, ret));
      return VecRect.fromVec(ret.ref);
    });
  }

  @override
  cvg.CascadeClassifier get ref => ptr.ref;
  static final finalizer = Finalizer<cvg.CascadeClassifierPtr>((p) {
    CFFI.CascadeClassifier_Close(p);
    calloc.free(p);
  });

  @override
  List<int> get props => [ptr.address];
}

class HOGDescriptor extends CvStruct<cvg.HOGDescriptor> {
  HOGDescriptor._(cvg.HOGDescriptorPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  factory HOGDescriptor.empty() {
    final p = calloc<cvg.HOGDescriptor>();
    cvRun(() => CFFI.HOGDescriptor_New(p));
    return HOGDescriptor._(p);
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
    Size winStride = (0, 0),
    Size padding = (0, 0),
    double scale = 1.05,
    double groupThreshold = 2.0,
    bool useMeanshiftGrouping = false,
  }) {
    return using<VecRect>((arena) {
      final rects = VecRect();
      cvRun(
        () => CFFI.HOGDescriptor_DetectMultiScaleWithParams(
          ref,
          image.ref,
          hitThreshold,
          winStride.toSize(arena).ref,
          padding.toSize(arena).ref,
          scale,
          groupThreshold,
          useMeanshiftGrouping,
          rects.ptr,
        ),
      );
      return rects;
    });
  }

  /// HOGDefaultPeopleDetector returns a new Mat with the HOG DefaultPeopleDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  static VecFloat getDefaultPeopleDetector() {
    return cvRunArena<VecFloat>((arena) {
      final v = arena<cvg.VecFloat>();
      cvRun(() => CFFI.HOG_GetDefaultPeopleDetector(v));
      return VecFloat.fromVec(v.ref);
    });
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
  static final finalizer = Finalizer<cvg.HOGDescriptorPtr>((p) {
    CFFI.HOGDescriptor_Close(p);
    calloc.free(p);
  });

  @override
  List<int> get props => [ptr.address];
}

// GroupRectangles groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/d5/d54/group__objdetect.html#ga3dba897ade8aa8227edda66508e16ab9
VecRect groupRectangles(VecRect rects, int groupThreshold, double eps) {
  return using<VecRect>((arena) {
    cvRun(() => CFFI.GroupRectangles(rects.ref, groupThreshold, eps));
    return rects;
  });
}

// QRCodeDetector groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html
class QRCodeDetector extends CvStruct<cvg.QRCodeDetector> {
  QRCodeDetector._(cvg.QRCodeDetectorPtr ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  factory QRCodeDetector.empty() {
    final p = calloc<cvg.QRCodeDetector>();
    cvRun(() => CFFI.QRCodeDetector_New(p));
    return QRCodeDetector._(p);
  }

  /// DetectAndDecode Both detects and decodes QR code.
  ///
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a7290bd6a5d59b14a37979c3a14fbf394
  (String ret, VecPoint? points, Mat? straightCode) detectAndDecode(
    InputArray img, {
    VecPoint? points,
    OutputArray? straightCode,
  }) {
    straightCode ??= Mat.empty();
    final points = VecPoint.fromList([]);
    final s = cvRunArena<String>((arena) {
      final v = arena<cvg.VecChar>();
      cvRun(() => CFFI.QRCodeDetector_DetectAndDecode(ref, img.ref, points.ptr, straightCode!.ptr, v));
      if (v == ffi.nullptr) return "";
      return VecChar.fromVec(v.ref).toString();
    });
    return (s, points, straightCode);
  }

  /// Detect detects QR code in image and returns the quadrangle containing the code.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a64373f7d877d27473f64fe04bb57d22b
  (bool ret, VecPoint? points) detect(InputArray input, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint?)>((arena) {
      final pts = VecPoint();
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.QRCodeDetector_Detect(ref, input.ref, pts.ref, ret));
      return (ret.value, pts);
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
    return cvRunArena<(String, VecPoint?, Mat?)>((arena) {
      points ??= VecPoint();
      final ret = VecChar();
      straightCode ??= Mat.empty();
      cvRun(() => CFFI.QRCodeDetector_Decode(ref, img.ref, points!.ref, straightCode!.ref, ret.ptr));
      return (ret.toString(), points, straightCode!);
    });
  }

  /// Detects QR codes in image and finds of the quadrangles containing the codes.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true if QR code was detected
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#aaf2b6b2115b8e8fbc9acf3a8f68872b6
  (bool, VecPoint? points) detectMulti(InputArray img, {VecPoint? points}) {
    return cvRunArena<(bool, VecPoint?)>((arena) {
      points ??= VecPoint.fromList([]);
      final ret = arena<ffi.Bool>();
      cvRun(() => CFFI.QRCodeDetector_DetectMulti(ref, img.ref, points!.ref, ret));
      return ret.value ? (ret.value, VecPoint.fromVec(points!.ref)) : (ret.value, null);
    });
  }

  /// Detects QR codes in image, finds the quadrangles containing the codes, and decodes the QRCodes to strings.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a188b63ffa17922b2c65d8a0ab7b70775
  // TODO: (bool, List<String>, Mat, List<Mat>) detectAndDecodeMulti(InputArray img) {}

  static final finalizer = Finalizer<cvg.QRCodeDetectorPtr>((p) {
    CFFI.QRCodeDetector_Close(p);
    calloc.free(p);
  });

  @override
  cvg.QRCodeDetector get ref => ptr.ref;
  @override
  List<int> get props => [ptr.address];
}
