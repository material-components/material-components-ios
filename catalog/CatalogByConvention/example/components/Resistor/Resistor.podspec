Pod::Spec.new do |s|
  s.name         = "Resistor"
  s.version      = "1.0.0"
  s.summary      = "An example component."
  s.homepage     = "https://github.com/google/catalog-by-convention"
  s.authors      = "Google Inc."
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/catalog-by-convention.git", :tag => "v#{s.version}" }
  s.requires_arc = true

  s.public_header_files = "src/*.h"
  s.source_files = "src/*.{h,m,swift}"
  s.header_mappings_dir = "src/*"
end
