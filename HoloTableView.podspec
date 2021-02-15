#
# Be sure to run `pod lib lint HoloTableView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'HoloTableView'
  s.version          = '2.4.0'
  s.summary          = 'Harness the power of UITableView with a simplified, chainable and expressive syntax.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = 'HoloTableView is a light-weight extension for UITableView. Harness the power of UITableView with a simplified, chainable and expressive syntax.'

  s.homepage         = 'https://github.com/HoloFoundation/HoloTableView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'gonghonglou' => 'gonghonglou@icloud.com' }
  s.source           = { :git => 'https://github.com/HoloFoundation/HoloTableView.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'HoloTableView/Classes/**/*'
  
  # s.resource_bundles = {
  #   'HoloTableView' => ['HoloTableView/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
