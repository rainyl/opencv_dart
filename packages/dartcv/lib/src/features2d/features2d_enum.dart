enum AKAZEDescriptorType {
  DESCRIPTOR_KAZE_UPRIGHT(2),
  DESCRIPTOR_KAZE(3),
  DESCRIPTOR_MLDB_UPRIGHT(4),
  DESCRIPTOR_MLDB(5);

  const AKAZEDescriptorType(this.value);
  final int value;

  factory AKAZEDescriptorType.fromValue(int value) => switch (value) {
        2 => DESCRIPTOR_KAZE_UPRIGHT,
        3 => DESCRIPTOR_KAZE,
        4 => DESCRIPTOR_MLDB_UPRIGHT,
        5 => DESCRIPTOR_MLDB,
        _ => throw ArgumentError.value(value, 'value', 'Invalid AKAZE descriptor type'),
      };
}

enum KAZEDiffusivityType {
  DIFF_PM_G1(0),
  DIFF_PM_G2(1),
  DIFF_WEICKERT(2),
  DIFF_CHARBONNIER(3);

  const KAZEDiffusivityType(this.value);
  final int value;

  factory KAZEDiffusivityType.fromValue(int value) => switch (value) {
        0 => DIFF_PM_G1,
        1 => DIFF_PM_G2,
        2 => DIFF_WEICKERT,
        3 => DIFF_CHARBONNIER,
        _ => throw ArgumentError.value(value, 'value', 'Invalid KAZE diffusivity type'),
      };
}

enum AgastDetectorType {
  AGAST_5_8(0),
  AGAST_7_12d(1),
  AGAST_7_12s(2),
  OAST_9_16(3);

  const AgastDetectorType(this.value);
  final int value;

  factory AgastDetectorType.fromValue(int value) => switch (value) {
        0 => AGAST_5_8,
        1 => AGAST_7_12d,
        2 => AGAST_7_12s,
        3 => OAST_9_16,
        _ => throw ArgumentError.value(value, 'value', 'Invalid detector type'),
      };
}

enum FastFeatureDetectorType {
  /// FastFeatureDetector::TYPE_5_8
  TYPE_5_8(0),

  /// FastFeatureDetector::TYPE_7_12
  TYPE_7_12(1),

  /// FastFeatureDetector::TYPE_9_16
  TYPE_9_16(2);

  const FastFeatureDetectorType(this.value);
  final int value;

  factory FastFeatureDetectorType.fromValue(int value) => switch (value) {
        0 => TYPE_5_8,
        1 => TYPE_7_12,
        2 => TYPE_9_16,
        _ => throw ArgumentError.value(value, 'value', 'Invalid FastFeatureDetector type'),
      };
}

enum ORBScoreType {
  HARRIS_SCORE(0),
  FAST_SCORE(1);

  const ORBScoreType(this.value);
  final int value;

  factory ORBScoreType.fromValue(int value) => switch (value) {
        0 => HARRIS_SCORE,
        1 => FAST_SCORE,
        _ => throw ArgumentError.value(value, 'value', 'Invalid ORB score type'),
      };
}

enum DrawMatchesFlag {
  /// DEFAULT creates new image and for each keypoint only the center point will be drawn
  DEFAULT(0),

  /// DRAW_OVER_OUTIMG draws matches on existing content of image
  DRAW_OVER_OUTIMG(1),

  /// NOT_DRAW_SINGLE_POINTS will not draw single points
  NOT_DRAW_SINGLE_POINTS(2),

  /// DRAW_RICH_KEYPOINTS draws the circle around each keypoint with keypoint size and orientation
  DRAW_RICH_KEYPOINTS(4);

  const DrawMatchesFlag(this.value);
  final int value;

  factory DrawMatchesFlag.fromValue(int value) => switch (value) {
        0 => DEFAULT,
        1 => DRAW_OVER_OUTIMG,
        2 => NOT_DRAW_SINGLE_POINTS,
        4 => DRAW_RICH_KEYPOINTS,
        _ => throw ArgumentError.value(value, 'value', 'Invalid DrawMatchesFlag value'),
      };
}
