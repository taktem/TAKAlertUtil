#
#  Be sure to run `pod spec lint TAKAlertUtil.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TAKAlertUtil"
  s.platform     = :ios, '8.0'
  s.version      = "2.1"
  s.summary      = "UIAlertController Support"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/taktem/TAKAlertUtil"
  s.author       = { "SOMTD" => "nishimura[at]taktem.com" }
  s.source       = { :git => "https://github.com/taktem/TAKAlertUtil.git", :tag => "#{s.version}" }
  s.requires_arc = true
  
  s.source_files = 'TAKAlertUtil/**/*.{h,m}'
  s.public_header_files = 'TAKAlertUtil/**/*.{h}'
  s.dependency 'ReactiveCocoa', '~> 4.1.0'
end
