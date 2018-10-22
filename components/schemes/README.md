<!--docs:
title: "Theming"
layout: detail
section: components
excerpt: "Material Theming refers to the customization of your Material Design app to better reflect your product’s brand."
path: /catalog/theming/
-->

# Theming

Material Theming refers to the customization of your Material Design app to better reflect your product’s brand.

## Design documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-theming">Material Theming</a></li>
</ul>

- - -

## Overview

Material Theming is a consistent way to apply a uniform design across your app when using Material Components for iOS. Material Theming on iOS consists of two primary patterns: schemes and themers.

- **Schemes** represent your design as systemized symbols.
- **Themers** are the glue that apply scheme symbols to components.

For example, there is a scheme for both the Material Design typography system and the Material
Design color system. Most components have a themer for at least one of these systems.

### Sensible defaults, yet highly configurable

By default, an instance of a scheme is initialized with the Material defaults. You can use these
defaults as a baseline, but at a minimum we encourage you to tweak your color scheme's primary and
secondary colors to match your brand colors.

### Schemes

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="Color/">Color scheme</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="Shape/">Shape scheme</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="Typography/">Typography scheme</a></li>
</ul>

## Examples

### Creating a scheme

In order to access the scheme APIs you'll first need to add the scheme target to your Podfile:

```bash
pod 'MaterialComponents/schemes/Color'
pod 'MaterialComponents/schemes/Shape'
pod 'MaterialComponents/schemes/Typography'
```

Consider where you will want to store your schemes so that they are accessible by your components.
One solution is to have a global singleton that exposes shared scheme instances as we've done in
the MDCCatalog, but the approach you take should be influenced by your app's architecture.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialColorScheme
import MaterialShapeScheme
import MaterialTypographyScheme

let colorScheme = MDCSemanticColorScheme()
let shapeScheme = MDCShapeScheme()
let typographyScheme = MDCTypographyScheme()
```

#### Objective-C

```objc
#import "MaterialColorScheme.h"
#import "MaterialTypographyScheme.h"

MDCSemanticColorScheme *colorScheme = [[MDCSemanticColorScheme alloc] init];
MDCShapeScheme *shapeScheme = [[MDCShapeScheme alloc] init];
MDCTypographyScheme *typographyScheme = [[MDCTypographyScheme alloc] init];
```
<!--</div>-->

### Applying a scheme

To apply a scheme to a component you must first add the component's themers to your
Podfile. You can see which themers a given component supports by looking at the component's src/
directory.

```bash
pod 'MaterialComponents/Buttons+ColorThemer'
pod 'MaterialComponents/Buttons+ShapeThemer'
pod 'MaterialComponents/Buttons+TypographyThemer'
```

You can now access the Button themers.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialButtons_ColorThemer
import MaterialComponents.MaterialButtons_ShapeThemer
import MaterialComponents.MaterialButtons_TypographyThemer

func applyGlobalTheme(to button: MDCButton) {
  MDCButtonColorThemer.applySemanticColorScheme(colorScheme, to: button)
  MDCButtonShapeThemer.apply(shapeScheme, to: button)
  MDCButtonTypographyThemer.apply(typographyScheme, to: button)
}
```

#### Objective-C

```objc
#import "MaterialButtons+ColorThemer.h"
#import "MaterialButtons+ShapeThemer.h"
#import "MaterialButtons+TypographyThemer.h"

void ApplyGlobalThemeToButton(MDCButton *button) {
  [MDCButtonColorThemer applySemanticColorScheme:colorScheme toButton:button];
  [MDCButtonTypographyThemer applyTypographyScheme:typographyScheme toButton:button];
}
```
<!--</div>-->
