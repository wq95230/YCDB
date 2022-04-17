Pod::Spec.new do |s|
  s.name             = 'YCDB'
  s.version          = '1.0.1'
  s.summary          = '对WCDB的一些封装使用,请使用 DBManager类方法'


  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/wq95230/YCDB'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '952303557@qq.com' => '952303557@qq.com' }
  s.source           = { :git => 'https://github.com/wq95230/YCDB.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'YCDB/Classes/*.{h,mm}'
  
  # s.resource_bundles = {
  #   'YCDB' => ['YCDB/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.default_subspecs = 'Database'
#  s.dependency 'YCDB/Database'
 s.dependency 'WCDB', '1.0.7.5'
  
  s.subspec 'Database' do |ss|
      ss.source_files = 'YCDB/Classes/Database/*.{h,mm}'
      
  end
  
end
