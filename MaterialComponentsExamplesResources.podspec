Pod::Spec.new do |s|
  s.name         = "MaterialComponentsExamplesResources"
  s.version      = "55.1.0"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec is an aggregate of all the Material Components examples."
  s.description  = "This spec is made for use in the MDC Catalog. Used in conjunction with CatalogByConvention we create our Material Catalog."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true
  s.resources = ['components/*/examples/resources/*', 'components/private/*/examples/resources/*', 'components/schemes/*/examples/resources/*']
end
