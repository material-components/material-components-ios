Pod::Spec.new do |s|
  s.name         = "material-components-ios"
  s.version      = "0.1.0"
  s.authors      = { 'Apple platform engineering at Google' => 'appleplatforms@google.com' }
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/google/material-components-ios"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  # # Subspec explanation
  #
  # ## Required properties
  #
  # public_header_files  => Exposes our public headers for use in an app target.
  # source_files         => Must include all source required to successfully build the component.
  # header_mappings_dir  => Must be 'components/ComponentName/src/*'. Flattens the headers into one directory.
  #
  # ## Optional properties
  #
  # resource_bundles     => If your component has a bundle, add a dictionary mapping from the bundle
  #                         name to the bundle path.
  #
  # # Template subspec
  #
  # Find-and-replace for 'ComponentName' is your friend once you copy-paste this :)
  #
  #  s.subspec 'ComponentName' do |ss|
  #    ss.public_header_files = 'components/ComponentName/src/*.h'
  #    ss.source_files = 'components/ComponentName/src/*.{h,m}', 'components/ComponentName/src/private/*.{h,m}'
  #    ss.header_mappings_dir = 'components/ComponentName/src/*'
  #
  #    # Only if you have a resource bundle
  #    ss.resource_bundles = {
  #      'MaterialComponentName' => ['components/ComponentName/MaterialComponentName.bundle/*']
  #    }
  #  end
  #

  s.subspec 'Buttons' do |ss|
    ss.public_header_files = 'components/Buttons/src/*.h'
    ss.source_files = 'components/Buttons/src/*.{h,m}', 'components/Buttons/src/Private/*.{h,m}'
    ss.header_mappings_dir = 'components/Buttons/src/*'
    ss.dependency 'material-components-ios/Ink'
    ss.dependency 'material-components-ios/ShadowElevations'
    ss.dependency 'material-components-ios/ShadowLayer'
    ss.dependency 'material-components-ios/Typography'
  end

  s.subspec 'FlexibleHeader' do |ss|
    ss.public_header_files = 'components/FlexibleHeader/src/*.h'
    ss.source_files = 'components/FlexibleHeader/src/*.{h,m}', 'components/FlexibleHeader/src/private/*.{h,m}'
    ss.header_mappings_dir = 'components/FlexibleHeader/src/*'
  end

  s.subspec 'Ink' do |ss|
    ss.public_header_files = 'components/Ink/src/*.h'
    ss.source_files = 'components/Ink/src/*.{h,m}', 'components/Ink/src/private/*.{h,m}'
    ss.header_mappings_dir = 'components/Ink/src/*'
  end

  s.subspec 'PageControl' do |ss|
    ss.public_header_files = 'components/PageControl/src/*.h'
    ss.source_files = 'components/PageControl/src/*.{h,m}', 'components/PageControl/src/private/*.{h,m}'
    ss.header_mappings_dir = 'components/PageControl/src/*'
  end

  s.subspec 'ScrollViewDelegateMultiplexer' do |ss|
    ss.public_header_files = 'components/ScrollViewDelegateMultiplexer/src/*.h'
    ss.source_files = 'components/ScrollViewDelegateMultiplexer/src/*.{h,m}'
    ss.header_mappings_dir = 'components/ScrollViewDelegateMultiplexer/src/*'
  end

  s.subspec 'ShadowElevations' do |ss|
    ss.public_header_files = 'components/ShadowElevations/src/*.h'
    ss.source_files = 'components/ShadowElevations/src/*.{h,m}'
    ss.header_mappings_dir = 'components/ShadowElevations/src/*'
  end

  s.subspec 'ShadowLayer' do |ss|
    ss.public_header_files = 'components/ShadowLayer/src/*.h'
    ss.source_files = 'components/ShadowLayer/src/*.{h,m}'
    ss.header_mappings_dir = 'components/ShadowLayer/src/*'
  end

  s.subspec 'Slider' do |ss|
    ss.public_header_files = 'components/Slider/src/*.h'
    ss.source_files = 'components/Slider/src/*.{h,m}', 'components/Slider/src/private/*.{h,m}'
    ss.header_mappings_dir = 'components/Slider/src/*'
    ss.dependency 'material-components-ios/private/ThumbTrack'
  end

  s.subspec 'SpritedAnimationView' do |ss|
    ss.public_header_files = 'components/SpritedAnimationView/src/*.h'
    ss.source_files = 'components/SpritedAnimationView/src/*.{h,m}'
    ss.header_mappings_dir = 'components/SpritedAnimationView/src/*'
  end

  s.subspec 'Switch' do |ss|
    ss.public_header_files = 'components/Switch/src/*.h'
    ss.source_files = 'components/Switch/src/*.{h,m}'
    ss.header_mappings_dir = 'components/Switch/src/*'
    ss.resource_bundles = {
      'MaterialSwitch' => ['components/Switch/src/MaterialSwitch.bundle/*']
    }
    ss.dependency 'material-components-ios/private/ThumbTrack'
  end

  s.subspec 'Typography' do |ss|
    ss.public_header_files = 'components/Typography/src/*.h'
    ss.source_files = 'components/Typography/src/*.{h,m}', 'components/Typography/src/Private/*.{h,m}'
    ss.header_mappings_dir = 'components/Typography/src/*'

    ss.resource_bundles = {
      'MaterialTypography' => ['components/Typography/src/MaterialTypography.bundle/*']
    }
  end

  s.subspec 'private' do |pss|

    pss.subspec 'Color' do |ss|
      ss.public_header_files = 'components/private/Color/src/*.h'
      ss.source_files = 'components/private/Color/src/*.{h,m}'
      ss.header_mappings_dir = 'components/private/Color/src/*'
    end

    pss.subspec 'ThumbTrack' do |ss|
      ss.public_header_files = 'components/private/ThumbTrack/src/*.h'
      ss.source_files = 'components/private/ThumbTrack/src/*.{h,m}'
      ss.header_mappings_dir = 'components/private/ThumbTrack/src/*'
      ss.dependency 'material-components-ios/ShadowElevations'
      ss.dependency 'material-components-ios/ShadowLayer'
      ss.dependency 'material-components-ios/private/Color'
    end
    
  end

end
