import 'package:opencv_dart/opencv_dart.dart' as cv;
import 'package:test/test.dart';

VecElementEquals vecElementEquals(cv.Vec expectedValues) => VecElementEquals(expectedValues);

class VecElementEquals extends Matcher {
  final cv.Vec expected;

  const VecElementEquals(this.expected);

  @override
  Description describe(Description description) {
    return description.add("$expected");
  }

  @override
  bool matches(Object? item, Map matchState) {
    final vec = item! as cv.Vec;
    if (vec.length != expected.length) return false;
    return vec.indexed.every((e) => e.$2 == expected[e.$1]);
  }
}
