Pod::Spec.new do |s|
  s.name         = "MaterialComponentsTests"
  s.version      = "88.0.1"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components testing utilities."
  s.description  = "This spec is made for use in the MDC Catalog."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '9.0'
  s.requires_arc = true
  s.source_files = 'components/private/XCTest/src/*.{h,m,swift}'
  s.framework    = 'XCTest'
end
