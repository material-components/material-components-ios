<!-- This file was auto-generated using ./scripts/generate_readme TextFields -->

# Text fields

[![Open bugs badge](https://img.shields.io/badge/dynamic/json.svg?label=open%20bugs&url=https%3A%2F%2Fapi.github.com%2Fsearch%2Fissues%3Fq%3Dis%253Aopen%2Blabel%253Atype%253ABug%2Blabel%253A%255BTextFields%255D&query=%24.total_count)](https://github.com/material-components/material-components-ios/issues?q=is%3Aopen+is%3Aissue+label%3Atype%3ABug+label%3A%5BTextFields%5D)

Text fields allow users to input text into your app. They are a direct connection to your users' thoughts and intentions via on-screen, or physical, keyboard. The Material Design Text Fields take the familiar element to new levels by adding useful animations, character counts, helper text, error states, and styles.

<div class="article__asset article__asset--screenshot">
  <img src="docs/assets/textfields.png" alt="Text Fields" width="375">
</div>

MDC's text fields come in several styles and have a great range of customization. Google's UX research has determined that Outlined and Filled (aka 'text box') styles perform the best by a large margin. So use  `MDCTextInputControllerFilled`, `MDCTextInputControllerOutlined`, and `MDCTextInputControllerOutlinedTextArea` if you can and set colors and fonts that match your company's branding.

For more information on text field styles, and animated images of each style in action, see [Text Field Styles](./styling).

## Design & API documentation

<ul class="icon-list">
  <li class="icon-list-item icon-list-item--spec"><a href="https://material.io/go/design-text-fields">Material Design guidelines: Text fields</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCIntrinsicHeightTextView.h">MDCIntrinsicHeightTextView</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/private/MDCTextInputAllCharactersCounter.m">MDCTextInputAllCharactersCounter</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerFilled.h">MDCTextInputControllerFilled</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerLegacyDefault.h">MDCTextInputControllerLegacyDefault</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerLegacyFullWidth.h">MDCTextInputControllerLegacyFullWidth</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerOutlined.h">MDCTextInputControllerOutlined</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerOutlinedTextArea.h">MDCTextInputControllerOutlinedTextArea</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerUnderline.h">MDCTextInputControllerUnderline</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCMultilineTextField.h">MDCMultilineTextField</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextField.h">MDCTextField</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputBorderView.h">MDCTextInputBorderView</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerBase.h">MDCTextInputControllerBase</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerFullWidth.h">MDCTextInputControllerFullWidth</a></li>
  <li class="icon-list-item icon-list-item--link">Class: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputUnderlineView.h">MDCTextInputUnderlineView</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInput.h">MDCLeadingViewTextInput</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInput.h">MDCMultilineTextInput</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCMultilineTextInputDelegate.h">  </a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCMultilineTextInputLayoutDelegate.h">MDCMultilineTextInputLayoutDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInput.h">MDCTextInput</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputCharacterCounter.h">MDCTextInputCharacterCounter</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputController.h">MDCTextInputController</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInputControllerFloatingPlaceholder.h">MDCTextInputControllerFloatingPlaceholder</a></li>
  <li class="icon-list-item icon-list-item--link">Protocol: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextFieldPositioningDelegate.h">MDCTextInputPositioningDelegate</a></li>
  <li class="icon-list-item icon-list-item--link">Enumeration: <a href="https://github.com/material-components/material-components-ios/blob/develop/components/TextFields/src/MDCTextInput.h">MDCTextInputTextInsetsMode</a></li>
</ul>

## Table of contents

- [Overview](#overview)
- [Installation](#installation)
  - [Installation with CocoaPods](#installation-with-cocoapods)
  - [Importing](#importing)
  - [Text Field Classes: The Inputs](#text-field-classes-the-inputs)
  - [Text Input Controller Classes: Recommended](#text-input-controller-classes-recommended)
  - [Text Input Controller Classes: Cautioned](#text-input-controller-classes-cautioned)
  - [Text Input Controller Classes: For Subclassing Only](#text-input-controller-classes-for-subclassing-only)
- [Usage](#usage)
- [Examples - Multi Line](#examples---multi-line)
  - [Text Field with Floating Placeholder](#text-field-with-floating-placeholder)
  - [Text Field with Character Count and Inline Placeholder](#text-field-with-character-count-and-inline-placeholder)
- [Extensions](#extensions)
  - [Theming Extensions](#theming-extensions)
- [Accessibility](#accessibility)
  - [MDCTextField Accessibility](#mdctextfield-accessibility)

- - -

## Overview

Text Fields provides both a single-line version based on `UITextField` and a multi-line version backed by `UITextView` as well as objects that customize the text fields' behavior and appearance called 'Text Input Controllers'.

The actual components (`MDCTextField` & `MDCMultilineTextField`) are 'dumb': they do not have styles, animations, or advanced features. They are designed to be controlled from the outside, via very liberal public API, with a text input controller.

Most text input controllers included are based on `MDCTextInputControllerBase` which manipulates the exposed elements of the text field to make placeholders float.

There is also a text input controller for full-width forms (`MDCTextInputControllerFullWidth`). Like `MDCTextInputControllerBase`d controllers, it also handles errors and character counting but has not been thoroughly tested with UX research.

Customize the included text input controllers via their parameters or create your own to express your app's brand identity thru typography, color, and animation: if the placeholder should move, add constraints or change the frame. If the trailing label should display validation information, change the text and color it.

This pattern is not a delegation or data source-like relationship but rather a controller-to-view relationship: the text field does not require nor expect to be served data or instruction but is instead malleable and easily influenced by outside interference.

## Installation

<!-- Extracted from docs/../../../docs/component-installation.md -->

### Installation with CocoaPods

Add the following to your `Podfile`:

```bash
pod 'MaterialComponents/TextFields'
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
import MaterialComponents.MaterialTextFields
```

#### Objective-C

```objc
#import "MaterialTextFields.h"
```
<!--</div>-->


<!-- Extracted from docs/classes.md -->

### Text Field Classes: The Inputs

#### Text Field

This is a single-line text input. It's subclassed from `UITextField` and supports all the features you'd expect from a `UITextField`:

- Placeholder
- Overlay views (left and right / leading and trailing)
- Custom fonts, colors
- Clear button

as well as new features:

- Underline
- Labels below the input
- Custom layouts
- Persistable placeholder
- Border view

#### Multi-line Text Field

This is a multi-line text input. It's subclassed from `UIView` with an embedded `UITextView`. It supports all the features of the single-line text field and `UITextView` plus:

<ul class="icon-list">
<li class="icon-list-item icon-list-item">Minimum number of lines</li>
</ul>

### Text Input Controller Classes: Recommended

See [Text Field Styles](./styling) for images and details.

These are the controllers that have been optimized for discoverability and clickability thru rigorous research, design iterations, and user testing. Always try to use one of these first.

#### MDCTextInputControllerFilled

Filled background with underline.

#### MDCTextInputControllerOutlined

Outlined background with no fill.

#### MDCTextInputControllerOutlinedTextArea

Nearly identical to `MDCTextInputControllerOutlined` but with two differences:

- Intended only for multi-line text fields that remain expanded when empty
- The floating placeholder does not cross the border but rather floats below it

### Text Input Controller Classes: Cautioned

See [Text Field Styles](./styling) for images and details.

These are the controllers that have performed the worst in user testing or haven't been extensively user tested at all. Use them only if you have to or conduct your own A/B testing against one of the recommended controllers to see if they perform as expected in your application.

#### MDCTextInputControllerFullWidth

Optimized for full width forms like emails. While common in messaging apps, its design hasn't been rigorously tested with users. For now, the Material Design team suggests using this only when another design is impracticle.

#### MDCTextInputControllerUnderline

'Classic' 2014 Material Design text field. This style is still found in many applications and sites but should be considered deprecated. It tested poorly in Material Research's user testing. Use `MDCTextInputControllerFilled` or `MDCTextInputControllerOutlined` instead.

#### MDCTextInputControllerLegacyDefault && MDCTextInputControllerLegacyFullWidth

Soon to be deprecated styles only created and included for backwards compatibility of the library. They have no visual distinction from the other full width and underline controllers but their layout behaves slightly differently.

### Text Input Controller Classes: For Subclassing Only

See [Text Field Styles](./styling) for images and details.

#### MDCTextInputControllerBase

__This class is meant to be subclassed and not used on its own.__ It's a full implementation of the `MDCTextInputControllerFloatingPlaceholder` protocol and holds all the 'magic' logic necessary to make:

- Floating placeholder animations
- Errors
- Character counts


## Usage

<!-- Extracted from docs/usage.md -->

A text field that conforms to `MDCTextInput` can be added to a view hierarchy the same way `UITextField` and `UIView` are. But to achieve the animations and presentations defined by the guidelines (floating placeholders, character counts), a controller that conforms to protocol `MDCTextInputController` must be initialized to manage the text field.

**NOTE:** Expect to interact with _both the text field_ (for the traditional API) _and the controller_ (for changes affecting the presentation and state).


<!-- Extracted from docs/examples.md -->

## Examples - Multi Line

### Text Field with Floating Placeholder

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
let textFieldFloating = MDCMultilineTextField()
scrollView.addSubview(textFieldFloating)

textFieldFloating.placeholder = "Full Name"
textFieldFloating.textView.delegate = self

textFieldControllerFloating = MDCTextInputControllerUnderline(textInput: textFieldFloating) // Hold on as a property
```

#### Objective-C

``` objc
MDCMultilineTextField *textFieldFloating = [[MDCMultilineTextField alloc] init];
[self.scrollView addSubview:textFieldFloating];

textFieldFloating.placeholder = @"Full Name";
textFieldFloating.textView.delegate = self;

self.textFieldControllerFloating = [[MDCTextInputControllerUnderline alloc] initWithTextInput:textFieldFloating];
```
<!--</div>-->

### Text Field with Character Count and Inline Placeholder

<!--<div class="material-code-render" markdown="1">-->
#### Swift

``` swift
// First the text field component is setup just like a UITextField
let textFieldDefaultCharMax = MDCMultilineTextField()
scrollView.addSubview(textFieldDefaultCharMax)

textFieldDefaultCharMax.placeholder = "Enter up to 50 characters"
textFieldDefaultCharMax.textView.delegate = self

// Second the controller is created to manage the text field
textFieldControllerDefaultCharMax = MDCTextInputControllerUnderline(textInput: textFieldDefaultCharMax) // Hold on as a property
textFieldControllerDefaultCharMax.characterCountMax = 50
textFieldControllerDefaultCharMax.isFloatingEnabled = false
```

#### Objective-C

``` objc
// First the text field component is setup just like a UITextField
MDCMultilineTextField *textFieldDefaultCharMax = [[MDCMultilineTextField alloc] init];
[self.scrollView addSubview:textFieldDefaultCharMax];

textFieldDefaultCharMax.placeholder = @"Enter up to 50 characters";
textFieldDefaultCharMax.textView.delegate = self;

// Second the controller is created to manage the text field
self.textFieldControllerDefaultCharMax = [[MDCTextInputControllerUnderline alloc] initWithTextInput: textFieldDefaultCharMax];
self.textFieldControllerDefaultCharMax.characterCountMax = 50;
self.textFieldControllerDefaultCharMax.floatingEnabled = NO;
```
<!--</div>-->


## Extensions

<!-- Extracted from docs/theming.md -->

### Theming Extensions

You can theme an MDCTextField using the TextFields theming extension. To add the theming extension to your project add the following line to your Podfile:

```bash
pod 'MaterialComponents/TextFields+Theming'
```

Then import the theming extension and the `MDCContainerScheme` and create an `MDCContainerScheme` instance. A container scheme
defines schemes for subsystems like Color and Typography. Finally, call theming methods on the theming extension of your MDCTextInputController instance.

<!--<div class="material-code-render" markdown="1">-->
#### Swift
```swift
// Step 1: Import the TextFields theming extension and container scheme
import MaterialComponents.MaterialTextFields_Theming
import MaterialComponents.MaterialContainerScheme

// Step 2: Create or get a container scheme
let containerScheme = MDCContainerScheme()

// Step 3: Apply the container scheme to your component using the desired alwert style
textInputController.applyTheme(withScheme: containerScheme)
```

#### Objective-C

```objc
// Step 1: Import the TextField theming extension and container scheme
#import "MaterialTextFields+Theming.h"
#import "MaterialContainerScheme.h"

// Step 2: Create or get a container scheme
MDCContainerScheme *containerScheme = [[MDCContainerScheme alloc] init];

// Step 3: Apply the container scheme to your component using the desired alert style
[textInputController applyThemeWithScheme:containerScheme];
```
<!--</div>-->


## Accessibility

<!-- Extracted from docs/accessibility.md -->

### MDCTextField Accessibility

Like UITextFields, MDCTextFields are accessible by default. To best take advantage of their accessibility features
please review the following recommendations.

#### `-accessibilityValue` Behavior

Similar to UITextFields, MDCTextFields are not accessibility elements themselves. Rather, they are accessibility
containers whose subviews act as accessibility elements. Such subviews include the MDCTextField's placeholder
label, the leading and trailing underline labels, and the clear button. The `accessibilityLabels` of these subviews
contribute to the `accessibilityValue` of the MDCTextField as a whole, giving it a value consistent with that of a
UITextField in a similar state. If the MDCTextField is empty, it will return a combination of any placeholderLabel text and
leading underline text. If the MDCTextField is not empty, it will return a combination of the MDCTextField's current text
and any leading underline text.

#### Using `-accessibilityLabel`

MDCTextField does not provide a custom implementation for `accessibilityLabel`. The client is free to set an
appropriate `accessibilityLabel` following norms established by Apple if they wish. However, they should consider
whether or not it it will provide information that is superfluous. A common scenario in which an
`accessibilityLabel` might not be necessary would be an MDCTextField whose leading underline label (a view not
present in UITextFields) conveys the information that an accessibility label might have otherwise conveyed. For
example, if an MDCTextField is intended to hold a user's zip code, and the leading underline label's
`accessibilityLabel` is already "Zip code", setting an `accessibilityLabel` of "Zip code" on the MDCTextField
may lead to duplicate VoiceOver statements.

#### Using `-accessibilityHint`

In general, Apple advises designing your user interface in such a way that clarification in the form of  an
`-accessibilityHint` is not needed. However, it is always an option.

