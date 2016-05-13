Pod::Spec.new do |s|
  s.name         = 'YYModel'
  s.summary      = 'High performance model framework for iOS/OSX.'
  s.version      = '1.0.3'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'ibireme' => 'ibireme@gmail.com' }
  s.social_media_url = 'http://blog.ibireme.com'
  s.homepage     = 'https://github.com/ibireme/YYModel'
  s.source       = { :git => 'https://github.com/ibireme/YYModel.git', :tag => s.version.to_s }
  s.requires_arc = true
  s.source_files = 'YYModel/*.{h,m}'
  s.public_header_files = 'YYModel/*.{h}'
  s.frameworks = 'Foundation', 'CoreFoundation'
  
    pch_YY = <<-EOS
#ifndef TARGET_OS_IOS
  #define TARGET_OS_IOS TARGET_OS_IPHONE
#endif
#ifndef TARGET_OS_WATCH
  #define TARGET_OS_WATCH 0
#endif
#ifndef TARGET_OS_TV
  #define TARGET_OS_TV 0
#endif
EOS
  s.prefix_header_contents = pch_YY
  s.ios.deployment_target = '6.0'
  s.osx.deployment_target = '10.7'
  s.watchos.deployment_target = '2.0'
  s.tvos.deployment_target = '9.0'


end
