# Bare

An skeleton example App used to measure the size of Material Components for iOS.

## Latest Measurement
| Bare App                                     |     Size |
|----------------------------------------------|----------|
| without Material Components iOS:             |    2.7MB |
| with Material Components iOS:                |    8.9MB |
|----------------------------------------------|----------|
| Delta by adding Material Components iOS:     |    7.2MB |

The Material Components iOS framework adds ~7.2MB to your project.
Measured on the 19.0.0 release.

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


### Size of the App generated
- Run `pod install` from the Bare root folder.
- Open the `Bare.xcworkspace`.
- Clean the build.
- Archive the Bare App.
- Find the `xcarchive` file and open it via `Show Contents of Package`
- Report back the size of `Products/Applications/Bar.app`
