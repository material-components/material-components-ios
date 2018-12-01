Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponentsAlpha"
  mdc.version      = "70.1.0"
  mdc.authors      = "The Material Components authors."
  mdc.summary      = "A collection of stand-alone alpha UI libraries that are not yet guaranteed to be ready for general production use. Use with caution."
  mdc.homepage     = "https://github.com/material-components/material-components-ios"
  mdc.license      = "Apache 2.0"
  mdc.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{mdc.version}" }
  mdc.platform     = :ios
  mdc.requires_arc = true
  mdc.ios.deployment_target = '8.0'

  # See MaterialComponents.podspec for the subspec structure and template.


  # ActionSheet

  mdc.subspec "ActionSheet" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/BottomSheet"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Typography"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      end
    end
  end

  mdc.subspec "ActionSheet+ActionSheetThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponentsAlpha/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponentsAlpha/ActionSheet+ColorThemer"
    extension.dependency "MaterialComponentsAlpha/ActionSheet+TypographyThemer"
  end

  mdc.subspec "ActionSheet+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponentsAlpha/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "ActionSheet+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponentsAlpha/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "Buttons+Theming" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ColorThemer"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ShapeThemer"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+TypographyThemer"
    extension.dependency "MaterialComponents/ShadowElevations"
    extension.dependency "MaterialComponentsAlpha/schemes/Container"
  end

  mdc.subspec "schemes" do |scheme_spec|
    scheme_spec.subspec "Container" do |scheme|
      scheme.ios.deployment_target = '8.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"
      scheme.dependency "MaterialComponents/schemes/Color"
      scheme.dependency "MaterialComponents/schemes/Typography"
      scheme.dependency "MaterialComponents/schemes/Shape"

      scheme.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}", "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        end
      end
    end
  end

  # Private

  mdc.subspec "private" do |private_spec|
    # CocoaPods requires at least one file to show up in a subspec, so we depend on the fake
    # "Alpha" component as a baseline.
    private_spec.subspec "Alpha" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"
    end
  end

end
