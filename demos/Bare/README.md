# Bare

An skeleton example App used to measure the size of Material Components for iOS.

## Latest Measurement
| Bare App                                     |     Size |
|----------------------------------------------|----------|
| without Material Components iOS:             |  0.558MB |
| with Material Components iOS without Roboto: |  5.879MB |
| with Material Components iOS:                |  7.533MB |

The Material Components iOS framework adds ~7MB to your project, with ~1.7MB of it as Roboto.
Measured on the 13.0.0 release.

## Installation/Building

Bare uses [CocoaPods](https://cocoapods.org/) for dependency
management. You will need CocoaPods as well as SSH access to
[material-components-ios](https://github.com/material-components/material-components-ios).
Needing SSH access is only temporary until MDC launches publicly.

To install/build, cd into this directory and run `pod install`.
Then run `open Bare.xcworkspace`. Do **not** open `Bare.xcodeproj`
or the project will not build.

## How we measured

These are the instructions for how we took this measurement.

### Create a base line
- Go to the `Podfile` and remove the `pod 'MaterialComponents', :path => '../../'` entry
- Measure the [size](#size-of-the-app-generated) of the App without Material Components.

### Measure the increase with Material Components iOS
- Go to the `Podfile` and re-add the `pod 'MaterialComponents', :path => '../../'` entry
- Measure the [size](#size-of-the-app-generated) of the App with Material Components iOS.

### Measure the increase with Material Components iOS without Roboto
- Go to the `Podfile.lock` and find the dependencies of MaterialComponents and copy and transform
them to be explicitly added to the `PodFile`
- Remove the Roboto dependency and the private components by deleting
  - `pod 'MaterialComponents/RobotoFontLoader', :path => '../../'`
  - `pod 'MaterialComponents/private', :path => '../../'`
- Your `Podfile` should have something like:
```
target 'Bare' do
  pod 'MaterialComponents/ActivityIndicator', :path => '../../'
  pod 'MaterialComponents/AppBar', :path => '../../'
  pod 'MaterialComponents/ButtonBar', :path => '../../'
  pod 'MaterialComponents/Buttons', :path => '../../'
  pod 'MaterialComponents/CollectionCells', :path => '../../'
  pod 'MaterialComponents/CollectionLayoutAttributes', :path => '../../'
  pod 'MaterialComponents/Collections', :path => '../../'
  pod 'MaterialComponents/Dialogs', :path => '../../'
  pod 'MaterialComponents/FlexibleHeader', :path => '../../'
  pod 'MaterialComponents/FontDiskLoader', :path => '../../'
  pod 'MaterialComponents/HeaderStackView', :path => '../../'
  pod 'MaterialComponents/Ink', :path => '../../'
  pod 'MaterialComponents/NavigationBar', :path => '../../'
  pod 'MaterialComponents/OverlayWindow', :path => '../../'
  pod 'MaterialComponents/PageControl', :path => '../../'
  pod 'MaterialComponents/Palettes', :path => '../../'
  pod 'MaterialComponents/ProgressView', :path => '../../'
  pod 'MaterialComponents/ShadowElevations', :path => '../../'
  pod 'MaterialComponents/ShadowLayer', :path => '../../'
  pod 'MaterialComponents/Slider', :path => '../../'
  pod 'MaterialComponents/Snackbar', :path => '../../'
  pod 'MaterialComponents/SpritedAnimationView', :path => '../../'
  pod 'MaterialComponents/Typography', :path => '../../'
end
```
- Measure the [size](#size-of-the-app-generated) of the App with Material Components iOS without
 Roboto.

### Size of the App generated
- Run `pod install` from the Bare root folder.
- Open the `Bare.xcworkspace`.
- Clean the build.
- Archive the Bare App.
- Find the `xcarchive` file and open it via `Show Contents of Package`
- Report back the size of `Products/Applications/Bar.app`
