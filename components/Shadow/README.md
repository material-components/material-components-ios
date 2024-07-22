# Shadow

Provides lightweight classes that hold shadow properties that each correspond to an elevation.

This library provides two immutable types that are created via builder APIs:
MDCShadowsCollection and MDCShadow. This library works with standard CALayer shadow APIs in order
to optimize for performance. UIView’s layer shadow properties are set directly, including:
shadowOffset, shadowRadius, shadowOpacity, shadowColor, and shadowPath. We ensure that
shadowPath is consistently set alongside the other properties in order for shadows to benefit
from the performance gains that shadowPath provides.

This library is part of an effort to simplify shadows in MDC, with the intent of deleting the
MDCShadowLayer component entirely.

## Usage

We want to provide a simple API to integrate this shadow solution. Therefore, we leaned on providing only one type of configuration method that should be re-called in the view’s lifecycle. Namely, the method should be the C function MDCConfigureShadowForView.

MDCConfigureShadowForView should be called in the start of the view’s lifecycle, i.e. during initialization, so that the shadowRadius, shadowOffset, shadowColor, and shadowOpacity are set on the layer.

MDCConfigureShadowForView should also be called when the elevation is changed for the view i.e. it is set by the client, or there is a state change that also changes the elevation. This is to ensure that the right shadow values for that elevation are set on the layer.
Lastly, MDCConfigureShadowForView should be called in layoutSubviews, to ensure that the shadowPath is set using the most up to date bounds and cornerRadius of the view.

### Importing Shadow

Before using Shadow, you'll need to import it:

#### Swift
```swift
import MaterialComponents

var shadowsCollection: MDCShadowsCollection
let shadow = MDCShadowBuilder.builder(withOpacity:0.1, radius: 0.2, offset: CGSize(0.3, 0.4)).build()
let shadowsBuilder = MDCShadowsCollectionBuilder.builder(withShadow:shadow forElevation:0)
let shadowValuesForElevation = [1: MDCShadowBuilder.builder(withOpacity:0.3,
                                                            radius: 0.4,
                                                            offset: CGSize(0.5, 0.6)).build()]
shadowsBuilder.addShadows(forElevation:shadowValuesForElevation)
shadowsCollection = shadowsBuilder.build()

...

func updateShadow() {
  MDCConfigureShadowForView(self,
                            self.shadowsCollection.shadow(forElevation:self.mdc_currentElevation),
                            self.shadowColor)
}
```

#### Objective-C
```objc
#import "MaterialShadow.h"

MDCShadowsCollection *shadowsCollection;
MDCShadow *shadow =
    [[MDCShadowBuilder builderWithOpacity:0.1
                                   radius:0.2
                                   offset:CGSizeMake(0.3, 0.4)] build];
MDCShadowsCollectionBuilder *shadowsBuilder =
    [MDCShadowsCollectionBuilder builderWithShadow:shadow forElevation:0];
NSDictionary<NSNumber *, MDCShadow *> *shadowValuesForElevation = @{
  @1 : [[MDCShadowBuilder builderWithOpacity:0.3
                                      radius:0.4
                                      offset:CGSizeMake(0.5, 0.6)] build],
};
[shadowsBuilder addShadowsForElevations:shadowValuesForElevation];
shadowsCollection = [shadowsBuilder build];

...

- (void)updateShadow {
  MDCConfigureShadowForView(self,
                            [self.shadowsCollection shadowForElevation:self.mdc_currentElevation],
                            self.shadowColor);
}
```
