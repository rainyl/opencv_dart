// ignore_for_file: avoid_print

// Spike demo, VM entry point: dart run tool/web/demo/main_vm.dart
import 'dart:io';

// The slice lives in the Flutter demo so both demos share it.
// ignore: avoid_relative_lib_imports
import '../flutter_demo/lib/slice_demo.dart';

Future<void> main() async {
  final png = File('test/images/lenna.png').readAsBytesSync();
  final r = await runSlice(png);
  r.forEach((k, v) => print('$k: $v'));
}
