.PHONY: ffigen ffigen_test clone_repo clean_repo

REPO_URL=https://github.com/rainyl/dartcv.git
TEMP_DIR=temp_repo
SRC_DIR=src/dartcv

ffigen: clone_repo
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
	$(MAKE) clean_repo

# Clone the repo and move only the dartcv directory
clone_repo:
	@if [ -d "$(SRC_DIR)" ]; then \
		echo "Directory $(SRC_DIR) exists. Deleting it."; \
		rm -rf $(SRC_DIR); \
	fi; \
	if [ -d "$(TEMP_DIR)" ]; then \
		rm -rf $(TEMP_DIR); \
	fi; \
	echo "Cloning repository..."; \
	git clone $(REPO_URL) $(TEMP_DIR); \
	echo "Moving dartcv directory to $(SRC_DIR)..."; \
	mkdir -p src; \
	mv $(TEMP_DIR)/dartcv $(SRC_DIR); \
	echo "Cleaning up temporary files..."; \
	rm -rf $(TEMP_DIR);
	
copy_files:
	mkdir -p src; \
	mv $(TEMP_DIR)/dartcv $(SRC_DIR); 
# Clean up the dartcv directory from the src directory
clean_repo:
	@rm -rf $(SRC_DIR)
	@rm -rf $(TEMP_DIR)

ffigen_test: clone_repo
	dart run ffigen --config ffigen/ffigen_types.yaml
	dart run ffigen --config ffigen/ffigen_core.yaml
	$(MAKE) clean_repo
