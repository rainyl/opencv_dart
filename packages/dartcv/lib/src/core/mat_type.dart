// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// coverage:ignore-file
// ignore_for_file: constant_identifier_names, non_constant_identifier_names

library cv;

import 'exception.dart';

extension type const MatType(int value) implements Object {
  const MatType.makeType(int depth, int channels)
    : value = (depth & (CV_DEPTH_MAX - 1)) | ((channels - 1) << CV_CN_SHIFT);

  const MatType.CV_8UC(int channels) : this.makeType(CV_8U, channels);
  const MatType.CV_8SC(int channels) : this.makeType(CV_8S, channels);
  const MatType.CV_16UC(int channels) : this.makeType(CV_16U, channels);
  const MatType.CV_16SC(int channels) : this.makeType(CV_16S, channels);
  const MatType.CV_32SC(int channels) : this.makeType(CV_32S, channels);
  const MatType.CV_32FC(int channels) : this.makeType(CV_32F, channels);
  const MatType.CV_64FC(int channels) : this.makeType(CV_64F, channels);
  const MatType.CV_16FC(int channels) : this.makeType(CV_16F, channels);

  int get depth => value & (CV_DEPTH_MAX - 1);
  bool get isInteger => depth < CV_32F;
  int get channels => (value >> CV_CN_SHIFT) + 1;

  @Deprecated("Use value instead")
  int toInt32() => value;

  static const int CV_CN_MAX = 512;
  static const int CV_CN_SHIFT = 3;
  static const int CV_DEPTH_MAX = 1 << CV_CN_SHIFT;

  // type depth constants
  static const int CV_8U = 0;
  static const int CV_8S = 1;
  static const int CV_16U = 2;
  static const int CV_16S = 3;
  static const int CV_32S = 4;
  static const int CV_32F = 5;
  static const int CV_64F = 6;
  static const int CV_16F = 7;

  /// predefined type constants
  static const CV_8UC1 = MatType.CV_8UC(1); // 0
  static const CV_8UC2 = MatType.CV_8UC(2); // 8
  static const CV_8UC3 = MatType.CV_8UC(3); // 16
  static const CV_8UC4 = MatType.CV_8UC(4); // 24
  static const CV_8SC1 = MatType.CV_8SC(1); // 1
  static const CV_8SC2 = MatType.CV_8SC(2); // 9
  static const CV_8SC3 = MatType.CV_8SC(3); // 17
  static const CV_8SC4 = MatType.CV_8SC(4); // 25
  static const CV_16UC1 = MatType.CV_16UC(1); // 2
  static const CV_16UC2 = MatType.CV_16UC(2); // 10
  static const CV_16UC3 = MatType.CV_16UC(3); // 18
  static const CV_16UC4 = MatType.CV_16UC(4); // 26
  static const CV_16SC1 = MatType.CV_16SC(1); // 3
  static const CV_16SC2 = MatType.CV_16SC(2); // 11
  static const CV_16SC3 = MatType.CV_16SC(3); // 19
  static const CV_16SC4 = MatType.CV_16SC(4); // 27
  static const CV_32SC1 = MatType.CV_32SC(1); // 4
  static const CV_32SC2 = MatType.CV_32SC(2); // 12
  static const CV_32SC3 = MatType.CV_32SC(3); // 20
  static const CV_32SC4 = MatType.CV_32SC(4); // 28
  static const CV_32FC1 = MatType.CV_32FC(1); // 5
  static const CV_32FC2 = MatType.CV_32FC(2); // 13
  static const CV_32FC3 = MatType.CV_32FC(3); // 21
  static const CV_32FC4 = MatType.CV_32FC(4); // 29
  static const CV_64FC1 = MatType.CV_64FC(1); // 6
  static const CV_64FC2 = MatType.CV_64FC(2); // 14
  static const CV_64FC3 = MatType.CV_64FC(3); // 22
  static const CV_64FC4 = MatType.CV_64FC(4); // 30
  static const CV_16FC1 = MatType.CV_16FC(1); // 7
  static const CV_16FC2 = MatType.CV_16FC(2); // 15
  static const CV_16FC3 = MatType.CV_16FC(3); // 23
  static const CV_16FC4 = MatType.CV_16FC(4); // 31

  // TODO: extension type do not support override/redeclare methods exist in Object
  // such as toString(), if they support this feature, we can just use toString()
  String asString() {
    final String s = switch (depth) {
      CV_8U => "CV_8U",
      CV_8S => "CV_8S",
      CV_16U => "CV_16U",
      CV_16S => "CV_16S",
      CV_32S => "CV_32S",
      CV_32F => "CV_32F",
      CV_64F => "CV_64F",
      CV_16F => "CV_16F",
      _ => throw CvdException("Unsupported type value ($value)"),
    };
    return channels <= 4 ? "${s}C$channels" : "${s}C($channels)";
  }
}
