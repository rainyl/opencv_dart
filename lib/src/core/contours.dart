import 'dart:collection';
import 'dart:ffi' as ffi;

import 'base.dart';
import '../opencv.g.dart' as cvg;
import 'point.dart';

final _bindings = cvg.CvNative(loadNativeLibrary());

// class Contour with IterableMixin<Point> {
//   Contour._(this._ptr) {
//     finalizer.attach(this, _ptr);
//   }
//   factory Contour.fromPointer(cvg.PointVector pts) {
//     return Contour._(pts);
//   }
//   factory Contour.fromList(List<Point> pts) {
//     final vec = _bindings.PointVector_New();
//     for (var i = 0; i < pts.length; i++) {
//       _bindings.PointVector_Append(vec, pts[i].toNative());
//     }
//     return Contour._(vec);
//   }

//   cvg.PointVector _ptr;
//   cvg.PointVector get ptr => _ptr;
//   static final finalizer = Finalizer<cvg.PointVector>((p0) {
//     _bindings.PointVector_Close(p0);
//   });

//   int get length => _bindings.PointVector_Size(_ptr);

//   Point operator [](int idx) {
//     final p = _bindings.PointVector_At(_ptr, idx);
//     return Point.fromNative(p);
//   }

//   @override
//   Iterator<Point> get iterator => ContourIterator(_ptr);

//   @override
//   String toString() {
//     return "Contour(length=$length, address=0x${ptr.address})";
//   }
// }

// class ContourIterator implements Iterator<Point> {
//   ContourIterator(this._ptr);

//   int get length => _bindings.PointVector_Size(_ptr);
//   int currentIndex = 0;

//   Point operator [](int idx) {
//     final p = _bindings.PointVector_At(_ptr, idx);
//     return Point.fromNative(p);
//   }

//   final cvg.PointVector _ptr;

//   @override
//   Point get current {
//     if (currentIndex < length) {
//       return this[currentIndex];
//     }
//     throw IndexError.withLength(currentIndex, length);
//   }

//   @override
//   bool moveNext() {
//     currentIndex++;
//     return currentIndex < length;
//   }
// }

class Contours with IterableMixin<List<Point>> implements ffi.Finalizable {
  Contours._(this._ptr) {
    finalizer.attach(this, _ptr);
  }
  factory Contours.fromPointer(cvg.PointsVector pts) {
    return Contours._(pts);
  }
  factory Contours.fromList(List<List<Point>> pts) {
    final vec = _bindings.PointsVector_New();
    for (var i = 0; i < pts.length; i++) {
      _bindings.PointsVector_Append(vec, pts[i].toNativeVecotr());
    }
    return Contours._(vec);
  }

  cvg.PointsVector _ptr;
  cvg.PointsVector get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.PointsVector_Close);

  int get length => _bindings.PointsVector_Size(_ptr);

  List<Point> operator [](int idx) {
    final pv = _bindings.PointsVector_At(_ptr, idx);
    return List.generate(
      _bindings.PointVector_Size(pv),
      (index) => Point.fromNative(_bindings.PointVector_At(pv, index)),
    );
  }

  @override
  Iterator<List<Point>> get iterator => ContoursIterator(_ptr);

  @override
  String toString() {
    return "Contours(length=$length, address=0x${ptr.address})";
  }
}

class ContoursIterator implements Iterator<List<Point>> {
  ContoursIterator(this._ptr);

  int get length => _bindings.PointsVector_Size(_ptr);
  int currentIndex = 0;

  List<Point> operator [](int idx) {
    final pv = _bindings.PointsVector_At(_ptr, idx);
    return List.generate(
      _bindings.PointVector_Size(pv),
      (index) => Point.fromNative(_bindings.PointVector_At(pv, index)),
    );
  }

  final cvg.PointsVector _ptr;

  @override
  List<Point> get current {
    if (currentIndex < length) {
      return this[currentIndex];
    }
    throw IndexError.withLength(currentIndex, length);
  }

  @override
  bool moveNext() {
    currentIndex++;
    return currentIndex < length;
  }
}

