import os

from conan import ConanFile
from conan.tools.build import can_run
from conan.tools.cmake import cmake_layout, CMake


class TestPackageConan(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain", "VirtualRunEnv"

    def requirements(self):
        self.requires(self.tested_reference_str)

    def build_requirements(self):
        self.tool_requires("cmake/3.28.1")

    def layout(self):
        print(self.settings.build_type)
        cmake_layout(self)

    def build(self):
        cmake = CMake(self)
        cmake.configure()
        cmake.build()

    def test(self):
        if can_run(self) and self.settings.os == "iOS":
            cmake_prog = os.environ.get("CONAN_CMAKE_PROGRAM")
            assert (
                cmake_prog is not None
                and os.path.basename(cmake_prog) == "cmake-wrapper"
            )
            toolchain = os.environ.get("CONAN_CMAKE_TOOLCHAIN_FILE")
            assert (
                toolchain is not None
                and os.path.basename(toolchain) == "ios.toolchain.cmake"
            )
            # bin_path = os.path.join(self.cpp.build.bindirs[0], "test_package")
            # self.run(bin_path, env="conanrun")
