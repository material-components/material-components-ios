Pod::Spec.new do |s|
  s.name         = "material-components-ios"
  s.version      = "0.1.0"
  s.authors      = { 'Googlers' => '@google.com' }
  s.summary      = "A collection of stand-alone production-ready UI libraries focused on design details."
  s.homepage     = "https://github.com/google/"
  s.license      = 'Apache 2.0'
  s.source       = { :git => "https://github.com/google/material-components-ios.git", :tag => s.version.to_s }
  s.platform     = :ios, '7.0'
  s.requires_arc = true

  # Subspecs

  s.subspec 'ScrollViewDelegateMultiplexer' do |ss|
    ss.public_header_files = 'ScrollViewDelegateMultiplexer/src/*.h'
    ss.header_dir = 'ScrollViewDelegateMultiplexer/src/'
    ss.source_files = 'ScrollViewDelegateMultiplexer/src/*.{h,m}'
  end

  s.subspec 'SpritedAnimationView' do |ss|
    ss.public_header_files = 'SpritedAnimationView/src/*.h'
    ss.header_dir = 'SpritedAnimationView/src/'
    ss.source_files = 'SpritedAnimationView/src/*.{h,m}'
  end

  s.subspec 'Typography' do |ss|
    ss.public_header_files = 'Typography/src/*.h'
    ss.private_header_files = 'Typography/src/Private/*.h'
    ss.header_dir = 'Typography/src/'
    ss.source_files = 'Typography/src/*.{h,m}', 'Typography/src/Private/*.{h,m}'
    s.resource_bundles = {
      'MaterialTypography' => ['Typography/MaterialTypography.bundle/*']
    }
  end
end
