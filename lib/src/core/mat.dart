import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:ffi/ffi.dart';

import 'error_code.dart';
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

  factory Mat.fromScalar(Scalar s, MatType type, {int rows=1, int cols=1}) {
    final _ptr = _bindings.Mat_NewWithSizeFromScalar(s.ref, rows, cols, type.toInt32());
    return Mat._(_ptr);
  }

  factory Mat.create({
    int cols = 0,
    int rows = 0,
    int r = 0,
    int g = 0,
    int b = 0,
    MatType? type,
  }) {
    type = type ?? MatType.CV_8UC3;
    final scalar = Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
    final _ptr = _bindings.Mat_NewWithSizeFromScalar(scalar.ref, rows, cols, type.toInt32());

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

  factory Mat.randn(int rows, int cols, MatType type, {Scalar? mean, Scalar? std}) {
    mean ??= Scalar.all(0);
    std ??= Scalar.all(1);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    _bindings.RandN(mat.ptr, mean.ref, std.ref);
    return mat;
  }

  factory Mat.randu(int rows, int cols, MatType type, {Scalar? low, Scalar? high}) {
    low ??= Scalar.all(0);
    high ??= Scalar.all(256);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    _bindings.RandU(mat.ptr, low.ref, high.ref);
    return mat;
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
  int get cols => _bindings.Mat_Cols(_ptr);
  int get rows => _bindings.Mat_Rows(_ptr);
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

  T at<T extends num>(int row, int col, {int cn = 0}) {
    double? vDouble;
    switch (type.depth) {
      case MatType.CV_8U:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetUChar(_ptr, row, col).toDouble()
            : _bindings.Mat_GetUChar3(_ptr, row, col, cn).toDouble();
      case MatType.CV_8S:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetSChar(_ptr, row, col).toDouble()
            : _bindings.Mat_GetSChar3(_ptr, row, col, cn).toDouble();
      case MatType.CV_16U:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetUShort(_ptr, row, col).toDouble()
            : _bindings.Mat_GetUShort3(_ptr, row, col, cn).toDouble();
      case MatType.CV_16S:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetShort(_ptr, row, col).toDouble()
            : _bindings.Mat_GetShort3(_ptr, row, col, cn).toDouble();
      case MatType.CV_32S:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetInt(_ptr, row, col).toDouble()
            : _bindings.Mat_GetInt3(_ptr, row, col, cn).toDouble();
      case MatType.CV_32F:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetFloat(_ptr, row, col).toDouble()
            : _bindings.Mat_GetFloat3(_ptr, row, col, cn).toDouble();
      case MatType.CV_64F:
        vDouble = type.channels == 1
            ? _bindings.Mat_GetDouble(_ptr, row, col).toDouble()
            : _bindings.Mat_GetDouble3(_ptr, row, col, cn).toDouble();
      default:
        throw UnsupportedError("at() for $type is not supported!");
    }
    if (T == int) {
      return vDouble.toInt() as T;
    } else {
      return vDouble as T;
    }
  }

  setValue<T extends num>(int row, int col, T val, {int cn = 0}) {
    switch (type.depth) {
      case MatType.CV_8U:
      assert(T==int, "$type only support int");
        type.channels == 1
            ? _bindings.Mat_SetUChar(_ptr, row, col, val as int)
            : _bindings.Mat_SetUChar3(_ptr, row, col, cn, val as int);
      case MatType.CV_8S:
      assert(T==int, "$type only support int");
        type.channels == 1
            ? _bindings.Mat_SetSChar(_ptr, row, col, val as int)
            : _bindings.Mat_SetSChar3(_ptr, row, col, cn, val as int);
      case MatType.CV_16U:
      assert(T==int, "$type only support int");
        type.channels == 1
            ? _bindings.Mat_SetUShort(_ptr, row, col, val as int)
            : _bindings.Mat_SetUShort3(_ptr, row, col, cn, val as int);
      case MatType.CV_16S:
      assert(T==int, "$type only support int");
        type.channels == 1
            ? _bindings.Mat_SetShort(_ptr, row, col, val as int)
            : _bindings.Mat_SetShort3(_ptr, row, col, cn, val as int);
      case MatType.CV_32S:
      assert(T==int, "$type only support int");
        type.channels == 1
            ? _bindings.Mat_SetInt(_ptr, row, col, val as int)
            : _bindings.Mat_SetInt3(_ptr, row, col, cn, val as int);
      case MatType.CV_32F:
      assert(T==double, "$type only support double");
        type.channels == 1
            ? _bindings.Mat_SetFloat(_ptr, row, col, val as double)
            : _bindings.Mat_SetFloat3(_ptr, row, col, cn, val as double);
      case MatType.CV_64F:
      assert(T==double, "$type only support double");
        type.channels == 1
            ? _bindings.Mat_SetDouble(_ptr, row, col, val as double)
            : _bindings.Mat_SetDouble3(_ptr, row, col, cn, val as double);
      default:
        throw UnsupportedError("setValue() for $type is not supported!");
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "addU8() only for CV_8U");
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
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "addI32() only for CV_32S");
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "addF32() only for CV_32F");
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "addF64() only for CV_64F");
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "subtractU8() only for CV_8U");
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
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "subtractI32() only for CV_32S");
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "subtractF32() only for CV_32F");
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "subtractF64() only for CV_64F");
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "multiplyU8() only for CV_8U");
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
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "multiplyI32() only for CV_32S");
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "multiplyF32() only for CV_32F");
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "multiplyF64() only for CV_64F");
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "divideU8() only for CV_8U");
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
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "divideI32() only for CV_32S");
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "divideF32() only for CV_32F");
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "divideF64() only for CV_64F");
    if (inplace) {
      _bindings.Mat_DivideF64(_ptr, val);
      return this;
    } else {
      final dst = this.clone();
      _bindings.Mat_DivideF64(dst.ptr, val);
      return dst;
    }
  }

  Mat transpose({bool inplace = false}) {
    final dst = inplace ? this : Mat.empty();
    final code = _bindings.Mat_Transpose(_ptr, dst.ptr);
    if (code == ErrorCode.StsOk.code) return dst;
    throw Exception("transpose() failed with code $code");
  }

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

  Mat region(Rect rect) {
    assert(rect.x + rect.width <= width && rect.y + rect.height <= height, "rect is out of range");
    return Mat._(_bindings.Mat_Region(_ptr, rect.ref));
  }

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

  /// Calculates a square root of array elements.
  Mat sqrt() {
    assert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F, "sqrt() only for CV_32F or CV_64F");
    return Mat._(_bindings.Mat_Sqrt(_ptr));
  }

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

extension MatsExtension on ffi.Pointer<cvg.Mats> {
  List<Mat> toList() {
    final ret = <Mat>[];
    for (var i = 0; i < this.ref.length; i++) {
      ret.add(Mat.fromCMat(this.ref.mats[i]));
    }
    return ret;
  }
}
