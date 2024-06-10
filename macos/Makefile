# Define the platform and architecture
PLATFORM := $(shell uname)
OPENCV_DART_ARCH ?= $(shell uname -m)

# Check and redirect x86_64 to x64
ifeq ($(OPENCV_DART_ARCH),x86_64)
	OPENCV_DART_ARCH := x64
endif

# MacOS specific architectures
MACOS_ARCHS := x64 arm64

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

# Get the parent directory of the current makefile
WORK_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))
VERSION := $(shell cat $(WORK_DIR)/../binary.version)
LIB_NAME := "libopencv_dart-macos-$(OPENCV_DART_ARCH).tar.gz"
CVD_LIB_URL := "https://github.com/rainyl/opencv_dart/releases/download/v${VERSION}/$(LIB_NAME)"

.PHONY: setup

ifdef OPENCV_DART_DISABLE_AUTO_BUILD
setup:
	@echo "OPENCV_DART_DISABLE_AUTO_BUILD detected, skipping setup..."
else
setup:
ifeq ($(PLATFORM),Darwin)
	@echo "Detected macOS platform"
ifeq ($(call check_in_list,$(OPENCV_DART_ARCH),$(MACOS_ARCHS)),)
	@echo "Unsupported architecture for macOS: $(OPENCV_DART_ARCH)"
	@exit 1
else
ifeq ($(shell test -s $(WORK_DIR)/libopencv_dart.dylib && echo true),true)
	@echo "Found $(WORK_DIR)/libopencv_dart.dylib, skipping..."
else
ifeq ($(shell test -s $(WORK_DIR)/$(LIB_NAME) && echo true),true)
	@echo "Found $(WORK_DIR)/$(LIB_NAME), extracting..."
	@cd $(WORK_DIR) && tar -xzf $(LIB_NAME)
else
	@echo "Running setup for macOS with architecture: $(OPENCV_DART_ARCH)"
	@cd $(WORK_DIR) && wget -O $(LIB_NAME) $(CVD_LIB_URL) && tar -xzf $(LIB_NAME)
endif
endif
endif
else
	@echo "This setup only runs on macOS"
	@exit 1
endif
endif
