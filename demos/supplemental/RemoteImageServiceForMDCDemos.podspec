Pod::Spec.new do |s|
  s.name         = "RemoteImageServiceForMDCDemos"
  s.version      = "119.0.0"
  s.summary      = "A helper image class for the MDC demos."
  s.description  = "This spec is made for use in the MDC demos. It gets images via url."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = "Apache 2.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.source_files  = "RemoteImageService/*.{h,m}"
  s.public_header_files = "RemoteImageService/*.h"
end
