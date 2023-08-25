#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint survicate_sdk.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'survicate_sdk'
  s.version          = '0.0.1'
  s.summary          = 'Flutter bindings for Survicate Mobile SDK'
  s.description      = <<-DESC
                      Official plugin for Survicate SDK integration with Flutter.
                       DESC
  s.homepage         = "https://github.com/Survicate/survicate-flutter-sdk"
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'Survicate' => 'hello@survicate.com' }
  s.source           = { :path => '.' }
  s.source_files     = 'Classes/**/*'
  s.platform         = :ios, '12.0'
  
  s.dependency 'Flutter'
  s.dependency 'Survicate', '3.0.2'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
