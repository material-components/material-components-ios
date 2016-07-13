Pod::Spec.new do |s|
  s.name         = "CatalogUnitTests"
  s.version      = "12.1.0"
  s.summary      = "Convention specification for the catalog examples."
  s.homepage     = "https://github.com/google/catalog-by-convention"
  s.authors      = "Google Inc."
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/catalog-by-convention.git", :tag => "v#{s.version}" }
  s.requires_arc = true

  # The conventions
  s.source_files = 'components/*/tests/unit/*.{h,m,swift}'
  s.resources = ['components/*/tests/unit/resources/*']
  s.framework = 'XCTest'
end
