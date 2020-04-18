Pod::Spec.new do |s|
  s.name                    = "GKNavigationBar"
  s.version                 = "1.0.4"
  s.summary                 = "自定义导航栏--导航栏联动"
  s.homepage                = "https://github.com/QuintGao/GKNavigationBar"
  s.license                 = "MIT"
  s.authors                 = { "高坤" => "1094887059@qq.com" }
  s.social_media_url        = "https://github.com/QuintGao"
  s.platform                = :ios, "8.0"
  s.ios.deployment_target   = "8.0"
  s.source                  = { :git => "https://github.com/QuintGao/GKNavigationBar.git", :tag => s.version.to_s }
  s.source_files            = "GKNavigationBar/**/*.{h,m}"
  s.public_header_files     = "GKNavigationBar/**/*.h"
  s.resource                = "GKNavigationBar/GKNavigationBar.bundle"
end

















