# Define the platform and architecture
PLATFORM := $(shell uname)

# Get the parent directory of the current makefile
WORK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VERSION := $(shell cat $(WORK_DIR)/../binary.version)
LIB_NAME := "libopencv_dart-ios-os64.tar.gz"
CVD_LIB_URL := "https://github.com/rainyl/opencv_dart/releases/download/v${VERSION}/$(LIB_NAME)"

.PHONY: setup

ifdef OPENCV_DART_DISABLE_AUTO_BUILD
setup:
	@echo "OPENCV_DART_DISABLE_AUTO_BUILD detected, skipping setup..."
else
setup:
ifeq ($(PLATFORM),Darwin)
	@echo "Detected macOS platform"
ifeq ($(shell test -s $(WORK_DIR)/opencv_dart.xcframework/Info.plist && echo true),true)
	@echo "Found $(WORK_DIR)/opencv_dart.xcframework/Info.plist, skipping..."
else
ifeq ($(shell test -s $(WORK_DIR)/$(LIB_NAME) && echo true),true)
	@echo "Found $(WORK_DIR)/$(LIB_NAME), extracting..."
	@cd $(WORK_DIR) && tar -xzf $(LIB_NAME)
else
	@echo "Running setup for iOS with architecture: $(OPENCV_DART_ARCH)"
	@cd $(WORK_DIR) && wget -O $(LIB_NAME) $(CVD_LIB_URL) && tar -xzf $(LIB_NAME)
endif
endif
else
	@echo "This setup only runs on macOS"
	@exit 1
endif
endif
