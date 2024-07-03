// ignore_for_file: non_constant_identifier_names

library cv;

import '../constants.g.dart';
import '../core/base.dart';
import '../core/dmatch.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import './features2d.dart';

extension AKAZEAsync on AKAZE {
  /// returns a new AKAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  static Future<AKAZE> emptyAsync() async => cvRunAsync(
        CFFI.AKAZE_Create_Async,
        (c, p) => c.complete(AKAZE.fromPointer(p.cast<cvg.AKAZE>())),
      );

  /// Detect keypoints in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.AKAZE_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  /// DetectAndCompute keypoints and compute in an image using AKAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async =>
      cvRunAsync2<(VecKeyPoint, Mat)>(
        (callback) => CFFI.AKAZE_DetectAndCompute_Async(
          ref,
          src.ref,
          mask.ref,
          callback,
        ),
        (c, keypoints, desc) => c.complete(
          (
            VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()),
            Mat.fromPointer(desc.cast<cvg.Mat>()),
          ),
        ),
      );
}

extension AgastFeatureDetectorAsync on AgastFeatureDetector {
  /// returns a new AgastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d7/d19/classcv_1_1AgastFeatureDetector.html
  static Future<AgastFeatureDetector> emptyAsync() async => cvRunAsync(
        CFFI.AgastFeatureDetector_Create_Async,
        (c, p) => c.complete(AgastFeatureDetector.fromPointer(p.cast<cvg.AgastFeatureDetector>())),
      );

  /// Detect keypoints in an image using AgastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.AgastFeatureDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension BRISKAsync on BRISK {
  /// returns a new BRISK algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d8/d30/classcv_1_1AKAZE.html
  static Future<BRISK> emptyAsync() async => cvRunAsync(
        CFFI.BRISK_Create_Async,
        (c, p) => c.complete(BRISK.fromPointer(p.cast<cvg.BRISK>())),
      );

  /// Detect keypoints in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.BRISK_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  /// DetectAndCompute keypoints and compute in an image using BRISK.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async =>
      cvRunAsync2<(VecKeyPoint, Mat)>(
        (callback) => CFFI.BRISK_DetectAndCompute_Async(
          ref,
          src.ref,
          mask.ref,
          callback,
        ),
        (c, keypoints, desc) => c.complete(
          (
            VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()),
            Mat.fromPointer(desc.cast<cvg.Mat>()),
          ),
        ),
      );
}

extension FastFeatureDetectorAsync on FastFeatureDetector {
  /// returns a new FastFeatureDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html
  static Future<FastFeatureDetector> emptyAsync() async => cvRunAsync(
        CFFI.FastFeatureDetector_Create_Async,
        (c, p) => c.complete(FastFeatureDetector.fromPointer(p.cast<cvg.FastFeatureDetector>())),
      );

  /// returns a new FastFeatureDetector algorithm with parameters
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d74/classcv_1_1FastFeatureDetector.html#ab986f2ff8f8778aab1707e2642bc7f8e
  static Future<FastFeatureDetector> createAsync({
    int threshold = 10,
    bool nonmaxSuppression = true,
    FastFeatureDetectorType type = FastFeatureDetectorType.TYPE_9_16,
  }) async =>
      cvRunAsync(
        (callback) => CFFI.FastFeatureDetector_CreateWithParams_Async(
          threshold,
          nonmaxSuppression,
          type.value,
          callback,
        ),
        (c, p) => c.complete(FastFeatureDetector.fromPointer(p.cast<cvg.FastFeatureDetector>())),
      );

  /// Detect keypoints in an image using FastFeatureDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.FastFeatureDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension GFTTDetectorAsync on GFTTDetector {
  /// returns a new GFTTDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/df/d21/classcv_1_1GFTTDetector.html
  static Future<GFTTDetector> emptyAsync() async => cvRunAsync(
        CFFI.GFTTDetector_Create_Async,
        (c, p) => c.complete(GFTTDetector.fromPointer(p.cast<cvg.GFTTDetector>())),
      );

