import os
import sys
import shutil
from pathlib import Path
from argparse import ArgumentParser, Namespace
import tarfile


LIB_NAME = "opencv_dart"


def generate_windows(args: Namespace):
    arch = "x64" if args.arch == "x64" else "Win32"
    cmake_cmd = (
        "cmake "
        # f"-D CMAKE_TOOLCHAIN_FILE={args.dst / 'conan_toolchain.cmake'} "
        # '-G "Visual Studio 16 2019" '
        "-D BUILD_WITH_STATIC_CRT=OFF "
        f"-D CMAKE_GENERATOR_PLATFORM={arch} "
    )
    return cmake_cmd


def generate_linux(args: Namespace):
    flags = (
        "-D CMAKE_C_FLAGS=-m32 -D CMAKE_CXX_FLAGS=-m32" if args.arch == "x86" else ""
    )
    cmake_cmd = f'cmake -G "Ninja" -D OPENCV_DART_ARCH={args.arch} {flags} '
    return cmake_cmd


def generate_macos(args: Namespace):
    target = "arm64-apple-macos" if args.arch == "arm64" else "x86_64-apple-macos"
    cmake_cmd = (
        "cmake "
        f'-G "Ninja" -D OPENCV_DART_ARCH={args.arch} '
        f"-D CMAKE_CXX_FLAGS='-target {target}' "
        f"-D CMAKE_C_FLAGS='-target {target}' "
    )
    return cmake_cmd


def generate_android(args: Namespace):
    if not args.ndk.exists():
        raise FileNotFoundError(f"Android NDK not found at {args.ndk}")
    cmake_cmd = (
        "cmake "
        '-G "Ninja" '
        "-D ANDROID_STL=c++_static "
        f"-D ANDROID_NDK={args.ndk} "
        "-D ANDROID_TOOLCHAIN=clang "
        f"-D CMAKE_TOOLCHAIN_FILE={args.ndk}/build/cmake/android.toolchain.cmake "
        f"-D ANDROID_ABI={args.arch} "
        # f"-D ANDROID_PLATFORM=android-$MINSDKVERSION"
    )
    return cmake_cmd


def generate_ios(args: Namespace):
    raise NotImplementedError


def cmake_generate(args: Namespace):
    src_dir = Path(args.src).absolute()

    cmake = ""
    match args.platform:
        case "windows":
            cmake = generate_windows(args)
        case "linux":
            cmake = generate_linux(args)
        case "android":
            cmake = generate_android(args)
        case "macos":
            cmake = generate_macos(args)
        case "ios":
            cmake = generate_ios(args)
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
            "-D WITH_OPENVINO=OFF "
            # "-D WITH_1394=OFF "
            "-D WITH_FFMPEG=ON "
            # "-D WITH_GSTREAMER=OFF "
            "-D WITH_OPENEXR=OFF "
            "-D WITH_EIGEN=ON "
            # "-D VIDEOIO_PLUGIN_LIST=all "
            "-D WITH_MSMF=ON "
            "-D WITH_MSMF_DXVA=ON "
            "-D WITH_QT=OFF "
            # "-D WITH_FREETYPE=OFF "
            "-D WITH_TESSERACT=OFF "
            "-D WITH_OBSENSOR=OFF "
            "-D WITH_LAPACK=OFF "
            "-D ENABLE_CXX11=1 "
            "-D ENABLE_PRECOMPILED_HEADERS=OFF "
            "-D CMAKE_NO_SYSTEM_FROM_IMPORTED=ON "
            "-D OPENCV_ENABLE_NONFREE=OFF "
            f"-D OPENCV_EXTRA_MODULES_PATH={args.extra_modules} "
            "-D BUILD_SHARED_LIBS=OFF "
            f"-S {src_dir} "
            f"-B {args.dst} "
        )
    elif args.dart:
        demo = "-D WITH_OPENCV_DART_DEMO=ON " if args.build_demo else ""
        cmd = (
            f"{cmake} "
            "-D CMAKE_BUILD_TYPE=Release "
            "-D CMAKE_INSTALL_PREFIX=install "
            f"{demo} "
            f"-S {src_dir} "
            f"-B {args.dst} "
        )
    else:
        raise NotImplementedError
    print(cmd)
    os.system(cmd)


def cmake_build(args: Namespace):
    cmd = f"cmake --build . -j {os.cpu_count()*2} --target install --config Release"
    os.system(cmd)


