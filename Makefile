.PHONY: ffigen ffigen_test

ffigen:
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_calib3d.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_contrib.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_core.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_dnn.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_features2d.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_gapi.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_highgui.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_imgcodecs.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_imgproc.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_objdetect.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_photo.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_stitching.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_types.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_video_io.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_const.yaml

ffigen_test:
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_types.yaml
	dart --enable-experiment=native-assets run ffigen --config ffigen/ffigen_core.yaml
