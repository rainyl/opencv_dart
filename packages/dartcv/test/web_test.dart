// Runs the package's own tests in a browser against the WebAssembly build:
//
//   dart tool/web/build_wasm.dart     # writes build/web/dartcv.{js,wasm}
//   dart test -p chrome test/web_test.dart
//
// Every test file listed here compiles for the web unchanged; files that need dart:io, highgui or
// gapi are left out. Fixtures are copied into the module's in-memory file system first, so the
// tests' relative paths (test/images/...) resolve as they do on native.
// The test files' `main`s are often `async`, which `group` rejects, hence the closures.
// ignore_for_file: unnecessary_lambdas
@TestOn('browser')
library;

import 'dart:js_interop';
import 'dart:js_interop_unsafe';

import 'package:dartcv4/dartcv.dart' as cv;
import 'package:dartcv4/src/package_version.dart';
import 'package:dartcv4/src/web/ffi.dart' as ffi;
import 'package:dartcv4/src/web/package_ffi.dart' as package_ffi;
import 'package:dartcv4/src/web/runtime.dart' as rt;
import 'package:test/test.dart';

import 'calib3d/calib3d_fisheye_test.dart' as calib3d_calib3d_fisheye_test;
import 'calib3d/calib3d_test.dart' as calib3d_calib3d_test;
import 'calib3d/stereo_test.dart' as calib3d_stereo_test;
import 'contrib/aruco_async_test.dart' as contrib_aruco_async_test;
import 'contrib/aruco_test.dart' as contrib_aruco_test;
import 'contrib/charuco_board_test.dart' as contrib_charuco_board_test;
import 'contrib/charuco_detector_async_test.dart' as contrib_charuco_detector_async_test;
import 'contrib/charuco_detector_test.dart' as contrib_charuco_detector_test;
import 'contrib/freetype_test.dart' as contrib_freetype_test;
import 'contrib/img_hash_async_test.dart' as contrib_img_hash_async_test;
import 'contrib/img_hash_test.dart' as contrib_img_hash_test;
import 'contrib/quality_test.dart' as contrib_quality_test;
import 'contrib/wechat_qrcode_async_test.dart' as contrib_wechat_qrcode_async_test;
import 'contrib/wechat_qrcode_test.dart' as contrib_wechat_qrcode_test;
import 'contrib/ximgproc_test.dart' as contrib_ximgproc_test;
import 'core/core_async_test.dart' as core_core_async_test;
import 'core/mat_async_test.dart' as core_mat_async_test;
import 'core/mat_test.dart' as core_mat_test;
import 'core/others_test.dart' as core_others_test;
import 'core/point_test.dart' as core_point_test;
import 'core/point_view_test.dart' as core_point_view_test;
import 'core/record_struct_test.dart' as core_record_struct_test;
import 'core/rng_test.dart' as core_rng_test;
import 'core/svd_test.dart' as core_svd_test;
import 'core/umat_test.dart' as core_umat_test;
import 'core/vec_test.dart' as core_vec_test;
import 'dnn/dnn_async_test.dart' as dnn_dnn_async_test;
import 'dnn/dnn_test.dart' as dnn_dnn_test;
import 'features2d/features2d_async_test.dart' as features2d_features2d_async_test;
import 'features2d/features2d_test.dart' as features2d_features2d_test;
import 'imgcodecs_test.dart' as imgcodecs_test;
import 'imgproc/clahe_test.dart' as imgproc_clahe_test;
import 'imgproc/imgproc_async_test.dart' as imgproc_imgproc_async_test;
import 'imgproc/imgproc_test.dart' as imgproc_imgproc_test;
import 'imgproc/linesegmentdetector_test.dart' as imgproc_linesegmentdetector_test;
import 'imgproc/subdiv2d_test.dart' as imgproc_subdiv2d_test;
import 'ml/ann_mlp_test.dart' as ml_ann_mlp_test;
import 'ml/boost_test.dart' as ml_boost_test;
import 'ml/dtrees_test.dart' as ml_dtrees_test;
import 'ml/em_test.dart' as ml_em_test;
import 'ml/knearest_test.dart' as ml_knearest_test;
import 'ml/logistic_regression_test.dart' as ml_logistic_regression_test;
import 'ml/ml_async_test.dart' as ml_ml_async_test;
import 'ml/normal_bayes_classifier_test.dart' as ml_normal_bayes_classifier_test;
import 'ml/rtrees_test.dart' as ml_rtrees_test;
import 'ml/stat_model_test.dart' as ml_stat_model_test;
import 'ml/svm_test.dart' as ml_svm_test;
import 'ml/svmsgd_test.dart' as ml_svmsgd_test;
import 'ml/train_data_test.dart' as ml_train_data_test;
import 'objdetect/objdetect_async_test.dart' as objdetect_objdetect_async_test;
import 'objdetect/objdetect_test.dart' as objdetect_objdetect_test;
import 'photo/photo_async_test.dart' as photo_photo_async_test;
import 'photo/photo_test.dart' as photo_photo_test;
import 'stitching/stitching_async_test.dart' as stitching_stitching_async_test;
import 'stitching/stitching_test.dart' as stitching_stitching_test;
import 'video/video_async_test.dart' as video_video_async_test;
import 'video/video_test.dart' as video_video_test;
import 'videoio/videoio_registry_test.dart' as videoio_videoio_registry_test;

