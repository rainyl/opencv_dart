// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/constants.g.dart';
import '../g/types.g.dart' as cvg;
import '../native_lib.dart' show ccore;
import 'base.dart';
import 'mat.dart';
import 'mat_type.dart';
import 'rect.dart';
import 'scalar.dart';
import 'vec.dart';

/// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#a25ac687266568c8b024debd187c15b9b
class UMat extends CvStruct<cvg.UMat> {
  UMat._(cvg.UMatPtr ptr, {bool attach = true, int? externalSize}) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this, externalSize: externalSize);
    }
  }

  static final finalizer = OcvFinalizer<cvg.UMatPtr>(ccore.addresses.cv_UMat_close);

  /// construct from pointer directly
  factory UMat.fromPointer(cvg.UMatPtr mat, {bool attach = true, int? externalSize}) =>
      UMat._(mat, attach: attach, externalSize: externalSize);

  /// create an empty [UMat]
  factory UMat.empty({UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT}) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_1(flags.value, p));
    return UMat._(p);
  }

  /// constructs 2D matrix and fills it with the specified value.
  ///
  ///```c++
  /// UMat(int rows, int cols, int type, UMatUsageFlags usageFlags = USAGE_DEFAULT);
  /// UMat(int rows, int cols, int type, const Scalar& s, UMatUsageFlags usageFlags = USAGE_DEFAULT);
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#a5e1866c206e9c116304a0257bc3a6c50
  factory UMat.create({
    int rows = 0,
    int cols = 0,
    int r = 0,
    int g = 0,
    int b = 0,
    MatType? type,
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    if (rows == 0 && cols == 0) {
      return UMat.empty(flags: flags);
    }

    type = type ?? MatType.CV_8UC3;
    final scalar = Scalar(b.toDouble(), g.toDouble(), r.toDouble(), 0);
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_3(rows, cols, type!.value, scalar.ref, flags.value, p));
    return UMat._(p);
  }

  /// constructs n-dimensional matrix
  /// ```c++
  /// UMat(int ndims, const int* sizes, int type, UMatUsageFlags usageFlags = USAGE_DEFAULT);
  /// UMat(int ndims, const int* sizes, int type, const Scalar& s, UMatUsageFlags usageFlags = USAGE_DEFAULT);
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#af159e956ff96c64745c6940a3b1820ba
  factory UMat.nd(
    List<int> sizes,
    MatType type, {
    Scalar? s,
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    final cSizes = calloc<ffi.Int>(sizes.length);
    cSizes.cast<ffi.Int32>().asTypedList(sizes.length).setAll(0, sizes);
    cvRun(
      () => s == null
          ? ccore.cv_UMat_create_4(sizes.length, cSizes, type.value, flags.value, p)
          : ccore.cv_UMat_create_5(sizes.length, cSizes, type.value, s.ref, flags.value, p),
    );
    calloc.free(cSizes);
    return UMat._(p);
  }

  /// copy constructor
  factory UMat.fromUMat(UMat umat) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_6(umat.ref, p));
    return UMat._(p);
  }

  /// creates a matrix header for a part of the bigger matrix
  ///
  /// ```c++
  /// UMat(const UMat& m, const Range& rowRange, const Range& colRange=Range::all());
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#afeaabd3e9eef98ccef422a81176a4250
  factory UMat.fromRange(UMat umat, {int rowStart = 0, int? rowEnd, int colStart = 0, int? colEnd}) {
    final p = calloc<cvg.UMat>();
    rowEnd ??= umat.rows;
    colEnd ??= umat.cols;
    cvRun(() => ccore.cv_UMat_create_7(umat.ref, rowStart, rowEnd!, colStart, colEnd!, p));
    return UMat._(p);
  }

  /// ```c++
  /// UMat(const UMat& m, const Rect& roi);
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#aaa3fa04bb82fee6026cc2e85df96a796
  factory UMat.fromRect(UMat umat, Rect roi) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_9(umat.ref, roi.ref, p));
    return UMat._(p);
  }

  factory UMat.zeros({
    int rows = 0,
    int cols = 0,
    MatType type = MatType.CV_8UC1,
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_zeros(rows, cols, type.value, flags.value, p));
    return UMat._(p);
  }

  factory UMat.zerosND(
    List<int> sizes,
    MatType type, {
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    final cSizes = calloc<ffi.Int>(sizes.length);
    cSizes.cast<ffi.Int32>().asTypedList(sizes.length).setAll(0, sizes);
    cvRun(() => ccore.cv_UMat_create_zeros_1(sizes.length, cSizes, type.value, flags.value, p));
    calloc.free(cSizes);
    return UMat._(p);
  }

  factory UMat.ones(
    int rows,
    int cols,
    MatType type, {
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_ones(rows, cols, type.value, flags.value, p));
    return UMat._(p);
  }

  factory UMat.onesND(
    List<int> sizes,
    MatType type, {
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    final cSizes = calloc<ffi.Int>(sizes.length);
    cSizes.cast<ffi.Int32>().asTypedList(sizes.length).setAll(0, sizes);
    cvRun(() => ccore.cv_UMat_create_ones_1(sizes.length, cSizes, type.value, flags.value, p));
    calloc.free(cSizes);
    return UMat._(p);
  }

  factory UMat.eye({
    int rows = 0,
    int cols = 0,
    MatType type = MatType.CV_8UC1,
    UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT,
  }) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_eye(rows, cols, type.value, flags.value, p));
    return UMat._(p);
  }

  factory UMat.diag(UMat umat, {UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT}) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_create_diag(umat.ref, flags.value, p));
    return UMat._(p);
  }

  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#a3d84c72c06ddd55d35b87c3d222d2674
  Mat getMat(AccessFlag accessFlags) {
    final p = calloc<cvg.Mat>();
    cvRun(() => ccore.cv_UMat_getMat(ref, accessFlags.value, p, ffi.nullptr));
    return Mat.fromPointer(p);
  }

  /// returns a new matrix header for the specified row
  UMat row(int i) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_row(ref, i, p, ffi.nullptr));
    return UMat._(p);
  }

  /// returns a new matrix header for the specified column
  UMat col(int i) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_col(ref, i, p, ffi.nullptr));
    return UMat._(p);
  }

  /// .. for the specified row span
  UMat rowRange(int start, int end) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_rowRange(ref, start, end, p, ffi.nullptr));
    return UMat._(p);
  }

  /// ... for the specified column span
  UMat colRange(int start, int end) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_colRange(ref, start, end, p, ffi.nullptr));
    return UMat._(p);
  }

  /// ... for the specified diagonal
  /// (d=0 - the main diagonal,
  ///  >0 - a diagonal from the upper half,
  ///  <0 - a diagonal from the lower half)
  UMat diag({int d = 0}) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_diag(ref, d, p, ffi.nullptr));
    return UMat._(p);
  }

  /// returns deep copy of the matrix, i.e. the data is copied
  UMat clone() {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_clone(ref, p, ffi.nullptr));
    return UMat._(p);
  }

  /// copies those matrix elements to "m" that are marked with non-zero mask elements.
  //
  //  It calls m.create(this->size(), this->type()).
  void copyTo(UMat dst, {UMat? mask}) {
    cvRun(
      () => mask == null
          ? ccore.cv_UMat_copyTo(ref, dst.ref, ffi.nullptr)
          : ccore.cv_UMat_copyTo_2(ref, mask.ref, dst.ref, ffi.nullptr),
    );
  }

  /// converts matrix to another datatype with optional scaling.
  UMat convertTo(MatType type, {UMat? dst, double alpha = 1, double beta = 0}) {
    dst ??= UMat.empty();
    cvRun(() => ccore.cv_UMat_convertTo(ref, type.value, alpha, beta, dst!.ref, ffi.nullptr));
    return dst;
  }

  /// sets some of the matrix elements to s, according to the mask
  void setTo(Scalar value, {UMat? mask}) {
    mask ??= UMat.empty();
    cvRun(() => ccore.cv_UMat_setTo(ref, value.ref, mask!.ref, ffi.nullptr));
  }

  /// creates alternative matrix header for the same data, with different
  /// number of channels and/or different number of rows. see cvReshape.
  /// ```c++
  /// UMat reshape(int cn, int rows=0) const;
  /// UMat reshape(int cn, int newndims, const int* newsz) const;
  /// ```
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#a25ac687266568c8b024debd187c15b9b
  UMat reshape(int cn, {int? rows, List<int>? newSizes}) {
    final p = calloc<cvg.UMat>();
    if (newSizes == null) {
      cvRun(() => ccore.cv_UMat_reshape(ref, cn, rows ?? 0, p, ffi.nullptr));
    } else {
      final cNewSizes = calloc<ffi.Int>(newSizes.length);
      cNewSizes.cast<ffi.Int32>().asTypedList(newSizes.length).setAll(0, newSizes);
      cvRun(() => ccore.cv_UMat_reshape_2(ref, cn, newSizes.length, cNewSizes, p, ffi.nullptr));
      calloc.free(cNewSizes);
    }
    return UMat._(p);
  }

  /// matrix transposition by means of matrix expressions
  UMat t() {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_t(ref, p, ffi.nullptr));
    return UMat._(p);
  }

  /// matrix inversion by means of matrix expressions
  UMat inv({int method = DECOMP_LU}) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_inv(ref, method, p, ffi.nullptr));
    return UMat._(p);
  }

  /// per-element matrix multiplication by means of matrix expressions
  UMat mul(UMat m, {double alpha = 1}) {
    final p = calloc<cvg.UMat>();
    cvRun(() => ccore.cv_UMat_mul(ref, m.ref, alpha, p, ffi.nullptr));
    return UMat._(p);
  }

  /// computes dot-product
  double dot(UMat m) {
    final p = calloc<ffi.Double>();
    cvRun(() => ccore.cv_UMat_dot(ref, m.ref, p, ffi.nullptr));
    final rval = p.value;
    calloc.free(p);
    return rval;
  }

  /// allocates new matrix data unless the matrix already has specified size and type.
  ///
  /// https://docs.opencv.org/4.x/d7/d45/classcv_1_1UMat.html#afe3063b40dd6c5d8a0054759c1142631
  void create(List<int> sizes, MatType type, {UMatUsageFlags flags = UMatUsageFlags.USAGE_DEFAULT}) {
    final cSizes = calloc<ffi.Int>(sizes.length);
    cSizes.cast<ffi.Int32>().asTypedList(sizes.length).setAll(0, sizes);
    cvRun(() => ccore.cv_UMat_createFunc_2(ref, sizes.length, cSizes, type.value, flags.value, ffi.nullptr));
    calloc.free(cSizes);
  }

  /// decreases reference counter;
  void release() => ccore.cv_UMat_release(ref);

  /// deallocates the matrix data
  void deallocate() => ccore.cv_UMat_deallocate(ref);

  /// increases the reference counter; use with care to avoid memleaks
  void addref() => ccore.cv_UMat_addref(ref);

  ffi.Pointer<ffi.Void> handle(AccessFlag flag) => ccore.cv_UMat_handle(ref, flag.value);

  /// returns true iff the matrix data is continuous
  bool get isContinuous => ccore.cv_UMat_isContinuous(ref);

  /// returns true if the matrix is a submatrix of another matrix
  bool get isSubmatrix => ccore.cv_UMat_isSubmatrix(ref);

  /// returns element size in bytes,
  int get elemSize => ccore.cv_UMat_elemSize(ref);

  ///returns the size of element channel in bytes.
  int get elemSize1 => ccore.cv_UMat_elemSize1(ref);

  /// returns element type, similar to CV_MAT_TYPE(cvmat->type)
  MatType get type => MatType(ccore.cv_UMat_type(ref));

  /// returns element type, similar to CV_MAT_DEPTH(cvmat->type)
  int get depth => ccore.cv_UMat_depth(ref);

  /// returns element type, similar to CV_MAT_CN(cvmat->type)
  int get channels => ccore.cv_UMat_channels(ref);

  /// returns step/elemSize1()
  int step1([int i = 0]) => ccore.cv_UMat_step1(ref, i);

  /// returns true if matrix data is NULL
  bool get empty => ccore.cv_UMat_empty(ref);

  /// returns true if matrix data is NULL
  bool get isEmpty => ccore.cv_UMat_empty(ref);

  /// returns the total number of matrix elements
  int get total => ccore.cv_UMat_total(ref);

  /// returns N if the matrix is 1-channel (N x ptdim) or ptdim-channel (1 x N) or (N x 1); negative number otherwise
  int checkVector(int elemChannels, {int depth = -1, bool requireContinuous = true}) =>
      ccore.cv_UMat_checkVector(ref, elemChannels, depth, requireContinuous);

  /// includes several bit-fields:
  ///   - the magic signature
  ///   - continuity flag
  ///   - depth
  ///   - number of channels
  int get flags => ccore.cv_UMat_flags(ref);

  /// the matrix dimensionality, >= 2
  int get dims => ccore.cv_UMat_dims(ref);

  /// number of rows in the matrix; -1 when the matrix has more than 2 dimensions
  int get rows => ccore.cv_UMat_rows(ref);

  /// number of columns in the matrix; -1 when the matrix has more than 2 dimensions
  int get cols => ccore.cv_UMat_cols(ref);

  /// usage flags for allocator; recommend do not set directly, instead set during construct/create/getUMat
  int get usageFlags => ccore.cv_UMat_usageFlags(ref);

  /// offset of the submatrix (or 0)
  int get offset => ccore.cv_UMat_offset(ref);

  /// number of bytes each matrix element/row/plane/dimension occupies
  (int, int, int) get step {
    final ms = ccore.cv_UMat_step(ref);
    return (ms.p[0], ms.p[1], ms.p[2]);
  }

  /// dimensional size of the matrix; accessible in various formats
  VecI32 get size => VecI32.fromPointer(ccore.cv_UMat_size(ref));

  @override
  cvg.UMat get ref => ptr.ref;

  void dispose() {
    finalizer.detach(this);
    ccore.cv_UMat_close(ptr);
  }

  @override
  String toString() => "UMat(addr=0x${ptr.address.toRadixString(16)}, "
      "type=${type.asString()}, rows=$rows, cols=$cols, channels=$channels)";

  static const int MAGIC_VAL = 0x42FF0000;
  static const int AUTO_STEP = 0;
  static const int CONTINUOUS_FLAG = CV_MAT_CONT_FLAG;
  static const int SUBMATRIX_FLAG = CV_SUBMAT_FLAG;

  static const int MAGIC_MASK = 0xFFFF0000;
  static const int TYPE_MASK = 0x00000FFF;
  static const int DEPTH_MASK = 7;
}

