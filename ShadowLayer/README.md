# ShadowLayer

This component provides an Core Animation Layer that will render a shadow based on its
elevation property.
UIViews can easily utilize this by overriding their layerClass method to return
MDCShadowLayer.

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
    self.shadowLayer.elevation = points
  }

}
```
