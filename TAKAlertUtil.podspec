#
#  Be sure to run `pod spec lint TAKAlertUtil.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "TAKAlertUtil"
  s.version      = "0.1"
  s.summary      = "Determine by OSVer. The UIAlertView and UIAlertController"
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.homepage     = "https://github.com/taktem/TAKAlertUtil"
  s.author       = { "SOMTD" => "totem.kc[at]me.com" }
  s.source       = { :git => "https://github.com/taktem/TAKAlertUtil.git", :tag => s.version, :submodules => true }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'TAKAlertUtil/**/*.{h,m}'
  #s.resources    = 'TAKAlertUtil/**/*.xib'
end