class Contours2f with IterableMixin<List<Point2f>> implements ffi.Finalizable {
  Contours2f._(this._ptr) {
    finalizer.attach(this, _ptr);
  }
  factory Contours2f.fromPointer(cvg.Points2fVector pts) {
    return Contours2f._(pts);
  }
  factory Contours2f.fromList(List<List<Point2f>> pts) {
    final vec = _bindings.Points2fVector_New();
    for (var i = 0; i < pts.length; i++) {
      _bindings.Points2fVector_Append(vec, pts[i].toNativeVecotr());
    }
    return Contours2f._(vec);
  }

  cvg.Points2fVector _ptr;
  cvg.Points2fVector get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Points2fVector_Close);

  int get length => _bindings.Points2fVector_Size(_ptr);

  List<Point2f> operator [](int idx) {
    final pv = _bindings.Points2fVector_At(_ptr, idx);
    return List.generate(
      _bindings.Point2fVector_Size(pv),
      (index) => Point2f.fromNative(_bindings.Point2fVector_At(pv, index)),
    );
  }

  @override
  Iterator<List<Point2f>> get iterator => Contours2fIterator(_ptr);

  @override
  String toString() {
    return "Contours2f(length=$length, address=0x${ptr.address})";
  }
}

class Contours2fIterator implements Iterator<List<Point2f>> {
  Contours2fIterator(this._ptr);

  int get length => _bindings.Points2fVector_Size(_ptr);
  int currentIndex = 0;

  List<Point2f> operator [](int idx) {
    final pv = _bindings.Points2fVector_At(_ptr, idx);
    return List.generate(
      _bindings.Point2fVector_Size(pv),
      (index) => Point2f.fromNative(_bindings.Point2fVector_At(pv, index)),
    );
  }

  final cvg.Points2fVector _ptr;

  @override
  List<Point2f> get current {
    if (currentIndex < length) {
      return this[currentIndex];
    }
    throw IndexError.withLength(currentIndex, length);
  }

  @override
  bool moveNext() {
    currentIndex++;
    return currentIndex < length;
  }
}

class Contours3f with IterableMixin<List<Point3f>> implements ffi.Finalizable {
  Contours3f._(this._ptr) {
    finalizer.attach(this, _ptr);
  }
  factory Contours3f.fromPointer(cvg.Points3fVector pts) {
    return Contours3f._(pts);
  }
  factory Contours3f.fromList(List<List<Point3f>> pts) {
    final vec = _bindings.Points3fVector_New();
    for (var i = 0; i < pts.length; i++) {
      _bindings.Points3fVector_Append(vec, pts[i].toNativeVecotr());
    }
    return Contours3f._(vec);
  }

  cvg.Points3fVector _ptr;
  cvg.Points3fVector get ptr => _ptr;
  static final finalizer = ffi.NativeFinalizer(_bindings.addresses.Points3fVector_Close);

  int get length => _bindings.Points3fVector_Size(_ptr);

  List<Point3f> operator [](int idx) {
    final pv = _bindings.Points3fVector_At(_ptr, idx);
    return List.generate(
      _bindings.Point3fVector_Size(pv),
      (index) => Point3f.fromNative(_bindings.Point3fVector_At(pv, index)),
    );
  }

  @override
  Iterator<List<Point3f>> get iterator => Contours3fIterator(_ptr);

  @override
  String toString() {
    return "Contours3f(length=$length, address=0x${ptr.address})";
  }
}

class Contours3fIterator implements Iterator<List<Point3f>> {
  Contours3fIterator(this._ptr);

  int get length => _bindings.Points3fVector_Size(_ptr);
  int currentIndex = 0;

  List<Point3f> operator [](int idx) {
    final pv = _bindings.Points3fVector_At(_ptr, idx);
    return List.generate(
      _bindings.Point3fVector_Size(pv),
      (index) => Point3f.fromNative(_bindings.Point3fVector_At(pv, index)),
    );
  }

  final cvg.Points3fVector _ptr;

  @override
  List<Point3f> get current {
    if (currentIndex < length) {
      return this[currentIndex];
    }
    throw IndexError.withLength(currentIndex, length);
  }

  @override
  bool moveNext() {
    currentIndex++;
    return currentIndex < length;
  }
}
