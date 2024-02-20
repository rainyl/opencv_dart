import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';
import 'package:opencv_dart/src/types/rect.dart';
import 'package:opencv_dart/src/types/scalar.dart';

import '../opencv.g.dart' as cvg;
import 'mat_type.dart';
import 'types.dart';

final _bindings = cvg.CvNative(loadNativeLibrary());

class Mat extends CvObject {
  Mat._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
  Mat(this._ptr) : super(_ptr);
  factory Mat.fromCMat(cvg.Mat mat) => Mat._(mat);
  factory Mat.empty() {
    final mat = _bindings.Mat_New();
    return Mat._(mat);
  }

  factory Mat.create({
    int width = 0,
    int height = 0,
    int r = 0,
    int g = 0,
    int b = 0,
    MatType? type,
  }) {
    late final cvg.Mat ptr;
    type = type ?? MatType.CV_8UC3;
    using((arena) {
      final scalar = arena<cvg.Scalar>()
        ..ref.val1 = b.toDouble()
        ..ref.val2 = g.toDouble()
        ..ref.val3 = r.toDouble();
      ptr = _bindings.Mat_NewWithSizeFromScalar(
          scalar.ref, height, width, type!.toInt32());
    });

    return Mat._(ptr);
  }

  factory Mat.eye(int rows, int cols, int type) {
    final _ptr = _bindings.Eye(rows, cols, type);
    return Mat._(_ptr);
  }

  factory Mat.zeros(int rows, int cols, int type) {
    final _ptr = _bindings.Zeros(rows, cols, type);
    return Mat._(_ptr);
  }

  factory Mat.ones(int rows, int cols, int type) {
    final _ptr = _bindings.Ones(rows, cols, type);
    return Mat._(_ptr);
  }

  factory Mat.fromPtr(
    cvg.Mat m,
    int rows,
    int cols,
    int type,
    int prows,
    int pcols,
  ) {
    final _ptr = _bindings.Mat_FromPtr(m, rows, cols, type, prows, pcols);
    return Mat._(_ptr);
  }

  static final _finalizer = ffi.NativeFinalizer(_bindings.addresses.Mat_Close);
  cvg.Mat _ptr;
  MatType get _type => MatType(_bindings.Mat_Type(_ptr));
  int get width => _bindings.Mat_Cols(_ptr);
  int get height => _bindings.Mat_Rows(_ptr);
  int get channels => _bindings.Mat_Channels(_ptr);
  int get total => _bindings.Mat_Total(_ptr);
  bool get isEmpty => _bindings.Mat_Empty(_ptr);
  bool get isContinus => _bindings.Mat_IsContinuous(_ptr);
  int get step => _bindings.Mat_Step(_ptr);
  int get elemSize => _bindings.Mat_ElemSize(_ptr);
  int get countNoneZero => _bindings.Mat_CountNonZero(_ptr);
  // TODO: add at() to retrive mat values

  static const int U8_MAX = 255; // uchar
  static const int U8_MIN = 0;
  static const int I8_MAX = 127; //schar
  static const int I8_MIN = -128;
  static const int U16_MAX = 65535;
  static const int U16_MIN = 0;

// TODO:  for now, dart do not support operator overloading
// https://github.com/dart-lang/language/issues/2456
// waiting for it's implementation and add more methods
  // operator +(int v) {
  //   _bindings.Mat_AddUChar(_ptr, v);
  // }
  Mat addMat(Mat other) {
    final dst = Mat.empty();
    _bindings.Mat_Add(_ptr, other.ptr, dst.ptr);
    return dst;
  }

