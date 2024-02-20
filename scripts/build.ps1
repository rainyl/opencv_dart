$baseDir = $pwd
$platform = "x64"
$buildType = "Release"
$os = "windows"

$buildDirectory = "build/opencv_dart/${os}-${platform}-${buildType}"
mkdir $buildDirectory -Force -ErrorAction Stop | Out-Null
cd $buildDirectory
echo "Working in $pwd"

cmake -G "MinGW Makefiles" `
    -D CMAKE_BUILD_TYPE=$buildType `
    -D CMAKE_INSTALL_PREFIX=install `
    "$baseDir/src"

cmake --build . -j 16 --target install

cd $baseDir
