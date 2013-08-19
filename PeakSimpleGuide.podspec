Pod::Spec.new do |s|
  s.name         = "PeakSimpleGuide"
  s.version      = "1.1.0"
  s.summary      = "一个简单的Guide模块，可以轮播显示图片及图片描述，到最后一页会自动隐藏."
  s.homepage     = "https://github.com/conis/PeakSimpleGuide"
  s.license      = 'MIT'
  s.author       = { "Conis" => "conis.yi@gmail.com" }
  s.source       = { :git => "https://github.com/conis/PeakSimpleGuide.git", :tag => "v1.1.0"}
  s.platform     = :ios, '5.0'
  s.source_files = '*.{h,m}'
  s.framework  = 'UIKit'
  s.requires_arc = true
end
