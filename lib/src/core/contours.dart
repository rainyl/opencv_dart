import 'dart:collection';

import 'base.dart';
import '../opencv.g.dart' as cvg;
import 'point.dart';

final _bindings = cvg.CvNative(loadNativeLibrary());

class Contours with IterableMixin<List<Point>> {
  Contours._(this._ptr) {
    _finalizer.attach(this, _ptr);
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
  static final _finalizer = Finalizer<cvg.PointsVector>((p0) {
    _bindings.PointsVector_Close(p0);
  });

  int get length => _bindings.PointsVector_Size(_ptr);
  // int currentIndex = 0;

  List<Point> operator [](int idx) {
    final pv = _bindings.PointsVector_At(_ptr, idx);
    return List.generate(
      _bindings.PointVector_Size(pv),
      (index) => Point.fromNative(_bindings.PointVector_At(pv, index)),
    );
  }

  // @override
  // List<Point> get current {
  //   if (currentIndex < length) {
  //     return this[currentIndex];
  //   }
  //   throw IndexError.withLength(currentIndex, length);
  // }

  // @override
  // bool moveNext() {
  //   if (currentIndex < length) {
  //     currentIndex++;
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  @override
  Iterator<List<Point>> get iterator => ContoursIterator(_ptr);
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
    if (currentIndex < length) {
      currentIndex++;
      return true;
    } else {
      return false;
    }
  }
}
