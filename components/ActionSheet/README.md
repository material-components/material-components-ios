<!-- This file was auto-generated using ./scripts/generate_readme ActionSheet -->

# Action Sheet

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BActionSheet%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BActionSheet%5D)

Material design action sheets should be used as an overflow menu. An Action Sheet comes up from the bottom of
the screen and displays actions a user can take.

<img src="docs/assets/actionSheetPortrait.gif" alt="An animation showing a Material Design Action Sheet." width="150"> <img src="docs/assets/actionSheetLandscape.gif" alt="An animation showing a Material Design Action Sheet." width="324">

## Design & API documentation


## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [Typical use](#typical-use)
- [MDCActionSheetController vs. UIAlertControllerStyleActionSheet](#mdcactionsheetcontroller-vs.-uialertcontrollerstyleactionsheet)
- [Extensions](#extensions)
- [Accessibility](#accessibility)
  - [Set `-scrimAccessibilityLabel`](#set-`-scrimaccessibilitylabel`)
  - [Set `-scrimAccessibilityHint`](#set-`-scrimaccessibilityhint`)
  - [Set `-isScrimAccessibilityElement`](#set-`-isscrimaccessibilityelement`)
  - [Set `-scrimAccessibilityTraits`](#set-`-scrimaccessibilitytraits`)

- - -

## Overview

`MDCActionSheetController` is a material design implementation of UIAlertControllerStyleActionSheet.

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

## Extensions

<!-- Extracted from docs/accessibility.md -->

## Accessibility

To help ensure your Action Sheet is accessible to as many users as possible, please be sure to reivew the following
recommendations:

The scrim by default enables the "Z" gesture to dismiss.

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



