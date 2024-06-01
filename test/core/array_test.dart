import 'package:test/test.dart';
import 'package:opencv_dart/opencv_dart.dart' as cv;

void main() {
  test('cv.U8Array', () {
    final array = cv.U8Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.U8Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.I8Array', () {
    final array = cv.I8Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.I8Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.U16Array', () {
    final array = cv.U16Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.U16Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.I16Array', () {
    final array = cv.I16Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.I16Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.I32Array', () {
    final array = cv.I32Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.I32Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.F32Array', () {
    final array = cv.F32Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.F32Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });

  test('cv.F64Array', () {
    final array = cv.F64Array(10, 1);
    expect(array[0], 1);
    array[1] = 2;
    expect(array[1], 2);
    array[1] = 1;
    expect(array.toList(), List.generate(10, (i) => 1));

    final array2 = cv.F64Array.fromList(List.generate(array.length, (i) => 1));
    expect(array2.props, isNotEmpty);
    expect(array2.toList(), array2.toList());

    array.dispose();
  });
}
