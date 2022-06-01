Pod::Spec.new do |s|
  s.name = 'SwifterKit'
  s.version = '1.1.0'
  s.summary = 'SwifterKit is a collection SwifterSwift And BFKit'
  s.description = <<-DESC
  SwifterKit is a collection SwifterSwift And BFKit, with handy methods, syntactic sugar, and performance improvements for wide range of primitive data types, UIKit and Cocoa classes –over 500 in 1– for iOS, macOS, tvOS and watchOS.
                   DESC

  s.homepage = 'https://github.com/SummerTimer2016/SwifterKit'
  s.license = { type: 'MIT', file: 'LICENSE' }
  s.authors = { 'SummerShine' => 'SummerTimer2016@163.com' }
  s.social_media_url = 'http://twitter.com/omaralbeik'
#  s.screenshot = 'https://raw.githubusercontent.com/SwifterSwift/SwifterSwift/master/Assets/logo.png'
#  s.documentation_url = 'http://swifterswift.com/docs'

  s.ios.deployment_target = '10.0'

  s.swift_version = '5.0'
  s.requires_arc = true
  s.source = { git: 'https://github.com/SummerTimer2016/SwifterKit.git', tag: s.version.to_s }
  s.source_files = 'SwifterKit/Classes/Sources/**/*.swift'

end

