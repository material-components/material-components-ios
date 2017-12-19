load 'scripts/generated/icons.rb'

Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponents"
  mdc.version      = "43.0.0"
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
  #  end
  #

  mdc.subspec "ActivityIndicator" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MotionAnimator", "~> 2.0"
  end

  mdc.subspec "ActivityIndicator+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/ActivityIndicator/src/#{spec.base_name}/*.h"
      spec.source_files = "components/ActivityIndicator/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/ActivityIndicator"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "AnimationTiming" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
  end

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
  end

  mdc.subspec "AppBar+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/AppBar/src/#{spec.base_name}/*.h"
      spec.source_files = "components/AppBar/src/#{spec.base_name}/*.{h,m}", "components/AppBar/src/#{spec.base_name}/private/*.{h,m}"
      spec.dependency "MaterialComponents/AppBar"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "BottomAppBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/NavigationBar+Extensions"
    component.dependency "MaterialComponents/private/Math"
  end

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
  end

  mdc.subspec "BottomNavigation+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/BottomNavigation/src/#{spec.base_name}/*.h"
      spec.source_files = "components/BottomNavigation/src/#{spec.base_name}/*.{h,m}"
      spec.dependency "MaterialComponents/BottomNavigation"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "BottomSheet" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MotionAnimator", "~> 2.3"
    component.dependency "MotionTransitioning", "~> 5.0"
  end

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
  end

  mdc.subspec "Buttons+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Buttons/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Buttons/src/#{spec.base_name}/*.{h,m}", "components/Buttons/src/#{spec.base_name}/private/*.{h,m}"
      spec.dependency "MaterialComponents/Buttons"
      spec.dependency "MaterialComponents/Themes"
    end
    component.subspec "TitleColorAccessibilityMutator" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Buttons/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Buttons/src/#{spec.base_name}/*.{h,m}", "components/Buttons/src/#{spec.base_name}/private/*.{h,m}"

      spec.dependency 'MDFTextAccessibility'
      spec.dependency "MaterialComponents/Buttons"
    end
  end

  mdc.subspec "ButtonBar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
  end

  mdc.subspec "ButtonBar+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/ButtonBar/src/#{spec.base_name}/*.h"
      spec.source_files = "components/ButtonBar/src/#{spec.base_name}/*.{h,m}"\

      spec.dependency "MaterialComponents/ButtonBar"
      spec.dependency "MaterialComponents/NavigationBar"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Chips" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/TextFields"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/private/Shapes"
  end

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
  end

  mdc.subspec "CollectionLayoutAttributes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"
  end

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
  end

  mdc.subspec "Dialogs" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MDFInternationalization"
    component.dependency "MotionAnimator", "~> 2.5"
    component.dependency "MotionTransitioning", "~> 5.0"
  end

  mdc.subspec "Dialogs+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Dialogs/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Dialogs/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/Dialogs"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "FeatureHighlight" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]

    component.dependency "MaterialComponents/private/Math"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MDFTextAccessibility"
  end

  mdc.subspec "FeatureHighlight+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/FeatureHighlight/src/#{spec.base_name}/*.h"
      spec.source_files = "components/FeatureHighlight/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/FeatureHighlight"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "FlexibleHeader" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency 'MDFTextAccessibility'
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/UIMetrics"
  end

  mdc.subspec "FlexibleHeader+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/FlexibleHeader/src/#{spec.base_name}/*.h"
      spec.source_files = "components/FlexibleHeader/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/FlexibleHeader"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "HeaderStackView" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"
  end

  mdc.subspec "HeaderStackView+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/HeaderStackView/src/#{spec.base_name}/*.h"
      spec.source_files = "components/HeaderStackView/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/HeaderStackView"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Ink" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Math"
  end

  mdc.subspec "Ink+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Ink/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Ink/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/Ink"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "LibraryInfo" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
  end

  mdc.subspec "MaskedTransition" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MotionTransitioning", "~> 5.0"
    component.dependency "MotionAnimator", "~> 2.0"
    component.dependency "MotionInterchange", "~> 1.0"
  end

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
  end

  mdc.subspec "NavigationBar+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/NavigationBar/src/#{spec.base_name}/*.h"
      spec.source_files = "components/NavigationBar/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/NavigationBar"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "OverlayWindow" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"
  end

  mdc.subspec "PageControl" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component.base_name}/src/Material#{component.base_name}.bundle"]
  end

  mdc.subspec "PageControl+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/PageControl/src/#{spec.base_name}/*.h"
      spec.source_files = "components/PageControl/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/PageControl"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Palettes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
  end

  mdc.subspec "ProgressView" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MotionAnimator", "~> 2.1"
  end

  mdc.subspec "ProgressView+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/ProgressView/src/#{spec.base_name}/*.h"
      spec.source_files = "components/ProgressView/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/ProgressView"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "ShadowElevations" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"
  end

  mdc.subspec "ShadowLayer" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}"

    component.dependency "MaterialComponents/ShadowElevations"
  end

  mdc.subspec "Slider" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/private/ThumbTrack"
  end

  mdc.subspec "Slider+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Slider/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Slider/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/Palettes"
      spec.dependency "MaterialComponents/Slider"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Snackbar" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/OverlayWindow"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Overlay"
  end

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
  end

  mdc.subspec "Tabs+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/Tabs/src/#{spec.base_name}/*.h"
      spec.source_files = "components/Tabs/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/Tabs"
      spec.dependency "MaterialComponents/Themes"
    end
  end

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
  end

  mdc.subspec "TextFields+Extensions" do |component|
    component.subspec "ColorThemer" do |spec|
      spec.ios.deployment_target = '8.0'
      spec.public_header_files = "components/TextFields/src/#{spec.base_name}/*.h"
      spec.source_files = "components/TextFields/src/#{spec.base_name}/*.{h,m}"

      spec.dependency "MaterialComponents/TextFields"
      spec.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Themes" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"
  end

  mdc.subspec "Typography" do |component|
    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component.base_name}/src/*.h"
    component.source_files = "components/#{component.base_name}/src/*.{h,m}", "components/#{component.base_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"
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
    end

    private_spec.subspec "KeyboardWatcher" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"
    end

    private_spec.subspec "Math" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"
    end

    private_spec.subspec "Overlay" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"
    end

    private_spec.subspec "ShapeLibrary" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Shapes"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "Shapes" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "ThumbTrack" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/Typography"
      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "UIMetrics" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component.base_name}/src/*.h"
      component.source_files = "components/private/#{component.base_name}/src/*.{h,m}", "components/private/#{component.base_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"
    end

  end

end
