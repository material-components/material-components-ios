<!--docs:
title: "ShapeLibrary"
layout: detail
section: components
excerpt: "ShapeLibrary consists of convenience APIs to create shaped surfaces."
iconId: shapelibrary
path: /catalog/shapelibrary/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme ShapeLibrary -->

# Shape Library

Our Shape Library consists of different convenience APIs and classes we use to build a shape.
Specifically, the classes in this library sit on top of our [core Shapes implementation](../Shapes), and that implementation
should be understood and used before making use of the classes here.

## Related Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../Shapes">Core Shapes Implementation</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Usage](#usage)

- - -

## Overview

The classes described below are convenience APIs on top of `MDCRectangleShapeGenerator`:

#### MDCCurvedCornerTreatment

Generates an MDCCornerTreatment that is curved and receives a size to define the size of the curve.

#### MDCCutCornerTreatment

Generates an MDCCornerTreatment that is a cut corner and receives a cut to define by how much to cut.

#### MDCRoundedCornerTreatment

Generates an MDCCornerTreatment that is rounded and receives a radius to define the radius of the rounding.

#### MDCTriangleEdgeTreatment

Generates an MDCEdgeTreatment that consists of a triangle of a settable size and style.

The classes described below are convenience shape generators that create an `MDCRectangleShapeGenerator` subclass that consist of preset corner and edge treatments:

#### MDCCurvedRectShapeGenerator

This generates a shape using MDCRectangleShapeGenerator with MDCCurvedCornerTreatment for its corners.

#### MDCPillShapeGenerator

This generates a shape using MDCRectangleShapeGenerator with MDCRoundedCornerTreatment for its corners.

#### MDCSlantedRectShapeGenerator

This generates a shape using MDCRectangleShapeGenerator and adds a slant to its corners using a simple offset to its corners.


## Usage

You'll typically create an `MDCRectangleShapeGenerator` instance that you set your component with.
Components that support the shape system will have a `id<MDCShapeGenerating> shapeGenerator` property as part of their API.
By setting the `shapeGenerator` property with your `MDCRectangleShapeGenerator`, you will provide the defined shape to your component.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let card = MDCCard()
let shapeGenerator = MDCRectangleShapeGenerator()
let cutCornerTreatment = MDCCutCornerTreatment(cut: 4)
shapeGenerator.setCorners(cutCornerTreatment)
let triangleEdgeTreatment = MDCTriangleEdgeTreatment(size: 8, style: MDCTriangleEdgeStyleCut)
shapeGenerator.setEdges(triangleEdgeTreatment)
card.shapeGenerator = shapeGenerator
```

#### Objective-C

```objc
MDCCard *card = [[MDCCard alloc] init];
MDCRectangleShapeGenerator *shapeGenerator = [[MDCRectangleShapeGenerator alloc] init];
MDCCutCornerTreatment *cutCornerTreatment = [[MDCCutCornerTreatment alloc] initWithCut: 4];
[shapeGenerator setCorners:cutCornerTreatment];
MDCTriangleEdgeTreatment *triangleEdgeTreatment = [[MDCTriangleEdgeTreatment alloc] initWithSize: 8 style: MDCTriangleEdgeStyleCut];
[shapeGenerator setEdges:triangleEdgeTreatment];
card.shapeGenerator = shapeGenerator;
```
<!--</div>-->
