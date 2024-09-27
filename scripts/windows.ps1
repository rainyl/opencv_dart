cmake -T v142,host=x64 `
-A ARM64 `
-DCMAKE_SYSTEM_NAME=Windows `
-DCMAKE_SYSTEM_PROCESSOR=ARM64 `
-DCMAKE_BUILD_TYPE=Release `
-DCMAKE_INSTALL_PREFIX=install `
-DCMAKE_POLICY_DEFAULT_CMP0074=NEW `
-DCVD_PLATFORM_INSTALL_DIR="D:\flutter\opencv_dart\windows" `
-DFFMPEG_DIR="D:\flutter\opencv_dart\build\Windows\libopencv-windows-arm64\ffmpeg\cmake" `
-DOpenCV_DIR="D:\flutter\opencv_dart\build\Windows\libopencv-windows-arm64" ../../..
