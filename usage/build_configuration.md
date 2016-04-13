# Build configuration

These are recommendations for configuring build settings in a project using material-components-ios.

## Deprecation warnings

material-components-ios uses deprecation warnings to communicate when an API will eventually be
removed from the code base.

Deprecation warnings are enabled by default in typical Xcode projects and CocoaPods Pods projects.
If you need to explicitly enable these warnings in your project:

    -Wdeprecated
    -Wdeprecated-declarations

We encourage projects treating warnings as errors to disable deprecation errors:

    -Wno-error=deprecated
    -Wno-error=deprecated-declarations
