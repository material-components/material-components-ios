<!-- This file was auto-generated using ./scripts/generate_readme TextControls -->

# TextControls

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BTextControls%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BTextControls%5D)

TextControls are controls used for text input that make use of classes like UITextField and UITextView.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/textfields.png" alt="TextFields" width="320">
</div>

## Design & API documentation


## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
- [Usage](#usage)
  - [TextFields](#textfields)
- [Theming](#theming)
  - [Theming](#theming)
- [Examples](#examples)
  - [Creating a textfield](#creating-a-textfield)

- - -

## Overview

At this time, the only text control we offer is the textfield. There are three textfield classes:

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--link">MDCFilledTextField: A textfield implementing the Material <a href="https://material.io/components/text-fields/#filled-text-field">filled style</a></li>
  <li class="icon-list-item icon-list-item--link">MDCOutlinedTextField: A textfield implementing the Material <a href="https://material.io/components/text-fields/#outlined-text-field">outlined style</a></li>
  <li class="icon-list-item icon-list-item">MDCBaseTextField: An unstyled textfield that the previous two inherit from</li>
</ul>

## Installation

<!-- Extracted from docs/installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/TextControls'
```
<!--{: .code-renderer.code-renderer--install }-->

Then, run the following command:

```bash
pod install
```

### Importing

To use TextControls in your code, import the MaterialTextControls umbrella header (Objective-C) or MaterialComponents module (Swift).

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
import MaterialComponents.MaterialTextControls
```

#### Objective-C

```objc
#import "MaterialTextControls.h"
```

<!--</div>-->



## Usage

<!-- Extracted from docs/typical-use.md -->

### TextFields

Using TextControl textfields is supposed to be as similar to using UITextField as possible. The most crucial difference from a usability standpoint relates to the sizing behavior of these textfields and the implications of that behavior for layout. Where UITextField can be whatever height a user wants it to be, MDCTextControl textfields have heights that they need to be in order to look correct. There is a precise vertical arrangement of the various subviews in MDCTextControl textfields, and this arrangement affects how tall the view ends up being. Other things like font also help determine the height. Ensuring that MDCTextControl textfields have their desired heights is done differently depending on whether one is working in an Auto Layout or a Manual Layout environment. In an Auto Layout environment, the textfield's desired height will be reflected in `intrinsicContentSize`, and the user will not have to do anything to ensure that the correct height is achieved. In a Manual Layout environment, methods like `sizeThatFits:` or `sizeToFit` must be used to inform the frames of the view.


## Theming

<!-- Extracted from docs/theming.md -->

### Theming

#### 
You can theme a textfield to match the Material Design style by using a theming extension. The content below assumes you have read the article on [Theming](../../docs/theming.md).

First, import the theming extension for TextControls and create a textfield.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
import MaterialComponents.MaterialTextControls
import MaterialComponents.MaterialTextControls_Theming

let textField = MDCOutlinedTextField()
```

#### Objective-C

```objc
#import <MaterialComponents/MaterialTextControls.h>
#import <MaterialComponents/MaterialTextControls+Theming.h>

MDCFilledTextField *filledTextField = [[MDCFilledTextField alloc] init];
```
<!--</div>-->

Then pass a container scheme to one of the theming methods on a theming extension.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
filledTextField.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
[self.filledTextField applyThemeWithScheme:self.containerScheme];
```
<!--</div>-->







## Examples

<!-- Extracted from docs/examples.md -->

### Creating a textfield

<!--<div class="material-code-render" markdown="1">-->
#### Swift

```swift
let estimatedFrame = ...
let textField = MDCFilledTextField(frame: estimatedFrame)
textField.label.text = "This is the floating label"
textField.leadingAssistiveLabel.text = "This is helper text"
textField.sizeToFit()
view.addSubview(textField)
```

#### Objective-C

```objc
CGRect estimatedFrame = ...
MDCOutlinedTextField *textField = [[MDCOutlinedTextField alloc] initWithFrame:estimatedFrame];
textField.label.text = "This is the floating label";
textField.leadingAssistiveLabel.text = "This is helper text";
[textField sizeToFit];
[view addSubview:textField];
```

<!--</div>-->

