<!--docs:
title: "Buttons"
layout: detail
section: components
excerpt: "Material design buttons allow users to take actions, and make choices, with a single tap."
iconId: button
path: /catalog/buttons/
api_doc_root: true
-->

# Buttons

Material design buttons allow users to take actions, and make choices, with a single tap. There are
many distinct button styles including text buttons, contained buttons, and floating action buttons.

<img src="docs/assets/text.gif" alt="An animation showing a Material Design text button." width="128"> <img src="docs/assets/contained.gif" alt="An animation showing a Material Design contained button." width="128">

## Design & API Documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-buttons">Material Design guidelines: Buttons</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/buttons/api-docs/Classes/MDCButton.html">API: MDCButton</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="https://material.io/components/ios/catalog/buttons/api-docs/Classes/MDCFloatingButton.html">API: MDCFloatingButton</a></li>
</ul>

## Extensions

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link"><a href="docs/theming.md">Theming</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="docs/color-theming.md">Color Theming</a></li>
  <li class="icon-list-item icon-list-item--link"><a href="docs/typography-theming.md">Typography Theming</a></li>
</ul>

- - -

## Installation

### Requirements

- Xcode 8.3.3 or higher.
- iOS SDK version 8.0 or higher.

### Installation with CocoaPods

To add this component to your Xcode project using CocoaPods, add the following to your `Podfile`:

```
pod 'MaterialComponents/Buttons'
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
import MaterialComponents.MaterialButtons
```

#### Objective-C

```objc
#import "MaterialButtons.h"
```
<!--</div>-->

- - -

## Overview

`MDCButton` is a highly-configurable UIButton implementation that provides support for shadow
elevation, Material Design ripples, and other stateful design APIs.

## Usage

### Typical usage: themed buttons

Create an instance of `MDCButton` and theme it with as one of the Material Design button styles
using the ButtonThemer extension. Once themed, use the button like you would use a typical UIButton
instance.

See the [ButtonThemer documentation](docs/theming.md) for a full list of supported Material Design
button styles.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let button = MDCButton()

// Themed as a text button:
MDCTextButtonThemer.applyScheme(buttonScheme, to: button)
```

#### Objective-C

```objc
MDCButton *button = [[MDCButton alloc] init];

// Themed as a text button:
[MDCTextButtonThemer applyScheme:buttonScheme toButton:button];
```
<!--</div>-->

### Typical usage: floating action buttons

MDCFloatingButton is a subclass of MDCButton that implements the Material Design floating action
button style and behavior. Floating action buttons should be provided with a templated image for
their normal state.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
// Note: you'll need to provide your own image - the following is just an example.
let plusImage = UIImage(named: "plus").withRenderingMode(.alwaysTemplate)
let button = MDCFloatingButton()
button.setImage(plusImage, forState: .normal)
```

#### Objective-C

```objc
// Note: you'll need to provide your own image - the following is just an example.
UIImage *plusImage =
    [[UIImage imageNamed:@"plus"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
MDCFloatingButton *button = [[MDCFloatingButton alloc] init];
[button setImage:plusImage forState:UIControlStateNormal];
```
<!--</div>-->

### Customizing a button's design

#### Changing the elevation of a button

The elevation of a button can be changed for a given control state using `setElevation:forState:`.

See the [Material Design shadow guidelines](https://material.io/guidelines/what-is-material/elevation-shadows.html) for a detailed
overview of different shadow elevations.

For example, to make a button elevate on tap like a floating action button:

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
button.setElevation(6, for: .normal)
button.setElevation(12, for: .highlighted)
```

#### Objective-C

```objc
[button setElevation:6.0f forState:UIControlStateNormal];
[button setElevation:12.0f forState:UIControlStateNormal];
```
<!--</div>-->

### Customizing floating action buttons

A floating action button can be configured with a combination of `shape` and `mode`. The 
`.default` shape is a 56-point circle containing a single image or short title. The `.mini` shape
is a smaller, 40-point circle.  The `.normal` mode is a circle containing an image or short title.
The `.expanded` mode is a "pill shape" and should include both an image and a single-word title. The
`.expanded` mode should only be used in the largest layouts. For example, an iPad in full screen.

While in the `.expanded` mode, a floating button can position its `imageView` to either the leading
or trailing side of the title by setting the `imageLocation` property.

Because of the combination of shapes and modes available to the floating action button, some
UIButton property setters have been made unavailable and replaced with methods to set them for a 
specific mode and shape combination. Getters for these values are not available, and the normal
getter will return the current value of the property.

* `-setContentEdgeInsets` is replaced with `-setContentEdgeInsets:forShape:inMode:`
* `-setHitAreaInsets` is replaced with `-setHitAreaInsets:forShape:inMode:`
* `-setMinimumSize` is replaced with `-setMinimumSize:forShape:inMode:`
* `-setMaximumSize` is replaced with `-setMaximumSize:forShape:inMode:`

### Interface Builder support

MDCButton and its subclasses can be used in Interface Builder, but the button type **must** be set
to "custom" in order for the button's highlight states to work as expected.
