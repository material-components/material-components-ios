---
title:  "Build environment"
layout: landing
section: howto
---

# Build environment

Material Components iOS builds with the standard open-source iOS toolchain:
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
