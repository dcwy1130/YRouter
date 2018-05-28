
Pod::Spec.new do |s|
  s.name             = 'YRouter'
  s.version          = '2.1.5'
  s.summary          = 'Components YRouter.'

  s.description      = <<-DESC
    Components of route YRouter
                       DESC

  s.homepage         = 'https://github.com/dcwy1130/YRouter'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'dcwy1130' => 'zhangdexiong@yryz.com' }
  s.source           = { :git => 'https://github.com/dcwy1130/YRouter.git', :tag => s.version.to_s }

  s.ios.deployment_target = '8.0'

  s.source_files = 'YRouter/Classes/**/*'
  s.public_header_files = 'YRouter/Classes/**/*.h'
  s.frameworks = 'UIKit'
end


