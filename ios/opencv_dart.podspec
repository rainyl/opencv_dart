#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint opencv_dart.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  system("make")

  s.name             = 'opencv_dart'
  s.version          = '0.0.1'
  s.summary          = 'OpenCV bindings for Dart.'
  s.description      = <<-DESC
  OpenCV bindings for Dart.
                       DESC
  s.homepage         = 'https://github.com/rainyl/opencv_dart'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Rainyl' => 'rainyliusy3@gmail.com' }

  # This will ensure the source files in Classes/ are included in the native
  # builds of apps using this FFI plugin. Podspec does not support relative
  # paths, so Classes contains a forwarder C file that relatively imports
  # `../src/*` so that the C sources can be shared among all target platforms.
  s.source           = { :path => '.' }
  # s.source_files = 'Classes/**/*'
  s.dependency 'Flutter'
  s.platform = :ios, '12.0'
  s.preserve_paths = "opencv_dart.framework"
  s.xcconfig = { 'OTHER_LDFLAGS' => '-framework opencv_dart' }
  s.vendored_frameworks = 'opencv_dart.framework'
  s.frameworks = 'AVFoundation'
  s.library = 'c++'
  s.static_framework = true

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES'}
end
