Pod::Spec.new do |s|
  s.name         = "MaterialComponentsTestingSupport"
  s.version      = "78.0.1"
  s.authors      = "The Material Components authors."
  s.summary      = "This spec provides support files and utilities for testing."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.subspec "schemes" do |scheme|
    scheme.subspec "Color" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/schemes/#{component.base_name}/tests/support/*.h"
      component.source_files = "components/schemes/#{component.base_name}/tests/support/*.{h,m,swift}"
      component.dependency "MaterialComponents/schemes/Color"
    end
    
    scheme.subspec "Typography" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/schemes/#{component.base_name}/tests/support/*.h"
      component.source_files = "components/schemes/#{component.base_name}/tests/support/*.{h,m,swift}"
      component.dependency "MaterialComponents/schemes/Typography"
    end
  end
  
end
