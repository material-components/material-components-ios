---
title:  "Shadow Elevations"
layout: detail
section: documentation
---
# Shadow Elevations

This component provides the most commonly-used Material Design elevations.
<!--{: .intro }-->

### Design Specifications

<ul class="icon-list">
  <li class="icon-link"><a href="https://www.google.com/design/spec/what-is-material/elevation-shadows.html">Elevation and Shadows</a></li>
</ul>

### API Documentation

<ul class="icon-list">
  <li class="icon-link"><a href="/apidocs/ShadowElevations/Constants.html">ShadowElevations Constants</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add the ShadowElevations component to your Xcode project using CocoaPods, add the following to
your PodFile:

~~~ bash
$ pod 'MaterialComponents/ShadowElevations'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~


- - -

## Usage

<!--<div class="material-code-render" markdown="1">-->

#### Swift
~~~ swift
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
~~~
<!--</div>-->
