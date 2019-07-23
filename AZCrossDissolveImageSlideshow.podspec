#
#  Be sure to run `pod spec lint AZCrossDissolveImageSlideshow.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "AZCrossDissolveImageSlideshow"
  spec.version      = "0.0.1"
  spec.summary      = "Subclass of zvonicek/ImageSlideshow that supports fade transition between images."

  spec.description  = <<-DESC
    Subclass of zvonicek/ImageSlideshow that supports fade transition between images.
  DESC

  spec.homepage     = "https://github.com/XiangWuShuo/AZCrossDissolveImageSlideshow"
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "ApolloZhu" => "public-apollonian@outlook.com" }
  spec.social_media_url   = "http://www.xiangwushuo.com"

  spec.swift_versions = ['4.0', '4.1', '4.2', '5']
  spec.platform       = :ios, '8.0'


  spec.source = { :git => "https://github.com/XiangWuShuo/AZCrossDissolveImageSlideshow.git", :tag => "#{spec.version}" }
  spec.source_files = "AZCrossDissolveImageSlideshow"
  # spec.exclude_files = "Classes/Exclude"

  spec.frameworks = "UIKit", "Foundation"

  spec.dependency "ImageSlideshow", "1.8.0"

end
