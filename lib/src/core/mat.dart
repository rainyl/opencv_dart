import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import 'cv_vec.dart';
import 'base.dart';
import 'rect.dart';
import 'scalar.dart';
import 'mat_type.dart';
import 'point.dart';
import 'vec.dart';
import 'array.dart';
import '../opencv.g.dart' as cvg;

class Mat extends CvStruct<cvg.Mat> {
  Mat._(cvg.MatPtr ptr, [this.xdata]) : super.fromPointer(ptr) {
    finalizer.attach(this, ptr.cast());
  }

  /// This method is very similar to [clone], will copy data from [mat]
  factory Mat.fromCMat(cvg.Mat mat) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_FromCMat(mat, p));
    final vec = Mat._(p);
    return vec;
  }

  /// Mat (Size size, int type, void *data, size_t step=AUTO_STEP)
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a9fa74fb14362d87cb183453d2441948f
  factory Mat.fromList(int rows, int cols, MatType type, List data, [int step = 0]) {
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
    cvRun(() => cvg.Mat_NewFromBytes(rows, cols, type.toInt32(), xdata.asVoid(), step, p));
    final mat = Mat._(p, xdata);
    return mat;
  }

  /// This method is different from [Mat.fromPtr], will construct from pointer directly
  factory Mat.fromPointer(cvg.MatPtr mat) => Mat._(mat);

  factory Mat.empty() {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_New(p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromScalar(int rows, int cols, MatType type, Scalar s) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_NewWithSizeFromScalar(s.ref, rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromVec(Vec vec) {
    final p = calloc<cvg.Mat>();
    if (vec is VecPoint) {
      cvRun(() => cvg.Mat_NewFromVecPoint(vec.ref, p));
    } else if (vec is VecPoint2f) {
      cvRun(() => cvg.Mat_NewFromVecPoint2f(vec.ref, p));
    } else if (vec is VecPoint3f) {
      cvRun(() => cvg.Mat_NewFromVecPoint3f(vec.ref, p));
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
    cvRun(() => cvg.Mat_NewWithSizeFromScalar(scalar.ref, rows, cols, type!.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.eye(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Eye(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.zeros(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Zeros(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.ones(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Ones(rows, cols, type.toInt32(), p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.randn(int rows, int cols, MatType type, {Scalar? mean, Scalar? std}) {
    mean ??= Scalar.all(0);
    std ??= Scalar.all(1);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => cvg.RandN(mat.ref, mean!.ref, std!.ref));
    return mat;
  }

  factory Mat.randu(int rows, int cols, MatType type, {Scalar? low, Scalar? high}) {
    low ??= Scalar.all(0);
    high ??= Scalar.all(256);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => cvg.RandU(mat.ref, low!.ref, high!.ref));
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
    cvRun(() => cvg.Mat_FromPtr(m, rows, cols, type, prows, pcols, p));
    final mat = Mat._(p);
    return mat;
  }

  static final finalizer = OcvFinalizer<cvg.MatPtr>(ffi.Native.addressOf(cvg.Mat_Close));

  /// external native data array of [Mat], used for [Mat.fromList]
  NativeArray? xdata;
  MatType get type => cvRunArena<MatType>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Type(ref, p));
        return MatType(p.value);
      });
  int get width => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Cols(ref, p));
        return p.value;
      });
  int get height => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Rows(ref, p));
        return p.value;
      });
  int get cols => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Cols(ref, p));
        return p.value;
      });
  int get rows => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Rows(ref, p));
        return p.value;
      });
  int get channels => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Channels(ref, p));
        return p.value;
      });
  int get total => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Total(ref, p));
        return p.value;
      });
  bool get isEmpty => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => cvg.Mat_Empty(ref, p));
        return p.value;
      });
  bool get isContinus => cvRunArena<bool>((arena) {
        final p = arena<ffi.Bool>();
        cvRun(() => cvg.Mat_IsContinuous(ref, p));
        return p.value;
      });
  int get step => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_Step(ref, p));
        return p.value;
      });
  int get elemSize => cvRunArena<int>((arena) {
        final p = arena<ffi.Int>();
        cvRun(() => cvg.Mat_ElemSize(ref, p));
        return p.value;
      });

  /// ([rows], [cols])
  List<int> get size => [rows, cols];

  // List<int> get shape {
  //   return cvRunArena<List<int>>((arena) {
  //     final s = arena<cvg.VecInt>();
  //     cvRun(() => cvg.Mat_Size(ref, s));
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
      cvRun(() => cvg.Mat_CountNonZero(ref, p));
      return p.value;
    });
  }

  T _atNum<T>(int row, int col, [int? cn]) {
    return cvRunArena<T>((arena) {
      switch (type.depth) {
        case MatType.CV_8U:
          final p = arena<ffi.Uint8>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetUChar(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetUChar3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_8S:
          final p = arena<ffi.Int8>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetSChar(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetSChar3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_16U:
          final p = arena<ffi.Uint16>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetUShort(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetUShort3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_16S:
          final p = arena<ffi.Int16>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetShort(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetShort3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_32S:
          final p = arena<ffi.Int32>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetInt(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetInt3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_32F:
          final p = arena<ffi.Float>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetFloat(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetFloat3(ref, row, col, cn, p));
          }
          return p.value as T;
        case MatType.CV_64F:
          final p = arena<ffi.Double>();
          if (type.channels == 1 || cn == null) {
            cvRun(() => cvg.Mat_GetDouble(ref, row, col, p));
          } else {
            cvRun(() => cvg.Mat_GetDouble3(ref, row, col, cn, p));
          }
          return p.value as T;
        default:
          throw UnsupportedError("at() for $type is not supported!");
      }
    });
  }

  T _atVec<T>(int row, int col) {
    final v = cvRunArena<T>((arena) {
      // Vec2b, Vec3b, Vec4b
      if (T == Vec2b) {
        final p = arena<cvg.Vec2b>();
        cvRun(() => cvg.Mat_GetVec2b(ref, row, col, p));
        return Vec2b.fromNative(p.ref) as T;
      } else if (T == Vec3b) {
        final p = arena<cvg.Vec3b>();
        cvRun(() => cvg.Mat_GetVec3b(ref, row, col, p));
        return Vec3b.fromNative(p.ref) as T;
      } else if (T == Vec4b) {
        final p = arena<cvg.Vec4b>();
        cvRun(() => cvg.Mat_GetVec4b(ref, row, col, p));
        return Vec4b.fromNative(p.ref) as T;
      }
      // Vec2w, Vec3w, Vec4w
      else if (T == Vec2w) {
        final p = arena<cvg.Vec2w>();
        cvRun(() => cvg.Mat_GetVec2w(ref, row, col, p));
        return Vec2w.fromNative(p.ref) as T;
      } else if (T == Vec3w) {
        final p = arena<cvg.Vec3w>();
        cvRun(() => cvg.Mat_GetVec3w(ref, row, col, p));
        return Vec3w.fromNative(p.ref) as T;
      } else if (T == Vec4w) {
        final p = arena<cvg.Vec4w>();
        cvRun(() => cvg.Mat_GetVec4w(ref, row, col, p));
        return Vec4w.fromNative(p.ref) as T;
      }
      // Vec2s, Vec3s, Vec4s
      else if (T == Vec2s) {
        final p = arena<cvg.Vec2s>();
        cvRun(() => cvg.Mat_GetVec2s(ref, row, col, p));
        return Vec2s.fromNative(p.ref) as T;
      } else if (T == Vec3s) {
        final p = arena<cvg.Vec3s>();
        cvRun(() => cvg.Mat_GetVec3s(ref, row, col, p));
        return Vec3s.fromNative(p.ref) as T;
      } else if (T == Vec4s) {
        final p = arena<cvg.Vec4s>();
        cvRun(() => cvg.Mat_GetVec4s(ref, row, col, p));
        return Vec4s.fromNative(p.ref) as T;
      }
      // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
      else if (T == Vec2i) {
        final p = arena<cvg.Vec2i>();
        cvRun(() => cvg.Mat_GetVec2i(ref, row, col, p));
        return Vec2i.fromNative(p.ref) as T;
      } else if (T == Vec3i) {
        final p = arena<cvg.Vec3i>();
        cvRun(() => cvg.Mat_GetVec3i(ref, row, col, p));
        return Vec3i.fromNative(p.ref) as T;
      } else if (T == Vec4i) {
        final p = arena<cvg.Vec4i>();
        cvRun(() => cvg.Mat_GetVec4i(ref, row, col, p));
        return Vec4i.fromNative(p.ref) as T;
      } else if (T == Vec6i) {
        final p = arena<cvg.Vec6i>();
        cvRun(() => cvg.Mat_GetVec6i(ref, row, col, p));
        return Vec6i.fromNative(p.ref) as T;
      } else if (T == Vec8i) {
        final p = arena<cvg.Vec8i>();
        cvRun(() => cvg.Mat_GetVec8i(ref, row, col, p));
        return Vec8i.fromNative(p.ref) as T;
      }
      // Vec2f, Vec3f, Vec4f, Vec6f
      else if (T == Vec2f) {
        final p = arena<cvg.Vec2f>();
        cvRun(() => cvg.Mat_GetVec2f(ref, row, col, p));
        return Vec2f.fromNative(p.ref) as T;
      } else if (T == Vec3f) {
        final p = arena<cvg.Vec3f>();
        cvRun(() => cvg.Mat_GetVec3f(ref, row, col, p));
        return Vec3f.fromNative(p.ref) as T;
      } else if (T == Vec4f) {
        final p = arena<cvg.Vec4f>();
        cvRun(() => cvg.Mat_GetVec4f(ref, row, col, p));
        return Vec4f.fromNative(p.ref) as T;
      } else if (T == Vec6f) {
        final p = arena<cvg.Vec6f>();
        cvRun(() => cvg.Mat_GetVec6f(ref, row, col, p));
        return Vec6f.fromNative(p.ref) as T;
      }
      // Vec2d, Vec3d, Vec4d, Vec6d
      else if (T == Vec2d) {
        final p = arena<cvg.Vec2d>();
        cvRun(() => cvg.Mat_GetVec2d(ref, row, col, p));
        return Vec2d.fromNative(p.ref) as T;
      } else if (T == Vec3d) {
        final p = arena<cvg.Vec3d>();
        cvRun(() => cvg.Mat_GetVec3d(ref, row, col, p));
        return Vec3d.fromNative(p.ref) as T;
      } else if (T == Vec4d) {
        final p = arena<cvg.Vec4d>();
        cvRun(() => cvg.Mat_GetVec4d(ref, row, col, p));
        return Vec4d.fromNative(p.ref) as T;
      } else if (T == Vec6d) {
        final p = arena<cvg.Vec6d>();
        cvRun(() => cvg.Mat_GetVec6d(ref, row, col, p));
        return Vec6d.fromNative(p.ref) as T;
      } else {
        throw UnsupportedError("at<$T>() for $type is not supported!");
      }
    });
    return v;
  }

  /// cv::Mat::at\<T\>(i0, i1, i2) of cv::Mat
  ///
  ///
  /// - If matrix is of type [MatType.CV_8U] then use Mat.at\<uchar\>(y,x).
  /// - If matrix is of type [MatType.CV_8S] then use Mat.at\<schar\>(y,x).
  /// - If matrix is of type [MatType.CV_16U] then use Mat.at\<ushort\>(y,x).
  /// - If matrix is of type [MatType.CV_16S] then use Mat.at\<short\>(y,x).
  /// - If matrix is of type [MatType.CV_32S] then use Mat.at\<int\>(y,x).
  /// - If matrix is of type [MatType.CV_32F] then use Mat.at\<float\>(y,x).
  /// - If matrix is of type [MatType.CV_64F] then use Mat.at\<double\>(y,x).
  ///
  /// example:
  /// ```dart
  /// var m = cv.Mat.fromScalar(cv.Scalar(2, 4, 1, 0), cv.MatType.CV_32FC3);
  /// m.at<double>(0, 0); // 2
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(2, 4, 1)
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a7a6d7e3696b8b19b9dfac3f209118c40
  T at<T>(int row, int col, [int? i2]) {
    if (T == int || T == double) {
      return _atNum<T>(row, col, i2);
    } else if (isSubtype<T, CvVec>()) {
      return _atVec<T>(row, col);
    } else {
      throw UnsupportedError("T must be num or CvVec(e.g., Vec3b), but got $T");
    }
  }

  void _setNum<T>(row, col, T val, [int? i2]) {
    switch (type.depth) {
      case MatType.CV_8U:
        assert(T == int, "$type only support int");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetUChar(ref, row, col, val as int))
            : cvRun(() => cvg.Mat_SetUChar3(ref, row, col, i2, val as int));
      case MatType.CV_8S:
        assert(T == int, "$type only support int");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetSChar(ref, row, col, val as int))
            : cvRun(() => cvg.Mat_SetSChar3(ref, row, col, i2, val as int));
      case MatType.CV_16U:
        assert(T == int, "$type only support int");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetUShort(ref, row, col, val as int))
            : cvRun(() => cvg.Mat_SetUShort3(ref, row, col, i2, val as int));
      case MatType.CV_16S:
        assert(T == int, "$type only support int");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetShort(ref, row, col, val as int))
            : cvRun(() => cvg.Mat_SetShort3(ref, row, col, i2, val as int));
      case MatType.CV_32S:
        assert(T == int, "$type only support int");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetInt(ref, row, col, val as int))
            : cvRun(() => cvg.Mat_SetInt3(ref, row, col, i2, val as int));
      case MatType.CV_32F:
        assert(T == double, "$type only support double");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetFloat(ref, row, col, val as double))
            : cvRun(() => cvg.Mat_SetFloat3(ref, row, col, i2, val as double));
      case MatType.CV_64F:
        assert(T == double, "$type only support double");
        type.channels == 1 || i2 == null
            ? cvRun(() => cvg.Mat_SetDouble(ref, row, col, val as double))
            : cvRun(() => cvg.Mat_SetDouble3(ref, row, col, i2, val as double));
      default:
        throw UnsupportedError("setValue() for $type is not supported!");
    }
  }

  void _setVec<T>(int row, int col, T val) {
    cvRunArena((arena) {
      // Vec2b, Vec3b, Vec4b
      if (val is Vec2b) {
        cvRun(() => cvg.Mat_SetVec2b(ref, row, col, val.ref));
      } else if (val is Vec3b) {
        cvRun(() => cvg.Mat_SetVec3b(ref, row, col, val.ref));
      } else if (val is Vec4b) {
        cvRun(() => cvg.Mat_SetVec4b(ref, row, col, val.ref));
      }
      // Vec2w, Vec3w, Vec4w
      else if (val is Vec2w) {
        cvRun(() => cvg.Mat_SetVec2w(ref, row, col, val.ref));
      } else if (val is Vec3w) {
        cvRun(() => cvg.Mat_SetVec3w(ref, row, col, val.ref));
      } else if (val is Vec4w) {
        cvRun(() => cvg.Mat_SetVec4w(ref, row, col, val.ref));
      }
      // Vec2s, Vec3s, Vec4s
      else if (val is Vec2s) {
        cvRun(() => cvg.Mat_SetVec2s(ref, row, col, val.ref));
      } else if (val is Vec3s) {
        cvRun(() => cvg.Mat_SetVec3s(ref, row, col, val.ref));
      } else if (val is Vec4s) {
        cvRun(() => cvg.Mat_SetVec4s(ref, row, col, val.ref));
      }
      // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
      else if (val is Vec2i) {
        cvRun(() => cvg.Mat_SetVec2i(ref, row, col, val.ref));
      } else if (val is Vec3i) {
        cvRun(() => cvg.Mat_SetVec3i(ref, row, col, val.ref));
      } else if (val is Vec4i) {
        cvRun(() => cvg.Mat_SetVec4i(ref, row, col, val.ref));
      } else if (val is Vec6i) {
        cvRun(() => cvg.Mat_SetVec6i(ref, row, col, val.ref));
      } else if (val is Vec8i) {
        cvRun(() => cvg.Mat_SetVec8i(ref, row, col, val.ref));
      }
      // Vec2f, Vec3f, Vec4f, Vec6f
      else if (val is Vec2f) {
        cvRun(() => cvg.Mat_SetVec2f(ref, row, col, val.ref));
      } else if (val is Vec3f) {
        cvRun(() => cvg.Mat_SetVec3f(ref, row, col, val.ref));
      } else if (val is Vec4f) {
        cvRun(() => cvg.Mat_SetVec4f(ref, row, col, val.ref));
      } else if (val is Vec6f) {
        cvRun(() => cvg.Mat_SetVec6f(ref, row, col, val.ref));
      }
      // Vec2d, Vec3d, Vec4d, Vec6d
      else if (val is Vec2d) {
        cvRun(() => cvg.Mat_SetVec2d(ref, row, col, val.ref));
      } else if (val is Vec3d) {
        cvRun(() => cvg.Mat_SetVec3d(ref, row, col, val.ref));
      } else if (val is Vec4d) {
        cvRun(() => cvg.Mat_SetVec4d(ref, row, col, val.ref));
      } else if (val is Vec6d) {
        cvRun(() => cvg.Mat_SetVec6d(ref, row, col, val.ref));
      } else {
        throw UnsupportedError("at<$T>() for $type is not supported!");
      }
    });
  }

  /// equivalent to Mat::at\<T\>(i0, i1, i2) = val;
  /// where T might be basic value types like uchar, char, int.
  /// or cv::Vec<> like cv::Vec3b
  ///
  /// example
  /// ```dart
  /// var m = cv.Mat.fromScalar(cv.Scalar(2, 4, 1, 0), cv.MatType.CV_32FC3);
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(2, 4, 1)
  /// m.set<cv.Vec3f>(0, 0, cv.Vec3f(9, 9, 9));
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(9, 9, 9)
  /// ```
  void set<T>(int row, int col, T val, [int? i2]) {
    if (T == int || T == double) {
      _setNum<T>(row, col, val, i2);
    } else if (isSubtype<T, CvVec>()) {
      _setVec<T>(row, col, val);
    } else {
      throw UnsupportedError("T must be num or CvVec(e.g., Vec3b), but got $T");
    }
  }

  // https://github.com/dart-lang/sdk/issues/43390#issuecomment-690993957
  bool isSubtype<S, T>() => <S>[] is List<T>;

  // TODO: for now, dart do not support operator overloading
  // https://github.com/dart-lang/language/issues/2456
  // waiting for it's implementation and add more methods
  // operator +(int v) {
  //   cvg.Mat_AddUChar(ref, v);
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
      cvRun(() => cvg.Mat_Add(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => cvg.Mat_Add(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat addU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX,
        "addU8() only for CV_8U");
    if (inplace) {
      cvRun(() => cvg.Mat_AddUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_AddUChar(dst.ref, val));
      return dst;
    }
  }

  Mat addI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX,
        "addI8() only for CV_8S");
    if (inplace) {
      cvRun(() => cvg.Mat_AddSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_AddSChar(dst.ref, val));
      return dst;
    }
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "addI32() only for CV_32S");
    if (inplace) {
      cvRun(() => cvg.Mat_AddI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_AddI32(dst.ref, val));
      return dst;
    }
  }

  Mat addF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "addF32() only for CV_32F");
    if (inplace) {
      cvRun(() => cvg.Mat_AddFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_AddFloat(dst.ref, val));
      return dst;
    }
  }

  Mat addF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "addF64() only for CV_64F");
    if (inplace) {
      cvRun(() => cvg.Mat_AddF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_AddF64(dst.ref, val));
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
      cvRun(() => cvg.Mat_Subtract(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => cvg.Mat_Subtract(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat subtractU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX,
        "subtractU8() only for CV_8U");
    if (inplace) {
      cvRun(() => cvg.Mat_SubtractUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_SubtractUChar(dst.ref, val));
      return dst;
    }
  }

  Mat subtractI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX,
        "subtractI8() only for CV_8S");
    if (inplace) {
      cvRun(() => cvg.Mat_SubtractSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_SubtractSChar(dst.ref, val));
      return dst;
    }
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "subtractI32() only for CV_32S");
    if (inplace) {
      cvRun(() => cvg.Mat_SubtractI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_SubtractI32(dst.ref, val));
      return dst;
    }
  }

  Mat subtractF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "subtractF32() only for CV_32F");
    if (inplace) {
      cvRun(() => cvg.Mat_SubtractFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_SubtractFloat(dst.ref, val));
      return dst;
    }
  }

  Mat subtractF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "subtractF64() only for CV_64F");
    if (inplace) {
      cvRun(() => cvg.Mat_SubtractF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_SubtractF64(dst.ref, val));
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
      cvRun(() => cvg.Mat_Multiply(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => cvg.Mat_Multiply(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat multiplyU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX,
        "multiplyU8() only for CV_8U");
    if (inplace) {
      cvRun(() => cvg.Mat_MultiplyUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_MultiplyUChar(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX,
        "multiplyI8() only for CV_8S");
    if (inplace) {
      cvRun(() => cvg.Mat_MultiplySChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_MultiplySChar(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "multiplyI32() only for CV_32S");
    if (inplace) {
      cvRun(() => cvg.Mat_MultiplyI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_MultiplyI32(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "multiplyF32() only for CV_32F");
    if (inplace) {
      cvRun(() => cvg.Mat_MultiplyFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_MultiplyFloat(dst.ref, val));
      return dst;
    }
  }

  Mat multiplyF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "multiplyF64() only for CV_64F");
    if (inplace) {
      cvRun(() => cvg.Mat_MultiplyF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_MultiplyF64(dst.ref, val));
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
      cvRun(() => cvg.Mat_Divide(ref, other.ref, ref));
      return this;
    } else {
      final dst = Mat.empty();
      cvRun(() => cvg.Mat_Divide(ref, other.ref, dst.ref));
      return dst;
    }
  }

  Mat divideU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX,
        "divideU8() only for CV_8U");
    if (inplace) {
      cvRun(() => cvg.Mat_DivideUChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_DivideUChar(dst.ref, val));
      return dst;
    }
  }

  Mat divideI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX,
        "divideI8() only for CV_8S");
    if (inplace) {
      cvRun(() => cvg.Mat_DivideSChar(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_DivideSChar(dst.ref, val));
      return dst;
    }
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX,
        "divideI32() only for CV_32S");
    if (inplace) {
      cvRun(() => cvg.Mat_DivideI32(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_DivideI32(dst.ref, val));
      return dst;
    }
  }

  Mat divideF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX, "divideF32() only for CV_32F");
    if (inplace) {
      cvRun(() => cvg.Mat_DivideFloat(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_DivideFloat(dst.ref, val));
      return dst;
    }
  }

  Mat divideF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX, "divideF64() only for CV_64F");
    if (inplace) {
      cvRun(() => cvg.Mat_DivideF64(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Mat_DivideF64(dst.ref, val));
      return dst;
    }
  }

  Mat transpose({bool inplace = false}) {
    final dst = inplace ? this : Mat.empty();
    cvRun(() => cvg.Mat_Transpose(ref, dst.ref));
    return dst;
  }

  Mat clone() {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_Clone(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  void copyTo(Mat dst) {
    cvRun(() => cvg.Mat_CopyTo(ref, dst.ref));
  }

  void copyToWithMask(Mat dst, Mat mask) {
    cvRun(() => cvg.Mat_CopyToWithMask(ref, dst.ref, mask.ref));
  }

  Mat convertTo(MatType type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    cvRun(() => cvg.Mat_ConvertToWithParams(ref, dst.ref, type.toInt32(), alpha, beta));
    return dst;
  }

  Mat region(Rect rect) {
    assert(rect.x + rect.width <= width && rect.y + rect.height <= height, "rect is out of range");
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_Region(ref, rect.ref, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat reshape(int cn, int rows) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_Reshape(ref, cn, rows, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat rotate(int rotationCode, {bool inplace = false}) {
    if (inplace) {
      cvRun(() => cvg.Rotate(ref, ref, rotationCode));
      return this;
    } else {
      final dst = clone();
      cvRun(() => cvg.Rotate(ref, dst.ref, rotationCode));
      return dst;
    }
  }

  Mat rowRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_rowRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat colRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_colRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  Mat convertToFp16() {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_ConvertFp16(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  Scalar mean({Mat? mask}) {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      if (mask == null) {
        cvRun(() => cvg.Mat_Mean(ref, s));
      } else {
        cvRun(() => cvg.Mat_MeanWithMask(ref, mask.ref, s));
      }
      return Scalar.fromNative(s.ref);
    });
  }

  /// Calculates standard deviation, per channel.
  /// [Scalar] order is same as [Mat], i.e., BGR -> BGR
  Scalar stdDev() {
    return cvRunArena<Scalar>((arena) {
      final mean = arena<cvg.Scalar>();
      final sd = arena<cvg.Scalar>();
      cvRun(() => cvg.Mat_MeanStdDev(ref, mean, sd));
      return Scalar.fromNative(sd.ref);
    });
  }

  /// Similar to [stdDev]
  Scalar variance() => stdDev().pow(2);

  /// Calculates a square root of array elements.
  Mat sqrt() {
    assert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F,
        "sqrt() only for CV_32F or CV_64F");
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.Mat_Sqrt(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() {
    return cvRunArena<Scalar>((arena) {
      final s = arena<cvg.Scalar>();
      cvRun(() => cvg.Mat_Sum(ref, s));
      return Scalar.fromNative(s.ref);
    });
  }

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => cvRun(() => cvg.Mat_PatchNaNs(ref, val));

  Mat setTo(Scalar s) {
    cvRun(() => cvg.Mat_SetTo(ref, s.ref));
    return this;
  }

  void release() => cvRun(() => cvg.Mat_Release(ptr));

  /// This Method converts single-channel Mat to 2D List
  List<List<num>> toList() {
    switch (type.depth) {
      case MatType.CV_8U:
      case MatType.CV_8S:
      case MatType.CV_16U:
      case MatType.CV_16S:
      case MatType.CV_32S:
        return List.generate(rows, (row) => List.generate(cols, (col) => at<int>(row, col)));
      case MatType.CV_32F:
      case MatType.CV_64F:
        return List.generate(rows, (row) => List.generate(cols, (col) => at<double>(row, col)));
      default:
        throw UnsupportedError("toList() for $type is not supported!");
    }
  }

  /// Returns a 3D list of the mat, only for multi-channel mats.
  /// The list is ordered as [row][col][channel].
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
  List<List<List<P>>> toList3D<T extends CvVec, P extends num>() {
    assert(channels >= 2, "toList3D() only for channels >= 2, but this.channels=$channels");
    return List.generate(
        rows, (row) => List.generate(cols, (col) => at<T>(row, col).val as List<P>));
  }

  /// Get the data pointer of the Mat, this getter will reture a view of native
  /// data, and will be GCed when the Mat is GCed.
  Uint8List get data {
    return cvRunArena<Uint8List>((arena) {
      final p = calloc<ffi.Pointer<cvg.uchar>>();
      final plen = arena<ffi.Int>();
      cvRun(() => cvg.Mat_DataPtr(ref, p, plen));
      final ret = p.value.cast<ffi.Uint8>().asTypedList(plen.value);
      calloc.free(p);
      return ret;
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
    finalizer.attach(this, ptr.cast());
  }
  factory VecMat.fromPointer(cvg.VecMatPtr ptr) => VecMat._(ptr);
  factory VecMat.fromVec(cvg.VecMat ptr) {
    final p = calloc<cvg.VecMat>();
    cvRun(() => cvg.VecMat_NewFromVec(ptr, p));
    final vec = VecMat._(p);
    return vec;
  }
  factory VecMat.fromList(List<Mat> pts) {
    final ptr = calloc<cvg.VecMat>();
    cvRun(() => cvg.VecMat_New(ptr));
    for (var i = 0; i < pts.length; i++) {
      cvRun(() => cvg.VecMat_Append(ptr.ref, pts[i].ref));
    }
    final vec = VecMat._(ptr);
    return vec;
  }

  @override
  int get length {
    final ptrlen = calloc<ffi.Int>();
    cvRun(() => cvg.VecMat_Size(ref, ptrlen));
    final length = ptrlen.value;
    calloc.free(ptrlen);
    return length;
  }

  @override
  cvg.VecMatPtr ptr;
  static final finalizer = OcvFinalizer<cvg.VecMatPtr>(ffi.Native.addressOf(cvg.VecMat_Close));
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
          cvRun(() => cvg.VecMat_Size(ptr, p));
          final len = p.value;
          return len;
        },
      );

  @override
  Mat operator [](int idx) {
    final p = calloc<cvg.Mat>();
    cvRun(() => cvg.VecMat_At(ptr, idx, p));
    final mat = Mat._(p);
    return mat;
  }
}

extension ListMatExtension on List<Mat> {
  VecMat get cvd => VecMat.fromList(this);
}
