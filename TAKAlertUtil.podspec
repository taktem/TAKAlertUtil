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
  s.version      = "2.0.4"
  s.summary      = "Determine by OSVer. The UIAlertView and UIAlertController"
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.homepage     = "https://github.com/taktem/TAKAlertUtil"
  s.author       = { "SOMTD" => "totem.kc[at]me.com" }
  s.source       = { :git => "https://github.com/taktem/TAKAlertUtil.git", :tag => "#{s.version}" }
  s.requires_arc = true
  
  s.subspec 'Swift' do |w|
    w.source_files = 'TAKAlertUtil/**/*.swift'
    w.dependency 'RxSwift', '~> 2.0.0-alpha'
    w.dependency 'RxCocoa', '~> 2.0.0-alpha'
    w.dependency 'RxBlocking', '~> 2.0.0-alpha'
  end

  s.subspec 'Objective-C' do |o|
    o.platform     = :ios, '7.0'
    o.source_files = 'TAKAlertUtil/**/*.{h,m}'
    o.public_header_files = 'TAKAlertUtil/**/*.{h}'
    o.dependency 'ReactiveCocoa', '~> 2.5'
  end

end
