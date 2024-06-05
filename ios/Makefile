# Define the platform and architecture
# Default architecture is arm64 if not specified
OPENCV_DART_ARCH ?= arm64
VALID_ARCHS := x64 arm64

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

# Get the parent directory of the current working directory
PARENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..
SETUP_CMD := cd $(PARENT_DIR) && conan build . -b missing

.PHONY: setup build_arm64 build_x64

build_arm64:
	@$(SETUP_CMD) -pr:h profiles/ios-armv8 -o output_dir=build/ios/arm64
build_x64:
	@$(SETUP_CMD) -pr:h profiles/ios-x86_64 -o output_dir=build/ios/x64

setup:
	@echo "Auto-selected architecture: $(OPENCV_DART_ARCH)"
	@echo "You can override this by setting the OPENCV_DART_ARCH environment variable. Valid options: x64, arm64"
ifdef OPENCV_DART_DISABLE_AUTO_BUILD
	@exit 0
endif
ifeq ($(OPENCV_DART_ARCH),x64)
	@echo "Running setup with architecture: $(OPENCV_DART_ARCH)"
	${MAKE} build_x64
else ifeq ($(OPENCV_DART_ARCH),arm64)
	@echo "Running setup with architecture: $(OPENCV_DART_ARCH)"
	${MAKE} build_arm64
else
	@echo "Unsupported architecture: $(OPENCV_DART_ARCH). Valid options are: x64, arm64"
	@exit 1
endif