  /// Detect keypoints in an image using GFTTDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.GFTTDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension KAZEAsync on KAZE {
  /// returns a new KAZE algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<KAZE> emptyAsync() async => cvRunAsync(
        CFFI.KAZE_Create_Async,
        (c, p) => c.complete(KAZE.fromPointer(p.cast<cvg.KAZE>())),
      );

  /// Detect keypoints in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.KAZE_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  /// DetectAndCompute keypoints and compute in an image using KAZE.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async =>
      cvRunAsync2<(VecKeyPoint, Mat)>(
        (callback) => CFFI.KAZE_DetectAndCompute_Async(
          ref,
          src.ref,
          mask.ref,
          callback,
        ),
        (c, keypoints, desc) => c.complete(
          (
            VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()),
            Mat.fromPointer(desc.cast<cvg.Mat>()),
          ),
        ),
      );
}

extension MSERAsync on MSER {
  /// returns a new MSER algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<MSER> emptyAsync() async => cvRunAsync(
        CFFI.MSER_Create_Async,
        (c, p) => c.complete(MSER.fromPointer(p.cast<cvg.MSER>())),
      );

  /// Detect keypoints in an image using MSER.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.MSER_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension ORBAsync on ORB {
  /// returns a new ORB algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<ORB> emptyAsync() async =>
      cvRunAsync(CFFI.ORB_Create_Async, (c, p) => c.complete(ORB.fromPointer(p.cast<cvg.ORB>())));

  /// NewORBWithParams returns a new ORB algorithm with parameters
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d95/classcv_1_1ORB.html#aeff0cbe668659b7ca14bb85ff1c4073b
  static Future<ORB> createAsync({
    int nFeatures = 500,
    double scaleFactor = 1.2,
    int nLevels = 8,
    int edgeThreshold = 31,
    int firstLevel = 0,
    int WTA_K = 2,
    ORBScoreType scoreType = ORBScoreType.HARRIS_SCORE,
    int patchSize = 31,
    int fastThreshold = 20,
  }) async =>
      cvRunAsync(
        (callback) => CFFI.ORB_CreateWithParams_Async(
          nFeatures,
          scaleFactor,
          nLevels,
          edgeThreshold,
          firstLevel,
          WTA_K,
          scoreType.value,
          patchSize,
          fastThreshold,
          callback,
        ),
        (c, p) => c.complete(ORB.fromPointer(p.cast<cvg.ORB>())),
      );

  /// Detect keypoints in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.ORB_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  /// DetectAndCompute keypoints and compute in an image using ORB.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async =>
      cvRunAsync2<(VecKeyPoint, Mat)>(
        (callback) => CFFI.ORB_DetectAndCompute_Async(
          ref,
          src.ref,
          mask.ref,
          callback,
        ),
        (c, keypoints, desc) => c.complete(
          (
            VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()),
            Mat.fromPointer(desc.cast<cvg.Mat>()),
          ),
        ),
      );
}

extension SimpleBlobDetectorAsync on SimpleBlobDetector {
  /// returns a new SimpleBlobDetector algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<SimpleBlobDetector> emptyAsync() async => cvRunAsync(
        CFFI.SimpleBlobDetector_Create_Async,
        (c, p) => c.complete(SimpleBlobDetector.fromPointer(p.cast<cvg.SimpleBlobDetector>())),
      );

  static Future<SimpleBlobDetector> createAsync(
    SimpleBlobDetectorParams params,
  ) async =>
      cvRunAsync(
        (callback) => CFFI.SimpleBlobDetector_Create_WithParams_Async(
          params.ref,
          callback,
        ),
        (c, p) => c.complete(
          SimpleBlobDetector.fromPointer(p.cast<cvg.SimpleBlobDetector>()),
        ),
      );

  /// Detect keypoints in an image using SimpleBlobDetector.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.SimpleBlobDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension BFMatcherAsync on BFMatcher {
  /// returns a new BFMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<BFMatcher> emptyAsync() async => cvRunAsync(
        CFFI.BFMatcher_Create_Async,
        (c, p) => c.complete(BFMatcher.fromPointer(p.cast<cvg.BFMatcher>())),
      );

  static Future<BFMatcher> createAsync({
    int type = NORM_L2,
    bool crossCheck = false,
  }) async =>
      cvRunAsync(
        (callback) => CFFI.BFMatcher_CreateWithParams_Async(type, crossCheck, callback),
        (c, p) => c.complete(BFMatcher.fromPointer(p.cast<cvg.BFMatcher>())),
      );

  /// Match Finds the best match for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/4.x/db/d39/classcv_1_1DescriptorMatcher.html#a0f046f47b68ec7074391e1e85c750cba
  Future<VecDMatch> matchAsync(Mat query, Mat train) async {
    final rval = cvRunAsync<VecDMatch>(
      (callback) => CFFI.BFMatcher_Match_Async(ref, query.ref, train.ref, callback),
      (c, ret) => c.complete(VecDMatch.fromPointer(ret.cast<cvg.VecDMatch>())),
    );
    return rval;
  }

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  Future<VecVecDMatch> knnMatchAsync(Mat query, Mat train, int k) async {
    final rval = cvRunAsync<VecVecDMatch>(
      (callback) => CFFI.BFMatcher_KnnMatch_Async(
        ref,
        query.ref,
        train.ref,
        k,
        callback,
      ),
      (c, ret) => c.complete(VecVecDMatch.fromPointer(ret.cast<cvg.VecVecDMatch>())),
    );
    return rval;
  }
}

