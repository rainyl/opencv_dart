# Define the platform and architecture
PLATFORM := $(shell uname)
OPENCV_DART_ARCH ?= $(shell uname -m)

# MacOS specific architectures
MACOS_ARCHS := x64 arm64

# Build command
BUILD_CMD := conan

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

# Get the parent directory of the current working directory
PARENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..
SETUP_CMD := cd $(PARENT_DIR) && $(BUILD_CMD)

.PHONY: setup

setup:
ifndef OPENCV_DART_DISABLE_AUTO_BUILD
  ifeq ($(PLATFORM),Darwin)
    @echo "Detected macOS platform"
    ifeq ($(call check_in_list,$(OPENCV_DART_ARCH),$(MACOS_ARCHS)),)
      @echo "Unsupported architecture for macOS: $(OPENCV_DART_ARCH)"
      @exit 1
    else
      @echo "Running setup for macOS with architecture: $(OPENCV_DART_ARCH)"
      @$(SETUP_CMD) build . -b missing -o output_dir=build/macos/$(OPENCV_DART_ARCH)
    endif
  else
    @echo "This setup only runs on macOS"
    @exit 1
  endif
endif
