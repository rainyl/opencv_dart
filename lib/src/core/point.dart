import 'dart:async';
import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../g/types.g.dart' as cvg;
import 'base.dart';
import 'vec.dart';

class Point extends CvStruct<cvg.Point> {
  Point._(ffi.Pointer<cvg.Point> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point(int x, int y) {
    final ptr = calloc<cvg.Point>()
      ..ref.x = x
      ..ref.y = y;
    return Point._(ptr);
  }
  factory Point.fromNative(cvg.Point p) => Point(p.x, p.y);
  factory Point.fromPointer(ffi.Pointer<cvg.Point> ptr, [bool attach = true]) => Point._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ref.x;
  int get y => ref.y;

  @override
  cvg.Point get ref => ptr.ref;
  @override
  String toString() => 'Point($x, $y)';
  @override
  List<int> get props => [x, y];
}

class Point2f extends CvStruct<cvg.Point2f> {
  Point2f._(ffi.Pointer<cvg.Point2f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point2f(double x, double y) {
    final ptr = calloc<cvg.Point2f>()
      ..ref.x = x
      ..ref.y = y;
    return Point2f._(ptr);
  }
  factory Point2f.fromNative(cvg.Point2f p) => Point2f(p.x, p.y);
  factory Point2f.fromPointer(ffi.Pointer<cvg.Point2f> ptr, [bool attach = true]) => Point2f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  double get y => ptr.ref.y;

  @override
  cvg.Point2f get ref => ptr.ref;
  @override
  String toString() => 'Point2f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y];
}

class Point3f extends CvStruct<cvg.Point3f> {
  Point3f._(ffi.Pointer<cvg.Point3f> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point3f(double x, double y, double z) {
    final ptr = calloc<cvg.Point3f>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3f._(ptr);
  }
  factory Point3f.fromNative(cvg.Point3f p) => Point3f(p.x, p.y, p.z);
  factory Point3f.fromPointer(ffi.Pointer<cvg.Point3f> ptr, [bool attach = true]) => Point3f._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  double get x => ptr.ref.x;
  double get y => ptr.ref.y;
  double get z => ptr.ref.z;

  @override
  cvg.Point3f get ref => ptr.ref;
  @override
  String toString() => 'Point3f(${x.toStringAsFixed(3)}, ${y.toStringAsFixed(3)}, ${z.toStringAsFixed(3)})';
  @override
  List<double> get props => [x, y, z];
}

class Point3i extends CvStruct<cvg.Point3i> {
  Point3i._(ffi.Pointer<cvg.Point3i> ptr, [bool attach = true]) : super.fromPointer(ptr) {
    if (attach) {
      finalizer.attach(this, ptr.cast(), detach: this);
    }
  }
  factory Point3i(int x, int y, int z) {
    final ptr = calloc<cvg.Point3i>()
      ..ref.x = x
      ..ref.y = y
      ..ref.z = z;
    return Point3i._(ptr);
  }
  factory Point3i.fromNative(cvg.Point3i p) => Point3i(p.x, p.y, p.z);
  factory Point3i.fromPointer(ffi.Pointer<cvg.Point3i> ptr, [bool attach = true]) => Point3i._(ptr, attach);

  static final finalizer = ffi.NativeFinalizer(calloc.nativeFree);

  void dispose() {
    finalizer.detach(this);
    calloc.free(ptr);
  }

  int get x => ptr.ref.x;
  int get y => ptr.ref.y;
  int get z => ptr.ref.z;

  @override
  cvg.Point3i get ref => ptr.ref;
  @override
  String toString() => 'Point3i($x, $y, $z)';
  @override
  List<int> get props => [x, y, z];
}

class VecPoint extends Vec<cvg.VecPoint, Point> {
  VecPoint.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecPoint([int length = 0, int x = 0, int y = 0]) => VecPoint.generate(length, (i) => Point(x, y));

  factory VecPoint.fromList(List<Point> pts) => VecPoint.generate(pts.length, (i) => pts[i]);

  factory VecPoint.generate(int length, Point Function(int i) generator) {
    // final p = calloc<cvg.Point>(length);
    final pp = malloc<cvg.VecPoint>()..ref.length = length;
    pp.ref.ptr = malloc<cvg.Point>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      pp.ref.ptr[i] = v.ref;
    }
    // ..ref.length = length
    // ..ref.ptr = p;
    return VecPoint.fromPointer(pp);
  }

  factory VecPoint.fromVec(cvg.VecPoint ref) {
    final p = calloc<cvg.VecPoint>()..ref = ref;
    return VecPoint.fromPointer(p);
  }

  @override
  int get length => ref.length;

@override
   void dispose() {
    Vec.finalizer.detach(this);
    calloc.free(ptr.ref.ptr);
    calloc.free(ptr);
  }

  @override
  Iterator<Point> get iterator => VecPointIterator(ref);

  @override
  cvg.VecPoint get ref => ptr.ref;
}

class VecPointIterator extends VecIterator<Point> {
  VecPointIterator(this.ref);
  cvg.VecPoint ref;

  @override
  int get length => ref.length;

