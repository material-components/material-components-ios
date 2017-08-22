Pod::Spec.new do |s|
  s.name         = "MaterialComponentsEarlGreyTests"
  s.version      = "33.0.0"
  s.authors      = "The Material Components authors."
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'components/*/tests/earlgrey/*.{h,m,swift}', 'components/private/*/tests/earlgrey/*.{h,m,swift}'
  s.framework    = 'XCTest'
  s.dependency 'MaterialComponents'
  s.dependency 'MDFTextAccessibility'
  s.dependency 'EarlGrey'
end
