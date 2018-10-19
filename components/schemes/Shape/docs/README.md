# Shape scheme

The Material Design shape system can be used to create a shape theme that reflects your brand or
style.

## Related Documentation

* [Theming](../../)

<!-- toc -->

- - -

## Overview

An implementation of the Material Design shape scheme is provided in the `MDCShapeScheme`
class. By default, an instance of this class is configured with the Material defaults. 
The following image shows an MDCButton themed with the default
shape scheme values (bottom) and an MDCButton themed with custom shape scheme values (top).

<img src="assets/shapethemedbuttons.png" width="144" alt="An MDCButton themed with the default shape scheme and a custom one.">

Currently, 5 components support being themed with a shape scheme using a `shape themer` extension, namely Cards, Buttons, FABs, Chips,
and Bottom Sheet. You can learn more about which extensions are available for a given component by reading the
[component documentation](../../../).

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

- [Shape to Component Mapping](shape-category-mapping.md)

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

- [Typical use: customizing a shape scheme](typical-use-customizing-a-scheme.md)

## Component content awareness when using custom shapes

- [Shapes impact on the component's content](shape-content-margins.md)