// test/models is downloaded by CI (release tag dnn_test_files); a missing model only fails its own test.
const _optionalFixtures = [
  'models/bvlc_googlenet.caffemodel',
  'models/bvlc_googlenet.prototxt',
  'models/detect.caffemodel',
  'models/detect.prototxt',
  'models/face_detection_yunet_2023mar.onnx',
  'models/face_landmark.tflite',
  'models/face_recognition_sface_2021dec.onnx',
  'models/googlenet-9.onnx',
  'models/googlenet_float32.tflite',
  'models/openface.nn4.small2.v1.t7',
  'models/sr.caffemodel',
  'models/sr.prototxt',
  'models/structure_edge_model.yml',
  'models/tensorflow_inception_graph.pb',
];

const _fixtures = [
  'data/brisque_model_live.yml',
  'data/brisque_range_live.yml',
  'data/haarcascade_frontalface_default.xml',
  'data/hog.xml',
  'data/hogcascade_pedestrians.xml',
  'font/hei.ttf',
  'images/MNIST_5.png',
  'images/MNIST_9.png',
  'images/aruco_6X6_250_1.png',
  'images/aruco_6X6_250_6.png',
  'images/aruco_6X6_250_6_contour.png',
  'images/avif_test.avif',
  'images/barcode1.png',
  'images/barcode2.png',
  'images/barcode_mask1.png',
  'images/barcode_mask2.png',
  'images/box.png',
  'images/box_in_scene.png',
  'images/building.jpg',
  'images/calibration_00.jpg',
  'images/chessboard_4x6.png',
  'images/chessboard_4x6_distort.png',
  'images/chessboard_4x6_distort_correct.png',
  'images/circles.jpg',
  'images/circles_grid.jpg',
  'images/contours.png',
  'images/distortion-correct.jpg',
  'images/distortion-correct.png',
  'images/distortion.jpg',
  'images/face-detect.jpg',
  'images/face.jpg',
  'images/fisheye_sample.jpg',
  'images/gocvlogo.jpg',
  'images/gocvlogo.png',
  'images/inpaint-mask.jpg',
  'images/inpaint-src.jpg',
  'images/lenna.png',
  'images/lut.png',
  'images/markers_6x6_250.png',
  'images/multi_qrcodes.png',
  'images/qrcode.png',
  'images/sample.webp',
  'images/sift_descriptor.png',
  'images/simple-translated.jpg',
  'images/simple.jpg',
  'images/small.mp4',
  'images/space_shuttle.jpg',
  'images/toy.jpg',
  'images/tsukuba_left.png',
  'images/tsukuba_right.png',
  'images/xquartz.png',
];

@JS('fetch')
external JSPromise<JSObject> _fetch(String url);

