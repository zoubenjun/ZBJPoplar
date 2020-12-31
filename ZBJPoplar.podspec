#
# Be sure to run `pod lib lint ZBJPoplar.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'ZBJPoplar'
  s.version          = '0.1.14'
  s.summary          = 'Personal Cagegory, Utils.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
    Personal Category, Utils. ZBJPoplar named by my son, a lovely boy.
                       DESC

  s.homepage         = 'https://github.com/zoubenjun/ZBJPoplar'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'zoubenjun' => '502153525@qq.com' }
  s.source           = { :git => 'https://github.com/zoubenjun/ZBJPoplar.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.frameworks = 'UIKit'
  s.public_header_files = 'ZBJPoplar/Classes/*.h'
  s.source_files = 'ZBJPoplar/Classes/*'
  
  s.subspec 'Macros' do |ss|
    ss.public_header_files = 'ZBJPoplar/Classes/Macros/**/*.h'
    ss.source_files = 'ZBJPoplar/Classes/Macros/**/*'
  end

  s.subspec 'Category' do |ss|
#    ss.public_header_files = 'ZBJPoplar/Classes/Category/**/*.h'
#    ss.source_files = 'ZBJPoplar/Classes/Category/**/*'
    
    ss.subspec 'Foundation' do |ss|
      ss.public_header_files = 'ZBJPoplar/Classes/Category/Foundation/**/*.h'
      ss.source_files = 'ZBJPoplar/Classes/Category/Foundation/**/*'
      ss.dependency 'ZBJPoplar/Macros'
    end
    
    ss.subspec 'Kit' do |ss|
      ss.public_header_files = 'ZBJPoplar/Classes/Category/Kit/**/*.h'
      ss.source_files = 'ZBJPoplar/Classes/Category/Kit/**/*'
      ss.dependency 'ZBJPoplar/Macros'
    end
  end
  
  s.subspec 'Tools' do |ss|
    ss.public_header_files = 'ZBJPoplar/Classes/Tools/**/*.h'
    ss.source_files = 'ZBJPoplar/Classes/Tools/**/*'
    ss.dependency 'ZBJPoplar/Macros'
  end
    
  # s.resource_bundles = {
  #   'ZBJPoplar' => ['ZBJPoplar/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
