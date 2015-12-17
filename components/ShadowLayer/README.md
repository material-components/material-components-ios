# ShadowLayer

MDCShadow is a material design stylized shadow that applies design principles relating to height
and light sources to a shadow's projected depth. MDCShadow builds on the notion of how physical
properties of paper are translated to the screen by simulating paper depth through shadow diffusion.
MDCShadow has an elevation property that affects shadow depth and strength. MDCShadow
automatically handles shadow diffusion based on the shadow's elevation.

MDCShadow provides a Core Animation CALayer that will render a shadow based on its elevation
property. UIViews can easily utilize this by overriding their layerClass method to return
MDCShadowLayer.

`elevation` sets the diffusion level of the shadow. The higher the shadow elevation, the more
diffused the shadow becomes. Elevation uses points as a unit to specify height. Common shadow
elevations are defined in [MDCShadowElevations](../ShadowElevations) and range from 0 to 24 points.
The shadow diffusion effect diminishes as elevations exceed 24 points.

Set `shadowMaskEnabled` to ensure the interior, non-shadow portion of the layer is visible.
This is enabled by default and the internal portion of the layer is cut out.

## Requirements

- Xcode 7.0 or higher.
- iOS SDK version 7.0 or higher.

## Usage

Example of a custom button based on UIButton with Material Design shadows:
```objective-c
@interface ShadowButton : UIButton

@end

@implementation ShadowButton

+ (Class)layerClass {
  return [MDCShadowLayer class];
}

@end
```
Add the custom button to view:
```objective-c
ShadowButton *button = [ShadowButton buttonWithType:UIButtonTypeSystem];
button.frame = CGRectMake(100, 100, 200, 50);
[button setTitle: @"Button" forState:UIControlStateNormal];
[(MDCShadowLayer *)button.layer setElevation:6.f];
[self.view addSubview:button];
```
Creating a custom UIView with a shadow:
```swift
class ShadowedView: UIView {

  override class func layerClass() -> AnyClass {
    return MDCShadowLayer.self
  }

  var shadowLayer: MDCShadowLayer {
    return self.layer as! MDCShadowLayer
  }

  func setElevation(points: CGFloat) {
    self.shadowLayer.elevation = points
  }

}
```
To improve performance, consider rasterizing MDCShadowLayer when the view using the shadow is not
animating or changing size.

```objective-c
self.layer.shouldRasterize = YES;
self.layer.rasterizationScale = [UIScreen mainScreen].scale;
```

Disable rasterization before animating MDCShadowLayer.
# ShadowMetrics

MDCShadowMetrics is a series of properties used to set MDCShadow. MDCShadow consists of two distinct
layers. The overlay of these two layers generates a single material design stylized shadow that
adheres to defined height and light source principles.
