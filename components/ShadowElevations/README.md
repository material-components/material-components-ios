---
title:  "Shadow Elevations"
layout: detail
section: components
excerpt: "The Shadow Elevations component provides the most commonly-used Material Design elevations."
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
  <li class="icon-link"><a href="/components/ShadowElevations/apidocs/Constants.html">ShadowElevations Constants</a></li>
</ul>


- - -

## Installation

### Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

~~~ bash
pod 'MaterialComponents/ShadowElevations'
~~~

Then, run the following command:

~~~ bash
$ pod install
~~~


- - -

## Usage

### Importing

Before using Shadow Elevations, you'll need to import it:

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
#import "MaterialShadowElevations.h"
~~~

#### Swift
~~~ swift
import MaterialComponents
~~~

<!--</div>-->

<!--<div class="material-code-render" markdown="1">-->
#### Objective-C
~~~ objc
@interface ShadowedView: UIView

@end

@implementation ShadowedView

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

- (MDCShadowLayer *)shadowLayer {
  return (MDCShadowLayer *)self.layer;
}

- (void)setDefaultElevation {
  self.shadowLayer.elevation = MDCShadowElevationCardResting;
}

@end
~~~

#### Swift
~~~ swift
class ShadowedView: UIView {

  override class func layerClass() -> AnyClass {
    return MDCShadowLayer.self
  }

  var shadowLayer: MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }

  func setDefaultElevation() {
    self.shadowLayer.elevation = MDCShadowElevationCardResting
  }

}
~~~
<!--</div>-->
