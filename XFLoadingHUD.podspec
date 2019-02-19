#
# Be sure to run `pod lib lint XFLoadingHUD.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'XFLoadingHUD'
s.version          = '0.1.2'
s.summary          = '可切换菊花、转圈、文字描绘三种加载动画，并为MJRefresh新增以上三种动画的自定义头部'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
TODO: Add long description of the pod here.
DESC

s.homepage         = 'https://github.com/1628471142/XFLoadingHUD'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { '953894805@qq.com' => '953894805@qq.com' }
s.source           = { :git => 'https://github.com/1628471142/XFLoadingHUD.git', :tag => s.version.to_s }
#   s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = "XFLoadingHUD/Classes/*"

s.resource_bundles = {
'XFLoadingHUD' => 'XFLoadingHUD/Assets/Pusab.ttf'
}

# s.public_header_files = 'Pod/Classes/**/*.h'
s.frameworks = 'UIKit'
s.dependency 'MJRefresh'
end
