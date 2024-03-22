import os
from conan import ConanFile
from conan.errors import ConanInvalidConfiguration, ConanException
from conan.tools.cmake import cmake_layout, CMake, CMakeToolchain, CMakeDeps
from conan.tools.files import chdir, mkdir, copy
from conan.tools.scm import Git
from conan.tools.microsoft import is_msvc, is_msvc_static_runtime
import tarfile
from pathlib import Path
import yaml

# for compatibility
arch_map = {
    "windows": {
        "x86_64": "x64",
    },
    "linux": {
        "x86_64": "x64",
    },
    "android": {
        "x86_64": "x86_64",
        "armv8": "arm64-v8a",
        "armv7": "armeabi-v7a",
    },
    "macos": {
        "x86_64": "x64",
        "armv8": "arm64",
    },
    "ios": {
        "x86_64": "x64",
        "armv8": "arm64",
    }
}

# (name, enabled)
OCV_MODULES = {
    "calib3d": True,
    "dnn": True,
    "features2d": True,
    "flann": True,
    "gapi": True,  # not implemented
    "highgui": True,
    "imgcodecs": True,
    "imgproc": True,
    "ml": False,  # not implemented
    "objdetect": True,
    "photo": True,
    "stitching": True,
    "video": True,
    "videoio": True,
    # contrib
    "aruco": True,
    # not implemented
    "wechat_qrcode": False,
    "bgsegm": False,
    "bioinspired": False,
    "ccalib": False,
    "dnn_objdetect": False,
    "dnn_superres": False,
    "dpm": False,
    "face": False,
    "fuzzy": False,
    "hfs": False,
    "img_hash": False,
    "intensity_transform": False,
    "line_descriptor": False,
    "mcc": False,
    "optflow": False,
    "phase_unwrapping": False,
    "plot": False,
    "rapid": False,
    "reg": False,
    "rgbd": False,
    "saliency": False,
    "shape": False,
    "signal": False,
    "stereo": False,
    "structured_light": False,
    "superres": False,
    "surface_matching": False,
    "tracking": False,
    "videostab": False,
    "xfeatures2d": False,
    "ximgproc": False,
    "xobjdetect": False,
    "xphoto": False,
    "alphamat": False,
    "cannops": False,
    "cudaarithm": False,
    "cudabgsegm": False,
    "cudacodec": False,
    "cudafeatures2d": False,
    "cudafilters": False,
    "cudaimgproc": False,
    "cudalegacy": False,
    "cudaobjdetect": False,
    "cudaoptflow": False,
    "cudastereo": False,
    "cudawarping": False,
    "cudev": False,
    "cvv": False,
    "freetype": False,
    "hdf": False,
    "java": False,
    "julia": False,
    "matlab": False,
    "ovis": False,
    "python2": False,
    "python3": False,
    "sfm": False,
    "ts": False,
    "viz": False,
}


