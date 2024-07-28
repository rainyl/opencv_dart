import 'dart:async';
import 'dart:ffi' as ffi;
import 'dart:typed_data';

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'cv_vec.dart';
import 'mat_type.dart';
import 'point.dart';
import 'rect.dart';
import 'scalar.dart';
import 'vec.dart';

class Mat extends CvStruct<cvg.Mat> {
  Mat._(cvg.MatPtr ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }

  //SECTION - Constructors

  factory Mat.fromNative(cvg.Mat mat) {
    final p = calloc<cvg.Mat>()..ref = mat;
    return Mat._(p);
  }

  /// Create a Mat from a list of data
  ///
  /// [data] should be raw pixels values with exactly same length of channels * [rows] * [cols]
  ///
  /// Mat (Size size, int type, void *data, size_t step=AUTO_STEP)
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a9fa74fb14362d87cb183453d2441948f
  factory Mat.fromList(int rows, int cols, MatType type, List<num> data) {
    final p = calloc<cvg.Mat>();
    // copy
    final xdata = switch (type.depth) {
      MatType.CV_8U => VecU8.fromList(data.cast<int>()) as Vec,
      MatType.CV_8S => VecI8.fromList(data.cast<int>()) as Vec,
      MatType.CV_16U => VecU16.fromList(data.cast<int>()) as Vec,
      MatType.CV_16S => VecI16.fromList(data.cast<int>()) as Vec,
      MatType.CV_32S => VecI32.fromList(data.cast<int>()) as Vec,
      MatType.CV_32F => VecF32.fromList(data.cast<double>()) as Vec,
      MatType.CV_64F => VecF64.fromList(data.cast<double>()) as Vec,
      MatType.CV_16F => VecF16.fromList(data.cast<double>()) as Vec,
      _ => throw UnsupportedError("Mat.fromList for MatType ${type.asString()} unsupported"),
    };
    // copy
    cvRun(() => ccore.Mat_NewFromBytes(rows, cols, type.value, xdata.asVoid(), p));
    xdata.dispose();
    return Mat._(p);
  }

  /// Create a Mat from a 2D list
  ///
  /// [data] should be a 2D list of numbers with a shape of (rows, cols).
  /// [type] specifies the Mat type.
  factory Mat.from2DList(Iterable<Iterable<num>> data, MatType type) {
    final rows = data.length;
    final cols = data.first.length;
    final flatData = <num>[];
    cvAssert(rows > 0, "The input data must not be empty.");
    cvAssert(
      cols > 0 &&
          data.every((r) {
            flatData.addAll(r);
            return r.length == cols;
          }),
      "All rows must have the same number of columns.",
    );
    return Mat.fromList(rows, cols, type, flatData);
  }

  /// Create a Mat from a 3D list
  ///
  /// [data] should be a 3D list of numbers with a shape of (rows, cols, channels).
  /// [type] specifies the Mat type.
  factory Mat.from3DList(Iterable<Iterable<Iterable<num>>> data, MatType type) {
    final rows = data.length;
    final cols = data.first.length;
    final channels = data.first.first.length;
    final flatData = <num>[];
    cvAssert(rows > 0, "The input data must not be empty.");
    cvAssert(
      cols > 0 &&
          channels > 0 &&
          data.every(
            (r) =>
                r.length == cols &&
                r.every((c) {
                  flatData.addAll(c);
                  return c.length == channels;
                }),
          ),
      "All rows must have the same number of columns.",
    );

    return Mat.fromList(rows, cols, type, flatData);
  }

  /// This method is different from [Mat.fromPtr], will construct from pointer directly
  factory Mat.fromPointer(cvg.MatPtr mat, [bool attach = true]) => Mat._(mat, attach);

