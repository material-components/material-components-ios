Pod::Spec.new do |s|
  s.name         = "CatalogByConvention"
  s.version      = "1.0.0"
  s.authors      = "Google Inc."
  s.summary      = "Tools for building a Catalog by Convention."
  s.homepage     = "https://github.com/google/catalog-by-convention"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/catalog-by-convention.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.public_header_files = "src/*.h"
  s.source_files = "src/*.{h,m,swift}", "src/private/*.{h,m,swift}"
  s.header_mappings_dir = "src/*"
end
