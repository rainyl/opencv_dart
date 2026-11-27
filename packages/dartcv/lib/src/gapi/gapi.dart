// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

library cv.gapi;

// import '../core/dmatch.dart';
// import '../core/keypoint.dart';
// import '../core/mat.dart';
// import '../core/scalar.dart';
// import '../core/vec.dart';
import '../bindings/gapi.dart' as cvg;
// import '../g/constants.g.dart';
import '../core/base.dart';
import '../ffi.dart' as ffi;
import '../package_ffi.dart';
import 'gmat.dart';
import 'gscalar.dart';

GMat addMat(GMat a, GMat b, {int ddepth = -1}) {
  return GMat.fromPointer(cvCreate(calloc<cvg.GMat>(), (p) => cvg.gapi_add(a.ref, b.ref, ddepth, p)));
}

GMat addC(GMat a, GScalar b, {int ddepth = -1}) {
  return GMat.fromPointer(cvCreate(calloc<cvg.GMat>(), (p) => cvg.gapi_addC(a.ref, b.ref, ddepth, p)));
}