  factory Mat.empty() {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_New(p));
    final mat = Mat._(p);
    return mat;
  }

  /// [rows]	Number of rows in a 2D array.
  ///
  /// [cols]	Number of columns in a 2D array.
  ///
  /// [type]	Array type. Use CV_8UC1, ..., CV_64FC4 to create 1-4 channel matrices,
  /// or CV_8UC(n), ..., CV_64FC(n) to create multi-channel (up to CV_CN_MAX channels) matrices.
  ///
  /// [s]	An optional value to initialize each matrix element with.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a3620c370690b5ca4d40c767be6fb4ceb
  factory Mat.fromScalar(int rows, int cols, MatType type, Scalar s) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_NewFromScalar(s.ref, rows, cols, type.value, p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.fromVec(Vec vec, {int? rows, int? cols, MatType? type}) {
    final p = calloc<cvg.Mat>();
    switch (vec) {
      case VecPoint():
        cvRun(() => ccore.Mat_NewFromVecPoint(vec.ref, p));
      case VecPoint2f():
        cvRun(() => ccore.Mat_NewFromVecPoint2f(vec.ref, p));
      case VecPoint3f():
        cvRun(() => ccore.Mat_NewFromVecPoint3f(vec.ref, p));
      case VecPoint3i():
        cvRun(() => ccore.Mat_NewFromVecPoint3i(vec.ref, p));
      case VecU8() when rows != null && cols != null && type != null:
      case VecI8() when rows != null && cols != null && type != null:
      case VecU16() when rows != null && cols != null && type != null:
      case VecI16() when rows != null && cols != null && type != null:
      case VecI32() when rows != null && cols != null && type != null:
      case VecF32() when rows != null && cols != null && type != null:
      case VecF64() when rows != null && cols != null && type != null:
      case VecF16() when rows != null && cols != null && type != null:
        cvRun(() => ccore.Mat_NewFromBytes(rows, cols, type.value, vec.asVoid(), p));
      default:
        throw UnsupportedError("Unsupported Vec type ${vec.runtimeType}");
    }
    vec.dispose();
    return Mat._(p);
  }

  factory Mat.create({int rows = 0, int cols = 0, int r = 0, int g = 0, int b = 0, MatType? type}) {
    type = type ?? MatType.CV_8UC3;
    final scalar = Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_NewFromScalar(scalar.ref, rows, cols, type!.value, p));
    final mat = Mat._(p);
    return mat;
  }

  /// Create [Mat] from another [Mat] with range
  ///
  /// Returns a reference of [Mat]
  factory Mat.fromRange(Mat mat, int rowStart, int rowEnd, {int colStart = 0, int? colEnd}) {
    final p = calloc<cvg.Mat>();
    colEnd ??= mat.cols;
    cvRun(() => ccore.Mat_FromRange(mat.ref, rowStart, rowEnd, colStart, colEnd!, p));
    return Mat._(p);
  }

  /// Returns an identity matrix of the specified size and type.
  ///
  /// The method returns a Matlab-style identity matrix initializer, similarly to Mat::zeros. Similarly to Mat::ones, you can use a scale operation to create a scaled identity matrix efficiently:
  ///
  /// ```Cpp
  /// // make a 4x4 diagonal matrix with 0.1's on the diagonal.
  /// Mat A = Mat::eye(4, 4, CV_32F)*0.1;
  /// ```
  ///
  /// Note
  ///     In case of multi-channels type, identity matrix will be initialized only for the first channel, the others will be set to 0's
  ///
  /// [rows]	Number of rows.
  ///
  /// [cols]	Number of columns.
  ///
  /// [type]	Created matrix type.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a458874f0ab8946136254da37ba06b78b
  factory Mat.eye(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Eye(rows, cols, type.value, p));
    final mat = Mat._(p);
    return mat;
  }

  /// Returns a zero array of the specified size and type.
  ///
  /// The method returns a Matlab-style zero array initializer. It can be used to quickly form a constant
  /// array as a function parameter, part of a matrix expression, or as a matrix initializer:
  ///
  /// ```cpp
  /// Mat A;
  /// A = Mat::zeros(3, 3, CV_32F);
  /// ```
  ///
  /// In the example above, a new matrix is allocated only if A is not a 3x3 floating-point matrix.
  /// Otherwise, the existing matrix A is filled with zeros.
  ///
  /// [rows] Number of rows.
  ///
  /// [cols] Number of columns.
  ///
  /// [type] Created matrix type.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a56daa006391a670e9cb0cd08e3168c99
  factory Mat.zeros(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Zeros(rows, cols, type.value, p));
    final mat = Mat._(p);
    return mat;
  }

  /// Returns an array of all 1's of the specified size and type.
  ///
  /// The method returns a Matlab-style 1's array initializer, similarly to Mat::zeros. Note that using this method you can initialize an array with an arbitrary value, using the following Matlab idiom:
  /// Mat A = Mat::ones(100, 100, CV_8U)*3; // make 100x100 matrix filled with 3.
  ///
  /// The above operation does not form a 100x100 matrix of 1's and then multiply it by 3. Instead, it just remembers the scale factor (3 in this case) and use it when actually invoking the matrix initializer.
  ///
  /// Note
  ///     In case of multi-channels type, only the first channel will be initialized with 1's, the others will be set to 0's.
  ///
  /// [rows]	Number of rows.
  ///
  /// [cols]	Number of columns.
  ///
  /// [type]	Created matrix type.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a5e10227b777425407986727e2d26fcdc
  factory Mat.ones(int rows, int cols, MatType type) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Ones(rows, cols, type.value, p));
    final mat = Mat._(p);
    return mat;
  }

  factory Mat.randn(int rows, int cols, MatType type, {Scalar? mean, Scalar? std}) {
    mean ??= Scalar.all(0);
    std ??= Scalar.all(1);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => ccore.RandN(mat.ref, mean!.ref, std!.ref));
    return mat;
  }

  factory Mat.randu(int rows, int cols, MatType type, {Scalar? low, Scalar? high}) {
    low ??= Scalar.all(0);
    high ??= Scalar.all(256);
    final mat = Mat.create(rows: rows, cols: cols, type: type);
    cvRun(() => ccore.RandU(mat.ref, low!.ref, high!.ref));
    return mat;
  }

  /// this constructor is a wrapper of
  /// `Mat (int rows, int cols, int type, void *data, size_t step=AUTO_STEP)`
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a51615ebf17a64c968df0bf49b4de6a3a
  factory Mat.fromPtr(
    cvg.Mat m,
    int rows,
    int cols,
    int type,
    int prows,
    int pcols,
  ) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_FromPtr(m, rows, cols, type, prows, pcols, p));
    final mat = Mat._(p);
    return mat;
  }

  //!SECTION Constructors

  //SECTION - Properties
  MatType get type => MatType(ccore.Mat_Type(ref));

  int get flags => ccore.Mat_Flags(ref);

  int get width => cols;
  int get height => rows;
  int get cols => ccore.Mat_Cols(ref);
  int get rows => ccore.Mat_Rows(ref);
  int get channels => ccore.Mat_Channels(ref);
  int get total => ccore.Mat_Total(ref);
  bool get isEmpty => ccore.Mat_Empty(ref);
  bool get isContinus => ccore.Mat_IsContinuous(ref);
  bool get isSubmatrix => ccore.Mat_IsSubmatrix(ref);
  (int, int, int) get step {
    final ms = ccore.Mat_Step(ref);
    return (ms.p[0], ms.p[1], ms.p[2]);
  }

  int get elemSize => ccore.Mat_ElemSize(ref);
  int get elemSize1 => ccore.Mat_ElemSize1(ref);
  int get dims => ccore.Mat_Dims(ref);

  /// Get  a view of native data, and will be GCed when the Mat is GCed.
  Uint8List get data => dataPtr.asTypedList(total * elemSize);

  /// Get the data pointer of the Mat
  ///
  /// DO NOT free the pointer, the native memory is managed by [Mat]
  ffi.Pointer<U8> get dataPtr => ccore.Mat_Data(ref).cast<U8>();

  /// Mat.size
  VecI32 get size => VecI32.fromPointer(ccore.Mat_Size(ref));

  /// ([rows], [cols], [channels])
  List<int> get shape => [rows, cols, channels];

  /// only for [channels] == 1
  int get countNoneZero {
    cvAssert(channels == 1, "countNoneZero only for channels == 1");
    return cvRunArena<int>((arena) {
      final p = arena<ffi.Int>();
      cvRun(() => ccore.Mat_CountNonZero(ref, p));
      return p.value;
    });
  }

  //!SECTION - Properties

  //SECTION - At Set

  /// wrapper of cv::Mat::at()
  ///
  num atNum(int i0, int i1, [int? i2]) {
    // https://github.com/opencv/opencv/blob/71d3237a093b60a27601c20e9ee6c3e52154e8b1/modules/core/include/opencv2/core/mat.inl.hpp#L968
    return switch (type.depth) {
      MatType.CV_8U => i2 == null ? (ptrAt<U8>(i0) + i1).value : ptrAt<U8>(i0, i1, i2).value,
      MatType.CV_8S => i2 == null ? (ptrAt<I8>(i0) + i1).value : ptrAt<I8>(i0, i1, i2).value,
      MatType.CV_16U => i2 == null ? (ptrAt<U16>(i0) + i1).value : ptrAt<U16>(i0, i1, i2).value,
      MatType.CV_16S => i2 == null ? (ptrAt<I16>(i0) + i1).value : ptrAt<I16>(i0, i1, i2).value,
      MatType.CV_32S => i2 == null ? (ptrAt<I32>(i0) + i1).value : ptrAt<I32>(i0, i1, i2).value,
      MatType.CV_32F => i2 == null ? (ptrAt<F32>(i0) + i1).value : ptrAt<F32>(i0, i1, i2).value,
      MatType.CV_64F => i2 == null ? (ptrAt<F64>(i0) + i1).value : ptrAt<F64>(i0, i1, i2).value,
      MatType.CV_16F => float16(i2 == null ? (ptrAt<U16>(i0) + i1).value : ptrAt<U16>(i0, i1, i2).value),
      _ => throw UnsupportedError("Unsupported type: ${type.asString()}")
    };
  }

  /// Get pixel value via [row], [col], returns a view of native data
  ///
  /// Note: No bound check under **release** mode
  List<num> atPixel(int row, int col) {
    assert(0 <= row && row < rows, "row must be less than $rows");
    assert(0 <= col && col < cols, "col must be less than $cols");

    switch (type.depth) {
      case MatType.CV_8U:
        return ptrAt<U8>(row, col).asTypedList(channels);
      case MatType.CV_8S:
        return ptrAt<I8>(row, col).asTypedList(channels);
      case MatType.CV_16U:
        return ptrAt<U16>(row, col).asTypedList(channels);
      case MatType.CV_16S:
        return ptrAt<I16>(row, col).asTypedList(channels);
      case MatType.CV_32S:
        return ptrAt<I32>(row, col).asTypedList(channels);
      case MatType.CV_32F:
        return ptrAt<F32>(row, col).asTypedList(channels);
      case MatType.CV_64F:
        return ptrAt<F64>(row, col).asTypedList(channels);
      // TODO: support CV_16F
      // case MatType.CV_16F:
      //   return ptrAt<U16>(row, col).asTypedList(channels).map(float16).toList(growable: false);
      case _:
        throw UnsupportedError("Unsupported type: ${type.asString()}");
    }
  }

  T atVec<T>(int row, int col) {
    // Vec2b, Vec3b, Vec4b
    if (T == Vec2b) {
      final p = calloc<cvg.Vec2b>();
      cvRun(() => ccore.Mat_GetVec2b(ref, row, col, p));
      return Vec2b.fromPointer(p) as T;
    } else if (T == Vec3b) {
      final p = calloc<cvg.Vec3b>();
      cvRun(() => ccore.Mat_GetVec3b(ref, row, col, p));
      return Vec3b.fromPointer(p) as T;
    } else if (T == Vec4b) {
      final p = calloc<cvg.Vec4b>();
      cvRun(() => ccore.Mat_GetVec4b(ref, row, col, p));
      return Vec4b.fromPointer(p) as T;
    }
    // Vec2w, Vec3w, Vec4w
    else if (T == Vec2w) {
      final p = calloc<cvg.Vec2w>();
      cvRun(() => ccore.Mat_GetVec2w(ref, row, col, p));
      return Vec2w.fromPointer(p) as T;
    } else if (T == Vec3w) {
      final p = calloc<cvg.Vec3w>();
      cvRun(() => ccore.Mat_GetVec3w(ref, row, col, p));
      return Vec3w.fromPointer(p) as T;
    } else if (T == Vec4w) {
      final p = calloc<cvg.Vec4w>();
      cvRun(() => ccore.Mat_GetVec4w(ref, row, col, p));
      return Vec4w.fromPointer(p) as T;
    }
    // Vec2s, Vec3s, Vec4s
    else if (T == Vec2s) {
      final p = calloc<cvg.Vec2s>();
      cvRun(() => ccore.Mat_GetVec2s(ref, row, col, p));
      return Vec2s.fromPointer(p) as T;
    } else if (T == Vec3s) {
      final p = calloc<cvg.Vec3s>();
      cvRun(() => ccore.Mat_GetVec3s(ref, row, col, p));
      return Vec3s.fromPointer(p) as T;
    } else if (T == Vec4s) {
      final p = calloc<cvg.Vec4s>();
      cvRun(() => ccore.Mat_GetVec4s(ref, row, col, p));
      return Vec4s.fromPointer(p) as T;
    }
    // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
    else if (T == Vec2i) {
      final p = calloc<cvg.Vec2i>();
      cvRun(() => ccore.Mat_GetVec2i(ref, row, col, p));
      return Vec2i.fromPointer(p) as T;
    } else if (T == Vec3i) {
      final p = calloc<cvg.Vec3i>();
      cvRun(() => ccore.Mat_GetVec3i(ref, row, col, p));
      return Vec3i.fromPointer(p) as T;
    } else if (T == Vec4i) {
      final p = calloc<cvg.Vec4i>();
      cvRun(() => ccore.Mat_GetVec4i(ref, row, col, p));
      return Vec4i.fromPointer(p) as T;
    } else if (T == Vec6i) {
      final p = calloc<cvg.Vec6i>();
      cvRun(() => ccore.Mat_GetVec6i(ref, row, col, p));
      return Vec6i.fromPointer(p) as T;
    } else if (T == Vec8i) {
      final p = calloc<cvg.Vec8i>();
      cvRun(() => ccore.Mat_GetVec8i(ref, row, col, p));
      return Vec8i.fromPointer(p) as T;
    }
    // Vec2f, Vec3f, Vec4f, Vec6f
    else if (T == Vec2f) {
      final p = calloc<cvg.Vec2f>();
      cvRun(() => ccore.Mat_GetVec2f(ref, row, col, p));
      return Vec2f.fromPointer(p) as T;
    } else if (T == Vec3f) {
      final p = calloc<cvg.Vec3f>();
      cvRun(() => ccore.Mat_GetVec3f(ref, row, col, p));
      return Vec3f.fromPointer(p) as T;
    } else if (T == Vec4f) {
      final p = calloc<cvg.Vec4f>();
      cvRun(() => ccore.Mat_GetVec4f(ref, row, col, p));
      return Vec4f.fromPointer(p) as T;
    } else if (T == Vec6f) {
      final p = calloc<cvg.Vec6f>();
      cvRun(() => ccore.Mat_GetVec6f(ref, row, col, p));
      return Vec6f.fromPointer(p) as T;
    }
    // Vec2d, Vec3d, Vec4d, Vec6d
    else if (T == Vec2d) {
      final p = calloc<cvg.Vec2d>();
      cvRun(() => ccore.Mat_GetVec2d(ref, row, col, p));
      return Vec2d.fromPointer(p) as T;
    } else if (T == Vec3d) {
      final p = calloc<cvg.Vec3d>();
      cvRun(() => ccore.Mat_GetVec3d(ref, row, col, p));
      return Vec3d.fromPointer(p) as T;
    } else if (T == Vec4d) {
      final p = calloc<cvg.Vec4d>();
      cvRun(() => ccore.Mat_GetVec4d(ref, row, col, p));
      return Vec4d.fromPointer(p) as T;
    } else if (T == Vec6d) {
      final p = calloc<cvg.Vec6d>();
      cvRun(() => ccore.Mat_GetVec6d(ref, row, col, p));
      return Vec6d.fromPointer(p) as T;
    } else {
      throw UnsupportedError("at<$T>() for ${type.asString()} is not supported!");
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
  T at<T>(int i0, int i1, [int? i2]) {
    if (T == int || T == double || T == num) {
      return atNum(i0, i1, i2) as T;
    } else if (isSubtype<T, CvVec>()) {
      return atVec<T>(i0, i1);
    } else {
      throw UnsupportedError("T must be num or CvVec(e.g., Vec3b), but got $T");
    }
  }

  //!SECTION At

  //SECTION - Set
  void setVec<T extends CvVec>(int row, int col, T val) {
    switch (val) {
      // Vec2b, Vec3b, Vec4b
      case Vec2b():
        cvRun(() => ccore.Mat_SetVec2b(ref, row, col, val.ref));
      case Vec3b():
        cvRun(() => ccore.Mat_SetVec3b(ref, row, col, val.ref));
      case Vec4b():
        cvRun(() => ccore.Mat_SetVec4b(ref, row, col, val.ref));
      // Vec2w, Vec3w, Vec4w
      case Vec2w():
        cvRun(() => ccore.Mat_SetVec2w(ref, row, col, val.ref));
      case Vec3w():
        cvRun(() => ccore.Mat_SetVec3w(ref, row, col, val.ref));
      case Vec4w():
        cvRun(() => ccore.Mat_SetVec4w(ref, row, col, val.ref));
      // Vec2s, Vec3s, Vec4s
      case Vec2s():
        cvRun(() => ccore.Mat_SetVec2s(ref, row, col, val.ref));
      case Vec3s():
        cvRun(() => ccore.Mat_SetVec3s(ref, row, col, val.ref));
      case Vec4s():
        cvRun(() => ccore.Mat_SetVec4s(ref, row, col, val.ref));
      // Vec2i, Vec3i, Vec4i, Vec6i, Vec8i
      case Vec2i():
        cvRun(() => ccore.Mat_SetVec2i(ref, row, col, val.ref));
      case Vec3i():
        cvRun(() => ccore.Mat_SetVec3i(ref, row, col, val.ref));
      case Vec4i():
        cvRun(() => ccore.Mat_SetVec4i(ref, row, col, val.ref));
      case Vec6i():
        cvRun(() => ccore.Mat_SetVec6i(ref, row, col, val.ref));
      case Vec8i():
        cvRun(() => ccore.Mat_SetVec8i(ref, row, col, val.ref));
      // Vec2f, Vec3f, Vec4f, Vec6f
      case Vec2f():
        cvRun(() => ccore.Mat_SetVec2f(ref, row, col, val.ref));
      case Vec3f():
        cvRun(() => ccore.Mat_SetVec3f(ref, row, col, val.ref));
      case Vec4f():
        cvRun(() => ccore.Mat_SetVec4f(ref, row, col, val.ref));
      case Vec6f():
        cvRun(() => ccore.Mat_SetVec6f(ref, row, col, val.ref));
      // Vec2d, Vec3d, Vec4d, Vec6d
      case Vec2d():
        cvRun(() => ccore.Mat_SetVec2d(ref, row, col, val.ref));
      case Vec3d():
        cvRun(() => ccore.Mat_SetVec3d(ref, row, col, val.ref));
      case Vec4d():
        cvRun(() => ccore.Mat_SetVec4d(ref, row, col, val.ref));
      case Vec6d():
        cvRun(() => ccore.Mat_SetVec6d(ref, row, col, val.ref));
      default:
        throw UnsupportedError("setVec<$T>() for ${type.asString()} is not supported!");
    }
  }

  void setNum(int i0, int i1, num val, [int? i2]) {
    switch (type.depth) {
      case MatType.CV_8U:
        i2 == null ? (ptrAt<U8>(i0) + i1).value = val.toInt() : ptrAt<U8>(i0, i1, i2).value = val.toInt();
      case MatType.CV_8S:
        i2 == null ? (ptrAt<I8>(i0) + i1).value = val.toInt() : ptrAt<I8>(i0, i1, i2).value = val.toInt();
      case MatType.CV_16U:
        i2 == null ? (ptrAt<U16>(i0) + i1).value = val.toInt() : ptrAt<U16>(i0, i1, i2).value = val.toInt();
      case MatType.CV_16S:
        i2 == null ? (ptrAt<I16>(i0) + i1).value = val.toInt() : ptrAt<I16>(i0, i1, i2).value = val.toInt();
      case MatType.CV_32S:
        i2 == null ? (ptrAt<I32>(i0) + i1).value = val.toInt() : ptrAt<I32>(i0, i1, i2).value = val.toInt();
      case MatType.CV_32F:
        i2 == null
            ? (ptrAt<F32>(i0) + i1).value = val.toDouble()
            : ptrAt<F32>(i0, i1, i2).value = val.toDouble();
      case MatType.CV_64F:
        i2 == null
            ? (ptrAt<F64>(i0) + i1).value = val.toDouble()
            : ptrAt<F64>(i0, i1, i2).value = val.toDouble();
      case MatType.CV_16F:
        i2 == null
            ? (ptrAt<U16>(i0) + i1).value = val.toDouble().fp16
            : ptrAt<U16>(i0, i1, i2).value = val.toDouble().fp16;
      case _:
        throw UnsupportedError("Unsupported type: ${type.asString()}");
    }
  }

  /// equivalent to Mat::at\<T\>(i0, i1, i2) = val;
  /// where T might be int, double, or cv::Vec<> like cv::Vec3b
  ///
  /// example
  /// ```dart
  /// var m = cv.Mat.fromScalar(cv.Scalar(2, 4, 1, 0), cv.MatType.CV_32FC3);
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(2, 4, 1)
  /// m.set<cv.Vec3f>(0, 0, cv.Vec3f(9, 9, 9));
  /// m.at<cv.Vec3f>(0, 0); // cv.Vec3f(9, 9, 9)
  /// ```
  void set<T>(int i0, int i1, T val, [int? i2]) {
    switch (val) {
      case num():
        setNum(i0, i1, val, i2);
      case CvVec():
        setVec<CvVec>(i0, i1, val);
      default:
        throw UnsupportedError("Unsupported type ${val.runtimeType}");
    }
  }

  // https://github.com/dart-lang/sdk/issues/43390#issuecomment-690993957
  bool isSubtype<S, T>() => <S>[] is List<T>;

  //!SECTION Set

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
    final step = this.step;

    ffi.Pointer<U8> pp = dataPtr + i0 * step.$1;
    if (i1 != null) {
      pp += i1 * step.$2;
      if (i2 != null) pp += i2 * step.$3;
    }
    return pp.cast<T>();
  }

  List<num> _ptrAsTypedList(ffi.Pointer<U8> p, int count, int depth) {
    switch (depth) {
      case MatType.CV_8U:
        return p.cast<U8>().asTypedList(count);
      case MatType.CV_8S:
        return p.cast<I8>().asTypedList(count);
      case MatType.CV_16U:
        return p.cast<U16>().asTypedList(count);
      case MatType.CV_16S:
        return p.cast<I16>().asTypedList(count);
      case MatType.CV_32S:
        return p.cast<I32>().asTypedList(count);
      case MatType.CV_32F:
        return p.cast<F32>().asTypedList(count);
      case MatType.CV_64F:
        return p.cast<F64>().asTypedList(count);
      // TODO: for now, dart has no `Float16` type, so this will create a new list, which
      // is different from the above
      // case MatType.CV_16F:
      //   callback(pp.cast<U16>().asTypedList(count).map(float16).toList(growable: false));
      case _:
        throw UnsupportedError("Unsupported type: ${type.asString()}");
    }
  }

  /// Iterate over all pixels in the Mat.
  ///
  /// [callback] is called for each pixel in the Mat, the parameter `pixel`
  /// of [callback] is a view of the pixel at every (row, col), which means
  /// it can be modified and will be reflected in the Mat.
  ///
  /// Example:
  /// ```dart
  /// final mat = cv.Mat.ones(3, 3, cv.MatType.CV_8UC3);
  /// mat.forEachPixel((row, col, pixel) {
  ///   print(pixel); // [1, 1, 1]
  ///   pixel[0] = 2;
  /// });
  /// print(mat.atPixel(0, 0)); // [2, 1, 1]
  /// ```
  void forEachPixel(void Function(int row, int col, List<num> pixel) callback) {
    // cache necessary props, they will be only get once
    final depth = type.depth, pdata = dataPtr, step = this.step, channels = this.channels;
    final rows = this.rows, cols = this.cols;

    for (int row = 0; row < rows; row++) {
      for (int col = 0; col < cols; col++) {
        final pp = pdata + row * step.$1 + col * step.$2;
        callback(row, col, _ptrAsTypedList(pp, channels, depth));
      }
    }
  }

  /// Iterate over all rows in the Mat.
  ///
  /// Similar to [forEachPixel], the parameter `values` of [callback] is a view of
  /// the row at every `row`, which means it can be modified and the original values
  /// in the Mat will be changed too.
  void forEachRow(void Function(int row, List<num> values) callback) {
    // cache necessary props, they will be only get once
    final depth = type.depth, pdata = dataPtr, step = this.step, channels = this.channels;
    final rows = this.rows, cols = this.cols;

    for (int row = 0; row < rows; row++) {
      final pp = pdata + row * step.$1;
      callback(row, _ptrAsTypedList(pp, channels * cols, depth));
    }
  }

  // TODO: for now, dart do not support operator overloading
  // https://github.com/dart-lang/language/issues/2456
  // waiting for it's implementation and add more methods
  // operator +(int v) {
  //   ccore.Mat_AddUChar(ref, v);
  // }

  Mat _opInt(
    int val,
    ffi.Pointer<cvg.CvStatus> Function(cvg.Mat, int val) func, {
    bool inplace = false,
  }) {
    if (inplace) {
      cvRun(() => func(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => func(dst.ref, val));
      return dst;
    }
  }

  Mat _opDouble(
    double val,
    ffi.Pointer<cvg.CvStatus> Function(cvg.Mat, double val) func, {
    bool inplace = false,
  }) {
    if (inplace) {
      cvRun(() => func(ref, val));
      return this;
    } else {
      final dst = clone();
      cvRun(() => func(dst.ref, val));
      return dst;
    }
  }

  Mat _opMat(
    Mat other,
    ffi.Pointer<cvg.CvStatus> Function(cvg.Mat, cvg.Mat) func, {
    bool inplace = false,
  }) {
    assert(other.type == type, "${type.asString()} != ${other.type.asString()}");
    if (inplace) {
      cvRun(() => func(ref, other.ref));
      return this;
    } else {
      final dst = clone();
      cvRun(() => func(dst.ref, other.ref));
      return dst;
    }
  }

  //SECTION - Add

  /// add
  Mat add<T>(T val, {bool inplace = false}) {
    return switch (val) {
      Mat() => addMat(val as Mat, inplace: inplace),
      int() => switch (type.depth) {
          MatType.CV_8U => addU8(val as int, inplace: inplace),
          MatType.CV_8S => addI8(val as int, inplace: inplace),
          MatType.CV_16U => addU16(val as int, inplace: inplace),
          MatType.CV_16S => addI16(val as int, inplace: inplace),
          MatType.CV_32S => addI32(val as int, inplace: inplace),
          _ => throw UnsupportedError("add int to ${type.asString()} is not supported!"),
        },
      double() => switch (type.depth) {
          MatType.CV_32F => addF32(val as double, inplace: inplace),
          MatType.CV_64F => addF64(val as double, inplace: inplace),
          // MatType.CV_16F => addF16(val as double, inplace: inplace), // TODO
          _ => throw UnsupportedError("add double to ${type.asString()} is not supported!"),
        },
      _ => throw UnsupportedError("Type $T is not supported"),
    };
  }

  Mat addMat(Mat other, {bool inplace = false}) => _opMat(other, ccore.Mat_AddMat, inplace: inplace);

  Mat addU8(int val, {bool inplace = false}) {
    // no bound check in release mode
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    return _opInt(val, ccore.Mat_AddUChar, inplace: inplace);
  }

  Mat addI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    return _opInt(val, ccore.Mat_AddSChar, inplace: inplace);
  }

  Mat addI16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16S && val >= CV_I16_MIN && val <= CV_I16_MAX);
    return _opInt(val, ccore.Mat_AddI16, inplace: inplace);
  }

  Mat addU16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16U && val >= CV_U16_MIN && val <= CV_U16_MAX);
    return _opInt(val, ccore.Mat_AddU16, inplace: inplace);
  }

  Mat addI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
    return _opInt(val, ccore.Mat_AddI32, inplace: inplace);
  }

  Mat addF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
    return _opDouble(val, ccore.Mat_AddFloat, inplace: inplace);
  }

  Mat addF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
    return _opDouble(val, ccore.Mat_AddF64, inplace: inplace);
  }

  // TODO - addF16

  //!SECTION ADD

  //SECTION - Subtract

  /// subtract
  Mat subtract<T>(T val, {bool inplace = false}) {
    return switch (val) {
      Mat() => subtractMat(val as Mat, inplace: inplace),
      int() => switch (type.depth) {
          MatType.CV_8U => subtractU8(val as int, inplace: inplace),
          MatType.CV_8S => subtractI8(val as int, inplace: inplace),
          MatType.CV_16U => subtractU16(val as int, inplace: inplace),
          MatType.CV_16S => subtractI16(val as int, inplace: inplace),
          MatType.CV_32S => subtractI32(val as int, inplace: inplace),
          _ => throw UnsupportedError("subtract int to ${type.asString()} is not supported!"),
        },
      double() => switch (type.depth) {
          MatType.CV_32F => subtractF32(val as double, inplace: inplace),
          MatType.CV_64F => subtractF64(val as double, inplace: inplace),
          // MatType.CV_16F => subtractF16(val as double, inplace: inplace), // TODO
          _ => throw UnsupportedError("subtract double to ${type.asString()} is not supported!"),
        },
      _ => throw UnsupportedError("Type $T is not supported"),
    };
  }

  Mat subtractMat(Mat other, {bool inplace = false}) =>
      _opMat(other, ccore.Mat_SubtractMat, inplace: inplace);

  Mat subtractU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    return _opInt(val, ccore.Mat_SubtractUChar, inplace: inplace);
  }

  Mat subtractI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    return _opInt(val, ccore.Mat_SubtractSChar, inplace: inplace);
  }

  Mat subtractI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
    return _opInt(val, ccore.Mat_SubtractI32, inplace: inplace);
  }

  Mat subtractI16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16S && val >= CV_I16_MIN && val <= CV_I16_MAX);
    return _opInt(val, ccore.Mat_SubtractI16, inplace: inplace);
  }

  Mat subtractU16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16U && val >= CV_U16_MIN && val <= CV_U16_MAX);
    return _opInt(val, ccore.Mat_SubtractU16, inplace: inplace);
  }

  Mat subtractF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
    return _opDouble(val, ccore.Mat_SubtractFloat, inplace: inplace);
  }

  Mat subtractF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
    return _opDouble(val, ccore.Mat_SubtractF64, inplace: inplace);
  }

  // TODO - subtractF16

  //!SECTION - Subtract

  //SECTION - multiply
  /// Multiply
  ///
  /// Note: `multiply<Mat>` is a wrapper for `Mat &operator*=(Mat &a, const Mat &b)`
  Mat multiply<T>(T val, {bool inplace = false}) {
    return switch (val) {
      Mat() => multiplyMat(val as Mat, inplace: inplace),
      int() => switch (type.depth) {
          MatType.CV_8U => multiplyU8(val as int, inplace: inplace),
          MatType.CV_8S => multiplyI8(val as int, inplace: inplace),
          MatType.CV_16U => multiplyU16(val as int, inplace: inplace),
          MatType.CV_16S => multiplyI16(val as int, inplace: inplace),
          MatType.CV_32S => multiplyI32(val as int, inplace: inplace),
          _ => throw UnsupportedError("multiply int to ${type.asString()} is not supported!"),
        },
      double() => switch (type.depth) {
          MatType.CV_32F => multiplyF32(val as double, inplace: inplace),
          MatType.CV_64F => multiplyF64(val as double, inplace: inplace),
          // MatType.CV_16F => multiplyF16(val as double, inplace: inplace), // TODO
          _ => throw UnsupportedError("multiply double to ${type.asString()} is not supported!"),
        },
      _ => throw UnsupportedError("Type $T is not supported"),
    };
  }

  /// Matrix multiplication
  ///
  /// Wrapper for `Mat &operator*=(Mat &a, const Mat &b)`
  Mat multiplyMat(Mat other, {bool inplace = false}) =>
      _opMat(other, ccore.Mat_MultiplyMat, inplace: inplace);

  Mat multiplyU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    return _opInt(val, ccore.Mat_MultiplyUChar, inplace: inplace);
  }

  Mat multiplyI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    return _opInt(val, ccore.Mat_MultiplySChar, inplace: inplace);
  }

  Mat multiplyI16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16S && val >= CV_I16_MIN && val <= CV_I16_MAX);
    return _opInt(val, ccore.Mat_MultiplyI16, inplace: inplace);
  }

  Mat multiplyU16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16U && val >= CV_U16_MIN && val <= CV_U16_MAX);
    return _opInt(val, ccore.Mat_MultiplyU16, inplace: inplace);
  }

  Mat multiplyI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
    return _opInt(val, ccore.Mat_MultiplyI32, inplace: inplace);
  }

  Mat multiplyF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
    return _opDouble(val, ccore.Mat_MultiplyFloat, inplace: inplace);
  }

  Mat multiplyF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
    return _opDouble(val, ccore.Mat_MultiplyF64, inplace: inplace);
  }

  // TODO - multiplyF16

  //!SECTION - multiply

  //SECTION - divide
  /// divide
  Mat divide<T>(T val, {bool inplace = false}) {
    return switch (val) {
      Mat() => divideMat(val as Mat, inplace: inplace),
      int() => switch (type.depth) {
          MatType.CV_8U => divideU8(val as int, inplace: inplace),
          MatType.CV_8S => divideI8(val as int, inplace: inplace),
          MatType.CV_16U => divideU16(val as int, inplace: inplace),
          MatType.CV_16S => divideI16(val as int, inplace: inplace),
          MatType.CV_32S => divideI32(val as int, inplace: inplace),
          _ => throw UnsupportedError("divide int to ${type.asString()} is not supported!"),
        },
      double() => switch (type.depth) {
          MatType.CV_32F => divideF32(val as double, inplace: inplace),
          MatType.CV_64F => divideF64(val as double, inplace: inplace),
          // MatType.CV_16F => divideF16(val as double, inplace: inplace), // TODO
          _ => throw UnsupportedError("divide double to ${type.asString()} is not supported!"),
        },
      _ => throw UnsupportedError("Type $T is not supported"),
    };
  }

  Mat divideMat(Mat other, {bool inplace = false}) => _opMat(other, ccore.Mat_DivideMat, inplace: inplace);

  Mat divideU8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8U && val >= CV_U8_MIN && val <= CV_U8_MAX);
    return _opInt(val, ccore.Mat_DivideUChar, inplace: inplace);
  }

  Mat divideI8(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_8S && val >= CV_I8_MIN && val <= CV_I8_MAX);
    return _opInt(val, ccore.Mat_DivideSChar, inplace: inplace);
  }

  Mat divideI16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16S && val >= CV_I16_MIN && val <= CV_I16_MAX);
    return _opInt(val, ccore.Mat_DivideI16, inplace: inplace);
  }

  Mat divideU16(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_16U && val >= CV_U16_MIN && val <= CV_U16_MAX);
    return _opInt(val, ccore.Mat_DivideU16, inplace: inplace);
  }

  Mat divideI32(int val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32S && val >= CV_I32_MIN && val <= CV_I32_MAX);
    return _opInt(val, ccore.Mat_DivideI32, inplace: inplace);
  }

  Mat divideF32(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_32F && val <= CV_F32_MAX);
    return _opDouble(val, ccore.Mat_DivideFloat, inplace: inplace);
  }

  Mat divideF64(double val, {bool inplace = false}) {
    assert(type.depth == MatType.CV_64F && val <= CV_F64_MAX);
    return _opDouble(val, ccore.Mat_DivideF64, inplace: inplace);
  }

  // TODO - divideF16
  //!SECTION - divide

  /// Creates a matrix header for the specified matrix column.
  ///
  /// The method makes a new header for the specified matrix column and returns it.
  /// This is an O(1) operation, regardless of the matrix size. The underlying data of
  /// the new matrix is shared with the original matrix. See also the Mat::row description.
  ///
  /// [x]	A 0-based column index.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a23df02a07ffbfa4aa59c19bc003919fe
  Mat col(int x) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Col(ref, x, p));
    return Mat._(p);
  }

  /// Creates a matrix header for the specified matrix row.
  ///
  /// The method makes a new header for the specified matrix row and returns it.
  /// This is an O(1) operation, regardless of the matrix size. The underlying data
  /// of the new matrix is shared with the original matrix. Here is the example of
  /// one of the classical basic matrix processing operations, axpy, used by LU
  /// and many other algorithms:
  ///
  /// ```cpp
  /// inline void matrix_axpy(Mat& A, int i, int j, double alpha)
  /// {
  ///     A.row(i) += A.row(j)*alpha;
  /// }
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a4b22e1c23af7a7f2eef8fa478cfa7434
  Mat row(int y) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Row(ref, y, p));
    return Mat._(p);
  }

  Mat transpose({bool inplace = false}) {
    final dst = inplace ? this : Mat.empty();
    cvRun(() => ccore.Mat_Transpose(ref, dst.ref));
    return dst;
  }

  Mat clone() {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Clone(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Copies the matrix to another one.
  ///
  /// The method copies the matrix data to another matrix. Before copying the data,
  /// the method invokes :
  ///
  /// ```cpp
  /// m.create(this->size(), this->type());
  /// ```
  ///
  /// so that the destination matrix is reallocated if needed. While m.copyTo(m);
  /// works flawlessly, the function does not handle the case of a partial overlap
  /// between the source and the destination matrices.
  ///
  /// When the operation mask is specified, if the Mat::create call shown above
  /// reallocates the matrix, the newly allocated matrix is initialized with all
  /// zeros before copying the data.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a33fd5d125b4c302b0c9aa86980791a77
  void copyTo(Mat dst, {Mat? mask}) => mask == null
      ? cvRun(() => ccore.Mat_CopyTo(ref, dst.ref))
      : cvRun(() => ccore.Mat_CopyToWithMask(ref, dst.ref, mask.ref));

  @Deprecated("use copyTo instead")
  void copyToWithMask(Mat dst, Mat mask) {
    cvRun(() => ccore.Mat_CopyToWithMask(ref, dst.ref, mask.ref));
  }

  /// Converts an array to another data type with optional scaling.
  ///
  /// The method converts source pixel values to the target data type.
  /// saturate_cast<> is applied at the end to avoid possible overflows:
  ///
  /// $m(x,y) = saturate \_ cast<rType>( \alpha (*this)(x,y) +  \beta )$
  ///
  /// Parameters
  ///     [type]	desired output matrix type or, rather, the depth since the number of channels are the same as the input has; if rtype is negative, the output matrix will have the same type as the input.
  ///     [alpha]	optional scale factor.
  ///     [beta]	optional delta added to the scaled values.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#adf88c60c5b4980e05bb556080916978b
  Mat convertTo(MatType type, {double alpha = 1, double beta = 0}) {
    final dst = Mat.empty();
    cvRun(() => ccore.Mat_ConvertToWithParams(ref, dst.ref, type.value, alpha, beta));
    return dst;
  }

  /// Performs an element-wise multiplication or division of the two matrices.
  ///
  /// The method returns a temporary object encoding per-element array multiplication,
  /// with optional scale. Note that this is not a matrix multiplication that corresponds to
  /// a simpler "\*" operator.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a385c09827713dc3e6d713bfad8460706
  Mat mul(Mat other, {bool inplace = false, double scale = 1.0}) {
    final p = inplace ? ptr : calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Mul(ref, other.ref, p, scale));
    return inplace ? this : Mat._(p);
  }

  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#aa7ec97373406215f2d4bc72cc1d27036
  Mat region(Rect rect) {
    cvAssert(rect.right <= width && rect.bottom <= height);
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Region(ref, rect.ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Changes the shape and/or the number of channels of a 2D matrix without copying the data.
  ///
  /// The method makes a new matrix header for *this elements. The new matrix may have a
  /// different size and/or different number of channels. Any combination is possible if:
  ///
  /// - No extra elements are included into the new matrix and no elements are excluded.
  /// Consequently, the product rows*cols*channels() must stay the same after the transformation.
  /// - No data is copied. That is, this is an O(1) operation. Consequently, if you change
  /// the number of rows, or the operation changes the indices of elements row in some
  /// other way, the matrix must be continuous. See Mat::isContinuous .
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a4eb96e3251417fa88b78e2abd6cfd7d8
  Mat reshape(int cn, [int rows = 0]) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Reshape(ref, cn, rows, p));
    final dst = Mat._(p);
    return dst;
  }

  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#ab2e41a510891e548f744832cf9b8ab89
  Mat reshapeTo(int cn, List<int> newshape) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_ReshapeByVec(ref, cn, newshape.i32.ref, p));
    return Mat._(p);
  }

  Mat rotate(int rotationCode, {bool inplace = false}) {
    if (inplace) {
      cvRun(() => ccore.Rotate(ref, ref, rotationCode));
      return this;
    } else {
      final dst = clone();
      cvRun(() => ccore.Rotate(ref, dst.ref, rotationCode));
      return dst;
    }
  }

  /// Creates a matrix header for the specified row span.
  ///
  /// The method makes a new header for the specified row span of the matrix.
  /// Similarly to Mat::row and Mat::col , this is an O(1) operation.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#aa6542193430356ad631a9beabc624107
  Mat rowRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_rowRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Creates a matrix header for the specified column span.
  ///
  /// The method makes a new header for the specified column span of the matrix.
  /// Similarly to Mat::row and Mat::col , this is an O(1) operation.
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#aadc8f9210fe4dec50513746c246fa8d9
  Mat colRange(int start, int end) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_colRange(ref, start, end, p));
    final dst = Mat._(p);
    return dst;
  }

  @Deprecated("Use convertTo instead")
  Mat convertToFp16() {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_ConvertFp16(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  Scalar mean({Mat? mask}) {
    final s = calloc<cvg.Scalar>();
    mask == null
        ? cvRun(() => ccore.Mat_Mean(ref, s))
        : cvRun(() => ccore.Mat_MeanWithMask(ref, mask.ref, s));
    return Scalar.fromPointer(s);
  }

  /// Calculates standard deviation, per channel.
  ///
  /// [Scalar] order is same as [Mat], i.e., BGR -> BGR
  Scalar stdDev() {
    final mean = calloc<cvg.Scalar>();
    final sd = calloc<cvg.Scalar>();
    cvRun(() => ccore.Mat_MeanStdDev(ref, mean, sd));
    return Scalar.fromPointer(sd);
  }

  /// Similar to [stdDev]
  Scalar variance() => stdDev().pow(2);

  /// Calculates a square root of array elements.
  Mat sqrt() {
    cvAssert(type.depth == MatType.CV_32F || type.depth == MatType.CV_64F);
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_Sqrt(ref, p));
    final dst = Mat._(p);
    return dst;
  }

  /// Sum calculates the per-channel pixel sum of an image.
  Scalar sum() {
    final s = calloc<cvg.Scalar>();
    cvRun(() => ccore.Mat_Sum(ref, s));
    return Scalar.fromPointer(s);
  }

  /// PatchNaNs converts NaN's to zeros.
  void patchNaNs({double val = 0}) => cvRun(() => ccore.Mat_PatchNaNs(ref, val));

  /// Sets all or some of the array elements to the specified value.
  ///
  /// This is an advanced variant of the Mat::operator=(const Scalar& s) operator.
  ///
  /// [value]	Assigned scalar converted to the actual array type.
  /// [mask]	Operation mask of the same size as *this. Its non-zero elements
  /// indicate which matrix elements need to be copied. The mask has to be of
  /// type CV_8U and can have 1 or multiple channels
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#a030678ffd9ca6e12127b3fd1337bf6e2
  Mat setTo(Scalar value, {Mat? mask}) {
    mask ??= Mat.empty();
    cvRun(() => ccore.Mat_SetTo(ref, value.ref, mask!.ref));
    return this;
  }

  /// Transposes a matrix.
  ///
  /// The method performs matrix transposition by means of matrix expressions.
  /// It does not perform the actual transposition but returns a temporary matrix
  /// transposition object that can be further used as a part of more complex matrix
  /// expressions or can be assigned to a matrix:
  ///
  /// https://docs.opencv.org/4.x/d3/d63/classcv_1_1Mat.html#aaa428c60ccb6d8ea5de18f63dfac8e11
  Mat t() {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.Mat_T(ref, p));
    return Mat._(p);
  }

  /// This Method converts single-channel Mat to 2D List
  List<List<num>> toList() {
    final ret = <List<num>>[];
    forEachRow((r, v) => ret.add(v));
    return ret;
  }

  /// Returns a 3D list of the mat, only for multi-channel mats.
  /// The list is ordered as [row][col][channels].
  ///
  /// Example:
  /// ```dart
  /// final mat = Mat.fromList(3, 3, MatType.CV_8UC1, [0, 1, 2, 3, 4, 5, 6, 7, 8]);
  /// final list = mat.toList3D();
  /// print(list); // [[[0, 1, 2], [3, 4, 5], [6, 7, 8]]]
  /// ```
  List<List<List<num>>> toList3D() {
    cvAssert(channels >= 2, "toList3D() only for channels >= 2, but this.channels=$channels");
    final rows = this.rows, cols = this.cols;
    return List.generate(rows, (r) => List.generate(cols, (c) => atPixel(r, c)));
  }

  String toFmtString({
    int fmtType = FMT_NUMPY,
    int f16Precision = 4,
    int f32Precision = 8,
    int f64Precision = 16,
    bool multiLine = true,
  }) {
    final p = calloc<ffi.Pointer<ffi.Char>>();
    cvRun(() => ccore.Mat_toString(ref, fmtType, f16Precision, f32Precision, f64Precision, multiLine, p));
    final rval = p.value.toDartString();
    calloc.free(p);
    return rval;
  }

  @override
  String toString() => toFmtString();

  static final finalizer = OcvFinalizer<cvg.MatPtr>(ccore.addresses.Mat_Close);

  @Deprecated("NOT recommended, call [dispose] instead")
  void release() => cvRun(() => ccore.Mat_Release(ptr));

  void dispose() {
    finalizer.detach(this);
    ccore.Mat_Close(ptr);
  }

  @override
  cvg.Mat get ref => ptr.ref;

  static const int FMT_DEFAULT = 0;
  static const int FMT_MATLAB = 1;
  static const int FMT_CSV = 2;
  static const int FMT_PYTHON = 3;
  static const int FMT_NUMPY = 4;
  static const int FMT_C = 5;
}

