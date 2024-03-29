import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'rect.dart';
import 'scalar.dart';
import 'mat_type.dart';
import 'point.dart';
import 'vec.dart';
import '../opencv.g.dart' as cvg;

class Mat extends CvPtrVoid<cvg.Mat> {
  Mat._(cvg.Mat ptr) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }
  factory Mat.fromCMat(cvg.Mat mat) => Mat._(mat);

  factory Mat.empty() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_New(p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.fromScalar(Scalar s, MatType type, {int rows = 1, int cols = 1}) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_NewWithSizeFromScalar(s.ref, rows, cols, type.toInt32(), p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.fromVec(Vec vec) {
    final p = calloc<cvg.Mat>();
    if (vec is VecPoint) {
      cvRun(() => CFFI.Mat_NewFromVecPoint(vec.ptr, p));
    } else if (vec is VecPoint2f) {
      cvRun(() => CFFI.Mat_NewFromVecPoint2f(vec.ptr, p));
    } else if (vec is VecPoint3f) {
      cvRun(() => CFFI.Mat_NewFromVecPoint3f(vec.ptr, p));
    } else {
      throw UnsupportedError("Unsupported Vec type ${vec.runtimeType}");
    }
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
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
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_NewWithSizeFromScalar(scalar.ref, rows, cols, type!.toInt32(), p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.eye(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Eye(rows, cols, type.toInt32(), p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.zeros(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Zeros(rows, cols, type.toInt32(), p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.ones(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Ones(rows, cols, type.toInt32(), p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  factory Mat.randn(int rows, int cols, MatType type, {Scalar? mean, Scalar? std}) {
    mean ??= Scalar.all(0);
    std ??= Scalar.all(1);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => CFFI.RandN(mat.ptr, mean!.ref, std!.ref));
    return mat;
  }

  factory Mat.randu(int rows, int cols, MatType type, {Scalar? low, Scalar? high}) {
    low ??= Scalar.all(0);
    high ??= Scalar.all(256);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun<Mat>(() => CFFI.RandU(mat.ptr, low!.ref, high!.ref), mat);
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
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_FromPtr(m, rows, cols, type, prows, pcols, p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }

  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.Mat_Close);
  MatType get _type => cvRunArena<MatType>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Type(ptr, p));
        return MatType(p.value);
      });
  int get width => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Cols(ptr, p));
        return p.value;
      });
  int get height => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Rows(ptr, p));
        return p.value;
      });
  int get cols => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Cols(ptr, p));
        return p.value;
      });
  int get rows => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Rows(ptr, p));
        return p.value;
      });
  int get channels => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Channels(ptr, p));
        return p.value;
      });
  int get total => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Total(ptr, p));
        return p.value;
      });
  bool get isEmpty => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => CFFI.Mat_Empty(ptr, p));
        return p.value;
      });
  bool get isContinus => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => CFFI.Mat_IsContinuous(ptr, p));
        return p.value;
      });
  int get step => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Step(ptr, p));
        return p.value;
      });
  int get elemSize => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_ElemSize(ptr, p));
        return p.value;
      });

  /// (rows, cols)
  List<int> get size => [rows, cols];

  // List<int> get shape {
  //   return cvRunArena<List<int>>((arena) {
  //     final s = arena<cvg.VecInt>();
  //     cvRun(() => CFFI.Mat_Size(ptr, s));
  //     final vec = VecInt.fromPointer(s.value);
  //     return vec.toList();
  //   });
  // }

  /// (rows, cols, channels)
  List<int> get shape => [rows, cols, channels];

  /// only for channels == 1
  int get countNoneZero {
    assert(channels == 1, "countNoneZero only for channels == 1");

    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.Mat_CountNonZero(ptr, p));
      return p.value;
    });
  }

  T at<T extends num>(int row, int col, {int? cn}) {
    Arena arena = Arena();
    num val;
    switch (type.depth) {
      case MatType.CV_8U:
        final p = arena<ffi.Uint8>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetUChar(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetUChar3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_8S:
        final p = arena<ffi.Int8>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetSChar(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetSChar3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_16U:
        final p = arena<ffi.Uint16>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetUShort(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetUShort3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_16S:
        final p = arena<ffi.Int16>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetShort(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetShort3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_32S:
        final p = arena<ffi.Int32>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetInt(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetInt3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_32F:
        final p = arena<ffi.Float>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetFloat(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetFloat3(ptr, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_64F:
        final p = arena<ffi.Double>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetDouble(ptr, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetDouble3(ptr, row, col, cn, p));
        }
        val = p.value;
      default:
        throw UnsupportedError("at() for $type is not supported!");
    }
    arena.releaseAll();
    return val as T;
  }

  setValue<T extends num>(int row, int col, T val, {int? cn}) {
    switch (type.depth) {
      case MatType.CV_8U:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetUChar(ptr, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetUChar3(ptr, row, col, cn, val as int));
      case MatType.CV_8S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetSChar(ptr, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetSChar3(ptr, row, col, cn, val as int));
      case MatType.CV_16U:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetUShort(ptr, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetUShort3(ptr, row, col, cn, val as int));
      case MatType.CV_16S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetShort(ptr, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetShort3(ptr, row, col, cn, val as int));
      case MatType.CV_32S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetInt(ptr, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetInt3(ptr, row, col, cn, val as int));
      case MatType.CV_32F:
        assert(T == double, "$type only support double");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetFloat(ptr, row, col, val as double))
            : cvRun(() => CFFI.Mat_SetFloat3(ptr, row, col, cn, val as double));
      case MatType.CV_64F:
        assert(T == double, "$type only support double");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetDouble(ptr, row, col, val as double))
            : cvRun(() => CFFI.Mat_SetDouble3(ptr, row, col, cn, val as double));
      default:
        throw UnsupportedError("setValue() for $type is not supported!");
    }
  }

  // TODO:  for now, dart do not support operator overloading
  // https://github.com/dart-lang/language/issues/2456
  // waiting for it's implementation and add more methods
  // operator +(int v) {
  //   CFFI.Mat_AddUChar(_ptr, v);
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
      cvRun(() => CFFI.Mat_Add(ptr, other.ptr, ptr));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Add(ptr, other.ptr, dst.ptr));
      return dst;
    }
  }

  Mat addU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "addU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddUChar(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_AddUChar(dst.ptr, val));
      return dst;
    }
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "addI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddI32(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_AddI32(dst.ptr, val));
      return dst;
    }
  }

  Mat addF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "addF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddFloat(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_AddFloat(dst.ptr, val));
      return dst;
    }
  }

  Mat addF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "addF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddF64(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_AddF64(dst.ptr, val));
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
      cvRun(() => CFFI.Mat_Subtract(ptr, other.ptr, ptr));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Subtract(ptr, other.ptr, dst.ptr));
      return dst;
    }
  }

  Mat subtractU8(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "subtractU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractUChar(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_SubtractUChar(dst.ptr, val));
      return dst;
    }
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "subtractI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractI32(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_SubtractI32(dst.ptr, val));
      return dst;
    }
  }

  Mat subtractF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "subtractF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractFloat(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_SubtractFloat(dst.ptr, val));
      return dst;
    }
  }

  Mat subtractF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "subtractF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractF64(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_SubtractF64(dst.ptr, val));
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
      cvRun(() => CFFI.Mat_Multiply(ptr, other.ptr, ptr));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Multiply(ptr, other.ptr, dst.ptr));
      return dst;
    }
  }

  Mat multiplyU8(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "multiplyU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyUChar(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_MultiplyUChar(dst.ptr, val));
      return dst;
    }
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "multiplyI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyI32(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_MultiplyI32(dst.ptr, val));
      return dst;
    }
  }

  Mat multiplyF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "multiplyF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyFloat(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_MultiplyFloat(dst.ptr, val));
      return dst;
    }
  }

  Mat multiplyF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "multiplyF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyF64(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_MultiplyF64(dst.ptr, val));
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
      cvRun(() => CFFI.Mat_Divide(ptr, other.ptr, ptr));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Divide(ptr, other.ptr, dst.ptr));
      return dst;
    }
  }

  Mat divideU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "divideU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideUChar(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_DivideUChar(dst.ptr, val));
      return dst;
    }
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "divideI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideI32(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_DivideI32(dst.ptr, val));
      return dst;
    }
  }

  Mat divideF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "divideF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideFloat(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_DivideFloat(dst.ptr, val));
      return dst;
    }
  }

  Mat divideF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "divideF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideF64(ptr, val));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Mat_DivideF64(dst.ptr, val));
      return dst;
    }
  }

  Mat transpose({bool inplace = false}) {
    final dst = inplace ? this : Mat.empty();
    cvRun(() => CFFI.Mat_Transpose(ptr, dst.ptr));
    return dst;
  }

  Mat clone() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Clone(ptr, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  void copyTo(Mat dst) {
    cvRun(() => CFFI.Mat_CopyTo(ptr, dst.ptr));
  }

  void copyToWithMask(Mat dst, Mat mask) {
    cvRun(() => CFFI.Mat_CopyToWithMask(ptr, dst.ptr, mask.ptr));
  }

  Mat convertTo(MatType type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    cvRun(() => CFFI.Mat_ConvertToWithParams(ptr, dst.ptr, type.toInt32(), alpha, beta));
    return dst;
  }

  Mat region(Rect rect) {
    assert(rect.x + rect.width <= width && rect.y + rect.height <= height, "rect is out of range");
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Region(ptr, rect.ref, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  Mat reshape(int cn, int rows) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Reshape(ptr, cn, rows, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  Mat rotate(int rotationCode, {bool inplace = false}) {
    if (inplace) {
      cvRun(() => CFFI.Rotate(ptr, ptr, rotationCode));
      return this;
    } else {
      final dst = this.clone();
      cvRun(() => CFFI.Rotate(ptr, dst.ptr, rotationCode));
      return dst;
    }
  }

  Mat rowRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_rowRange(ptr, start, end, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  Mat colRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_colRange(ptr, start, end, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  Mat convertToFp16() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_ConvertFp16(ptr, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  Scalar mean({Mat? mask}) {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      if (mask == null) {
        cvRun(() => CFFI.Mat_Mean(ptr, s));
      } else {
        cvRun(() => CFFI.Mat_MeanWithMask(ptr, mask.ptr, s));
      }
      return Scalar.fromNative(s.ref);
    });
  }

  /// Calculates a square root of array elements.
  Mat sqrt() {
    assert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F, "sqrt() only for CV_32F or CV_64F");
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Sqrt(ptr, p));
    final dst = Mat._(p.value);
    calloc.free(p);
    return dst;
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      cvRun(() => CFFI.Mat_Sum(ptr, s));
      return Scalar.fromNative(s.ref);
    });
  }

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => cvRun(() => CFFI.Mat_PatchNaNs(ptr, val));

  Mat setTo(Scalar s) {
    cvRun(() => CFFI.Mat_SetTo(ptr, s.ref));
    return this;
  }

  List<List<T>> toList<T extends num>({int cn = 0}) {
    return List.generate(
      this.rows,
      (row) => List.generate(
        this.cols,
        (col) => this.at<T>(row, col, cn: cn),
      ),
    );
  }

  List<List<List<T>>> toList3D<T extends num>() {
    assert(this.channels == 3, "toList3D() only for 3 channels, but this.channels=${this.channels}");
    return List.generate(3, (cn) => toList(cn: cn));
  }

  List<List<List<List<T>>>> toList4D<T extends num>() {
    assert(this.channels == 4, "toList4D() only for 4 channels, but this.channels=${this.channels}");
    return List.generate(4, (cn) => toList(cn: cn));
  }

  Uint8List get data {
    return cvRunArena<Uint8List>((arena) {
      final p = VecChar.fromList([]);
      cvRun(() => CFFI.Mat_ToVecChar(ptr, p.ptr));
      final vec = Uint8List.fromList(p.toList());
      return vec;
    });
  }

  MatType get type => _type;

  @override
  String toString() {
    return "Mat(address=${ptr.address}, type=$type rows=$rows, cols=$cols, channels=$channels)";
  }

  @override
  List<int> get props => [ptr.address];
}

