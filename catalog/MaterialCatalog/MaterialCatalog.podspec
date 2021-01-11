Pod::Spec.new do |s|
  s.name         = "MaterialCatalog"
  s.version      = "119.5.0"
  s.summary      = "Helper Objective-C classes for the MDC catalog."
  s.description  = "This spec is made for use in the MDC Catalog."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = "Apache 2.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.source_files  = "*.{h,m}"
  s.public_header_files = "*.h"

  s.dependency "MaterialComponents/Themes"
end
