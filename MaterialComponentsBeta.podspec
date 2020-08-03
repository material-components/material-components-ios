Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponentsBeta"
  mdc.version      = "112.0.1"
  mdc.authors      = "The Material Components authors."
  mdc.summary      = "A collection of stand-alone alpha UI libraries that are not yet guaranteed to be ready for general production use. Use with caution."
  mdc.homepage     = "https://github.com/material-components/material-components-ios"
  mdc.license      = "Apache 2.0"
  mdc.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{mdc.version}" }
  mdc.platform     = :ios
  mdc.requires_arc = true
  mdc.ios.deployment_target = '9.0'

  # See MaterialComponents.podspec for the subspec structure and template.

  mdc.subspec "BottomNavigation" do |component|
    component.ios.deployment_target = '9.0'
    component.public_header_files = "components/#{component.base_name}/src/MDCBottomNavigationBarController.h", "components/#{component.base_name}/src/MaterialBottomNavigationBeta.h"
    component.source_files = "components/#{component.base_name}/src/MDCBottomNavigationBarController.*", "components/#{component.base_name}/src/MaterialBottomNavigationBeta.h"
    component.dependency "MaterialComponents/BottomNavigation"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/MDCBottomNavigationBarControllerTests.m",
        "components/#{component.base_name}/tests/unit/MDCBottomNavigationBarControllerDelegateTests.m"
      ]
    end
  end

  # Private

  mdc.subspec "private" do |private_spec|
    # CocoaPods requires at least one file to show up in a subspec, so we depend on the fake
    # "Beta" component as a baseline.
    private_spec.subspec "Beta" do |component|
      component.ios.deployment_target = '9.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"
    end
  end

end
