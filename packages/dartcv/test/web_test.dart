// Runs the package's own tests in a browser against the WebAssembly build:
//
//   tool/web/build_wasm.sh            # writes build/web/dartcv.{mjs,wasm}
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
import 'core/rng_test.dart' as core_rng_test;
import 'core/svd_test.dart' as core_svd_test;
import 'core/umat_test.dart' as core_umat_test;
import 'core/vec_test.dart' as core_vec_test;
import 'features2d/features2d_async_test.dart' as features2d_features2d_async_test;
import 'features2d/features2d_test.dart' as features2d_features2d_test;
import 'imgproc/clahe_test.dart' as imgproc_clahe_test;
import 'imgproc/imgproc_async_test.dart' as imgproc_imgproc_async_test;
import 'imgproc/imgproc_test.dart' as imgproc_imgproc_test;
import 'imgproc/linesegmentdetector_test.dart' as imgproc_linesegmentdetector_test;
import 'imgproc/subdiv2d_test.dart' as imgproc_subdiv2d_test;
import 'photo/photo_async_test.dart' as photo_photo_async_test;
import 'photo/photo_test.dart' as photo_photo_test;
import 'stitching/stitching_async_test.dart' as stitching_stitching_async_test;
import 'stitching/stitching_test.dart' as stitching_stitching_test;
import 'video/video_async_test.dart' as video_video_async_test;
import 'video/video_test.dart' as video_video_test;
import 'videoio/videoio_registry_test.dart' as videoio_videoio_registry_test;

// test/models is downloaded by CI (release tag dnn_test_files); a missing model only fails its own test.
const _optionalFixtures = [
  'models/detect.caffemodel',
  'models/detect.prototxt',
  'models/sr.caffemodel',
  'models/sr.prototxt',
  'models/structure_edge_model.yml',
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
  await cv.initDartcv(moduleUrl: '../build/web/dartcv.mjs');
  await _preload();
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
  group('features2d/features2d_async_test.dart', () {
    features2d_features2d_async_test.main();
  });
  group('features2d/features2d_test.dart', () {
    features2d_features2d_test.main();
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
