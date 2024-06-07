# Get the parent directory of the current working directory
PARENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..
SETUP_CMD := cd $(PARENT_DIR) && dart run opencv_dart:setup ios --arch os64

.PHONY: setup

ifdef OPENCV_DART_DISABLE_AUTO_BUILD
setup:
	@echo "OPENCV_DART_DISABLE_AUTO_BUILD detected, skipping setup..."
else
setup:
	@echo "Running auto setup, command: $(SETUP_CMD)"
	@$(SETUP_CMD)
endif
