<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "Material Theming refers to the customization of your Material Design app to better reflect your product’s brand."
path: /catalog/theming/
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

Subsystem schemes represent a set of opinionated properties that are intended to be mapped to component parameters. There is a scheme for each Material Theming subsystem. For example, there is a scheme for the color, shape, and typography subsystems.

The Container scheme represents a single configurable entity that is applicable to all themeable components. A container scheme consists of all of the subsystem schemes.

Theming extensions are component extensions that, when invoked with a default container scheme, will theme a component according to the [Material Design guidelines](https://material.io/design). When provided with subsystem schemes via a container scheme, the extension will map the subsystem scheme's values to the component’s parameters.

### Sensible defaults, yet highly configurable

By default, components have reasonable defaults for all of their customizable properties, e.g. `backgroundColor` or `titleFont`. You can use these defaults as a baseline, but we encourage you to theme your components to match your brand style using theming extensions.

### Schemes

<ul class="icon-list">
<li class="icon-list-item icon-list-item--link"><a href="Container/">Container scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Color/">Color scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Shape/">Shape scheme</a></li>
<li class="icon-list-item icon-list-item--link"><a href="Typography/">Typography scheme</a></li>
</ul>

## Examples

### Theming a Component

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
#import <MaterialComponents/MaterialButtons.h>
#import <MaterialComponents/MaterialButtons+Theming.h>
#import <MaterialComponentsBeta/MaterialContainerScheme.h>

MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
MDCButton *button = [[MDCButton alloc] init];
[button applyTextThemeWithScheme:containerScheme];
```
<!--</div>-->

### Creating a container scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme
import MaterialComponents.MaterialTypographyScheme
import MaterialComponents.MaterialShapeScheme
import MaterialComponentsBeta.MaterialContainerScheme

let containerScheme = MDCContainerScheme()
containerScheme.colorScheme = myColorScheme
containerScheme.typographyScheme = myTypographyScheme
containerScheme.shapeScheme = myShapeScheme
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialColorScheme.h>
#import <MaterialComponents/MaterialShapeScheme.h>
#import <MaterialComponents/MaterialTypographyScheme.h>
#import <MaterialComponentsBeta/MaterialContainerScheme.h>

MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];
containerScheme.colorScheme = self.myColorScheme;
containerScheme.shapeScheme = self.myShapeScheme;
containerScheme.typographyScheme = self.myTypographyScheme;
```
<!--</div>-->

### Using a subsystem scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
// Configure custom properties to match your brand
colorScheme.backgroundColor = .lightGray
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialColorScheme.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
// Configure custom properties to match your brand
colorScheme.backgroundColor = UIColor.lightGrayColor
```
<!--</div>-->

### How to get the code

#### Beta components

In order to use the theming extensions and container scheme you'll need to follow [these](../../contributing/beta_components.md) 
instructions since they are currently in beta.

#### Cocoapods

In order to use the components and subsystem schemes you'll need to add the targets to your Podfile:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/Buttons'
pod 'MaterialComponents/schemes/Color'
```
<!--</div>-->

## Themers

**Note** These will soon be deprecated for theming-extensions outlined above.

Our approach to theming relies on the relationships between the following concepts:

1. Components
2. Schemes
3. Themers

Components are expected to provide public APIs for a variety of parameters. An example of a component is [MDCBottomNavigation](https://github.com/material-components/material-components-ios/tree/develop/components/BottomNavigation).

Schemes represent a set of opinionated properties that are intended to be mapped to component parameters. There is a scheme for each Material Theming subsystem. For example, there is a scheme for the color, shape, and typography subsystems.

Themers are objects that, when invoked with a scheme, will theme a component according to the [Material Design guidelines](https://material.io/design).

## Examples

### Theming a Component

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialBottomNavigation
import MaterialComponents.MaterialBottomNavigation_ColorThemer

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
let bottomNavBar = MDCBottomNavigationBar()
MDCBottomNavigationBarColorThemer.applySemanticColorScheme(colorScheme,
toBottomNavigation: bottomNavBar)
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialBottomNavigation.h>
#import <MaterialComponents/MaterialBottomNavigation+ColorThemer.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
MDCBottomNavigation *bottomNavBar = [[MDCBottomNavigation alloc] init];
[MDCBottomNavigationBarColorThemer applySemanticColorScheme:self.colorScheme
toBottomNavigation:_bottomNavBar];
```
<!--</div>-->

### Using a scheme

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialColorScheme

let colorScheme = MDCSemanticColorScheme(defaults: .material201804)
// Configure custom properties to match your brand
colorScheme.backgroundColor = .lightGray
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialColorScheme.h>

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];
// Configure custom properties to match your brand
colorScheme.backgroundColor = UIColor.lightGrayColor
```
<!--</div>-->

### How to get the code

#### Cocoapods

In order to use the components, themers and subsystem schemes you'll need to add the targets to your Podfile:

<!--<div class="material-code-render" markdown="1">-->

```bash
pod 'MaterialComponents/BottomNavigation'
pod 'MaterialComponents/BottomNavigation+ColorThemer'
pod 'MaterialComponents/schemes/Color'
```
<!--</div>-->

## Additional links

* [Material Guidelines introduction to Theming](https://material.io/design/material-theming/overview.html)
* [Material Theming at Google I/O](https://youtu.be/3VUMl_l-_fI)
