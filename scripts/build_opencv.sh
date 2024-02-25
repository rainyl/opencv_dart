build_type="Release"
platform="x64"
os="linux"

base_dir=`pwd`
build_dir="$base_dir/build/opencv/$os-$platform"
mkdir -p $build_dir
cd $build_dir

opencv_dir="$base_dir/src/opencv"
opencv_contrib_dir="$base_dir/src/opencv_contrib/modules"

cmake -G "Unix Makefiles" \
    -D CMAKE_BUILD_TYPE=$build_type \
    -D CMAKE_INSTALL_PREFIX=install \
    -D INSTALL_C_EXAMPLES=OFF \
    -D INSTALL_PYTHON_EXAMPLES=OFF \
    -D BUILD_DOCS=OFF \
    -D BUILD_WITH_DEBUG_INFO=OFF \
    -D BUILD_DOCS=OFF \
    -D BUILD_EXAMPLES=OFF \
    -D BUILD_TESTS=OFF \
    -D BUILD_PERF_TESTS=OFF \
    -D BUILD_JAVA=OFF \
    -D BUILD_WITH_DEBUG_INFO=OFF \
    -D BUILD_opencv_apps=OFF \
    -D BUILD_opencv_datasets=OFF \
    -D BUILD_opencv_gapi=OFF \
    -D BUILD_opencv_java_bindings_generator=OFF \
    -D BUILD_opencv_js=OFF \
    -D BUILD_opencv_js_bindings_generator=OFF \
    -D BUILD_opencv_objc_bindings_generator=OFF \
    -D BUILD_opencv_python_bindings_generator=OFF \
    -D BUILD_opencv_python_tests=OFF \
    -D BUILD_opencv_ts=OFF \
    -D BUILD_opencv_world=OFF \
    -D WITH_MSMF=OFF \
    -D WITH_MSMF_DXVA=OFF \
    -D WITH_QT=OFF \
    -D WITH_FREETYPE=OFF \
    -D WITH_TESSERACT=OFF \
    -D WITH_OBSSENSOR=OFF \
    -D WITH_LAPACK=ON \
    -D ENABLE_CXX11=1 \
    -D ENABLE_PRECOMPILED_HEADERS=OFF \
    -D CMAKE_NO_SYSTEM_FROM_IMPORTED=ON \
    -D OPENCV_ENABLE_NONFREE=OFF \
    -D OPENCV_EXTRA_MODULES_PATH=$opencv_contrib_dir \
    -D BUILD_SHARED_LIBS=OFF $opencv_dir

cmake --build . -j 20 --target install

cd $base_dir
