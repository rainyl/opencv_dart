# Define the platform and architecture
# Default architecture is x64 if not specified
OPENCV_DART_ARCH ?= fat
VALID_ARCHS := x64 arm64 fat

# Get the parent directory of the current working directory
PARENT_DIR := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))..
SETUP_CMD := cd $(PARENT_DIR) && conan build . -b missing -o post_install=False
LIPO_CMD := cd $(PARENT_DIR) && lipo

# Function to check if a value is in a list
check_in_list = $(filter $(1),$(2))

define patch_profile
	@echo "Patching $(1)"
	@sed -i .bak '/user_toolchain/d' $(1)
	@cd $(PARENT_DIR) && echo "tools.cmake.cmaketoolchain:user_toolchain=[\"`pwd`/profiles/ios.toolchain.cmake\"]" >> $(1)
endef

.PHONY: setup build_arm64 build_x64 build prepare_profile copy_arm64 copy_x64

build: build_x64 build_arm64
	@echo "Creating directory ios/opencv_dart.framework"
	@cd $(PARENT_DIR) && mkdir -p ios/opencv_dart.framework && \
		cp build/ios/arm64/install/opencv_dart.framework/Info.plist ios/opencv_dart.framework/ && \
		/usr/libexec/PlistBuddy -c "Add :CFBundleSupportedPlatforms: string iPhoneSimulator" "ios/opencv_dart.framework/Info.plist"
	@$(LIPO_CMD) \
		build/ios/arm64/install/opencv_dart.framework/opencv_dart \
		build/ios/x64/install/opencv_dart.framework/opencv_dart \
		-create -output ios/opencv_dart.framework/opencv_dart

prepare_profile:
	$(call patch_profile,$(PARENT_DIR)/profiles/ios-x86_64)
	$(call patch_profile,$(PARENT_DIR)/profiles/ios-armv8)

build_arm64: prepare_profile
	# cd $(PARENT_DIR)/profiles/ios-cmake && conan create . -b missing -pr:h ../ios-armv8
	@$(SETUP_CMD) -pr:h profiles/ios-armv8 -o output_dir=build/ios/arm64
build_x64: prepare_profile
	# cd $(PARENT_DIR)/profiles/ios-cmake && conan create . -b missing -pr:h ../ios-x86_64
	@$(SETUP_CMD) -pr:h profiles/ios-x86_64 -o output_dir=build/ios/x64

copy_arm64:
	@echo "Copying build/ios/arm64/install/opencv_dart.framework -> ios/opencv_dart.framework"
	@cd $(PARENT_DIR) && cp -R build/ios/arm64/install/opencv_dart.framework ios/
copy_x64:
	@echo "Copying build/ios/x64/install/opencv_dart.framework -> ios/opencv_dart.framework"
	@cd $(PARENT_DIR) && cp -R build/ios/x64/install/opencv_dart.framework ios/

ifdef OPENCV_DART_DISABLE_AUTO_BUILD
setup:
	@echo "OPENCV_DART_DISABLE_AUTO_BUILD detected, skipping setup..."
else
setup:
	@echo "Auto-selected architecture: $(OPENCV_DART_ARCH)"
	@echo "You can override this by setting the OPENCV_DART_ARCH environment variable. Valid options: x64, arm64"
ifdef OPENCV_DART_DISABLE_AUTO_BUILD
	@exit 0
endif
ifeq ($(OPENCV_DART_ARCH),x64)
	@echo "Running setup with architecture: $(OPENCV_DART_ARCH)"
	${MAKE} build_x64
	${MAKE} copy_x64
else ifeq ($(OPENCV_DART_ARCH),arm64)
	@echo "Running setup with architecture: $(OPENCV_DART_ARCH)"
	${MAKE} build_arm64
	${MAKE} copy_arm64
else ifeq ($(OPENCV_DART_ARCH),fat)
	@echo "Running setup with architecture: x86_64, arm64"
	${MAKE} build
else
	@echo "Unsupported architecture: $(OPENCV_DART_ARCH). Valid options are: x64, arm64"
	@exit 1
endif
endif
