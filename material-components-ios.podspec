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
  # private_header_files => This should point to your component's Private/ directory if you have any
  #                         private headers.
  # resource_bundles     => If your component has a bundle, add a dictionary mapping from the bundle
  #                         name to the bundle path.
  #
  # # Template subspec
  #
  # Find-and-replace for 'ComponentName' is your friend once you copy-paste this :)
  #
  #  s.subspec 'ComponentName' do |ss|
  #    ss.public_header_files = 'components/ComponentName/src/*.h'
  #    ss.source_files = 'components/ComponentName/src/*.{h,m}', 'components/ComponentName/src/Private/*.{h,m}'
  #    ss.header_mappings_dir = 'components/ComponentName/src/*'
  #
  #    # Only if you have private headers
  #    ss.private_header_files = 'components/ComponentName/src/Private/*.h'
  #
  #    # Only if you have a resource bundle
  #    ss.resource_bundles = {
  #      'MaterialComponentName' => ['components/ComponentName/MaterialComponentName.bundle/*']
  #    }
  #  end
  #

  s.subspec 'Ink' do |ss|
    ss.public_header_files = 'components/Ink/src/*.h'
    ss.source_files = 'components/Ink/src/*.{h,m}', 'components/Ink/src/private/*.{h,m}'
    ss.header_mappings_dir = 'components/Ink/src/*'
    ss.private_header_files = 'components/Ink/src/private/*.h'
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
    ss.public_header_files = 'ShadowLayer/src/*.h'
    ss.source_files = 'ShadowLayer/src/*.{h,m}'
    ss.header_mappings_dir = 'ShadowLayer/src/*'
  end

  s.subspec 'SpritedAnimationView' do |ss|
    ss.public_header_files = 'components/SpritedAnimationView/src/*.h'
    ss.source_files = 'components/SpritedAnimationView/src/*.{h,m}'
    ss.header_mappings_dir = 'components/SpritedAnimationView/src/*'
  end

  s.subspec 'Typography' do |ss|
    ss.public_header_files = 'Typography/src/*.h'
    ss.source_files = 'Typography/src/*.{h,m}', 'Typography/src/Private/*.{h,m}'
    ss.header_mappings_dir = 'Typography/src/*'

    ss.private_header_files = 'Typography/src/Private/*.h'
    ss.resource_bundles = {
      'MaterialTypography' => ['Typography/src/MaterialTypography.bundle/*']
    }
  end

end
