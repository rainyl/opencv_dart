build_type="Release"
platform="x64"
os="linux"

base_dir=`pwd`
build_dir="$base_dir/build/opencv_dart/$os-$platform-$build_type"
mkdir -p $build_dir
cd $build_dir

cmake -G "Unix Makefiles" \
    -D CMAKE_BUILD_TYPE=$build_type \
    -D CMAKE_INSTALL_PREFIX=install \
    "$base_dir/src"

cmake --build . -j 20 --target install

cd $base_dir
