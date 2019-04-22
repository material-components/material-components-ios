<!--docs:
title: "Shapes"
layout: detail
section: components
excerpt: "Shapes consists of core APIs to create shaped surfaces."
iconId: shapes
path: /catalog/shapes/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme Shapes -->

# Shapes Core

This library consists of several classes that are often used together to implement Shape behavior on a component.
Concretely, to create a shape object, you'll need to create an object that implements the `MDCShapeGenerating` protocol. 
`MDCShapeGenerating` only has one method, `(CGPath *)pathForSize:(CGSize)size` that returns the shape’s `CGPath` for the expected size.

Our components support shapes by providing a property called `id<MDCShapeGenerating> shapeGenerator` and applies the provided shape to the component.

## Related Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../ShapeLibrary">Shape Library</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Usage](#usage)

- - -

## Overview

Listed below are classes that can be used to create an object that implements the `MDCShapeGenerating` protocol.

#### MDCPathGenerator

At the core there is `MDCPathGenerator`, which provides helper methods for building a `CGPath`.
By providing a start point and end point, and using its different APIs to draw lines/curves between points, a CGPath is created.

#### MDCShapedShadowLayer

An `MDCShapedShadowLayer` class is used as the main layer class of the component's view instead of `MDCShadowLayer` 
to allow shapes to work well with shadows, borders, and background color.

The same way we override the layer in our components with `MDCShadowLayer` to achieve a shadow, we instead use `MDCShapedShadowLayer` like so:

```objc
@interface Component ()
@property(nonatomic, readonly, strong) MDCShapedShadowLayer *layer;
@end

@implementation Component

@dynamic layer;

+ (Class)layerClass {
  return [MDCShapedShadowLayer class];
}
@end
```

#### MDCShapedView

`MDCShapedView` is a base `UIView` that incorporates `MDCShapedShadowLayer`, a shapeGenerator object,
and elevation, to provide a minimal view that has full shape support. 
This can be used as a building block for components that need shape support.

#### MDCCornerTreatment and MDCEdgeTreatment

`MDCCornerTreatment` and `MDCEdgeTreatment` are both classes that provide a modular approach for defining specifically the `CGPath` for a specific edge or corner.

#### MDCRectangleShapeGenerator

The last class in the Shapes Core library is `MDCRectangleShapeGenerator`. 
It is a shapeGenerator on its own (meaning it implements `MDCShapeGenerating`),
and generates a `CGPath` but allows good customization as part of its implementation. 
It allows to set each of its corners and edges by using its `MDCCornerTreatments` and `MDCEdgeTreatment`. 
With this class we can basically build any Shape we want.

## Usage

You'll typically create an `MDCRectangleShapeGenerator` instance that you set your component with.
Components that support the shape system will have a `id<MDCShapeGenerating> shapeGenerator` property as part of their API.
By setting the `shapeGenerator` property with your `MDCRectangleShapeGenerator`, you will provide the defined shape to your component.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let card = MDCCard()
let shapeGenerator = MDCRectangleShapeGenerator()
card.shapeGenerator = MDCRectangleShapeGenerator()
```

#### Objective-C

```objc
MDCCard *card = [[MDCCard alloc] init];
MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
card.shapeGenerator = shapeGenerator;
```
<!--</div>-->
