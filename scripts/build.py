import os
import sys
import shutil
from pathlib import Path
from argparse import ArgumentParser, Namespace
import tarfile


LIB_NAME = "opencv_dart"


def cmake_generate(args: Namespace):
    src_dir = Path(args.src).absolute()

    cmake = "cmake "
    match args.os:
        case "windows":
            arch = "x64" if args.arch == "x64" else "Win32"
            cmake += (
                # f"-D CMAKE_TOOLCHAIN_FILE={args.dst / 'conan_toolchain.cmake'} "
                # '-G "Visual Studio 16 2019" '
                "-D BUILD_WITH_STATIC_CRT=OFF "
                f"-D CMAKE_GENERATOR_PLATFORM={arch} "
            )
        case "linux":
            flags = (
                "-D CMAKE_C_FLAGS=-m32 -D CMAKE_CXX_FLAGS=-m32"
                if args.arch == "x86"
                else ""
            )
            cmake += f'-G "Ninja" -D OPENCV_DART_ARCH={args.arch} {flags} '
        case "android":
            if not args.ndk.exists():
                raise FileNotFoundError(f"Android NDK not found at {args.ndk}")
            cmake += (
                '-G "Ninja" '
                "-D ANDROID_STL=c++_static "
                f"-D ANDROID_NDK={args.ndk} "
                "-D ANDROID_TOOLCHAIN=clang "
                f"-D CMAKE_TOOLCHAIN_FILE={args.ndk}/build/cmake/android.toolchain.cmake "
                f"-D ANDROID_ABI={args.abi} "
                # f"-D ANDROID_PLATFORM=android-$MINSDKVERSION"
            )
        case "macos":
            cmake += '-G "Unix Makefiles" '
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


# def copy_dlls(args, install_dir, lib_name_suffix, lib_copy_to_dir):
#     lib_name_prefix: str = "lib" if args.os == "windows" else ""
#     if args.copy_dlls:
#         dependencies = pyldd.parse_to_list(
#             pyldd.Args(
#                 format_="json",
#                 path=install_dir / f"{LIB_NAME}{lib_name_suffix}",
#                 sort_by="soname",
#                 recursive=True,
#                 unused=True,
#             )
#         )
#         for dep in dependencies:
#             skip = (
#                 dep["soname"] is None
#                 # skip system dlls
#                 or str(Path(dep["path"]).absolute()).startswith("C:\WINDOWS")
#                 or not Path(dep["path"]).is_absolute()  # skip existed
#                 or not isinstance(dep["path"], str)
#             )

#             if skip:
#                 print(f"skip {dep['soname']}: {dep['path']}")
#                 continue
#             dep_path = Path(dep["path"])
#             shutil.copyfile(dep["path"], lib_copy_to_dir / dep_path.name)

#             if str(Path(dep["path"])).startswith(str(install_dir)):
#                 print(f"skip {dep['soname']}: {dep['path']}")
#                 continue

#             dst = install_dir / f"{lib_name_prefix}{dep_path.name}"

#             shutil.copyfile(dep["path"], dst)
#             print(f"{dep['path']} -> {dst}")


def main(args: Namespace):
    if args.opencv:
        args.src = args.src / "opencv"

    build_sub = "opencv_dart" if args.dart else "opencv"
    if args.os == "android":
        args.arch = args.abi
    args.extra_modules = Path(args.extra_modules).absolute()
    args.dst = args.dst / build_sub / f"{args.os}" / f"{args.arch}"
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
    lib_copy_to_dir: Path
    lib_name_suffix: str = ""
    match args.os:
        case "windows":
            lib_copy_to_dir = args.work_dir / args.os
            lib_name_suffix = ".dll"
        case "android":
            lib_copy_to_dir = (
                args.work_dir / args.os / "src" / "main" / "jniLibs" / args.abi
            )
            lib_name_suffix = ".so"
        case "linux":
            lib_copy_to_dir = args.work_dir / args.os
            lib_name_suffix = ".so"
        case "macos" | "ios":
            lib_copy_to_dir = args.work_dir / args.os
            lib_name_suffix = ".dylib"
        case _:
            raise NotImplementedError
    if not lib_copy_to_dir.exists():
        lib_copy_to_dir.mkdir(parents=True)

    publish_dir = args.work_dir / "build" / "publish"
    if not publish_dir.exists():
        publish_dir.mkdir(parents=True)

    install_dir = Path(args.dst) / "install"
    _prefix: str = "" if args.os == "windows" else "lib"
    shutil.copy(install_dir / f"{_prefix}{LIB_NAME}{lib_name_suffix}", lib_copy_to_dir)

    # copy_dlls()

    # archive
    fname = publish_dir / f"lib{LIB_NAME}-{args.os}-{args.arch}.tar.gz"
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
        "--copy-dlls",
        dest="copy_dlls",
        action="store_true",
        default=False,
    )

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
    assert not all([args.opencv, args.dart])
    args.work_dir = work_dir
    args.src = Path(args.src).absolute()
    args.ndk = Path(args.ndk).absolute()
    args.dst = Path(args.build_dir).absolute()
    main(args)
