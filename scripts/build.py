import os
import sys
import shutil
from pathlib import Path
from argparse import ArgumentParser, Namespace


LIB_NAME = "libopencv_dart"


def cmake_generate(args: Namespace):
    src_dir = Path(args.src).absolute()

    cmake = "cmake "
    match args.os:
        case "windows":
            cmake += '-G "Ninja" '
        case "linux":
            cmake += '-G "Ninja" '
        case "android":
            ndk = Path(args.ndk)
            if not ndk.exists():
                raise FileNotFoundError(f"Android NDK not found at {ndk}")
            cmake += (
                '-G "Ninja" '
                "-D ANDROID_STL=c++_static "
                f"-D ANDROID_NDK={ndk} "
                "-D ANDROID_TOOLCHAIN=clang "
                f"-D CMAKE_TOOLCHAIN_FILE={ndk}/build/cmake/android.toolchain.cmake "
                f"-D ANDROID_ABI={args.abi} "
                # f"-D ANDROID_PLATFORM=android-$MINSDKVERSION"
            )
        case "macos":
            cmake += '-G "Unix Makefiles" '
            raise NotImplementedError
        case "ios":
            cmake += '-G "Unix Makefiles" '
            raise NotImplementedError
        case _:
            raise NotImplementedError
    if args.opencv:
        cmd = (
            f"{cmake} "
            "-D CMAKE_BUILD_TYPE=Release "
            "-D CMAKE_INSTALL_PREFIX=install "
            "-D INSTALL_C_EXAMPLES=OFF "
            "-D INSTALL_PYTHON_EXAMPLES=OFF "
            "-D BUILD_DOCS=OFF "
            "-D BUILD_WITH_DEBUG_INFO=OFF "
            "-D BUILD_EXAMPLES=OFF "
            "-D BUILD_TESTS=OFF "
            "-D BUILD_PERF_TESTS=OFF "
            "-D BUILD_JAVA=OFF "
            "-D BUILD_WITH_DEBUG_INFO=OFF "
            "-D BUILD_opencv_apps=OFF "
            "-D BUILD_opencv_datasets=OFF "
            "-D BUILD_opencv_gapi=OFF "
            "-D BUILD_opencv_java_bindings_generator=OFF "
            "-D BUILD_opencv_js=OFF "
            "-D BUILD_opencv_js_bindings_generator=OFF "
            "-D BUILD_opencv_objc_bindings_generator=OFF "
            "-D BUILD_opencv_python_bindings_generator=OFF "
            "-D BUILD_opencv_python_tests=OFF "
            "-D BUILD_opencv_ts=OFF "
            "-D BUILD_opencv_world=OFF "
            "-D WITH_MSMF=OFF "
            "-D WITH_MSMF_DXVA=OFF "
            "-D WITH_QT=OFF "
            "-D WITH_FREETYPE=OFF "
            "-D WITH_TESSERACT=OFF "
            "-D WITH_OBSSENSOR=OFF "
            "-D WITH_LAPACK=ON "
            "-D ENABLE_CXX11=1 "
            "-D ENABLE_PRECOMPILED_HEADERS=OFF "
            "-D CMAKE_NO_SYSTEM_FROM_IMPORTED=ON "
            "-D OPENCV_ENABLE_NONFREE=OFF "
            f"-D OPENCV_EXTRA_MODULES_PATH={args.extra_modules} "
            "-D BUILD_SHARED_LIBS=OFF "
            f"{src_dir} "
        )
    elif args.dart:
        cmd = (
            f"{cmake} "
            "-D CMAKE_BUILD_TYPE=Release "
            "-D CMAKE_INSTALL_PREFIX=install "
            f"{src_dir} "
        )
    else:
        raise NotImplementedError
    print(cmd)
    os.system(cmd)


def cmake_build(args: Namespace):
    cmd = f"cmake --build . -j {os.cpu_count()*2} --target install"
    os.system(cmd)


def main(args: Namespace):
    args.src = Path(args.src).absolute()
    build_sub = "opencv_dart" if args.dart else "opencv"
    if args.os == "android":
        args.arch = args.abi
    args.dst = (
        Path(args.build_dir).absolute() / build_sub / f"{args.os}" / f"{args.arch}"
    )
    args.extra_modules = Path(args.extra_modules).absolute()
    if not args.dst.exists():
        args.dst.mkdir(parents=True)
    os.chdir(args.dst)
    cmake_generate(args)
    cmake_build(args)
    os.chdir(args.work_dir)

    lib_copy_to_dir = ""
    lib_name_suffix = ""
    match args.os:
        case "windows":
            lib_copy_to_dir = args.work_dir / args.os
            lib_name_suffix = ".dll"
        case "android":
            lib_copy_to_dir = args.work_dir / args.os / "src" / "main" / "jniLibs" / args.abi
            lib_name_suffix = ".so"
        case "linux":
            lib_copy_to_dir = args.work_dir / args.os
            lib_name_suffix = ".so"
        case "macos" | "ios":
            lib_copy_to_dir = f"{LIB_NAME}.dylib"
            lib_name_suffix = ".dylib"
            raise NotImplementedError
        case _:
            raise NotImplementedError
    if not lib_copy_to_dir.exists():
        lib_copy_to_dir.mkdir(parents=True)

    publish_dir = args.work_dir / "build" / "publish"
    if not publish_dir.exists():
        publish_dir.mkdir(parents=True)
    
    lib = Path(args.dst) / "install" / f"{LIB_NAME}{lib_name_suffix}"
    shutil.copy(lib, lib_copy_to_dir)
    print(f"copy {lib} to {lib_copy_to_dir}")
    lib_pub = publish_dir/f"{LIB_NAME}-{args.os}-{args.arch}{lib_name_suffix}"
    shutil.copy(lib, lib_pub)
    print(f"copy {lib} to {lib_pub}")


if __name__ == "__main__":
    work_dir = Path(__file__).parent.parent.absolute()
    parser = ArgumentParser()
    parser.add_argument("--opencv", dest="opencv", action="store_true", default=False)
    parser.add_argument("--dart", dest="dart", action="store_true", default=False)

    parser.add_argument(
        "--os",
        dest="os",
        type=str,
        default="windows",
        choices=["windows", "linux", "android", "macos", "ios"],
    )
    parser.add_argument(
        "--arch",
        dest="arch",
        type=str,
        default="x64",
        choices=["x64", "x86", "arm64", "arm"],
    )

    parser.add_argument(
        "--src",
        dest="src",
        type=str,
        default=str((work_dir / "src").absolute()),
    )
    parser.add_argument(
        "--build-dir",
        dest="build_dir",
        type=str,
        default=str((work_dir / "build").absolute()),
    )
    parser.add_argument(
        "--extra-modules",
        dest="extra_modules",
        type=str,
        default=str((work_dir / "src" / "opencv_contrib" / "modules").absolute()),
    )
    parser.add_argument(
        "--android-ndk",
        dest="ndk",
        type=str,
        default=os.environ.get("ANDROID_NDK_HOME", ""),
    )
    parser.add_argument(
        "--android-abi",
        dest="abi",
        type=str,
        default="arm64-v8a",
        choices=["arm64-v8a", "armeabi-v7a", "x86", "x86_64"],
    )

    args = parser.parse_args()
    args.work_dir = work_dir
    main(args)
