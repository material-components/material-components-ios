Pod::Spec.new do |s|
  s.name         = "RemoteImageService"
  s.version      = "0.0.1"
  s.summary      = "A helper image class for the MDC demos."
  s.description  = "This spec is made for use in the MDC demos."
  s.homepage     = "https://github.com/google/material-components-ios"
  s.license      = "Apache 2.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => "#{s.version}" }
  s.source_files  = "demos/supplemental/RemoteImageService/*.{h,m}"
  s.public_header_files = "demos/supplemental/RemoteImageService/*.h"
end