def main(args: Namespace):
    if args.opencv:
        args.src = args.src / "opencv"

    build_sub = "opencv_dart" if args.dart else "opencv"
    args.extra_modules = Path(args.extra_modules).absolute()
    args.dst = args.dst / build_sub / f"{args.platform}" / f"{args.arch}"
    if not args.dst.exists():
        args.dst.mkdir(parents=True)
    os.chdir(args.dst)

    cmake_generate(args)
    if args.no_build:
        return
    cmake_build(args)

    os.chdir(args.work_dir)

    if not args.dart:
        return

    # copy built dlls to platform directory
    # i.e., windows/; linux/; macos/; android/src/main/jniLibs/
    lib_copy_to_dir: Path
    lib_name_suffix: str = ""
    match args.platform:
        case "windows":
            lib_copy_to_dir = args.work_dir / args.platform
            lib_name_suffix = ".dll"
        case "android":
            lib_copy_to_dir = (
                args.work_dir / args.platform / "src" / "main" / "jniLibs" / args.arch
            )
            lib_name_suffix = ".so"
        case "linux":
            lib_copy_to_dir = args.work_dir / args.platform
            lib_name_suffix = ".so"
        case "macos" | "ios":
            lib_copy_to_dir = args.work_dir / args.platform
            lib_name_suffix = ".dylib"
        case _:
            raise NotImplementedError
    if not lib_copy_to_dir.exists():
        lib_copy_to_dir.mkdir(parents=True)

    publish_dir = args.work_dir / "build" / "publish"
    if not publish_dir.exists():
        publish_dir.mkdir(parents=True)

    install_dir = Path(args.dst) / "install"
    _prefix: str = "" if args.platform == "windows" else "lib"
    shutil.copy(install_dir / f"{_prefix}{LIB_NAME}{lib_name_suffix}", lib_copy_to_dir)

    # copy_dlls()

    # archive
    fname = publish_dir / f"lib{LIB_NAME}-{args.platform}-{args.arch}.tar.gz"
    with tarfile.open(fname, mode="w:gz") as tar:
        for file in install_dir.glob("*"):
            if file.is_file():
                tar.add(file, arcname=file.name)
    print(f"published: {fname}")


if __name__ == "__main__":
    work_dir = Path(__file__).parent.parent.absolute()
    parser = ArgumentParser()
    parser.add_argument("--opencv", dest="opencv", action="store_true", default=False)
    parser.add_argument("--dart", dest="dart", action="store_true", default=False)
    parser.add_argument(
        "--no-build",
        dest="no_build",
        action="store_true",
        default=False,
    )
    parser.add_argument(
        "--build-demo",
        dest="build_demo",
        action="store_true",
        default=False,
    )
    parser.add_argument(
        "--src",
        dest="src",
        type=str,
        default="src",
    )
    parser.add_argument(
        "--build-dir",
        dest="build_dir",
        type=str,
        default="build",
    )
    parser.add_argument(
        "--extra-modules",
        dest="extra_modules",
        type=str,
        default=str((work_dir / "src" / "opencv_contrib" / "modules").absolute()),
    )

    sub_parsers = parser.add_subparsers(title="platform", dest="platform")
    # macOS
    sub_macos = sub_parsers.add_parser("macos")
    sub_macos.add_argument(
        "--arch",
        dest="arch",
        type=str,
        default="x64",
        choices=["x64", "arm64"],
    )

    # Windows
    sub_windows = sub_parsers.add_parser("windows")
    sub_windows.add_argument(
        "--arch",
        dest="arch",
        type=str,
        default="x64",
        choices=["x64", "x86"],
    )

    # linux
    sub_linux = sub_parsers.add_parser("linux")
    sub_linux.add_argument(
        "--arch",
        dest="arch",
        type=str,
        default="x64",
        choices=["x64", "x86"],
    )

    # android
    sub_android = sub_parsers.add_parser("android")
    sub_android.add_argument(
        "--arch",
        dest="arch",
        type=str,
        default="arm64-v8a",
        choices=["arm64-v8a", "armeabi-v7a", "x86", "x86_64"],
        help="i.e., android abi",
    )
    sub_android.add_argument(
        "--android-ndk",
        dest="ndk",
        type=str,
        default=os.environ.get("ANDROID_NDK_HOME", ""),
    )

    # ios
    sub_ios = sub_parsers.add_parser("ios")

    args = parser.parse_args()

    print(args)
    assert not all([args.opencv, args.dart])

    args.work_dir = work_dir
    args.src = Path(args.src).absolute()
    args.dst = Path(args.build_dir).absolute()
    if args.platform == "android":
        args.ndk = Path(args.ndk).absolute()

    main(args)
