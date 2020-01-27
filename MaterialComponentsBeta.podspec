Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponentsBeta"
  mdc.version      = "103.1.0"
  mdc.authors      = "The Material Components authors."
  mdc.summary      = "A collection of stand-alone alpha UI libraries that are not yet guaranteed to be ready for general production use. Use with caution."
  mdc.homepage     = "https://github.com/material-components/material-components-ios"
  mdc.license      = "Apache 2.0"
  mdc.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{mdc.version}" }
  mdc.platform     = :ios
  mdc.requires_arc = true
  mdc.ios.deployment_target = '9.0'

  # See MaterialComponents.podspec for the subspec structure and template.


  # ActionSheet

  mdc.subspec "ActionSheet+ActionSheetThemer" do |extension|
    extension.ios.deployment_target = '9.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponentsBeta/ActionSheet+ColorThemer"
    extension.dependency "MaterialComponentsBeta/ActionSheet+TypographyThemer"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}", "components/#{extension.base_name.split('+')[0]}/tests/unit/MDCActionSheetTestHelper.*"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  mdc.subspec "ActionSheet+ColorThemer" do |extension|
    extension.ios.deployment_target = '9.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  mdc.subspec "ActionSheet+TypographyThemer" do |extension|
    extension.ios.deployment_target = '9.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

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

  mdc.subspec "Tabs+TabBarView" do |extension|
    extension.ios.deployment_target = '9.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/AnimationTiming"
    extension.dependency "MaterialComponents/Ripple"
    extension.dependency "MaterialComponents/private/Math"
    extension.dependency "MDFInternationalization"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      ]
      unit_tests.dependency "MaterialComponents/AppBar"
      unit_tests.dependency "MaterialComponents/HeaderStackView"
      unit_tests.dependency "MaterialComponents/Typography"
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
