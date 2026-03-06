# Uncomment the next line to define a global platform for your project
 platform :ios, '13.0'

target 'SPianoOC' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SPianoOC
  # 网络
  pod 'AFNetworking'
  pod 'YTKNetwork'
  pod 'Reachability'

  # 布局
  pod 'Masonry'

  # 图片
  pod 'SDWebImage'

  # JSON
  pod 'YYModel'
  pod 'MJExtension'

  # HUD
  pod 'MBProgressHUD'

  # 刷新
  pod 'MJRefresh'

  # Router
#  pod 'JLRoutes'

  # MVVM
  pod 'ReactiveObjC'

  # 数据库
#  pod 'FMDB'

  # 缓存
  pod 'YYCache'

  # 键盘
  pod 'IQKeyboardManager'

  # 日志
  pod 'CocoaLumberjack'

  # 动画
  pod 'lottie-ios'

  # 图片浏览
  pod 'MWPhotoBrowser'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
    end
  end
end
