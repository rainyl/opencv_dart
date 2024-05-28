# Define the platform and architecture
PLATFORM := $(shell uname)
ARCH ?= arm64  # Default architecture is arm64 if not specified
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
ifeq ($(PLATFORM),Darwin)
	@echo "Detected iOS platform"
	@echo "Auto-selected architecture: arm64"
	@echo "You can override this by setting the ARCH environment variable. Valid options: x64, arm64"
ifeq ($(call check_in_list,$(ARCH),$(VALID_ARCHS)),)
	@echo "Unsupported architecture for iOS: $(ARCH). Valid options are: x64, arm64"
	@exit 1
else
	@echo "Running setup for iOS with architecture: $(ARCH)"
	@$(SETUP_CMD) ios --arch $(ARCH)
endif
else
	@echo "This setup only runs on macOS"
	@exit 1
endif
