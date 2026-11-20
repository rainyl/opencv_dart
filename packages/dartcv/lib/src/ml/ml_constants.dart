// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: constant_identifier_names

library cv.ml;

/// Each training sample is a row of samples.
/// https://docs.opencv.org/4.x/dd/ded/group__ml.html
const int ROW_SAMPLE = 0;

/// Each training sample occupies a column of samples.
const int COL_SAMPLE = 1;

/// Same as VAR_ORDERED.
/// https://docs.opencv.org/4.x/dd/ded/group__ml.html
const int VAR_NUMERICAL = 0;

/// Ordered variables.
const int VAR_ORDERED = 0;

/// Categorical variables.
const int VAR_CATEGORICAL = 1;

/// https://docs.opencv.org/4.x/dd/ded/group__ml.html
const int TEST_ERROR = 0;
const int TRAIN_ERROR = 1;

/// Flags of cv::ml::StatModel, shared by every model type.
/// https://docs.opencv.org/4.x/db/d7d/classcv_1_1ml_1_1StatModel.html
abstract final class StatModel {
  /// Used by `trainWithData` to update the model instead of retraining it from scratch.
  static const int UPDATE_MODEL = 1;

  /// Makes `predict` return the raw output (e.g. the SVM decision function value).
  static const int RAW_OUTPUT = 1;
  static const int COMPRESSED_INPUT = 2;
  static const int PREPROCESSED_INPUT = 4;
}
