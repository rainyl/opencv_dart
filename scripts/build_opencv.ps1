$buildType = "Release"
$platform = "x64"
$os = "windows"

$baseDir = $pwd

$buildDirectory = "$baseDir/build/opencv/${os}-${platform}"
mkdir $buildDirectory -Force -ErrorAction Stop | Out-Null
cd $buildDirectory
echo "Working in $pwd"

$opencvDir = "$baseDir/src/opencv"
$opencvContribDir = "$baseDir/src/opencv_contrib/modules"


cmake -G "MinGW Makefiles" `
    -D CMAKE_BUILD_TYPE=$buildType `
    -D CMAKE_INSTALL_PREFIX=install `
    -D INSTALL_C_EXAMPLES=OFF `
    -D INSTALL_PYTHON_EXAMPLES=OFF `
    -D BUILD_DOCS=OFF `
    -D BUILD_WITH_DEBUG_INFO=OFF `
    -D BUILD_DOCS=OFF `
    -D BUILD_EXAMPLES=OFF `
    -D BUILD_TESTS=OFF `
    -D BUILD_PERF_TESTS=OFF `
    -D BUILD_JAVA=OFF `
    -D BUILD_WITH_DEBUG_INFO=OFF `
    -D BUILD_opencv_apps=OFF `
    -D BUILD_opencv_datasets=OFF `
    -D BUILD_opencv_gapi=OFF `
    -D BUILD_opencv_java_bindings_generator=OFF `
    -D BUILD_opencv_js=OFF `
    -D BUILD_opencv_js_bindings_generator=OFF `
    -D BUILD_opencv_objc_bindings_generator=OFF `
    -D BUILD_opencv_python_bindings_generator=OFF `
    -D BUILD_opencv_python_tests=OFF `
    -D BUILD_opencv_ts=OFF `
    -D BUILD_opencv_world=OFF `
    -D WITH_MSMF=OFF `
    -D WITH_MSMF_DXVA=OFF `
    -D WITH_QT=OFF `
    -D WITH_FREETYPE=OFF `
    -D WITH_TESSERACT=OFF `
    -D WITH_OBSSENSOR=OFF `
    -D WITH_LAPACK=ON `
    -D ENABLE_CXX11=1 `
    -D ENABLE_PRECOMPILED_HEADERS=OFF `
    -D CMAKE_NO_SYSTEM_FROM_IMPORTED=ON `
    -D OPENCV_ENABLE_NONFREE=OFF `
    -D OPENCV_EXTRA_MODULES_PATH=$opencvContribDir `
    -D BUILD_SHARED_LIBS=ON $opencvDir

cmake --build . -j 16 --target install

cd $baseDir
