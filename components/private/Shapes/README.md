<!--docs:
title: "<#component_name#>"
layout: detail
section: components
excerpt: "Shapes consists of core APIs to create shaped surfaces."
iconId: shapes
path: /catalog/shapes/
api_doc_root: true
-->

<!-- This file was auto-generated using scripts/generate_readme private/Shapes -->

# Shapes Core

Our Shapes Core library consists of different APIs and classes we use to build shapes for our components. 
Concretely, to create a shape object, you'll need to create an object that implements the protocol `MDCShapeGenerating`. 
`MDCShapeGenerating` only has one method, `(CGPath *)pathForSize:(CGSize)size` that returns the shape’s `CGPath` for the expected size.

Our components support shapes by providing in their API a property called `id<MDCShapeGenerating> shapeGenerator`, which can receive any object that implements
the `MDCShapeGenerating` protocol, and applies the provided shape on the component.

## Related Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../ShapeLibrary">Shape Library</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Usage](#usage)

- - -

## Overview

For our convenience there are a few classes that help create an object that implements the protocol `MDCShapeGenerating`.

#### MDCPathGenerator
At the core there is `MDCPathGenerator`, which has a few helper methods to build a `CGPath`.
By providing a start point and end point, and using its different APIs to draw lines/curves between points, a CGPath is created.

#### MDCShapedShadowLayer
An `MDCShapedShadowLayer` class is used as the base layer of the component's view instead of `MDCShadowLayer` 
to allow shapes to work well with shadows, borders, and background color.

#### MDCShapedView
`MDCShapedView` is a base `UIView` that already incorporates `MDCShapedShadowLayer`, a shapeGenerator object,
and elevation, to provide a minimal view that has full shape support. 
This can be used as a basic building block to build on top of when building new components that need shape support from the get go.

#### MDCCornerTreatment and MDCEdgeTreatment
`MDCCornerTreatment` and `MDCEdgeTreatment` are both classes that provide a more modular approach for defining specifically the `CGPath` for a specific edge or corner.

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
