Pod::Spec.new do |s|
  s.name         = "MaterialComponentsExamples"
  s.version      = "116.0.0"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components examples."
  s.description  = "This spec is made for use in the MDC Catalog. Used in conjunction with CatalogByConvention we create our Material Catalog."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '10.0'
  s.requires_arc = true
  s.source_files = ['components/*/examples/*.{h,m,swift}', 'components/*/examples/supplemental/*.{h,m,swift}', 'components/private/*/examples/*.{h,m,swift}', 'components/schemes/*/examples/*.{h,m,swift}', 'components/schemes/*/examples/supplemental/*.{h,m,swift}']

  s.resources = ['components/*/examples/resources/*', 'components/private/*/examples/resources/*', 'components/schemes/*/examples/resources/*']
  s.dependency 'MaterialComponents'
  s.public_header_files = ['components/*/examples/*.h', 'components/*/examples/supplemental/*.h', 'components/private/*/examples/*.h', 'components/schemes/*/examples/*.h']
end
