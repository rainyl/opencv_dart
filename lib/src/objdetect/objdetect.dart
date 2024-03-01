library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../core/extensions.dart';
import '../core/rect.dart';
import '../core/base.dart';
import '../core/mat.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class CascadeClassifier implements ffi.Finalizable {
  CascadeClassifier._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory CascadeClassifier.empty() {
    final _ptr = _bindings.CascadeClassifier_New();
    return CascadeClassifier._(_ptr);
  }

  /// Load cascade classifier from a file.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#a1a5884c8cc749422f9eb77c2471958bc
  bool load(String name) {
    return using<bool>((arena) {
      final cname = name.toNativeUtf8(allocator: arena);
      final ret = _bindings.CascadeClassifier_Load(_ptr, cname.cast());
      return ret != 0;
    });
  }

  /// DetectMultiScale detects objects of different sizes in the input Mat image.
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// http://docs.opencv.org/master/d1/de5/classcv_1_1CascadeClassifier.html#aaf8181cb63968136476ec4204ffca498
  List<Rect> detectMultiScale(
    InputArray image, {
    double scaleFactor = 1.1,
    int minNeighbors = 3,
    int flags = 0,
    Size minSize = (0, 0),
    Size maxSize = (0, 0),
  }) {
    final rects = using<cvg.Rects>((arena) {
      final _rects = _bindings.CascadeClassifier_DetectMultiScaleWithParams(
        _ptr,
        image.ptr,
        scaleFactor,
        minNeighbors,
        flags,
        minSize.toSize(arena).ref,
        maxSize.toSize(arena).ref,
      );
      return _rects;
    });
    return Rects.toList(rects);
  }

  cvg.CascadeClassifier _ptr;
  cvg.CascadeClassifier get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.CascadeClassifier_Close);
}

class HOGDescriptor implements ffi.Finalizable {
  HOGDescriptor._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory HOGDescriptor.empty() {
    final _ptr = _bindings.HOGDescriptor_New();
    return HOGDescriptor._(_ptr);
  }

  /// DetectMultiScale calls DetectMultiScale but allows setting parameters
  /// The detected objects are returned as a slice of image.Rectangle structs.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  List<Rect> detectMultiScale(
    InputArray image, {
    double hitThreshold = 0,
    int minNeighbors = 3,
    Size winStride = (0, 0),
    Size padding = (0, 0),
    double scale = 1.05,
    double groupThreshold = 2.0,
    bool useMeanshiftGrouping = false,
  }) {
    final rects = using<cvg.Rects>((arena) {
      final _rects = _bindings.HOGDescriptor_DetectMultiScaleWithParams(
        _ptr,
        image.ptr,
        hitThreshold,
        winStride.toSize(arena).ref,
        padding.toSize(arena).ref,
        scale,
        groupThreshold,
        useMeanshiftGrouping,
      );
      return _rects;
    });
    return Rects.toList(rects);
  }

  /// HOGDefaultPeopleDetector returns a new Mat with the HOG DefaultPeopleDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a660e5cd036fd5ddf0f5767b352acd948
  static Mat getDefaultPeopleDetector() {
    return Mat.fromCMat(_bindings.HOG_GetDefaultPeopleDetector());
  }

  /// SetSVMDetector sets the data for the HOGDescriptor.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d33/structcv_1_1HOGDescriptor.html#a09e354ad701f56f9c550dc0385dc36f1
  void setSVMDetector(Mat det) {
    _bindings.HOGDescriptor_SetSVMDetector(_ptr, det.ptr);
  }

  cvg.HOGDescriptor _ptr;
  cvg.HOGDescriptor get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.HOGDescriptor_Close);
}

// GroupRectangles groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/d5/d54/group__objdetect.html#ga3dba897ade8aa8227edda66508e16ab9
List<Rect> groupRectangles(List<Rect> rects, int groupThreshold, double eps) {
  final ret = using<List<Rect>>((arena) {
    final _rects = _bindings.GroupRectangles(rects.toNative(arena).ref, groupThreshold, eps);
    return Rects.toList(_rects);
  });
  return ret;
}

// QRCodeDetector groups the object candidate rectangles.
//
// For further details, please see:
// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html
class QRCodeDetector implements ffi.Finalizable {
  QRCodeDetector._(this._ptr) {
    finalizer.attach(this, _ptr);
  }

  factory QRCodeDetector.empty() {
    final _ptr = _bindings.QRCodeDetector_New();
    return QRCodeDetector._(_ptr);
  }

  /// DetectAndDecode Both detects and decodes QR code.
  ///
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a7290bd6a5d59b14a37979c3a14fbf394
  String detectAndDecode(
    InputArray img,
    OutputArray points, {
    OutputArray? straight_code = null,
  }) {
    straight_code ??= Mat.empty();
    final ret = _bindings.QRCodeDetector_DetectAndDecode(_ptr, img.ptr, points.ptr, straight_code.ptr);
    if (ret == ffi.nullptr) return "";
    return ret.cast<Utf8>().toDartString();
  }

  /// Detect detects QR code in image and returns the quadrangle containing the code.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a64373f7d877d27473f64fe04bb57d22b
  bool detect(InputArray input, OutputArray points) {
    final ret = _bindings.QRCodeDetector_Detect(_ptr, input.ptr, points.ptr);
    return ret;
  }

  /// Decode decodes QR code in image once it's found by the detect() method. Returns UTF8-encoded output string or empty string if the code cannot be decoded.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a4172c2eb4825c844fb1b0ae67202d329
  String decode(
    InputArray img,
    InputArray points, {
    OutputArray? straight_code = null,
  }) {
    straight_code ??= Mat.empty();
    final ret = _bindings.QRCodeDetector_Decode(_ptr, img.ptr, points.ptr, straight_code.ptr);
    if (ret == ffi.nullptr) return "";
    return ret.cast<Utf8>().toDartString();
  }

  /// Detects QR codes in image and finds of the quadrangles containing the codes.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true if QR code was detected
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#aaf2b6b2115b8e8fbc9acf3a8f68872b6
  detectMulti(InputArray img, OutputArray points) {
    return _bindings.QRCodeDetector_DetectMulti(_ptr, img.ptr, points.ptr);
  }

  /// Detects QR codes in image, finds the quadrangles containing the codes, and decodes the QRCodes to strings.
  ///
  /// Each quadrangle would be returned as a row in the `points` Mat and each point is a Vecf.
  /// Returns true as long as some QR code was detected even in case where the decoding failed
  /// For usage please see TestQRCodeDetector
  /// For further details, please see:
  /// https://docs.opencv.org/master/de/dc3/classcv_1_1QRCodeDetector.html#a188b63ffa17922b2c65d8a0ab7b70775
  // TODO: (bool, List<String>, Mat, List<Mat>) detectAndDecodeMulti(InputArray img) {}

  cvg.QRCodeDetector _ptr;
  cvg.QRCodeDetector get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.QRCodeDetector_Close);
}
