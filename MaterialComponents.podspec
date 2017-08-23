load 'scripts/generated/icons.rb'

Pod::Spec.new do |s|
  s.name         = "MaterialComponents"
  s.version      = "33.0.0"
  s.authors      = "The Material Components authors."
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/material-components/material-components-ios"
  s.license      = "Apache 2.0"
  s.source       = { :git => "https://github.com/material-components/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios
  s.requires_arc = true
  s.ios.deployment_target = '8.0'

  # # Subspec explanation
  #
  # ## Required properties
  #
  # public_header_files  => Exposes our public headers for use in an app target.
  # source_files         => Must include all source required to successfully build the component.
  #
  # ## Optional properties
  #
  # resources    		 => If your component has a bundle, add a dictionary mapping from the bundle
  #                         name to the bundle path. NOTE: Do not use resource_bundle property.
  #
  # # Template subspec
  #
  #  s.subspec "ComponentName" do |ss|
  #    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
  #    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
  #
  #    # Only if you have a resource bundle
  #    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]
  #
  #  end
  #

  s.subspec "ActivityIndicator" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

      ss.dependency "MaterialComponents/private/Application"
      ss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/ActivityIndicator/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "AnimationTiming" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
  end

  s.subspec "AppBar" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

      # Navigation bar contents
      sss.dependency "MaterialComponents/HeaderStackView"
      sss.dependency "MaterialComponents/NavigationBar"
      sss.dependency "MaterialComponents/Typography"

      # Flexible header + shadow
      sss.dependency "MaterialComponents/FlexibleHeader"
      sss.dependency "MaterialComponents/ShadowElevations"
      sss.dependency "MaterialComponents/ShadowLayer"

      sss.dependency "MaterialComponents/private/Icons/ic_arrow_back"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}", "components/#{ss.base_name}/src/#{sss.base_name}/private/*.{h,m}"
      sss.dependency "MaterialComponents/AppBar/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "BottomSheet" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

    ss.dependency "MaterialComponents/private/KeyboardWatcher"
    ss.dependency "MaterialComponents/private/Math"
  end

  s.subspec "Buttons" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

      ss.dependency 'MDFTextAccessibility'
      ss.dependency "MaterialComponents/Ink"
      ss.dependency "MaterialComponents/ShadowElevations"
      ss.dependency "MaterialComponents/ShadowLayer"
      ss.dependency "MaterialComponents/Typography"

      ss.dependency "MaterialComponents/private/Math"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}", "components/#{ss.base_name}/src/#{sss.base_name}/private/*.{h,m}"
      sss.dependency "MaterialComponents/Buttons/Component"
      sss.dependency "MaterialComponents/Themes"
    end
    ss.subspec "TitleColorAccessibilityMutator" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}", "components/#{ss.base_name}/src/#{sss.base_name}/private/*.{h,m}"

      sss.dependency 'MDFTextAccessibility'
      sss.dependency "MaterialComponents/Buttons/Component"
    end

  end

  s.subspec "ButtonBar" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

      ss.dependency "MaterialComponents/Buttons"
      ss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/ButtonBar/Component"
      sss.dependency "MaterialComponents/NavigationBar/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "CollectionCells" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

    ss.framework = "CoreGraphics", "QuartzCore"

    ss.dependency "MaterialComponents/CollectionLayoutAttributes"
    ss.dependency "MaterialComponents/Ink"
    ss.dependency "MaterialComponents/Typography"
    ss.dependency "MaterialComponents/private/Icons/ic_check"
    ss.dependency "MaterialComponents/private/Icons/ic_check_circle"
    ss.dependency "MaterialComponents/private/Icons/ic_chevron_right"
    ss.dependency "MaterialComponents/private/Icons/ic_info"
    ss.dependency "MaterialComponents/private/Icons/ic_radio_button_unchecked"
    ss.dependency "MaterialComponents/private/Icons/ic_reorder"
    ss.dependency "MaterialComponents/private/Math"
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "CollectionLayoutAttributes" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
  end

  s.subspec "Collections" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

    ss.framework = "CoreGraphics", "QuartzCore"

    ss.dependency "MaterialComponents/CollectionCells"
    ss.dependency "MaterialComponents/CollectionLayoutAttributes"
    ss.dependency "MaterialComponents/Ink"
    ss.dependency "MaterialComponents/ShadowElevations"
    ss.dependency "MaterialComponents/ShadowLayer"
    ss.dependency "MaterialComponents/Typography"
  end

  s.subspec "Dialogs" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

      sss.dependency "MaterialComponents/Buttons"
      sss.dependency "MaterialComponents/ShadowElevations"
      sss.dependency "MaterialComponents/ShadowLayer"
      sss.dependency "MaterialComponents/private/KeyboardWatcher"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/Dialogs/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "FeatureHighlight" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]
      sss.dependency "MaterialComponents/private/Math"
      sss.dependency "MaterialComponents/Typography"
      sss.dependency "MDFTextAccessibility"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/FeatureHighlight/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "FlexibleHeader" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      ss.dependency 'MDFTextAccessibility'
      ss.dependency "MaterialComponents/private/Application"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/FlexibleHeader/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "HeaderStackView" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/HeaderStackView/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "Ink" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/Ink/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "MaskedTransition" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

    ss.dependency "MotionTransitioning", "~> 3.0"
    ss.dependency "MotionAnimator", "~> 1.0"
    ss.dependency "MotionInterchange", "~> 1.0"
  end

  s.subspec "NavigationBar" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}"

      # Accessibility Configurator
      sss.dependency "MDFTextAccessibility"

      sss.dependency "MaterialComponents/ButtonBar/Component"
      sss.dependency "MaterialComponents/Typography"

      sss.dependency "MaterialComponents/private/Math"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/NavigationBar/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "OverlayWindow" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

    ss.dependency "MaterialComponents/private/Application"
  end

  s.subspec "PageControl" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/PageControl/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "Palettes" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
  end

  s.subspec "ProgressView" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}"

      sss.dependency "MaterialComponents/private/Math"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/ProgressView/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "ShadowElevations" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
  end

  s.subspec "ShadowLayer" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
  end

  s.subspec "Slider" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

      sss.dependency "MaterialComponents/private/ThumbTrack"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/Slider/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "Snackbar" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

    ss.dependency "MaterialComponents/AnimationTiming"
    ss.dependency "MaterialComponents/Buttons"
    ss.dependency "MaterialComponents/OverlayWindow"
    ss.dependency "MaterialComponents/Typography"
    ss.dependency "MaterialComponents/private/Application"
    ss.dependency "MaterialComponents/private/KeyboardWatcher"
    ss.dependency "MaterialComponents/private/Overlay"
  end

  s.subspec "Tabs" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
      sss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

      sss.dependency "MaterialComponents/AnimationTiming"
      sss.dependency "MaterialComponents/Ink"
      sss.dependency "MaterialComponents/Typography"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/Tabs/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "TextFields" do |ss|
    ss.subspec "Component" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/*.h"
      sss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

      sss.dependency "MaterialComponents/AnimationTiming"
      sss.dependency "MaterialComponents/Palettes"
      sss.dependency "MaterialComponents/Typography"

      sss.dependency "MaterialComponents/private/Math"
      sss.dependency "MaterialComponents/private/RTL"
    end
    ss.subspec "ColorThemer" do |sss|
      sss.ios.deployment_target = '8.0'
      sss.public_header_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.h"
      sss.source_files = "components/#{ss.base_name}/src/#{sss.base_name}/*.{h,m}"
      sss.dependency "MaterialComponents/TextFields/Component"
      sss.dependency "MaterialComponents/Themes"
    end
  end

  s.subspec "Themes" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
  end

  s.subspec "Typography" do |ss|
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"

    ss.dependency "MaterialComponents/private/Application"
  end

  s.subspec "private" do |pss|

    # Pull in icon dependencies
    # The implementation of this method is generated by running scripts/sync_icons.sh
    # and defined in scripts/generated/icons.rb
    registerIcons(pss)

    pss.subspec "Application" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
    end

    pss.subspec "KeyboardWatcher" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"

      ss.dependency "MaterialComponents/private/Application"
    end

    pss.subspec "Math" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
    end

    pss.subspec "Overlay" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}", "components/private/#{ss.base_name}/src/private/*.{h,m}"
    end

    pss.subspec "RTL" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
    end

    pss.subspec "ThumbTrack" do |ss|
      ss.ios.deployment_target = '8.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"

      ss.dependency "MaterialComponents/Ink"
      ss.dependency "MaterialComponents/ShadowElevations"
      ss.dependency "MaterialComponents/ShadowLayer"
      ss.dependency "MaterialComponents/Typography"

      ss.dependency "MaterialComponents/private/Math"
      ss.dependency "MaterialComponents/private/RTL"
    end

  end

end
