Pod::Spec.new do |s|
  s.name                    = 'GKNavigationBar'
  s.version                 = '1.9.4'
  s.license                 = 'MIT'
  s.summary                 = '自定义导航栏--导航栏联动'
  s.homepage                = 'https://github.com/QuintGao/GKNavigationBar'
  s.social_media_url        = 'https://github.com/QuintGao'
  s.authors                 = { 'QuintGao' => '1094887059@qq.com' }
  s.source                  = { :git => 'https://github.com/QuintGao/GKNavigationBar.git', :tag => s.version }
  s.ios.deployment_target   = '9.0'
  s.source_files            = 'GKNavigationBar/GKNavigationBar.h'
  
  s.subspec 'NavigationBar' do |ss|
    ss.source_files = 'GKNavigationBar/NavigationBar'
    ss.resource     = 'GKNavigationBar/GKNavigationBar.bundle'
    ss.resource_bundles = {'GKNavigationBar.privacy' => 'GKNavigationBar/PrivacyInfo.xcprivacy'}
  end
  
  s.subspec 'GestureHandle' do |ss|
    ss.source_files = 'GKNavigationBar/GestureHandle'
  end
end