Future<void> _preload() async {
  final fs = rt.module['FS']! as JSObject;
  for (final dir in ['test/images', 'test/data', 'test/font', 'test/images_out', 'test/models']) {
    fs.callMethod('mkdirTree'.toJS, dir.toJS);
  }
  await Future.wait([
    for (final f in [..._fixtures, ..._optionalFixtures])
      () async {
        final res = await _fetch(f).toDart;
        if (!(res['ok']! as JSBoolean).toDart) {
          if (_optionalFixtures.contains(f)) return;
          throw StateError('fetch $f failed');
        }
        final buf = await res.callMethod<JSPromise<JSArrayBuffer>>('arrayBuffer'.toJS).toDart;
        fs.callMethod('writeFile'.toJS, 'test/$f'.toJS, buf.toDart.asUint8List().toJS);
      }(),
  ]);
}

Future<void> main() async {
  // Before any group: the test files build Mats while declaring their tests.
  await cv.initDartcv(moduleUrl: '../build/web/dartcv.js');
  await _preload();

  group('runtime.dart', () {
    // Calls with five or more arguments go through `Reflect.apply` instead of `callAsFunction`.
    // `Function.prototype.apply` on a wasm function object runs it with no arguments at all in the
    // browser, which used to make every such call act on garbage: `Mat.fromScalar` (six arguments)
    // wrote its Mat to address 16, so every Mat came back empty.
    // dart2js has no 64-bit integers and `ByteData.getInt64` throws there, while `Net.getPerfProfile`
    // returns an `int64*` (and a struct may hold an `int64` field). The stand-in reads and writes the
    // two 32-bit halves instead.
    test('64-bit pointers round-trip on dart2js', () {
      final i = package_ffi.calloc.allocate<ffi.Int64>(8);
      addTearDown(() => package_ffi.calloc.free(i));
      for (final v in [0, 1, -1, 0x123456789, -0x123456789, 0x7FFFFFFF, -0x80000000]) {
        i.value = v;
        expect(i.value, v, reason: 'int64 ${v.toRadixString(16)}');
      }
      final u = package_ffi.calloc.allocate<ffi.Uint64>(8);
      addTearDown(() => package_ffi.calloc.free(u));
      for (final v in [0, 1, 0xFFFFFFFF, 0x100000000, 0x123456789]) {
        u.value = v;
        expect(u.value, v, reason: 'uint64 ${v.toRadixString(16)}');
      }
    });

    // The module is stamped with the version it was built from and `initDartcv()` refuses a
    // mismatch; if the build tool stops embedding it, that check silently stops working.
    // The stamp is a named export of the ES module, so read it from the namespace, not from the
    // factory's instance (`rt.module`).
    test('the wasm module reports the package version', () async {
      final namespace = await importModule('../build/web/dartcv.js'.toJS).toDart;
      final reported = namespace['dartcvVersion'];
      expect(reported, isA<JSString>(), reason: 'rebuild build/web/dartcv.js');
      expect((reported! as JSString).toDart, packageVersion);
    });

    test('a call with six arguments reaches the C wrapper', () {
      final mat = cv.Mat.fromScalar(4, 5, cv.MatType.CV_8UC3, cv.Scalar.white);
      addTearDown(mat.dispose);
      expect(
        (mat.rows, mat.cols, mat.channels, mat.type.value),
        (4, 5, 3, cv.MatType.CV_8UC3.value),
      );
    });
  });
  group('calib3d/calib3d_fisheye_test.dart', () {
    calib3d_calib3d_fisheye_test.main();
  });
  group('calib3d/calib3d_test.dart', () {
    calib3d_calib3d_test.main();
  });
  group('calib3d/stereo_test.dart', () {
    calib3d_stereo_test.main();
  });
  group('contrib/aruco_async_test.dart', () {
    contrib_aruco_async_test.main();
  });
  group('contrib/aruco_test.dart', () {
    contrib_aruco_test.main();
  });
  group('contrib/charuco_board_test.dart', () {
    contrib_charuco_board_test.main();
  });
  group('contrib/charuco_detector_async_test.dart', () {
    contrib_charuco_detector_async_test.main();
  });
  group('contrib/charuco_detector_test.dart', () {
    contrib_charuco_detector_test.main();
  });
  group('contrib/freetype_test.dart', () {
    contrib_freetype_test.main();
  });
  group('contrib/img_hash_async_test.dart', () {
    contrib_img_hash_async_test.main();
  });
  group('contrib/img_hash_test.dart', () {
    contrib_img_hash_test.main();
  });
  group('contrib/quality_test.dart', () {
    contrib_quality_test.main();
  });
  group('contrib/wechat_qrcode_async_test.dart', () {
    contrib_wechat_qrcode_async_test.main();
  });
  group('contrib/wechat_qrcode_test.dart', () {
    contrib_wechat_qrcode_test.main();
  });
  group('contrib/ximgproc_test.dart', () {
    contrib_ximgproc_test.main();
  });
  group('core/core_async_test.dart', () {
    core_core_async_test.main();
  });
  group('core/mat_async_test.dart', () {
    core_mat_async_test.main();
  });
  group('core/mat_test.dart', () {
    core_mat_test.main();
  });
  group('core/others_test.dart', () {
    core_others_test.main();
  });
  group('core/point_test.dart', () {
    core_point_test.main();
  });
  group('core/point_view_test.dart', () {
    core_point_view_test.main();
  });
  group('core/record_struct_test.dart', () {
    core_record_struct_test.main();
  });
  group('core/rng_test.dart', () {
    core_rng_test.main();
  });
  group('core/svd_test.dart', () {
    core_svd_test.main();
  });
  group('core/umat_test.dart', () {
    core_umat_test.main();
  });
  group('core/vec_test.dart', () {
    core_vec_test.main();
  });
  group('dnn/dnn_async_test.dart', () {
    dnn_dnn_async_test.main();
  });
  group('dnn/dnn_test.dart', () {
    dnn_dnn_test.main();
  });
  group('features2d/features2d_async_test.dart', () {
    features2d_features2d_async_test.main();
  });
  group('features2d/features2d_test.dart', () {
    features2d_features2d_test.main();
  });
  group('imgcodecs_test.dart', () {
    imgcodecs_test.main();
  });
  group('imgproc/clahe_test.dart', () {
    imgproc_clahe_test.main();
  });
  group('imgproc/imgproc_async_test.dart', () {
    imgproc_imgproc_async_test.main();
  });
  group('imgproc/imgproc_test.dart', () {
    imgproc_imgproc_test.main();
  });
  group('imgproc/linesegmentdetector_test.dart', () {
    imgproc_linesegmentdetector_test.main();
  });
  group('imgproc/subdiv2d_test.dart', () {
    imgproc_subdiv2d_test.main();
  });
  group('ml/ann_mlp_test.dart', () {
    ml_ann_mlp_test.main();
  });
  group('ml/boost_test.dart', () {
    ml_boost_test.main();
  });
  group('ml/dtrees_test.dart', () {
    ml_dtrees_test.main();
  });
  group('ml/em_test.dart', () {
    ml_em_test.main();
  });
  group('ml/knearest_test.dart', () {
    ml_knearest_test.main();
  });
  group('ml/logistic_regression_test.dart', () {
    ml_logistic_regression_test.main();
  });
  group('ml/ml_async_test.dart', () {
    ml_ml_async_test.main();
  });
  group('ml/normal_bayes_classifier_test.dart', () {
    ml_normal_bayes_classifier_test.main();
  });
  group('ml/rtrees_test.dart', () {
    ml_rtrees_test.main();
  });
  group('ml/stat_model_test.dart', () {
    ml_stat_model_test.main();
  });
  group('ml/svm_test.dart', () {
    ml_svm_test.main();
  });
  group('ml/svmsgd_test.dart', () {
    ml_svmsgd_test.main();
  });
  group('ml/train_data_test.dart', () {
    ml_train_data_test.main();
  });
  group('objdetect/objdetect_async_test.dart', () {
    objdetect_objdetect_async_test.main();
  });
  group('objdetect/objdetect_test.dart', () {
    objdetect_objdetect_test.main();
  });
  group('photo/photo_async_test.dart', () {
    photo_photo_async_test.main();
  });
  group('photo/photo_test.dart', () {
    photo_photo_test.main();
  });
  group('stitching/stitching_async_test.dart', () {
    stitching_stitching_async_test.main();
  });
  group('stitching/stitching_test.dart', () {
    stitching_stitching_test.main();
  });
  group('video/video_async_test.dart', () {
    video_video_async_test.main();
  });
  group('video/video_test.dart', () {
    video_video_test.main();
  });
  group('videoio/videoio_registry_test.dart', () {
    videoio_videoio_registry_test.main();
  });
}
