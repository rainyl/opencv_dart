import os
from conan import ConanFile
from conan.errors import ConanInvalidConfiguration, ConanException
from conan.tools.cmake import cmake_layout, CMake, CMakeToolchain, CMakeDeps
import conan.tools.files as cfiles
import tarfile
from pathlib import Path
import yaml

OPENCV_VERSION = "4.9.0+1"
OPENCV_FILES_URL = (
    f"https://github.com/rainyl/opencv.full/releases/download/{OPENCV_VERSION}"
)

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
    },
}


class OcvDartDesktop(ConanFile):
    name = "opencv_dart"
    settings = "os", "compiler", "build_type", "arch"
    # generators = "CMakeToolchain", "CMakeDeps"
    options = {
        "package_root": ["ANY"],
        "output_dir": ["ANY"],
        "opencv_overwrite": [True, False],
        "opencv_dir": ["ANY"],
    }
    default_options = {
        "package_root": ".",
        "output_dir": "build",
        "opencv_overwrite": False,
        "opencv_dir": "",
    }

    opencv_full: Path

    def __init__(self, display_name=""):
        super().__init__(display_name)
        pubspec = Path(str(self.options.get_safe("package_root", "."))) / "pubspec.yaml"
        with open(pubspec, "r") as f:
            doc = yaml.safe_load(f)
        self.version = doc["binary_version"]

    def requirements(self):
        out_dir = os.path.abspath(str(self.options.get_safe("output_dir")))
        if not os.path.exists(out_dir):
            Path(out_dir).mkdir(parents=True)
        p0 = str(self.options.get_safe("opencv_dir", "")) or os.environ.get("OpenCV_DIR", "")
        if p0:
            assert os.path.exists(p0), f"explicitly configured opencv_dir/OpenCV_DIR {p0} not exists, check your command or environment variables"
            self.opencv_full = Path(p0)
            return
        platform = str(self.settings.os).lower()
        arch = arch_map[platform][str(self.settings.arch)]
        filename = f"libopencv-{platform}-{arch}.tar.gz"
        self.opencv_full = Path(out_dir) / "opencv" / filename.replace(".tar.gz", "")
        if not self.opencv_full.exists() or self.options.get_safe("opencv_overwrite", False):
            cfiles.get(
                self,
                f"{OPENCV_FILES_URL}/{filename}",
                destination=str(self.opencv_full.absolute()),
                filename=filename,
                verify=False,  # TODO: add verify
            )

    def build_requirements(self):
        self.tool_requires("cmake/3.28.1")
        self.tool_requires("nasm/2.16.01")
        if self.settings.os != "Windows":
            self.tool_requires("ninja/1.11.1")
        # if self.settings.os == "Android":
        #     self.tool_requires("android-ndk/r26c")

    def layout(self):
        # self.build_folder: build/{os}/{arch}/opencv
        # base = Path(self.build_folder).parent  # build/{os}/{arch}
        out_dir = Path(os.path.abspath(str(self.options.get_safe("output_dir"))))
        pkg_dir = Path(os.path.abspath(str(self.options.get_safe("package_root"))))
        self.folders.generators = str((out_dir / "generators").absolute())
        self.folders.build = str(out_dir.absolute())
        self.folders.source = str(pkg_dir.absolute())
        self.folders.set_base_package(str(pkg_dir.absolute()))

    def generate(self):
        tc: CMakeToolchain = CMakeToolchain(self)
        if self.settings.os == "iOS":
            platform_map = {
                "armv8": "OS64",
                "x86_64": "SIMULATOR64",
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
        tc.generate()
        CMakeDeps(self).generate()

    def build(self):
        cmake = CMake(self)

        # build opencv_dart
        cmake.configure(
            variables={
                "CMAKE_INSTALL_PREFIX": str(self.install_folder),
                "OpenCV_DIR": self.opencv_dir,
                "CMAKE_VISIBILITY_INLINES_HIDDEN": "hidden",
                "CMAKE_C_VISIBILITY_PRESET": "hidden",
                "CMAKE_CXX_VISIBILITY_PRESET": "hidden",
                "INSTALL_GTEST": False,
            },
        )
        tool_args = ["CODE_SIGNING_ALLOWED=NO"] if self.settings.os == "iOS" else None
        cmake.build(build_tool_args=tool_args)
        # cmake.test()
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
        dst = Path(self.package_folder).absolute() / os
        if os == "android":
            dst = dst / "src" / "main" / "jniLibs" / arch
        print(f"Copying to {dst}")
        cfiles.copy(self, "*", self.install_folder, dst)

    @property
    def install_folder(self) -> Path:
        return Path(f"{os.path.join(self.build_folder, 'install')}")

    @property
    def publish_folder(self) -> Path:
        return Path(self.package_folder).absolute() / "build" / "publish"

    @property
    def opencv_dir(self) -> str:
        if self.settings.os == "Windows":
            return str(self.opencv_full)
        elif self.settings.os in ["Linux", "Macos", "iOS"]:
            return str(self.opencv_full / "lib" / "cmake" / "opencv4")
        elif self.settings.os == "Android":
            return str(self.opencv_full / "sdk" / "native" / "jni")
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