enum UMatUsageFlags {
  USAGE_DEFAULT(0),

  // buffer allocation policy is platform and usage specific
  USAGE_ALLOCATE_HOST_MEMORY(1 << 0), // 1
  USAGE_ALLOCATE_DEVICE_MEMORY(1 << 1), // 2

  /// It is not equal to: USAGE_ALLOCATE_HOST_MEMORY | USAGE_ALLOCATE_DEVICE_MEMORY
  USAGE_ALLOCATE_SHARED_MEMORY(1 << 2); // 4

  final int value;

  const UMatUsageFlags(this.value);

  static UMatUsageFlags fromValue(int value) => switch (value) {
        0 => USAGE_DEFAULT,
        1 => USAGE_ALLOCATE_HOST_MEMORY,
        2 => USAGE_ALLOCATE_DEVICE_MEMORY,
        4 => USAGE_ALLOCATE_SHARED_MEMORY,
        _ => throw ArgumentError('Unknown value for UMatUsageFlags: $value'),
      };
}

enum AccessFlag {
  ACCESS_READ(1 << 24), // 0x1000000
  ACCESS_WRITE(1 << 25), // 0x2000000
  ACCESS_RW(3 << 24), // 0x3000000
  ACCESS_MASK(3 << 24), // 0x3000000
  ACCESS_FAST(1 << 26); // 0x4000000

  final int value;

  const AccessFlag(this.value);

  static AccessFlag fromValue(int value) => switch (value) {
        0x1000000 => ACCESS_READ,
        0x2000000 => ACCESS_WRITE,
        0x3000000 => ACCESS_RW,
        0x4000000 => ACCESS_FAST,
        _ => throw ArgumentError('Unknown value for AccessFlag: $value'),
      };
}
