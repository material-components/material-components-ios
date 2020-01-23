<!--docs:
title: "Action Sheet"
layout: detail
section: components
excerpt: "Material design action sheet displays a list of actions."
iconId: <#icon_id#>
path: /catalog/action-sheet/
api_doc_root: true
-->

<!-- This file was auto-generated using ./scripts/generate_readme ActionSheet -->

# Action Sheet

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BActionSheet%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BActionSheet%5D)

Material design action sheets should be used as an overflow menu. An Action Sheet comes up from the bottom of
the screen and displays actions a user can take.

<img src="docs/assets/actionSheetPortrait.gif" alt="An animation showing a Material Design Action Sheet." width="150"> <img src="docs/assets/actionSheetLandscape.gif" alt="An animation showing a Material Design Action Sheet." width="324">

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-action-sheet">Material Design guidelines: ActionSheet</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/action-sheet/api-docs/Classes/MDCActionSheetAction.html">MDCActionSheetAction</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://material.io/components/ios/catalog/action-sheet/api-docs/Classes/MDCActionSheetController.html">MDCActionSheetController</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://material.io/components/ios/catalog/action-sheet/api-docs/Protocols/MDCActionSheetControllerDelegate.html">MDCActionSheetControllerDelegate</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use](#typical-use)
- [MDCActionSheetController vs. UIAlertControllerStyleActionSheet](#mdcactionsheetcontroller-vs.-uialertcontrollerstyleactionsheet)
- [Customization](#customization)
  - [Positioning Action Sheet Actions](#positioning-action-sheet-actions)
- [Extensions](#extensions)
  - [Theming](#theming)
- [Accessibility](#accessibility)
  - [Set `-isScrimAccessibilityElement`](#set-`-isscrimaccessibilityelement`)
  - [Set `-scrimAccessibilityLabel`](#set-`-scrimaccessibilitylabel`)
  - [Set `-scrimAccessibilityHint`](#set-`-scrimaccessibilityhint`)
  - [Set `-scrimAccessibilityTraits`](#set-`-scrimaccessibilitytraits`)
- [Unsupported](#unsupported)
  - [Color Theming](#color-theming)
  - [Typography Theming](#typography-theming)

- - -

## Overview

`MDCActionSheetController` is a material design implementation of UIAlertControllerStyleActionSheet.

Action Sheet is currently a [beta component](../../contributing/beta_components.md). Therefore, clients that
wish to use Action Sheet in their app will need to manually clone the repo and add the code to their project. 


## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/ActionSheet'
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
import MaterialComponents.MaterialActionSheet
```

#### Objective-C

```objc
#import "MaterialActionSheet.h"
```
<!--</div>-->


## Usage

<!-- Extracted from docs/typical-use.md -->

### Typical use

Create an instance of `MDCActionSheetController` and add actions to it. You can now 
present the action sheet controller.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController(title: "Action Sheet", 
                                           message: "Secondary line text")
let actionOne = MDCActionSheetAction(title: "Home", 
                                     image: UIImage(named: "Home"), 
                                     handler: { print("Home action" })
let actionTwo = MDCActionSheetAction(title: "Email", 
                                     image: UIImage(named: "Email"), 
                                     handler: { print("Email action" })
actionSheet.addAction(actionOne)
actionSheet.addAction(actionTwo)

present(actionSheet, animated: true, completion: nil)
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet =
    [MDCActionSheetController actionSheetControllerWithTitle:@"Action sheet"
                                                     message:@"Secondary line text"];
MDCActionSheetAction *homeAction = 
    [MDCActionSheetAction actionWithTitle:@"Home"
                                    image:[UIImage imageNamed:@"Home"]
                                  handler:nil];
MDCActionSheetAction *favoriteAction =
    [MDCActionSheetAction actionWithTitle:@"Favorite"
                                    image:[UIImage imageNamed:@"Favorite"]
                                  handler:nil];
[actionSheet addAction:homeAction];
[actionSheet addAction:favoriteAction];
[self presentViewController:actionSheet animated:YES completion:nil];
```
<!--</div>-->


## MDCActionSheetController vs. UIAlertControllerStyleActionSheet

MDCActionSheetController is intended to mirror a [UIAlertController](https://developer.apple.com/documentation/uikit/uialertcontroller?language=objc)
with the [UIAlertControllerStyleActionSheet](https://developer.apple.com/documentation/uikit/uialertcontrollerstyle/uialertcontrollerstyleactionsheet) style.  

#### Similarities

1. Both classes are presented from the bottom of the screen on an iPhone and have a list of actions.

2. Both classes support optional title and message properties.

#### Differences

1. UIAlertControllerActionSheetStyle requires that you set the popoverPresentationController on larger devices, 
MDCActionSheetController doesn't support popoverPresentationController but instead always comes up from the 
bottom of the screen.

2. UIAlertControllerStyleActionSheet is a style of UIAlertController and not its own class. If you need a
Material UIAlertController please see the `MDCAlertController` class. 

3. MDCActionSheetController does not support text fields.

4. MDCActionSheetController does not have a preferredAction.

<!-- Extracted from docs/customization.md -->

## Customization

### Positioning Action Sheet Actions

The layout of the Action Sheet list items can be adjusted with the
`contentEdgeInsets` API. Positive values will inset the content and negative
values will outset the conent. The insets apply to all action items.

<img src="docs/assets/actionsheet-default appearance.png" alt="Action Sheet showing three items with default edge content insets." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with default content insets.

For example, setting top and bottom insets (positive values) will reduce the
height of the Action list items. 

<img src="docs/assets/actionsheet-top and bottom insets.png" alt="Action Sheet showing three items with top and bottom content edge insets." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with top and bottom content edge insets.

Setting a left outset (negative value) and right inset (positive value) will
shift the Action's content to the trailing edge.

<img src="docs/assets/actionsheet-left outset right inset.png" alt="Action Sheet showing three items with a left content edge outset and right inset shifting content to the right." width="375">
<!--{: .article__asset.article__asset--screenshot }-->
Action Sheet showing three items with a left content edge outset and right inset shifting content to the right.


## Extensions

<!-- Extracted from docs/theming.md -->

### Theming

You can theme an MDCActionSheet to match the Material Design style by using a theming extension. The content below assumes you have read the article on [Theming](../../docs/theming.md).

First, create an action sheet and import the theming extension header for Action Sheets.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialActionSheet
import MaterialComponents.MaterialActionSheet_Theming

let actionSheet = MDCActionSheetController()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialActionSheet.h>
#import <MaterialComponents/MaterialActionSheet+Theming.h>

MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
```
<!--</div>-->

You can then provide a container scheme instance to any of the MDCActionSheet theming extensions.

Then, you can theme your action sheet.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
actionSheet.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.actionSheet applyThemeWithScheme:self.containerScheme];
```
<!--</div>-->







<!-- Extracted from docs/accessibility.md -->

## Accessibility

To help ensure your Action Sheet is accessible to as many users as possible, please be sure to reivew the following
recommendations:

The scrim by default enables the "Z" gesture to dismiss. If `isScrimAccessibilityElement` is not set or is set to
`false` then `scrimAccessibilityLabel`, `scrimAccessibilityHint`, and `scrimAccessibilityTraits` will
have any effect.

### Set `-isScrimAccessibilityElement`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.isScrimAccessibilityElement = true
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.isScrimAccessibilityElement = YES;
```
<!--</div>-->

### Set `-scrimAccessibilityLabel`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityLabel = "Cancel"
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityLabel = @"Cancel";
```
<!--</div>-->

### Set `-scrimAccessibilityHint`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityHint = "Dismiss the action sheet"
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityHint = @"Dismiss the action sheet";
```

<!--</div>-->

### Set `-scrimAccessibilityTraits`

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
let actionSheet = MDCActionSheetController()
actionSheet.transitionController.scrimAccessibilityTraits = UIAccessibilityTraitButton
```

#### Objective-C

```objc
MDCActionSheetController *actionSheet = [MDCActionSheetController alloc] init];
actionSheet.scrimAccessibilityTraits = UIAccessibilityTraitButton;
```
<!--</div>-->


## Unsupported

<!-- Extracted from docs/color-theming.md -->

### Color Theming

You can theme an Action Sheet with your app's color scheme using the ColorThemer extension.

You must first add the Color Themer extension to your project:

```bash
pod `MaterialComponentsBeta/ActionSheet+ColorThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponentsBeta.MaterialActionSheet_ColorThemer

// Step 2: Create or get a color scheme
let colorScheme = MDCSemanticColorScheme()

// Step 3: Apply the color scheme to your component
let actionSheet = MDCActionSheetController()
MDCActionSheetColorThemer.applySemanticColorScheme(colorScheme, to: actionSheet)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialActionSheet+ColorThemer.h"

// Step 2: Create or get a color scheme
id<MDCColorScheming> colorScheme = [[MDCSematnicColorScheme alloc] init];

// Step 3: Apply the color scheme to your component
MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
[MDCActionSheetColorThemer applySemanticColorScheme:self.colorScheme
                            toActionSheetController:actionSheet];
```
<!--</div>-->

<!-- Extracted from docs/typography-theming.md -->

### Typography Theming

You can theme an Action Sheet with your app's typography scheme using the TypographyThemer extension.

You must first add the Typography Themer extension to your project:

```bash
pod `MaterialComponentsBeta/ActionSheet+TypographyThemer`
```

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the ColorThemer extension
import MaterialComponentsBeta.MaterialActionSheet_TypographyThemer

// Step 2: Create or get a color scheme
let typographyScheme = MDCTypographyScheme()

// Step 3: Apply the color scheme to your component
let actionSheet = MDCActionSheetController()
MDCActionSheetTypographyThemer.applyTypographyScheme(typographyScheme, to: actionSheet)
```

#### Objective-C

```objc
// Step 1: Import the ColorThemer extension
#import "MaterialActionSheet+TypographyThemer.h"

// Step 2: Create or get a color scheme
id<MDCTypographyScheming> typographyScheme = [[MDCTypographyScheme alloc] init];

// Step 3: Apply the color scheme to your component
MDCActionSheetController *actionSheet = [[MDCActionSheetController alloc] init];
[MDCActionSheetTypographyThemer applyTypographyScheme:self.typographyScheme
                              toActionSheetController:actionSheet];
```
<!--</div>-->

