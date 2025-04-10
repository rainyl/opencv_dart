// Copyright (c) 2024, rainyl and all contributors. All rights reserved.
// Use of this source code is governed by a Apache-2.0 license
// that can be found in the LICENSE file.

// ignore_for_file: non_constant_identifier_names

library cv.features2d;

import '../core/base.dart';
import '../core/dmatch.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../g/features2d.g.dart' as cfeatures2d;
import './features2d.dart';

extension AKAZEAsync on AKAZE {
  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0<VecKeyPoint>(
      (callback) => cfeatures2d.cv_AKAZE_detect(ref, src.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) =>
          cfeatures2d.cv_AKAZE_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret.ptr, callback),
      (c) {
        return c.complete((ret, desc));
      },
    );
  }
}

extension AgastFeatureDetectorAsync on AgastFeatureDetector {
  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_AgastFeatureDetector_detect(ref, src.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension BRISKAsync on BRISK {
  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_BRISK_detect(ref, src.ref, ret.ptr, callback), (c) {
      return c.complete(ret);
    });
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) =>
          cfeatures2d.cv_BRISK_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret.ptr, callback),
      (c) {
        return c.complete((ret, desc));
      },
    );
  }
}

extension FastFeatureDetectorAsync on FastFeatureDetector {
  /// Detect keypoints in an image using FastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_FastFeatureDetector_detect(ref, src.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension GFTTDetectorAsync on GFTTDetector {
  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_GFTTDetector_detect(ref, src.ref, ret.ptr, callback), (
      c,
    ) {
      return c.complete(ret);
    });
  }
}

extension KAZEAsync on KAZE {
  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_KAZE_detect(ref, src.ref, ret.ptr, callback), (c) {
      return c.complete(ret);
    });
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_KAZE_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret.ptr, callback),
      (c) {
        return c.complete((ret, desc));
      },
    );
  }
}

extension MSERAsync on MSER {
  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_MSER_detect(ref, src.ref, ret.ptr, callback), (c) {
      return c.complete(ret);
    });
  }
}

extension ORBAsync on ORB {
  /// Detect keypoints in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_ORB_detect(ref, src.ref, ret.ptr, callback), (c) {
      return c.complete(ret);
    });
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(
    Mat src,
    Mat mask, {
    VecKeyPoint? keypoints,
    Mat? description,
    bool useProvidedKeypoints = false,
  }) async {
    keypoints ??= VecKeyPoint();
    description ??= Mat.empty();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_ORB_detectAndCompute(
        ref,
        src.ref,
        mask.ref,
        keypoints!.ptr,
        description!.ref,
        useProvidedKeypoints,
        callback,
      ),
      (c) {
        return c.complete((keypoints!, description!));
      },
    );
  }
}

extension SimpleBlobDetectorAsync on SimpleBlobDetector {
  /// Detect keypoints in an image using SimpleBlobDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_SimpleBlobDetector_detect(ref, src.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension BFMatcherAsync on BFMatcher {
  /// Match Finds the best match for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d39/classcv_1_1DescriptorMatcher.html#a0f046f47b68ec7074391e1e85c750cba
  Future<VecDMatch> matchAsync(Mat query, Mat train) async {
    final ret = VecDMatch();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_BFMatcher_match(ref, query.ref, train.ref, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  Future<VecVecDMatch> knnMatchAsync(Mat query, Mat train, int k) async {
    final ret = VecVecDMatch();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_BFMatcher_knnMatch(ref, query.ref, train.ref, k, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension FlannBasedMatcherAsync on FlannBasedMatcher {
  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  Future<VecVecDMatch> knnMatchAsync(Mat query, Mat train, int k) async {
    final ret = VecVecDMatch();
    return cvRunAsync0(
      (callback) =>
          cfeatures2d.cv_FlannBasedMatcher_knnMatch(ref, query.ref, train.ref, k, ret.ptr, callback),
      (c) {
        return c.complete(ret);
      },
    );
  }
}

extension SIFTAsync on SIFT {
  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final ret = VecKeyPoint();
    return cvRunAsync0((callback) => cfeatures2d.cv_SIFT_detect(ref, src.ref, ret.ptr, callback), (c) {
      return c.complete(ret);
    });
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final ret = VecKeyPoint();
    return cvRunAsync0(
      (callback) => cfeatures2d.cv_SIFT_detectAndCompute(ref, src.ref, mask.ref, desc.ref, ret.ptr, callback),
      (c) {
        return c.complete((ret, desc));
      },
    );
  }
}

Future<void> drawKeyPointsAsync(
  Mat src,
  VecKeyPoint keypoints,
  Mat dst,
  Scalar color,
  DrawMatchesFlag flag,
) async {
  await cvRunAsync0<void>(
    (callback) =>
        cfeatures2d.cv_drawKeyPoints(src.ref, keypoints.ref, dst.ref, color.ref, flag.value, callback),
    (c) => c.complete(),
  );
}

/// DrawMatches draws matches on combined train and querry images.
///
/// For further details, please see:
/// https://docs.opencv.org/master/d4/d5d/group__features2d__draw.html#gad8f463ccaf0dc6f61083abd8717c261a
Future<void> drawMatchesAsync(
  InputArray img1,
  VecKeyPoint keypoints1,
  InputArray img2,
  VecKeyPoint keypoints2,
  VecDMatch matches1to2,
  InputOutputArray outImg, {
  Scalar? matchColor,
  Scalar? singlePointColor,
  VecChar? matchesMask,
  DrawMatchesFlag flags = DrawMatchesFlag.DEFAULT,
}) async {
  matchColor ??= Scalar.all(-1);
  singlePointColor ??= Scalar.all(-1);
  matchesMask ??= VecChar.fromList([]);
  return cvRunAsync0(
    (callback) => cfeatures2d.cv_drawMatches(
      img1.ref,
      keypoints1.ref,
      img2.ref,
      keypoints2.ref,
      matches1to2.ref,
      outImg.ref,
      matchColor!.ref,
      singlePointColor!.ref,
      matchesMask!.ref,
      flags.value,
      callback,
    ),
    (c) {
      c.complete();
    },
  );
}
