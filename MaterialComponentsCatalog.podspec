Pod::Spec.new do |s|
  s.name         = "MaterialComponentsCatalog"
  s.version      = "15.1.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/google/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true
  s.source_files = 'components/*/examples/*.{h,m,swift}', 'components/*/examples/supplemental/*.{h,m,swift}'
  s.resources = ['components/*/examples/resources/*']
  s.dependency 'MaterialComponents'
  s.public_header_files = 'components/*/examples/*.h', 'components/*/examples/supplemental/*.h'
end
