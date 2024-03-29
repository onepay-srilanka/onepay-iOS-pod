#
# Be sure to run `pod lib lint OnepayIPG.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'OnepayIPG'
  s.version          = '0.1.0'
  s.summary          = 'iOS app for onepay payment gateway'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/onepay-srilanka/ipgios.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'onepay' => 'info@spemai.com' }
  s.source           = { :git => 'https://github.com/onepay-srilanka/ipgios.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/onepaylk'

  s.ios.deployment_target = '12.0'

  s.source_files = 'Source/**/*.swift'
  
  s.swift_version = '5.0'
  s.platforms = {
      "ios": "12.0"
  }
  
  
  s.resources = "Source/**/*.{png,jpeg,jpg,storyboard,xib,xcassets,ttf}"
  s.dependency 'Alamofire'
  s.dependency 'MGPSDK'
  
  # s.resource_bundles = {
  #   'OnepayIPG' => ['OnepayIPG/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.vendored_frameworks = 'CalendarControl.framework'
  # s.frameworks = 'CalendarControl'

  # s.vendored_frameworks = 'SubDirec/CalendarControl.xcframework'
  # s.dependency 'AFNetworking', '~> 2.3'
end
