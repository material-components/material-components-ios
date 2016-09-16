<!--{% if site.link_to_site == "true" %}-->
See <a href="https://material-ext.appspot.com/mdc-ios-preview/howto/build-env/">MDC site documentation</a> for richer experience.
<!--{% else %}See <a href="https://github.com/google/material-components-ios/tree/develop/howto/build-env">GitHub</a> for README documentation.{% endif %}-->

# Build environment

Material Components for iOS builds with the standard open-source iOS toolchain:
Xcode and CocoaPods. However, there are certain settings that you can use to
maximize compatibility with our source.

- - -

## Xcode warning settings

Deprecation warnings are an important part of how we communicate upcoming
changes to the library; they are enabled by default in typical Xcode and
CocoaPods projects.

If your project doesn't already specify these warnings, include the following
flags in your build:

    -Wdeprecated
    -Wdeprecated-declarations

If you treat warnings as errors (`-Werror` or "Treat warnings as errors" in
Xcode), then you should exclude deprecation warnings from being treated as
errors to allow the normal deprecation process to work:

    -Wno-error=deprecated
    -Wno-error=deprecated-declarations

## Supported versions

### Xcode

The core team uses **Xcode 7.2.1**, which corresponds to Swift 2.1. Once Swift
has stablized we will track particular Swift versions independently of Xcode
versions.

### iOS

All components are expected to support **iOS 7.0 and above**.

#### iOS 8.0 and above components

* [Dialogs](https://github.com/google/material-components-ios/tree/develop/components/Dialogs)

### CocoaPods

We are using CocoaPods 1.0.1.

### Ruby

The core team uses **Ruby 2.0.0**. Newer versions of ruby have subtle modifications that affect our
`Podfile.lock` output.
