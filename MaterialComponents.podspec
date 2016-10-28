load 'scripts/generated/icons.rb'

Pod::Spec.new do |s|
  s.name         = "MaterialComponents"
  s.version      = "16.1.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/google/material-components-ios"
  s.license      = "Apache 2.0"
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => "v#{s.version}" }
  s.platform     = :ios
  s.requires_arc = true

  # # Subspec explanation
  #
  # ## Required properties
  #
  # public_header_files  => Exposes our public headers for use in an app target.
  # source_files         => Must include all source required to successfully build the component.
  # header_mappings_dir  => Must be "components/#{ss.base_name}/src/*". Flattens the headers into one directory.
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
  #    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  #
  #    # Only if you have a resource bundle
  #    ss.resources = ["components/#{ss.base_name}/Material#{ss.base_name}.bundle"]
  #    
  #  end
  #

  s.subspec "ActivityIndicator" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src/*"

    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "AppBar" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    # Navigation bar contents
    ss.dependency "MaterialComponents/HeaderStackView"
    ss.dependency "MaterialComponents/NavigationBar"
    ss.dependency "MaterialComponents/Typography"

    # Flexible header + shadow
    ss.dependency "MaterialComponents/FlexibleHeader"
    ss.dependency "MaterialComponents/ShadowElevations"
    ss.dependency "MaterialComponents/ShadowLayer"

    ss.dependency "MaterialComponents/private/Icons/ic_arrow_back"
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "AnimationTiming" do |ss|
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "Buttons" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency 'MDFTextAccessibility'
    ss.dependency "MaterialComponents/Ink"
    ss.dependency "MaterialComponents/ShadowElevations"
    ss.dependency "MaterialComponents/ShadowLayer"
    ss.dependency "MaterialComponents/Typography"
  end

  s.subspec "ButtonBar" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/Buttons"
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "CollectionCells" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

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
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "CollectionLayoutAttributes" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "Collections" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
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
    ss.ios.deployment_target = '8.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/Buttons"
    ss.dependency "MaterialComponents/ShadowElevations"
    ss.dependency "MaterialComponents/ShadowLayer"
    ss.dependency "MaterialComponents/private/KeyboardWatcher"
  end

  s.subspec "FlexibleHeader" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
    ss.dependency 'MDFTextAccessibility'
  end

  s.subspec "FontDiskLoader" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.framework = "CoreText"
  end

  s.subspec "HeaderStackView" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "Ink" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "NavigationBar" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/ButtonBar"
    ss.dependency "MaterialComponents/Typography"
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "OverlayWindow" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "PageControl" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]
  end

  s.subspec "Palettes" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "ProgressView" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "RobotoFontLoader" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    # Only if you have a resource bundle
    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

    ss.dependency "MaterialComponents/FontDiskLoader"
    ss.dependency "MaterialComponents/Typography"
  end

  s.subspec "ShadowElevations" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "ShadowLayer" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "Slider" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/private/ThumbTrack"
  end

  s.subspec "Snackbar" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"

    ss.dependency "MaterialComponents/AnimationTiming"
    ss.dependency "MaterialComponents/Buttons"
    ss.dependency "MaterialComponents/OverlayWindow"
    ss.dependency "MaterialComponents/private/KeyboardWatcher"
    ss.dependency "MaterialComponents/private/Overlay"
  end

  s.subspec "SpritedAnimationView" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "Switch" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
    ss.resources = ["components/#{ss.base_name}/src/Material#{ss.base_name}.bundle"]

    ss.dependency "MaterialComponents/private/ThumbTrack"
    ss.dependency "MaterialComponents/private/RTL"
  end

  s.subspec "Typography" do |ss|
    ss.ios.deployment_target = '7.0'
    ss.public_header_files = "components/#{ss.base_name}/src/*.h"
    ss.source_files = "components/#{ss.base_name}/src/*.{h,m}", "components/#{ss.base_name}/src/private/*.{h,m}"
    ss.header_mappings_dir = "components/#{ss.base_name}/src"
  end

  s.subspec "private" do |pss|

    # Pull in icon dependencies
    # The implementation of this method is generated by running scripts/sync_icons.sh
    # and defined in scripts/generated/icons.rb
    registerIcons(pss)

    pss.subspec "Color" do |ss|
      ss.ios.deployment_target = '7.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
      ss.header_mappings_dir = "components/private/#{ss.base_name}/src"
    end

    pss.subspec "KeyboardWatcher" do |ss|
      ss.ios.deployment_target = '7.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
      ss.header_mappings_dir = "components/private/#{ss.base_name}/src"
    end

    pss.subspec "Overlay" do |ss|
      ss.ios.deployment_target = '7.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}", "components/private/#{ss.base_name}/src/private/*.{h,m}"
      ss.header_mappings_dir = "components/private/#{ss.base_name}/src"
    end

    pss.subspec "RTL" do |ss|
      ss.ios.deployment_target = '7.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
      ss.header_mappings_dir = "components/private/#{ss.base_name}/src"
    end

    pss.subspec "ThumbTrack" do |ss|
      ss.ios.deployment_target = '7.0'
      ss.public_header_files = "components/private/#{ss.base_name}/src/*.h"
      ss.source_files = "components/private/#{ss.base_name}/src/*.{h,m}"
      ss.header_mappings_dir = "components/private/#{ss.base_name}/src"

      ss.dependency "MaterialComponents/Ink"
      ss.dependency "MaterialComponents/ShadowElevations"
      ss.dependency "MaterialComponents/ShadowLayer"
      ss.dependency "MaterialComponents/Typography"
      ss.dependency "MaterialComponents/private/Color"
    end

  end

end