class OcvDartDesktop(ConanFile):
    name = "opencv_dart"
    settings = "os", "compiler", "build_type", "arch"
    # generators = "CMakeToolchain", "CMakeDeps"
    options = {
        "shared": [True, False],
        "with_cuda": [True, False],
        "with_cublas": [True, False],
        "with_cufft": [True, False],
        "with_cudnn": [True, False],
        "with_eigen": [True, False],
        "with_opencl": [True, False],
        "with_openvino": [True, False],
        "with_obsensor": [True, False],
        "with_ipp": [False, "intel-ipp", "opencv-icv"],
        "with_protobuf": [True, False],
        "with_vulkan": [True, False],
        # imgcodecs module options
        "with_avif": [True, False],
        "with_jpeg": [False, "libjpeg", "libjpeg-turbo", "mozjpeg"],
        "with_png": [True, False],
        "with_tiff": [True, False],
        "with_jpeg2000": [False, "jasper", "openjpeg"],
        "with_openexr": [True, False],
        "with_webp": [True, False],
        "with_gdal": [True, False],
        "with_gdcm": [True, False],
        "with_imgcodec_hdr": [True, False],
        "with_imgcodec_pfm": [True, False],
        "with_imgcodec_pxm": [True, False],
        "with_imgcodec_sunraster": [True, False],
        "with_msmf": [True, False],
        "with_msmf_dxva": [True, False],
        # objdetect module options
        "with_quirc": [True, False],
        # videoio module options
        "with_ffmpeg": [True, False],
        "with_v4l": [True, False],
        # text module options
        "with_tesseract": [True, False],
        "with_gtk": [True, False],
        "nonfree": [True, False],
    }
    options.update({k: [True, False] for k in OCV_MODULES})
    default_options = {
        "shared": False,
        "with_cuda": False,
        "with_cublas": False,
        "with_cufft": False,
        "with_cudnn": False,
        "with_eigen": False,
        "with_opencl": True,
        "with_openvino": False,
        "with_obsensor": False,
        "with_ipp": "opencv-icv",
        "with_protobuf": True,
        "with_vulkan": False,
        # imgcodecs module options
        "with_avif": False,
        "with_jpeg": "libjpeg-turbo",
        "with_png": True,
        "with_tiff": True,
        "with_jpeg2000": "openjpeg",
        "with_openexr": True,
        "with_webp": True,
        "with_gdal": False,
        "with_gdcm": False,
        "with_imgcodec_hdr": True,
        "with_imgcodec_pfm": True,
        "with_imgcodec_pxm": True,
        "with_imgcodec_sunraster": True,
        "with_msmf": True,
        "with_msmf_dxva": True,
        # objdetect module options
        "with_quirc": True,
        # videoio module options
        "with_ffmpeg": True,
        "with_v4l": True,
        # text module options
        "with_tesseract": False,
        "with_gtk": True,
        "nonfree": False,
    }
    default_options.update(OCV_MODULES)

    opencv_repo: str
    opencv_contrib_repo: str

    def __init__(self, display_name=""):
        super().__init__(display_name)
        with open("pubspec.yaml", "r") as f:
            doc = yaml.safe_load(f)
        self.version = doc["binary_version"]

    def generate(self):
        tc: CMakeToolchain = CMakeToolchain(self)
        if self.settings.os == "iOS":
            platform_map = {
                "armv8": "OS64",
                "x86_64": "SIMULATOR64"
                # TODO: maybe need a conf var to support "SIMULATORARM64" and more
            }
            platform = platform_map[str(self.settings.arch)]
            block = tc.blocks["user_toolchain"]
            block.template = (
                f"set(PLATFORM {platform})\n"
                "set(ENABLE_ARC FALSE)\n"
                "set(ENABLE_BITCODE FALSE)\n"
                f"{block.template}"
            )
            # tc.variables["CMAKE_XCODE_ATTRIBUTE_DEVELOPMENT_TEAM"] = "rainyl"
            # tc.variables["CODE_SIGNING_ALLOWED"] = "NO"
        tc.variables["BUILD_CUDA_STUBS"] = False
        tc.variables["BUILD_DOCS"] = False
        tc.variables["BUILD_EXAMPLES"] = False
        tc.variables["BUILD_FAT_JAVA_LIB"] = False
        tc.variables["BUILD_IPP_IW"] = self.options.with_ipp == "opencv-icv"
        tc.variables["BUILD_ITT"] = False
        tc.variables["BUILD_JASPER"] = False
        tc.variables["BUILD_JAVA"] = False
        tc.variables["BUILD_JPEG"] = True
        tc.variables["BUILD_OPENEXR"] = True
        tc.variables["BUILD_OPENJPEG"] = True
        tc.variables["BUILD_TESTS"] = False
        tc.variables["BUILD_PROTOBUF"] = True
        tc.variables["BUILD_PERF_TESTS"] = False
        tc.variables["BUILD_USE_SYMLINKS"] = False
        tc.variables["BUILD_opencv_apps"] = False
        tc.variables["BUILD_opencv_java"] = False
        tc.variables["BUILD_opencv_java_bindings_gen"] = False
        tc.variables["BUILD_opencv_js"] = False
        tc.variables["BUILD_ZLIB"] = True
        tc.variables["BUILD_PNG"] = True
        tc.variables["BUILD_TIFF"] = True
        tc.variables["BUILD_WEBP"] = True
        tc.variables["BUILD_TBB"] = False
        tc.variables["OPENCV_FORCE_3RDPARTY_BUILD"] = False
        tc.variables["OPENCV_PYTHON_SKIP_DETECTION"] = True
        tc.variables["BUILD_opencv_python2"] = False
        tc.variables["BUILD_opencv_python3"] = False
        tc.variables["BUILD_opencv_python_bindings_g"] = False
        tc.variables["BUILD_opencv_python_tests"] = False
        tc.variables["BUILD_opencv_ts"] = False

        tc.variables["WITH_1394"] = True
        tc.variables["WITH_ARAVIS"] = False
        tc.variables["WITH_CLP"] = False
        tc.variables["WITH_NVCUVID"] = False

        tc.variables["WITH_FFMPEG"] = self.get_bool("with_ffmpeg", False)
        tc.variables["WITH_GSTREAMER"] = False
        tc.variables["WITH_HALIDE"] = False
        tc.variables["WITH_HPX"] = False
        tc.variables["WITH_IMGCODEC_HDR"] = self.get_bool("with_imgcodec_hdr", False)
        tc.variables["WITH_IMGCODEC_PFM"] = self.get_bool("with_imgcodec_pfm", False)
        tc.variables["WITH_IMGCODEC_PXM"] = self.get_bool("with_imgcodec_pxm", False)
        tc.variables["WITH_IMGCODEC_SUNRASTER"] = self.get_bool(
            "with_imgcodec_sunraster", False
        )
        tc.variables["WITH_IPP"] = bool(self.options.get_safe("with_ipp", False))
        tc.variables["WITH_ITT"] = False
        tc.variables["WITH_LIBREALSENSE"] = False
        tc.variables["WITH_MFX"] = False
        # opencl fails on ios
        tc.variables["WITH_OPENCL"] = False if self.settings.os == "iOS" else self.get_bool("with_opencl", False)
        tc.variables["WITH_OPENCLAMDBLAS"] = False
        tc.variables["WITH_OPENCLAMDFFT"] = False
        tc.variables["WITH_OPENCL_SVM"] = False
        tc.variables["WITH_OPENGL"] = False
        tc.variables["WITH_OPENNI"] = False
        tc.variables["WITH_OPENNI2"] = False
        tc.variables["WITH_OPENVX"] = False
        tc.variables["WITH_CAROTENE"] = False
        tc.variables["WITH_PLAIDML"] = False
        tc.variables["WITH_PVAPI"] = False
        tc.variables["WITH_QT"] = self.get_bool("with_qt", False)
        tc.variables["WITH_QUIRC"] = self.get_bool("with_quirc", False)
        tc.variables["WITH_V4L"] = self.get_bool("with_v4l", False)
        tc.variables["WITH_VA"] = False
        tc.variables["WITH_VA_INTEL"] = False
        tc.variables["WITH_VTK"] = self.get_bool("viz", False)
        tc.variables["WITH_VULKAN"] = self.get_bool("with_vulkan", False)
        tc.variables["WITH_XIMEA"] = False
        tc.variables["WITH_XINE"] = False
        tc.variables["WITH_LAPACK"] = False

        tc.variables["WITH_GTK"] = self.get_bool("with_gtk", False)
        tc.variables["WITH_WEBP"] = self.get_bool("with_webp", False)
        tc.variables["WITH_JPEG"] = bool(self.options.get_safe("with_jpeg", False))
        tc.variables["WITH_PNG"] = self.get_bool("with_png", False)
        tc.variables["WITH_TIFF"] = self.get_bool("with_tiff", False)
        tc.variables["WITH_JASPER"] = self.options.get_safe("with_jpeg2000") == "jasper"
        tc.variables["WITH_OPENJPEG"] = (
            self.options.get_safe("with_jpeg2000") == "openjpeg"
        )
        tc.variables["WITH_OPENEXR"] = self.get_bool("with_openexr", False)
        tc.variables["WITH_GDAL"] = self.get_bool("with_gdal", False)
        tc.variables["WITH_GDCM"] = self.get_bool("with_gdcm", False)
        tc.variables["WITH_EIGEN"] = self.get_bool("with_eigen")
        tc.variables["WITH_DSHOW"] = is_msvc(self)
        tc.variables["WITH_MSMF"] = self.get_bool("with_msmf", False)
        tc.variables["WITH_MSMF_DXVA"] = self.get_bool("with_msmf_dxva", False)
        tc.variables["OPENCV_ENABLE_NONFREE"] = self.get_bool("nonfree", False)
        tc.variables["ENABLE_NEON"] = self.get_bool("neon", False)
        tc.variables["OPENCV_DNN_CUDA"] = self.get_bool("dnn_cuda", False)
        tc.variables["WITH_OPENVINO"] = False
        tc.variables["WITH_AVIF"] = self.get_bool("with_avif", False)
        tc.variables["BUILD_opencv_world"] = self.get_bool("world", False)
        tc.variables["BUILD_opencv_core"] = True
        for module in OCV_MODULES:
            tc.variables[f"BUILD_opencv_{module}"] = self.get_bool(module, False)
        tc.variables["WITH_PROTOBUF"] = self.get_bool("with_protobuf", False)
        tc.variables["WITH_ADE"] = self.get_bool("gapi", False)
        tc.variables["BUILD_opencv_julia"] = False
        tc.variables["BUILD_opencv_matlab"] = False
        tc.variables["WITH_TESSERACT"] = self.get_bool("with_tesseract", False)
        tc.variables["WITH_CUDA"] = self.get_bool("with_cuda", False)
        tc.variables["WITH_CUBLAS"] = self.get_bool("with_cublas", False)
        tc.variables["WITH_CUFFT"] = self.get_bool("with_cufft", False)
        tc.variables["WITH_CUDNN"] = self.get_bool("with_cudnn", False)
        tc.variables["BUILD_WITH_STATIC_CRT"] = is_msvc_static_runtime(self)
        if is_msvc(self):
            tc.variables["BUILD_WITH_STATIC_CRT"] = is_msvc_static_runtime(self)

        if self.settings.os == "Android":
            tc.variables["BUILD_ANDROID_EXAMPLES"] = False

        tc.variables["OPENCV_EXTRA_MODULES_PATH"] = os.path.join(
            self.opencv_contrib_repo, "modules"
        ).replace("\\", "/")
        tc.generate()

        CMakeDeps(self).generate()

    def requirements(self):
        root = os.path.abspath(".")
        self.opencv_repo = os.path.join(root, "build", "opencv")
        self.opencv_contrib_repo = os.path.join(root, "build", "opencv_contrib")
        git = Git(self)
        if not os.path.exists(self.opencv_repo):
            git.clone("https://github.com/opencv/opencv.git", self.opencv_repo)
        if not os.path.exists(self.opencv_contrib_repo):
            git.clone(
                "https://github.com/opencv/opencv_contrib.git",
                self.opencv_contrib_repo,
            )

    def build_requirements(self):
        self.tool_requires("cmake/3.28.1")
        self.tool_requires("nasm/2.16.01")
        # self.tool_requires("ccache/4.9.1")
        if self.settings.os != "Windows":
            self.tool_requires("ninja/1.11.1")

    def source(self):
        git = Git(self)
        git.clone("https://github.com/opencv/opencv.git", "opencv")
        git.clone("https://github.com/opencv/opencv_contrib.git", "opencv_contrib")

    # def configure(self):
    #     ...

    def layout(self):
        base = Path("build") / str(self.settings.os) / str(self.settings.arch)
        self.folders.generators = str((base / "generators").absolute())
        self.folders.build = str((base / "opencv").absolute())
        self.folders.source = "build/opencv"

    def layout_dart(self):
        # self.build_folder: build/{os}/{arch}/opencv
        base = Path(self.build_folder).parent  # build/{os}/{arch}
        self.folders.generators = str((base / "generators").absolute())
        self.folders.build = str(base.absolute())
        self.folders.source = "."

    def build(self):
        cmake = CMake(self)

        # build opencv
        cmake.configure(
            variables={
                "CMAKE_INSTALL_PREFIX": self.install_folder,
            }
        )
        cmake.build(target="install")
        ocv_install_dir = self.opencv_dir(self.install_folder)

        # build opencv_dart
        self.layout_dart()
        cmake.configure(
            variables={
                "CMAKE_INSTALL_PREFIX": self.install_folder,
                "OpenCV_DIR": ocv_install_dir,
                "CMAKE_VISIBILITY_INLINES_HIDDEN": "hidden",
                "CMAKE_C_VISIBILITY_PRESET": "hidden",
                "CMAKE_CXX_VISIBILITY_PRESET": "hidden",
            },
        )
        tool_args = ["CODE_SIGNING_ALLOWED=NO"] if self.settings.os == "iOS" else None
        cmake.build(build_tool_args=tool_args)
        cmake.install(cli_args=["--strip"])

        self.post_build()

    def post_build(self):
        # archive
        install_dir = Path(self.install_folder)
        os = str(self.settings.os).lower()
        arch = arch_map[os][str(self.settings.arch)]
        new_name = f"lib{self.name}-{os}-{arch}.tar.gz"
        fname = self.publish_folder / new_name
        print(fname)
        if not fname.parent.exists():
            fname.parent.mkdir(parents=True)
        with tarfile.open(fname, mode="w:gz") as tar:
            for file in install_dir.glob("*"):
                print(f"Adding {file}...")
                tar.add(file, arcname=file.name)
        print(f"published: {fname}")
        dst = self.publish_folder.parent.parent / os
        if os == "android":
            dst = dst / "src" / "main" / "jniLibs" / arch
        print(f"Copying to {dst}")
        copy(self, "*", self.install_folder, dst)

    @property
    def install_folder(self) -> Path:
        return Path(f"{os.path.join(self.build_folder, 'install')}")

    @property
    def publish_folder(self) -> Path:
        p = Path(self.install_folder).absolute().parent.parent.parent
        return p / "publish"

    def opencv_dir(self, dir: Path) -> str:
        if self.settings.os == "Windows":
            return str(dir)
        elif self.settings.os in ["Linux", "Macos", "iOS"]:
            return str(dir / "lib" / "cmake" / "opencv4")
        elif self.settings.os == "Android":
            return str(dir / "sdk" / "native" / "jni")
        else:
            raise ConanInvalidConfiguration

    def get_bool(self, name: str, default=False):
        value = str(self.options.get_safe(name, default))
        if isinstance(value, str):
            return value == "True"
        elif isinstance(value, bool):
            return value
        else:
            raise ValueError(f"value: {value=} of {name=} error")
