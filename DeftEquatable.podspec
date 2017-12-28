Pod::Spec.new do |s|
  s.name             = "DeftEquatable"
  s.version          = "1.0.0"
  s.summary          = "Never implement Equatable manually again."
  s.description      = <<-DESC
                        With DeftEquatable, you never implement Equatable manually again.
                        DESC

  s.homepage         = "https://github.com/Meniny/DeftEquatable"
  s.license          = 'MIT'
  s.author           = { "Elias Abel" => "Meniny@qq.com" }
  s.source           = { :git => "https://github.com/Meniny/DeftEquatable.git", :tag => s.version.to_s }
  s.social_media_url = 'https://meniny.cn/'

  s.ios.deployment_target = '8.0'
  s.osx.deployment_target = '10.10'
  s.tvos.deployment_target = '9.0'
  s.watchos.deployment_target = '2.0'

  s.source_files = 'DeftEquatable/**/*.{h,swift}'
  s.public_header_files = 'DeftEquatable/**/*{.h}'
  s.frameworks = 'Foundation'
#s.dependency ""
end
