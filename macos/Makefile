# Define the platform and architecture
PLATFORM := $(shell uname)
ARCH := $(shell uname -m)

# MacOS specific architectures
MACOS_ARCHS := x64 arm64

# Dart command
DART_CMD := dart run opencv_dart:setup

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

.PHONY: setup

setup:
ifeq ($(PLATFORM),Darwin)
	@echo "Detected macOS platform"
ifeq ($(call check_in_list,$(ARCH),$(MACOS_ARCHS)),)
	@echo "Unsupported architecture for macOS: $(ARCH)"
	@exit 1
else
	@echo "Running setup for macOS with architecture: $(ARCH)"
	$(DART_CMD) macos --arch $(ARCH)
endif
else
	@echo "This setup only runs on macOS"
	@exit 1
endif
