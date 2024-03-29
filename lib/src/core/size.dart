import 'dart:ffi' as ffi;
import 'package:ffi/ffi.dart';

import '../opencv.g.dart' as cvg;

/// (width, height)
typedef Size = (int, int);

extension RecordSizeExtension1 on Size {
  ffi.Pointer<cvg.Size> toSize(Arena arena) {
    final size = arena<cvg.Size>()
      ..ref.width = this.$1
      ..ref.height = this.$2;
    return size;
  }
}
