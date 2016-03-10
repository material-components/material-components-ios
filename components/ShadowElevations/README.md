---
layout: post
title:  "ShadowElevations"
date:   2016-03-01 20:15:01 -0500
categories: documentation
---
# ShadowElevations

This component provides the most commonly-used elevations:
https://www.google.com/design/spec/what-is-material/elevation-shadows.html

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

```swift
class ShadowedView: UIView {

  override class func layerClass() -> AnyClass {
    return MDCShadowLayer.self
  }

  var shadowLayer: MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }

  func setElevation(points: CGFloat) {
    self.shadowLayer.elevation = MDCShadowElevationCardResting
  }

}
```
