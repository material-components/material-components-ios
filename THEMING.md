<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "Material Theming refers to the customization of your Material Design app to better reflect your product’s brand."
-->

# Theming

Material Theming refers to the customization of your Material Design app to better reflect your product’s brand.

## Overview

### Terminology

Our approach to theming relies on the relationships between the following concepts:

1. Components
2. Subsystem Schemes
3. The Container Scheme
4. Theming Extensions

Components are expected to provide public APIs for a variety of parameters. An example of a component is [MDCButton](https://github.com/material-components/material-components-ios/tree/develop/components/Buttons).

Subsystem schemes represent a set of opinionated properties that are intended to be mapped to component parameters. There is a scheme for each Material Theming subsystem. For example, there is a scheme for color, shape, and typography subsystems.

The Container scheme represents a single configurable entity that is applicable to all themeable components. A container scheme consists of all of the subsystem schemes.

Theming extensions are component extensions that, when invoked with a default container scheme, will configure a component to match the design system's defaults. When provided with subsystem schemes via a container scheme, the extension will map the subsystem scheme's values to the component’s parameters.

### Sensible defaults, yet highly configurable

By default, we try and give our components sensible values for all of their customizable properties, things such as `backgroundColor` or `titleFont`. You can use these defaults as a baseline, but we encourage you to theming your components to match your brand style.

### Schemes

<ul class="icon-list">
<li class="icon-list-item icon-list-item--link"><a href="Container/">Container scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Color/">Color scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Shape/">Shape scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Typography/">Typography scheme</a></li>
</ul>

#### Container scheme

The Container Scheme represents a single configurable entity that is applicable to all themeable Components. A Container Scheme consists of all of the Subsystem Schemes.

## Examples

### Using a subsystem scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
// Configure custom properties to match your branch
colorScheme.backgroundColor = .black
colorScheme.primaryColor = .yellow
colorScheme.secondaryColor = .red
```

#### Objective-C

```objc
#import "MaterialColorScheme.h"

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
// Configure custom properties to match your branch
colorScheme.backgroundColor = UIColor.blackColor;
colorScheme.primaryColor = UIColor.yellowColor;
colorScheme.secondaryColor = UIColor.redColor;
```
<!--</div>-->

### Creating a container scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialShapeScheme

let containerScheme = MDCContainerScheme()
containerScheme.colorScheme = myColorScheme
containerScheme.typographyScheme = myTypographyScheme
containerScheme.shapeScheme = myShapeScheme
```

#### Objective-C

```objc
#import "MaterialColorScheme.h"
#import "MaterialShapeScheme.h"
#import "MaterialTypographyScheme.h"

MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
containerScheme.colorScheme = self.myColorScheme;
containerScheme.shapeScheme = self.myShapeScheme;
containerScheme.typographyScheme = self.myTypographyScheme;
```
<!--</div>-->

### Theme component

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialButtons
import MaterialComponentsBeta.MaterialButtons_Theming
import MaterialComponentsBeta.MaterialContainerScheme


let containerScheme = MDCContainerScheme()
let button = MDCButton()
button.applyTextTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
#import "MaterialButtons.h"
#import "MaterialButtons+Theming.h"
#import "MaterialContainerScheme.h"


MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
MDCButton *button = [[MDCButton alloc] init];
[button applyTextThemeWithScheme:containerScheme];
```
<!--</div>-->


### Additional links

* [Material Design Theming document](https://material.io/design/material-theming/overview.html#)
* [Material Theming at Google I/O](https://youtu.be/3VUMl_l-_fI)
