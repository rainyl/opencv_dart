import 'dart:ffi' as ffi;

import 'package:ffi/ffi.dart';
import '../opencv.g.dart' as cvg;

typedef TermCriteria = (int type, int count, double eps);

extension TermCriteriaX on TermCriteria {
  ffi.Pointer<cvg.TermCriteria> toNativePtr(Arena arena) {
    return arena<cvg.TermCriteria>()
      ..ref.type = this.$1
      ..ref.maxCount = this.$2
      ..ref.epsilon = this.$3;
  }

  int get type => this.$1;
  int get count => this.$2;
  double get eps => this.$3;
}

extension TermCriteriaX1 on cvg.TermCriteria {
  TermCriteria toDart() {
    return (type, maxCount, epsilon);
  }
}
