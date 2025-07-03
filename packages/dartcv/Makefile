.PHONY: ffigen ffigen_test clone_repo clean_repo test test_coverage

DART_EXEC := $(abspath $(dir $(shell which dart)))/cache/dart-sdk/bin/dart
UNAME_S := $(shell uname -s)

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


clone_repo:
	echo "Getting submodules"
	@git submodule update --init --recursive

	echo "Updating submodules"
	@git submodule update --remote

ffigen_test: clone_repo
	dart run ffigen --config ffigen/ffigen_types.yaml
	dart run ffigen --config ffigen/ffigen_core.yaml

test:
ifeq ($(UNAME_S),Darwin)
	DYLD_LIBRARY_PATH=`pwd`/libdartcv/lib $(DART_EXEC) test
else
	LD_LIBRARY_PATH=`pwd`/libdartcv/lib $(DART_EXEC) test
endif

test_coverage:
ifeq ($(UNAME_S),Darwin)
	DYLD_FALLBACK_LIBRARY_PATH=`pwd`/libdartcv/lib $(DART_EXEC) pub global run coverage:test_with_coverage
else
	LD_LIBRARY_PATH=`pwd`/libdartcv/lib $(DART_EXEC) pub global run coverage:test_with_coverage
endif
