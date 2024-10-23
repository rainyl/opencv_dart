#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opencv_dart.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name         = 'opencv_dart'
  s.version      = '0.0.1'
  s.summary      = 'OpenCV bindings for Dart.'
  s.description  = <<-DESC
    OpenCV bindings for Dart.
  DESC
  s.homepage     = 'https://github.com/rainyl/opencv_dart'
  s.license      = { :file => '../LICENSE' }
  s.author       = { 'Rainyl' => 'rainyliusy3@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source       = { :path => '.' }
  # s.source_files  = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.dependency 'DartCvMacOS', '4.10.0+2'
  s.dependency 'DartCvMacOS/dnn', '4.10.0+2'
  s.dependency 'DartCvMacOS/videoio', '4.10.0+2'

  s.platform = :osx, '10.15'
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
