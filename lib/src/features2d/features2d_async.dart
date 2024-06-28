library cv;

import 'package:opencv_dart/src/constants.g.dart';

import '../core/base.dart';
import '../core/dmatch.dart';
import '../core/keypoint.dart';
import '../core/mat.dart';
import '../core/scalar.dart';
import '../core/vec.dart';
import '../opencv.g.dart' as cvg;
import './features2d.dart';

extension AKAZEAsync on AKAZE {
  static Future<AKAZE> emptyAsync() async => cvRunAsync(
        CFFI.AKAZE_Create_Async,
        (c, p) => c.complete(AKAZE.fromPointer(p.cast<cvg.AKAZE>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.AKAZE_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final rval = cvRunAsync<(VecKeyPoint, Mat)>(
      (callback) => CFFI.AKAZE_DetectAndCompute_Async(
        ref,
        src.ref,
        mask.ref,
        desc.ref,
        callback,
      ),
      (c, keypoints) => c.complete(
        (VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()), desc),
      ),
    );
    return rval;
  }
}

extension AgastFeatureDetectorAsync on AgastFeatureDetector {
  static Future<AgastFeatureDetector> emptyAsync() async => cvRunAsync(
        CFFI.AgastFeatureDetector_Create_Async,
        (c, p) => c.complete(
          AgastFeatureDetector.fromPointer(
            p.cast<cvg.AgastFeatureDetector>(),
          ),
        ),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.AgastFeatureDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension BRISKAsync on BRISK {
  static Future<BRISK> emptyAsync() async => cvRunAsync(
        CFFI.BRISK_Create_Async,
        (c, p) => c.complete(BRISK.fromPointer(p.cast<cvg.BRISK>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.BRISK_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final rval = cvRunAsync<(VecKeyPoint, Mat)>(
      (callback) => CFFI.BRISK_DetectAndCompute_Async(
        ref,
        src.ref,
        mask.ref,
        desc.ref,
        callback,
      ),
      (c, keypoints) => c.complete(
        (VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()), desc),
      ),
    );
    return rval;
  }
}

extension FastFeatureDetectorAsync on FastFeatureDetector {
  static Future<FastFeatureDetector> emptyAsync() async => cvRunAsync(
        CFFI.FastFeatureDetector_Create_Async,
        (c, p) => c.complete(
          FastFeatureDetector.fromPointer(p.cast<cvg.FastFeatureDetector>()),
        ),
      );

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
        (c, p) => c.complete(
          FastFeatureDetector.fromPointer(
            p.cast<cvg.FastFeatureDetector>(),
          ),
        ),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.FastFeatureDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension GFTTDetectorAsync on GFTTDetector {
  static Future<GFTTDetector> emptyAsync() async => cvRunAsync(
        CFFI.GFTTDetector_Create_Async,
        (c, p) => c.complete(GFTTDetector.fromPointer(p.cast<cvg.GFTTDetector>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.GFTTDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension KAZEAsync on KAZE {
  static Future<KAZE> emptyAsync() async => cvRunAsync(
        CFFI.KAZE_Create_Async,
        (c, p) => c.complete(KAZE.fromPointer(p.cast<cvg.KAZE>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.KAZE_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final rval = cvRunAsync<(VecKeyPoint, Mat)>(
      (callback) => CFFI.KAZE_DetectAndCompute_Async(
        ref,
        src.ref,
        mask.ref,
        desc.ref,
        callback,
      ),
      (c, keypoints) => c.complete(
        (VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()), desc),
      ),
    );
    return rval;
  }
}

extension MSERAsync on MSER {
  static Future<MSER> emptyAsync() async => cvRunAsync(
        CFFI.MSER_Create_Async,
        (c, p) => c.complete(MSER.fromPointer(p.cast<cvg.MSER>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.MSER_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension ORBAsync on ORB {
  static Future<ORB> emptyAsync() async => cvRunAsync(
        CFFI.ORB_Create_Async,
        (c, p) => c.complete(ORB.fromPointer(p.cast<cvg.ORB>())),
      );

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

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.ORB_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final rval = cvRunAsync<(VecKeyPoint, Mat)>(
      (callback) => CFFI.ORB_DetectAndCompute_Async(
        ref,
        src.ref,
        mask.ref,
        desc.ref,
        callback,
      ),
      (c, keypoints) => c.complete(
        (VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()), desc),
      ),
    );
    return rval;
  }
}

extension SimpleBlobDetectorAsync on SimpleBlobDetector {
  static Future<SimpleBlobDetector> emptyAsync() async => cvRunAsync(
        CFFI.SimpleBlobDetector_Create_Async,
        (c, p) => c.complete(
          SimpleBlobDetector.fromPointer(p.cast<cvg.SimpleBlobDetector>()),
        ),
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
          SimpleBlobDetector.fromPointer(
            p.cast<cvg.SimpleBlobDetector>(),
          ),
        ),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.SimpleBlobDetector_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }
}

extension BFMatcherAsync on BFMatcher {
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

  Future<VecDMatch> matchAsync(Mat query, Mat train) async {
    final rval = cvRunAsync<VecDMatch>(
      (callback) => CFFI.BFMatcher_Match_Async(ref, query.ref, train.ref, callback),
      (c, ret) => c.complete(VecDMatch.fromPointer(ret.cast<cvg.VecDMatch>())),
    );
    return rval;
  }

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
  static Future<FlannBasedMatcher> emptyAsync() async => cvRunAsync(
        CFFI.FlannBasedMatcher_Create_Async,
        (c, p) => c.complete(
          FlannBasedMatcher.fromPointer(p.cast<cvg.FlannBasedMatcher>()),
        ),
      );

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
  static Future<SIFT> emptyAsync() async => cvRunAsync(
        CFFI.SIFT_Create_Async,
        (c, p) => c.complete(SIFT.fromPointer(p.cast<cvg.SIFT>())),
      );

  Future<VecKeyPoint> detectAsync(Mat src) async {
    final rval = cvRunAsync<VecKeyPoint>(
      (callback) => CFFI.SIFT_Detect_Async(ref, src.ref, callback),
      (c, ret) => c.complete(VecKeyPoint.fromPointer(ret.cast<cvg.VecKeyPoint>())),
    );
    return rval;
  }

  Future<(VecKeyPoint, Mat)> detectAndComputeAsync(Mat src, Mat mask) async {
    final desc = Mat.empty();
    final rval = cvRunAsync<(VecKeyPoint, Mat)>(
      (callback) => CFFI.SIFT_DetectAndCompute_Async(
        ref,
        src.ref,
        mask.ref,
        desc.ref,
        callback,
      ),
      (
        c,
        keypoints,
      ) =>
          c.complete(
        (VecKeyPoint.fromPointer(keypoints.cast<cvg.VecKeyPoint>()), desc),
      ),
    );
    return rval;
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
