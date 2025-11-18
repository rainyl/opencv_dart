.PHONY: ffigen ffigen_test

ffigen:
	dart run ffigen --config ffigen/ffigen_const.yaml
	dart run ffigen --config ffigen/ffigen_types.yaml
	dart run ffigen --config ffigen/ffigen_core.yaml
	dart run ffigen --config ffigen/ffigen_calib3d.yaml
	dart run ffigen --config ffigen/ffigen_contrib.yaml
	dart run ffigen --config ffigen/ffigen_dnn.yaml
	dart run ffigen --config ffigen/ffigen_features2d.yaml
	dart run ffigen --config ffigen/ffigen_gapi.yaml
	dart run ffigen --config ffigen/ffigen_highgui.yaml
	dart run ffigen --config ffigen/ffigen_imgcodecs.yaml
	dart run ffigen --config ffigen/ffigen_imgproc.yaml
	dart run ffigen --config ffigen/ffigen_objdetect.yaml
	dart run ffigen --config ffigen/ffigen_photo.yaml
	dart run ffigen --config ffigen/ffigen_stitching.yaml
	dart run ffigen --config ffigen/ffigen_video.yaml
	dart run ffigen --config ffigen/ffigen_videoio.yaml

ffigen_test:
	dart run ffigen --config ffigen/ffigen_types.yaml
	dart run ffigen --config ffigen/ffigen_core.yaml
