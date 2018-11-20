load 'scripts/generated/icons.rb'

Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponents"
  mdc.version      = "70.0.0"
  mdc.authors      = "The Material Components authors."
  mdc.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  mdc.homepage     = "https://github.com/material-components/material-components-ios"
  mdc.license      = "Apache 2.0"
  mdc.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{mdc.version}" }
  mdc.platform     = :ios
  mdc.requires_arc = true
  mdc.ios.deployment_target = '8.0'

  # # Subspec explanation
  #
  # ## Required properties
  #
  # public_header_files  => Exposes our public headers for use in an app target.
  # source_files         => Must include all source required to successfully build the component.
  #
  # ## Optional properties
  #
  # resources        => If your component has a bundle, this property should be an Array
  #                     containing the bundle path as a String.
  #                     NOTE: Do not use resource_bundle property
  #
  # # Template subspec
  #
  #  mdc.subspec "ComponentName" do |component|
  #    component.public_header_files = "components/#{component.base_name}/src/*.h"
  #    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
  #
  #    # Only if you have a resource bundle
  #    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]
  #
  #   component.test_spec 'tests' do |tests|
  #     tests.test_spec 'unit' do |unit_tests|
  #       unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
  #       unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
  #     end
  #   end
  #  end
  #

  # ActivityIndicator

  mdc.subspec "ActivityIndicator" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MotionAnimator", "~> 2.0"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "ActivityIndicator+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  # AnimationTiming

  mdc.subspec "AnimationTiming" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # AppBar

  mdc.subspec "AppBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    # Navigation bar contents
    component.dependency "MaterialComponents/HeaderStackView"
    component.dependency "MaterialComponents/NavigationBar"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Application"
    # Flexible header + shadow
    component.dependency "MaterialComponents/FlexibleHeader"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Icons/ic_arrow_back"
    component.dependency "MaterialComponents/private/UIMetrics"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "AppBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/FlexibleHeader+ColorThemer"
    extension.dependency "MaterialComponents/NavigationBar+ColorThemer"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "AppBar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/NavigationBar+TypographyThemer"
  end

  # BottomAppBar

  mdc.subspec "BottomAppBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/NavigationBar"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "BottomAppBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # BottomNavigation

  mdc.subspec "BottomNavigation" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "BottomNavigation+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "BottomNavigation+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # BottomSheet

  mdc.subspec "BottomSheet" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/ShapeLibrary"
    component.dependency "MaterialComponents/private/Shapes"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "BottomSheet+ShapeThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  # Buttons

  mdc.subspec "Buttons" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency 'MDFInternationalization'
    component.dependency 'MDFTextAccessibility'
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/Shapes"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Buttons+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "Buttons+TitleColorAccessibilityMutator" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"

    extension.dependency 'MDFTextAccessibility'
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
  end

  mdc.subspec "Buttons+ShapeThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  mdc.subspec "Buttons+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "Buttons+ButtonThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Buttons+ColorThemer"
    extension.dependency "MaterialComponents/Buttons+ShapeThemer"
    extension.dependency "MaterialComponents/Buttons+TypographyThemer"
  end

  # ButtonBar

  mdc.subspec "ButtonBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/private/Application"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "ButtonBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "ButtonBar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # Cards

  mdc.subspec "Cards" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/Icons/ic_check_circle"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/Shapes"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Cards+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "Cards+ShapeThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  mdc.subspec "Cards+CardThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Cards+ColorThemer"
    extension.dependency "MaterialComponents/Cards+ShapeThemer"
  end

  # Chips

  mdc.subspec "Chips" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/TextFields"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/ShapeLibrary"
    component.dependency "MaterialComponents/private/Shapes"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Chips+ChipThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Chips+ColorThemer"
    extension.dependency "MaterialComponents/Chips+ShapeThemer"
    extension.dependency "MaterialComponents/Chips+TypographyThemer"
  end

  mdc.subspec "Chips+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "Chips+FontThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "Chips+ShapeThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  mdc.subspec "Chips+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # CollectionCells

  mdc.subspec "CollectionCells" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]
    component.framework = "CoreGraphics", "QuartzCore"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/CollectionLayoutAttributes"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Icons/ic_check"
    component.dependency "MaterialComponents/private/Icons/ic_check_circle"
    component.dependency "MaterialComponents/private/Icons/ic_chevron_right"
    component.dependency "MaterialComponents/private/Icons/ic_info"
    component.dependency "MaterialComponents/private/Icons/ic_radio_button_unchecked"
    component.dependency "MaterialComponents/private/Icons/ic_reorder"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # CollectionLayoutAttributes

  mdc.subspec "CollectionLayoutAttributes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # Collections

  mdc.subspec "Collections" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]
    component.framework = "CoreGraphics", "QuartzCore"

    component.dependency "MaterialComponents/CollectionCells"
    component.dependency "MaterialComponents/CollectionLayoutAttributes"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # Dialogs

  mdc.subspec "Dialogs" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MDFInternationalization"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Dialogs+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
    extension.dependency "MaterialComponents/Buttons+ColorThemer"
  end

  mdc.subspec "Dialogs+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
    extension.dependency "MaterialComponents/Buttons+TypographyThemer"
  end

  mdc.subspec "Dialogs+DialogThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Dialogs+ColorThemer"
    extension.dependency "MaterialComponents/Dialogs+TypographyThemer"
    extension.dependency "MaterialComponents/Buttons+ButtonThemer"
  end

  # FeatureHighlight

  mdc.subspec "FeatureHighlight" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFTextAccessibility"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "FeatureHighlight+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "FeatureHighlight+FontThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "FeatureHighlight+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "FeatureHighlight+FeatureHighlightAccessibilityMutator" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency 'MDFTextAccessibility'
  end

  # FlexibleHeader

  mdc.subspec "FlexibleHeader" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency 'MDFTextAccessibility'
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/UIMetrics"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "FlexibleHeader+CanAlwaysExpandToMaximumHeight" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
  end

  mdc.subspec "FlexibleHeader+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  # HeaderStackView

  mdc.subspec "HeaderStackView" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "HeaderStackView+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # Ink

  mdc.subspec "Ink" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Ink+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # LibraryInfo

  mdc.subspec "LibraryInfo" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # List

  mdc.subspec "List" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "List+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "List+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "List+ListThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/List+ColorThemer"
    extension.dependency "MaterialComponents/List+TypographyThemer"
  end

  # MaskedTransition

  mdc.subspec "MaskedTransition" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MotionTransitioning", "~> 5.0"
    component.dependency "MotionAnimator", "~> 2.0"
    component.dependency "MotionInterchange", "~> 1.0"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # NavigationBar

  mdc.subspec "NavigationBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    # Accessibility Configurator
    component.dependency "MDFTextAccessibility"

    component.dependency "MaterialComponents/ButtonBar"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "NavigationBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "NavigationBar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # NavigationDrawer

  mdc.subspec "NavigationDrawer" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/UIMetrics"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      end
    end
  end

  mdc.subspec "NavigationDrawer+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  # OverlayWindow

  mdc.subspec "OverlayWindow" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # PageControl

  mdc.subspec "PageControl" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]
    component.dependency "MDFInternationalization"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "PageControl+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # Palettes

  mdc.subspec "Palettes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # ProgressView

  mdc.subspec "ProgressView" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MotionAnimator", "~> 2.1"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "ProgressView+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # ShadowElevations

  mdc.subspec "ShadowElevations" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # ShadowLayer

  mdc.subspec "ShadowLayer" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.dependency "MaterialComponents/ShadowElevations"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # Slider

  mdc.subspec "Slider" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/private/ThumbTrack"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Slider+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/Palettes"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  # Snackbar

  mdc.subspec "Snackbar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/OverlayWindow"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Overlay"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Snackbar+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "Snackbar+FontThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "Snackbar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # Tabs

  mdc.subspec "Tabs" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "Tabs+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/schemes/Color"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
  end

  mdc.subspec "Tabs+FontThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "Tabs+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # TextFields

  mdc.subspec "TextFields" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MDFInternationalization"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "TextFields+ColorThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "TextFields+FontThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "TextFields+TypographyThemer" do |extension|
    extension.ios.deployment_target = '8.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # Themes

  mdc.subspec "Themes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/schemes/Color"
    component.dependency "MaterialComponents/schemes/Typography"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  # Typography

  mdc.subspec "Typography" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'tests' do |tests|
      tests.test_spec 'unit' do |unit_tests|
        unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end

  mdc.subspec "schemes" do |scheme_spec|
    scheme_spec.subspec "Color" do |scheme|
      scheme.ios.deployment_target = '8.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"

      scheme.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}", "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
        end
      end
    end
    scheme_spec.subspec "Shape" do |scheme|
      scheme.ios.deployment_target = '8.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"
      scheme.dependency "MaterialComponents/private/ShapeLibrary"
      scheme.dependency "MaterialComponents/private/Shapes"

      scheme.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}", "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
        end
      end
    end
    scheme_spec.subspec "Typography" do |scheme|
      scheme.ios.deployment_target = '8.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"

      scheme.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}", "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
        end
      end
    end
  end

  mdc.subspec "private" do |private_spec|
    # Pull in icon dependencies
    # The implementation of this method is generated by running scripts/sync_icons.sh
    # and defined in scripts/generated/icons.rb
    registerIcons(private_spec)

    private_spec.subspec "Application" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "KeyboardWatcher" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "Math" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "Overlay" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "ShapeLibrary" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Shapes"
      component.dependency "MaterialComponents/private/Math"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "Shapes" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/private/Math"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "ThumbTrack" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/Typography"
      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end

    private_spec.subspec "UIMetrics" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"

      component.test_spec 'tests' do |tests|
        tests.test_spec 'unit' do |unit_tests|
          unit_tests.source_files = "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
          unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
        end
      end
    end
  end
end
