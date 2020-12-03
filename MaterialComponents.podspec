load 'scripts/generated/icons.rb'

Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponents"
  mdc.version      = "119.1.3"
  mdc.authors      = "The Material Components authors."
  mdc.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  mdc.homepage     = "https://github.com/material-components/material-components-ios"
  mdc.license      = "Apache 2.0"
  mdc.source       = { :git => "https://github.com/material-components/material-components-ios.git",
                       :tag => "v#{mdc.version}" }
  mdc.platform     = :ios
  mdc.requires_arc = true
  mdc.ios.deployment_target = '10.0'

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
  #    component.source_files = [
  #      "components/#{component.base_name}/src/*.{h,m}",
  #      "components/#{component.base_name}/src/private/*.{h,m}"
  #    ]
  #
  #    # Only if you have a resource bundle
  #    component.resources = [
  #      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
  #    ]
  #
  #   component.test_spec 'tests' do |tests|
  #     tests.test_spec 'unit' do |unit_tests|
  #       unit_tests.source_files = [
  #         "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
  #         "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
  #       ]
  #       unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
  #     end
  #   end
  #  end
  #

  # ActionSheet

  mdc.subspec "ActionSheet" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/BottomSheet"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/Typography"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}"
      ]
    end
  end

  mdc.subspec "ActionSheet+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Availability"
    extension.dependency "MaterialComponents/Elevation"
    extension.dependency "MaterialComponents/private/Color"
    extension.dependency "MaterialComponents/schemes/Container"
    extension.dependency "MaterialComponents/ShadowElevations"
  end

  # ActivityIndicator

  mdc.subspec "ActivityIndicator" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MotionAnimator", "~> 2.0"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # AnimationTiming

  mdc.subspec "AnimationTiming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # AppBar

  mdc.subspec "AppBar" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]

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

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/AppBar+ColorThemer"
      unit_tests.dependency "MaterialComponents/AppBar+TypographyThemer"
    end
  end

  mdc.subspec "AppBar+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}", "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  mdc.subspec "AppBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/NavigationBar+ColorThemer"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "AppBar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/NavigationBar+TypographyThemer"
  end

  # Availability

  mdc.subspec "Availability" do |extension| 
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name}/src/*.h"
    extension.source_files = "components/#{extension.base_name}/src/*.{h,m}"
  end

  # Banner

  mdc.subspec "Banner" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Typography"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.m"
      ]
    end
  end

  mdc.subspec "Banner+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Buttons"
    extension.dependency "MaterialComponents/Buttons+Theming"
    extension.dependency "MaterialComponents/Elevation"
    extension.dependency "MaterialComponents/Typography"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
      unit_tests.dependency "MaterialComponents/private/Color"
      unit_tests.dependency "MaterialComponents/private/Math"
    end
  end

  # BottomAppBar

  mdc.subspec "BottomAppBar" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/NavigationBar"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # BottomNavigation

  mdc.subspec "BottomNavigation" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.exclude_files = [
      "components/#{component.base_name}/src/MDCBottomNavigationBarController.*",
      "components/#{component.base_name}/src/MaterialBottomNavigation+BottomNavigationController.h"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.exclude_files = [
        "components/#{component.base_name}/tests/unit/MDCBottomNavigationBarControllerTests.m",
        "components/#{component.base_name}/tests/unit/MDCBottomNavigationBarControllerDelegateTests.m"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "BottomNavigation+BottomNavigationController" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = [
      "components/#{component.base_name.split('+')[0]}/src/MDCBottomNavigationBarController.h",
      "components/#{component.base_name.split('+')[0]}/src/MaterialBottomNavigation+BottomNavigationController.h",
    ]
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/MDCBottomNavigationBarController.*",
      "components/#{component.base_name.split('+')[0]}/src/MaterialBottomNavigation+BottomNavigationController.h",
    ]
    component.dependency "MaterialComponents/BottomNavigation"
    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name.split('+')[0]}/tests/unit/MDCBottomNavigationBarControllerTests.m",
        "components/#{component.base_name.split('+')[0]}/tests/unit/MDCBottomNavigationBarControllerDelegateTests.m"
      ]
    end
  end

  mdc.subspec "BottomNavigation+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/ShadowElevations"
    extension.dependency "MaterialComponents/schemes/Color"
    extension.dependency "MaterialComponents/schemes/Container"
    extension.dependency "MaterialComponents/schemes/Typography"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # BottomSheet

  mdc.subspec "BottomSheet" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.framework = "WebKit"

    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/ShapeLibrary"
    component.dependency "MaterialComponents/Shapes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/BottomSheet+ShapeThemer"
    end
  end

  mdc.subspec "BottomSheet+ShapeThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  # Buttons

  mdc.subspec "Buttons" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency 'MDFInternationalization'
    component.dependency 'MDFTextAccessibility'
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/ShapeLibrary"
    component.dependency "MaterialComponents/Shapes"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/Buttons+ShapeThemer"
      unit_tests.dependency "MaterialComponents/Buttons+ColorThemer"
      unit_tests.dependency "MaterialComponents/Buttons+ButtonThemer"
    end
  end

  mdc.subspec "Buttons+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "Buttons+ShapeThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Shape"
  end

  mdc.subspec "Buttons+TypographyThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "Buttons+ButtonThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Buttons+ColorThemer"
    extension.dependency "MaterialComponents/Buttons+ShapeThemer"
    extension.dependency "MaterialComponents/Buttons+TypographyThemer"
    extension.dependency "MaterialComponents/Palettes"
  end

  mdc.subspec "Buttons+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ColorThemer"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ShapeThemer"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+TypographyThemer"
    extension.dependency "MaterialComponents/ShadowElevations"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # ButtonBar

  mdc.subspec "ButtonBar" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/private/Application"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Cards

  mdc.subspec "Cards" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"
    component.exclude_files = [
        "components/#{component.base_name}/src/MDCCard+Ripple.{h,m}",
        "components/#{component.base_name}/src/MDCCardCollectionCell+Ripple.{h,m}"
    ]
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Shapes"
    component.dependency "MaterialComponents/private/Icons/ic_check_circle"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "Cards+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # Chips

  mdc.subspec "Chips" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShapeLibrary"
    component.dependency "MaterialComponents/Shapes"
    component.dependency "MaterialComponents/TextFields"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Chips+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"
    extension.dependency "MaterialComponents/Typography"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # CollectionCells

  mdc.subspec "CollectionCells" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]
    component.framework = "CoreGraphics", "QuartzCore"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/CollectionLayoutAttributes"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Icons/ic_check"
    component.dependency "MaterialComponents/private/Icons/ic_check_circle"
    component.dependency "MaterialComponents/private/Icons/ic_chevron_right"
    component.dependency "MaterialComponents/private/Icons/ic_info"
    component.dependency "MaterialComponents/private/Icons/ic_radio_button_unchecked"
    component.dependency "MaterialComponents/private/Icons/ic_reorder"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # CollectionLayoutAttributes

  mdc.subspec "CollectionLayoutAttributes" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Collections

  mdc.subspec "Collections" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]
    component.framework = "CoreGraphics", "QuartzCore"

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/CollectionCells"
    component.dependency "MaterialComponents/CollectionLayoutAttributes"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Dialogs

  mdc.subspec "Dialogs" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]

    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MDFInternationalization"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "Dialogs+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
    extension.dependency "MaterialComponents/Buttons+ColorThemer"
  end

  mdc.subspec "Dialogs+TypographyThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
    extension.dependency "MaterialComponents/Buttons+TypographyThemer"
  end

  mdc.subspec "Dialogs+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ColorThemer"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+TypographyThemer"
    extension.dependency "MaterialComponents/ShadowElevations"
    extension.dependency "MaterialComponents/schemes/Container"
    extension.dependency "MaterialComponents/Buttons+Theming"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  mdc.subspec "Elevation" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/private/Color"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/private/Color"
    end
  end

  # FeatureHighlight

  mdc.subspec "FeatureHighlight" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFTextAccessibility"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/FeatureHighlight+ColorThemer"
    end
  end

  mdc.subspec "FeatureHighlight+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  # FlexibleHeader

  mdc.subspec "FlexibleHeader" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency 'MDFTextAccessibility'
    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/FlexibleHeader+ShiftBehavior"
    component.dependency "MaterialComponents/FlexibleHeader+ShiftBehaviorEnabledWithStatusBar"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/UIMetrics"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/ShadowLayer"
    end
  end

  mdc.subspec "FlexibleHeader+ShiftBehavior" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]
  end

  mdc.subspec "FlexibleHeader+ShiftBehaviorEnabledWithStatusBar" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/FlexibleHeader+ShiftBehavior"
  end

  mdc.subspec "FlexibleHeader+CanAlwaysExpandToMaximumHeight" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
  end

  # HeaderStackView

  mdc.subspec "HeaderStackView" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Ink

  mdc.subspec "Ink" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/private/Color"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # LibraryInfo

  mdc.subspec "LibraryInfo" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # List

  mdc.subspec "List" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "List+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # NavigationBar

  mdc.subspec "NavigationBar" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    # Accessibility Configurator
    component.dependency "MDFTextAccessibility"

    component.dependency "MaterialComponents/ButtonBar"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/NavigationBar+ColorThemer"
      unit_tests.dependency "MaterialComponents/NavigationBar+TypographyThemer"
    end
  end

  mdc.subspec "NavigationBar+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "NavigationBar+TypographyThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  # NavigationDrawer

  mdc.subspec "NavigationDrawer" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.exclude_files = "components/#{component.base_name}/src/private/MDCBottomDrawerContainerViewController+Testing.h"

    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/UIMetrics"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}",
        "components/#{component.base_name}/src/private/MDCBottomDrawerContainerViewController+Testing.h"
      ]
      unit_tests.dependency "MaterialComponents/NavigationDrawer+ColorThemer"
    end
  end

  mdc.subspec "NavigationDrawer+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  mdc.subspec "NavigationDrawer+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"
  end

  # OverlayWindow

  mdc.subspec "OverlayWindow" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/private/Application"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # PageControl

  mdc.subspec "PageControl" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]
    component.dependency "MDFInternationalization"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Palettes

  mdc.subspec "Palettes" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # ProgressView

  mdc.subspec "ProgressView" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "ProgressView+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # Ripple

  mdc.subspec "Ripple" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/private/Color"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # ShadowElevations

  mdc.subspec "ShadowElevations" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # ShadowLayer

  mdc.subspec "ShadowLayer" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.dependency "MaterialComponents/ShadowElevations"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # ShapeLibrary

  mdc.subspec "ShapeLibrary" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/Shapes"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Shapes

  mdc.subspec "Shapes" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/Color"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = "components/#{component.base_name}/tests/unit/*.{h,m,swift}", "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Slider

  mdc.subspec "Slider" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = [
      "components/#{component.base_name}/src/*.h"
    ]
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/ThumbTrack"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  mdc.subspec "Slider+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/Palettes"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Color"
  end

  # Snackbar

  mdc.subspec "Snackbar" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]
    component.resources = [
      "components/#{component.base_name}/src/Material#{component.base_name}.bundle"
    ]

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/OverlayWindow"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/Overlay"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/Themes"
    end
  end

  # Tabs

  mdc.subspec "Tabs" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}",
      "components/#{component.base_name}/src/ExtendedAlignment/*.{h,m}",
      "components/#{component.base_name}/src/SizeClassDelegate/*.{h,m}"
    ]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/Ripple"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/Tabs+TypographyThemer"
      unit_tests.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Tabs+TypographyThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/schemes/Typography"
  end

  mdc.subspec "Tabs+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+TypographyThemer"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
        "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  mdc.subspec "Tabs+TabBarView" do |extension|
    extension.ios.deployment_target = '10.0'
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

  mdc.subspec "Tabs+TabBarViewTheming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+TabBarView"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{extension.base_name.split('+')[0]}/tests/unit/TabBarView/MDCTabBarViewThemingTests.m",
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextFields

  mdc.subspec "TextFields" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/Elevation"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MDFInternationalization"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
      unit_tests.dependency "MaterialComponents/TextFields+ColorThemer"
      unit_tests.dependency "MaterialComponents/Themes"
    end
  end

  # TextControls+Enums

  mdc.subspec "TextControls+Enums" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
  end

  # TextControls+BaseTextAreas

  mdc.subspec "TextControls+BaseTextAreas" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [ "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
    "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
    component.dependency "MaterialComponents/private/TextControlsPrivate+BaseStyle"
    component.dependency "MDFInternationalization"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+BaseTextFields

  mdc.subspec "TextControls+BaseTextFields" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [ "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
    "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
    component.dependency "MaterialComponents/private/TextControlsPrivate+BaseStyle"
    component.dependency "MaterialComponents/private/TextControlsPrivate+TextFields"
    component.dependency "MDFInternationalization"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+FilledTextAreas

  mdc.subspec "TextControls+FilledTextAreas" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/TextControls+BaseTextAreas"
    component.dependency "MaterialComponents/private/TextControlsPrivate+FilledStyle"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+FilledTextAreasTheming

  mdc.subspec "TextControls+FilledTextAreasTheming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/TextControls+FilledTextAreas"
    component.dependency "MaterialComponents/schemes/Container"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
    end
  end

  # TextControls+FilledTextFields

  mdc.subspec "TextControls+FilledTextFields" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/TextControls+BaseTextFields"
    component.dependency "MaterialComponents/private/TextControlsPrivate+FilledStyle"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+FilledTextFieldsTheming

  mdc.subspec "TextControls+FilledTextFieldsTheming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/TextControls+FilledTextFields"
    component.dependency "MaterialComponents/schemes/Container"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
    end
  end

  # TextControls+OutlinedTextAreas

  mdc.subspec "TextControls+OutlinedTextAreas" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/TextControls+BaseTextAreas"
    component.dependency "MaterialComponents/private/TextControlsPrivate+OutlinedStyle"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+OutlinedTextAreasTheming

  mdc.subspec "TextControls+OutlinedTextAreasTheming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/TextControls+OutlinedTextAreas"
    component.dependency "MaterialComponents/schemes/Container"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/Availability"
    end
  end

  # TextControls+OutlinedTextFields

  mdc.subspec "TextControls+OutlinedTextFields" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/TextControls+BaseTextFields"
    component.dependency "MaterialComponents/private/TextControlsPrivate+OutlinedStyle"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
      unit_tests.dependency "MaterialComponents/schemes/Container"
    end
  end

  # TextControls+OutlinedTextFieldsTheming

  mdc.subspec "TextControls+OutlinedTextFieldsTheming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/TextControls+OutlinedTextFields"
    component.dependency "MaterialComponents/schemes/Container"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
      ]
    end
  end

  # TextControls+UnderlinedTextFields

  mdc.subspec "TextControls+UnderlinedTextFields" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/Availability"
    component.dependency "MaterialComponents/TextControls+BaseTextFields"
    component.dependency "MaterialComponents/private/TextControlsPrivate+UnderlinedStyle"
  end

  # TextControls+UnderlinedTextFieldsTheming

  mdc.subspec "TextControls+UnderlinedTextFieldsTheming" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
    component.source_files = [
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}",
      "components/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/TextControls+UnderlinedTextFields"
    component.dependency "MaterialComponents/schemes/Container"
  end

  mdc.subspec "TextFields+ColorThemer" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    ]
    extension.source_files = [
      "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}"
    ]

    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/Themes"
  end

  mdc.subspec "TextFields+Theming" do |extension|
    extension.ios.deployment_target = '10.0'
    extension.public_header_files = "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
    extension.source_files = [
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
    "components/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
    ]
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}"
    extension.dependency "MaterialComponents/#{extension.base_name.split('+')[0]}+ColorThemer"
    extension.dependency "MaterialComponents/schemes/Container"

    extension.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/*.{h,m,swift}",
      "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{extension.base_name.split('+')[0]}/tests/unit/#{extension.base_name.split('+')[1]}/resources/*"
    end
  end

  # Themes

  mdc.subspec "Themes" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/schemes/Color"
    component.dependency "MaterialComponents/schemes/Typography"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
    end
  end

  # Typography

  mdc.subspec "Typography" do |component|
    component.ios.deployment_target = '10.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = [
      "components/#{component.base_name}/src/*.{h,m}",
      "components/#{component.base_name}/src/private/*.{h,m}"
    ]

    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MDFTextAccessibility"

    component.test_spec 'UnitTests' do |unit_tests|
      unit_tests.source_files = [
        "components/#{component.base_name}/tests/unit/*.{h,m,swift}",
        "components/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
      ]
      unit_tests.resources = "components/#{component.base_name}/tests/unit/resources/*"
	  unit_tests.dependency "MaterialComponents/private/Application"
    end
  end

  mdc.subspec "schemes" do |scheme_spec|
    scheme_spec.subspec "Color" do |scheme|
      scheme.ios.deployment_target = '10.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"

      scheme.dependency "MaterialComponents/Availability"
      scheme.dependency "MaterialComponents/private/Color"

      scheme.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}",
          "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
        unit_tests.dependency "MaterialComponents/private/Math"
      end
    end
    scheme_spec.subspec "Container" do |scheme|
      scheme.ios.deployment_target = '10.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"
      scheme.dependency "MaterialComponents/schemes/Color"
      scheme.dependency "MaterialComponents/schemes/Typography"
      scheme.dependency "MaterialComponents/schemes/Shape"

      scheme.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}",
          "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
      end
    end
    scheme_spec.subspec "Shape" do |scheme|
      scheme.ios.deployment_target = '10.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"
      scheme.dependency "MaterialComponents/ShapeLibrary"
      scheme.dependency "MaterialComponents/Shapes"

      scheme.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}",
          "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
      end
    end
    scheme_spec.subspec "Typography" do |scheme|
      scheme.ios.deployment_target = '10.0'
      scheme.public_header_files = "components/schemes/#{scheme.base_name}/src/*.h"
      scheme.source_files = "components/schemes/#{scheme.base_name}/src/*.{h,m}"
      scheme.dependency "MaterialComponents/Typography"
      scheme.dependency "MaterialComponents/schemes/Typography+BasicFontScheme"
      scheme.dependency "MaterialComponents/schemes/Typography+Scheming"

      scheme.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/schemes/#{scheme.base_name}/tests/unit/*.{h,m,swift}",
          "components/schemes/#{scheme.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/schemes/#{scheme.base_name}/tests/unit/resources/*"
      end
    end
    scheme_spec.subspec "Typography+BasicFontScheme" do |extension|
      extension.ios.deployment_target = '10.0'
      extension.public_header_files = "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
      extension.source_files = [
        "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
        "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
      ]
    end
    scheme_spec.subspec "Typography+Scheming" do |extension|
      extension.ios.deployment_target = '10.0'
      extension.public_header_files = "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.h"
      extension.source_files = [
        "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/*.{h,m}",
        "components/schemes/#{extension.base_name.split('+')[0]}/src/#{extension.base_name.split('+')[1]}/private/*.{h,m}"
      ]
    end
  end

  mdc.subspec "private" do |private_spec|
    # Pull in icon dependencies
    # The implementation of this method is generated by running scripts/sync_icons.sh
    # and defined in scripts/generated/icons.rb
    registerIcons(private_spec)

    private_spec.subspec "Application" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "Color" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/Availability"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "KeyboardWatcher" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "Math" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"
      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "Overlay" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = [
        "components/private/#{component.base_name}/src/*.{h,m}",
        "components/private/#{component.base_name}/src/private/*.{h,m}"
      ]

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "TextControlsPrivate+Shared" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]
      component.dependency "MaterialComponents/TextControls+Enums"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "TextControlsPrivate+BaseStyle" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]
      component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "TextControlsPrivate+FilledStyle" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]

      component.dependency "MaterialComponents/Availability"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
      component.dependency "MaterialComponents/private/TextControlsPrivate+UnderlinedStyle"
    end

    private_spec.subspec "TextControlsPrivate+OutlinedStyle" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]
      component.dependency "MaterialComponents/Availability"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
    end

    private_spec.subspec "TextControlsPrivate+TextFields" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
        "components/private/#{component.base_name.split('+')[0]}/tests/unit/#{component.base_name.split('+')[1]}/*.{h,m,swift}"
        ]
        unit_tests.dependency "MaterialComponents/schemes/Container"
      end
    end

    private_spec.subspec "TextControlsPrivate+UnderlinedStyle" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.h"
      component.source_files = [ "components/private/#{component.base_name.split('+')[0]}/src/#{component.base_name.split('+')[1]}/*.{h,m}"
      ]
      component.dependency "MaterialComponents/Availability"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MaterialComponents/private/TextControlsPrivate+Shared"
    end

    private_spec.subspec "ThumbTrack" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = [
        "components/private/#{component.base_name}/src/*.{h,m}",
        "components/private/#{component.base_name}/src/private/*.{h,m}"
      ]

      component.dependency "MaterialComponents/Availability"
      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/Ripple"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/ShapeLibrary"
      component.dependency "MaterialComponents/Typography"
      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end

    private_spec.subspec "UIMetrics" do |component|
      component.ios.deployment_target = '10.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = [
        "components/private/#{component.base_name}/src/*.{h,m}",
        "components/private/#{component.base_name}/src/private/*.{h,m}"
      ]

      component.dependency "MaterialComponents/private/Application"

      component.test_spec 'UnitTests' do |unit_tests|
        unit_tests.source_files = [
          "components/private/#{component.base_name}/tests/unit/*.{h,m,swift}",
          "components/private/#{component.base_name}/tests/unit/supplemental/*.{h,m,swift}"
        ]
        unit_tests.resources = "components/private/#{component.base_name}/tests/unit/resources/*"
      end
    end
  end
end