extension FlannBasedMatcherAsync on FlannBasedMatcher {
  /// returns a new FlannBasedMatcher algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d3/d61/classcv_1_1KAZE.html
  static Future<FlannBasedMatcher> emptyAsync() async => cvRunAsync(
        CFFI.FlannBasedMatcher_Create_Async,
        (c, p) => c.complete(FlannBasedMatcher.fromPointer(p.cast<cvg.FlannBasedMatcher>())),
      );

  /// KnnMatch Finds the k best matches for each descriptor from a query set.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/db/d39/classcv_1_1DescriptorMatcher.html#aa880f9353cdf185ccf3013e08210483a
  Future<VecVecDMatch> knnMatchAsync(Mat query, Mat train, int k) async {
    final rval = cvRunAsync<VecVecDMatch>(
      (callback) => CFFI.FlannBasedMatcher_KnnMatch_Async(
        ref,
        query.ref,
        train.ref,
        k,
        callback,
      ),
      (c, ret) => c.complete(VecVecDMatch.fromPointer(ret.cast<cvg.VecVecDMatch>())),
    );
    return rval;
  }
}

extension SIFTAsync on SIFT {
  /// returns a new SIFT algorithm
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d5/d3c/classcv_1_1xfeatures2d_1_1SIFT.html
  static Future<SIFT> emptyAsync() async =>
      cvRunAsync(CFFI.SIFT_Create_Async, (c, p) => c.complete(SIFT.fromPointer(p.cast<cvg.SIFT>())));

  /// Detect keypoints in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#aa4e9a7082ec61ebc108806704fbd7887
  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.SIFT_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  /// DetectAndCompute keypoints and compute in an image using SIFT.
  ///
  /// For further details, please see:
  /// https://docs.opencv.org/master/d0/d13/classcv_1_1Feature2D.html#a8be0d1c20b08eb867184b8d74c15a677
  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async =>
      cvRunAsync2<(VecKeyPoint, Mat)>(
        (callback) => CFFI.SIFT_DetectAndCompute_Async(
          ref,
          src.ref,
          mask.ref,
          callback,
        ),
        (c, keypoints, desc) => c.complete(
          (
            VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()),
            Mat.fromPointer(desc.cast<cvg.Mat>()),
          ),
        ),
      );
}

Future<void> drawKeyPointsAsync(
  Mat src,
  VecKeyPoint keypoints,
  Mat dst,
  Scalar color,
  DrawMatchesFlag flag,
) async {
  await cvRunAsync0<void>(
    (callback) => CFFI.DrawKeyPoints_Async(
      src.ref,
      keypoints.ref,
      dst.ref,
      color.ref,
      flag.value,
      callback,
    ),
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
  matchesMask ??= VecChar();
  await cvRunAsync0<void>(
    (callback) => CFFI.DrawMatches_Async(
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
    (c) => c.complete(),
  );
}
