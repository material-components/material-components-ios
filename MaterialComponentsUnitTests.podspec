Pod::Spec.new do |s|
  s.name         = "MaterialComponentsUnitTests"
  s.version      = "60.3.0"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components unit tests."
  s.description  = "This spec is made for use in the MDC Catalog."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.source_files = 'components/*/tests/unit/*.{h,m,swift}', 'components/private/*/tests/unit/*.{h,m,swift}', 'components/*/tests/unit/supplemental/*.{h,m,swift}', 'components/private/*/tests/unit/supplemental/*.{h,m,swift}', 'components/schemes/*/tests/unit/*.{h,m,swift}'
  s.resources = ['components/*/tests/unit/resources/*', 'components/private/*/tests/unit/resources/*']
  s.framework    = 'XCTest'
  s.dependency 'MaterialComponents'
  s.dependency 'MaterialComponentsAlpha'
  s.dependency 'MDFTextAccessibility'
end
