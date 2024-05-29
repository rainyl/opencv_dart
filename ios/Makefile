# Define the platform and architecture
OPENCV_DART_ARCH ?= arm64  # Default architecture is arm64 if not specified
VALID_ARCHS := x64 arm64

# Dart command
DART_CMD := dart run opencv_dart:setup

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

# Get the parent directory of the current working directory
PARENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..
SETUP_CMD := cd $(PARENT_DIR) && $(DART_CMD)

.PHONY: setup

setup:
	@echo "Auto-selected architecture: $(OPENCV_DART_ARCH)"
	@echo "You can override this by setting the OPENCV_DART_ARCH environment variable. Valid options: x64, arm64"
ifeq ($(call check_in_list,$(OPENCV_DART_ARCH),$(VALID_ARCHS)),)
	@echo "Unsupported architecture: $(OPENCV_DART_ARCH). Valid options are: x64, arm64"
	@exit 1
else
	@echo "Running setup with architecture: $(OPENCV_DART_ARCH)"
	@$(SETUP_CMD) ios --arch $(OPENCV_DART_ARCH)
endif
