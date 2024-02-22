import 'dart:ffi' as ffi;
import 'dart:typed_data';
import 'dart:math' show pow;

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'rect.dart';
import 'scalar.dart';
import 'mat_type.dart';
import 'base.dart';
import '../opencv.g.dart' as cvg;

final _bindings = cvg.CvNative(loadNativeLibrary());

class Mat extends CvObject with EquatableMixin {
  Mat._(this._ptr) : super(_ptr) {
    _finalizer.attach(this, _ptr);
  }
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
    type = type ?? MatType.CV_8UC3;
    final scalar = Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
    final _ptr = _bindings.Mat_NewWithSizeFromScalar(scalar.ref, height, width, type.toInt32());

    return Mat._(_ptr);
  }

  factory Mat.eye(int rows, int cols, MatType type) {
    final _ptr = _bindings.Eye(rows, cols, type.toInt32());
    return Mat._(_ptr);
  }

  factory Mat.zeros(int rows, int cols, MatType type) {
    final _ptr = _bindings.Zeros(rows, cols, type.toInt32());
    return Mat._(_ptr);
  }

  factory Mat.ones(int rows, int cols, MatType type) {
    final _ptr = _bindings.Ones(rows, cols, type.toInt32());
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

  /// only for channels == 1
  int get countNoneZero {
    assert(channels == 1, "countNoneZero only for channels == 1");
    return _bindings.Mat_CountNonZero(_ptr);
  }

  static const int U8_MAX = 255; // uchar
  static const int U8_MIN = 0;
  static const int I8_MAX = 127; // schar
  static const int I8_MIN = -128;
  static const int U16_MAX = 65535; // ushort
  static const int U16_MIN = 0;
  static const int I16_MAX = 32767; // short
  static const int I16_MIN = -32768;
  static const int U32_MAX = 4294967295;
  static const int U32_MIN = 0;
  static const int I32_MAX = 2147483647; // int
  static const int I32_MIN = -2147483648;
  static const double F32_MAX = 3.4028234663852886e+38;
  static const double F64_MAX = 1.7976931348623157e+308;

  T at<T extends num>(int row, int col) {
    double? vDouble;
    switch (type.depth) {
      case MatType.CV_8U:
        vDouble = _bindings.Mat_GetUChar(_ptr, row, col).toDouble();
      case MatType.CV_8S:
        vDouble = _bindings.Mat_GetSChar(_ptr, row, col).toDouble();
      case MatType.CV_16U:
        vDouble = _bindings.Mat_GetUShort(_ptr, row, col).toDouble();
      case MatType.CV_16S:
        vDouble = _bindings.Mat_GetShort(_ptr, row, col).toDouble();
      case MatType.CV_32S:
        vDouble = _bindings.Mat_GetInt(_ptr, row, col).toDouble();
      case MatType.CV_32F:
        vDouble = _bindings.Mat_GetFloat(_ptr, row, col);
      case MatType.CV_64F:
        vDouble = _bindings.Mat_GetDouble(_ptr, row, col);
      default:
        throw UnsupportedError("at() for $type is not supported!");
    }
    if (T == int) {
      return vDouble.toInt() as T;
    } else {
      return vDouble as T;
    }
  }

  // TODO:  for now, dart do not support operator overloading
  // https://github.com/dart-lang/language/issues/2456
  // waiting for it's implementation and add more methods
  // operator +(int v) {
  //   _bindings.Mat_AddUChar(_ptr, v);
  // }

  /// add
  Mat add<T>(T val, {bool inplace = false}) {
    if (T == Mat) {
      return addMat(val as Mat, inplace: inplace);
    } else if (T == double) {
      switch (type.depth) {
        case MatType.CV_32F:
          return addF32(val as double, inplace: inplace);
        case MatType.CV_64F:
          return addF64(val as double, inplace: inplace);
        default:
          throw UnsupportedError("add float to $type is not supported!");
      }
    } else if (T == int) {
      switch (type.depth) {
        case MatType.CV_8U:
          return addU8(val as int, inplace: inplace);
        case MatType.CV_32S:
          return addI32(val as int, inplace: inplace);
        default:
          throw UnimplementedError();
      }
    } else {
      throw UnsupportedError("Type $T is not supported");
    }
  }

  Mat addMat(Mat other, {bool inplace = false}) {
    assert(other.type == type, "${this.type} != ${other.type}");
    if (inplace) {
      _bindings.Mat_Add(_ptr, other.ptr, _ptr);
      return this;
    } else {
      final dst = Mat.empty();
      _bindings.Mat_Add(_ptr, other.ptr, dst.ptr);
      return dst;
    }
  }

  Mat addU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= U8_MIN && val <= U8_MAX, "addU8() only for CV_8U");
    if (inplace) {
      _bindings.Mat_AddUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= I32_MIN && val <= I32_MAX, "addI32() only for CV_32S");
    if (inplace) {
      _bindings.Mat_AddI32(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddI32(dst.ptr, val);
      return dst;
    }
  }

  Mat addF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= F32_MAX, "addF32() only for CV_32F");
    if (inplace) {
      _bindings.Mat_AddFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat addF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= F64_MAX, "addF64() only for CV_64F");
    if (inplace) {
      _bindings.Mat_AddF64(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_AddF64(dst.ptr, val);
      return dst;
    }
  }

  /// subtract
  Mat subtract<T>(T val, {bool inplace = false}) {
    if (T == Mat) {
      return subtractMat(val as Mat, inplace: inplace);
    } else if (T == double) {
      switch (type.depth) {
        case MatType.CV_32F:
          return subtractF32(val as double, inplace: inplace);
        case MatType.CV_64F:
          return subtractF64(val as double, inplace: inplace);
        default:
          throw UnsupportedError("subtract float to $type is not supported!");
      }
    } else if (T == int) {
      switch (type.depth) {
        case MatType.CV_8U:
          return subtractU8(val as int, inplace: inplace);
        case MatType.CV_32S:
          return subtractI32(val as int, inplace: inplace);
        default:
          throw UnimplementedError();
      }
    } else {
      throw UnsupportedError("Type $T is not supported");
    }
  }

  Mat subtractMat(Mat other, {bool inplace = false}) {
    assert(other.type == type, "${this.type} != ${other.type}");
    if (inplace) {
      _bindings.Mat_Subtract(_ptr, other.ptr, _ptr);
      return this;
    } else {
      final dst = Mat.empty();
      _bindings.Mat_Subtract(_ptr, other.ptr, dst.ptr);
      return dst;
    }
  }

  Mat subtractU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= U8_MIN && val <= U8_MAX, "subtractU8() only for CV_8U");
    if (inplace) {
      _bindings.Mat_SubtractUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= I32_MIN && val <= I32_MAX, "subtractI32() only for CV_32S");
    if (inplace) {
      _bindings.Mat_SubtractI32(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractI32(dst.ptr, val);
      return dst;
    }
  }

  Mat subtractF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= F32_MAX, "subtractF32() only for CV_32F");
    if (inplace) {
      _bindings.Mat_SubtractFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat subtractF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= F64_MAX, "subtractF64() only for CV_64F");
    if (inplace) {
      _bindings.Mat_SubtractF64(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_SubtractF64(dst.ptr, val);
      return dst;
    }
  }

  /// multiply
  Mat multiply<T>(T val, {bool inplace = false}) {
    if (T == Mat) {
      return multiplyMat(val as Mat, inplace: inplace);
    } else if (T == double) {
      switch (type.depth) {
        case MatType.CV_32F:
          return multiplyF32(val as double, inplace: inplace);
        case MatType.CV_64F:
          return multiplyF64(val as double, inplace: inplace);
        default:
          throw UnsupportedError("multiply float to $type is not supported!");
      }
    } else if (T == int) {
      switch (type.depth) {
        case MatType.CV_8U:
          return multiplyU8(val as int, inplace: inplace);
        case MatType.CV_32S:
          return multiplyI32(val as int, inplace: inplace);
        default:
          throw UnimplementedError();
      }
    } else {
      throw UnsupportedError("Type $T is not supported");
    }
  }

  Mat multiplyMat(Mat other, {bool inplace = false}) {
    assert(other.type == type, "${this.type} != ${other.type}");
    if (inplace) {
      _bindings.Mat_Multiply(_ptr, other.ptr, _ptr);
      return this;
    } else {
      final dst = Mat.empty();
      _bindings.Mat_Multiply(_ptr, other.ptr, dst.ptr);
      return dst;
    }
  }

  Mat multiplyU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= U8_MIN && val <= U8_MAX, "multiplyU8() only for CV_8U");
    if (inplace) {
      _bindings.Mat_MultiplyUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= I32_MIN && val <= I32_MAX, "multiplyI32() only for CV_32S");
    if (inplace) {
      _bindings.Mat_MultiplyI32(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyI32(dst.ptr, val);
      return dst;
    }
  }

  Mat multiplyF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= F32_MAX, "multiplyF32() only for CV_32F");
    if (inplace) {
      _bindings.Mat_MultiplyFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat multiplyF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= F64_MAX, "multiplyF64() only for CV_64F");
    if (inplace) {
      _bindings.Mat_MultiplyF64(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_MultiplyF64(dst.ptr, val);
      return dst;
    }
  }

  /// divide
  Mat divide<T>(T val, {bool inplace = false}) {
    if (T == Mat) {
      return divideMat(val as Mat, inplace: inplace);
    } else if (T == double) {
      switch (type.depth) {
        case MatType.CV_32F:
          return divideF32(val as double, inplace: inplace);
        case MatType.CV_64F:
          return divideF64(val as double, inplace: inplace);
        default:
          throw UnsupportedError("divide float to $type is not supported!");
      }
    } else if (T == int) {
      switch (type.depth) {
        case MatType.CV_8U:
          return divideU8(val as int, inplace: inplace);
        case MatType.CV_32S:
          return divideI32(val as int, inplace: inplace);
        default:
          throw UnimplementedError();
      }
    } else {
      throw UnsupportedError("Type $T is not supported");
    }
  }

  Mat divideMat(Mat other, {bool inplace = false}) {
    assert(other.type == type, "${this.type} != ${other.type}");
    if (inplace) {
      _bindings.Mat_Divide(_ptr, other.ptr, _ptr);
      return this;
    } else {
      final dst = Mat.empty();
      _bindings.Mat_Divide(_ptr, other.ptr, dst.ptr);
      return dst;
    }
  }

  Mat divideU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= U8_MIN && val <= U8_MAX, "divideU8() only for CV_8U");
    if (inplace) {
      _bindings.Mat_DivideUChar(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideUChar(dst.ptr, val);
      return dst;
    }
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= I32_MIN && val <= I32_MAX, "divideI32() only for CV_32S");
    if (inplace) {
      _bindings.Mat_DivideI32(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideI32(dst.ptr, val);
      return dst;
    }
  }

  Mat divideF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= F32_MAX, "divideF32() only for CV_32F");
    if (inplace) {
      _bindings.Mat_DivideFloat(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideFloat(dst.ptr, val);
      return dst;
    }
  }

  Mat divideF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= F64_MAX, "divideF64() only for CV_64F");
    if (inplace) {
      _bindings.Mat_DivideF64(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideF64(dst.ptr, val);
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

  Mat convertTo(MatType type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    _bindings.Mat_ConvertToWithParams(_ptr, dst.ptr, type.toInt32(), alpha, beta);
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

  Mat setTo(Scalar s) {
    _bindings.Mat_SetTo(_ptr, s.ref);
    return this;
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

  @override
  List<Object?> get props => [_ptr.address];
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

// TODO
extension MatsExtension on ffi.Pointer<cvg.Mats> {}
