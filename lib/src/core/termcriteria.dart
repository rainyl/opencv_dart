library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import 'base.dart';
import '../opencv.g.dart' as cvg;

typedef TermCriteria = (int type, int count, double eps);

extension TermCriteriaExtension on TermCriteria {
  /// TermCriteria is the criteria for iterative algorithms.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d9/d5d/classcv_1_1TermCriteria.html
  cvg.TermCriteriaPtr toTermCriteria(Arena arena) {
    final p = arena<cvg.TermCriteria>();
    cvRun(() => CFFI.TermCriteria_New($1, $2, $3, p));
    return p;
  }
}
