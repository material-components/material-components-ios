<!--docs:
title: "Build environment"
layout: landing
section: docs
path: /docs/build-env/
-->

# Build environment

Material Components for iOS builds with the standard open-source iOS toolchain:
[Xcode](https://developer.apple.com/xcode/downloads/) and
[CocoaPods](https://cocoapods.org/about). However, there are certain settings
that you can use to maximize compatibility with our source.

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

The core team uses **Xcode 8 and Swift 3.0**

### iOS

Our components currently support **iOS 8.0 and up**.

### CocoaPods

We are using CocoaPods 1.2.

### Ruby

The core team uses **Ruby 2.0.0**. Newer versions of ruby have subtle modifications that affect our
`Podfile.lock` output.