  @override
  Point operator [](int idx) => Point.fromNative(ref.ptr[idx]);
}

class VecPoint2f extends Vec<cvg.VecPoint2f, Point2f> {
  VecPoint2f.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecPoint2f([int length = 0, double x = 0, double y = 0]) =>
      VecPoint2f.generate(length, (i) => Point2f(x, y));

  factory VecPoint2f.fromList(List<Point2f> pts) => VecPoint2f.generate(pts.length, (i) => pts[i]);

  factory VecPoint2f.generate(int length, Point2f Function(int i) generator) {
    final p = calloc<cvg.Point2f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecPoint2f>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecPoint2f.fromPointer(pp);
  }

  factory VecPoint2f.fromVec(cvg.VecPoint2f ref) {
    final p = calloc<cvg.VecPoint2f>()..ref = ref;
    return VecPoint2f.fromPointer(p);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<Point2f> get iterator => VecPoint2fIterator(ref);

  @override
  cvg.VecPoint2f get ref => ptr.ref;
}

class VecPoint2fIterator extends VecIterator<Point2f> {
  VecPoint2fIterator(this.ref);
  cvg.VecPoint2f ref;

  @override
  int get length => ref.length;

  @override
  Point2f operator [](int idx) => Point2f.fromNative(ref.ptr[idx]);
}

class VecPoint3f extends Vec<cvg.VecPoint3f, Point3f> implements CvStruct<cvg.VecPoint3f> {
  VecPoint3f.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecPoint3f([int length = 0, double x = 0, double y = 0, double z = 0]) =>
      VecPoint3f.generate(length, (i) => Point3f(x, y, z));

  factory VecPoint3f.fromList(List<Point3f> pts) => VecPoint3f.generate(pts.length, (i) => pts[i]);

  factory VecPoint3f.generate(int length, Point3f Function(int i) generator) {
    final p = calloc<cvg.Point3f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecPoint3f>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecPoint3f.fromPointer(pp);
  }

  factory VecPoint3f.fromVec(cvg.VecPoint3f ref) {
    final p = calloc<cvg.VecPoint3f>()..ref = ref;
    return VecPoint3f.fromPointer(p);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<Point3f> get iterator => VecPoint3fIterator(ref);

  @override
  cvg.VecPoint3f get ref => ptr.ref;
}

class VecPoint3fIterator extends VecIterator<Point3f> {
  VecPoint3fIterator(this.ref);
  cvg.VecPoint3f ref;

  @override
  int get length => ref.length;

  @override
  Point3f operator [](int idx) => Point3f.fromNative(ref.ptr[idx]);
}

class VecPoint3i extends Vec<cvg.VecPoint3i, Point3i> implements CvStruct<cvg.VecPoint3i> {
  VecPoint3i.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();

  factory VecPoint3i([int length = 0, int x = 0, int y = 0, int z = 0]) =>
      VecPoint3i.generate(length, (i) => Point3i(x, y, z));

  factory VecPoint3i.fromList(List<Point3i> pts) => VecPoint3i.generate(pts.length, (i) => pts[i]);

  factory VecPoint3i.generate(int length, Point3i Function(int i) generator) {
    final p = calloc<cvg.Point3i>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecPoint3i>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecPoint3i.fromPointer(pp);
  }

  factory VecPoint3i.fromVec(cvg.VecPoint3i ref) {
    final p = calloc<cvg.VecPoint3i>()..ref = ref;
    return VecPoint3i.fromPointer(p);
  }

  @override
  int get length => ref.length;

  @override
  Iterator<Point3i> get iterator => VecPoint3iIterator(ref);

  @override
  cvg.VecPoint3i get ref => ptr.ref;
}

class VecPoint3iIterator extends VecIterator<Point3i> {
  VecPoint3iIterator(this.ref);
  cvg.VecPoint3i ref;

  @override
  int get length => ref.length;

  @override
  Point3i operator [](int idx) => Point3i.fromNative(ref.ptr[idx]);
}

// VecVecPoint
class VecVecPoint extends Vec<cvg.VecVecPoint, VecPoint> implements CvStruct<cvg.VecVecPoint> {
  VecVecPoint.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecVecPoint.fromVec(cvg.VecVecPoint ref) {
    final p = calloc<cvg.VecVecPoint>()..ref = ref;
    return VecVecPoint.fromPointer(p);
  }

  factory VecVecPoint.fromVecPoint(VecPoint v) => VecVecPoint.generate(1, (i) => v);

  factory VecVecPoint.fromList(List<List<Point>> pts) => VecVecPoint.generate(pts.length, (i) => pts[i].cvd);

  factory VecVecPoint.generate(int length, VecPoint Function(int i) generator) {
    final p = calloc<cvg.VecPoint>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecVecPoint>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecVecPoint.fromPointer(pp);
  }

  @override
  Iterator<VecPoint> get iterator => VecVecPointIterator(ref);

