import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

import 'package:typed_data/src/typed_buffer.dart' as tb;

class PointList extends tb.TypedDataBuffer<cv.Point> {
  PointList(super.buffer);

  @override
  cv.Point get _defaultValue => cv.Point(0, 0);
}

void main() {
  test('aaa', () {
    final list = [
      cv.Point(0, 0),
      cv.Point(0, 0),
      cv.Point(0, 0),
      cv.Point(0, 0),
    ];
    final buffer = PointList(list);
    
  });
}
