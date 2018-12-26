<!--docs:
title: "Shape scheme"
layout: detail
section: components
excerpt: "The Material shape scheme provides support for theming an app with a set of custom shapes."
iconId: themes
path: /catalog/theming/shape/
api_doc_root: true
-->

<!-- This file was auto-generated using scripts/generate_readme schemes/Shape -->

# Shape scheme

The Material Design shape system can be used to create a shape theme that reflects your brand or
style.

## Related Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="../">Theming</a></li>
</ul>

## Table of contents

- [Overview](#overview)
  - [Shape Values](#shape-values)
  - [Shape to Component Mapping](#shape-to-component-mapping)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use: customizing a shape scheme](#typical-use-customizing-a-shape-scheme)
- [Component content awareness when using custom shapes](#component-content-awareness-when-using-custom-shapes)

- - -

## Overview

An implementation of the Material Design shape scheme is provided in the `MDCShapeScheme`
class. By default, an instance of this class is configured with the Material defaults. 
The following image shows an MDCButton themed with the default
shape scheme values (bottom) and an MDCButton themed with custom shape scheme values (top).

<img src="docs/assets/shapethemedbuttons.png" width="144" alt="An MDCButton themed with the default shape scheme and a custom one.">

Currently, 5 components support being themed with a shape scheme using a `shape themer` extension, namely Cards, Buttons, FABs, Chips,
and Bottom Sheet. You can learn more about which extensions are available for a given component by reading the
[component documentation](../../).

### Shape Values

A shape scheme consists of the following shape values:

| Shape Category         | Use        |
|:---------------------  |:---------- |
| `smallComponentShape`  | The shape defining small sized components.  |
| `mediumComponentShape` | The shape defining medium sized components. |
| `largeComponentShape`  | The shape defining large sized components.  |

Each of the shape categories are of the class `MDCShapeCategory`. 

An `MDCShapeCategory` holds properties that define a shape value. It consists of 4 corners of type `MDCCornerTreatment` that represent each corner of the shape. It also has a convenience initializer to set all the 4 corners at once to the same value, creating a symmetrical shape.

Lastly, an `MDCCornerTreatment` can be set by using any of the convenience initializers in [MDCCornerTreatment+CornerTypeInitializer.h](https://github.com/material-components/material-components-ios/blob/develop/components/private/ShapeLibrary/src/MDCCornerTreatment%2BCornerTypeInitalizer.h).

### Shape to Component Mapping

<!-- Extracted from docs/shape-category-mapping.md -->

Below is a table showing how our shape categories are mapped to each component.

| Small Components | Medium Components | Large Components           |
|------------------|-------------------|----------------------------|
| Button           | Card              | Bottom Sheet (modal)       |
| Chip             | Dialog            | Navigation Drawer (bottom) |
| Extended FAB     |                   |                            |
| FAB              |                   |                            |
| Snackbar         |                   |                            |
| Textfield        |                   |                            |


## Installation

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/schemes/Shape'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To import the component:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialShapeScheme
```

#### Objective-C

```objc
#import "MaterialShapeScheme.h"
```
<!--</div>-->

## Usage

<!-- Extracted from docs/typical-use-customizing-a-scheme.md -->

### Typical use: customizing a shape scheme

You'll typically want to create one default `MDCShapeScheme` instance for your app where all
of the shape properties are set to your desired brand or style.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let shapeScheme = MDCShapeScheme()
// Small Component Shape
shapeScheme.smallComponentShape = MDCShapeCategory(cornersWith: .cut, andSize: 4)

// Medium Component Shape
shapeScheme.mediumComponentShape = MDCShapeCategory(cornersWith: .rounded, andSize: 10)

// Large Component Shape
let largeShapeCategory = MDCShapeCategory()
let rounded50PercentCorner = MDCCornerTreatment.corner(withRadius: 0.5,
                                                       valueType: .percentage)
let cut8PointsCorner = MDCCornerTreatment.corner(withCut: 8)
largeShapeCategory?.topLeftCorner = rounded50PercentCorner
largeShapeCategory?.topRightCorner = rounded50PercentCorner
largeShapeCategory?.bottomLeftCorner = cut8PointsCorner
largeShapeCategory?.bottomRightCorner = cut8PointsCorner
shapeScheme.largeComponentShape = largeShapeCategory
```

#### Objective-C

```objc
MDCShapeScheme *shapeScheme = [[MDCShapeScheme alloc] init];
// Small Component Shape
shapeScheme.smallComponentShape = 
    [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyCut
                                            andSize:4];

// Medium Component Shape
shapeScheme.mediumComponentShape = 
    [[MDCShapeCategory alloc] initCornersWithFamily:MDCShapeCornerFamilyRounded
                                            andSize:10];

// Large Component Shape
MDCShapeCategory *largeShapeCategory = [[MDCShapeCategory alloc] init];
MDCCornerTreatment *rounded50PercentCorner =
    [MDCCornerTreatment cornerWithRadius:(CGFloat)0.5 valueType:MDCCornerTreatmentValueTypePercentage];
MDCCornerTreatment *cut8PointsCorner = [MDCCornerTreatment cornerWithCut:8];
largeShapeCategory.topLeftCorner = rounded50PercentCorner;
largeShapeCategory.topRightCorner = rounded50PercentCorner;
largeShapeCategory.bottomLeftCorner = cut8PointsCorner;
largeShapeCategory.bottomRightCorner = cut8PointsCorner;
shapeScheme.largeComponentShape = largeShapeCategory;
```
<!--</div>-->


## Component content awareness when using custom shapes

<!-- Extracted from docs/shape-content-margins.md -->

Choosing a shape value for your shape scheme or component has an effect on the component's content.

As an example, we may choose the `smallComponentShape` category to have a cut corner treatment at a 50% value of its height. 
That will create a diamond-like shape, which in certain cases is likely to clip content. 
In other cases, such as with dynamic type, or a typography scheme with large fonts, even a less intrusive shape could potentially cut out content. 

Therefore, it is recommended to be mindful of how a custom shape manipulates the component and if that shape makes sense for your specific case. 
One recommendation is to use the built-in UIView’s `layoutMargins`. By setting it to a custom `UIEdgeInset` you can get the desired outcome for your content when using a custom shape.

