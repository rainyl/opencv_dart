#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint dartcv_core.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name         = 'dartcv_core'
  s.version      = '0.0.1'
  s.summary      = '[core] OpenCV bindings for Dart.'
  s.description  = <<-DESC
    OpenCV bindings for Dart. core module.
  DESC
  s.homepage     = 'https://github.com/rainyl/dartcv_core/pkgs/dartcv_core'
  s.license      = { :file => '../LICENSE' }
  s.author       = { 'Rainyl' => 'rainyliusy3@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source       = { :path => '.' }
  s.source_files  = 'Classes/**/*'
  s.dependency 'FlutterMacOS'
  s.vendored_libraries = '*.dylib'
  s.platform     = :osx, '10.15'
  s.static_framework = true
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES' }
  s.swift_version = '5.0'
end