typedef OutputArray = Mat;
typedef InputArray = OutputArray;
typedef InputOutputArray = Mat;

class VecMat extends Vec<cvg.VecMat, Mat> {
  VecMat.fromPointer(super.ptr, [bool attach = true]) : super.fromPointer() {
    if (attach) {
      Vec.finalizer.attach(this, ptr.cast<ffi.Void>(), detach: this);
      Vec.finalizer.attach(this, ptr.ref.ptr.cast<ffi.Void>(), detach: this);
    }
  }

  factory VecMat.fromList(List<Mat> mats) => VecMat.generate(mats.length, (i) => mats[i], dispose: false);

  factory VecMat.generate(int length, Mat Function(int i) generator, {bool dispose = true}) {
    final pp = calloc<cvg.VecMat>()..ref.length = length;
    pp.ref.ptr = calloc<cvg.Mat>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
      if (dispose) v.dispose();
    }
    return VecMat.fromPointer(pp);
  }

  @override
  VecMat clone() => VecMat.generate(length, (idx) => this[idx], dispose: false);

  @override
  int get length => ref.length;

  @override
  Iterator<Mat> get iterator => VecMatIterator(ref);

  @override
  cvg.VecMat get ref => ptr.ref;

  @override
  void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  ffi.Pointer<ffi.Void> asVoid() => ref.ptr.cast<ffi.Void>();

  @override
  void reattach({ffi.Pointer<cvg.VecMat>? newPtr}) {
    super.reattach(newPtr: newPtr);
    Vec.finalizer.attach(this, ref.ptr.cast<ffi.Void>(), detach: this);
  }

  @override
  void operator []=(int idx, Mat value) => throw UnsupportedError("VecMat is read-only");
}

class VecMatIterator extends VecIterator<Mat> {
  VecMatIterator(this.ref);
  cvg.VecMat ref;

  @override
  int get length => ref.length;

  @override
  Mat operator [](int idx) => Mat.fromPointer(ref.ptr + idx, false);
}

extension ListMatExtension on List<Mat> {
  VecMat get cvd => VecMat.fromList(this);
  VecMat asVecMat() => VecMat.fromList(this);
}

// Completers for async
void matCompleter(Completer<Mat> completer, VoidPtr p) =>
    completer.complete(Mat.fromPointer(p.cast<cvg.Mat>()));
void matCompleter2(Completer<(Mat, Mat)> completer, VoidPtr p, VoidPtr p1) =>
    completer.complete((Mat.fromPointer(p.cast<cvg.Mat>()), Mat.fromPointer(p1.cast<cvg.Mat>())));
void matCompleter3(Completer<(Mat, Mat, Mat)> completer, VoidPtr p, VoidPtr p1, VoidPtr p2) =>
    completer.complete(
      (
        Mat.fromPointer(p.cast<cvg.Mat>()),
        Mat.fromPointer(p1.cast<cvg.Mat>()),
        Mat.fromPointer(p2.cast<cvg.Mat>())
      ),
    );
