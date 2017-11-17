load 'scripts/generated/icons.rb'

Pod::Spec.new do |mdc|
  mdc.name         = "MaterialComponents"
  mdc.version      = "40.0.2"
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
  #.   component_name="#{component.base_name}"
  #
  #    component.public_header_files = "components/#{component_name}/src/*.h"
  #    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
  #
  #    # Only if you have a resource bundle
  #    component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]
  #  end
  #

  mdc.subspec "ActivityIndicator" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/Palettes"
      component.dependency "MaterialComponents/private/Application"
      component.dependency "MotionAnimator", "~> 2.0"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/ColorThemer/*.h"
      colorthemer.source_files = "components/#{component_name}/src/ColorThemer/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "AnimationTiming" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
  end

  mdc.subspec "AppBar" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

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
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/ColorThemer/*.h"
      colorthemer.source_files = "components/#{component_name}/src/ColorThemer/*.{h,m}", "components/#{component_name}/src/ColorThemer/private/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "BottomAppBar" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

    component.dependency "MDFInternationalization"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/NavigationBar"
    component.dependency "MaterialComponents/private/Math"
  end

  mdc.subspec "BottomNavigation" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/private/Math"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "BottomSheet" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Math"
    component.dependency "MotionAnimator", "~> 2.3"
    component.dependency "MotionTransitioning", "~> 4.0"
  end

  mdc.subspec "Buttons" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

      component.dependency 'MDFTextAccessibility'
      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/Typography"

      component.dependency "MaterialComponents/private/Math"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}", "components/#{component_name}/src/#{component_name}/private/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
    spec.subspec "TitleColorAccessibilityMutator" do |mutator|
      mutator.ios.deployment_target = '8.0'
      mutator.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      mutator.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}", "components/#{component_name}/src/#{component_name}/private/*.{h,m}"

      mutator.dependency 'MDFTextAccessibility'
      mutator.dependency "MaterialComponents/Buttons/Component"
    end

  end

  mdc.subspec "ButtonBar" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/Buttons"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/NavigationBar/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Chips" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Math"
  end

  mdc.subspec "CollectionCells" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

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
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}"
  end

  mdc.subspec "Collections" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
    component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

    component.framework = "CoreGraphics", "QuartzCore"

    component.dependency "MaterialComponents/CollectionCells"
    component.dependency "MaterialComponents/CollectionLayoutAttributes"
    component.dependency "MaterialComponents/Ink"
    component.dependency "MaterialComponents/Palettes"
    component.dependency "MaterialComponents/ShadowElevations"
    component.dependency "MaterialComponents/ShadowLayer"
    component.dependency "MaterialComponents/Typography"
  end

  mdc.subspec "Dialogs" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

      component.dependency "MaterialComponents/Buttons"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/private/KeyboardWatcher"
      component.dependency "MDFInternationalization"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "FeatureHighlight" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MaterialComponents/Typography"
      component.dependency "MDFTextAccessibility"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "FlexibleHeader" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.dependency 'MDFTextAccessibility'
      component.dependency "MaterialComponents/private/Application"
      component.dependency "MaterialComponents/private/UIMetrics"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "HeaderStackView" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Ink" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "LibraryInfo" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
  end

  mdc.subspec "MaskedTransition" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
    component.dependency "MotionTransitioning", "~> 4.0"
    component.dependency "MotionAnimator", "~> 2.0"
    component.dependency "MotionInterchange", "~> 1.0"
  end

  mdc.subspec "NavigationBar" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}"

      # Accessibility Configurator
      component.dependency "MDFTextAccessibility"

      component.dependency "MaterialComponents/ButtonBar/Component"
      component.dependency "MaterialComponents/Typography"

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "OverlayWindow" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"
  end

  mdc.subspec "PageControl" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Palettes" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
  end

  mdc.subspec "ProgressView" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/Palettes"
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MotionAnimator", "~> 2.1"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "ShadowElevations" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}"
  end

  mdc.subspec "ShadowLayer" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}"

    component.dependency "MaterialComponents/ShadowElevations"
  end

  mdc.subspec "Slider" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/Palettes"
      component.dependency "MaterialComponents/private/ThumbTrack"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Palettes"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Snackbar" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/AnimationTiming"
    component.dependency "MaterialComponents/Buttons"
    component.dependency "MaterialComponents/OverlayWindow"
    component.dependency "MaterialComponents/Typography"
    component.dependency "MaterialComponents/private/Application"
    component.dependency "MaterialComponents/private/KeyboardWatcher"
    component.dependency "MaterialComponents/private/Overlay"
  end

  mdc.subspec "Tabs" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
      component.resources = ["components/#{component_name}/src/Material#{component_name}.bundle"]

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/Typography"
      component.dependency "MaterialComponents/private/Math"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "TextFields" do |spec|
    component_name="#{spec.base_name}"

    spec.subspec "Component" do |component|
      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/#{component_name}/src/*.h"
      component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/AnimationTiming"
      component.dependency "MaterialComponents/Palettes"
      component.dependency "MaterialComponents/Typography"

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"
      component.dependency "MDFInternationalization"
    end
    spec.subspec "ColorThemer" do |colorthemer|
      colorthemer.ios.deployment_target = '8.0'
      colorthemer.public_header_files = "components/#{component_name}/src/#{component_name}/*.h"
      colorthemer.source_files = "components/#{component_name}/src/#{component_name}/*.{h,m}"

      colorthemer.dependency "MaterialComponents/#{component_name}/Component"
      colorthemer.dependency "MaterialComponents/Themes"
    end
  end

  mdc.subspec "Themes" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"
  end

  mdc.subspec "Typography" do |component|
    component_name="#{component.base_name}"

    component.ios.deployment_target = '8.0'
    component.public_header_files = "components/#{component_name}/src/*.h"
    component.source_files = "components/#{component_name}/src/*.{h,m}", "components/#{component_name}/src/private/*.{h,m}"

    component.dependency "MaterialComponents/private/Application"
  end

  mdc.subspec "private" do |private_spec|

    # Pull in icon dependencies
    # The implementation of this method is generated by running scripts/sync_icons.sh
    # and defined in scripts/generated/icons.rb
    registerIcons(private_spec)

    private_spec.subspec "Application" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}"
    end

    private_spec.subspec "KeyboardWatcher" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"
    end

    private_spec.subspec "Math" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}"
    end

    private_spec.subspec "Overlay" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}", "components/private/#{component_name}/src/private/*.{h,m}"
    end

    private_spec.subspec "ShapeLibrary" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}", "components/private/#{component_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Shapes"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "Shapes" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}", "components/private/#{component_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "ThumbTrack" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}"

      component.dependency "MaterialComponents/Ink"
      component.dependency "MaterialComponents/ShadowElevations"
      component.dependency "MaterialComponents/ShadowLayer"
      component.dependency "MaterialComponents/Typography"

      component.dependency "MDFInternationalization"
      component.dependency "MaterialComponents/private/Math"
    end

    private_spec.subspec "UIMetrics" do |component|
      component_name="#{component.base_name}"

      component.ios.deployment_target = '8.0'
      component.public_header_files = "components/private/#{component_name}/src/*.h"
      component.source_files = "components/private/#{component_name}/src/*.{h,m}", "components/private/#{component_name}/src/private/*.{h,m}"

      component.dependency "MaterialComponents/private/Application"
    end

  end

end