typedef OutputArray = Mat;
typedef InputArray = OutputArray;
typedef InputOutputArray = Mat;

class VecMat extends Vec<Mat> {
  VecMat._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecMat.fromPointer(cvg.VecMat ptr) => VecMat._(ptr);
  factory VecMat.fromList(List<Mat> pts) {
    final ptr = calloc<cvg.VecMat>();
    cvRun(() => CFFI.VecMat_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecMat_Append(ptr.value, pts[i].ptr));
    }
    final vec = VecMat._(ptr.value);
    calloc.free(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecMat_Size(ptr, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  cvg.VecMat ptr;
  static final finalizer = ffi.NativeFinalizer(CFFI.addresses.VecMat_Close);
  @override
  Iterator<Mat> get iterator => VecMatIterator(ptr);
}

class VecMatIterator extends VecIterator<Mat> {
  VecMatIterator(this.ptr);
  cvg.VecMat ptr;

  @override
  int get length => using<int>(
        (arena) {
          final p = arena<ffi.Int>();
          cvRun(() => CFFI.VecMat_Size(ptr, p));
          final len = p.value;
          return len;
        },
      );

  @override
  Mat operator [](int idx) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.VecMat_At(ptr, idx, p));
    final mat = Mat._(p.value);
    calloc.free(p);
    return mat;
  }
}

extension ListMatExtension on List<Mat> {
  VecMat get ocv => VecMat.fromList(this);
}
