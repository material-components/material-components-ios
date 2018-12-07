<!--docs:
title: "Slider"
layout: detail
section: components
excerpt: "The Slider component provides a Material Design control for selecting a value from a continuous range or discrete set of values."
iconId: slider
path: /catalog/sliders/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme Slider -->

# Slider

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BSlider%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BSlider%5D)

The `MDCSlider` object is a Material Design control used to select a value from a continuous range
or discrete set of values.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/slider.png" alt="Slider" width="375">
</div>

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-sliders">Material Design guidelines: Slider</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/sliders/api-docs/Classes/MDCSlider.html">MDCSlider</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/sliders/api-docs/Protocols/MDCSliderDelegate.html">MDCSliderDelegate</a></li>
</ul>

## Table of contents

- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use](#typical-use)
  - [Stateful APIs](#stateful-apis)
  - [Differences from UISlider](#differences-from-uislider)
- [Extensions](#extensions)
  - [Color Theming](#color-theming)
- [Accessibility](#accessibility)
  - [ `-accessibilityLabel`](#-`-accessibilitylabel`)
  - [Minimum touch size](#minimum-touch-size)

- - -

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/Slider'
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
import MaterialComponents.MaterialSlider
```

#### Objective-C

```objc
#import "MaterialSlider.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use.md -->

### Typical use

MDCSlider can be be used like a standard `UIControl`.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
override func viewDidLoad() {
  super.viewDidLoad()

  let slider = MDCSlider(frame: CGRect(x: 50, y: 50, width: 100, height: 27))
  slider.addTarget(self,
                   action: #selector(didChangeSliderValue(senderSlider:)),
                   for: .valueChanged)
  view.addSubview(slider)
}

func didChangeSliderValue(senderSlider:MDCSlider) {
  print("Did change slider value to: %@", senderSlider.value)
}
```

#### Objective C

```objc
- (void)viewDidLoad {
  MDCSlider *slider = [[MDCSlider alloc] initWithFrame:CGRectMake(50, 50, 100, 27)];
  [slider addTarget:self
                action:@selector(didChangeSliderValue:)
      forControlEvents:UIControlEventValueChanged];
  [self.view addSubview:slider];
}

- (void)didChangeSliderValue:(MDCSlider *)slider {
  NSLog(@"did change %@ value: %f", NSStringFromClass([slider class]), slider.value);
}
```
<!--</div>-->

<!-- Extracted from docs/stateful-apis.md -->

### Stateful APIs

`MDCSlider` exposes stateful APIs to customize the colors for different control states. In order to use this API you must enable `statefulAPIEnabled` on your `MDCSlider` instances.

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
 let slider = MDCSlider()
 slider.isStatefulAPIEnabled = true

 // Setting a thumb color for selected state.
 slider.setThumbColor(.red, for: .selected)
```

#### Objective C

```objc
 MDCSlider *slider = [[MDCSlider alloc] init];
 slider.statefulAPIEnabled = YES;
 
 // Setting a thumb color for selected state.
 [slider setThumbColor:[UIColor redColor] forState:UIControlStateSelected];
```
<!--</div>-->

<!-- Extracted from docs/differences-from-uislider.md -->

### Differences from UISlider

Does not have api to:

- set right and left icons
- set the thumb image
- set the right and left track images (for a custom track)
- set the right (background track) color

Same features:

- set color for thumb via @c thumbColor
- set color of track via @c trackColor

New features:

- making the slider a snap to discrete values via property numberOfDiscreteValues

#### `-accessibilityActivate`

Our implementation closely resembles what UISlider does but it's not an exact match. On an
`accessibilityActivate` we move one sixth of the amount between the current value and the midpoint value.


## Extensions

<!-- Extracted from docs/color-theming.md -->

### Color Theming

You can theme a slider with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod 'MaterialComponents/Slider+ColorThemer'
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponents.MaterialSlider_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
MDCSliderColorThemer.applySemanticColorScheme(colorScheme, to: component)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialSlider+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSemanticColorScheme alloc] initWithDefaults:MDCColorSchemeDefaultsMaterial201804];

// Step 3: Apply the color scheme to your component
[MDCSliderColorThemer applySemanticColorScheme:colorScheme
     toslider:component];
```
<!--</div>-->

<!-- Extracted from docs/accessibility.md -->

## Accessibility
To help ensure your slider is accessible to as many users as possible, please be sure to review the following recommendations:

###  `-accessibilityLabel`

Set an appropriate `accessibilityLabel` value for your slider. This should reflect what the slider affects.

#### Swift
```swift
slider.accessibilityLabel = "Volume level"
```

#### Objective - C
```objc
slider.accessibilityLabel = @"Volume level";
``` 

### Minimum touch size

Sliders currently respect the minimum touch size recomended by the Google Material spec [touch areas should be 
at least 48 points high and 48 wide](https://material.io/design/layout/spacing-methods.html#touch-click-targets). 
The height of the slider is set to 27 points so make sure there is sufficient space so that touches don't affect other 
elements.

