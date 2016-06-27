Pod::Spec.new do |s|
  s.name         = "MaterialComponentsUnitTests"
  s.version      = "11.0.1"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/google/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'components/*/tests/unit/*.{h,m,swift}'
  s.framework    = 'XCTest'
  s.dependency 'MaterialComponents'

  s.subspec "private" do |pss|
    pss.source_files = 'components/private/*/tests/unit/*.{h,m,swift}'
  end

end
