import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;
import 'array.dart';
import 'base.dart';
import 'cv_vec.dart';
import 'mat_type.dart';
import 'point.dart';
import 'rect.dart';
import 'scalar.dart';
import 'vec.dart';

class Mat extends CvStruct<cvg.Mat> {
  Mat._(cvg.MatPtr ptr, [this.xdata, bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
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
  factory Mat.fromList(int rows, int cols, MatType type, List<num> data, [int step = 0]) {
    assert(data is List<int> || data is List<double>, "Only support List<int> or List<double>");
    final p = calloc<cvg.Mat>();
    // 1 copy
    final NativeArray xdata;
    switch (type.depth) {
      case MatType.CV_8U:
        xdata = U8Array.fromList(data.cast());
      case MatType.CV_8S:
        xdata = I8Array.fromList(data.cast());
      case MatType.CV_16U:
        xdata = U16Array.fromList(data.cast());
      case MatType.CV_16S:
        xdata = I16Array.fromList(data.cast());
      case MatType.CV_32S:
        xdata = I32Array.fromList(data.cast());
      case MatType.CV_32F:
        xdata = F32Array.fromList(data.cast<double>());
      case MatType.CV_64F:
        xdata = F64Array.fromList(data.cast<double>());
      default:
        throw UnsupportedError("Mat.fromBytes for MatType $type unsupported");
    }
    // no copy, data is owned by [xdata]
    cvRun(() => CFFI.Mat_NewFromBytes(rows, cols, type.toInt32(), xdata.asVoid(), step, p));
    final mat = Mat._(p, xdata);
    return mat;
  }

  /// This method is different from [Mat.fromPtr], will construct from pointer directly
  factory Mat.fromPointer(cvg.MatPtr mat, [bool attach = true]) => Mat._(mat, null, attach);

  factory Mat.empty() {
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_New(p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromScalar(int rows, int cols, MatType type, Scalar s) {
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

  static final finalizer = OcvFinalizer<cvg.MatPtr>(CFFI.addresses.Mat_Close);

  void release() => cvRun(() => CFFI.Mat_Release(ptr));
  void dispose() {
    finalizer.detach(this);
    CFFI.Mat_Close(ptr);
  }

  /// external native data array of [Mat], used for [Mat.fromList]
  NativeArray? xdata;

  /// cached mat type
  MatType? _type;

  /// here the mat type can't be changed once created, method such as [convertTo] will create a new [Mat]
  MatType get type {
    if (_type == null) {
      final p = calloc<ffi.Int>();
      cvRun(() => CFFI.Mat_Type(ref, p));
      _type = MatType(p.value);
    }
    return _type!;
  }

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

  /// ([rows], [cols])
  List<int> get size => [rows, cols];

  // List<int> get shape {
  //   return cvRunArena<List<int>>((arena) {
  //     final s = arena<cvg.VecInt>();
  //     cvRun(() => CFFI.Mat_Size(ref, s));
  //     final vec = VecInt.fromPointer(s.value);
  //     return vec.toList();
  //   });
  // }

  /// ([rows], [cols], [channels])
  List<int> get shape => [rows, cols, channels];

  /// only for [channels] == 1
  int get countNoneZero {
    assert(channels == 1, "countNoneZero only for channels == 1");

    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => CFFI.Mat_CountNonZero(ref, p));
      return p.value;
    });
  }

  int atU8(int row, int col, [int? i2]) => using<int>((arena) {
        final p = arena<ffi.Uint8>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetUChar(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetUChar3(ref, row, col, i2, p));
        return p.value;
      });

  int atI8(int row, int col, [int? i2]) => using<int>((arena) {
        final p = arena<ffi.Int8>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetSChar(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetSChar3(ref, row, col, i2, p));
        return p.value;
      });

  int atU16(int row, int col, [int? i2]) => using<int>((arena) {
        final p = arena<ffi.Uint16>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetUShort(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetUShort3(ref, row, col, i2, p));
        return p.value;
      });

  int atI16(int row, int col, [int? i2]) => using<int>((arena) {
        final p = arena<ffi.Int16>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetShort(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetShort3(ref, row, col, i2, p));
        return p.value;
      });

  int atI32(int row, int col, [int? i2]) => using<int>((arena) {
        final p = arena<ffi.Int32>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetInt(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetInt3(ref, row, col, i2, p));
        return p.value;
      });

  double atF32(int row, int col, [int? i2]) => using<double>((arena) {
        final p = arena<ffi.Float>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetFloat(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetFloat3(ref, row, col, i2, p));
        return p.value;
      });

  double atF64(int row, int col, [int? i2]) => using<double>((arena) {
        final p = arena<ffi.Double>();
        i2 == null
            ? cvRun(() => CFFI.Mat_GetDouble(ref, row, col, p))
            : cvRun(() => CFFI.Mat_GetDouble3(ref, row, col, i2, p));
        return p.value;
      });

  num atNum<T extends num>(int row, int col, [int? i2]) {
    return switch (type.depth) {
      MatType.CV_8U => atU8(row, col, i2),
      MatType.CV_8S => atI8(row, col, i2),
      MatType.CV_16U => atU16(row, col, i2),
      MatType.CV_16S => atI16(row, col, i2),
      MatType.CV_32S => atI32(row, col, i2),
      MatType.CV_32F => atF32(row, col, i2),
      MatType.CV_64F => atF64(row, col, i2),
      _ => throw UnsupportedError("Unsupported type: $type")
    };
  }

  T atVec<T>(int row, int col) {
    // Vec2b, Vec3b, Vec4b
    if (T == Vec2b) {
      final p = calloc<cvg.Vec2b>();
      cvRun(() => CFFI.Mat_GetVec2b(ref, row, col, p));
      return Vec2b.fromPointer(p) as T;
    } else if (T == Vec3b) {
      final p = calloc<cvg.Vec3b>();
      cvRun(() => CFFI.Mat_GetVec3b(ref, row, col, p));
      return Vec3b.fromPointer(p) as T;
    } else if (T == Vec4b) {
      final p = calloc<cvg.Vec4b>();
      cvRun(() => CFFI.Mat_GetVec4b(ref, row, col, p));
      return Vec4b.fromPointer(p) as T;
    }
    // Vec2w, Vec3w, Vec4w
    else if (T == Vec2w) {
      final p = calloc<cvg.Vec2w>();
      cvRun(() => CFFI.Mat_GetVec2w(ref, row, col, p));
      return Vec2w.fromPointer(p) as T;
    } else if (T == Vec3w) {
      final p = calloc<cvg.Vec3w>();
      cvRun(() => CFFI.Mat_GetVec3w(ref, row, col, p));
      return Vec3w.fromPointer(p) as T;
    } else if (T == Vec4w) {
      final p = calloc<cvg.Vec4w>();
      cvRun(() => CFFI.Mat_GetVec4w(ref, row, col, p));
      return Vec4w.fromPointer(p) as T;
    }
    // Vec2s, Vec3s, Vec4s
    else if (T == Vec2s) {
      final p = calloc<cvg.Vec2s>();
      cvRun(() => CFFI.Mat_GetVec2s(ref, row, col, p));
      return Vec2s.fromPointer(p) as T;
    } else if (T == Vec3s) {
      final p = calloc<cvg.Vec3s>();
      cvRun(() => CFFI.Mat_GetVec3s(ref, row, col, p));
      return Vec3s.fromPointer(p) as T;
    } else if (T == Vec4s) {
      final p = calloc<cvg.Vec4s>();
      cvRun(() => CFFI.Mat_GetVec4s(ref, row, col, p));
      return Vec4s.fromPointer(p) as T;
    }
    // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
    else if (T == Vec2i) {
      final p = calloc<cvg.Vec2i>();
      cvRun(() => CFFI.Mat_GetVec2i(ref, row, col, p));
      return Vec2i.fromPointer(p) as T;
    } else if (T == Vec3i) {
      final p = calloc<cvg.Vec3i>();
      cvRun(() => CFFI.Mat_GetVec3i(ref, row, col, p));
      return Vec3i.fromPointer(p) as T;
    } else if (T == Vec4i) {
      final p = calloc<cvg.Vec4i>();
      cvRun(() => CFFI.Mat_GetVec4i(ref, row, col, p));
      return Vec4i.fromPointer(p) as T;
    } else if (T == Vec6i) {
      final p = calloc<cvg.Vec6i>();
      cvRun(() => CFFI.Mat_GetVec6i(ref, row, col, p));
      return Vec6i.fromPointer(p) as T;
    } else if (T == Vec8i) {
      final p = calloc<cvg.Vec8i>();
      cvRun(() => CFFI.Mat_GetVec8i(ref, row, col, p));
      return Vec8i.fromPointer(p) as T;
    }
    // Vec2f, Vec3f, Vec4f, Vec6f
    else if (T == Vec2f) {
      final p = calloc<cvg.Vec2f>();
      cvRun(() => CFFI.Mat_GetVec2f(ref, row, col, p));
      return Vec2f.fromPointer(p) as T;
    } else if (T == Vec3f) {
      final p = calloc<cvg.Vec3f>();
      cvRun(() => CFFI.Mat_GetVec3f(ref, row, col, p));
      return Vec3f.fromPointer(p) as T;
    } else if (T == Vec4f) {
      final p = calloc<cvg.Vec4f>();
      cvRun(() => CFFI.Mat_GetVec4f(ref, row, col, p));
      return Vec4f.fromPointer(p) as T;
    } else if (T == Vec6f) {
      final p = calloc<cvg.Vec6f>();
      cvRun(() => CFFI.Mat_GetVec6f(ref, row, col, p));
      return Vec6f.fromPointer(p) as T;
    }
    // Vec2d, Vec3d, Vec4d, Vec6d
    else if (T == Vec2d) {
      final p = calloc<cvg.Vec2d>();
      cvRun(() => CFFI.Mat_GetVec2d(ref, row, col, p));
      return Vec2d.fromPointer(p) as T;
    } else if (T == Vec3d) {
      final p = calloc<cvg.Vec3d>();
      cvRun(() => CFFI.Mat_GetVec3d(ref, row, col, p));
      return Vec3d.fromPointer(p) as T;
    } else if (T == Vec4d) {
      final p = calloc<cvg.Vec4d>();
      cvRun(() => CFFI.Mat_GetVec4d(ref, row, col, p));
      return Vec4d.fromPointer(p) as T;
    } else if (T == Vec6d) {
      final p = calloc<cvg.Vec6d>();
      cvRun(() => CFFI.Mat_GetVec6d(ref, row, col, p));
      return Vec6d.fromPointer(p) as T;
    } else {
      throw UnsupportedError("at<$T>() for $type is not supported!");
    }
  }

  /// cv::Mat::at\<T\>(i0, i1, i2) of cv::Mat
  ///
  /// example:
  /// ```dart
  /// var m = cv.Mat.fromScalar(cv.Scalar(2, 4, 1, 0), cv.MatType.CV_32FC3);
  /// m.at<double>(0, 0); // 2.0
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(2, 4, 1)
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a7a6d7e3696b8b19b9dfac3f209118c40
  T at<T>(int row, int col, [int? i2]) {
    if (T == int || T == double || T == num) {
      return atNum(row, col, i2) as T;
    } else if (isSubtype<T, CvVec>()) {
      return atVec<T>(row, col);
    } else {
      throw UnsupportedError("T must be num or CvVec(e.g., Vec3b), but got $T");
    }
  }

  void setVec<T>(int row, int col, T val) {
    // Vec2b, Vec3b, Vec4b
    if (val is Vec2b) {
      cvRun(() => CFFI.Mat_SetVec2b(ref, row, col, val.ref));
    } else if (val is Vec3b) {
      cvRun(() => CFFI.Mat_SetVec3b(ref, row, col, val.ref));
    } else if (val is Vec4b) {
      cvRun(() => CFFI.Mat_SetVec4b(ref, row, col, val.ref));
    }
    // Vec2w, Vec3w, Vec4w
    else if (val is Vec2w) {
      cvRun(() => CFFI.Mat_SetVec2w(ref, row, col, val.ref));
    } else if (val is Vec3w) {
      cvRun(() => CFFI.Mat_SetVec3w(ref, row, col, val.ref));
    } else if (val is Vec4w) {
      cvRun(() => CFFI.Mat_SetVec4w(ref, row, col, val.ref));
    }
    // Vec2s, Vec3s, Vec4s
    else if (val is Vec2s) {
      cvRun(() => CFFI.Mat_SetVec2s(ref, row, col, val.ref));
    } else if (val is Vec3s) {
      cvRun(() => CFFI.Mat_SetVec3s(ref, row, col, val.ref));
    } else if (val is Vec4s) {
      cvRun(() => CFFI.Mat_SetVec4s(ref, row, col, val.ref));
    }
    // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
    else if (val is Vec2i) {
      cvRun(() => CFFI.Mat_SetVec2i(ref, row, col, val.ref));
    } else if (val is Vec3i) {
      cvRun(() => CFFI.Mat_SetVec3i(ref, row, col, val.ref));
    } else if (val is Vec4i) {
      cvRun(() => CFFI.Mat_SetVec4i(ref, row, col, val.ref));
    } else if (val is Vec6i) {
      cvRun(() => CFFI.Mat_SetVec6i(ref, row, col, val.ref));
    } else if (val is Vec8i) {
      cvRun(() => CFFI.Mat_SetVec8i(ref, row, col, val.ref));
    }
    // Vec2f, Vec3f, Vec4f, Vec6f
    else if (val is Vec2f) {
      cvRun(() => CFFI.Mat_SetVec2f(ref, row, col, val.ref));
    } else if (val is Vec3f) {
      cvRun(() => CFFI.Mat_SetVec3f(ref, row, col, val.ref));
    } else if (val is Vec4f) {
      cvRun(() => CFFI.Mat_SetVec4f(ref, row, col, val.ref));
    } else if (val is Vec6f) {
      cvRun(() => CFFI.Mat_SetVec6f(ref, row, col, val.ref));
    }
    // Vec2d, Vec3d, Vec4d, Vec6d
    else if (val is Vec2d) {
      cvRun(() => CFFI.Mat_SetVec2d(ref, row, col, val.ref));
    } else if (val is Vec3d) {
      cvRun(() => CFFI.Mat_SetVec3d(ref, row, col, val.ref));
    } else if (val is Vec4d) {
      cvRun(() => CFFI.Mat_SetVec4d(ref, row, col, val.ref));
    } else if (val is Vec6d) {
      cvRun(() => CFFI.Mat_SetVec6d(ref, row, col, val.ref));
    } else {
      throw UnsupportedError("at<$T>() for $type is not supported!");
    }
  }

  void setU8(int row, int col, int val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetUChar(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetUChar3(ref, row, col, i2, val));

  void setI8(int row, int col, int val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetSChar(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetSChar3(ref, row, col, i2, val));

  void setU16(int row, int col, int val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetUShort(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetUShort3(ref, row, col, i2, val));

  void setI16(int row, int col, int val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetShort(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetShort3(ref, row, col, i2, val));

  void setI32(int row, int col, int val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetInt(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetInt3(ref, row, col, i2, val));

  void setF32(int row, int col, double val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetFloat(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetFloat3(ref, row, col, i2, val));

  void setF64(int row, int col, double val, [int? i2]) => i2 == null
      ? cvRun(() => CFFI.Mat_SetDouble(ref, row, col, val))
      : cvRun(() => CFFI.Mat_SetDouble3(ref, row, col, i2, val));

  void setNum<T extends num>(int row, int col, T val, [int? i2]) {
    return switch (type.depth) {
      MatType.CV_8U => setU8(row, col, val as int, i2),
      MatType.CV_8S => setI8(row, col, val as int, i2),
      MatType.CV_16U => setU16(row, col, val as int, i2),
      MatType.CV_16S => setI16(row, col, val as int, i2),
      MatType.CV_32S => setI32(row, col, val as int, i2),
      MatType.CV_32F => setF32(row, col, val as double, i2),
      MatType.CV_64F => setF64(row, col, val as double, i2),
      _ => throw UnsupportedError("Unsupported type: $type")
    };
  }

  /// equivalent to Mat::at\<T\>(i0, i1, i2) = val;
  /// where T might be int, double, [U8], [I8], [U16], [I16], [I32], [F32], [F64].
  /// or cv::Vec<> like cv::Vec3b
  ///
  /// example
  /// ```dart
  /// var m = cv.Mat.fromScalar(cv.Scalar(2, 4, 1, 0), cv.MatType.CV_32FC3);
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(2, 4, 1)
  /// m.set<cv.Vec3f>(0, 0, cv.Vec3f(9, 9, 9));
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(9, 9, 9)
  /// ```
  void set<T>(int row, int col, Object val, [int? i2]) {
    if (T == int || T == double) {
      setNum(row, col, val as num, i2);
    } else if (isSubtype<T, CvVec>()) {
      setVec<T>(row, col, val as T);
    } else if (T == U8) {
      setU8(row, col, val as int);
    } else if (T == I8) {
      setI8(row, col, val as int);
    } else if (T == U16) {
      setU16(row, col, val as int);
    } else if (T == I16) {
      setI16(row, col, val as int);
    } else if (T == I32) {
      setI32(row, col, val as int);
    } else if (T == F32) {
      setF32(row, col, val as double);
    } else if (T == F64) {
      setF64(row, col, val as double);
    } else {
      throw UnsupportedError("Unsupported type $T");
    }
  }

  // https://github.com/dart-lang/sdk/issues/43390#issuecomment-690993957
  bool isSubtype<S, T>() => <S>[] is List<T>;

  /// equivalent to Mat::ptr\<T\>(i0, i1, i2)
  ///
  /// **DANGEROUS**
  ///
  /// returns a pointer to operate Mat directly and effectively, use with caution!
  ///
  /// Example:
  /// ```dart
  /// final mat = cv.Mat.ones(3, 3, cv.MatType.CV_8UC1);
  /// mat.set<int>(0, 0, 99);
  ///
  /// final ptr = mat.ptrAt<cv.U8>(0, 0);
  /// print(ptr[0]); // 99
  ///
  /// ptr[0] = 21;
  /// // Mat::ptr(i, j)
  /// print(mat.at<int>(0, 0)); // 21
  /// print(ptr[0]); // 21
  ///
  /// final ptr1 = mat.ptrAt<cv.U8>(0);
  /// print(ptr1[0]); // 21
  /// print(List.generate(mat.cols, (i)=>ptr1[i]); // [21, 1, 1]
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a8b2912f6a6f5d55a3c9a7aae9134d862
  ffi.Pointer<T> ptrAt<T extends ffi.NativeType>(int i0, [int? i1, int? i2]) {
    if (T == ffi.UnsignedChar) return ptrU8(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.Char) return ptrI8(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.UnsignedShort) return ptrU16(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.Short) return ptrI16(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.Int) return ptrI32(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.Float) return ptrF32(i0, i1, i2) as ffi.Pointer<T>;
    if (T == ffi.Double) return ptrF64(i0, i1, i2) as ffi.Pointer<T>;
    throw UnsupportedError("ptr<$T>() is not supported!");
  }

  ffi.Pointer<ffi.UnsignedChar> ptrU8(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.UnsignedChar>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_u8_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_u8_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_u8_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrU8($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.UnsignedChar>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.Char> ptrI8(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i8_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i8_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_i8_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrI8($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.Char>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.UnsignedShort> ptrU16(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.UnsignedShort>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_u16_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_u16_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_u16_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrU16($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.UnsignedShort>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.Short> ptrI16(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.Short>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i16_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i16_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_i16_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrI16($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.Short>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.Int> ptrI32(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.Int>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i32_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_i32_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_i32_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrI32($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.Int>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.Float> ptrF32(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.Float>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_f32_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_f32_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_f32_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrF32($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.Float>();
    calloc.free(p);
    return ret;
  }

  ffi.Pointer<ffi.Double> ptrF64(int i0, [int? i1, int? i2]) {
    final p = calloc<ffi.Pointer<ffi.Double>>();
    if (i1 == null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_f64_1(ref, i0, p));
    } else if (i1 != null && i2 == null) {
      cvRun(() => CFFI.Mat_Ptr_f64_2(ref, i0, i1, p));
    } else if (i1 != null && i2 != null) {
      cvRun(() => CFFI.Mat_Ptr_f64_3(ref, i0, i1, i2, p));
    } else {
      throw UnsupportedError("ptrF64($i0, $i1, $i2) is not supported!");
    }
    final ret = p.value.cast<ffi.Double>();
    calloc.free(p);
    return ret;
  }

  // TODO: for now, dart do not support operator overloading
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
        case MatType.CV_8S:
          return addI8(val as int, inplace: inplace);
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_AddUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddUChar(dst.ref, val));
      return dst;
    }
  }

  Mat addI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_AddSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_AddSChar(dst.ref, val));
      return dst;
    }
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
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
        case MatType.CV_8S:
          return subtractI8(val as int, inplace: inplace);
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractUChar(dst.ref, val));
      return dst;
    }
  }

  Mat subtractI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_SubtractSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_SubtractSChar(dst.ref, val));
      return dst;
    }
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
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
        case MatType.CV_8S:
          return multiplyI8(val as int, inplace: inplace);
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplyUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplyUChar(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_MultiplySChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_MultiplySChar(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
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
        case MatType.CV_8S:
          return divideI8(val as int, inplace: inplace);
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
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideUChar(dst.ref, val));
      return dst;
    }
  }

  Mat divideI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    if (inplace) {
      cvRun(() => CFFI.Mat_DivideSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => CFFI.Mat_DivideSChar(dst.ref, val));
      return dst;
    }
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
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
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
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
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
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
    assert(rect.x + rect.width <= width && rect.y + rect.height <= height);
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
      final s = calloc<cvg.Scalar>();
      if (mask == null) {
        cvRun(() => CFFI.Mat_Mean(ref, s));
      } else {
        cvRun(() => CFFI.Mat_MeanWithMask(ref, mask.ref, s));
      }
      return Scalar.fromPointer(s);
    });
  }

  /// Calculates standard deviation, per channel.
  /// [Scalar] order is same as [Mat], i.e., BGR -> BGR
  Scalar stdDev() {
    return cvRunArena<Scalar>((arena) {
      final mean = calloc<cvg.Scalar>();
      final sd = calloc<cvg.Scalar>();
      cvRun(() => CFFI.Mat_MeanStdDev(ref, mean, sd));
      return Scalar.fromPointer(sd);
    });
  }

  /// Similar to [stdDev]
  Scalar variance() => stdDev().pow(2);

  /// Calculates a square root of array elements.
  Mat sqrt() {
    assert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F);
    final p = calloc<cvg.Mat>();
    cvRun(() => CFFI.Mat_Sqrt(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() {
    return cvRunArena<Scalar>((arena) {
      final s = calloc<cvg.Scalar>();
      cvRun(() => CFFI.Mat_Sum(ref, s));
      return Scalar.fromPointer(s);
    });
  }

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => cvRun(() => CFFI.Mat_PatchNaNs(ref, val));

  Mat setTo(Scalar s) {
    cvRun(() => CFFI.Mat_SetTo(ref, s.ref));
    return this;
  }

  /// This Method converts single-channel Mat to 2D List
  List<List<num>> toList() => switch (type.depth) {
        MatType.CV_8U => List.generate(rows, (row) => List.generate(cols, (col) => atU8(row, col))),
        MatType.CV_8S => List.generate(rows, (row) => List.generate(cols, (col) => atI8(row, col))),
        MatType.CV_16U => List.generate(rows, (row) => List.generate(cols, (col) => atU16(row, col))),
        MatType.CV_16S => List.generate(rows, (row) => List.generate(cols, (col) => atI16(row, col))),
        MatType.CV_32S => List.generate(rows, (row) => List.generate(cols, (col) => atI32(row, col))),
        MatType.CV_32F => List.generate(rows, (row) => List.generate(cols, (col) => atF32(row, col))),
        MatType.CV_64F => List.generate(rows, (row) => List.generate(cols, (col) => atF64(row, col))),
        _ => throw UnsupportedError("toList() for $type is not supported!")
      };

  /// Returns a 3D list of the mat, only for multi-channel mats.
  /// The list is ordered as [row][col][channels].
  ///
  /// [T]: The type of the elements in the mat.
  /// [P]: The type of the elements in the list.
  ///
  /// Example:
  /// ```dart
  /// final mat = Mat.fromBytes(width: 3, height: 3, type: MatType.CV_8UC3, bytes: [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  /// final list = mat.toList3D<Vec3b, int>();
  /// print(list); // [[[0, 1, 2], [3, 4, 5], [6, 7, 8]]]
  /// ```
  List<List<List<num>>> toList3D<T extends CvVec>() {
    assert(channels >= 2, "toList3D() only for channels >= 2, but this.channels=$channels");
    return List.generate(rows, (row) => List.generate(cols, (col) => at<T>(row, col).val));
  }

  /// Get  a view of native data, and will be GCed when the Mat is GCed.
  Uint8List get data {
    final (p, len) = dataPtr;
    return p.asTypedList(len);
  }

  /// Get the data pointer of the Mat
  ///
  /// DO NOT free the pointer, the native memory is managed by [Mat]
  (ffi.Pointer<ffi.Uint8> ptr, int len) get dataPtr {
    final p = calloc<ffi.Pointer<cvg.uchar>>();
    final plen = calloc<ffi.Int>();
    cvRun(() => CFFI.Mat_DataPtr(ref, p, plen));
    final ret = (p.value.cast<ffi.Uint8>(), plen.value);
    calloc.free(p);
    calloc.free(plen);
    return ret;
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
  VecMat._(this.ptr, [bool attach = true]) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory VecMat.fromPointer(cvg.VecMatPtr ptr, [bool attach = true]) => VecMat._(ptr, attach);
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
  static final finalizer = OcvFinalizer<cvg.VecMatPtr>(CFFI.addresses.VecMat_Close);

  void dispose() {
    finalizer.detach(this);
    CFFI.VecMat_Close(ptr);
  }

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
