import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'base.dart';
import 'rect.dart';
import 'scalar.dart';
import 'mat_type.dart';
import 'point.dart';
import 'vec.dart';
import 'array.dart';
import '../opencv.g.dart' as cvg;

class Mat extends CvStruct<cvg.Mat> {
  Mat._(cvg.MatPtr ptr, [this.vptr]) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr);
  }

  /// This method is very similar to [clone], will copy data from [mat]
  factory Mat.fromCMat(cvg.Mat mat) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_FromCMat(mat, p));
    final vec = Mat._(p);
    return vec;
  }

  /// Mat (Size size, int type, void *data, size_t step=AUTO_STEP)
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a9fa74fb14362d87cb183453d2441948f
  factory Mat.fromBytes(int rows, int cols, MatType type, Uint8List data, [int step = 0]) {
    final p = calloc<cvg.Mat>();
    // final NativeArray pdata;
    // switch (type.depth) {
    //   case MatType.CV_8U:
    //     pdata = U8Array.fromList(data);
    //   case MatType.CV_8S:
    //     pdata = I8Array.fromList(data);
    //   case MatType.CV_32S:
    //     pdata = I32Array.fromList(data);
    //   case MatType.CV_32F:
    //     pdata = F32Array.fromList(data.cast<double>());
    //   case MatType.CV_64F:
    //     pdata = F64Array.fromList(data.cast<double>());
    //   default:
    //     throw UnsupportedError("Mat.fromBytes for MatType $type unsupported");
    // }
    final vec = VecUChar.fromList(data);

    cvRun(() => CFFI.Mat_NewFromBytes(rows, cols, type.toInt32(), vec.ref, step, p));
    final mat = Mat._(p, vec);
    return mat;
  }

  /// This method is different from [Mat.fromPtr], will construct from pointer directly
  factory Mat.fromPointer(cvg.MatPtr mat) => Mat._(mat);

  factory Mat.empty() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_New(p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromScalar(Scalar s, MatType type, {int rows = 1, int cols = 1}) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_NewWithSizeFromScalar(s.ref, rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromVec(Vec vec) {
    final p = calloc<cvg.Mat>();
    if (vec is VecPoint) {
      cvRun(() => CFFI.Mat_NewFromVecPoint(vec.ref, p));
    } else if (vec is VecPoint2f) {
      cvRun(() => CFFI.Mat_NewFromVecPoint2f(vec.ref, p));
    } else if (vec is VecPoint3f) {
      cvRun(() => CFFI.Mat_NewFromVecPoint3f(vec.ref, p));
    } else {
      throw UnsupportedError("Unsupported Vec type ${vec.runtimeType}");
    }
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.create({int rows = 0, int cols = 0, int r = 0, int g = 0, int b = 0, MatType? type}) {
    type = type ?? MatType.CV_8UC3;
    final scalar = Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_NewWithSizeFromScalar(scalar.ref, rows, cols, type!.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.eye(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Eye(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.zeros(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Zeros(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.ones(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Ones(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.randn(int rows, int cols, MatType type, {Scalar? mean, Scalar? std}) {
    mean ??= Scalar.all(0);
    std ??= Scalar.all(1);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => CFFI.RandN(mat.ref, mean!.ref, std!.ref));
    return mat;
  }

  factory Mat.randu(int rows, int cols, MatType type, {Scalar? low, Scalar? high}) {
    low ??= Scalar.all(0);
    high ??= Scalar.all(256);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => CFFI.RandU(mat.ref, low!.ref, high!.ref));
    return mat;
  }

  /// this constructor is a wrapper of cv::Mat::ptr
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
    final mat = Mat._(p);
    return mat;
  }

  static final finalizer = Finalizer<cvg.MatPtr>((p) {
    CFFI.Mat_Close(p);
    calloc.free(p);
  });
  ffi.Pointer<ffi.NativeType>? pdata;
  Vec? vptr;
  MatType get type => cvRunArena<MatType>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Type(ref, p));
        return MatType(p.value);
      });
  int get width => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Cols(ref, p));
        return p.value;
      });
  int get height => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Rows(ref, p));
        return p.value;
      });
  int get cols => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Cols(ref, p));
        return p.value;
      });
  int get rows => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Rows(ref, p));
        return p.value;
      });
  int get channels => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Channels(ref, p));
        return p.value;
      });
  int get total => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Total(ref, p));
        return p.value;
      });
  bool get isEmpty => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => CFFI.Mat_Empty(ref, p));
        return p.value;
      });
  bool get isContinus => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => CFFI.Mat_IsContinuous(ref, p));
        return p.value;
      });
  int get step => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_Step(ref, p));
        return p.value;
      });
  int get elemSize => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => CFFI.Mat_ElemSize(ref, p));
        return p.value;
      });

  /// (rows, cols)
  List<int> get size => [rows, cols];

  // List<int> get shape {
  //   return cvRunArena<List<int>>((arena) {
  //     final s = arena<cvg.VecInt>();
  //     cvRun(() => CFFI.Mat_Size(ref, s));
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
      cvRun(() => CFFI.Mat_CountNonZero(ref, p));
      return p.value;
    });
  }

  T at<T extends num>(int row, int col, [int? cn]) {
    assert(cn == null || cn >= 0 && cn < channels, "cn must be null or between 0 and channels");
    Arena arena = Arena();
    num val;
    switch (type.depth) {
      case MatType.CV_8U:
        final p = arena<ffi.Uint8>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetUChar(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetUChar3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_8S:
        final p = arena<ffi.Int8>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetSChar(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetSChar3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_16U:
        final p = arena<ffi.Uint16>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetUShort(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetUShort3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_16S:
        final p = arena<ffi.Int16>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetShort(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetShort3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_32S:
        final p = arena<ffi.Int32>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetInt(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetInt3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_32F:
        final p = arena<ffi.Float>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetFloat(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetFloat3(ref, row, col, cn, p));
        }
        val = p.value;
      case MatType.CV_64F:
        final p = arena<ffi.Double>();
        if (type.channels == 1 || cn == null) {
          cvRun(() => CFFI.Mat_GetDouble(ref, row, col, p));
        } else {
          cvRun(() => CFFI.Mat_GetDouble3(ref, row, col, cn, p));
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
            ? cvRun(() => CFFI.Mat_SetUChar(ref, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetUChar3(ref, row, col, cn, val as int));
      case MatType.CV_8S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetSChar(ref, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetSChar3(ref, row, col, cn, val as int));
      case MatType.CV_16U:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetUShort(ref, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetUShort3(ref, row, col, cn, val as int));
      case MatType.CV_16S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetShort(ref, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetShort3(ref, row, col, cn, val as int));
      case MatType.CV_32S:
        assert(T == int, "$type only support int");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetInt(ref, row, col, val as int))
            : cvRun(() => CFFI.Mat_SetInt3(ref, row, col, cn, val as int));
      case MatType.CV_32F:
        assert(T == double, "$type only support double");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetFloat(ref, row, col, val as double))
            : cvRun(() => CFFI.Mat_SetFloat3(ref, row, col, cn, val as double));
      case MatType.CV_64F:
        assert(T == double, "$type only support double");
        type.channels == 1 || cn == null
            ? cvRun(() => CFFI.Mat_SetDouble(ref, row, col, val as double))
            : cvRun(() => CFFI.Mat_SetDouble3(ref, row, col, cn, val as double));
      default:
        throw UnsupportedError("setValue() for $type is not supported!");
    }
  }

  // TODO:  for now, dart do not support operator overloading
  // https://github.com/dart-lang/language/issues/2456
  // waiting for it's implementation and add more methods
  // operator +(int v) {
  //   CFFI.Mat_AddUChar(ref, v);
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
    assert(other.type == type, "$type != ${other.type}");
    if (inplace) {
      cvRun(() => CFFI.Mat_Add(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Add(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat addU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "addU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddUChar(dst.ref, val));
      return dst;
    }
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX, "addI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddI32(dst.ref, val));
      return dst;
    }
  }

  Mat addF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "addF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddFloat(dst.ref, val));
      return dst;
    }
  }

  Mat addF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "addF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_AddF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddF64(dst.ref, val));
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
    assert(other.type == type, "$type != ${other.type}");
    if (inplace) {
      cvRun(() => CFFI.Mat_Subtract(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Subtract(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat subtractU8(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "subtractU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractUChar(dst.ref, val));
      return dst;
    }
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "subtractI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractI32(dst.ref, val));
      return dst;
    }
  }

  Mat subtractF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "subtractF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractFloat(dst.ref, val));
      return dst;
    }
  }

  Mat subtractF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "subtractF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractF64(dst.ref, val));
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
    assert(other.type == type, "$type != ${other.type}");
    if (inplace) {
      cvRun(() => CFFI.Mat_Multiply(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Multiply(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat multiplyU8(int val, {bool inplace = false}) {
    assert(
        type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "multiplyU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplyUChar(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "multiplyI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplyI32(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "multiplyF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplyFloat(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "multiplyF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplyF64(dst.ref, val));
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
    assert(other.type == type, "$type != ${other.type}");
    if (inplace) {
      cvRun(() => CFFI.Mat_Divide(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => CFFI.Mat_Divide(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat divideU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX, "divideU8() only for CV_8U");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideUChar(dst.ref, val));
      return dst;
    }
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "divideI32() only for CV_32S");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideI32(dst.ref, val));
      return dst;
    }
  }

  Mat divideF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "divideF32() only for CV_32F");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideFloat(dst.ref, val));
      return dst;
    }
  }

  Mat divideF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "divideF64() only for CV_64F");
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideF64(dst.ref, val));
      return dst;
    }
  }

  Mat transpose({bool inplace = false}) {
    final dst = inplace ? this : Mat.empty();
    cvRun(() => CFFI.Mat_Transpose(ref, dst.ref));
    return dst;
  }

  Mat clone() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Clone(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  void copyTo(Mat dst) {
    cvRun(() => CFFI.Mat_CopyTo(ref, dst.ref));
  }

  void copyToWithMask(Mat dst, Mat mask) {
    cvRun(() => CFFI.Mat_CopyToWithMask(ref, dst.ref, mask.ref));
  }

  Mat convertTo(MatType type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    cvRun(() => CFFI.Mat_ConvertToWithParams(ref, dst.ref, type.toInt32(), alpha, beta));
    return dst;
  }

  Mat region(Rect rect) {
    assert(rect.x + rect.width <= width && rect.y + rect.height <= height, "rect is out of range");
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Region(ref, rect.ref, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat reshape(int cn, int rows) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Reshape(ref, cn, rows, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat rotate(int rotationCode, {bool inplace = false}) {
    if (inplace) {
      cvRun(() => CFFI.Rotate(ref, ref, rotationCode));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Rotate(ref, dst.ref, rotationCode));
      return dst;
    }
  }

  Mat rowRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_rowRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat colRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_colRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat convertToFp16() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_ConvertFp16(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  Scalar mean({Mat? mask}) {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      if (mask == null) {
        cvRun(() => CFFI.Mat_Mean(ref, s));
      } else {
        cvRun(() => CFFI.Mat_MeanWithMask(ref, mask.ref, s));
      }
      return Scalar.fromNative(s.ref);
    });
  }

  /// Calculates a square root of array elements.
  Mat sqrt() {
    assert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F, "sqrt() only for CV_32F or CV_64F");
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Sqrt(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      cvRun(() => CFFI.Mat_Sum(ref, s));
      return Scalar.fromNative(s.ref);
    });
  }

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => cvRun(() => CFFI.Mat_PatchNaNs(ref, val));

  Mat setTo(Scalar s) {
    cvRun(() => CFFI.Mat_SetTo(ref, s.ref));
    return this;
  }

  List<List<T>> toList<T extends num>([int cn = 0]) {
    return List.generate(
      rows,
      (row) => List.generate(
        cols,
        (col) => at<T>(row, col, cn),
      ),
    );
  }

  List<List<List<T>>> toList3D<T extends num>() {
    assert(channels == 3, "toList3D() only for 3 channels, but this.channels=$channels");
    return List.generate(3, (cn) => toList(cn));
  }

  List<List<List<List<T>>>> toList4D<T extends num>() {
    assert(channels == 4, "toList4D() only for 4 channels, but this.channels=$channels");
    return List.generate(4, (cn) => toList(cn));
  }

  Uint8List get data {
    return cvRunArena<Uint8List>((arena) {
      final p = arena<cvg.VecUChar>();
      cvRun(() => CFFI.Mat_Data(ref, p));
      return VecUChar.fromVec(p.ref).toU8List(); // TODO: copy 3 times, find a more efficient way
    });
  }

  @override
  String toString() {
    return "Mat(address=${ptr.address}, type=$type rows=$rows, cols=$cols, channels=$channels)";
  }

  @override
  List<int> get props => [ptr.address];
  @override
  cvg.Mat get ref => ptr.ref;
}

