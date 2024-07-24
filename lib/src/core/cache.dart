import 'dart:collection';
import 'dart:ffi' as ffi;

import '../native_lib.dart' show ccore;
import 'mat.dart';
import 'mat_type.dart';

class MatCache {
  final LinkedHashMap<int, Object> _cache = LinkedHashMap<int, Object>();
  final int _maxItems;
  final Mat _mat;

  MatCache({required Mat mat, int maxItems = 20})
      : _maxItems = maxItems,
        _mat = mat;

  Object operator [](int key) {
    switch (key) {
      case CACHE_KEY_FLAGS:
        if (!_cache.containsKey(CACHE_KEY_FLAGS)) {
          _cache[CACHE_KEY_FLAGS] = ccore.Mat_Flags(_mat.ref);
        }
        return _cache[CACHE_KEY_FLAGS]! as int;
      case CACHE_KEY_PDATA:
        if (!_cache.containsKey(CACHE_KEY_PDATA)) {
          _cache[CACHE_KEY_PDATA] = ccore.Mat_Data(_mat.ref).cast<ffi.Uint8>();
        }
        return _cache[CACHE_KEY_PDATA]! as ffi.Pointer<ffi.Uint8>;
      case CACHE_KEY_STEP:
        if (!_cache.containsKey(CACHE_KEY_STEP)) {
          final ms = ccore.Mat_Step(_mat.ref);
          _cache[CACHE_KEY_STEP] = (ms.p[0], ms.p[1], ms.p[2]);
        }
        return _cache[CACHE_KEY_STEP]! as (int, int, int);
      case CACHE_KEY_TYPE:
        if (!_cache.containsKey(CACHE_KEY_TYPE)) {
          _cache[CACHE_KEY_TYPE] = MatType(ccore.Mat_Type(_mat.ref));
        }
        return _cache[CACHE_KEY_TYPE]! as MatType;
      default:
        throw UnimplementedError("cacheProp($key)");
    }
  }

  void operator []=(int key, Object value) {
    if (_cache.length >= _maxItems) {
      _cache.remove(_cache.keys.first);
    }
    _cache[key] = value;
  }

  // cache keys
  static const int CACHE_KEY_FLAGS = 0;
  static const int CACHE_KEY_STEP = 1;
  static const int CACHE_KEY_PDATA = 2;
  static const int CACHE_KEY_TYPE = 3;
}
