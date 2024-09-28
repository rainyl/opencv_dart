cmake -T v142,host=x64 `
-A ARM64 `
-DCMAKE_SYSTEM_NAME=Windows `
-DCMAKE_SYSTEM_PROCESSOR=ARM64 `
-DCMAKE_BUILD_TYPE=Release `
-DCMAKE_INSTALL_PREFIX=install `
-DCMAKE_POLICY_DEFAULT_CMP0074=NEW `
-DCVD_PLATFORM_INSTALL_DIR="$pwd\windows" `
-DFFMPEG_DIR="D:\flutter\opencv.full\ffmpeg-n6.1-latest-winarm64-lgpl-shared-6.1\cmake" `
-DOpenCV_DIR="D:\flutter\opencv.full\opencv\arm64\install" ../../..
