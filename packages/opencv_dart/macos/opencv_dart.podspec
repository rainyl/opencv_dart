#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opencv_dart.podspec` to validate before publishing.
#
require 'psych'

proj_dir = File.dirname(File.dirname(__FILE__))
pubspec_path = File.join(proj_dir, "pubspec.yaml")
pubspec = Psych.load(File.read(pubspec_path))
dartcv_version = pubspec["dartcv_version"]

Pod::Spec.new do |s|
  s.name         = 'opencv_dart'
  s.version      = '0.0.1'
  s.summary      = 'OpenCV bindings for Dart.'
  s.description  = <<-DESC
    OpenCV bindings for Dart.
  DESC
  s.homepage     = 'https://github.com/rainyl/opencv_dart'
  s.license      = { :type => 'Apache License 2.0', :file => '../LICENSE' }
  s.author       = { 'Rainyl' => 'rainyliusy3@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source       = { :path => '.' }
  # s.source_files  = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'DartCvMacOS', "#{dartcv_version}"
  s.dependency 'DartCvMacOS/dnn', "#{dartcv_version}"
  s.dependency 'DartCvMacOS/videoio', "#{dartcv_version}"

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
