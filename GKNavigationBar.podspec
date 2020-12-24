Pod::Spec.new do |s|
  s.name                    = 'GKNavigationBar'
  s.version                 = '1.3.8'
  s.license                 = 'MIT'
  s.summary                 = '自定义导航栏--导航栏联动'
  s.homepage                = 'https://github.com/QuintGao/GKNavigationBar'
  s.social_media_url        = 'https://github.com/QuintGao'
  s.authors                 = { '高坤' => '1094887059@qq.com' }
  s.source                  = { :git => 'https://github.com/QuintGao/GKNavigationBar.git', :tag => s.version }
  s.ios.deployment_target   = '9.0'
  
  s.source_files            = 'GKNavigationBar/GKNavigationBar.h'
  
  s.subspec 'NavigationBar' do |ss|
    ss.source_files = 'GKNavigationBar/NavigationBar'
    ss.resource     = 'GKNavigationBar/NavigationBar/GKNavigationBar.bundle'
  end
  
  s.subspec 'GestureHandle' do |ss|
    ss.source_files = 'GKNavigationBar/GestureHandle'
  end
end
