

Pod::Spec.new do |s|

  s.name         = "JLYYModel"
  s.version      = "1.0.5"
  s.summary      = "对YYModel做了一点修改"
  s.homepage     = "https://github.com/yuanjlGithub/YYModel"
  s.license      = "MIT"
  s.author             = { "beCooler" => "1251304927@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/yuanjlGithub/YYModel.git", :tag => "1.0.5" }
  s.source_files  = "YYModel", "*.{h,m}"
  s.requires_arc = true

end