typedef OutputArray = Mat;
typedef InputArray = OutputArray;
typedef InputOutputArray = Mat;

class VecMat extends Vec<Mat> implements CvStruct<cvg.VecMat> {
  VecMat._(this.ptr) {
    finalizer.attach(this, ptr);
  }
  factory VecMat.fromPointer(cvg.VecMatPtr ptr) => VecMat._(ptr);
  factory VecMat.fromVec(cvg.VecMat ptr) {
    final p = calloc<cvg.VecMat>();
    cvRun(() => CFFI.VecMat_NewFromVec(ptr, p));
    final vec = VecMat._(p);
    return vec;
  }
  factory VecMat.fromList(List<Mat> pts) {
    final ptr = calloc<cvg.VecMat>();
    cvRun(() => CFFI.VecMat_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => CFFI.VecMat_Append(ptr.ref, pts[i].ref));
    }
    final vec = VecMat._(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => CFFI.VecMat_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  @override
  cvg.VecMatPtr ptr;
  static final finalizer = Finalizer<cvg.VecMatPtr>((p) {
    CFFI.VecMat_Close(p);
    calloc.free(p);
  });
  @override
  Iterator<Mat> get iterator => VecMatIterator(ref);

  @override
  cvg.VecMat get ref => ptr.ref;
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
    final mat = Mat._(p);
    return mat;
  }
}

extension ListMatExtension on List<Mat> {
  VecMat get cvd => VecMat.fromList(this);
}