  @override
  cvg.VecVecPoint get ref => ptr.ref;
}

class VecVecPointIterator extends VecIterator<VecPoint> {
  VecVecPointIterator(this.ref);
  cvg.VecVecPoint ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint operator [](int idx) => VecPoint.fromVec(ref.ptr[idx]);
}

class VecVecPoint2f extends Vec<cvg.VecVecPoint2f, VecPoint2f> implements CvStruct<cvg.VecVecPoint2f> {
  VecVecPoint2f.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecVecPoint2f.fromVec(cvg.VecVecPoint2f ref) {
    final p = calloc<cvg.VecVecPoint2f>()..ref = ref;
    return VecVecPoint2f.fromPointer(p);
  }

  factory VecVecPoint2f.fromVecPoint(VecPoint2f v) => VecVecPoint2f.generate(1, (i) => v);

  factory VecVecPoint2f.fromList(List<List<Point2f>> pts) =>
      VecVecPoint2f.generate(pts.length, (i) => pts[i].cvd);

  factory VecVecPoint2f.generate(int length, VecPoint2f Function(int i) generator) {
    final p = calloc<cvg.VecPoint2f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecVecPoint2f>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecVecPoint2f.fromPointer(pp);
  }

  @override
  Iterator<VecPoint2f> get iterator => VecVecPoint2fIterator(ref);

  @override
  cvg.VecVecPoint2f get ref => ptr.ref;
}

class VecVecPoint2fIterator extends VecIterator<VecPoint2f> {
  VecVecPoint2fIterator(this.ref);
  cvg.VecVecPoint2f ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint2f operator [](int idx) => VecPoint2f.fromVec(ref.ptr[idx]);
}

class VecVecPoint3f extends Vec<cvg.VecVecPoint3f, VecPoint3f> implements CvStruct<cvg.VecVecPoint3f> {
  VecVecPoint3f.fromPointer(super.ptr, [super.attach = true]) : super.fromPointer();
  factory VecVecPoint3f.fromVec(cvg.VecVecPoint3f ref) {
    final p = calloc<cvg.VecVecPoint3f>()..ref = ref;
    return VecVecPoint3f.fromPointer(p);
  }

  factory VecVecPoint3f.fromVecPoint(VecPoint3f v) => VecVecPoint3f.generate(1, (i) => v);

  factory VecVecPoint3f.fromList(List<List<Point3f>> pts) =>
      VecVecPoint3f.generate(pts.length, (i) => pts[i].cvd);

  factory VecVecPoint3f.generate(int length, VecPoint3f Function(int i) generator) {
    final p = calloc<cvg.VecPoint3f>(length);
    for (var i = 0; i < length; i++) {
      final v = generator(i);
      p[i] = v.ref;
    }
    final pp = calloc<cvg.VecVecPoint3f>()
      ..ref.length = length
      ..ref.ptr = p;
    return VecVecPoint3f.fromPointer(pp);
  }

  @override
  Iterator<VecPoint3f> get iterator => VecVecPoint3fIterator(ref);

  @override
  cvg.VecVecPoint3f get ref => ptr.ref;
}

class VecVecPoint3fIterator extends VecIterator<VecPoint3f> {
  VecVecPoint3fIterator(this.ref);
  cvg.VecVecPoint3f ref;

  @override
  int get length => ref.length;

  /// return the reference
  @override
  VecPoint3f operator [](int idx) => VecPoint3f.fromVec(ref.ptr[idx]);
}

extension ListPointExtension on List<Point> {
  VecPoint get cvd => VecPoint.fromList(this);
}

extension ListPoint2fExtension on List<Point2f> {
  VecPoint2f get cvd => VecPoint2f.fromList(this);
}

extension ListPoint3fExtension on List<Point3f> {
  VecPoint3f get cvd => VecPoint3f.fromList(this);
}

extension ListPoint3iExtension on List<Point3i> {
  VecPoint3i get cvd => VecPoint3i.fromList(this);
}

extension ListListPointExtension on List<List<Point>> {
  VecVecPoint get cvd => VecVecPoint.fromList(this);
}

extension VecPointExtension on VecPoint {
  VecVecPoint get toVecVecPoint => VecVecPoint.fromVecPoint(this);
}

extension ListListPoint2fExtension on List<List<Point2f>> {
  VecVecPoint2f get cvd => VecVecPoint2f.fromList(this);
}

extension ListListPoint3fExtension on List<List<Point3f>> {
  VecVecPoint3f get cvd => VecVecPoint3f.fromList(this);
}

extension PointRecordExtension on (int x, int y) {
  Point get asPoint => Point(this.$1, this.$2);
}

extension Point2fRecordExtension on (double x, double y) {
  Point2f get asPoint2f => Point2f(this.$1, this.$2);
}

extension Point3fRecordExtension on (double x, double y, double z) {
  Point3f get asPoint3f => Point3f(this.$1, this.$2, this.$3);
}

// completers
void vecPointCompleter(Completer<VecPoint> completer, VoidPtr p) =>
    completer.complete(VecPoint.fromPointer(p.cast<cvg.VecPoint>()));

void vecPoint2fCompleter(Completer<VecPoint2f> completer, VoidPtr p) =>
    completer.complete(VecPoint2f.fromPointer(p.cast<cvg.VecPoint2f>()));
