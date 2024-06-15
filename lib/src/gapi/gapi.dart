library cv;

import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';

import '../constants.g.dart';
import '../core/base.dart';
import '../core/dmatch.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import 'gmat.dart';
import 'gscalar.dart';

GMat addMat(GMat a, GMat b, {int ddepth = -1}) {
  final p = calloc<cvg.GMat>();
  cvRun(() => CFFI.gapi_add(a.ref, b.ref, ddepth, p));
  return GMat.fromPointer(p);
}

GMat addC(GMat a, GScalar b, {int ddepth = -1}) {
  final p = calloc<cvg.GMat>();
  cvRun(() => CFFI.gapi_addC(a.ref, b.ref, ddepth, p));
  return GMat.fromPointer(p);
}