  Mat addU8(int val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_AddUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat addDouble(double val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_AddFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat subtractMat(Mat other) {
    final dst = Mat.empty();
    _bindings.Mat_Subtract(_ptr, other.ptr, dst.ptr);
    return dst;
  }

  Mat subtractU8(int val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_SubtractUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat subtractDouble(double val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_SubtractFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat multiplyMat(Mat other) {
    final dst = Mat.empty();
    _bindings.Mat_Multiply(_ptr, other.ptr, dst.ptr);
    return dst;
  }

  Mat multiplyU8(int val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_MultiplyUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat multiplyDouble(double val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_MultiplyFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat divideMat(Mat other) {
    final dst = Mat.empty();
    _bindings.Mat_Divide(_ptr, other.ptr, dst.ptr);
    return dst;
  }

  Mat divideU8(int val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_DivideUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat divideDouble(double val, {bool inplace = false}) {
    if (inplace) {
      _bindings.Mat_DivideFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat transpose() => Mat._(_bindings.Mat_T(_ptr));

  Mat clone() => Mat._(_bindings.Mat_Clone(_ptr));

  void copyTo(Mat dst) {
    _bindings.Mat_CopyTo(_ptr, dst.ptr);
  }

  void copyToWithMask(Mat dst, Mat mask) {
    _bindings.Mat_CopyToWithMask(_ptr, dst.ptr, mask.ptr);
  }

  Mat convertTo(int type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    _bindings.Mat_ConvertToWithParams(_ptr, dst.ptr, type, alpha, beta);
    return dst;
  }

  Mat region(Rect rect) => Mat._(_bindings.Mat_Region(_ptr, rect.ref));

  Mat reshape(int cn, int rows) => Mat._(_bindings.Mat_Reshape(_ptr, cn, rows));
  Mat rotate(int rotationCode, {bool inplace = false}) {
    if (inplace) {
      _bindings.Rotate(_ptr, _ptr, rotationCode);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Rotate(_ptr, dst.ptr, rotationCode);
      return dst;
    }
  }

  Mat rowRange(int start, int end) {
    return Mat.fromCMat(_bindings.Mat_rowRange(_ptr, start, end));
  }

  Mat colRange(int start, int end) {
    return Mat.fromCMat(_bindings.Mat_colRange(_ptr, start, end));
  }

  Mat convertToFp16() => Mat._(_bindings.Mat_ConvertFp16(_ptr));
  Scalar mean({Mat? mask}) {
    final cvg.Scalar s;
    if (mask == null) {
      s = _bindings.Mat_Mean(_ptr);
    } else {
      s = _bindings.Mat_MeanWithMask(_ptr, mask.ptr);
    }
    return Scalar.fromNative(s);
  }

  /// Sqrt calculates a square root of array elements.
  Mat sqrt() => Mat._(_bindings.Mat_Sqrt(_ptr));

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() => Scalar.fromNative(_bindings.Mat_Sum(_ptr));

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => _bindings.Mat_PatchNaNs(_ptr, val);

  void setTo(Scalar s) {
    _bindings.Mat_SetTo(_ptr, s.ref);
  }

  @override
  cvg.Mat get ptr => _ptr;

  set ptr(cvg.Mat value) {
    _ptr = value;
  }

  Uint8List get data {
    final _data = _bindings.Mat_DataPtr(_ptr);
    return _data.data.cast<ffi.Uint8>().asTypedList(_data.length);
  }

  int get length => _bindings.Mat_DataPtr(_ptr).length;
  MatType get type => _type;

  // @override
  // Future<Null> onDispose() {
  //   _bindings.Mat_Close(_ptr);
  //   return super.onDispose();
  // }

  @override
  ffi.NativeType get ref => throw UnsupportedError("Mat has no Native type");
  @override
  ffi.NativeType toNative() => throw UnsupportedError("Mat has no Native type");
}

typedef OutputArray = Mat;
typedef InputArray = OutputArray;

typedef InputOutputArray = Mat;

extension ListMatExtension on List<Mat> {
  ffi.Pointer<cvg.Mats> toMats(Arena arena) {
    final matArray = arena<cvg.Mat>(this.length);
    for (var i = 0; i < this.length; i++) {
      matArray[i] = this[i].ptr;
    }
    final mats = arena<cvg.Mats>()
      ..ref.mats = matArray
      ..ref.length = this.length;
    return mats;
  }
}

extension MatsExtension on ffi.Pointer<cvg.Mats> {}
