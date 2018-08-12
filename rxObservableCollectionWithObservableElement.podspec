#
# Be sure to run `pod lib lint rxObservableCollectionWithObservableElement.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'rxObservableCollectionWithObservableElement'
  s.version          = '0.1.0'
  s.summary          = 'An observable collection with a Notify Element.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
	This observable collection works just likes any other providing collection changed events on insertions and deletions. Where this differs is that each element must implement the NotifyChanged protocol discussed below. This allows not only to received event's if elements are inserted but receive events for object's that implement the NotifyChanged Protocol any time a Variable is modified.
                       DESC

  s.homepage         = 'https://github.com/izzy5455/rxObservableCollectionWithObservableElement'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'ismael.a.otero@gmail.com' => 'ismael.otero@allscripots.com' }
  s.source           = { :git => 'https://github.com/izzy5455/rxObservableCollectionWithObservableElement.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'
  s.swift_version = '4.0'
  s.source_files = 'rxObservableCollectionWithObservableElement/Classes/**/*'
  
  # s.resource_bundles = {
  #   'rxObservableCollectionWithObservableElement' => ['rxObservableCollectionWithObservableElement/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'RxSwift'
  s.dependency 'RxCocoa'
end
