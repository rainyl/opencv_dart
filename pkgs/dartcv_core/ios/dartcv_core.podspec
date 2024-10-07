#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dartcv_core.podspec` to validate before publishing.
#

require 'yaml'
proj_dir = File.dirname(__FILE__, 2)
pod_dir = File.dirname(__FILE__, 1)
pubspec = YAML.load_file("#{proj_dir}/pubspec.yaml")
proj_ver=pubspec['version']
opencv_ver=pubspec['version_opencv']

Pod::Spec.new do |s|
  s.name             = 'dartcv_core'
  s.version          = proj_ver
  s.summary          = '[core] OpenCV bindings for Dart.'
  s.description      = <<-DESC
  OpenCV bindings for Dart. core module.
                       DESC
  s.homepage         = 'https://github.com/rainyl/dartcv_core/pkgs/dartcv_core'
  s.license          = { :type => 'Apache 2.0', :file => '../LICENSE' }
  s.author           = { 'Rainyl' => 'rainyliusy3@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'

  s.prepare_command = <<-CMD
    if [ ! -f #{pod_dir}/libopencv/libopencv.a ]; then
      if [ ! -f #{pod_dir}/libopencv.zip ]; then
        echo "libopencv.a and libopencv.zip not found, downloading...";
        curl -L "https://github.com/rainyl/opencv.full/releases/download/#{opencv_ver}/libopencv-ios.zip" > libopencv.zip;
      else
        echo "found libopencv.zip";
      fi
      echo "extracting...";
      unzip -q -o libopencv.zip;
      echo "cleaning...";
      rm -f libopencv.zip;
    else
      echo "found libopencv.a, continue...";
    fi
  CMD

  s.frameworks = [
    'Accelerate', 'AssetsLibrary', 'AVFoundation',
    'CoreGraphics', 'CoreImage', 'CoreMedia',
    'CoreVideo', 'Foundation', 'QuartzCore',
    'UIKit'
  ]
  s.vendored_libraries = 'libopencv/libopencv.a'
  s.xcconfig = { 
    'HEADER_SEARCH_PATHS' => [
      '"${PODS_TARGET_SRCROOT}/libopencv/include/opencv4"'
    ],
    'OTHER_LDFLAGS' => '-Wl,-ld_classic' # https://wadetregaskis.com/no-platform-load-command-found-in-libxyz-a-assuming-macos/
  }

  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  s.swift_version = '5.0'
end
